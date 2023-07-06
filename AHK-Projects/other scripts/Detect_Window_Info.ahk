;---------------------------------------------------------------------------
;               AutoHotkey Window Information
;---------------------------------------------------------------------------

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

; Description: Get extended attributes of window under mouse cursor
; Permalink: https://autohotkey.com/boards/viewtopic.php?f=6&t=43544
; Author: aph
; Version: 0.6
; Hotkey: Win+w
;/*
#w::
MouseGetPos, CursorX, CursorY, Window, ClassNN, 3
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
	WindowText = `n%WindowText%
WinGetText, Text, ahk_id %Window%
WinGet, ahk_exe, ProcessName, ahk_id %Window%
WinGet, Path, ProcessPath, ahk_id %Window%
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

Window Text:%WindowText%

Control Text:
%ControlText%

)
Gui, Destroy
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
Return
*/
; Idea is to send a click to the button - https://www.autohotkey.com/boards/viewtopic.php?style=7&f=76&t=4403 - might get me there
;/*
#q::													;https://www.autohotkey.com/docs/v1/lib/ControlFocus.htm
DetectHiddenWindows, On
DetectHiddenText,On
;SetControlDelay -1
ControlClick, ThunderRT6FormDC, Italic,,,, NA
; go to hznwindowclick.txt via Inspect.exe (3.AHK)
;frmPaneMgmtPolicies
;ahk_class ThunderRT6FormDC
;WinExist("A") ; Set the Last Found Window to the active window
;ControlGet, hWndControl, Hwnd,, ThunderRT6CommandButton9  ; Get HWND of first Button
;ControlSend, ThunderRT6CommandButton9,{Down}
;MsgBox,, 0x0028, hWndControl, True  ; 0x0028 is WM_NEXTDLGCTL
*/