;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"

; ahk-Sushi: Anime Icon + Progressbar in Statusbar
; (w) Nov 2008 by DerRaphael(at)oleco.net
; modified for SB_SetProgress demonstration
;text:= LoopFile_Script(%root%, %fileList%)
gui,add,text,w180 center y10,%text%
; gui,add,button,x+10 yp-3 w90 gRestart vR_Btn1 default, Restart!
Gui,add,statusbar, hwndhwndBar
gui,show,w300,Saving...
;gui,show,AutoSize,Saving

SB_SetParts(20,200,100)
SB_SetText(%text%,2)
hIS     := SB_SetIcon(A_AhkPath,1,1)
hwnd := SB_SetProgress(50,3,"BackgroundGreen cLime")
Gosub, Prep_Animation

Restart:
SB_SetProgress(0,3,"show")
GuiControl,Disable,R_Btn1
Gui,+LastFound
ControlFocus
pp := 0
SetTimer,ProgressAnimation,50
return

ProgressAnimation:
SB_SetProgress(++pp,3)
R := mod(pp,8)//2+1
SendMessage, 0x40F, 0, hI%R%,, ahk_id %hwndBar%     ; SB_SETICON := (WM_USER:=0x400) + 15 - icon animation!
if (pp=100) {
	SendMessage, 0x40F, 0, hIS,, ahk_id %hwndBar%    ; StandardIcon hIS
	SB_SetText("`tEat mo' sushi!",2,0)               ; update Text
	SetTimer,ProgressAnimation,Off                   ; Timer OFF
	GuiControl,Enable,R_Btn1
	SB_SetText("`tDone!",3,0)                        ; update Text
	SB_SetProgress(0,3,"hide")                       ; hide the progress
	
} else  ; update Text
	;SB_SetText("`tLala lala la: " pp " %",2,0)
	SB_SetText(%text% pp " %",2,0)
Return

Prep_Animation:
; Prepare Animation - Load 4 Icons and make their handle available
hInst := DllCall("GetModuleHandle", "str", "shell32.dll")
Loop,4
	hI%A_index% := DllCall("LoadImage", "Uint", hInst, "Uint", 3+A_index, "Uint", 1
                        , "int", 16, "int", 16, "Uint", 0x8000)
;Return

;GuiEscape:
;GuiClose:
exitapp