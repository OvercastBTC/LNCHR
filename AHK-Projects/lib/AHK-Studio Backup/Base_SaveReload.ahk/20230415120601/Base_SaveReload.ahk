;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
;SetWinDelay, -1
;SetControlDelay, -1
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;============================== Group Section ==============================
;GroupAdd, saveReload, %A_ScriptName%
;GroupAdd, AllWindows,,,,hznhorizon.exe
;GroupAdd, horizon, hznhorizon.exe

;============+++++++++++++================== Main Script ============================================

~^s::

#IfWinActive ahk_exe AutoHotkeyU32.exe
/*	
ReloadAllAhkScripts() {
	DetectHiddenWindows, On
	SetTitleMatchMode, 2
	WinGet, allAhkExe, List, ahk_class AutoHotkey
	Loop, % allAhkExe {
		hwnd := allAhkExe%A_Index%
		if (hwnd = A_ScriptHwnd)  ; ignore the current window for reloading
		{
			continue
		}
		PostMessage, 0x0111, 65303,,, % "ahk_id" . hwnd
	}
	Reload
}
*/
;============================== Reload - On Save - & Copy to AHK Teams ==============================
; https://www.autohotkey.com/boards/viewtopic.php?t=91592
;Start Variables
Global theme:= "+Border -SysMenu" ;+Resize  +Theme
Global OnTop:= "+AlwaysOnTop"
Global NotOnTop:= "-AlwaysOnTop"
Global root:= "C:\AHK-Studio\"
Global OneDrive:= "C:\Users\bacona\OneDrive - FM Global\"
Global teams:= "General - AutoHotKey User Group\"
Global t_script:= "Adams Buggy Betas\"
Global root_RSS:= "3. AHK\"

; script name and startup path
splitPath, a_ScriptFullPath, , , script_ext, script_name
global sName:= script_name
global script_full_name:= script_name "." script_ext
global startup_shortcut:= A_Startup "\" script_full_name ".lnk"
global startTime
global finishTime
IniRead, tSaved, %root%lib\LastSaved.ini, SavedVariables, LastSaved
global startTime := tSaved
global finishTime := A_Now
; A_Startup = C:\Users\<UserName>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; End Variables

; Step 1 - Read LastSaved.ini in the main lib folder), and place the date in the tSaved variable.
;IniRead, tSaved, %root%lib\LastSaved.ini, SavedVariables, LastSaved 

; Step 2 - Set tStart to "A_Now", get the difference (DeltaT), b/n now and when the file was last [saved to server].


; Step 3 - Create a "Notification" (via TrayTip) and display a saving message.
T:= finishTime - startTime
;MsgBox % T
FormatTime, tSaved, tSaved, dddd MMMM d, yyyy hh:mm:ss tt ;MM/dd/yyyy hh:mm:ss
TrayTip %sName%, Saving ...`nLast save was %tSaved% ;ago.
SetTimer, disable, -500
; Step 4 - Save "Now" as the latest value
IniWrite, %A_Now%, %root%lib\LastSaved.ini, SavedVariables, LastSaved
IniWrite, %A_Now%, %OneDrive%%teams%RSS\LastSaved.ini, SavedVariables, LastSaved


; Step 5 - Evaluate if the last time it was saved to the server is greater than x minutes
If (T > 50000){	; Step 4 - if Yes-->Save to Server
	;TrayTip %sName%, Saving to Server is in progress... Please wait.
	;countdown(SavetoServer, -1000)
	;FileCopyDir, %root%, %OneDrive%%teams%%t_script%, 1
	;FileCopyDir, %OneDrive%%root_RSS%, %OneDrive%%teams%RSS, 1
	Gosub,SavetoServer
	TrayTip %sName%, Server Save Complete. Reloading Script.
	WinActivateBottom, ahk_id New notification
	countdown(disable_enable,-100)
} else {
	TrayTip %sName%, Save Complete. Reloading Script., -1
	WinActivateBottom, ahk_id New notification
	countdown(disable_enable,-100)
}	
;countdown(disable,-100)
Reload
TrayTip off
Return
#IfWinActive

SavetoServer:
FileCopyDir, %root%, %OneDrive%%teams%%t_script%, 1
FileCopyDir, %OneDrive%%root_RSS%, %OneDrive%%teams%RSS, 1
return

timedelay:
return