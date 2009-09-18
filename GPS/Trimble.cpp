
#include "stdafx.h"
#define STRICT

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "SharedMemory.h"
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

//
// forward declarations
//
void gpsParser(char *in);
void ggaParser(char *in, char *time, char *latitude, char *ns, 
			   char *logitude, char *ew, char *elevation);
void printError (LPCSTR str);
void printUsage ();
void rmcParser(char *in, char *speed);
void terminal (HANDLE h);
void waitForKeyPressed();
void sendResetString ();
void disableWatchdog ();

int InitSerial();

int substring (char *in, char *out, int startPosition, int endPosition);
int initSharedMemory();
int writeToSharedMemory(int position, float in);
int commandMovement (int motorSpeedLeft, int motorSpeedRight);

//
// global variables
//
char exename[1024];
char logname[1024];

// 0=hex 1=ascii 2=decimal
int displayMode;

// 0=space 1=newline 2=tab 3=empty
int separator;

// 0=off 1=on
int echo=1;

// 0=off 1=raw 2=parsed
int logData=2;

// 0=off 1=on
int matlab=0;

// header for parsed file
bool header = false;
bool header2 = false;

// global pointer to the shared memory block
SharedBlock *gpSharedBlock;

// mutex that protects the shared data
HANDLE ghDataLock;

HANDLE hFile;

PFLOAT hView, aux;     

///////////////////////////////////////////////////////////////////////////////
//
// motor command packet structure
//
///////////////////////////////////////////////////////////////////////////////

struct motorCommand {

	unsigned char motorCommandStart;
	unsigned char motorCommandDirection;
	char motorCommandSpeed1;
	char motorCommandSpeed2;
	char carriageReturn;

} *mCommand;

///////////////////////////////////////////////////////////////////////////////
//
// waypoints
//
///////////////////////////////////////////////////////////////////////////////

double pi = 3.14159265;
bool useRMC = true;
bool collectedTenGPS = false;
int gpsCount =0;
double stackLat[10];
double stackLong[10];

double wp1Lat  = 4226.075270; 
double wp1Long = 8353.597330;
bool wp1Found = false;

double wp2Lat  = 4226.072103; 
double wp2Long = 8353.595100;
bool wp2Found = false;

double wp3Lat  = 4226.062357; 
double wp3Long = 8353.625475;
bool wp3Found = false;

double wp4Lat  = 4226.056240; 
double wp4Long = 8353.630199;
bool wp4Found = false;

double wp5Lat  = 4226.050346; 
double wp5Long = 8353.636570;
bool wp5Found = false;

double wp6Lat  = 4226.056793; 
double wp6Long = 8353.650770;
bool wp6Found = false;

HANDLE hSerialMC;
DWORD dwBytesWritten, dwBytesRead;

// log file
FILE *fp;

/////////////////////////////////////////////////////////////////////
//
// conInThread
//
/////////////////////////////////////////////////////////////////////

DWORD CALLBACK conInThread (HANDLE h)
{
	OVERLAPPED ov;
	HANDLE hconn = GetStdHandle(STD_INPUT_HANDLE);
	BOOL quit = FALSE;

	ZeroMemory(&ov,sizeof(ov));
	ov.hEvent = CreateEvent(NULL,FALSE,FALSE,NULL);
   
	if (ov.hEvent == INVALID_HANDLE_VALUE) {
		printError("E001_CreateEvent failed");
		SetCommMask(h,0);
		return 0;
	}

	char kb;
	INPUT_RECORD b1;

	SetConsoleMode(hconn,0);
	
	printf("\npress Esc or Ctrl+C to terminate\n");
    
	do {
      
		char buf[10];
		DWORD read = 0;

		SetConsoleMode(hconn,0);
   
		// wait for user to type something
		WaitForSingleObject(hconn,INFINITE);

		// read the console buffer
		if (!ReadConsoleInput(hconn,&b1,1,&read)) {
         
			printError("E002_ReadConsoleInput failed...");
			quit  = TRUE;
		}
	  
	  
		kb=b1.Event.KeyEvent.uChar.AsciiChar;
	    buf[0] = kb;
	        
		if(read) {
         
			DWORD write=1;
			 
			// terminate when esc or ctl-c is pressed
			if( buf[0] == 0x1b || buf[0] == 0x3 ) {
				quit = TRUE;
				break;
         
			} else {

				if (buf[0] != 0x0  && b1.Event.KeyEvent.bKeyDown) {

					// send it to the com port
					if( !WriteFile(h,buf,write,&write,&ov) ) {
						
						if(GetLastError() == ERROR_IO_PENDING) {
						
							if( !GetOverlappedResult(h,&ov,&write,TRUE) ) {
								printError("E003_GetOverlappedResult failed");
								quit = TRUE;
							}
						}
						
						// make the local output - echo is global var ...
						if (echo == 1) printf("%c", (unsigned char)buf[0]);
					
					} else {
						printError("E004_WriteFile failed");
						quit = TRUE;
					}
				} 
			}
		}

	} while(!quit);

		// tell terminal thread to quit
		if (!SetCommMask(h,0)) {
			printf("SetCommMask-GetLastError: %i\n", GetLastError());
		}
		
		return 0;

} // end conInThread


/////////////////////////////////////////////////////////////////////
//
// ggaParser
//
// Parses a GGA sentence 
//
// $GPGGA,120446.00,4226.056918,N,08353.643486,W,2,05,1.3,273.51,M,-34.08,M,1.2,0117*72
//
//	1 time of fix (hhmmss),
//	2 latitude,
//	3 N/S,
//	4 longitude,
//	5 E/W,
//	6 Fix quality (0=invalid, 1=GPS fix, 2=DGPS fix),
//	7 number of satellites being tracked,
//	8 horizontal dilution of position,
//	9 altitude above sea level,
//	10 M (meters),
//	11 height of geoid (mean sea level) above WGS84 ellipsoid,
//	12 time in seconds since last DGPS update,
//	13 DGPS station ID number,
//	14 checksum
//
/////////////////////////////////////////////////////////////////////

void ggaParser(char *in, char *time, char *latitude, char *ns, char *longitude,
			   char *ew, char *elevation) 
{
	int i=0, commasIndex=0;

	int commas [15]; 

	int length = strlen(in);
	
	for (i=0; i<length; i++) {
	
		if (in[i] == ',') {	
			commas[commasIndex] = i;
			commasIndex++;
		}

	}
	
	substring(in, time, commas[0], commas[1]);
	substring(in, latitude, commas[1], commas[2]);
	substring(in, ns, commas[2], commas[3]);
	substring(in, longitude, commas[3], commas[4]);
	substring(in, ew, commas[4], commas[5]);
	substring(in, elevation, commas[8], commas[9]);

	///////////////////////////////////////////////////////////////////////////
	//
	// very crude waypoint navigation code...
	//
	///////////////////////////////////////////////////////////////////////////
	
	/**

	// add a check to make sure the path is clear!!!

	// add deadband

	// go slightly forward ten times and collect a gps coordinate each time
	if (!collectedTenGPS) {
		printf("Collecting ten GPS samples [%d/%d]...", gpsCount, 10);
		commandMovement(20, 20);
		gpsCount++;
		stackLat[gpsCount] = strtod(latitude, NULL);
		stackLong[gpsCount] = strtod(longitude, NULL);
		if (gpsCount >= 10) {
			collectedTenGPS = true;
			gpsCount = 0;
		}
		Sleep(1000);
	
	} else {

		// compare the most recent gps with the least recent to get our bearing and 
		// compare that the location of our first waypoint
		double tmpLatDiff  = stackLat[9] - wp1Lat;
		double tmpLongDiff = stackLong[9] - wp1Long;

		printf("Current [%lf, %lf], waypoint [%lf, %lf] :: Diff [%lf, %lf]\n", stackLat[9], stackLong[9], wp1Lat, wp1Long, tmpLatDiff, tmpLongDiff);

		// latitude: if difference is positive, keep going forward
		//           if difference is negative, turn around
		if (tmpLatDiff < 0) {
			commandMovement(30, 30);
			printf("ACTION: FORWARD\n");
		} else {
			commandMovement(30, 0);
			collectedTenGPS = false;
			printf("ACTION: TURNING AROUND\n");
		}

		// longitude: if difference is positive, turn right
		//            if difference is negative, turn left
		if (tmpLongDiff > 0) {
			commandMovement(30, 0);
			collectedTenGPS = false;
			printf("ACTION: RIGHT\n");
		} else {
			commandMovement(0, 30);
			collectedTenGPS = false;
			printf("ACTION: LEFT\n");
		}

	}
**/


} // end ggaParser


/////////////////////////////////////////////////////////////////////
//
// gpsParser
//
// Parses a GPS sentence to identify the sentence type
//
/////////////////////////////////////////////////////////////////////

void gpsParser (char *in) 
{
	FILE *stream;

	char sentenceType [7];

	char time[20];
	char longitude [20];
	char ns	[20];		
	char latitude [20];
	char ew [20];
	char elevation [10];
	char speed[20];
	
	strncpy(sentenceType, in, 6);
	sentenceType[6] = '\0';

	if (strcmp(sentenceType, "$GPGGA") == 0) {

		ggaParser(in, time, latitude, ns, longitude, ew, elevation);

		if (echo == 1) {

			printf(" time = %s", time);
			printf(" latitude = %s", latitude);
			printf(" ns = %s", ns);
			printf(" longitude = %s", longitude);
			printf(" ew = %s", ew);
			printf(" elevation = %s\n", elevation);

		}

		if (logData == 2) {

			stream = fopen(logname, "a");

			if (!header) {
				fprintf(stream, "time, latitude, n/s, longitude, e/w, elevation, speed\n");
				header = true;
			}

			fprintf(stream, "%f", (float)strtod(time, NULL));
			fprintf(stream, ",%f", (float)strtod(latitude, NULL));
			
			if (ns == "100") {
			
				fprintf(stream, ",%s", "N");
			
			} else if (ns == "200") { 

				fprintf(stream, ",%s", "S");

			} else {

				fprintf(stream, ",%s", "");

			}

			fprintf(stream, ",%f", (float)strtod(longitude, NULL));

			if (ew == "400") {
			
				fprintf(stream, ",%s", "E");
			
			} else if (ew == "500") { 

				fprintf(stream, ",%s", "W");

			} else {

				fprintf(stream, ",%s", "");

			}

			fprintf(stream, ",%f", (float)strtod(longitude, NULL));

			fclose(stream);
		}

		if (matlab == 1) {

			writeToSharedMemory(0, (float)strtod(time, NULL));
			writeToSharedMemory(1, (float)strtod(latitude, NULL));

			if (ns[0] == 'N') {
				writeToSharedMemory(2, 100);
			} else if (ns[0] == 'S') {
				writeToSharedMemory(2, 200);
			} else { 
				writeToSharedMemory(2, 300);
			}

			writeToSharedMemory(3, (float)strtod(longitude, NULL));

			if (ew[0] == 'E') {
				writeToSharedMemory(4, 400);
			} else if (ew[0] == 'W') {
				writeToSharedMemory(4, 500);
			} else {
				writeToSharedMemory(4, 600);
			}

			writeToSharedMemory(5, (float)strtod(elevation, NULL));
		}

	}

	if (strcmp(sentenceType, "$GPRMC") == 0) {

		rmcParser(in, speed);

		if (echo == 1) {
			printf(" speed = %s\n", speed);
		}

		if (matlab == 1) {
			writeToSharedMemory(6, (float)strtod(speed, NULL));
		}

		if (logData == 2) {

			stream = fopen(logname, "a");

			fprintf(stream, ",%f\n", (float)strtod(longitude, NULL));

			fclose(stream);
		}

	}

} // end gpsParser


/////////////////////////////////////////////////////////////////////
//
// initSharedMemory
//
/////////////////////////////////////////////////////////////////////

int initSharedMemory()
{
	// create a mutex with inital ownership.  if is already exists, 
	//	it will be blocked until it is available
	ghDataLock = ::CreateMutex(NULL, TRUE, "Turing Data Mutex");

	hFile = CreateFileMapping(INVALID_HANDLE_VALUE, 
								NULL,
								PAGE_READWRITE, 
								0, 
								1024 * 7, 
								"TURING-GPS");
	
	if (hFile == NULL) {
		 printf("Could not create a file\n");
		 exit(1);
	}

	hView = (PFLOAT) MapViewOfFile(hFile, 
						FILE_MAP_ALL_ACCESS,  
						0,
						0,
						0);

	if (hView == NULL) {
		 printf("Unable to create a view\n");
		 exit(1);
	}

	aux = hView;		
	
	printf("Shared data has been initialized\n");

	::ReleaseMutex(ghDataLock);

	return 0;


} // end initSharedMemory


/////////////////////////////////////////////////////////////////////
//
// printError
//
/////////////////////////////////////////////////////////////////////

void printError (LPCSTR str)
{
	LPVOID lpMessageBuffer;
   
	int error = GetLastError();
   
	FormatMessage(
		FORMAT_MESSAGE_ALLOCATE_BUFFER |
		FORMAT_MESSAGE_FROM_SYSTEM,
		NULL,
		error,
		MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), //The user default language
		(LPTSTR) &lpMessageBuffer,
		0,
		NULL
	);

	printf("%s: (%d) %s\n\n",str,error,lpMessageBuffer);
    LocalFree( lpMessageBuffer );

} // end printError


/////////////////////////////////////////////////////////////////////
//
// printUsage
//
/////////////////////////////////////////////////////////////////////

void printUsage ()
{
	printf("\n\n*** Error ***");
	printf("\n\n\tMatlab Interface usage: Trimble <matlab> <echo y/n>");
	printf("\n\tLog File usage:	Trimble <log> <file_name> <r=raw p=parsed> <echo y/n>\n\n\n");

} // end printUsage


/////////////////////////////////////////////////////////////////////
//
// rmcParser
//
// Parses an RMP sentence 
//
// $GPRMC,120446,A,4226.056918,N,08353.643486,W,000.09,133.4,180206,5.5,W,D*2D
//
//	1 time
//	2 status, V = Navigation receiver warning
//	3 latitude
//  4 N/S
//  5 longitude
//  6 E/W
//	7 speed over ground, knots
//  8 track made good, degrees true
//	9 date, ddmmyy
//  10 magnetic variation, degrees
//	11 E/W
//  12 checksum
//
//
/////////////////////////////////////////////////////////////////////

void rmcParser(char *in, char *speed) 
{
	int i=0, commasIndex=0;

	int commas [13]; 

	int length = strlen(in);
	
	for (i=0; i<length; i++) {
	
		if (in[i] == ',') {	
			commas[commasIndex] = i;
			commasIndex++;
		}

	}
	
	substring(in, speed, commas[6], commas[7]);

	//////////////////////////////////////////////////////////////////////////////
	//
	// our waypoint code
	//
	///////////////////////////////////////////////////////////////////////////

	char time[20];
	char status[20];
	char longitude [20];
	char ns	[20];		
	char latitude [20];
	char ew [20];
	char trueHeading [10];

	substring(in, time, commas[0], commas[1]);
	substring(in, status, commas[1], commas[2]);
	substring(in, latitude, commas[2], commas[3]);
	substring(in, ns, commas[3], commas[4]);
	substring(in, longitude, commas[4], commas[5]);
	substring(in, ew, commas[5], commas[6]);
	substring(in, trueHeading, commas[7], commas[8]);

	// test to see if we have a valid sentence
	if (strcmp(status, "A") == 0) {

		double waypointHeading = 0;

		// convert the strings to doubles
		double currentLat = strtod(latitude, NULL);
		double currentLon = strtod(longitude, NULL);
		double trueHeadingValue = strtod(trueHeading, NULL);

		// say we have NMEA data of 4266.075270
		//  we just want the integer part with no rounding -- 42
		int tmpLatCur = (int)currentLat/100;
		int tmpLonCur = (int)currentLon/100;

		// next, we want the 66.075270 part
		double tmpLatCur2 = (tmpLatCur * 100) - currentLat;
		double tmpLonCur2 = (tmpLonCur * 100) - currentLon;

		// finally, we do 42 + (26.075270/60) to come up with the decimal
		double decLatCur = tmpLatCur + (tmpLatCur2 / 60);
		double decLonCur = tmpLonCur + (tmpLonCur2 / 60);	

		// convert the decimal to radians
		double currentLatRad = decLatCur * pi / 180.0;;
		double currentLonRad = decLonCur * pi / 180.0;;

		// now, do the same thing for the waypoint
		int tmpLatWay = (int)wp1Lat/100;
		int tmpLonWay = (int)wp1Long/100;

		double tmpLatWay2 = (tmpLatWay * 100) - wp1Lat;
		double tmpLonWay2 = (tmpLonWay * 100) - wp1Long;

		// finally, we do 42 + (26.075270/60) to come up with the decimal
		double decLatWay = tmpLatWay + (tmpLatWay2 / 60);
		double decLonWay = tmpLonWay + (tmpLonWay2 / 60);	

		// convert the decimal to radians
		double waypointLatRad = decLatWay * pi / 180.0;;
		double waypointLonRad = decLonWay * pi / 180.0;;

		// calculate heading to waypoint
		// pythagorean theorem - works for short distances
		double diffLat = waypointLatRad - currentLatRad;
		double diffLon = waypointLonRad - currentLonRad;

		printf("currentLatRad=%lf, currentLonRad=%lf, waypointLatRad=%lf, waypointLongRad=%lf\n", currentLatRad, currentLonRad, waypointLatRad, waypointLonRad);

		// if within 2 feet of waypoint stop for now but we need to switch to next waypoint ---  0.0000015deg*(180/Pi)*(60min/deg)*(6080ft/min)
		if((diffLat < 0.0000015 && diffLat >-0.0000015) && (diffLon<0.0000015 && diffLon>-0.0000015)) {
			commandMovement(0,0);
			printf("REACHED WAYPOINT\N");
		}

		waypointHeading = atan2(diffLon, diffLat);

		// make clockwise direction positive (CCW is +ve as is)
		if (sin(waypointLonRad - currentLonRad) > 0.0) {
			waypointHeading = 360.0 - waypointHeading * 180.0 / pi;
		} else {
			waypointHeading = -waypointHeading * 180.0 / pi;
		}

		double error = waypointHeading - trueHeadingValue;
		double kp = 1.0;

		// keep error between -180 and 180
		if (error >= 180.0)  error = error - 360.0;
		if (error <= -180.0) error = 360.0 + error;

		int forward = 20;

		int movement = forward - kp * error;

//		rud_pwm = 142 - Kp*error; // typical neutral position (127) is a little off on Magpie (142)

		// no ailerons on Magpie; have to limit rudder deflection
//		if(rud_pwm<122) rud_pwm=122;   // turn right (neutral-20)
//		if(rud_pwm>162) rud_pwm=162; // turn left (neutral+20)

		// write stuff to our log file
		if (!header2) {
			fprintf(fp, "currentLatNMEA, currentLongNMEA, currentLatDec, currentLongDec, wp1LatNMEA, wp1LongNMEA, wp1LatDec, wp1LongDec, diffLat, diffLong, waypointHeading\n");
			header2 = true;
		}
		

	} // end if test for valid string

} // end rmcParser


/////////////////////////////////////////////////////////////////////
//
// substring
//
// Takes in a string, start, end positions and returns the 
//	null-terminated substring
//
/////////////////////////////////////////////////////////////////////

int substring (char *in, char *out, int startPosition, int endPosition)
{
	int i=0, index=0;

	for (i=startPosition+1; i<endPosition; i++) {

		out[index] = in[i];
		index++;

	}

	out[endPosition-startPosition-1] = '\0';

	return 0;

} // end substring


/////////////////////////////////////////////////////////////////////
//
// terminal
//
/////////////////////////////////////////////////////////////////////

void terminal (HANDLE h)
{

	HANDLE hconn = GetStdHandle(STD_OUTPUT_HANDLE);
	DWORD mask;
	DWORD id, i;
	OVERLAPPED ov;

	FILE *stream;

	char gpsBuffer[256];

	int gpsAccumulator = 0;
   
	if (logData == 1) {
		stream = fopen(logname, "w");
	}
   
	HANDLE hconin = CreateThread(NULL,0,conInThread,h,0,&id);
   
	if( hconin == INVALID_HANDLE_VALUE ) {
      printError("E005_CreateThread failed");
      return;
	}

	CloseHandle(hconin);  // don't need this handle

	ZeroMemory(&ov,sizeof(ov));

	// create event for overlapped I/O
	ov.hEvent = CreateEvent(NULL,FALSE,FALSE,NULL);
   
	if (ov.hEvent == INVALID_HANDLE_VALUE) {
		printError("E006_CreateEvent failed");
	}

	// wait for received characters
	if (!SetCommMask(h,EV_RXCHAR)) {
		printError("E007_SetCommMask failed");
	}

	while (1) {

     // get the event mask
	if( !WaitCommEvent(h,&mask,&ov) ) {
      
		DWORD e = GetLastError();

		if ( e == ERROR_IO_PENDING ) {
            
			DWORD r;

            if (!GetOverlappedResult(h,&ov,&r,TRUE)) {
               printError("E008_GetOverlappedResult failed");
               break;
            }

         } else {

            printError("E009_WaitCommEvent failed");
            break;
         }
	}

    // if no event, then UI thread terminated with SetCommMask(h,0)
    if (mask == 0) {
		break;
    }

    if (mask & EV_RXCHAR) {

        char buf[10];
        DWORD read;
        
		do {
			
			read = 0;
            
			if( !ReadFile(h,buf,sizeof(buf),&read,&ov) ) {

				if( GetLastError() == ERROR_IO_PENDING ) {

					if( !GetOverlappedResult(h,&ov,&read,TRUE) ) {
						printError("E010_GetOverlappedResult failed");
						break;
					}
               
				} else {
                  
					printError("E011_ReadFile failed");
					break;
               }
            }

            if (read)
		 	  
				// WriteFile(hconn,buf,read,&read,NULL);
				for (i=0; i<read; i++) {

					if (echo == 1) {

						// print to the screen
						if (displayMode==0) printf("0x%x", (unsigned char)buf[i]);
						if (displayMode==1) printf("%c", (unsigned char)buf[i]);
						if (displayMode==2) printf("%i", (unsigned char)buf[i]);
						if (separator==0) printf(" ");
						if (separator==1) printf("\n");
						if (separator==2) printf("\t");

					}

					if (logData == 1) {

		  				// print to the logfile
						if (displayMode==0) fprintf(stream,"0x%x", (unsigned char)buf[i]);
						if (displayMode==1) fprintf(stream,"%c", (unsigned char)buf[i]);
						if (displayMode==2) fprintf(stream,"%i", (unsigned char)buf[i]);
						if (separator==0) fprintf(stream," ");
						if (separator==1) fprintf(stream,"\n");
						if (separator==2) fprintf(stream,"\t");
					}

					gpsBuffer[gpsAccumulator] = buf[i];		
					gpsAccumulator++;

					if (buf[i] == 0x0A) {

						gpsParser(gpsBuffer);

						gpsAccumulator = 0;
		
						for (int j=0; j<256; j++) {
							gpsBuffer[j] = ' ';
						}
					}

				}
		 
			} while (read);

		} // enddo

		mask = 0;
   
	} // endif
   
	CloseHandle(ov.hEvent);  // close the event
	
	if (logData ==1) {
		fclose(stream);
	}
   
} // end terminal


/////////////////////////////////////////////////////////////////////
//
// waitForKeyPressed
//
/////////////////////////////////////////////////////////////////////

void waitForKeyPressed()
{
	  
	HANDLE hStdin; 
	DWORD cNumRead, fdwMode, fdwSaveOldMode, i, quit; 
    INPUT_RECORD irInBuf[128]; 
 
    // Get the standard input handle. 
    hStdin = GetStdHandle(STD_INPUT_HANDLE); 
 
	if (hStdin == INVALID_HANDLE_VALUE) {
		printf("Problem:GetStdHandle"); 
	}
 
    // Save the current input mode, to be restored on exit. 
    if (! GetConsoleMode(hStdin, &fdwSaveOldMode) ) {
		printf("Problem:GetConsoleMode"); 
	}
 
    //Enable the window and mouse input events. 
    fdwMode = ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT; 
 
	if (! SetConsoleMode(hStdin, fdwMode) ) {
		printf("Problem:SetConsoleMode"); 
	}
 
    // Loop to read and handle the input events. 
	quit = 1;

    while (quit) { 
        
		// Wait for the events. 
        if (! ReadConsoleInput( 
                hStdin,					// input buffer handle 
                irInBuf,				// buffer to read into 
                128,					// size of read buffer 
                &cNumRead) ) {			// number of records read 
            
			printf("Problem:ReadConsoleInput\n"); 

		}
 
        // check if key pressed ...
        for (i = 0; i < cNumRead; i++) {

			if (irInBuf[i].EventType == KEY_EVENT) {
				quit=0;
			}
        }
	  
	} 

	// rest the console mode
	SetConsoleMode(hStdin, fdwSaveOldMode);

} // end waitForKeyPressed


/////////////////////////////////////////////////////////////////////
//
// writeToSharedMemory
//
/////////////////////////////////////////////////////////////////////

int writeToSharedMemory(int position, float in)
{
	printf("writeToSharedMemory %d %f\n", position, in);

	// make sure that shared memory is available
	::WaitForSingleObject(ghDataLock, INFINITE);

	aux[position] = in;

	// release the lock
	::ReleaseMutex(ghDataLock);

	return 0;

} // end writeToSharedMemory


/////////////////////////////////////////////////////////////////////
//
// main
//
/////////////////////////////////////////////////////////////////////

int main( int argc, char **argv )
{
	echo = 0;

	// copy the name of the executable into a global variable
	strcpy(exename,argv[0]);

	int readFromGPS1FromFile2 = 2;

/**
	if (argc < 2) {

		printf("invalid usage\n");
		printUsage();
		return 0;
	}

	if ( (strcmp("matlab", argv[1]) == 0) || (strcmp("log", argv[1]) == 0) ) {

		// if matlab is chosen, there should be three arguments
		if (strcmp("matlab", argv[1]) == 0) {

			if (argc != 3) {

				printf("\n\nmatlab: Invalid number of arguments\n");
				printUsage();
				return 0;
			}

			if ( (strcmp("y", argv[2]) == 0) || (strcmp("Y", argv[2]) == 0) ) {

				echo = 1;

			} else if ( (strcmp("n", argv[2]) == 0) || (strcmp("N", argv[2]) == 0) ) {

				echo = 0;

			} else {

				printf("\n\nmatlab: echo must be y/n\n");
				printUsage();
				return 0;
			}

			// init shared memory
			matlab = 1;
			initSharedMemory();

		}

		// if log to file is chosen, there should be four arguments
		if (strcmp("log", argv[1]) == 0) {

			if (argc != 5) {

				printf("\n\nlog: invalid number of arguments\n");
				printUsage();
				return 0;
			}

			if ((strcmp("r", argv[3]) == 0) || (strcmp("R", argv[3]) == 0)) { 
				
				log = 1;

			} else if ((strcmp("p", argv[3]) == 0) || (strcmp("P", argv[3]) == 0)) { 
			
				log = 2;

			} else {

				printUsage();
				return 0;
			}

			if ( (strcmp("y", argv[4]) == 0) || (strcmp("Y", argv[4]) == 0) ) {

				echo = 1;

			} else if ( (strcmp("n", argv[4]) == 0) || (strcmp("N", argv[4]) == 0) ) {

				echo = 0;

			} else {

				printf("\n\nlog: echo must be y/n\n");
				printUsage();
				return 0;
			}

			strcpy(logname, argv[2]);

			if (log == 2) {

				remove(logname);
			}

		}

	} else {

		printf("\n\nyou must select either matlab or log\n");
		printUsage();

	}
**/
	logData = 2;
	strcpy(logname, "c:\\gps.txt");
	echo = 0;

	cout << "Read from GPS = 1, Read from file = 2....\n\n==> ";
	cin >> readFromGPS1FromFile2;

	if (readFromGPS1FromFile2 == 1) {

		// done with error checking, now we set up the serial com stuff...

		// open port for overlapped I/O
		HANDLE h = CreateFile("COM1",
					GENERIC_READ|GENERIC_WRITE,
				    0,NULL,
					OPEN_EXISTING,FILE_FLAG_OVERLAPPED,NULL);

		if (h == INVALID_HANDLE_VALUE) {

			printError("E012_Failed to open port");
			return 0;
    
		} else {
         
			// set timeouts
			COMMTIMEOUTS cto = { 2, 1, 1, 0, 0 };
			DCB dcb;
         
			if(!SetCommTimeouts(h,&cto)) {
				printError("E013_SetCommTimeouts failed");
			}

			// set DCB
			memset(&dcb,0,sizeof(dcb));
			dcb.DCBlength	= sizeof(dcb);
			dcb.BaudRate	= 38400;
			dcb.fBinary		= 1;
			dcb.fDtrControl = DTR_CONTROL_ENABLE;
			dcb.fRtsControl = RTS_CONTROL_ENABLE;
			dcb.Parity		= NOPARITY;
			dcb.StopBits	= ONESTOPBIT;
			dcb.ByteSize	= 8;
         
			// ascii
			displayMode = 1;

			// empty seperator
			separator = 3;
		 
			if(!SetCommState(h,&dcb)) {
				printError("E014_SetCommState failed");
			}


			// initialize the motor controller
//			InitSerial();

			// initialize our log file
//			fp=fopen("c:\\waypoint_log.txt", "a");

			// pause for five seconds to let the gps get its current location
//			Sleep(5000);

			printf("All done...\n");

			// start terminal
			terminal(h);
			CloseHandle(h);

		}

	// read from file
	} else {
	
		string fileName;
		cout << "Filename?\n\n==> ";
		cin >> fileName;
		
		ifstream gpsFile;
		string line;

		gpsFile.open(fileName.c_str());

		if (gpsFile.is_open()) {
    
			while (!gpsFile.eof()) {
				getline (gpsFile,line);
				cout << line << endl;
			}
		
			gpsFile.close();

		}

	}
 

	return 0;

} // end main



///////////////////////////////////////////////////////////////////////////////
//
// InitSerial
//
///////////////////////////////////////////////////////////////////////////////

int InitSerial () 
{	
	///////////////////////////////////////////////////////////////////////////
	//
	// motor controller
	//
	///////////////////////////////////////////////////////////////////////////
/**
	string comPort = "COM5";
	hSerialMC = CreateFile(comPort.c_str(), 
		GENERIC_READ | GENERIC_WRITE, 
		0, 
		0, 
		OPEN_EXISTING, 
		FILE_ATTRIBUTE_NORMAL, 
		0);

	if (hSerialMC == INVALID_HANDLE_VALUE) {
		printf("ERROR opening serial port\n");
	}

	// set parameters
	DCB dcbSerialParams = {0};

	dcbSerialParams.DCBlength = sizeof(dcbSerialParams);

	if (!GetCommState(hSerialMC, &dcbSerialParams)) {
		// error getting state
	}

	dcbSerialParams.BaudRate = 9600;
	dcbSerialParams.ByteSize = 7;
	dcbSerialParams.StopBits = ONESTOPBIT;
	dcbSerialParams.Parity = EVENPARITY;

	if (!SetCommState(hSerialMC, &dcbSerialParams)) {
		// error setting state
	}

	// set timeouts
	COMMTIMEOUTS timeouts = {0};
	timeouts.ReadIntervalTimeout = 50;
	timeouts.ReadTotalTimeoutConstant = 50;
	timeouts.ReadTotalTimeoutMultiplier = 10;
	timeouts.WriteTotalTimeoutConstant = 50;
	timeouts.WriteTotalTimeoutMultiplier = 10;

	if (!SetCommTimeouts(hSerialMC, &timeouts)) {
		// error setting the timeouts
	}

	// send 10 carriage returns in sequence to enter rs-232 mode
	for (int i=0; i<10; i++) {
		if (!WriteFile(hSerialMC, "\r", 1, &dwBytesWritten, NULL)) {
			// error writing
		}
		Sleep(50);
	}

	// disable the watchdog timer
	disableWatchdog ();

	// send a reset string
	sendResetString ();
**/
	return 0;

}

///////////////////////////////////////////////////////////////////////////////
//
// commandMovement
//
//
//	the command is !Mnn where
//	  A: channel 1, forward
//	  a: channel 1, reverse
//    B: channel 2, forward
//    b: channel 2, reverse
//	 nn: speed value 0-127
//
//
///////////////////////////////////////////////////////////////////////////////

int commandMovement (int motorSpeedLeft, int motorSpeedRight)
{
	// define a motor control packet
	motorCommand cmdLeft;
	motorCommand cmdRight;

	// packet start
	cmdLeft.motorCommandStart = '!';
	cmdRight.motorCommandStart = '!';

	// left direction
	if (motorSpeedLeft < 0) {
		cmdLeft.motorCommandDirection = 'a';
	} else {
		cmdLeft.motorCommandDirection = 'A';
	}

	// right direction
	if (motorSpeedRight < 0) {
		cmdRight.motorCommandDirection = 'b';
	} else {
		cmdRight.motorCommandDirection = 'B';
	}

	char bufferLeft[5];
	char bufferRight[5];

	// convert the decimal to hex

	// hack to pad the string with an extra zero if command is zero
	if (motorSpeedLeft != 0) {
		sprintf(bufferLeft, "0x%x", abs(motorSpeedLeft));
	} else {
		sprintf(bufferLeft, "0x%x0", abs(motorSpeedLeft));
	}
	
	if (motorSpeedRight != 0) {
		sprintf(bufferRight, "0x%x", abs(motorSpeedRight));
	} else {
		sprintf(bufferRight, "0x%x0", abs(motorSpeedRight));
	}

	cmdLeft.motorCommandSpeed1  = bufferLeft[2];
	cmdLeft.motorCommandSpeed2  = bufferLeft[3];
	cmdRight.motorCommandSpeed1 = bufferRight[2];
	cmdRight.motorCommandSpeed2 = bufferRight[3];

	// packet end :: carriage return
	cmdLeft.carriageReturn  = '\r';
	cmdRight.carriageReturn = '\r';

	// sth 8-may-09, added 0 to prevent lockups
//	serialMotorController.Write(&cmdLeft, sizeof(cmdLeft), 0, 0, 0);
//	serialMotorController.Write(&cmdRight, sizeof(cmdRight), 0, 0, 0);

//	if (!WriteFile(hSerialMC, &cmdLeft, sizeof(cmdLeft), &dwBytesWritten, NULL)) {
//		// error writing
//	}

//	if (!WriteFile(hSerialMC, &cmdRight, sizeof(cmdRight), &dwBytesWritten, NULL)) {
//		// error writing
//	}


	return 0;

} // end commandMovement

///////////////////////////////////////////////////////////////////////////////
//
// disableWatchdog
//
// Address: ^01
//
// pg 149 of manual
//
///////////////////////////////////////////////////////////////////////////////

void disableWatchdog ()
{
	string command = "^00 01\r";

	if (!WriteFile(hSerialMC, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

} // end disableWatchdog


///////////////////////////////////////////////////////////////////////////////
//
// sendResetString
//
// "%rrrrrr"
//
///////////////////////////////////////////////////////////////////////////////

void sendResetString ()
{
	string command = "%rrrrrr\r";

	if (!WriteFile(hSerialMC, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

} // end sendResetString
