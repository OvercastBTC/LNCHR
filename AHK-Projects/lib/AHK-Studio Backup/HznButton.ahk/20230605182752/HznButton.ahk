;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; #Warn  ; Enable warnings to assist with detecting common errors.
; SetWinDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetControlDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 = max speed possible. ; (AJB - 05/2023)comment out for testing
; SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing 
; SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
;#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#Requires AutoHotkey 1.1+

;#NoTrayIcon

; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; ----------------------------------------------------------------------------------------------------------------------
; Name .........: Horizon Button == A Horizon function library
; Description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
; AHK Version ..: AHK 1.1+ x32/64 Unicode
; Author .......: Overcast (Adam Bacon), Terry Keatts, and special assistance from Descolada
; License ......: WTFPL - http://www.wtfpl.net/txt/copying/
; Changelog ....: ??? - v0.1 - First version. Added Ctrl-I, Ctrl-B
; ..............: ??? - v0.2 - Broke lots of things, and "fixed" them
; ..............: ??? - v0.3 - Broke lots of things, and "fixed" them... again. Added Ctrl-A
; ..............: ??? - v0.4 - Broke lots of things, and "fixed" them... again  
; ..............: 5/23/2023 - v0.5 - Fixed issue where Ctrl-A didn't work in the Equipment Section.
; ..............: 5/31/2023 - v0.6 - Transferred all data sheets to a .ini file (OSTitle.ini).
; ..............: 6/01/2023 - v0.7 - Changed the MakeOSItalic() to read the key: Title= only => see Common_Abbrevations
; . Continued .....................: See Common_Abbrevations.ahk for additional details.
; ..............: 6/04/2023 - v0.8 - Added icon, tray menu, separated MakeOSItalic() function
; . Continued .....................: => Tray Menu has the "option" to run an startup ==> this needs to change to always
; ..............: 6/04/2023 - v0.9 - Added "CloseHandle" and "GlobalFree" dllcalls to attempt correction of weirdness
; . Continued .....................: after running the HznButton() function
; ----------------------------------------------------------------------------------------------------------------------


; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Script Name, Startup Path, and icon
; ----------------------------------------------------------------------------------------------------------------------
ICON := "C:\AHK-Studio\AHK-Projects\Horizon\HznHorizon.ico"
splitPath, A_ScriptFullPath, , , A_Script_Ext, A_Script_Name
A_Script_Full_Name := A_Script_Name "." A_Script_Ext
Startup_Shortcut := A_Startup "\" A_Script_Name ".lnk"
; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu
; ----------------------------------------------------------------------------------------------------------------------

Menu, Tray, Icon, % Icon ; this changes the icon into a little Horizon thing.
Menu, Tray, NoStandard
addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
addTrayMenuOption()
addTrayMenuOption("Run at startup", "runAtStartup")
Menu, Tray, % fileExist(Startup_Shortcut) ? "check" : "unCheck", Run at startup ; update the tray menu status on startup
addTrayMenuOption()
Menu, Tray, Standard

; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu Functions
; Description .....: addTrayMenuOption() ; madeBy() ; runAtStartup() ; trayNotify()
; ----------------------------------------------------------------------------------------------------------------------

addTrayMenuOption(label = "", command = "") {
	if (label = "" && command = "") {
		Menu, Tray, Add
	} else {
		Menu, Tray, Add, % label, % command
	}
}

madeBy(){
	; visit authors website
	;Run, https://bibeka.com.np/
	MsgBox This was made by nerds, for nerds. Regular people are ok too, lol.`nModified by Adam Bacon`nCredit:Made with ❤️ by Bibek Aryal
}

runAtStartup() {
	if (FileExist(startup_shortcut)) {
		FileDelete, % startup_shortcut
		Menu, Tray, % "unCheck", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut removed", "This script will not run when you turn on your computer.")
	} else {
		FileCreateShortcut, % a_scriptFullPath, % startup_shortcut
		Menu, Tray, % "check", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut added", "This script will now automatically run when your turn on your computer.")
	}
	
}

trayNotify(title, message, seconds = "", options = 0) {
	TrayTip, %title%, %message%, %seconds%, %options%
}

; ********************************************** ... First Return ... **************************************************
return
; ********************************************** ... First Return ... **************************************************

; ...............: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#IfWinActive ahk_exe hznhorizon.exe

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon {Enter} ==> Select Option
; Description ..: Hotkeys (shortcuts) sending {Enter} in leu of "Double Click"
; Author .......: Overcast (Adam Bacon)
; TODO .........: Still doesn't work. Might have to not use the WinActive() function
; ----------------------------------------------------------------------------------------------------------------------
#If WinActive("ahk_exe hznhorizonmgr.exe") or WinActive("ahk_exe hznhorizon.exe")
{
	ControlGetFocus, hCtl, A
	ControlGet, Ctl, hWnd,,% hCtl, A
	Shift & Enter::DllCall("PostMessage", Ptr, Ctl, UInt,0x0203,Ptr, 0, Ptr, 0)
}
return
#If

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Buttons/Hotkeys
; Description ..: Hotkeys (shortcuts) for normal Windows hotkeys: CTRL+I (italics) ; CTRL+B (bold) ; CTRL+A (select all)
; . Continued ..: CTRL+U (underline) - Where Applicable - else same as CTRL+B (I dunno why).
; . Continued ..: In ideal land, this will be a single function call. Right now this works.
; Author .......: Overcast (Adam Bacon)
; TODO .........: Reduce to a single HznButton function call
; ChangeLog ....: see above
; Special Notes : >>>>> The below indexs, or n from the HznButton() function, depend on what screen you are on <<<<<
; . Continued ..: ===== Human Element Section =====
; . Continued ..: 1=Bold, 2=Italics, 10=Cut, 11=Copy, 12=Paste, 14=Undo, 15=Redo, 17=Bulleted List, 18=Spell Check
; . Continued ..: 20=Super/Sub Script, 21=Find/Replace
; . Continued ..: Mystery or Spacers: 3-9, 13, 16, 19=?Bold?
; . Continued ..: ===== Equipment Section =====
; . Continued ..: Nothing?=1,2; Same: 21,20,18,17,
; . Continued ..: ===== where underline is an option is index 3, else it reverts to CTRL+B 
; ----------------------------------------------------------------------------------------------------------------------

; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Horizon Button Function <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
^i::
^b::
^u::
hHK:= trim(A_ThisHotkey, " `t `n `r : ")
hIDx := hHK = trim("^i" ? 2
	: hHK = "^b" ? 1
	: hHK = "^u" ? 9
;: MsgBox % ErrorLevel
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,hIDx)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,hIDx)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,hIDx)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,hIDx)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,hIDx)
return
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Button - Italics (Ctrl-I)
; ----------------------------------------------------------------------------------------------------------------------

;^i::
; ..........: Leave until conversion to AHK v2 ==> backup for conflict with SetBatchLines, SetWinDelay, SetControlDelay
ci:
; ......................................................................................................................
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,2)
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Button - Bold (Ctrl-B)
; ----------------------------------------------------------------------------------------------------------------------

;^b::
; ..........: Leave until conversion to AHK v2 ==> backup for conflict with SetBatchLines, SetWinDelay, SetControlDelay
cb:
; ......................................................................................................................
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,1)
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Button - Underline (Ctrl+U) [Where Applicable]
; FE Notepad .....:  9=U, 10=U, 
; Required COPE ..: 9=U, 10=U
; .....: original value of 3???
; ----------------------------------------------------------------------------------------------------------------------

;^u::
; ..........: Leave until conversion to AHK v2 ==> backup for conflict with SetBatchLines, SetWinDelay, SetControlDelay
cu:
; ......................................................................................................................
hIndex := 9 ;WinActive("Field Engineer's Notepad:") & WinActive("ahk_exe hznhorizon.exe") ? 9 : 3
;hIndex := WinActive("ahk_exe hznhorizon.exe") & WinActive("Field Engineer's Notepad:") ? 9
;: WinActive("ahk_exe hznhorizon.exe") & WinActive("Required COPE Information:") ? 9
;: WinActive("ahk_exe hznhorizon.exe") & WinActive("[Main]") ? 9 : 10

ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,hIndex)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,hIndex)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,hIndex)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,hIndex)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,hIndex)
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkey - Select-All (Ctrl-A)
; ----------------------------------------------------------------------------------------------------------------------

^a::
; ..........: Leave until conversion to AHK v2 ==> backup for conflict with SetBatchLines, SetWinDelay, SetControlDelay
ca:
; ......................................................................................................................
ControlGetFocus, hCtl, A
ControlGet, Ctl, hWnd,,% hCtl, A
hWndChild := DllCall("RealChildWindowFromPoint", Ptr,Ctl, UInt,, Ptr)
WinGetClass, vCtl, % "ahk_id " hWndChild
vhCtl := vCtl = "ThunderRT6TextBox" or "TX11" ? DllCall("SendMessage","PTR",ctl,"UInt",0xB1)
									 : DllCall("SendMessage","PTR",ctl,"UInt",0xB1, Ptr, 0, Ptr, -1)
/*									 
If(vCtl = "ThunderRT6TextBox"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}
If(vCtl = "TX11"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}else {
	;PostMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	;SendMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1, Ptr, 0, Ptr, -1) 	; works in eqpt
}
;reload
*/
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: HznButton()
; Description ..: Find and Control-Click the Horizon msvb_lib_toolbar buttons
; Definition ...: hWndToolbar = the toolbar window's handle
; Definition ...: n = the index for the specified button
; Author .......: Descolada, Overcast (Adam Bacon)
; ----------------------------------------------------------------------------------------------------------------------

HznButton(hWndToolbar, n) 
{
	static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETITEMRECT := 0x41D ; set the static variables
	SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar% ; count and load all the msvb_lib_toolbar buttons into memory
	buttonCount := ErrorLevel
	if (n >= 1 && n <= buttonCount) {
		DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UIntP", targetProcessID)
		; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
		hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		; Allocate memory for the TBBUTTON structure in the target process's address space
		remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")
		SendMessage, TB_GETITEMRECT, % n-1, remoteMemory, , ahk_id %hWndToolbar%
		VarSetCapacity(RECT, 16, 0)
		DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
		DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
		;DllCall("CloseHandle", "Ptr", hProcess) ; this and the below "GlobalFree" may have fixed the need for a reload.	
		; get the bounding rectangle for the specified button
		X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
		ControlClick, % "x" (X+W//2) " y" (Y+H//2), ahk_id %hWndToolbar%,,,, NA
		SetControlDelay, %prevDelay%
	} else {
		MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
	}
}
;DllCall("GlobalFree", "Ptr", hWndToolbar) ; this and the above "CloseHandle" may have fixed the need for a reload.	
reload ; make sure you reload or it... does weird stuff
return
#IfWinActive