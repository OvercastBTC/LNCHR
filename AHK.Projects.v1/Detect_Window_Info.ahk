;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; #Warn  ; Enable warnings to assist with detecting common errors.
; SetWinDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetControlDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 = max speed possible. ; (AJB - 05/2023)comment out for testing
; SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing 
; SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#Requires AutoHotkey 1.1+
;#NoTrayIcon
; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; Description: Get extended attributes of window under mouse cursor
; Permalink: https://autohotkey.com/boards/viewtopic.php?f=6&t=43544
; Author: aph
; Version: 0.6
; Hotkey: Win+o
;/*

#o::
MouseGetPos, CursorX, CursorY, Window, ClassNN
WinGetTitle, Title, ahk_id %Window%
WinGetClass, ahk_class, ahk_id %Window%
DetectHiddenText, On
WinGetText, WindowText, ahk_id %Window%
WinGet, WindowPID, PID, ahk_id %Window%
WinGet, ControlText, ControlList, ahk_id %Window%
CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
WinGet, ControlText, ControlList, ahk_id %Window%
StringReplace, ControlText, ControlText, `n or `r, `r`r, All
StringReplace, WindowText, WindowText, `n,  , All
StringReplace, WindowText, WindowText, %A_SPACE%%A_SPACE%, , All
If not (WindowText = "")
	WindowText:= % "`n" WindowText "`n"
WinGetText, Text, ahk_id %Window%
WinGet, ahk_exe, ProcessName, ahk_id %Window%
WinGet, Path, ProcessPath, ahk_id %Window%
text:= % text "`n"
UnderCursor = 
(
Title: %Title%
ahk_id = %Window%
ahk_exe = %ahk_exe%
ahk_class = %ahk_class%
Path: %Path%
Process ID: %WindowPID%
Control ClassNN: %ClassNN%
hWnd: %CursorHwnd%

Window Text:
%Text%

Control Text:
%ControlText%
)
Gui, Destroy
Gui, +Resize
SysGet, Workspace, MonitorWorkArea
Gui, Add, Text, , Ctrl+C to copy to clipboard. Repeat %A_ThisHotkey% to update.
Gui, Add, Edit, vInfo +Wrap w380, %UnderCursor%
DetectHiddenWindows, On
Gui, +LastFound +AlwaysOnTop +Owner
Gui, Show, NoActivate h255 Hide
GuiControl, Move, Info, h220
AspectRatio := WorkspaceRight/WorkSpaceBottom
GUI_ID := WinExist()
WinGetPos, GUIX, GUIY, GUIWidth, GUIHeight, ahk_id %GUI_ID%
Offset = 30 ; Change 30 to a lower to move GUI farther from bottom right
Gui, Show, % "NoActivate x"WorkspaceRight-GUIWidth-WorkspaceRight/Offset/AspectRatio " y"WorkspaceBottom-GUIHeight-WorkSpaceBottom/Offset, Window under cursor
Return
OnExit(ExitApp)