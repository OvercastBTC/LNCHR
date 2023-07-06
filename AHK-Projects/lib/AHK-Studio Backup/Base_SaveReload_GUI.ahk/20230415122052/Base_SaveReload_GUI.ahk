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
;============================== Group Section ==============================
;GroupAdd, saveReload, %A_ScriptName%
;GroupAdd, AllWindows,,,,hznhorizon.exe
;GroupAdd, horizon, hznhorizon.exe

;============+++++++++++++================== Main Script =====================================

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
/*
	*Start Variables
	*Global theme:= "+Border -SysMenu" ;+Resize  +Theme
	*Global OnTop:= "+AlwaysOnTop"
	*Global NotOnTop:= "-AlwaysOnTop"
	*Global root:= "C:\AHK-Studio\"
	*Global OneDrive:= "C:\Users\bacona\OneDrive - FM Global\"
	*Global teams:= "General - AutoHotKey User Group\"
	*Global t_script:= "Adams Buggy Betas\"
	*Global root_RSS:= "3. AHK\"
	
	/*
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
*/
; ahk-Sushi: Anime Icon + Progressbar in Statusbar
; (w) Nov 2008 by DerRaphael(at)oleco.net
; modified for SB_SetProgress demonstration
text:= LoopFile_Script(%root%, %fileList%)
gui,add,text,w180 center y10,%text%
; gui,add,button,x+10 yp-3 w90 gRestart vR_Btn1 default, Restart!
Gui,add,statusbar, hwndhwndBar
; gui,show,w300,[ahksushi] Statusbar Demo
gui,show,AutoSize,Saving

SB_SetParts(20,200,100)
SB_SetText("demotext",2)
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
	ReloadAllAhkScripts()
} else  ; update Text
	SB_SetText("`tLala lala la: " pp " %",2,0)
Return

Prep_Animation:
; Prepare Animation - Load 4 Icons and make their handle available
hInst := DllCall("GetModuleHandle", "str", "shell32.dll")
Loop,4
	hI%A_index% := DllCall("LoadImage", "Uint", hInst, "Uint", 3+A_index, "Uint", 1
                        , "int", 16, "int", 16, "Uint", 0x8000)
Return

;GuiEscape:
;GuiClose:
;exitapp