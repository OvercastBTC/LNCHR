;============================== Start Auto-Execution Section ==============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;============================== End Auto-Execution Section ==============================


Gui +LastFound
DllCall("RegisterShellHookWindow", UInt, WinExist())
OnMessage(DllCall("RegisterWindowMessage", Str, "SHELLHOOK"), "WinActiveChange")

WinActiveChange(wParam, hwnd) {
	static HSHELL_RUDEAPPACTIVATED := 32772
	
	if (wParam != HSHELL_RUDEAPPACTIVATED) ; only listen for HSHELL_RUDEAPPACTIVATED
		return
	
	WinGet,  a_process,  ProcessName,  A
	Tooltip % a_process, xm, ys
}