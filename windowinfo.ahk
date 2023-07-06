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
; Hotkey: Win+q
#k::
MouseGetPos, CursorX, CursorY, Window, ClassNN, 3								;https://www.autohotkey.com/docs/v1/lib/MouseGetPos.htm
WinGetTitle, Title, ahk_id %Window%
WinGetClass, ahk_class, ahk_id %Window%
DetectHiddenText, On
WinGetText, WindowText, ahk_id %Window%
WinGet, WindowPID, PID, ahk_id %Window%
WinGet, ControlText, ControlList, ahk_id %Window%
CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
;WinGet, List, List, ahk_id %Window%		; https://www.autohotkey.com/docs/v1/lib/ControlGet.htm#List
WinGet, List, List, ahk_id %Window%		; https://www.autohotkey.com/docs/v1/lib/ControlGet.htm#List
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
Mouse: x=%CursorX% y=%CursorY%

Window Text:%WindowText%

Control Text:
%ControlText%

Control Text List:
%list%
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

; Idea is to send a click to the button - https://www.autohotkey.com/boards/viewtopic.php?style=7&f=76&t=4403 - might get me there


^#7::
; https://www.autohotkey.com/docs/v1/lib/ControlFocus.htm
;WinExist("A") ; Set the Last Found Window to the active window
;ControlGet, hWndControl, Hwnd,, Button1  ; Get HWND of first Button
;SendMessage, 0x0028, hWndControl, True  ; 0x0028 is WM_NEXTDLGCTL
;ControlGet,count,CurrentLine,,Edit1, A
;ControlGet,text,Line,% count,Edit1, A
;ControlGet,count,CurrentCol,,Edit1, A

;RegExMatch(SubStr(text,1,count-1),"([^,，\s\.\t]*$)",str)
;RegExMatch(SubStr(text,count),"^[^,，\s,\.\t]*",string)
;word:=str string
;MsgBox % word
;return
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
MsgBox, Monitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
Loop, %MonitorCount%
{
	SysGet, MonitorName, MonitorName, %A_Index%
	SysGet, Monitor, Monitor, %A_Index%
	SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
	MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
}
return
/*
To send a message to all windows in the system, including those that are hidden or disabled, specify ahk_id 0xFFFF for WinTitle (0xFFFF is HWND_BROADCAST). This technique should be used only for messages intended to be broadcast, such as the following example:
SendMessage, 0x001A,,,, ahk_id 0xFFFF  ; 0x001A is WM_SETTINGCHANGE
To have a script receive a message, use OnMessage().
See the Message Tutorial for an introduction to using these commands.
Window titles and text are case sensitive. Hidden windows are not detected unless DetectHiddenWindows has been turned on.

Message List, Message Tutorial, OnMessage(), Automating Winamp, DllCall(), ControlSend, WinMenuSelectItem

Press a hotkey to turn off the monitor.
*/
+#o:: ; Win+O
Sleep 1000 ; Give user a chance to release keys (in case their release would wake up the monitor again).
; Turn Monitor Off:
SendMessage, 0x0112, 0xF170, 2,, Program Manager   ; 0x0112 is WM_SYSCOMMAND, 0xF170 is SC_MONITORPOWER.
; Note for the above: Use -1 in place of 2 to turn the monitor on.
; Use 1 in place of 2 to activate the monitor's low-power mode.
return
;Starts the user's chosen screen saver.
SendMessage, 0x0112, 0xF140, 0,, Program Manager  ; 0x0112 is WM_SYSCOMMAND, and 0xF140 is SC_SCREENSAVE.
;Switches the active window's keyboard layout/language to English.
PostMessage, 0x0050, 0, 0x4090409,, A  ; 0x0050 is WM_INPUTLANGCHANGEREQUEST.