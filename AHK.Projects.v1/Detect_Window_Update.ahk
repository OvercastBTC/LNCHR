;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
;#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
;SetWinDelay, -1
;SetControlDelay, -1
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;============================== End Auto-Execution Section ==============================
/*
~LAlt:: ; update the current active window if Alt-Tab is used
state_alt:= GetKeyState("LAlt")
GetKeyState("LAlt")

state_tab:= GetKeyState("Tab")
GetKeyState("LAlt" and "Tab")
if (state_alt = "T")
	Loop
	{
	Sleep, 10
	if !GetKeyState("LAlt", "P") ; The key has been released, so break out of the loop.
		break
	if GetKeyState("LAlt", "T")
		GetKeyState("Tab")
			if !GetKeyState("Tab", "P")
				Gosub, Update_Window_1
			break
	If GetKeyState("Tab", "T")
		Gosub, Update_Window_1
	return
}
Sleep 2250
SplashTextOff
return

~LButton::
state:= GetKeyState("LButton")
GetKeyState("LButton")
;SplashTextOn, 100, 50,, % state
if (state = "T")
	Loop
	{
		Sleep, 10
		if GetKeyState("LButton", "T")
			Gosub, Update_Window_1
		Sleep, 10
		if !GetKeyState("LButton", "P") ; The key has been release, so break out of the loop.
			break
		
		return
}
Sleep 2250
SplashTextOff
return

^+!0::
Update_Window_1:
DetectHiddenWindows, On								; https://autohotkey.com/docs/commands/DetectHiddenWindows.htm
;SetTitleMatchMode,	Slow								; https://autohotkey.com/docs/commands/SetTitleMatchMode.htm
WinGet, Current_Window,ID,A							; https://autohotkey.com/docs/commands/WinGet.htm
;WinGet, Current_Window,ProcessName,A					; https://autohotkey.com/docs/commands/WinGet.htm
;WinGet, Current_Window,PID,A							; https://autohotkey.com/docs/commands/WinGet.htm
;WinGetClass,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetClass.htm
;WinGetText,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetText.htm
;WinGetTitle,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetTitle.htm
;MsgBox % Current_Window
;WinGet, Current_Window, ControlList, ahk_id %Window%
ToolTip,% Current_Window "`n" Last_Window "`n" Old_Window, x+w,0+h
SetTimer, RemoveToolTip, -500

;Current_Window = a_process

If(state_alt = "T"){
	SplashTextOn, 200, 100,, % "1=On/Down`n "state_alt "LAlt is On `n" "The active process is: " a_process
}else{
	return
}
If(state = "T"){
	SplashTextOn, 200, 100,, % "1=On/Down`n "state "LAlt is On `n" "The active process is: " a_process
}else{
	return
}	

if(Current_Window!=Last_Window)
	Old_Window:=Last_Window,Last_Window:=Current_Window
return

RemoveToolTip:
ToolTip
return

