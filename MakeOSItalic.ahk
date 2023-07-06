;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#NoTrayIcon
; ============================== End Auto-Execution Section ==============================

#IfWinActive ahk_exe hznhorizon.exe

if ErrorLevel  ; ClipWait timed out.
	return
return

; ----------- begin of horizon buttons -----------

; ----------- italics ----------

^i::
ci:
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,2)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,2)
return

; ---------- bold ------------
^b::
cb:
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,1)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,1)
return

; ---------- underline ---------
^u::
cu:
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar2, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar3, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar4, A
HznButton(hToolbar,3)
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar5, A
HznButton(hToolbar,3)
return

; ----------- select-all -----------
^a::
ca:
ControlGetFocus, hCtl, A
ControlGet, Ctl, hWnd,,% hCtl, A
hWndChild := DllCall("RealChildWindowFromPoint", Ptr,Ctl, UInt,, Ptr)
WinGetClass, vCtl, % "ahk_id " hWndChild
If (vCtl = "ThunderRT6TextBox"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}
If (vCtl = "TX11"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}else {
	;PostMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	;SendMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1, Ptr, 0, Ptr, -1) 	; works in eqpt
}
return
; ----------- end of horizon buttons -----------

;<-------------------------------------------------------------------------------------------------------------------->

; ================================ Begin - OS Italics Function ================================
MakeOSItalic(OSTitle)
{
	OSSplit := StrSplit(OSTitle,",",,2)
	Send % OSSplit[1] ","
	WinGet, process, ProcessName, A
	If (process = "hznhorizon.exe"){
		Gosub, ci
		Send % OSSplit[2]
		Gosub, ci
	} else {
		SendLevel, 1
		Send ^i
		Send % OSSplit[2]
		send ^i
	}	
}
return
; ================================ End - OS Italics Function ================================

;<-------------------------------------------------------------------------------------------------------------------->

; ================================ Begin - Horizon Button Clicking Function ================================
HznButton(hWndToolbar, n)
{
	static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETITEMRECT := 0x41D
	SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar%
	buttonCount := ErrorLevel
	if (n >= 1 && n <= buttonCount) {
		DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UIntP", targetProcessID)
		; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
		hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		; Allocate memory for the TBBUTTON structure in the target process's address space
		remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")
		SendMessage, TB_GETITEMRECT, % n-1, remoteMemory, , ahk_id %hWndToolbar%
		VarSetCapacity(RECT, 16, 0)
		DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
		DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
		DllCall("CloseHandle", "Ptr", hProcess)
		
		X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
		ControlClick, % "x" (X+W//2) " y" (Y+H//2), ahk_id %hWndToolbar%,,,, NA
		SetControlDelay, %prevDelay%
	} else {
		MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
	}
	return
}
reload
; ================================ End - Horizon Button Clicking Function ================================
#IfWinActive
^#9::
; This script compares a string's words to array elements
#Requires AutoHotkey v1.1.33
WinGet, aCtrls, ControlList, A
;MsgBox % aCtrls
str  := aCtrls
MsgBox % str

;arr := ["msvb_lib_toolbar", "msvb_lib_toolbar1","msvb_lib_toolbar2", "msvb_lib_toolbar3", "msvb_lib_toolbar4", "msvb_lib_toolbar5"]
RegExMatch(str,"i)(msvb_lib_toolbar([0-9]?))",arr) ; this provides at least one match (on HE page, so only one)
;RegExMatch(str,"msvb_lib_toolbar",arr)
MsgBox % "Array: `n" arr "`n"
;arr  := RegExMatch(str,"^msvb_lib_toolbar(.*)")
list := ""
For each, item in m := match(str, arr)
	MsgBox % item
SendLevel, 1
SetKeyDelay,100,10
ControlGet, hToolbar, hWnd,,%item%, A
MsgBox % hToolbar
HznButton(hToolbar,2)
;list .= (list = "" ? "" : "`n") item
;MsgBox, 64, % "Matches (N=" m.Count() ")", % list
return

match(str, arr) { ; Return array of matches
	match := []
	For each, word in arr
		RegExMatch(str, "i)\b" word "\b") && match.Push(word)
	MsgBox % match
	return match
}
return
; ======= Build of missing shortcuts/hotkeys - Horizon ====================
;tb_name:= RegExMatch("msvb_lib_toolbar", "iO)msvb_lib_toolbar.*", SubPat,1)
;#9::
results := []
WinGet,names,ControlList,A  ;"msvb_lib_toolbar, msvb_lib_toolbar1, msvb_lib_toolbar2, msvb_lib_toolbar3, msvb_lib_toolbar4, msvb_lib_toolbar5"
pos := 1
while found := RegExMatch(names, "msvb_lib_toolbar""([0-9]?)", result, pos)
	results.Push(result), pos := found + StrLen(result)

; display array contents:
for k, v in results
	output .= v "`n"
ToolTip, % output
;ToolTip % "SubPat:" SubPat "`nSubPatCount: " SubPat.Count() "`nSubPatValue: " SubPat.Value() "`nSubPatName: " SubPat.Name() "`nName?: " SubPat["(.*)"] "`nErrorLevel: " ErrorLevel
return

/*			; alt test script for ctrl-a
^+a::
ControlGetFocus, hCtl, A
ControlGet, Ctl, hWnd,,% hCtl, A
hWndChild := DllCall("RealChildWindowFromPoint", Ptr,Ctl, UInt,, Ptr)
WinGetClass, vWinClass1, % "ahk_id " hWndChild
;MsgBox % vWinClass1
Clipboard:= % vWinclass1
ToolTip % vClass
return
*/
/*
+^a::		; original test script for ctrl-a
SendLevel, 1
;SetKeyDelay, 100, 10
;MouseGetPos,,,win, hCtl
;ControlGetFocus, vCtlClassNN, A
ControlGetFocus, hCtl, A
ControlGet, ctl, hWnd,,% hCtl, A
hWndParent := DllCall("GetAncestor", Ptr,Ctl, UInt,1, Ptr) ;GA_PARENT := 1
WinGetClass, ClassN, % "ahk_id" hWndParent
;ControlGet, Ctl, hWnd,, %hCtl%, A
;txtL:= PostMessage, WM_GETTEXTLENGTH:=0x000E,0,0,,ahk_id %ctl%
PostMessage, EM_SETSEL:=0x00b1, 0, -1, , % "ahk_id " ctl
;DllCall("SendMessage","PTR",ctl,"UInt",0xB1,"PTR*",start,"PTR*",end) ;EM_SETSEL
;ToolTip % "Control: " hCtl " | ahk_id " ctl "`nTextLength: " txtL "`nhWndParent: " hWndParent " : ClassName: " ClassN, x+1, y+1
;Sleep 3000
;ToolTip
;MsgBox % start " - " end
;Return
return
#if
*/
#9::
key := "^"
LocaleID := 0xA2

HKL := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "UInt", 0)
val := DllCall("VkKeyScanExW", "Char", Asc(key), "UInt", HKL)
MsgBox, % val
return
;Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ADMX_WindowsExplorer\NoWindowsHotKeys, RegValueNameRedirect (Name), REG_SZ (Type), NoWinKeys (Data)
; made edits here, because this is where I can
; Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\NoWinKeys, NoWinKeys - REG_DWORD - (1)
RegRead, state, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\NoWinKeys, NoWinKey, Name
RegRead, state1, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ADMX_WindowsExplorer\NoWindowsHotKeys, RegValueNameRedirect, Type
RegRead, state2, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ADMX_WindowsExplorer\NoWindowsHotKeys, RegValueNameRedirect, Data
;RegRead, state1, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ADMX_WindowsExplorer\NoWindowsHotKeys, REG_SZ
;RegRead, state2, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ADMX_WindowsExplorer\NoWindowsHotKeys, NoWinKeys
;RegRead, state, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoWinKeys, NoWinKeys
;RegRead, state, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ADMX_WindowsExplorer\NoWindowsHotKeys, RegValueNameRedirect
;RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoWinKeys, NoWinKeys, 0x00000001 (1)
MsgBox % "RegValueNameRedirect: " state "`n" "REG_SZ: " state1 "`n" "NoWinKeys: " state1 "`n"
return