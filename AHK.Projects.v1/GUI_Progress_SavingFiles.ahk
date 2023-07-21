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
;============================== Main Script ==============================
;Import/Export AHK ImageList Content possible?
;https://www.autohotkey.com/board/topic/54607-importexport-ahk-imagelist-content-possible/

Gui, New,,Save
Gui, Color, White
;Gui, Add, Picture, x0 y0 h350 w450 ;, %A_WinDir%\system32\ntimage.gif
Gui, Add, Button, hidden Default, Start the Bar Moving
Gui, Add, Progress, vMyProgress w300
Gui, Add, Text, vMyText wp  ; wp means "use width of previous".
Gui, Show, AutoSize
Send {Enter}
;Gui, Hide
return

ButtonStartTheBarMoving:
Loop, Files, C:\AHK-Studio\AHK-Projects\*.*, R
{
	if (A_Index > 100)
		break
	GuiControl,, MyProgress, %A_Index%
	GuiControl,, MyText, %A_LoopFileName%
	;Gui, Add, Picture, Icon, % "HBITMAP:%handle%"
	Sleep 20
}
GuiControl,, MyText, Save Complete.
Sleep 500
Gui, Destroy
ExitApp
return
;============================== End Script ==============================