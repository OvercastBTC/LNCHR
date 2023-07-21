;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
CoordMode, ToolTip, Screen
;#NoTrayIcon

global a_process
Gui +LastFound
DllCall("RegisterShellHookWindow", UInt, WinExist())
OnMessage(DllCall("RegisterWindowMessage", Str, "SHELLHOOK"), "WinActiveChange")

WinActiveChange(wParam, hwnd) {
	static HSHELL_RUDEAPPACTIVATED := 32772
	global a_process
	
	if (wParam != HSHELL_RUDEAPPACTIVATED) ; only listen for HSHELL_RUDEAPPACTIVATED
		return
	
	WinGet,  a_process,  ProcessName,  A
	Tooltip % a_process,0,0
	return a_process
}

;============================== End Script ==============================