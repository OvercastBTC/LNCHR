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

splitPath, A_ScriptFullPath, , , A_ThisScript_ext, script_name
Title:= "WindowProbe"
num:=55
wt:= DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
WatchCursor:
CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
MouseGetPos,x,y , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ControlGetFocus, ActiveWin, A
ControlGet, List,List,,%wt%
ControlGet, Checked,Checked,,%wt%
ControlGet, Enabled,Enabled,,%wt%
ControlGet, Visible,Visible,,%wt%
ControlGet, Tab,Tab,,%wt%
ControlGet, FindString,FindString,*,%wt%
ControlGet, Choice,Choice,,%wt%
ControlGet, LineCount,LineCount,,%wt%
ControlGet, CurrentLine,CurrentLine,,%wt%
ControlGet, CurrentCol,CurrentCol,,%wt%
ControlGet, Line,Line,*,%wt%
ControlGet, Selected,Selected,,%wt%
ControlGet, Style,Style,,%wt%
ControlGet, ExStyle,ExStyle,,%wt%
ControlGet, Hwnd,Hwnd,,%wt%
;ToolTip, CH: %CursorHwnd%`nList: %List%Checked: %Checked%`nEnabled:%Enabled%`nVisible: %Visible%`nTab: %Tab%`n`nFindString: %FindString%`nChoice: %Choice%`nLineCount: %LineCount%`nCurrentLine: %CurrentLine%`nCurrentCol: %CurrentCol%`nLine: %Line%`nSelected: %Selected%`nStyle: %Style%`nExStyle: %ExStyle%`nHwnd: %Hwnd%`nx: %x%`ny: %y%`nUnique ID: ahk_id %id%`nTitle: %title%`nClass: ahk_class %class%`nControl: %control%`nActive Control: %ActiveWin%`nList: %List%`nChecked: %Checked%`nEnabled:%Enabled%`nVisible: %Visible%`nTab: %Tab%`n`nFindString: %FindString%`nChoice: %Choice%`nLineCount: %LineCount%`nCurrentLine: %CurrentLine%`nCurrentCol: %CurrentCol%`nLine: %Line%`nSelected: %Selected%`nStyle: %Style%`nExStyle: %ExStyle%`nHwnd: %Hwnd%`nx: %x%`ny: %y%`nCTRL+WIN+T to Toggle On and Off`nCTRL+F12 to Copy to Clipboard
ToolTip, Unique ID: ahk_id %id%`nClass: ahk_class %class%`nControl: %control%`nActive Control: %ActiveWin%`nCH: %CursorHwnd% `nTitle: %Title% `nCTRL+WIN+T to Toggle On and Off`nCTRL+F12 to Copy to Clipboard, ,0,% num
;[Original]
;ToolTip, Unique ID: ahk_id %id%`nTitle: %title%`nClass: ahk_class %class%`nControl: %control%`nActive Control: %ActiveWin%`nx: %x%`ny: %y%`nCH: %CursorHwnd%`nList: %List%`nChecked: %Checked%`nEnabled:%Enabled%`nVisible: %Visible%`nTab: %Tab%`n`nFindString: %FindString%`nChoice: %Choice%`nLineCount: %LineCount%`nCurrentLine: %CurrentLine%`nCurrentCol: %CurrentCol%`nLine: %Line%`nSelected: %Selected%`nStyle: %Style%`nExStyle: %ExStyle%`nHwnd: %Hwnd%`nCTRL+WIN+T to Toggle On and Off`nCTRL+F12 to Copy to Clipboard

return
#IfWinActive WindowProbe
C::LV_Delete()
E:: edit
P::
Pause :=! Pause, WinTitle := ( Pause = 0 ? Title : Title . " (Paused)" )
WinSetTitle %WinTitle%

R::Reload
X::ExitApp	
#c::ClipBoard := "Unique ID: ahk_id " . id . Chr(13) . Chr(10) . "Title: " . title . Chr(13) . Chr(10) . "Class: ahk_class" .  class . Chr(13) . Chr(10) . "Control: " . control . Chr(13) . Chr(10) . "Active Control: " . ActiveWinReturn
return
#IfWinActive
#IfWinActive
/*MouseGetPos, CursorX, CursorY, Window, ClassNN, 3								;https://www.autohotkey.com/docs/v1/lib/MouseGetPos.htm
	WinGetTitle, Title, ahk_id %Window%
	WinGetClass, ahk_class, ahk_id %Window%
	DetectHiddenText, On
	WinGetText, WindowText, ahk_id %Window%
	WinGet, WindowPID, PID, ahk_id %Window%
	WinGet, ControlText, ControlList, ahk_id %Window%
	CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
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
*/