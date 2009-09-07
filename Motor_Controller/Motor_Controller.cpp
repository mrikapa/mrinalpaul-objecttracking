
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File Name:		Motor_Controller.cpp
// Author:			Shawn Hunt
// Date Written:	3-Apr-2009
// Purpose:			This program does very basic motion control of the IGVC platform.
//
// To-Do:			- Add checks to make sure data passed into the motor command function are valid		
//					- Add code to read data from the motor controller
//					- Encoder feedback
//					- This needs to interact with the decision manager of whether the path is clear or not
//					- Add in #defines to support Linux, similar commands to Windows without using serial class
//
// Last Revision:	3-Apr-2009: Version 1.0 - Original, Work In Progress
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define STRICT
#include <tchar.h>
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <iostream>
#include <ctime>
#include <string>
#include <sstream>

#include "windows.h"

using namespace std;

typedef short int16;
typedef char  int8;

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
// function prototypes
//
///////////////////////////////////////////////////////////////////////////////

int commandMovement (int motorSpeedLeft, int motorSpeedRight);
int readAmpsAppliedToMotors ();
int readBatteryVoltages ();
int readDistance ();
int readEncoderCounter (int n);
int readPowerAppliedToMotors ();
int readSpeed();

string itos(int i);

void sendResetString ();
void disableWatchdog ();

///////////////////////////////////////////////////////////////////////////////
//
// global variables
//
///////////////////////////////////////////////////////////////////////////////

// are we connected now (used for debugging packets)
int connected = 1;

HANDLE hSerial;
DWORD dwBytesWritten=0, dwBytesRead=0;

///////////////////////////////////////////////////////////////////////////////
//
// main
//
///////////////////////////////////////////////////////////////////////////////

int main (int argc, char **argv)
{
	int lLastError = ERROR_SUCCESS;
	string comPort = "COM5";

	// set up the serial port
	if (connected) {

		hSerial = CreateFile(comPort.c_str(), 
			GENERIC_READ | GENERIC_WRITE, 
			0, 
			0, 
			OPEN_EXISTING, 
			FILE_ATTRIBUTE_NORMAL, 
			0);

		if (hSerial == INVALID_HANDLE_VALUE) {
			printf("ERROR opening serial port\n");
		}

		// set parameters
		DCB dcbSerialParams = {0};

		dcbSerialParams.DCBlength = sizeof(dcbSerialParams);

		if (!GetCommState(hSerial, &dcbSerialParams)) {
			// error getting state
		}

		dcbSerialParams.BaudRate = 9600;
		dcbSerialParams.ByteSize = 7;
		dcbSerialParams.StopBits = ONESTOPBIT;
		dcbSerialParams.Parity = EVENPARITY;

		if (!SetCommState(hSerial, &dcbSerialParams)) {
			// error setting state
		}

		// set timeouts
		COMMTIMEOUTS timeouts = {0};

		timeouts.ReadIntervalTimeout = 50;
		timeouts.ReadTotalTimeoutConstant = 50;
		timeouts.ReadTotalTimeoutMultiplier = 10;
		timeouts.WriteTotalTimeoutConstant = 50;
		timeouts.WriteTotalTimeoutMultiplier = 10;

		if (!SetCommTimeouts(hSerial, &timeouts)) {
			// error setting the timeouts
		}

		// send 10 carriage returns in sequence to enter rs-232 mode
		for (int i=0; i<10; i++) {
			if (!WriteFile(hSerial, "\r", 1, &dwBytesWritten, NULL)) {
				// error writing
			}
			Sleep(50);
		}

		// disable the watchdog timer
		disableWatchdog ();

		// send a reset string
		sendResetString ();

		printf("Serial port initialized...\n");
		Sleep(1000);
	}

	bool loop = true;
	int choice = 0;
	while (loop) {
		
		cout << "\n\n\n";
		cout << "1.  Read Encoder Counter\n";
		cout << "2.  Read Speed\n";
		cout << "3.  Read Distance\n";
		cout << "4.  Read Power Applied to Motors\n";
		cout << "5.  Read Amps Applied to Motors\n";
		cout << "6.  Read Battery Voltages\n";
		cout << "99. End\n";
		cout << "\n--> ";
		cin  >> choice;

		if (choice == 1) {
			readEncoderCounter(1);
		}

		if (choice == 2) {
			readSpeed();
		}

		if (choice == 3) {
			readDistance();
		}

		if (choice == 4) {
			readPowerAppliedToMotors();
		}

		if (choice == 5) {
			readAmpsAppliedToMotors();
		}

		if (choice == 6) {
			readBatteryVoltages();
		}

		if (choice == 99) {
			loop = false;
		}

	}

    // close the port 
	if (connected) {
		CloseHandle(hSerial);
	}

    return 0;

} // end main


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

	if (!WriteFile(hSerial, &cmdLeft, sizeof(cmdLeft), &dwBytesWritten, NULL)) {
		// error writing
	}

	if (!WriteFile(hSerial, &cmdRight, sizeof(cmdRight), &dwBytesWritten, NULL)) {
		// error writing
	}

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
//	serial.Write(command.c_str(), command.size(), 0, 0, 0);

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}


} // end disableWatchdog


///////////////////////////////////////////////////////////////////////////////
//
// itos
//
///////////////////////////////////////////////////////////////////////////////

string itos(int i)
{
	stringstream s;
	s << i;
	return s.str();

} // end itos


///////////////////////////////////////////////////////////////////////////////
//
// readAmpsAppliedToMotors
//
// Syntax:
//   
//  ?a or ?A
//
//	Reply: 
//
//		nn = power 1
//		mm = power 2
//
///////////////////////////////////////////////////////////////////////////////

int readAmpsAppliedToMotors ()
{
	string command = "?A\r";

	int n = 128;
	char szBuff[128+1] = {0};

	DWORD bytesRead=0;

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

	Sleep(250);

	if (!ReadFile(hSerial, szBuff, n, &dwBytesRead, NULL)) {
		// error reading
	}

	for (int i=0; i<dwBytesRead; i++) {
		printf("%c ", szBuff[i]);
	}

	szBuff[128-1] = 0x00;

	int amps1, amps2;
	int ret = sscanf(szBuff, "%*2c %2X %2X", &amps1, &amps2);
	
	if (ret == 2) {
		cout << "amps1 = " << amps1 << " amps2 = " << amps2 << "\n";
	}

	return 0;

} // end readPowerAppliedToMotors


///////////////////////////////////////////////////////////////////////////////
//
// readBatteryVoltages
//
// Syntax:
//   
//  ?e or ?E
//
//	Reply: 
//
//		nn = main battery voltage 
//		mm = internal 12V voltage
//
///////////////////////////////////////////////////////////////////////////////

int readBatteryVoltages ()
{
	string command = "?E\r";

	int n = 128;
	char szBuff[128+1] = {0};

	DWORD bytesRead=0;

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

	Sleep(250);

	if (!ReadFile(hSerial, szBuff, n, &dwBytesRead, NULL)) {
		// error reading
	}

	for (int i=0; i<dwBytesRead; i++) {
		printf("%c ", szBuff[i]);
	}

	szBuff[128-1] = 0x00;

	int voltage1, voltage2;
	int ret = sscanf(szBuff, "%*2c %2X %2X", &voltage1, &voltage2);
	
	if (ret == 2) {
		cout << "voltage1 = " << voltage1 << " voltage2 = " << voltage2 << "\n";
	}

	return 0;

} // end readPowerAppliedToMotors

///////////////////////////////////////////////////////////////////////////////
//
// readEncoderCounter
//
// Syntax:
//   
//  ?qm or ?Qm
//
//	where m = 
//
//		0: Encoder 1, Absolute
//		1: Encoder 2, Absolute
//		2: Sum of encoders 1 and 2, Absolute
//
//		4: Encoder 1, Relative
//		5: Encoder 2, Relative
//		6: Sum of encoders 1 and 2, Relative
//
//	Reply: 
//
//		nnnnnnnn = counter value using 1-8 hex digits
//
///////////////////////////////////////////////////////////////////////////////

int readEncoderCounter (int m)
{
	string command = "?Q" + itos(m) + "\r";

	int n = 128;
	char szBuff[128+1] = {0};

	DWORD bytesRead=0;

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

	Sleep(250);

	if (!ReadFile(hSerial, szBuff, n, &dwBytesRead, NULL)) {
		// error reading
	}

	for (int i=0; i<dwBytesRead; i++) {
		printf("%c ", szBuff[i]);
	}

	szBuff[128-1] = 0x00;

	int counter;
	int ret = sscanf(szBuff, "%*3c %2X", &counter);
	
	if (ret == 1) {
		cout << "counter = " << counter << "\n";
	}
	
	return 0;

} // end readEncoderCounter


///////////////////////////////////////////////////////////////////////////////
//
// readPowerAppliedToMotors
//
// Syntax:
//   
//  ?v or ?V
//
//	Reply: 
//
//		nn = power 1
//		mm = power 2
//
///////////////////////////////////////////////////////////////////////////////

int readPowerAppliedToMotors ()
{
	string command = "?V\r";

	int n = 128;
	char szBuff[128+1] = {0};

	DWORD bytesRead=0;

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

	Sleep(250);

	if (!ReadFile(hSerial, szBuff, n, &dwBytesRead, NULL)) {
		// error reading
	}

	for (int i=0; i<dwBytesRead; i++) {
		printf("%c ", szBuff[i]);
	}

	szBuff[128-1] = 0x00;

	int power1, power2;
	int ret = sscanf(szBuff, "%*2c %2X %2X", &power1, &power2);
	
	if (ret == 2) {
		cout << "power1 = " << power1 << " power2 = " << power2 << "\n";
	}

	return 0;

} // end readPowerAppliedToMotors


///////////////////////////////////////////////////////////////////////////////
//
// readSpeed
//
// Syntax:
//   
//  ?z or ?Z
//
//	Reply: 
//
//		nn = speed 1
//		mm = speed 2
//
///////////////////////////////////////////////////////////////////////////////

int readSpeed ()
{
	string command = "?Z\r";

	int n = 128;
	char szBuff[128+1] = {0};

	DWORD bytesRead=0;

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

	Sleep(250);

	if (!ReadFile(hSerial, szBuff, n, &dwBytesRead, NULL)) {
		// error reading
	}

	for (int i=0; i<dwBytesRead; i++) {
		printf("%c ", szBuff[i]);
	}

	szBuff[128-1] = 0x00;

	int speed1, speed2;
	int ret = sscanf(szBuff, "%*2c %2X %2X", &speed1, &speed2);
	
	if (ret == 2) {
		cout << "speed1 = " << speed1 << " speed2 = " << speed2 << "\n";
	}

	return 0;

} // end readEncoderCounter


///////////////////////////////////////////////////////////////////////////////
//
// readDistance
//
// Syntax:
//   
//  ?d or ?D
//
//	Reply: 
//
//		nn = distance 1
//		mm = distance 2
//
///////////////////////////////////////////////////////////////////////////////

int readDistance ()
{
	string command = "?D\r";

	int n = 128;
	char szBuff[128+1] = {0};

	DWORD bytesRead=0;

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

	Sleep(250);

	if (!ReadFile(hSerial, szBuff, n, &dwBytesRead, NULL)) {
		// error reading
	}

	for (int i=0; i<dwBytesRead; i++) {
		printf("%c ", szBuff[i]);
	}

	szBuff[128-1] = 0x00;

	int distance1, distance2;
	int ret = sscanf(szBuff, "%*2c %2X %2X", &distance1, &distance2);
	
	if (ret == 2) {
		cout << "distance1 = " << distance1 << " distance2 = " << distance2 << "\n";
	}

	return 0;

} // end readDistance

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

	if (!WriteFile(hSerial, command.c_str(), command.size(), &dwBytesWritten, NULL)) {
		// error writing
	}

} // end sendResetString
