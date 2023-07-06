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
if ErrorLevel  ; ClipWait timed out.
	return
return

#IfWinActive ahk_exe hznhorizon.exe

; ----------- italics ----------

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

; ---------- bold ------------
^b::
cb:
SendLevel, 1
SetKeyDelay,100,10
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

; ---------- underline ---------
^u::
cu:
SendLevel, 1
SetKeyDelay,100,10
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


; ----------- select-all -----------
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
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) 				; does not work in eqpt
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1, Ptr, 0, Ptr, -1) 	; works in eqpt
}
return

MakeOSItalic(OSTitle)
{
	OSSplit := StrSplit(OSTitle,",",,2)
	Send % OSSplit[1] ","
	WinGet, process, ProcessName, A
	If (process = "hznhorizon.exe"){
		SendLevel, 1
		SetKeyDelay,10,10
		Sleep 100
		Gosub, ci
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
		;HznButton(hToolbar,2)
		Sleep 100
		Send % OSSplit[2]
		Sleep 100
		Gosub, ci
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
		;HznButton(hToolbar,2)
		;ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
		;HznButton(hToolbar,2)
	} else {
		SendLevel, 1
		Send ^i
		Send % OSSplit[2]
		send ^i
	}	
}
return
;#IfWinActive

HznButton(hWndToolbar, n)
{
	static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETITEMRECT := 0x41D
	SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar%
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
		
		X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
		ControlClick, % "x" (X+W//2) " y" (Y+H//2), ahk_id %hWndToolbar%,,,, NA
		;PostMessage, 0x01 % "x" (X+W//2) " y" (Y+H//2), ahk_id %hWndToolbar%,,,, NA
		SetControlDelay, %prevDelay%
		;ToolTip % "X: " X " Y: " Y " W: " W " H: " H " #: " buttonCount
		;CoordMode, Mouse, Client ; not working
		;MouseMove, X, Y
	} else {
		MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
	}
	return
}
reload