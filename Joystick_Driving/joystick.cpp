
#define STRICT
#define DIRECTINPUT_VERSION 0x0800

#include <windows.h>
#include <commctrl.h>
#include <basetsd.h>
#include <dinput.h>
#include <strsafe.h>
#include "resource.h"

#include <string>
#include <sstream>

#include "Serial.h"

using namespace std;

///////////////////////////////////////////////////////////////////////////////
//
// function prototypes
//
///////////////////////////////////////////////////////////////////////////////

int commandMovement (int motorSpeedLeft, int motorSpeedRight);
INT_PTR CALLBACK MainDlgProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam);
BOOL CALLBACK EnumObjectsCallback(const DIDEVICEOBJECTINSTANCE* pdidoi, VOID* pContext);
BOOL CALLBACK EnumJoysticksCallback(const DIDEVICEINSTANCE* pdidInstance, VOID* pContext);
HRESULT InitDirectInput(HWND hDlg);
VOID FreeDirectInput();
HRESULT UpdateInputState(HWND hDlg);

int InitSerial ();

string itos(int i);

void endDataCollection();
void readINI();
void startDataCollection();
void updateINI (int runNumberIn);

void runIMU(void *arg);
void runFrames(void *arg);

///////////////////////////////////////////////////////////////////////////////
//
// global variables
//
///////////////////////////////////////////////////////////////////////////////

bool runOnce = false;
bool threadsCreated = false;

char iniFile [] = "C:\\Development\\Data_Collection\\Data_Collection.ini";

int cameraIndex = 0;
int comPortMotorController = 0;
int comPortSony = 0;
int comPortIMU = 0;
int height = 0;
int width = 0;
int autofocus = 0;
int zoom = 0;
int runNumber = 0;

string fileNameIMU;
string path;

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
// constants and global variables
//
///////////////////////////////////////////////////////////////////////////////

#define SAFE_DELETE(p)  { if(p) { delete (p);     (p)=NULL; } }
#define SAFE_RELEASE(p) { if(p) { (p)->Release(); (p)=NULL; } }

LPDIRECTINPUT8 g_pDI = NULL;         
LPDIRECTINPUTDEVICE8 g_pJoystick = NULL;     

// CSerial classes
CSerial serialMotorController;

HANDLE handle;

int serialErrors = 0;

///////////////////////////////////////////////////////////////////////////////
//
// WinMain
//
///////////////////////////////////////////////////////////////////////////////

int APIENTRY WinMain(HINSTANCE hInst, HINSTANCE, LPSTR, int)
{
	// read INI
	readINI();

    InitCommonControls();
	serialErrors = InitSerial();

    // display the main dialog box
    DialogBox(hInst, MAKEINTRESOURCE(IDD_JOYST_IMM), NULL, MainDlgProc);
    
    return TRUE;

} // end WinMain


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

	int lLastError = ERROR_SUCCESS;
	string comPort = "COM1";
   // attempt to open the serial port
	lLastError = serialMotorController.Open(comPort.c_str(),0,0,true);
	if (lLastError != ERROR_SUCCESS) {
		printf("Unable to open the COM port\n");
	}

	// setup the serial port -- 9600,7E1
	lLastError = serialMotorController.Setup(CSerial::EBaud9600, CSerial::EData7, CSerial::EParEven, CSerial::EStop1);
	if (lLastError != ERROR_SUCCESS) {
		printf("Unable to set COM port settings\n");
	}

	// turn handshaking off
	lLastError = serialMotorController.SetupHandshaking(CSerial::EHandshakeOff);
	if (lLastError != ERROR_SUCCESS) {
		printf("Unable to turn handshaking off\n");
	}

	// use 'non-blocking' reads, because we don't know how many bytes will be received
	lLastError = serialMotorController.SetupReadTimeouts(CSerial::EReadTimeoutNonblocking);
	if (lLastError != ERROR_SUCCESS) {
		printf("Unable to set COM port read timeout\n");
	}

	// create a handle for the overlapped operations
	HANDLE hevtOverlapped = ::CreateEvent(0,TRUE,FALSE,0);
	if (hevtOverlapped == 0) {
		printf("Unable to create manual reset event for overlapped I/O");
	}

	// setup the overlapped structure
	OVERLAPPED ov = {0};
	ov.hEvent = hevtOverlapped;

	// send 10 carriage returns in sequence to enter rs-232 mode
	for (int i=0; i<10; i++) {
		serialMotorController.Write("\r", 2, 0, 0);
		Sleep(50);
	}

	return ERROR_SUCCESS;

} // end initSerial


///////////////////////////////////////////////////////////////////////////////
//
// MainDialogProc
//
// Handles dialog messages
//
///////////////////////////////////////////////////////////////////////////////

INT_PTR CALLBACK MainDlgProc(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
    switch (msg) {

        case WM_INITDIALOG:
        
			if (FAILED(InitDirectInput(hDlg))) {
                MessageBox(NULL, TEXT("Error Initializing DirectInput"), 
                            TEXT("Data Collection"), MB_ICONERROR | MB_OK );
                EndDialog( hDlg, 0 );
            }

			if (serialErrors != ERROR_SUCCESS) {
                MessageBox(NULL, TEXT("Error Initializing COM Port"), 
                            TEXT("Data Collection"), MB_ICONERROR | MB_OK );
                EndDialog( hDlg, 0 );
            }

            // set a timer to go off 30 times a second. At every timer message
            // the input device will be read
            SetTimer(hDlg, 0, 1000/30, NULL);
            return TRUE;

        case WM_ACTIVATE:

            if (WA_INACTIVE != wParam && g_pJoystick) {
                // make sure the device is acquired, if we are gaining focus
                g_pJoystick->Acquire();
            }
            return TRUE;

        case WM_TIMER:

            // update the input device every timer message
            if(FAILED(UpdateInputState(hDlg))) {
                KillTimer(hDlg, 0);    
                MessageBox(NULL, TEXT("Error Reading Input State.") \
                            TEXT("Progam will now terminate."), TEXT("Data Collection"), 
                            MB_ICONERROR | MB_OK );
                EndDialog( hDlg, TRUE ); 
            }
            return TRUE;

        case WM_COMMAND:

            switch(LOWORD(wParam)) {
                case IDCANCEL:
                    EndDialog( hDlg, 0 );
                    return TRUE;
          //      case IDC_BUTTON_STOP:


            }

        case WM_DESTROY:

            // cleanup everything
            KillTimer(hDlg, 0);    
            FreeDirectInput();    
            return TRUE;    
    }

    return FALSE; 

} // end MainDlgProc


///////////////////////////////////////////////////////////////////////////////
//
// InitDirectInput
//
// Initialize the DirectInput variables
//
///////////////////////////////////////////////////////////////////////////////

HRESULT InitDirectInput(HWND hDlg)
{
    HRESULT hr;

    // register with the DirectInput subsystem and get a pointer
    // to a IDirectInput interface we can use

    // Create a DInput object
    if (FAILED(hr = DirectInput8Create(GetModuleHandle(NULL), DIRECTINPUT_VERSION, 
                                         IID_IDirectInput8, (VOID**)&g_pDI, NULL )))
        return hr;

    // look for the joystick
    if (FAILED(hr = g_pDI->EnumDevices(DI8DEVCLASS_GAMECTRL, 
                                         EnumJoysticksCallback,
                                         NULL, DIEDFL_ATTACHEDONLY)))
        return hr;

    // make sure we have a joystick
    if (NULL == g_pJoystick) {
        MessageBox(NULL, TEXT("Joystick not found. The program will now terminate."), TEXT("Data Collection"), MB_ICONERROR | MB_OK );
        EndDialog( hDlg, 0 );
        return S_OK;
    }

    // set the data format to "simple joystick" - a predefined data format 

	// A data format specifies which controls on a device we are interested in,
    // and how they should be reported. This tells DInput that we will be
    // passing a DIJOYSTATE2 structure to IDirectInputDevice::GetDeviceState().
    if (FAILED(hr = g_pJoystick->SetDataFormat(&c_dfDIJoystick2)))
        return hr;

    // set the cooperative level to let DInput know how this device should
    // interact with the system and with other DInput applications.
    if (FAILED(hr = g_pJoystick->SetCooperativeLevel(hDlg, DISCL_EXCLUSIVE | 
                                                             DISCL_FOREGROUND)))
        return hr;

    // enumerate the joystick objects. The callback function enabled user
    // interface elements for objects that are found, and sets the min/max
    // values property for discovered axes.
    if (FAILED(hr = g_pJoystick->EnumObjects(EnumObjectsCallback, 
                                                (VOID*)hDlg, DIDFT_ALL)))
        return hr;

    return S_OK;

} // end InitDirectInput



///////////////////////////////////////////////////////////////////////////////
//
// EnumJoysticksCallback
//
// This is called one for each enumerated joystick.  If one is found, we create
//  a device interface on it so we can use it.
//
///////////////////////////////////////////////////////////////////////////////

BOOL CALLBACK EnumJoysticksCallback( const DIDEVICEINSTANCE* pdidInstance,
                                     VOID* pContext )
{
    HRESULT hr;

    // obtain an interface to the enumerated joystick.
    hr = g_pDI->CreateDevice(pdidInstance->guidInstance, &g_pJoystick, NULL);

    // if it failed, then we can't use this joystick. (Maybe the user unplugged
    // it while we were in the middle of enumerating it.)
    if (FAILED(hr)) 
        return DIENUM_CONTINUE;

    // stop the enumeration. Note: we're just taking the first joystick we find. You
    // could store all the enumerated joysticks and let the user pick.
    return DIENUM_STOP;

} // end EnumJoysticksCallback


///////////////////////////////////////////////////////////////////////////////
//
// EnumObjectsCallback
//
// This is the callback function for enumerating objects (axes, buttons, POVs)
//  on a joystick.  This function enables user interface elements for objects 
//  that are found to exist and scales axes min/max values.
//
///////////////////////////////////////////////////////////////////////////////

BOOL CALLBACK EnumObjectsCallback(const DIDEVICEOBJECTINSTANCE* pdidoi, VOID* pContext)
{
    HWND hDlg = (HWND)pContext;

	// the number of slider controls
    static int nSliderCount = 0;  // Number of returned slider controls

	// the number of returned POV controls
	static int nPOVCount = 0;     

    // for axes that are returned, set the DIPROP_RANGE property for the
    // enumerated axis in order to scale min/max values.
    if(pdidoi->dwType & DIDFT_AXIS) {
        DIPROPRANGE diprg; 
        diprg.diph.dwSize       = sizeof(DIPROPRANGE); 
        diprg.diph.dwHeaderSize = sizeof(DIPROPHEADER); 
        diprg.diph.dwHow        = DIPH_BYID; 
        diprg.diph.dwObj        = pdidoi->dwType; // Specify the enumerated axis
        diprg.lMin              = -1000; 
        diprg.lMax              = +1000; 
    
        // set the range for the axis
        if(FAILED(g_pJoystick->SetProperty( DIPROP_RANGE, &diprg.diph))) 
            return DIENUM_STOP;
         
    }

    // set the UI to reflect what objects the joystick supports
    if (pdidoi->guidType == GUID_XAxis) {
        EnableWindow(GetDlgItem(hDlg, IDC_X_AXIS), TRUE);
        EnableWindow(GetDlgItem(hDlg, IDC_X_AXIS_TEXT), TRUE);
    }

    if (pdidoi->guidType == GUID_YAxis) {
        EnableWindow(GetDlgItem(hDlg, IDC_Y_AXIS), TRUE);
        EnableWindow(GetDlgItem(hDlg, IDC_Y_AXIS_TEXT), TRUE);
    }

    if (pdidoi->guidType == GUID_ZAxis) {
        EnableWindow(GetDlgItem(hDlg, IDC_Z_AXIS), TRUE);
        EnableWindow(GetDlgItem(hDlg, IDC_Z_AXIS_TEXT), TRUE);
    }

    if (pdidoi->guidType == GUID_RxAxis) {
        EnableWindow(GetDlgItem(hDlg, IDC_X_ROT), TRUE);
        EnableWindow(GetDlgItem(hDlg, IDC_X_ROT_TEXT), TRUE);
    }

    if (pdidoi->guidType == GUID_RyAxis) {
        EnableWindow(GetDlgItem(hDlg, IDC_Y_ROT), TRUE);
        EnableWindow(GetDlgItem(hDlg, IDC_Y_ROT_TEXT), TRUE);
    }

    if (pdidoi->guidType == GUID_RzAxis) {
        EnableWindow(GetDlgItem(hDlg, IDC_Z_ROT), TRUE);
        EnableWindow(GetDlgItem(hDlg, IDC_Z_ROT_TEXT), TRUE);
    }

    if (pdidoi->guidType == GUID_Slider) {

        switch(nSliderCount++) {

            case 0 :
                EnableWindow(GetDlgItem(hDlg, IDC_SLIDER0), TRUE);
                EnableWindow(GetDlgItem(hDlg, IDC_SLIDER0_TEXT), TRUE);
                break;

            case 1 :
                EnableWindow(GetDlgItem(hDlg, IDC_SLIDER1), TRUE);
                EnableWindow(GetDlgItem(hDlg, IDC_SLIDER1_TEXT), TRUE);
                break;
        }
    }

    if (pdidoi->guidType == GUID_POV) {

        switch(nPOVCount++) {

            case 0 :
                EnableWindow(GetDlgItem(hDlg, IDC_POV0), TRUE);
                EnableWindow(GetDlgItem(hDlg, IDC_POV0_TEXT), TRUE);
                break;

            case 1 :
                EnableWindow(GetDlgItem(hDlg, IDC_POV1), TRUE);
                EnableWindow(GetDlgItem(hDlg, IDC_POV1_TEXT), TRUE);
                break;

            case 2 :
                EnableWindow( GetDlgItem(hDlg, IDC_POV2), TRUE);
                EnableWindow( GetDlgItem(hDlg, IDC_POV2_TEXT), TRUE);
                break;

            case 3 :
                EnableWindow(GetDlgItem(hDlg, IDC_POV3), TRUE);
                EnableWindow(GetDlgItem(hDlg, IDC_POV3_TEXT), TRUE);
                break;
        }
    }

    return DIENUM_CONTINUE;

} // end EnumObjectsCallback


///////////////////////////////////////////////////////////////////////////////
//
// UpdateInputState
//
// This gets the input device's state and displays it
//
///////////////////////////////////////////////////////////////////////////////

HRESULT UpdateInputState(HWND hDlg)
{
    HRESULT hr;

	// device state text
    TCHAR strText[512] = {0};

	// DInput joystick state
    DIJOYSTATE2 js;         

    if (NULL == g_pJoystick) 
        return S_OK;

    // poll the device to read the current state
    hr = g_pJoystick->Poll(); 

    if (FAILED(hr)) {

        // DInput is telling us that the input stream has been
        // interrupted. We aren't tracking any state between polls, so
        // we don't have any special reset that needs to be done. We
        // just re-acquire and try again.
        hr = g_pJoystick->Acquire();
        
		while (hr == DIERR_INPUTLOST) 
            hr = g_pJoystick->Acquire();

        // hr may be DIERR_OTHERAPPHASPRIO or other errors.  This
        // may occur when the app is minimized or in the process of 
        // switching, so just try again later 
        return S_OK; 
    }

    // get the input's device state
    if (FAILED(hr = g_pJoystick->GetDeviceState(sizeof(DIJOYSTATE2), &js)))
        return hr; 

    // display joystick state to dialog

    // axes
    StringCchPrintf(strText, 512, TEXT("%ld"), js.lX); 
    SetWindowText(GetDlgItem(hDlg, IDC_X_AXIS), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.lY); 
    SetWindowText(GetDlgItem(hDlg, IDC_Y_AXIS), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.lZ); 
    SetWindowText(GetDlgItem(hDlg, IDC_Z_AXIS), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.lRx); 
    SetWindowText(GetDlgItem(hDlg, IDC_X_ROT), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.lRy); 
    SetWindowText(GetDlgItem(hDlg, IDC_Y_ROT ), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.lRz); 
    SetWindowText(GetDlgItem(hDlg, IDC_Z_ROT), strText);

    // slider controls
    StringCchPrintf(strText, 512, TEXT("%ld"), js.rglSlider[0]); 
    SetWindowText(GetDlgItem(hDlg, IDC_SLIDER0), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.rglSlider[1]); 
    SetWindowText(GetDlgItem(hDlg, IDC_SLIDER1), strText);

    // points of view
    StringCchPrintf(strText, 512, TEXT("%ld"), js.rgdwPOV[0]);
    SetWindowText(GetDlgItem(hDlg, IDC_POV0), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.rgdwPOV[1]);
    SetWindowText(GetDlgItem(hDlg, IDC_POV1), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.rgdwPOV[2]);
    SetWindowText( GetDlgItem(hDlg, IDC_POV2), strText);
    StringCchPrintf(strText, 512, TEXT("%ld"), js.rgdwPOV[3]);
    SetWindowText( GetDlgItem(hDlg, IDC_POV3), strText);
    
    // fill up text with which buttons are pressed
    for (int i=0; i<128; i++) {

        if (js.rgbButtons[i] & 0x80) {
            TCHAR sz[128];
            StringCchPrintf( sz, 128, TEXT("  %02d  "), i );
            StringCchCat( strText, 512, sz );
         }
    }

	bool driveMode = false;
	int deadband = 200;
	int walkSpeed = 110;


	//////////////////////////////////////////////////////////////////////////////
	//
	// slower pace
	//
	////////////////////////////////////////////////////////////////////////////// 

	// forward
	if (js.lY < -deadband && js.rgbButtons[2] & 0x80) {
		commandMovement(walkSpeed, walkSpeed);

	// reverse
	} else if (js.lY > deadband && js.rgbButtons[2] & 0x80) {
		commandMovement(-walkSpeed, -walkSpeed);

	// left
	} else if (js.lX < -deadband && js.rgbButtons[2] & 0x80) {
		commandMovement(0, walkSpeed);
	
	// right
	} else if (js.lX > deadband && js.rgbButtons[2] & 0x80) {
		commandMovement(walkSpeed,0);

	// lower right
	} else if (js.lY > deadband && js.lX > deadband && js.rgbButtons[2] & 0x80) {
		commandMovement(-walkSpeed, walkSpeed/2);

	// lower left
	} else if (js.lY < deadband && js.lX > deadband && js.rgbButtons[2] & 0x80) {
		commandMovement(walkSpeed/2, -walkSpeed);	

	// upper left
//	} else if (js.lY < deadband && js.lX < deadband && js.rgbButtons[2] & 0x80) {
//		commandMovement(walkSpeed/2, walkSpeed);	

	// upper right
//	} else if (js.lY < deadband && js.lX > deadband && js.rgbButtons[2] & 0x80) {
//		commandMovement(walkSpeed, walkSpeed/2);		

	// otherwise, command stop
	} else {
		commandMovement(0, 0);
	}

    SetWindowText(GetDlgItem(hDlg, IDC_BUTTONS), strText);

    return S_OK;
	 
} // end UpdateInputState


///////////////////////////////////////////////////////////////////////////////
//
// FreeDirectInput
//
// This frees the DirectInput variables
//
///////////////////////////////////////////////////////////////////////////////

VOID FreeDirectInput()
{
    // unacquire the device one last time just in case 
    // the app tried to exit while the device is still acquired.
    if (g_pJoystick) 
        g_pJoystick->Unacquire();
    
    // release any DirectInput objects
    SAFE_RELEASE(g_pJoystick);
    SAFE_RELEASE(g_pDI);

	// close the serial port
	//serial.Close();
	CloseHandle(handle);


} // end FreeDirectInput


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

	serialMotorController.Write(&cmdLeft, sizeof(cmdLeft), 0, 0, 0);
	serialMotorController.Write(&cmdRight, sizeof(cmdRight), 0, 0, 0);

	return 0;

} // end commandMovement


///////////////////////////////////////////////////////////////////////////////
//
// readINI
//
///////////////////////////////////////////////////////////////////////////////

void readINI()
{
	char pathChar[100];
	GetPrivateProfileString("Data_Collection", "Path", "C:\\", pathChar, 100, iniFile);
	path = pathChar;
	
	runNumber = GetPrivateProfileInt("Data_Collection", "Run_Number", 0, iniFile);

	// IMU
	comPortIMU = GetPrivateProfileInt("Data_Collection", "IMU_port", 99, iniFile);

	char fileNameIMUChar[100];
	GetPrivateProfileString("Data_Collection", "IMU_File_Name", "C:\\", fileNameIMUChar, 100, iniFile);
	fileNameIMU = fileNameIMUChar;
	
	// video
	cameraIndex = GetPrivateProfileInt("Data_Collection", "Camera_Index", 99, iniFile);
	height = GetPrivateProfileInt("Data_Collection", "Height", 99, iniFile);
	width = GetPrivateProfileInt("Data_Collection", "Width", 99, iniFile);
	autofocus = GetPrivateProfileInt("Data_Collection", "Autofocus", 0, iniFile);
	zoom = GetPrivateProfileInt("Data_Collection", "Zoom", 1, iniFile);

	// motor controller
	comPortMotorController = GetPrivateProfileInt("Data_Collection", "Motor_Controller_Port", 99, iniFile);

} // end readINI



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
