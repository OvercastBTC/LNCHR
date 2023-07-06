;=======================================================================================================================
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
CoordMode, ToolTip, Screen
#Requires AutoHotkey 1.1+
;#NoTrayIcon

; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: Initiation Section
; ----------------------------------------------------------------------------------------------------------------------
global A_Process	; set a super-global variable that can be accessible within all functions by default.

Gui +LastFound
DllCall("RegisterShellHookWindow", UInt, WinExist())
;OnMessage(DllCall("RegisterWindowMessage", Str, "SHELLHOOK"), "WinActiveChange") ; original
;OnMessage(DllCall("RegisterWindowMessage", Str, "SHELLHOOK"), "WinActiveChange1")
OnMessage(DllCall("RegisterWindowMessage", Str, "SHELLHOOK"), "WinActiveChange2")
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: WinActiveChange()
; ----------------------------------------------------------------------------------------------------------------------

WinActiveChange(wParam, hwnd) {
	static HSHELL_RUDEAPPACTIVATED := 32772
	global A_Process
	
	if (wParam != HSHELL_RUDEAPPACTIVATED) ; only listen for HSHELL_RUDEAPPACTIVATED
		return
	
	WinGet,  a_process,  ProcessName,  A
	Tooltip % a_process,0,0,1
	return A_Process
}
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: WinActiveChange1()
; Description .....: removed WinGet, A_Process, ProcessName, A in place of getActiveProcessName()
; ----------------------------------------------------------------------------------------------------------------------
WinActiveChange1(wParam, hwnd) {
	static HSHELL_RUDEAPPACTIVATED := 32772
	global A_Process
	
	if (wParam != HSHELL_RUDEAPPACTIVATED) ; only listen for HSHELL_RUDEAPPACTIVATED
		return
	getActiveProcessName()
	;WinGet,  a_process,  ProcessName,  A
	Tooltip % "Original: "a_process "`npname: " getActiveProcessName(),0,0,1
	return A_Process
}
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: WinActiveChange2()
; Description .....: removed WinGet, A_Process, ProcessName, A in place of getActiveProcessName()
; ----------------------------------------------------------------------------------------------------------------------
WinActiveChange2(wParam, hwnd) {
	static HSHELL_RUDEAPPACTIVATED := 32772
	global A_Process
	
	if (wParam != HSHELL_RUDEAPPACTIVATED) ; only listen for HSHELL_RUDEAPPACTIVATED
		return
	handle := DllCall("GetForegroundWindow", "Ptr")
	DllCall("GetWindowThreadProcessId", "Int", handle, "int*", pid)
	global true_pid := pid
	callback := RegisterCallback("enumChildCallback", "Fast")
	DllCall("EnumChildWindows", "Int", handle, "ptr", callback, "int", pid)
	handle := DllCall("OpenProcess", "Int", 0x0400, "Int", 0, "Int", true_pid)
	length := 259 ;max path length in windows
	VarSetCapacity(name, length)
	DllCall("QueryFullProcessImageName", "Int", handle, "Int", 0, "Ptr", &name, "int*", length)
	DllCall("CloseHandle", "Ptr", handle) ; added => not in original script
	; name = full path
	; pname = program (.exe)
	SplitPath, name, A_Process
	Tooltip % A_Process,0,0,1 ;"`npname: " getActiveProcessName(),0,0,1
	return A_Process
}
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: getActiveProcessName()
; Description .....: maybe a better version of WinActiveChange()
; ----------------------------------------------------------------------------------------------------------------------

;#s::MsgBox % getActiveProcessName() ;example use

getActiveProcessName() {
	handle := DllCall("GetForegroundWindow", "Ptr")
	DllCall("GetWindowThreadProcessId", "Int", handle, "int*", pid)
	global true_pid := pid
	callback := RegisterCallback("enumChildCallback", "Fast")
	DllCall("EnumChildWindows", "Int", handle, "ptr", callback, "int", pid)
	handle := DllCall("OpenProcess", "Int", 0x0400, "Int", 0, "Int", true_pid)
	length := 259 ;max path length in windows
	VarSetCapacity(name, length)
	DllCall("QueryFullProcessImageName", "Int", handle, "Int", 0, "Ptr", &name, "int*", length)
	DllCall("CloseHandle", "Ptr", handle) ; added => not in original script
	; name = full path
	; pname = program (.exe)
	SplitPath, name, pname
	return pname
}

enumChildCallback(hwnd, pid) {
	DllCall("GetWindowThreadProcessId", "Int", hwnd, "int*", child_pid)
	if (child_pid != pid)
		global true_pid := child_pid
	DllCall("CloseHandle", "Ptr", hwnd) ; added => not in original script
	return 1
}
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Script Name, Startup Path, and icon
; ----------------------------------------------------------------------------------------------------------------------
ICON := % A_ScriptDir "\ICON\dllcall.ico"
splitPath, A_ScriptFullPath, , , A_Sscript_Ext, A_Script_Name
A_Script_Full_Name := A_Script_Name "." A_Script_Ext
Startup_Shortcut := A_Startup "\" A_Script_Name ".lnk"
; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu
; ----------------------------------------------------------------------------------------------------------------------

Menu, Tray, Icon, % Icon ; this changes the icon into a little dllcall thing.
Menu, Tray, NoStandard
addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
addTrayMenuOption()
addTrayMenuOption("Run at startup", "runAtStartup")
Menu, Tray, % fileExist(Startup_Shortcut) ? "check" : "unCheck", Run at startup ; update the tray menu status on startup
addTrayMenuOption()
Menu, Tray, Standard

; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu Functions
; Description .....: addTrayMenuOption() ; madeBy() ; runAtStartup() ; trayNotify()
; ----------------------------------------------------------------------------------------------------------------------

addTrayMenuOption(label = "", command = "") {
	if (label = "" && command = "") {
		Menu, Tray, Add
	} else {
		Menu, Tray, Add, % label, % command
	}
}

madeBy(){
	; visit authors website
	;Run, https://bibeka.com.np/
	MsgBox This was made by nerds, for nerds. Regular people are ok too, lol.`nModified by Adam Bacon`nCredit:Made with ❤️ by Bibek Aryal
}

runAtStartup() {
	if (FileExist(startup_shortcut)) {
		FileDelete, % startup_shortcut
		Menu, Tray, % "unCheck", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut removed", "This script will not run when you turn on your computer.")
	} else {
		FileCreateShortcut, % a_scriptFullPath, % startup_shortcut
		Menu, Tray, % "check", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut added", "This script will now automatically run when your turn on your computer.")
	}
	
}

trayNotify(title, message, seconds = "", options = 0) {
	TrayTip, %title%, %message%, %seconds%, %options%
}

; ********************************************** ... First Return ... **************************************************
return
; ********************************************** ... First Return ... **************************************************

; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: familyHasAttribue()
; Description .....: for use 
; ----------------------------------------------------------------------------------------------------------------------

familyHasAttribute(item,attrib:="Checked",subfamilies:=true,subparents:=true) {
	if (!item)
		return true
	
	nextid:=item
	
	Loop {
		if (subfamilies) {
			if (this.isparent(nextid)) {
				if (!subparents) ;if we only want the children...
					continue
				else ;if we want the parents too, then recurse...
					return (this.familyHasAttribute(this.firstchild(nextid),attrib,subfamilies,subparents))
			} else
				if (!this.hasattribute(nextid,attrib))
					return false
		} else {
			if (subparents)
				return (this.familyHasAttribute(this.firstchild(nextid),attrib,0,0)) ;check one level only
			else ;(false,false) not defined?? Im guessing it's this...
				if (!this.hasattribute(nextid,attrib))
					return false
		}
		if (!(nextid:=this.sibling(nextid)))
			break
	}
	
	return true
}
; ----------------------------------------------------------------------------------------------------------------------
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
