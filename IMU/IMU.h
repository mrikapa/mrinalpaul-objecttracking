
#ifndef _IMU_
#define _IMU_

#include "windows.h"
#include <iostream>
#include <fstream>
#include <string>
#include <ctime>

using namespace std;

// constants for IMU
#define GYROGAINSCALE		64
#define CMD_RAW_SENSOR		0x01
#define CMD_GYRO_VECTOR     0x02
#define CMD_INSTANT_VECTOR  0x03
#define CMD_GYRO_OR_MATRIX  0x0B
#define CMD_GYRO_EULER      0x0E
#define STABILIZED			2
#define LSB_MASK			0xFF

class IMU
{
	public:

		bool fileInited;

		// file name to log to
		string logFileName, logFileNameTimeStamps;
	
		// file
		ofstream logFile;

		// global variables
		int deviceMap[1];
		int gyroGainScale[1];

		// what are we logging?
		bool grabStabAccelFlag, grabStabEulerAnglesFlag, grabStabOrientationMatrixFlag;
	
		// 0=off 1=on
		int log;

		char globalFileName [30];
		char logname[1024];

		int globalMatlab, globalEcho, globalNSamples, globalPortNumber, globalCounter, globalGrab;

		bool globalInit;

		bool running;

		int closeSerialPort ();
		int initializeSerialPort (string comPortIn);

		void grabStabAccel ();
		void grabStabEulerAngles ();
		void grabGyroStabilizedOrientationMatrix ();

		void grabStabAccel (float *accel1, float *accel2, float *accel3);
		void grabStabEulerAngles (float *roll, float *pitch, float *yaw);
		void grabGyroStabilizedOrientationMatrix (float *om1, float *om2, float *om3, float *om4, float *om5, float *om6, float *om7, float *om8, float *om9);

		void runGrab();

		IMU();
		~IMU();

	private:

		bool header;

		bool serialPortInitedOnce;

		HANDLE h;

		int convertToInt (char* buffer); 

		short convertToShort (char* buffer); 

		void writeHeader();

};

#endif
