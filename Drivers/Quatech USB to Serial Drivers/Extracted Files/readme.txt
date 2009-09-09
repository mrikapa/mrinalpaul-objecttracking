Quatech FreedomUSB Driver Set for Windows 98/Me/2000/XP readme file

(Please refer to the HISTORY.TXT file for change history.)

====================================================================================================

Readme Contents
  Section 1:  Driver Overview
  Section 2:  Devices Supported by Driver Set
  Section 3:  New Hardware Installation
  Section 4:  Updating drivers on Windows 2000/XP for an Existing Hardware Installation
  Section 5:  Updating drivers on Windows 98/Me for an Existing Hardware Installation
  Section 6:  Files Includes with this Driver Set
  Section 7:  Release Notes

====================================================================================================

[SECTION 1: Driver Overview]

This readme file contains information for the Quatech FreedomUSB Driver Set.
For full information on using a Quatech FreedomUSB product, please see
the User's Manual included with the product or download the PDF version of
the manual from our website:

      http://www.quatech.com/

====================================================================================================

[SECTION 2: Devices Supported]

The FreedomUSB product line benefitted from changes in its manufacturing
processes in March 2003.  This driver set supports only units manufactured
since the changes were implemented.  Prior units are supported by a different
driver set.

All FreedomUSB products have a sticker listing manufacturing data.  This
sticker is on the bottom of the case, except for the SSU devices, which
have the sticker on the side of the case.

Find the sticker on your FreedomUSB product.  Locate the assembly revision
level.  The assembly revision level is made up of a letter designating a
major level and an optional digit designating a minor level.  Major revisions
increase in alphabetical order.  Minor revisions increase in numerical order.

  Example:  F3 is higher than F2.
            F2 is higher than F.
            F  is higher than E4.

The following Quatech FreedomUSB products are supported by this driver set:

   Model          Supported revisions      Description
   -----          -------------------      -----------
   SSU-100          C3 and later           Single-channel USB to RS-232
   DSU-100          F3 and later           Two-channel USB to RS-232
   DSU-200/300      F3 and later           Two-channel USB to RS-422/485
   QSU-100          F3 and later           Four-channel USB to RS-232
   QSU-200/300      F3 and later           Four-channel USB to RS-422/485
   ESU-100          E2 and later           Eight-channel USB to RS-232
   ESU-200/300      E2 and later           Eight-channel USB to RS-422/485
   HSU-100          E2 and later           Sixteen-channel USB to RS-232
   HSU-200/300      E2 and later           Sixteen-channel USB to RS-422/485

If your FreedomUSB device has a revision level older than that listed
above, please visit www.quatech.com and download the correct driver set.
Please contact our technical support department if you have any questions.

====================================================================================================

[SECTION 3:  New Hardware Installation]

If you are attempting to install your product for the first time, please read
the PDF file User’s Manual on the CD which came with your hardware.  That
document will contain detailed instructions with screen shots from the
different versions of Windows to guide you through the installation process.

====================================================================================================

[SECTION 4: Updating Release 5.x drivers on Windows 2000/XP
            for an Existing Hardware Installation]

The "Update Drivers" button in Device Manager does not work reliably and cannot
be used to update FreedomUSB device drivers.  It is necessary to uninstall
the FreedomUSB device, remove the files that Windows uses to choose the proper
drivers, and then reinstall the FreedomUSB device using the new drivers.
Follow the detailed steps below.  Contact Quatech technical support for
assistance if you have any questions or difficulties with these steps.

Uninstalling the old drivers
----------------------------

(These steps are for Windows XP.  Windows 2000 is very similar.)

1.  Ensure that a USB cable is connected between the FreedomUSB device and
    your computer.
2.  Open Device Manager by clicking the "Start" button, then selecting
    "Settings->Control Panel."  Double-click the "System" icon.  Click on
    the "Hardware" tab, then the "Device Manager" button.
3.  Double-click on "Multi-port serial adapters."  You should see your
    FreedomUSB device listed under "Multi-port serial adapters."
4.  Click on the entry for the FreedomUSB, then from the menu bar, select
    "Action/Uninstall."
5.  Unplug the FreedomUSB device's USB cable.

6.  Click the "Start" button, then "Search."
7.  Click on "All Files and Folders" if you see it in the left-hand pane.
8.  In the "All or part of the file name" box, type "OEM*.INF".
9.  In the "A Word or phrase in the file" box, type "QTUSB".
10. In the "Look in" box, select "Local Hard Drives".
11. Under "Advanced Options," make sure the following checkboxes are checked:
    "Search system folders"
    "Search hidden files and folders"
    "Search subfolders"
11. Click the "Search" button.  Wait for the search to complete.
    Results will appear in the right-hand pane.
12. Note any matching files that reside in the \WINDOWS\INF folder.
    Select one of them and click it with the right mouse button.
    Choose "Open Containing Folder."  This should open the \WINDOWS\INF folder
    with the file highlighted.
13. Select all of the files that matched the search results.  (The search
    results window should still be open if you need to refer back to it.)
    Also select the files with the same name but a file extension of .PNF.
    For instance, if the search found OEM7.INF, select OEM7.INF and OEM7.PNF.
14. Drag the files to the Recycle Bin.
15. Close all windows.
16. Shutdown the computer and reboot.

Installing the new drivers
--------------------------

1.  Plug the USB cable into the FreedomUSB device.
2.  Windows should detect the FreedomUSB device as new hardware.
3.  Follow the wizard prompts to install the new drivers.
    Be sure to point to the new drivers as you step through the wizard.

====================================================================================================

[SECTION 5: Updating Release 5.x drivers on Windows 98/Me
            for an Existing Hardware Installation]

The "Update Driver" button in Device Manager does not work reliably and cannot
be used to update FreedomUSB device drivers.  It is necessary to uninstall
the FreedomUSB device, remove the files that Windows uses to choose the proper
drivers, and then reinstall the FreedomUSB device using the new drivers.
Follow the detailed steps below.  Contact Quatech technical support for
assistance if you have any questions or difficulties with these steps.

Uninstalling the old drivers
----------------------------

(These steps are for Windows Me.  Windows 98 is very similar.)

1.  Ensure that a USB cable is connected between the FreedomUSB device and
    your computer.
2.  Open Device Manager by clicking the "Start" button, then selecting
    "Settings->Control Panel."  Double-click the "System" icon.  Click on
    the "Device Manager" tab.
3.  Double-click on "Multi-port serial devices."  You should see your
    FreedomUSB device listed under "Multi-port serial devices."
4.  Click on the entry for the FreedomUSB, then click the "Remove" button.
5.  Unplug the FreedomUSB device's USB cable.

6.  Click the "Start" button, then "Search->For Files or Folders."
7.  In the "Search for files" box, type "*.INF".
8.  In the "Containing text" box, type "QTUSB".
9.  In the "Look in" box, select "Local Hard Drives".
10. Click "Search Now."  Wait for the search to complete.  Results will
    appear in the right-hand pane.
11. Find any matching files that reside in the \WINDOWS\INF or
    \WINDOWS\INF\OTHER directories.  Highlight them and drag
    them to the Recycle Bin.
12. Close all windows.
13. Shutdown the computer and reboot.


Installing the new drivers
--------------------------

1.  Plug the USB cable into the FreedomUSB device.
2.  Windows should detect the FreedomUSB device as new hardware.
3.  Follow the wizard prompts to install the new drivers.
    Be sure to point to the new drivers as you step through the wizard.

====================================================================================================

[SECTION 6: Files Includes with this Driver Set]

The set consists of all driver files required for both Windows 98/ME and Windows 2000/XP.  Following is
a list of the files required for each OS and their destination directories, where d: is the drive on
which Windows is installed.

Windows 98/ME

   Destination directory d:\windows\inf\other\
   qtusbbx2.inf
   qtusbpt2.inf

   Destination directory d:\windows\system\
   qtusbcom.dll
   qtusbcom.sys
   serqtusb.vxd


Windows 2000

   Destination directory d:\winnt\inf\
   qtusbbx2.inf
   qtusbpt2.inf

   Destination directory d:\winnt\system32\
   qtucomco.dll
   qtucompp.dll

   Destination directory d:\winnt\system32\drivers\
   qtucombx.sys
   qtucompt.sys
   qtwdmlib.sys

====================================================================================================

[SECTION 7: Release Notes]

Please refer to the HISTORY.TXT file for change history.
