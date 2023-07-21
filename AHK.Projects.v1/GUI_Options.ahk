;============================== Start Auto-Execution Section ==============================
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
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
Gui,+AlwaysOnTop -Caption +Border
Gui,Color,Black
Gui,1:Font,s10 Q4, Segoe UI Black
Gui,Add,Progress,x0 y0 w240 h2 BackgroundYellow 
Gui,Add,Progress,x0 y123 w240 h2 BackgroundYellow 
Gui,Add,Progress,x0 y0 w2 h125 BackgroundYellow 
Gui,Add,Progress,x238 y0 w2 h125 BackgroundYellow 
Gui,Add,Text,cAqua x5 y2 w30 h20 Border Center gTag,HB
Gui,1:Font,s10 Underline Q4, Segoe UI Black
Gui,Add,Text,cYellow x60 y2 w120 h20 Border Center gMove_window,Move Window
Gui,1:Font,
Gui,1:Font,s10 Q4, Segoe UI Black
Gui,Add,Text,cRed x+16 y2 w20 h20 Border Center gMin_window,-
Gui,Add,Text,cRed x+0 y2 w20 h20 Border Center gGuiClose,x
Gui,Add,Checkbox,cLime x10 y+7 Checked vAlways gAOT,AlwaysOnTop
Gui,Add,Button,x10 y+7 w220 gSet_Next_On_Top -Theme,Set Next Win On Top
Gui,Add,Button,x10 y+7 w220 gSet_Last_On_Top -Theme,Set Last Win On Top
Gui,Show,w240 h125,Random Gui
Gui,Submit,NoHide
SetTimer,Update_Window,100

return
*/
;GuiClose:
;	ExitApp

Min_Window:
Gui,Minimize
return

Move_Window:
PostMessage,0xA1,2
return

Tag:
TrayTip,,Adam Bacon and Terry Keatts were here!,2
return

AOT:
if(Always:=!Always)
	Gui,+AlwaysOnTop
else
	Gui,-AlwaysOnTop
return

Uncheck:
Control, Uncheck,,Always, A
return

Set_Next_On_Top:
While(!GetKeyState("ctrl"))
	Tooltip, Activate the window to set on top and then press "ctrl"
Tooltip,
Winset,AlwaysOnTop,Toggle,A
return

Set_Last_On_Top:
WinSet,AlwaysOnTop,Toggle,ahk_id %Old_Window%
return

/*
Set_Current:
Winset,AlwaysOnTop,Toggle,A
return
*/

Update_Window:
DetectHiddenWindows, On								; https://autohotkey.com/docs/commands/DetectHiddenWindows.htm
;SetTitleMatchMode,									; https://autohotkey.com/docs/commands/SetTitleMatchMode.htm
WinGet, Current_Window,ID,A							; https://autohotkey.com/docs/commands/WinGet.htm
WinGet, Current_Window,ProcessName,A					; https://autohotkey.com/docs/commands/WinGet.htm
WinGet, Current_Window,PID,A							; https://autohotkey.com/docs/commands/WinGet.htm
WinGetClass,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetClass.htm
WinGetText,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetText.htm
WinGetTitle,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetTitle.htm

ToolTip,% Current_Window "`n" Last_Window "`n" Old_Window

if(Current_Window!=Last_Window)
	Old_Window:=Last_Window,Last_Window:=Current_Window
return


;*^ESC::ExitApp
