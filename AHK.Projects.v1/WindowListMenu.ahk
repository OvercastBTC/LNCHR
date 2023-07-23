﻿;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; #Warn  ; Enable warnings to assist with detecting common errors.
;SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing 
;SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible. ; (AJB - 05/2023)comment out for testing
;SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing 
;SetWinDelay 0
;SetControlDelay 0
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
; ----------------------------------------------------------------------------------------------------------------------
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; WindowListMenu.ahk
; AutoHotkey Version: 1.x
; Language:	English
; Platform:	Win9x/NT ; Validated on Win11
; Author:		Jack Dunning (http://www.computoredge.com)
;                              (https://jacksautohotkeyblog.wordpress.com/)
; Updates:	Overcast
; Script Function:
;	Create a menu (and Gui DropDownList) of open windows for quick activation and navigation
;

/*
	When launched WindowListMenu.ahk scans the open windows and builds an activation menu
	from that list. It includes the process ids in the menu items to ensure unique menu item
	names. Otherwise, similar menu items (e.g. multiple blank Notepad windows) would only open the topmost
	window.
	
	The app detects when new windows open and the closing of old windows, then updates the menu.
	
	The script also builds a Gui with a DropDownList similar to the original WindowList.ahk script.
	You can comment out or remove this code if not wanted.
	Use Ctrl+Alt+W, Ctrl+Win+M, or XButton2 to open menu. (You may need to assign Hotkey to XButton2
	in mouse setup app.)
	
	Use Ctrl+Win+L to open Gui Window.
	
	Click "Rescan Windows" to manually update the list. Menu appears in most-recently-used order
	from topmost down.
*/

/*
	The following lines are required for detecting the opening and closing of
	windows—plus the ShellMessage() function.
*/
;#Persistent        ; Window open/close detection
Gui +LastFound        ; Window open/close detection
hWnd := WinExist()        ; Window open/close detection
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
SplitPath, A_ScriptName, , , , MyGui
; To prevent Menu command errors from stopping script.
Menu, MenuName, UseErrorLevel

/*
	The following code sets up the Gui with a DropDownList with the original list of
	open windows. Remove or comment out this code for Menu only.
*/
Gui,+AlwaysOnTop +Resize
Gui, Font, s11, Calibri
;Gui, Add, DropDownList, r20 w400 vWindowMove gPosChoice Sort Choose1 ; ,Pick a Window||
Gui, Add, ListBox, r10 w400 vWindowMove gPosChoice Sort Choose1 ; ,Pick a Window||
Menu, FileMenu, Add, &Rescan`tCtrl+R, GuiReset
Menu, MyMenuBar, Add, &File, :FileMenu
Gui, Menu, MyMenuBar

GoSub, GuiReset
Gui, Show, w425 h250
Return

; Function ShellMessage launches reloading of window list when open/close detected.

ShellMessage( wParam,lParam ) {
	If ( wParam = 1 ) ; or ( wParam = 2 )  HSHELL_WINDOWCREATED := 1
	{
		GoSub, GuiReset
	}
}

; Subroutine scans open windows and creates a list for both the menu and Gui DropDownList.
GuiReset:

WinGet, OpenWindow, List
GuiControl,,WindowMove, |
Menu, WindowMenu, Delete
Menu, WindowMenu, Add, Rescan Windows, GuiReset
Menu, WindowMenu, Icon, Rescan Windows, C:\Windows\System32\imageres.dll, 140

Loop, %OpenWindow%
{
	WinGetTitle, Title, % "ahk_id " OpenWindow%A_Index%
	WinGetClass, Class, % "ahk_id " OpenWindow%A_Index%
	WinGet, AppName, ProcessPath, %Title%
	
	If (Title != "" and Class != "BasicWindow" and Title != "Start"
		and Title != "Program Manager")
	{
		Title := StrSplit(Title,"|")
		GuiControl,,WindowMove, % Title[1]
		Menu, WindowMenu, Insert,, % Title[1] . " |" . OpenWindow%A_Index%, MenuChoice
		Menu, WindowMenu, Icon, % Title[1] . " |" . OpenWindow%A_Index%, %AppName%
		If ErrorLevel
			Menu, WindowMenu, Icon, % Title[1] . " |" . OpenWindow%A_Index%
		, C:\WINDOWS\System32\SHELL32.dll,36
	}
}

GuiControl, Choose, WindowMove, 1
Return

; Hotkeys for displaying current menu.
XButton2::
^!W::
^#M::
Menu, WindowMenu, Show
Return

; Hotkey for showing the Gui with the DropDownList control.
^#L::
Gui, Show, W475 H250, Window List
Return

MenuChoice:

ProcessID := StrSplit(A_ThisMenuItem,"|")
WinActivate, % "ahk_id " ProcessID[2]

Return

PosChoice:
Gui, Submit, NoHide
WinActivate, %WindowMove%

; Checks for window location off screen and resets to on screen.
WinGetPos,X1,Y1,W1,H1,Program Manager
WinGetPos,X2,Y2,W2,H2,%WindowMove%
If (X2 > W1 or Y2 > H1)
	WinMove, %WindowMove%,, 20, 20
Return

#If WinActive(A_ThisLabel)
{
	GuiClose:
	Gui Destroy
	ExitApp
}
	
#If	