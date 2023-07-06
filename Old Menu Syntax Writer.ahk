;*******************************************************
; Want a clear path for learning AHK; Take a look at our AutoHotkey courses.
; They're structured in a way to make learning AHK EASY: https://the-Automator.com/Learn
;*******************************************************
#NoEnv
#SingleInstance,Force
#Requires AutoHotkey v1.1.33

#Include <ScriptObject\ScriptObject>

global script := {base         : script
                 ,name          : regexreplace(A_ScriptName, "\.\w+")
                 ,version      : "0.2.0"
                 ,author       : "Lexikos"
                 ,email        : ""
                 ,crtdate      : "June 07, 2015"
                 ,moddate      : "April 28, 2023"
                 ,homepagetext : "Alt Menu Search"
                 ,homepagelink : "https://www.autohotkey.com/boards/viewtopic.php?f=6&t=8085"
                 ,donateLink   : "https://www.paypal.com/donate?hosted_button_id=MBT5HSD9G94N6"
                 ,resfolder    : A_ScriptDir "\res"
                 ,iconfile     : A_ScriptDir "\res\sct.ico"
                 ,configfile   : A_ScriptDir "\settings.ini"
                 ,configfolder : A_ScriptDir ""}

Menu, Tray, Icon, %A_WinDir%\system32\imageres.dll,1 ;Set custom Script icon
Menu, Tray, NoStandard
Menu, Tray, Add
Menu, Tray, Add,About, ShowAbout
Menu, Tray, Add
Menu, Tray, Add,Cnt+G gets Menu,^g
Menu, Tray, Icon,Cnt+G gets Menu, %A_WinDir%\system32\imageres.dll,1 ;Set custom Script icon

Menu, Tray, Add, % AppWindow, Show
Menu, Tray, Icon, % AppWindow, imageres.dll, 23


Menu, Tray, Add, Edit, Edit
Menu, Tray, Icon, Edit , imageres.dll,290
Menu, Tray, Add, Reload, Reload
Menu, Tray, Icon, Reload, imageres.dll,239
Menu, Tray, Add, Exit, Exit
Menu, Tray, Icon,Exit, %A_WinDir%\system32\imageres.dll,85 ;Set custom Script icon

;~ Menu,%scriptName%, Icon, % "Open Script Folder", shell32.dll ,4
;~ Menu,%scriptName%, Icon, % "Reload" , shell32.dll ,239

SetBatchLines -1
OnMessage(0x100, "GuiKeyDown")
; OnMessage(0x6, "GuiActivate")
return

^g:: ;Control+G will get the menu items
;if !WinHasMenu("A")
;{
    ;MsgBox % "This window does not have a Win32 Menu"
    ;return
;}
Gui +LastFoundExist
if WinActive()
	goto GuiEscape

GuiControlGet Version
if !Version
    IniRead, Version, % script.configfile, general, lastVersion, 1

Gui Destroy
Gui Font, s11
Gui Margin, 5,5
Gui Add, Edit, w500 vQuery gType
;~ Gui Add, Text, x5 y+2 w15, 1`n2`n3`n4`n5`n6`n7`n8`n9
;~ Gui Add, ListBox, x+0 yp-2 w500 r21 vCommand gSelect AltSubmit
Gui Add, ListBox, y+2 w500 r21 vCommand gSelect AltSubmit


oldv1Sel := Version = 1
oldv2Sel := Version = 0
Gui, Add, Radio, vVersion Checked%oldv1Sel% AltSubmit gSaveVersion, v1 Code
Gui, Add, Radio, x+m Checked%oldv2Sel% gSaveVersion, v2 Code
Gui Add, StatusBar
Gui +Resize +MinSize +MinSize200x +MaxSize +MaxSize%A_ScreenWidth%x
window := WinExist("A")
WinGetTitle, winTitle, ahk_id %window%

cmds := MenuGetAll(window)
gosub Type
WinGetTitle title, ahk_id %window%
title := RegExReplace(title, ".* - ")
Gui Show,, Searching menus of:  %title%
GuiControl Focus, Query
return

ShowAbout:
script.about()
Return

SaveVersion:
GuiControlGet Version
IniWrite, %Version%, % script.configfile, general, lastVersion
Return

Type:
SetTimer Refresh, -10
return

Refresh:
GuiControlGet Query
r := cmds
if (Query != ""){
    StringSplit q, Query, %A_Space%
    Loop % q0
	r := Filter(r, q%A_Index%, c)
}
rows := "", row_id := []

Loop Parse, r, `n
{
    RegExMatch(A_LoopField, "(\d+)`t(.*)", m)
    row_id[A_Index] := m1
    rows .= "|"  m2
    jRow.=m1 a_tab m2 "`n"  ;My own parsing
}
GuiControl,, Command, % rows ? rows : "|"
if (Query = "")
	c := row_id.MaxIndex()

Select:
GuiControlGet Command
GuiControlGet Version

path := StrSplit(rows, "|")[Command+1]
if !Command
	Command := 1
Command := row_id[Command]
SB_SetText("Total " c " results`t`tID: " Command)
if (A_GuiEvent != "DoubleClick")
	return

Confirm:
if GetKeyState("Ctrl"){
	WinActivate ahk_id %window%
	DllCall("SendMessage", "ptr", window, "uint", 0x111, "ptr", Command, "ptr", 0)
	gosub GuiEscape
}

gosub CopyCommand
Tooltip % "Syntax copied to the clipboard"
sleep 2000
ToolTip
return


GuiEscape:
Gui Destroy
cmds := r := ""
return

GuiSize:
GuiControl Move, Query, % "w" A_GuiWidth-20
GuiControl Move, Command, % "w" A_GuiWidth-20
return

GuiActivate(wParam){
    if (A_Gui && wParam = 0)
	SetTimer GuiEscape, -5
}

GuiKeyDown(wParam, lParam){
	if !A_Gui
		return
	if (wParam = GetKeyVK("Enter")){
		gosub Confirm
		return 0
	}
	if (wParam = GetKeyVK(key := "Down")|| wParam = GetKeyVK(key := "Up")){
		GuiControlGet focus, FocusV
		if (focus != "Command"){
			GuiControl Focus, Command
			if (key = "Up")
				Send {End}
			else
				Send {Home}
			return 0
		}
		return
	}
	if (wParam >= 49 && wParam <= 57 && !GetKeyState("Shift")) {
		SendMessage 0x18E,,, ListBox1
		GuiControl Choose, Command, % wParam-48 + ErrorLevel
		GuiControl Focus, Command
		gosub Select
		return 0
	}
	if (wParam = GetKeyVK(key := "PgUp")|| wParam = GetKeyVK(key := "PgDn")){
		GuiControl Focus, Command
		Send {%key%}
		return
	}
}

CopyCommand:
template := "PostMessage 0x111, {1}, 0,, {2} ""ahk_id"" WinExist(""{3}"") `; Runs --> {4}"
clipboard := Format(template, command, (Version = 1 ? "% " : ""), WinTitle, path)
return

Filter(s, q, ByRef count){
    if (q = ""){
	StringReplace s, s, `n, `n, UseErrorLevel
	count := ErrorLevel
	return s
    }
    i := 1, match := "", result := "", count := 0
    while i := RegExMatch(s, "`ami)^.*\Q" q "\E.*$", match, i + StrLen(match)){
	result .= match "`n"
	count += 1
    }
    return SubStr(result, 1, -1)
}

MenuGetAll(hwnd){
    if !menu := DllCall("GetMenu", "ptr", hwnd, "ptr")
	return ""
    MenuGetAll_sub(menu, "", cmds)
    return cmds
}

MenuGetAll_sub(menu, prefix, ByRef cmds){
	Loop % DllCall("GetMenuItemCount", "ptr", menu){
		VarSetCapacity(itemString, 2000)
		if !DllCall("GetMenuString", "ptr", menu, "int", A_Index-1, "str", itemString, "int", 1000, "uint", 0x400)
			continue
		itemString := StrReplace(itemString, "&")
		itemID := DllCall("GetMenuItemID", "ptr", menu, "int", A_Index-1)
		if (itemID = -1)
			if subMenu := DllCall("GetSubMenu", "ptr", menu, "int", A_Index-1, "ptr"){
				MenuGetAll_sub(subMenu, prefix itemString " > ", cmds)
				continue
			}
		cmds .= itemID "`t" prefix RegExReplace(itemString, "`t.*") "`n"
	}
}

WinHasMenu(WinTitle:="") {
    return !!DllCall("GetMenu", "ptr", WinExist(WinTitle), "ptr")
}



;********************Adding back some options***********************************
Reload:
Reload
return

Exit:
ExitApp
return

Edit:
Edit
return