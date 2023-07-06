;============================== Start Auto-Execution Section ==============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization)()-1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;============================== Begin Script ==============================
EnvGet, vUserProfile, USERPROFILE
EnvGet, vHomeDrive, HOMEDRIVE
EnvGet, vHomePath, HOMEPATH
;MsgBox HP: %vHomePath%`rHD: %vHomeDrive%`rUP: %vUserProfile%
^+!#i:
FileType:= ""
IniRead, FileType, WM_LIST.ini, WM_LIST, ALL
; This script compares a string's words to array elements
;#Requires AutoHotkey v1.1.33
WinGet, aCtrls, ControlList, A
;MsgBox % aCtrls
str  := % FileType
MsgBox % str

;arr := ["msvb_lib_toolbar", "msvb_lib_toolbar1","msvb_lib_toolbar2", "msvb_lib_toolbar3", "msvb_lib_toolbar4", "msvb_lib_toolbar5"]
;RegExMatch(str,"i)(msvb_lib_toolbar([0-9]?))",arr) ; this provides at least one match (on HE page, so only one)
;RegExMatch(str,"msvb_lib_toolbar",arr)
MsgBox % "Array: `n" arr "`n"
;arr  := RegExMatch(str,"^msvb_lib_toolbar(.*)")
list := ""
For each, item in m := match(str, arr)
	StrSplit(m,:=,:=)
	

match(str, arr*) { ; Return array of matches
	match := []
	For each, item in list
		RegExMatch(str, "i)\b" word "\b") && match.Push(word)
		MsgBox % match
	return match
}
return
directory:= "C:\AHK-Studio\AHK-Projects\" ; Directory containing files or specific type of Files

; Collect the files in an array and sort them alphabetically
files:= []

Loop, Parse, %FileType%, `n`r
{
    DateModified:= A_LoopFileTimeModified
    FormatTime, DateModified, %DateModified%, yyyy/MM/dd (HH:mm:ss)
    files[A_Index]:= [A_LoopFileName, A_LoopFileSizeKB, DateModified] ; A_LoopFileSize is in bytes, you can use A_LoopFileSizeKB, A_LoopFileSizeMB or convert it yourself
    DateModified:= ""
}
; Create a GUI displaying the sorted list of files/folders
Gui, MyGui: New,, File Search in a Folder
Gui, MyGui: Add, ListView, r20 w500 gClickableName, Command|Code
Gui, MyGui: Add, Text, Section xm+100,Select file then click Ok or hit Enter(Return):
Gui, MyGui: Add, Button, w50 Section xm gSelectButton, Ok
;Gui, MyGui: Add, Edit, vFileType, *.ini
Gui, MyGui: Add, Button,w50 x+400 gExitButton, Exit
Gui, MyGui: Default ;this is the magic line that tells ahk which gui any LV controls should use

;GuiControlGet, FileType,, FileType

; Add the sorted files/folders to the ListView
for index, items in files
	LV_Add("", file.1, file.2, file.3)
LV_ModifyCol(1, 200)
LV_ModifyCol(2, "100 Integer")
Gui, MyGui: Show, AutoSize
Return

ExitButton:
Gui, MyGui: Destroy
ExitApp
return

#If WinActive("File Search")
Enter::
ClickableName:
if (A_GuiEvent = "DoubleClick") {
	Sleep 100
	GuiControlGet, Selection,, HelloButton
	ToolTip, % Selection
}
SelectButton:
Gui, MyGui: Default ; just to be safe we add it again before calling any more LV commands
row_num:= LV_GetNext()	; number of files in or rows of text?
outputvar:= ""	;file or folder Name
LV_GetText(outputvar, row_num)
MsgBox, %row_num% in %outputvar%
return
;Gui, MyGui: Destroy
return
;============================== End Script ==============================
; WindowListMenu.ahk
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Jack Dunning (http://www.computoredge.com)
;                              (https://jacksautohotkeyblog.wordpress.com/)
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

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
	The following lines are required for detecting the opening and closing of
	windows—plus the ShellMessage() function.
*/
#Persistent        ; Window open/close detection
Gui +LastFound        ; Window open/close detection
hWnd := WinExist()        ; Window open/close detection
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )

; To prevent Menu command errors from stopping script.
Menu, MenuName, UseErrorLevel

/*
	The following code sets up the Gui with a DropDownList with the original list of
	open windows. Remove or comment out this code for Menu only.
*/
Gui,+AlwaysOnTop
Gui, Font, s11, Calibri
Gui, Add, DropDownList, r10 w425 vWindowMove gPosChoice Sort Choose1 ; ,Pick a Window||
Menu, FileMenu, Add, &Rescan`tCtrl+R, GuiReset
Menu, MyMenuBar, Add, &File, :FileMenu
Gui, Menu, MyMenuBar

GoSub, GuiReset
Gui, Show, w500 h250
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



/*
directory := "C:\AHK-Studio\AHK-Projects\" ; Directory containing .ini files

; Collect the .ini files in an array and sort them alphabetically
files := []

Loop, files, % directory "*.ini", R
{
	DateModified := A_LoopFileTimeModified
	FormatTime, DateModified, %DateModified%, yyyy/MM/dd (HH:mm:ss)
	files[A_Index] := [A_LoopFileName, A_LoopFileSizeKB, DateModified] ; A_LoopFileSize is in bytes, you can use A_LoopFileSizeKB, A_LoopFileSizeMB or convert it yourself
	DateModified := ""
}

; Create a GUI displaying the sorted list of .ini files
Gui, MyGui:New, , List of .ini Files in a Folder (Recursive)
Gui, Add, ListView, r20 w500 gClickableName, Filename|File Size (Kb)|Last modified

Gui, Add, Button, gHelloButton, Select File
Gui, Add, Button, gExitButton, Exit

; Add the sorted .ini files to the ListView
for index, file in files
	LV_Add("", file.1, file.2, file.3)
LV_ModifyCol(1, 200)
LV_ModifyCol(2, "100 Integer")
Gui, Show, AutoSize
Return

ExitButton:
Gui, MyGui:Destroy
return

#IfWinActive List of .ini Files in a Folder (Recursive)
Enter::
If (A_GuiEvent = "Enter"){
	GuiControlGet, Selection,, HelloButton
}
return
ClickableName:

HelloButton:
zvoleny_radek:= LV_GetNext(0,"F")
kaka:= ""
LV_GetText(kaka, zvoleny_radek)
MsgBox, %zvoleny_radek% a text %kaka%
Gui, MyGui:Destroy
return
#IfWinActive
return
;============================== End Script ==============================