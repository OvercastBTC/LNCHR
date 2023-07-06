;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#NoTrayIcon
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
; Function .....: Horizon Buttons
; Description ..: Hotkeys (shortcuts) for Italics, Bold, Underline, and Select-All
; Author .......: Overcast (Adam Bacon), Descolada
; ----------------------------------------------------------------------------------------------------------------------

#IfWinActive ahk_exe hznhorizon.exe

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
return
; ----------- end of horizon buttons -----------

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Make_Window_Groups()
; Description ..: Create editor groups to differentiate a function call for MakeOSItalic()
; Author .......: GroggtOtter, Overcast (Adam Bacon)
; ToDo .........: Test
; ----------------------------------------------------------------------------------------------------------------------

;Use an #If directive with a Window group.

#Requires AutoHotkey 1.1+
;#SingleInstance Force
;#Warn

make_editor_groups()
Return

#If WinActive("ahk_group advanced_editors")
return
#If WinActive("ahk_group basic_editors")
MakeOSItalic(OSTitle)
{
	Send % OSTitle	
return
#If WinActive("ahk_group report_editors")
MakeOSItalic(OSTitle)
{
	OSSplit := StrSplit(OSTitle,",",,2)
	Send % OSSplit[1] ","
	WinGet, process, ProcessName, A
	If (process = "hznhorizon.exe"){
		Gosub, ci
		Send % OSSplit[2]
		Gosub, ci
	} else {
		SendLevel, 1
		Send ^i
		Send % OSSplit[2]
		send ^i
	}	
}
return
#If

make_editor_groups() {
   GroupAdd, advanced_editors, ahk_exe WindowsTerminal.exe
   GroupAdd, advanced_editors, ahk_exe Code.exe
   GroupAdd, basic_editors, ahk_exe notepad.exe
   GroupAdd, basic_editors, ahk_exe notepad++.exe
   GroupAdd, report_editors, ahk_exe hznhorizon.exe
}

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: MakeOSItalic()
; Description ..: Associated Press (AP), and Brand Assurance (BA) approved Operating Starndard (OS) citing method.
; ..............: Italicize the OS title.
; Author .......: Terry Keatts, Overcast (Adam Bacon)
; ToDo .........: Test the above editor function
; ----------------------------------------------------------------------------------------------------------------------

MakeOSItalic(OSTitle)
{
	OSSplit := StrSplit(OSTitle,",",,2)
	Send % OSSplit[1] ","
	WinGet, process, ProcessName, A
	If (process = "hznhorizon.exe"){
		Gosub, ci
		Send % OSSplit[2]
		Gosub, ci
	} else {
		SendLevel, 1
		Send ^i
		Send % OSSplit[2]
		send ^i
	}	
}
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