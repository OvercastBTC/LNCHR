;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
;#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible. ; (AJB - 05/2023)comment out for testing
; SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing 
SetWinDelay 0
; SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing 
SetControlDelay 0
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#Include ..\..\..\..\..\..\AHK-Studio\AHK-Projects\Common_Abbrevations.ahk
#Requires AutoHotkey 1.1+
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Make_Window_Groups()
; Description ..: Create editor groups to differentiate a function call for MakeOSItalic()
; Author .......: GroggtOtter, Overcast (Adam Bacon)
; ToDo .........: Fix me
; ----------------------------------------------------------------------------------------------------------------------
;/*
;Use an #If directive with a Window group.
make_editor_groups()
Return


/* ; unable to fully test at this time (AJB 5/2023)
#If WinActive("ahk_group advanced_editors") && WinActive("ahk_group basic_editors")
	MakeOSItalic(OSTitle)
	{
		Send % OSTitle
	}	
#If WinActive("ahk_group report_editors")
	MakeOSItalic(OSTitle)
	{
		OSSplit := StrSplit(OSTitle,",",,2)
		Send % OSSplit[1] ","
		Gosub, ci
		Sleep 100
		Send % OSSplit[2] " "
		Sleep 100
		Gosub, ci
	}
#If !WinActive("ahk_group advanced_editors") && WinActive("ahk_group basic_editors") && WinActive("ahk_group report_editors")
		MakeOSItalic(OSTitle)
	{
		OSSplit := StrSplit(OSTitle,",",,2)
		Send % OSSplit[1] ","
		Send ^i
		Sleep 100
		Send % OSSplit[2] " "
		;Sleep 100
		Send ^i
	}
return
#If
*/

;#NoTrayIcon
; ============================== End Auto-Execution Section ==============================
; ----------------------------------------------------------------------------------------------------------------------
; Name .........: Horizon library
; Description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
; AHK Version ..: AHK 1.3.3+ x32/64 Unicode
; Author .......: Overcast (Adam Bacon), Terry Keatts, and special assistance from Descolada
; License ......: WTFPL - http://www.wtfpl.net/txt/copying/
; Changelog ....: ??? - v0.1 - First version. Added Ctrl-I, Ctrl-B
; ..............: ??? - v0.2 - Broke lots of things, and "fixed" them
; ..............: ??? - v0.3 - Broke lots of things, and "fixed" them... again. Added Ctrl-A
; ..............: ??? - v0.4 - Broke lots of things, and "fixed" them... again  
; ..............: 5/23/2023 - v0.5 - Fixed issue where Ctrl-A didn't work in the Equipment Section.
; ----------------------------------------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Manager Enter
; Description ..: Hotkeys (shortcuts) sending {Enter} in leu of "Double Click"
; Author .......: Overcast (Adam Bacon), Descolada
; ----------------------------------------------------------------------------------------------------------------------
#If WinActive("ahk_exe hznhorizonmgr.exe") or WinActive("ahk_exe hznhorizon.exe")
{
	ControlGetFocus, hCtl, A
	ControlGet, Ctl, hWnd,,% hCtl, A
	Shift & Enter::DllCall("SendMessage", Ptr, Ctl, UInt,0x0203,Ptr, 0, Ptr, 0)
}
return
#If
; ----------------------------------------------------------------------------------------------------------------------
; Hotkey .....: I don't remember why I put this here (AJB 5/2023)
; ----------------------------------------------------------------------------------------------------------------------
#IfWinActive ahk_exe Hznhorizon.exe
if ErrorLevel  ; ClipWait timed out.
	return
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Button - Italics (Ctrl-I)
; ----------------------------------------------------------------------------------------------------------------------

^i::
ci:
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

^b::
cb:
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
; Function .....: Horizon Button - Underline (Ctrl-U) [Where Applicable]
; ----------------------------------------------------------------------------------------------------------------------

^u::
cu:
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,3)
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkey - Select-All (Ctrl-A)
; ----------------------------------------------------------------------------------------------------------------------

^a::
ca:
ControlGetFocus, hCtl, A
ControlGet, Ctl, hWnd,,% hCtl, A
hWndChild := DllCall("RealChildWindowFromPoint", Ptr,Ctl, UInt,, Ptr)
WinGetClass, vCtl, % "ahk_id " hWndChild
If (vCtl = "ThunderRT6TextBox"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}
If (vCtl = "TX11"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}else {
	;PostMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	;SendMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1, Ptr, 0, Ptr, -1) 	; works in eqpt
}
;reload
return
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: MakeOSItalic()
; Description ..: Associated Press (AP), and Brand Assurance (BA) approved Operating Starndard (OS) citing method.
; ..............: Italicize the OS title.
; Author .......: Terry Keatts, Overcast (Adam Bacon)
; ToDo .........: Test/Fix Make_Window_Groups
; ----------------------------------------------------------------------------------------------------------------------
MakeOSItalic(OSTitle)
{
	
	WinGet,  a_process,  ProcessName, A
	;	Msgbox % a_process ; Pops a message box so I know the process name to add to the logic below.
	
	If(a_process = "notepad.exe" or a_process = "notepad++.exe" or a_process = "AutoHotkeyU32.exe") ; Don't do italics in plain text editors
	{
		SendLevel 1
		IniRead, OST, OSTitle.ini,% OSTitle, Title
		;IniRead, OSNT, OSTitle.ini,OS, %OSTitle%
		Clipboard:=% ", " OST
		Send ^v
		Send, {Space}
		return
	}
	
	If(a_process = "hznhorizon.exe") ; Do Italic Font Specific to Horizon
	{
		SendLevel 1
		IniRead, OSN, OSTitle.ini,% OSTitle, OS
		Sleep 200
		Clipboard:= % OSN
		ClipWait 1
		Send ^v
		Send {Space}
		Clipboard:=""
		IniRead, OST, OSTitle.ini,% OSTitle, Title
		sleep 100
		Send ^i
		;gosub ci
		sleep 100
		Clipboard:= % OST
		ClipWait 1
		Send ^v
		sleep 100
		Send ^i
		;gosub ci
		Sleep 100
		Send, {Space}
		return
	}
	
	Else
	{
		SendLevel 1
		IniRead, OSN, OSTitle.ini,% OSTitle, OS
		Sleep 100
		Clipboard:= % OSN
		ClipWait 1
		Send ^v
		Send {Space}
		Clipboard:=""
		IniRead, OST, OSTitle.ini,% OSTitle, Title
		sleep 100
		Send ^i
		sleep 100
		Clipboard:= % OST
		ClipWait 1
		Send ^v
		sleep 100
		Send ^i
		Sleep 100
		Send, {Space}
		return
	}
	Clipboard:=""
	return
}


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
		DllCall("CloseHandle", "Ptr", hProcess)
		; get the bounding rectangle for the specified button
		X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
		ControlClick, % "x" (X+W//2) " y" (Y+H//2), ahk_id %hWndToolbar%,,,, NA
		SetControlDelay, %prevDelay%
	} else {
		MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
	}
	return
}
reload ; make sure you reload or it... does weird stuff
#IfWinActive
	
make_editor_groups()
{
	;-------- advanced_editors ----------
	GroupAdd, advanced_editors, ahk_exe WindowsTerminal.exe
	GroupAdd, advanced_editors, ahk_exe Code.exe
	;-------- basic_editors ----------
	GroupAdd, basic_editors, ahk_exe notepad.exe
	GroupAdd, basic_editors, ahk_exe notepad++.exe
	GroupAdd, basic_editors, ahk_exe AutoHotkeyU32.exe
	GroupAdd, basic_editors, ahk_exe AutoHotkeyU64.exe
	GroupAdd, basic_editors, ahk_exe AutoHotkey.exe
	;-------- AHK Variations ----------
	GroupAdd, ahk_editors, ahk_exe AutoHotkeyU32.exe
	GroupAdd, ahk_editors, ahk_exe AutoHotkeyU64.exe
	GroupAdd, ahk_editors, ahk_exe AutoHotkey.exe
	
	;-------- report_editors ----------
	GroupAdd, report_editors, ahk_exe hznhorizon.exe
}