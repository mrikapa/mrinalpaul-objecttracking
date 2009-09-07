
#include "IMU.h"

///////////////////////////////////////////////////////////////////////////////
//
// constructor
//
///////////////////////////////////////////////////////////////////////////////

IMU::IMU ()
{
	serialPortInitedOnce = false;
	running = false;
	header = false;
	globalEcho = 1;
	fileInited = false;

} // end constructor


///////////////////////////////////////////////////////////////////////////////
//
// destructor
//
///////////////////////////////////////////////////////////////////////////////

IMU::~IMU ()
{

} // end constructor


///////////////////////////////////////////////////////////////////////////////
//
// closeSerialPort
//
///////////////////////////////////////////////////////////////////////////////

int IMU::closeSerialPort ()
{
	CloseHandle(h);
	return 0;

} // end closeSerialPort


///////////////////////////////////////////////////////////////////////////////
//
// convertToInt
//
///////////////////////////////////////////////////////////////////////////////

int IMU::convertToInt (char* buffer) 
{
	int x = (buffer[0]&LSB_MASK)*256 + (buffer[1]&LSB_MASK);
	return x;

} // end convertToInt


///////////////////////////////////////////////////////////////////////////////
//
// convertToShort
//
///////////////////////////////////////////////////////////////////////////////

short IMU::convertToShort (char* buffer) 
{
	short x = (buffer[0]&LSB_MASK)*256 + (buffer[1]&LSB_MASK);
	return x;

} // end convertToShort


///////////////////////////////////////////////////////////////////////////////
//
// grabGyroStabilizedOrientationMatrix
//
///////////////////////////////////////////////////////////////////////////////

void IMU::grabGyroStabilizedOrientationMatrix ()
{
	// write the header if we need to
	if (header == false) {
		writeHeader();
	}

	FILE *stream;

	float xform [3][3];
	float convertFactor = 8192.0f;

	char command [1];
	char response[128];

	int status;
	int responseLength = 23;

	DWORD bytesWritten, bytesRead;

	command[0] = (char)CMD_GYRO_OR_MATRIX;

	// send the command
	status = WriteFile(h, command, 1, &bytesWritten, NULL);

	if (status == 0) {
		printf("Error sending command to IMU\n");
	}

	// read the response
	status = ReadFile(h, &response[0], responseLength, &bytesRead, NULL);
		
	if (status == 0) {
		printf("grabGyroStabilizedOrientationMatrix :: Error receiving data from IMU\n");
	}

	for (int i=0; i<3; i++) {
		for (int j=0;j<3;j++) {
			xform[i][j] = (float) convertToShort(&response[1+2*(j*3+i)])/convertFactor;
		}
	}

	if (log == 1) {

		stream = fopen(globalFileName, "a");

		if (!header) {
			fprintf(stream, "GyroStabilizedOrientationMatrix\n");
			header = true;
		}

		fprintf(stream, "%f, %f, %f, %f, %f, %f, %f, %f, %f\n", 
			xform[0][0], xform[0][1], xform[0][2],
			xform[1][0], xform[1][1], xform[1][2],
			xform[2][0], xform[2][1], xform[2][2]);
		fclose(stream);
	}

	if (globalEcho == 1) {
		for (int i=0; i<3; i++) {
			for (int j=0;j<3;j++) {
				printf("xform[%d][%d] = %f\n", i, j, xform[i][j]);
			}
		}
	}

} // end grabGyroStabilizedOrientationMatrix


///////////////////////////////////////////////////////////////////////////////
//
// grabGyroStabilizedOrientationMatrix
//
///////////////////////////////////////////////////////////////////////////////

void IMU::grabGyroStabilizedOrientationMatrix (float *om1, float *om2, float *om3, float *om4, float *om5, float *om6, float *om7, float *om8, float *om9)
{
	float xform [3][3];
	float convertFactor = 8192.0f;

	char command [1];
	char response[128];

	int status;
	int responseLength = 23;

	DWORD bytesWritten, bytesRead;

	command[0] = (char)CMD_GYRO_OR_MATRIX;

	// send the command
	status = WriteFile(h, command, 1, &bytesWritten, NULL);

	Sleep(10);

	// read the response
	status = ReadFile(h, &response[0], responseLength, &bytesRead, NULL);
		
	for (int i=0; i<3; i++) {
		for (int j=0;j<3;j++) {
			xform[i][j] = (float) convertToShort(&response[1+2*(j*3+i)])/convertFactor;
		}
	}

	*om1 = xform[0][0];
	*om2 = xform[0][1];
	*om3 = xform[0][2];
	*om4 = xform[1][0];
	*om5 = xform[1][1];
	*om6 = xform[1][2];
	*om7 = xform[2][0];
	*om8 = xform[2][1];
	*om9 = xform[2][2];

} // end grabGyroStabilizedOrientationMatrix


///////////////////////////////////////////////////////////////////////////////
//
// grabStabEulerAngles
//
///////////////////////////////////////////////////////////////////////////////

void IMU::grabStabEulerAngles ()
{
	// write the header if we need to
	if (header == false) {
		writeHeader();
	}

	FILE *stream;

	float roll, pitch, yaw;

	float convertFactor = (360.0/65536.0f);

	char command [1];
	char response[128];

	int status;
	int responseLength = 11;

	DWORD bytesWritten, bytesRead;

	command[0] = (char)CMD_GYRO_EULER;

	// send the command
	status = WriteFile(h, command, 1, &bytesWritten, NULL);

	if (status == 0) {
		printf("grabStabEulerAngles :: Error sending command to IMU\n");
	}

	// read the response
	status = ReadFile(h, &response[0], responseLength, &bytesRead, NULL);

	if (status == 0) {
		printf("Error receiving data from IMU\n");
	}

    roll  = convertToShort(&response[1]) * convertFactor;
    pitch = convertToShort(&response[3]) * convertFactor;
    yaw   = convertToShort(&response[5]) * convertFactor;

	if (log == 1) {

		stream = fopen(globalFileName, "a");

		if (!header) {
			fprintf(stream, "roll, pitch, yaw\n");
			header = true;
		}

		fprintf(stream, "%f, %f, %f\n", roll, pitch, yaw);
		fclose(stream);
	}

	if (globalEcho == 1) {
		printf("roll = %f\n", roll);
		printf("pitch = %f\n", pitch);
		printf("yaw = %f\n", yaw);
	}

} // end grabStabEulerAngles


///////////////////////////////////////////////////////////////////////////////
//
// grabStabEulerAngles
//
///////////////////////////////////////////////////////////////////////////////

void IMU::grabStabEulerAngles (float *roll, float *pitch, float *yaw)
{
	float convertFactor = (360.0/65536.0f);

	char command [1];
	char response[128];

	int status;
	int responseLength = 11;

	DWORD bytesWritten, bytesRead;

	command[0] = (char)CMD_GYRO_EULER;

	// send the command
	status = WriteFile(h, command, 1, &bytesWritten, NULL);

	Sleep(10);

	// read the response
	status = ReadFile(h, &response[0], responseLength, &bytesRead, NULL);

    *roll  = convertToShort(&response[1]) * convertFactor;
    *pitch = convertToShort(&response[3]) * convertFactor;
    *yaw   = convertToShort(&response[5]) * convertFactor;

} // end grabStabEulerAngles


///////////////////////////////////////////////////////////////////////////////
//
// grabStabAccel
//
///////////////////////////////////////////////////////////////////////////////

void IMU::grabStabAccel ()
{
	// write the header if we need to
	if (header == false) {
		writeHeader();
	}

	FILE *stream;

	float magnetic[3];
	float acceleration[3];
	float angularRate[3];
	float convertFactor = 8192.0f;
    float angularFactor = gyroGainScale[0] * 8192.0f * 0.0065536f;

	char command [1];
	char response[128];

	int status;
	int responseLength = 23;

	DWORD bytesWritten, bytesRead;

	command[0] = (char) CMD_GYRO_VECTOR;

	// send the command
	status = WriteFile(h, command, 1, &bytesWritten, NULL);

	if (status == 0) {
		printf("Error sending command to IMU\n");
	}

	// read the response
	status = ReadFile(h, &response[0], responseLength, &bytesRead, NULL);

	if (status == 0) {
		printf("grabStabAccel :: Error receiving data from IMU\n");
	}

	for (int i=0; i<3; i++) {
		magnetic[i]     = (float) convertToShort(&response[1 + i*2])/convertFactor;
		acceleration[i] = (float) convertToShort(&response[7 + i*2])/convertFactor;
		angularRate[i]	= (float) convertToShort(&response[13+ i*2])/angularFactor;
	}

	if (log == 1) {

		stream = fopen(globalFileName, "a");

		if (!header) {
			fprintf(stream, "stabAccel\n");
			header = true;
		}

		fprintf(stream, "%f, %f, %f\n", acceleration[0], acceleration[1], acceleration[2]);
		fclose(stream);
	}
 
	if (globalEcho == 1) {
		for (int i=0; i<3; i++) {
			printf("acceleration[%d] = %f\n", i, acceleration[i]);
		}
	}

} // end grabStabAccel


///////////////////////////////////////////////////////////////////////////////
//
// grabStabAccel
//
///////////////////////////////////////////////////////////////////////////////

void IMU::grabStabAccel (float *accel1, float *accel2, float *accel3)
{
	float magnetic[3];
	float acceleration[3];
	float angularRate[3];
	float convertFactor = 8192.0f;
    float angularFactor = gyroGainScale[0] * 8192.0f * 0.0065536f;

	char command [1];
	char response[128];

	int status;
	int responseLength = 23;

	DWORD bytesWritten, bytesRead;

	command[0] = (char) CMD_GYRO_VECTOR;

	// send the command
	status = WriteFile(h, command, 1, &bytesWritten, NULL);

	Sleep(10);

	// read the response
	status = ReadFile(h, &response[0], responseLength, &bytesRead, NULL);

	for (int i=0; i<3; i++) {
		magnetic[i]     = (float) convertToShort(&response[1 + i*2])/convertFactor;
		acceleration[i] = (float) convertToShort(&response[7 + i*2])/convertFactor;
		angularRate[i]	= (float) convertToShort(&response[13+ i*2])/angularFactor;
	}

	*accel1 = acceleration[0];
	*accel2 = acceleration[1];
	*accel3 = acceleration[2];

} // end grabStabAccel


///////////////////////////////////////////////////////////////////////////////
//
// initializeSerialPort
//
///////////////////////////////////////////////////////////////////////////////

int IMU::initializeSerialPort (string comPortIn)
{
	if (serialPortInitedOnce == false) {

		h = CreateFile(comPortIn.c_str(), GENERIC_READ|GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);

		if (h == INVALID_HANDLE_VALUE) {

			printf("Failed to open port");
			return 0;
    
		} else {
         
			// set buffer sizes
			SetupComm(h, 128, 128);

			// set DCB
			DCB dcb;
       
			memset(&dcb,0,sizeof(dcb));
			dcb.DCBlength	= sizeof(dcb);
			dcb.BaudRate	= 38400;
			dcb.Parity		= NOPARITY;
			dcb.StopBits	= 0;
			dcb.ByteSize	= 8;

			if (!SetCommState(h,&dcb)) {
				printf("SetCommState failed");
			}

			// set timeouts
			COMMTIMEOUTS cto = { 50, 50, 10, 50, 10 };

			if(!SetCommTimeouts(h,&cto)) {
				printf("SetCommTimeouts failed");
			}

		}

		serialPortInitedOnce = true;
	}

	return 0;

} // end 


///////////////////////////////////////////////////////////////////////////////
//
// writeHeader
//
///////////////////////////////////////////////////////////////////////////////

void IMU::writeHeader ()
{
	// first, init the log file
	logFile.open (logFileName.c_str());

	// write the headers
	if (grabStabAccelFlag == 1) {
		logFile << "accel[0],accel[1],accel[2],";
	}

	if (grabStabEulerAnglesFlag == 1) {
		logFile << "roll,pitch,yaw,";
	}

	if (grabStabOrientationMatrixFlag == 1) {
		logFile << "orientationMaxtrix[0],orientationMaxtrix[1],orientationMaxtrix[2]," <<
			"orientationMaxtrix[3],orientationMaxtrix[4],orientationMaxtrix[5]," <<
			"orientationMaxtrix[6],orientationMaxtrix[7],orientationMaxtrix[8]";
	}

	// write a new line
	logFile << "\n";

	// set header to true
	header = true;

} // end writeHeader


///////////////////////////////////////////////////////////////////////////////
//
// runGrab
//
///////////////////////////////////////////////////////////////////////////////

void IMU::runGrab ()
{
	float accel1=0, accel2=0, accel3=0;
	float roll=0, pitch=0, yaw=0;
	float om1=0, om2=0, om3=0, om4=0, om5=0, om6=0, om7=0, om8=0, om9=0;

	time_t sampleTime;

	if (!fileInited) {
		// first, init the log file
		logFile.open (logFileName.c_str());
		cout << "\n\nIMU :: Opened " << logFileName << "\n";
		fileInited = true;
	}

	// write the header
	if (grabStabAccelFlag == true && header == false) {
		grabStabAccel(&accel1, &accel2, &accel3);
		logFile << "accel1,accel2,accel3,";
	}

	if (grabStabEulerAnglesFlag == true && header == false) {
		grabStabAccel(&roll, &pitch, &yaw);
		logFile << "roll,pitch,yaw,";
	}

	if (grabStabOrientationMatrixFlag == true && header == false) {
		grabGyroStabilizedOrientationMatrix(&om1, &om2, &om3, &om4, &om5, &om6, &om7, &om8, &om9);
		logFile << "om1,om2,om3,om4,om5,om6,om7,om8,om9,timestamp";
		header = true;
	}

	logFile << "\n";

	while (running) {

		if (grabStabAccelFlag == true) {
			grabStabAccel(&accel1, &accel2, &accel3);
			logFile << accel1 << "," << accel2 << "," << accel3 << ",";
		}

		if (grabStabEulerAnglesFlag == true) {
	//		grabStabAccel(&roll, &pitch, &yaw);
			grabStabEulerAngles(&roll, &pitch, &yaw);
			logFile << roll << "," << pitch << "," << yaw << ",";
		}

		if (grabStabOrientationMatrixFlag == true) {
			grabGyroStabilizedOrientationMatrix(&om1, &om2, &om3, &om4, &om5, &om6, &om7, &om8, &om9);
			logFile << om1 << "," << om2 << "," << om3 << "," << om4 << "," << om5 << "," << om6 << "," << om7 << "," << om8 << "," << om9;
		}

		// get the time
		time(&sampleTime);

		logFile << "," << sampleTime << "\n";

	}

	logFile.close();

}