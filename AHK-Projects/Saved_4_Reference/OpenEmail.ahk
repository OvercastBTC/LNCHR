#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
; Note: References found below
DetectHiddenText,On

^+!m::
OS_Text:= "Switchgear and Circuit Breakers"
Clipboard:= ""
;OpenEmail:
;SetTimer,Update_Window,100							; Update_Window from GUI alwaysontop w options.ahk
;Sleep, 100

Gui, Italicizer:New, -AlwaysOnTop
WinActivateBottom, Italicizer
Gui, Font, s10, TimeNewRoman
;Gui, Add, Text, w250, Text with custom font
Gui, Add, Edit, section R1 vOS_Title xm+20 -5 W250, %OS_Text%
;Gui, Add, Edit, w250, 
Gui, Add, Button, -default section gCancel x+25, Cancel
Gui, Show, AutoSize, Italicizer
;Gui, Submit,NoHide


GuiControlGet, ostitle,, OS_Title, Edit

Send ^c
ClipWait 0

Gui, Destroy

;MsgBox % Clipboard

;Gui, Submit, Hide

Run, RichEdit_Editor_1.0.ahk
WinWaitActive, AHK Rich Edit

;SetKeyDelay 50
Sleep 500
Send !i
Sleep 10
Send ^v
Sleep 10
;Send {Backspace}
Send ^a
Send ^c
ClipWait 0
ExitApp
;MsgBox % Clipboard

WinGet,  a_process,  ProcessName,  A
h_process:="hznhorizon.exe"
;SplashTextOn, 300, 300, Process,  %a_process%
;sleep,  1000
;WinMove,  Process, , 0,0 
;SetTimer,Update_Window,100

;if_a_h:
if (a_process=h_process){
	WinActivate, ahk_exe hznHorizon.exe
	Send {Tab} 
	Send ^v
} else{
	MsgBox I dont work yet
	return ;#Include oslist.ahk
}
return

;ExitApp