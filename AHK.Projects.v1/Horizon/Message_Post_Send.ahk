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
DetectHiddenText,On
DetectHiddenWindows, On

; ================= Global Declares - Horizon ==================

/* ;global list of all WM_ stuff
	global WM_NULL:=0x0000
	global WM_CREATE:=0x0001
	global WM_DESTROY:=0x0002
	global WM_MOVE:=0x0003
	global WM_SIZE:=0x0005
	global WM_ACTIVATE:=0x0006
	global WM_SETFOCUS:=0x0007
	global WM_KILLFOCUS:=0x0008
	global WM_ENABLE:=0x000A
	global WM_SETREDRAW:=0x000B
	global WM_SETTEXT:=0x000C
	global WM_GETTEXT:=0x000D
	global WM_GETTEXTLENGTH:=0x000E
	global WM_PAINT:=0x000F
	global WM_CLOSE:=0x0010
	global WM_QUERYENDSESSION:=0x0011
	global WM_QUIT:=0x0012
	global WM_QUERYOPEN:=0x0013
	global WM_ERASEBKGND:=0x0014
	global WM_SYSCOLORCHANGE:=0x0015
	global WM_ENDSESSION:=0x0016
	global WM_SYSTEMERROR:=0x0017
	global WM_SHOWWINDOW:=0x0018
	global WM_CTLCOLOR:=0x0019
	global WM_WININICHANGE:=0x001A
	global WM_SETTINGCHANGE:=0x001A
	global WM_DEVMODECHANGE:=0x001B
	global WM_ACTIVATEAPP:=0x001C
	global WM_FONTCHANGE:=0x001D
	global WM_TIMECHANGE:=0x001E
	global WM_CANCELMODE:=0x001F
	global WM_SETCURSOR:=0x0020
	global WM_MOUSEACTIVATE:=0x0021
	global WM_CHILDACTIVATE:=0x0022
	global WM_QUEUESYNC:=0x0023
	global WM_GETMINMAXINFO:=0x0024
	global WM_PAINTICON:=0x0026
	global WM_ICONERASEBKGND:=0x0027
	global WM_NEXTDLGCTL:=0x0028
	global WM_SPOOLERSTATUS:=0x002A
	global WM_DRAWITEM:=0x002B
	global WM_MEASUREITEM:=0x002C
	global WM_DELETEITEM:=0x002D
	global WM_VKEYTOITEM:=0x002E
	global WM_CHARTOITEM:=0x002F
	
	global WM_SETFONT:=0x0030
	global WM_GETFONT:=0x0031
	global WM_SETHOTKEY:=0x0032
	global WM_GETHOTKEY:=0x0033
	global WM_QUERYDRAGICON:=0x0037
	global WM_COMPAREITEM:=0x0039
	global WM_COMPACTING:=0x0041
	global WM_WINDOWPOSCHANGING:=0x0046
	global WM_WINDOWPOSCHANGED:=0x0047
	global WM_POWER:=0x0048
	global WM_COPYDATA:=0x004A
	global WM_CANCELJOURNAL:=0x004B
	global WM_NOTIFY:=0x004E
	global WM_INPUTLANGCHANGEREQUEST:=0x0050
	global WM_INPUTLANGCHANGE:=0x0051
	global WM_TCARD:=0x0052
	global WM_HELP:=0x0053
	global WM_USERCHANGED:=0x0054
	global WM_NOTIFYFORMAT:=0x0055
	global WM_CONTEXTMENU:=0x007B
	global WM_STYLECHANGING:=0x007C
	global WM_STYLECHANGED:=0x007D
	global WM_DISPLAYCHANGE:=0x007E
	global WM_GETICON:=0x007F
	global WM_SETICON:=0x0080
	
	global WM_NCCREATE:=0x0081
	global WM_NCDESTROY:=0x0082
	global WM_NCCALCSIZE:=0x0083
	global WM_NCHITTEST:=0x0084
	global WM_NCPAINT:=0x0085
	global WM_NCACTIVATE:=0x0086
	global WM_GETDLGCODE:=0x0087
	global WM_NCMOUSEMOVE:=0x00A0
	global WM_NCLBUTTONDOWN:=0x00A1
	global WM_NCLBUTTONUP:=0x00A2
	global WM_NCLBUTTONDBLCLK:=0x00A3
	global WM_NCRBUTTONDOWN:=0x00A4
	global WM_NCRBUTTONUP:=0x00A5
	global WM_NCRBUTTONDBLCLK:=0x00A6
	global WM_NCMBUTTONDOWN:=0x00A7
	global WM_NCMBUTTONUP:=0x00A8
	global WM_NCMBUTTONDBLCLK:=0x00A9
	
	global WM_KEYFIRST:=0x0100
	global WM_KEYDOWN:=0x0100
	global WM_KEYUP:=0x0101
	global WM_CHAR:=0x0102
	global WM_DEADCHAR:=0x0103
	global WM_SYSKEYDOWN:=0x0104
	global WM_SYSKEYUP:=0x0105
	global WM_SYSCHAR:=0x0106
	global WM_SYSDEADCHAR:=0x0107
	global WM_KEYLAST:=0x0108
	
	global WM_IME_STARTCOMPOSITION:=0x010D
	global WM_IME_ENDCOMPOSITION:=0x010E
	global WM_IME_COMPOSITION:=0x010F
	global WM_IME_KEYLAST:=0x010F
	
	global WM_INITDIALOG:=0x0110
	global WM_COMMAND:=0x0111
	global WM_SYSCOMMAND:=0x0112
	global WM_TIMER:=0x0113
	global WM_HSCROLL:=0x0114
	global WM_VSCROLL:=0x0115
	global WM_INITMENU:=0x0116
	global WM_INITMENUPOPUP:=0x0117
	global WM_MENUSELECT:=0x011F
	global WM_MENUCHAR:=0x0120
	global WM_ENTERIDLE:=0x0121
	
	global WM_CTLCOLORMSGBOX:=0x0132
	global WM_CTLCOLOREDIT:=0x0133
	global WM_CTLCOLORLISTBOX:=0x0134
	global WM_CTLCOLORBTN:=0x0135
	global WM_CTLCOLORDLG:=0x0136
	global WM_CTLCOLORSCROLLBAR:=0x0137
	global WM_CTLCOLORSTATIC:=0x0138
	
	global WM_MOUSEFIRST:=0x0200
	global WM_MOUSEMOVE:=0x0200
	global WM_LBUTTONDOWN:=0x0201
	global WM_LBUTTONUP:=0x0202
	global WM_LBUTTONDBLCLK:=0x0203
	global WM_RBUTTONDOWN:=0x0204
	global WM_RBUTTONUP:=0x0205
	global WM_RBUTTONDBLCLK:=0x0206
	global WM_MBUTTONDOWN:=0x0207
	global WM_MBUTTONUP:=0x0208
	global WM_MBUTTONDBLCLK:=0x0209
	global WM_MOUSEWHEEL:=0x020A
	global WM_MOUSEHWHEEL:=0x020E
	
	global WM_PARENTNOTIFY:=0x0210
	global WM_ENTERMENULOOP:=0x0211
	global WM_EXITMENULOOP:=0x0212
	global WM_NEXTMENU:=0x0213
	global WM_SIZING:=0x0214
	global WM_CAPTURECHANGED:=0x0215
	global WM_MOVING:=0x0216
	global WM_POWERBROADCAST:=0x0218
	global WM_DEVICECHANGE:=0x0219
	
	global WM_MDICREATE:=0x0220
	global WM_MDIDESTROY:=0x0221
	global WM_MDIACTIVATE:=0x0222
	global WM_MDIRESTORE:=0x0223
	global WM_MDINEXT:=0x0224
	global WM_MDIMAXIMIZE:=0x0225
	global WM_MDITILE:=0x0226
	global WM_MDICASCADE:=0x0227
	global WM_MDIICONARRANGE:=0x0228
	global WM_MDIGETACTIVE:=0x0229
	global WM_MDISETMENU:=0x0230
	global WM_ENTERSIZEMOVE:=0x0231
	global WM_EXITSIZEMOVE:=0x0232
	global WM_DROPFILES:=0x0233
	global WM_MDIREFRESHMENU:=0x0234
	
	global WM_IME_SETCONTEXT:=0x0281
	global WM_IME_NOTIFY:=0x0282
	global WM_IME_CONTROL:=0x0283
	global WM_IME_COMPOSITIONFULL:=0x0284
	global WM_IME_SELECT:=0x0285
	global WM_IME_CHAR:=0x0286
	global WM_IME_KEYDOWN:=0x0290
	global WM_IME_KEYUP:=0x0291
	
	global WM_MOUSEHOVER:=0x02A1
	global WM_NCMOUSELEAVE:=0x02A2
	global WM_MOUSELEAVE:=0x02A3
	
	global WM_CUT:=0x0300
	global WM_COPY:=0x0301
	global WM_PASTE:=0x0302
	global WM_CLEAR:=0x0303
	global WM_UNDO:=0x0304
	
	global WM_RENDERFORMAT:=0x0305
	global WM_RENDERALLFORMATS:=0x0306
	global WM_DESTROYCLIPBOARD:=0x0307
	global WM_DRAWCLIPBOARD:=0x0308
	global WM_PAINTCLIPBOARD:=0x0309
	global WM_VSCROLLCLIPBOARD:=0x030A
	global WM_SIZECLIPBOARD:=0x030B
	global WM_ASKCBFORMATNAME:=0x030C
	global WM_CHANGECBCHAIN:=0x030D
	global WM_HSCROLLCLIPBOARD:=0x030E
	global WM_QUERYNEWPALETTE:=0x030F
	global WM_PALETTEISCHANGING:=0x0310
	global WM_PALETTECHANGED:=0x0311
	
	global WM_HOTKEY:=0x0312
	global WM_PRINT:=0x0317
	global WM_PRINTCLIENT:=0x0318
	
	global WM_HANDHELDFIRST:=0x0358
	global WM_HANDHELDLAST:=0x035F
	global WM_PENWINFIRST:=0x0380
	global WM_PENWINLAST:=0x038F
	global WM_COALESCE_FIRST:=0x0390
	global WM_COALESCE_LAST:=0x039F
	global WM_DDE_FIRST:=0x03E0
	global WM_DDE_INITIATE:=0x03E0
	global WM_DDE_TERMINATE:=0x03E1
	global WM_DDE_ADVISE:=0x03E2
	global WM_DDE_UNADVISE:=0x03E3
	global WM_DDE_ACK:=0x03E4
	global WM_DDE_DATA:=0x03E5
	global WM_DDE_REQUEST:=0x03E6
	global WM_DDE_POKE:=0x03E7
	global WM_DDE_EXECUTE:=0x03E8
	global WM_DDE_LAST:=0x03E8
	
	global WM_USER:=0x0400
	global WM_APP:=0x8000
	global VK_LBUTTON:=0x01
*/
; === vars ===
hCtl:="msvb_lib_toolbar1"
tCtl:="TX11"
hzn:="ahk_exe hznhorizon.exe"
; ========== Human Element - Horizon - Bold ==============

;#1::
;ControlGet, Ctlh, hWnd,,% hCtl, A
;ControlGet, Ctlt, hWnd,,% tCtl, A
;CoordMode, Mouse, Client
; bold button
;PostMessage,0x0201,,,, ahk_id %Ctlh% ;L_Button Down
;PostMessage,0x0202,,,, ahk_id %Ctlh% ;L_Button Up
;return

; ========== Human Element - Horizon - Italics ==============
;#2::
;ToolTip
;ControlGet, Ctlh, hWnd,,% hCtl, A
;ControlGet, Ctlt, hWnd,,% tCtl, A
;CoordMode, Mouse, Client
; italics button
;PostMessage,0x0201,,40,, ahk_id %Ctlh% ;L_Button Down
;PostMessage,0x0202,,40,, ahk_id %Ctlh% ;L_Button Up
;return

;#3:: ; Cut Button
;ControlGet, Ctlh, hWnd,,% hCtl, A
;ControlGet, Ctlt, hWnd,,% tCtl, A
;CoordMode, Mouse, Client
; Cut button
;PostMessage,0x0201,,70,, ahk_id %Ctlh% ;L_Button Down
;PostMessage,0x0202,,70,, ahk_id %Ctlh% ;L_Button Up
;return

;WatchCursor3:
;MouseGetPos, , , id, control, 3
;ControlGetFocus, vCtlClassNN, A
;ControlGet, hCtl, Hwnd,, % vCtlClassNN, A
;WinGetClass, vCtlClass, % "ahk_id " hCtl
;ControlGetText, vText, % vCtlClassNN, A
;ControlGet, vText2, List,, % vCtlClassNN, A
;MsgBox, % vCtlClass
;MsgBox, % vText
;ToolTip % vCtlClass " ID:"id
;Clipboard:= % vText
;MsgBox, % vText2
;return

#4::
;#Persistent
SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos, , , tbctrl_ID, control, 3
ControlGet, tbctrl_name, hWnd,, %tbctrl_ID%, A
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
WinGet, ControlList, ControlList, A
;ToolTip, %ControlList%
ToolTip, % "Reset Tooltip by pressing #1" "`n" . "Name: " tbctrl_name "ahk_id " tbctrl_ID "`n" ;ahk_class %class%`n%title%`nControl: %control%`nControlList: %ControlList%`n
/*
	;compatibility types 
	UPtr := A_PtrSize ? "UPtr" : "UInt"
	AStr := A_IsUnicode ? "AStr" : "Str"
	
	;cinfo:= DllCall("ChildWindowFromPointEx", Ptr,hCtl, UInt,"0x0000")
	;hFont := DllCall("CreateFont",uint,20 ; int nHeight
	;, int,0 ; int nWidth
	;, int,0 ; int nEscapement
	;, int,0 ; int nOrientation
	;, int,646 ; int fnWeight
	;, int,0 ; DWORD fdwItalic
	;, uint,0 ; DWORD fdwUnderline
	;, uint,True ; DWORD fdwStrikeOut
	;, uint,0 ; DWORD fdwCharSet
	;, uint,0 ; DWORD fdwOutPutPrecision
	;, uint,0 ; DWORD fdwClipPrecision
	;, uint,0 ; DWORD fdwQuality
	;, uint,0 ; DWORD fdwPitchAndFamily
	;, str, "Arial") ; LPCTSTR lpszFace
	
	;SendMessage 0x30,d %w hfont, True, %control%, ahk_id %win%
	;ToolTip Info: %cinfo% Control: %hCtl% ahk_id %win%
*/
return

#8::
ToolTip
#Persistent
CoordMode, Mouse, Window
SetTimer, WatchCursor8, 500
global win
global Ctl
WatchCursor8:
MouseGetPos,,,win, hCtl
ControlGet, Ctl, hWnd,, %hCtl%, A

ToolTip Control: %hCtl% ahk_id %ctl%, x+1, y+1
Return

; Function: ClickToolbarItem
; Description: Clicks the nth item in a toolbar.
; Parameters:
;   - hWndToolbar: The handle of the toolbar control.
;   - n: The index of the toolbar item to click.


; ========================================= ClickToolbarItem() Call Function ==========================================
#6::
ControlGet, hToolbar, hWnd,,msvb_lib_toolbar1, A
ClickToolbarItem(hToolbar,21)
return
; 1=Bold, 2=Italics, 10=Cut, 11=Copy, 12=Paste, 14=Undo, 15=Redo
; 17=Bulleted List, 18=Spell Check, 20=Super/Sub Script, 21=Find/Replace
; Mystery or Spacers: 3-9, 13, 16, 19=?Bold?
return

;/*
ClickToolbarItem(hWndToolbar, n) {
	static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETITEMRECT := 0x41D
	SendMessage, TB_BUTTONCOUNT,0,0,, % "ahk_id " hWndToolbar
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
		;ToolTip % "X: " X " Y: " Y " W: " W " H: " H " #: " buttonCount
	} else {
		MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
	}
	return
}
reload
*/
/* ; rev 5 - no workie - sends to tree on left
	ClickToolbarItem(hWndToolbar, n) {
		static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETRECT := 0x433
		SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar%
		buttonCount := ErrorLevel
		if (n >= 1 && n <= buttonCount) {
			DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UIntP", targetProcessID)PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
			hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
			remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 32, "UInt", 0x1000, "UInt", 0x04, "Ptr")
			SendMessage, TB_GETBUTTON, n - 1, remoteMemory, , ahk_id %hWndToolbar%
			VarSetCapacity(localTBBUTTON, 32, 0)
			DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &localTBBUTTON, "UPtr", 32, "UIntP", bytesRead, "Int")
			idCommand := NumGet(localTBBUTTON, 4, "Int")
			SendMessage, TB_GETRECT, idCommand, remoteMemory, , ahk_id %hWndToolbar%
			VarSetCapacity(RECT, 16, 0)
			DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
			DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
			DllCall("CloseHandle", "Ptr", hProcess)
			
			hParent := DllCall("user32\GetAncestor", "UInt", hWndToolbar, "UInt",2, "Ptr") ; GA_ROOT := 2
			ControlGetPos, ctrlX, ctrlY,,,, ahk_id %hWndToolbar%
			X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
			X += ctrlX, Y += ctrlY
			SetControlDelay -1
			ControlClick, % "x" (X+W//2) " y" (Y+H//2), ahk_id %hParent%,,,, NA
			SetControlDelay, %prevDelay%
		} else {
			MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
		}
	}
*/
/* ; === Rev 4 [THIS ONE WORKS!!!]==========================================================================================================================
	ClickToolbarItem(hWndToolbar, n) {
		static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETRECT := 0x433
		SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar%
		buttonCount := ErrorLevel
		if (n >= 1 && n <= buttonCount) {
			DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UIntP", targetProcessID)
			; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
			hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
			; Allocate memory for the TBBUTTON structure in the target process's address space
			remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 32, "UInt", 0x1000, "UInt", 0x04, "Ptr")
			SendMessage, TB_GETBUTTON, n - 1, remoteMemory, , ahk_id %hWndToolbar%
			VarSetCapacity(localTBBUTTON, 32, 0)
			DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &localTBBUTTON, "UPtr", 32, "UIntP", bytesRead, "Int")
			idCommand := NumGet(localTBBUTTON, 4, "Int")
			SendMessage, TB_GETRECT, idCommand, remoteMemory, , ahk_id %hWndToolbar%
			VarSetCapacity(RECT, 16, 0)
			DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
			DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
			DllCall("CloseHandle", "Ptr", hProcess)
			
			X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
			ToolTip % "X: " X " Y: " Y " W: " W " H: " H
			SetControlDelay -1
			ControlClick, % "x" (X+W//2) " y" (Y+H//2), ahk_id %hWndToolbar%,,,, NA
			SetControlDelay, %prevDelay%
			ToolTip % "X: " X " Y: " Y " W: " W " H: " H		
		} else {
			MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
		}
		return
	}
	return
*/
/* ; rev 3 ClickToolbarItem()
	ClickToolbarItem(hWndToolbar, n) {
		static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETRECT := 0x433
		SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar%
		buttonCount := ErrorLevel
		if (n >= 1 && n <= buttonCount) {
			DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UIntP", targetProcessID)
			; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
			hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
			; Allocate memory for the TBBUTTON structure in the target process's address space
			remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 32, "UInt", 0x1000, "UInt", 0x04, "Ptr")
			SendMessage, TB_GETBUTTON, n - 1, remoteMemory, , ahk_id %hWndToolbar%
			VarSetCapacity(localTBBUTTON, 32, 0)
			DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &localTBBUTTON, "UPtr", 32, "UIntP", bytesRead, "Int")
			idCommand := NumGet(localTBBUTTON, 4, "Int")
			SendMessage, TB_GETRECT, idCommand, remoteMemory, , ahk_id %hWndToolbar%
			VarSetCapacity(RECT, 16, 0)
			DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
			DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
			DllCall("CloseHandle", "Ptr", hProcess)
			
			X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int")
			PostMessage,0x0201,X,Y,, ahk_id %hWndToolbar% ;L_Button Down
			PostMessage,0x0202,X,Y,, ahk_id %hWndToolbar% ;L_Button Up
		} else {
			MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
		}
	}
*/
/* Rev 2 ClickToolbarItem()
	ClickToolbarItem(hWndToolbar, n) {
		static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_PRESSBUTTON := 0x403
		SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar%
		buttonCount := ErrorLevel
		if (n >= 1 && n <= buttonCount) {
			DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UIntP", targetProcessID)
			; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
			hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
			; Allocate memory for the TBBUTTON structure in the target process's address space
			remoteTBBUTTON := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 32, "UInt", 0x1000, "UInt", 0x04, "Ptr")
			SendMessage, TB_GETBUTTON, n - 1, remoteTBBUTTON, , ahk_id %hWndToolbar%
			VarSetCapacity(localTBBUTTON, 32, 0)
			DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteTBBUTTON, "Ptr", &localTBBUTTON, "UPtr", 32, "UIntP", bytesRead, "Int")
			DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteTBBUTTON, "UPtr", 0, "UInt", 0x8000)
			DllCall("CloseHandle", "Ptr", hProcess)
			idCommand := NumGet(localTBBUTTON, 4, "Int")
			; Send the TB_PRESSBUTTON message to press the button
			SendMessage, TB_PRESSBUTTON, idCommand, 1, , ahk_id %hWndToolbar%
			Sleep, 100
			SendMessage, TB_PRESSBUTTON, idCommand, False, , ahk_id %hWndToolbar%
		} else {
			MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
		}
	}
*/
/* ; original ClickToolbarItem()
	ClickToolbarItem(hWndToolbar, n) {
		; Constants for Toolbar button messages
		TB_BUTTONCOUNT := 0x418
		TB_GETBUTTON := 0x417
		TB_PRESSBUTTON := 0x401
		
		; Get the number of buttons in the toolbar
		SendMessage, TB_BUTTONCOUNT, 0, 0, , ahk_id %hWndToolbar%
		buttonCount := ErrorLevel
		
		; Check if the specified index is within the range of button count
		if (n >= 1 && n <= buttonCount) {
			; Get the TBBUTTON structure for the nth button
			VarSetCapacity(tbb, 20, 0)
			SendMessage, TB_GETBUTTON, n - 1, &tbb, , ahk_id %hWndToolbar%
			
			; Extract the idCommand from the TBBUTTON structure
			idCommand := NumGet(tbb, 0, "Int")
			
			; Send the TB_PRESSBUTTON message to press the button
			SendMessage, TB_PRESSBUTTON, idCommand, True, , ahk_id %hWndToolbar%
			
			; Introduce a short delay to simulate the click
			Sleep, 100
			
			; Send the TB_PRESSBUTTON message to release the button
			SendMessage, TB_PRESSBUTTON, idCommand, False, , ahk_id %hWndToolbar%
		} else {
			MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
		}
	}
	return
*/
;/*
#2::
#Persistent
SetTimer, WatchCursor5, 500
WinGet, hWnd, ID, A
;WinGet, vCtlList, ControlList, % "ahk_id " hWnd
WinGet, vCtlList, ControlList, % "ahk_id " hWnd
vOutput := ""
return

WatchCursor5:
MouseGetPos, , , id, control, 3
ControlGetFocus, vCtlClassNN, A
ControlGet, hCtl, Hwnd,, % vCtlClassNN, A
WinGetClass, vCtlClass, % "ahk_id " hCtl
ControlGetText, vText, % vCtlClassNN, A
ControlGet, vText2, List,, % vCtlClassNN, A
hWndParent := DllCall("user32\GetAncestor", Ptr,hCtl, UInt,1, Ptr) ;GA_PARENT := 1
hWndRoot := DllCall("user32\GetAncestor", Ptr,hCtl, UInt,2, Ptr) ;GA_ROOT := 2
hWndOwner := DllCall("user32\GetWindow", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
hWndChild := DllCall("RealChildWindowFromPoint", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
WinGet, chWnd, ID, "ahk_id " hWndChild
WinGetClass, vWinClass1, % "ahk_id " hWndParent
WinGetClass, vWinClass2, % "ahk_id " hWndRoot
WinGetClass, vWinClass3, % "ahk_id " hWndOwner
WinGetClass, vWinClass4, % "ahk_id " hWndChild
ToolTip % "Parent: " . vWinClass1 "`nRoot: " . vWinClass2 "`nOwner: " . vWinClass3 . "`nChild: " vWinClass4 . "`nID: " . ID
return
;Clipboard:= % vText
Loop, Parse, vCtlList, `n
{
	vCtlClassNN := A_LoopField
	ControlGet, hCtl, Hwnd,, % vCtlClassNN, % "ahk_id " hWnd
	hWndParent := DllCall("user32\GetAncestor", Ptr,hCtl, UInt,1, Ptr) ;GA_PARENT := 1
	hWndRoot := DllCall("user32\GetAncestor", Ptr,hCtl, UInt,2, Ptr) ;GA_ROOT := 2
	hWndOwner := DllCall("user32\GetWindow", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
	hWndChild := DllCall("RealChildWindowFromPoint", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
	;CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
	WinGetClass, vWinClass1, % "ahk_id " hWndParent
	WinGetClass, vWinClass2, % "ahk_id " hWndRoot
	WinGetClass, vWinClass3, % "ahk_id " hWndOwner
	WinGetClass, vWinClass4, % "ahk_id " hWndChild
	vOutput .= A_Index ":" vCtlClassNN "|" vWinClass1 "|" vWinClass2 "|" vWinClass3 "|" vWinClass4 "`r`n" ;"|" vWinClass4 "`r`n"
}
Clipboard := vOutput 
;ToolTip, % vCtlClassNN,x+1,0
ToolTip, % vOutput, xm,0
;MsgBox, % vOutput
return
;*/
#1::
Reload
Return


#5::
WinGet, hWnd, ID, A
;WinGet, vCtlList, ControlList, % "ahk_id " hWnd
WinGet, vCtlList, ControlList, % "ahk_id " hWnd
vOutput := ""
Loop, Parse, vCtlList, `n
{
	vCtlClassNN := A_LoopField
	ControlGet, hCtl, Hwnd,, % vCtlClassNN, % "ahk_id " hWnd
	hWndParent := DllCall("user32\GetAncestor","Ptr",hCtl, "UInt",1, "Ptr") ;GA_PARENT := 1
	hWndRoot := DllCall("user32\GetAncestor","Ptr", hCtl, "UInt",2, "Ptr") ;GA_ROOT := 2
	hWndOwner := DllCall("user32\GetAncestor","Ptr", hCtl, "UInt",4, "Ptr") ;GA_ROOT := 2
	;hWndOwner := DllCall("user32\GetWindow", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
	hWndChild := DllCall("RealChildWindowFromPoint","Ptr",hCtl, "UInt",4, "Ptr") ;GW_OWNER = 4
	CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
	WinGetClass, vWinClass1, % "ahk_id " hWndParent
	WinGetClass, vWinClass2, % "ahk_id " hWndRoot
	WinGetClass, vWinClass3, % "ahk_id " hWndOwner
	WinGetClass, vWinClass4, % "ahk_id " hWndChild
	vOutput .= "Index: " A_Index " | ClassNN: " vCtlClassNN " | hWndChild: " vWinClass4 " | hWndChild: " hWndChild " | hWndParent: " hWndParent " | hWndRoot: " hWndRoot " | hWndOwner: " hWndOwner " | CursorHwnd: " CursorHwnd "`n" ;"|" vWinClass1 "|" vWinClass2 "|" vWinClass3 "|" vWinClass4 "`r`n" ;"|" vWinClass4 "`r`n"
}
Clipboard := vOutput 
;ToolTip, % vCtlClassNN,x+1,0
ToolTip, % vOutput, xm,0
;MsgBox, % vOutput
return
*/
/*
Index: 1 | ClassNN: MDIClient1 | hWndChild: ThunderRT6FormDC | hWndChild: 593758 | hWndParent: 396402 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 2 | ClassNN: ThunderRT6FormDC1 | hWndChild: ThunderRT6UserControlDC | hWndChild: 332182 | hWndParent: 527578 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 3 | ClassNN: AfxOleControl421 | hWndChild: AfxWnd42 | hWndChild: 332150 | hWndParent: 593758 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 4 | ClassNN: AfxWnd421 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 5 | ClassNN: AfxWnd422 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 6 | ClassNN: AfxWnd423 | hWndChild: AfxWnd42 | hWndChild: 332150 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 7 | ClassNN: AfxFrameOrView421 | hWndChild: SysTreeView32 | hWndChild: 525706 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 8 | ClassNN: SysTreeView321 | hWndChild: SysTreeView32 | hWndChild: 525706 | hWndParent: 857090 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 9 | ClassNN: AfxFrameOrView422 | hWndChild: AfxFrameOrView42 | hWndChild: 332154 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 10 | ClassNN: AfxFrameOrView423 | hWndChild: AfxFrameOrView42 | hWndChild: 332146 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 11 | ClassNN: PVSPLITTERWNDCLASS1 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 332158 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 12 | ClassNN: PVSPLITTERWNDCLASS2 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 332148 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 13 | ClassNN: Edit1 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 14 | ClassNN: SysListView321 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 15 | ClassNN: Edit2 | hWndChild:  | hWndChild: 0 | hWndParent: 332162 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 16 | ClassNN: AfxFrameOrView424 | hWndChild: AfxFrameOrView42 | hWndChild: 332170 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 17 | ClassNN: AfxFrameOrView425 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 18 | ClassNN: AfxWnd424 | hWndChild: AfxWnd42 | hWndChild: 332174 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 19 | ClassNN: AfxWnd425 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 20 | ClassNN: ToolbarWindow321 | hWndChild: ToolbarWindow32 | hWndChild: 332178 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 21 | ClassNN: AfxWnd426 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 22 | ClassNN: AfxFrameOrView426 | hWndChild:  | hWndChild: 0 | hWndParent: 332142 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 23 | ClassNN: AfxOleControl422 | hWndChild: AfxWnd42 | hWndChild: 332176 | hWndParent: 593758 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 24 | ClassNN: AfxWnd427 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 25 | ClassNN: AfxWnd428 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 26 | ClassNN: AfxWnd429 | hWndChild: AfxWnd42 | hWndChild: 332176 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 27 | ClassNN: AfxFrameOrView427 | hWndChild: SysTreeView32 | hWndChild: 332116 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 28 | ClassNN: SysTreeView322 | hWndChild: SysTreeView32 | hWndChild: 332116 | hWndParent: 397642 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 29 | ClassNN: AfxFrameOrView428 | hWndChild: AfxFrameOrView42 | hWndChild: 332110 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 30 | ClassNN: AfxFrameOrView429 | hWndChild: AfxFrameOrView42 | hWndChild: 332118 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 31 | ClassNN: PVSPLITTERWNDCLASS3 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 332114 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 32 | ClassNN: PVSPLITTERWNDCLASS4 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 332108 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 33 | ClassNN: Edit3 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 34 | ClassNN: SysListView322 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 35 | ClassNN: Edit4 | hWndChild:  | hWndChild: 0 | hWndParent: 332128 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 36 | ClassNN: AfxFrameOrView4210 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 37 | ClassNN: AfxFrameOrView4211 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 38 | ClassNN: AfxWnd4210 | hWndChild: AfxWnd42 | hWndChild: 332126 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 39 | ClassNN: AfxWnd4211 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 40 | ClassNN: ToolbarWindow322 | hWndChild: ToolbarWindow32 | hWndChild: 332140 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 41 | ClassNN: AfxWnd4212 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 42 | ClassNN: AfxFrameOrView4212 | hWndChild:  | hWndChild: 0 | hWndParent: 463060 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 43 | ClassNN: AfxOleControl423 | hWndChild: AfxFrameOrView42 | hWndChild: 921926 | hWndParent: 593758 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 44 | ClassNN: AfxWnd4213 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 45 | ClassNN: AfxWnd4214 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 46 | ClassNN: AfxWnd4215 | hWndChild: AfxWnd42 | hWndChild: 462602 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 47 | ClassNN: AfxFrameOrView4213 | hWndChild: SysTreeView32 | hWndChild: 856372 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 48 | ClassNN: SysTreeView323 | hWndChild: SysTreeView32 | hWndChild: 856372 | hWndParent: 921926 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 49 | ClassNN: AfxFrameOrView4214 | hWndChild: AfxFrameOrView42 | hWndChild: 1706642 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 50 | ClassNN: AfxFrameOrView4215 | hWndChild: AfxFrameOrView42 | hWndChild: 528642 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 51 | ClassNN: PVSPLITTERWNDCLASS5 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 659528 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 52 | ClassNN: PVSPLITTERWNDCLASS6 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 2164816 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 53 | ClassNN: Edit5 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 54 | ClassNN: SysListView323 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 55 | ClassNN: Edit6 | hWndChild:  | hWndChild: 0 | hWndParent: 1575390 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 56 | ClassNN: AfxFrameOrView4216 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 57 | ClassNN: AfxFrameOrView4217 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 58 | ClassNN: AfxWnd4216 | hWndChild: AfxWnd42 | hWndChild: 461546 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 59 | ClassNN: AfxWnd4217 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 60 | ClassNN: ToolbarWindow323 | hWndChild: ToolbarWindow32 | hWndChild: 526996 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 61 | ClassNN: AfxWnd4218 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 62 | ClassNN: AfxFrameOrView4218 | hWndChild:  | hWndChild: 0 | hWndParent: 921670 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 63 | ClassNN: AfxOleControl424 | hWndChild: AfxWnd42 | hWndChild: 462564 | hWndParent: 593758 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 64 | ClassNN: AfxWnd4219 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 65 | ClassNN: AfxWnd4220 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 66 | ClassNN: AfxWnd4221 | hWndChild: SysTabControl32 | hWndChild: 921210 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 67 | ClassNN: SysTabControl321 | hWndChild: SysTabControl32 | hWndChild: 921210 | hWndParent: 462564 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 68 | ClassNN: AfxFrameOrView4219 | hWndChild: SysTreeView32 | hWndChild: 462572 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 69 | ClassNN: SysTreeView324 | hWndChild: SysTreeView32 | hWndChild: 462572 | hWndParent: 528102 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 70 | ClassNN: AfxFrameOrView4220 | hWndChild: AfxFrameOrView42 | hWndChild: 528112 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 71 | ClassNN: AfxFrameOrView4221 | hWndChild: AfxFrameOrView42 | hWndChild: 462568 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 72 | ClassNN: PVSPLITTERWNDCLASS7 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 462608 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 73 | ClassNN: PVSPLITTERWNDCLASS8 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 462586 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 74 | ClassNN: Edit7 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 75 | ClassNN: SysListView324 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 76 | ClassNN: Edit8 | hWndChild:  | hWndChild: 0 | hWndParent: 528110 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 77 | ClassNN: AfxFrameOrView4222 | hWndChild: AfxFrameOrView42 | hWndChild: 462598 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 78 | ClassNN: AfxFrameOrView4223 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 79 | ClassNN: AfxWnd4222 | hWndChild: AfxWnd42 | hWndChild: 462580 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 80 | ClassNN: AfxWnd4223 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 81 | ClassNN: ToolbarWindow324 | hWndChild: ToolbarWindow32 | hWndChild: 856352 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 82 | ClassNN: AfxWnd4224 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 83 | ClassNN: AfxFrameOrView4224 | hWndChild:  | hWndChild: 0 | hWndParent: 462556 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 84 | ClassNN: AfxOleControl425 | hWndChild: AfxFrameOrView42 | hWndChild: 1183372 | hWndParent: 593758 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 85 | ClassNN: AfxWnd4225 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 86 | ClassNN: Shell Embedding1 | hWndChild:  | hWndChild: 0 | hWndParent: 463390 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 87 | ClassNN: AfxWnd4226 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 88 | ClassNN: AfxWnd4227 | hWndChild: AfxWnd42 | hWndChild: 659140 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 89 | ClassNN: AfxFrameOrView4225 | hWndChild: SysTabControl32 | hWndChild: 792196 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 90 | ClassNN: SysTreeView325 | hWndChild: SysTreeView32 | hWndChild: 463378 | hWndParent: 1183372 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 91 | ClassNN: SysTabControl322 | hWndChild: SysTabControl32 | hWndChild: 792196 | hWndParent: 1183372 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 92 | ClassNN: SysTreeView326 | hWndChild:  | hWndChild: 0 | hWndParent: 1183372 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 93 | ClassNN: AfxFrameOrView4226 | hWndChild: AfxFrameOrView42 | hWndChild: 855700 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 94 | ClassNN: AfxFrameOrView4227 | hWndChild: AfxFrameOrView42 | hWndChild: 593630 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 95 | ClassNN: PVSPLITTERWNDCLASS9 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 1250400 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 96 | ClassNN: PVSPLITTERWNDCLASS10 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 463382 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 97 | ClassNN: Edit9 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 98 | ClassNN: SysListView325 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 99 | ClassNN: Edit10 | hWndChild:  | hWndChild: 0 | hWndParent: 659152 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 100 | ClassNN: AfxFrameOrView4228 | hWndChild: ThunderRT6FormDC | hWndChild: 856486 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 101 | ClassNN: ThunderRT6FormDC2 | hWndChild: ThunderRT6FormDC | hWndChild: 856486 | hWndParent: 528084 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 102 | ClassNN: ProtoViewResizer1 | hWndChild:  | hWndChild: 0 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 103 | ClassNN: SSActiveTabsWndClass1 | hWndChild:  | hWndChild: 0 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 104 | ClassNN: TabStrip20WndClass1 | hWndChild: TabStrip20WndClass | hWndChild: 595662 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 105 | ClassNN: ThunderRT6UserControlDC1 | hWndChild: ThunderRT6UserControlDC | hWndChild: 595638 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 106 | ClassNN: ThunderRT6UserControlDC2 | hWndChild: ThunderRT6UserControlDC | hWndChild: 857510 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 107 | ClassNN: ThunderRT6OptionButton1 | hWndChild: ThunderRT6OptionButton | hWndChild: 595590 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 108 | ClassNN: ThunderRT6OptionButton2 | hWndChild: ThunderRT6OptionButton | hWndChild: 595592 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 109 | ClassNN: ThunderRT6Frame1 | hWndChild: ThunderRT6Frame | hWndChild: 595526 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 110 | ClassNN: ThunderRT6UserControlDC3 | hWndChild: ATL:10EE0020 | hWndChild: 530082 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 111 | ClassNN: ATL:10EE00201 | hWndChild: DT5_PVCombo | hWndChild: 530078 | hWndParent: 595594 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 112 | ClassNN: DT5_PVCombo1 | hWndChild: DT5ComboBox_PVCombo | hWndChild: 530072 | hWndParent: 530082 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 113 | ClassNN: ScrollBar1 | hWndChild:  | hWndChild: 0 | hWndParent: 530078 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 114 | ClassNN: DT5ComboBox_PVCombo1 | hWndChild: DT5ComboBox_PVCombo | hWndChild: 530072 | hWndParent: 530078 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 115 | ClassNN: ThunderRT6UserControlDC4 | hWndChild: ATL:10EE0020 | hWndChild: 1246718 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 116 | ClassNN: ATL:10EE00202 | hWndChild: DT5_PVCombo | hWndChild: 530084 | hWndParent: 530066 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 117 | ClassNN: DT5_PVCombo2 | hWndChild: DT5ComboBox_PVCombo | hWndChild: 530092 | hWndParent: 1246718 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 118 | ClassNN: ScrollBar2 | hWndChild:  | hWndChild: 0 | hWndParent: 530084 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 119 | ClassNN: DT5ComboBox_PVCombo2 | hWndChild: DT5ComboBox_PVCombo | hWndChild: 530092 | hWndParent: 530084 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 120 | ClassNN: ThunderRT6Frame2 | hWndChild: ThunderRT6OptionButton | hWndChild: 1643414 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 121 | ClassNN: ThunderRT6OptionButton3 | hWndChild: ThunderRT6OptionButton | hWndChild: 530100 | hWndParent: 530086 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 122 | ClassNN: ThunderRT6OptionButton4 | hWndChild: ThunderRT6OptionButton | hWndChild: 1643414 | hWndParent: 530086 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 123 | ClassNN: ThunderRT6UserControlDC5 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1246698 | hWndParent: 530086 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 124 | ClassNN: ThunderRT6UserControlDC6 | hWndChild: ThunderRT6UserControlDC | hWndChild: 923036 | hWndParent: 530086 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 125 | ClassNN: ThunderRT6Frame3 | hWndChild: ThunderRT6OptionButton | hWndChild: 922032 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 126 | ClassNN: ThunderRT6OptionButton5 | hWndChild: ThunderRT6OptionButton | hWndChild: 2298770 | hWndParent: 660858 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 127 | ClassNN: ThunderRT6OptionButton6 | hWndChild: ThunderRT6OptionButton | hWndChild: 922032 | hWndParent: 660858 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 128 | ClassNN: ThunderRT6UserControlDC7 | hWndChild: ThunderRT6UserControlDC | hWndChild: 661168 | hWndParent: 660858 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 129 | ClassNN: ThunderRT6UserControlDC8 | hWndChild: ThunderRT6UserControlDC | hWndChild: 658060 | hWndParent: 660858 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 130 | ClassNN: ThunderRT6Frame4 | hWndChild: ThunderRT6OptionButton | hWndChild: 923040 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 131 | ClassNN: ThunderRT6OptionButton7 | hWndChild: ThunderRT6OptionButton | hWndChild: 2102426 | hWndParent: 595372 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 132 | ClassNN: ThunderRT6OptionButton8 | hWndChild: ThunderRT6OptionButton | hWndChild: 923040 | hWndParent: 595372 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 133 | ClassNN: ThunderRT6UserControlDC9 | hWndChild: ThunderRT6UserControlDC | hWndChild: 988784 | hWndParent: 595372 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 134 | ClassNN: ThunderRT6UserControlDC10 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1835500 | hWndParent: 595372 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 135 | ClassNN: ThunderRT6Frame5 | hWndChild: ThunderRT6OptionButton | hWndChild: 1117230 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 136 | ClassNN: ThunderRT6OptionButton9 | hWndChild: ThunderRT6OptionButton | hWndChild: 726752 | hWndParent: 726726 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 137 | ClassNN: ThunderRT6OptionButton10 | hWndChild: ThunderRT6OptionButton | hWndChild: 1117230 | hWndParent: 726726 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 138 | ClassNN: ThunderRT6UserControlDC11 | hWndChild: ThunderRT6UserControlDC | hWndChild: 726652 | hWndParent: 726726 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 139 | ClassNN: ThunderRT6UserControlDC12 | hWndChild: ThunderRT6UserControlDC | hWndChild: 857744 | hWndParent: 726726 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 140 | ClassNN: ThunderRT6Frame6 | hWndChild: ThunderRT6OptionButton | hWndChild: 792094 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 141 | ClassNN: ThunderRT6OptionButton11 | hWndChild: ThunderRT6OptionButton | hWndChild: 1642606 | hWndParent: 2228460 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 142 | ClassNN: ThunderRT6OptionButton12 | hWndChild: ThunderRT6OptionButton | hWndChild: 792094 | hWndParent: 2228460 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 143 | ClassNN: ThunderRT6UserControlDC13 | hWndChild: ThunderRT6UserControlDC | hWndChild: 726676 | hWndParent: 2228460 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 144 | ClassNN: ThunderRT6UserControlDC14 | hWndChild: ThunderRT6UserControlDC | hWndChild: 988776 | hWndParent: 2228460 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 145 | ClassNN: ThunderRT6Frame7 | hWndChild: ThunderRT6OptionButton | hWndChild: 1181122 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 146 | ClassNN: ThunderRT6UserControlDC15 | hWndChild: ThunderRT6UserControlDC | hWndChild: 792088 | hWndParent: 2164178 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 147 | ClassNN: ThunderRT6UserControlDC16 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2953526 | hWndParent: 2164178 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 148 | ClassNN: ThunderRT6OptionButton13 | hWndChild: ThunderRT6OptionButton | hWndChild: 1181122 | hWndParent: 2164178 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 149 | ClassNN: ThunderRT6OptionButton14 | hWndChild: ThunderRT6OptionButton | hWndChild: 1906380 | hWndParent: 2164178 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 150 | ClassNN: ThunderRT6Frame8 | hWndChild: ThunderRT6OptionButton | hWndChild: 1705144 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 151 | ClassNN: ThunderRT6UserControlDC17 | hWndChild: ThunderRT6UserControlDC | hWndChild: 923162 | hWndParent: 857812 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 152 | ClassNN: ThunderRT6UserControlDC18 | hWndChild: ThunderRT6UserControlDC | hWndChild: 857618 | hWndParent: 857812 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 153 | ClassNN: ThunderRT6OptionButton15 | hWndChild: ThunderRT6OptionButton | hWndChild: 1705144 | hWndParent: 857812 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 154 | ClassNN: ThunderRT6OptionButton16 | hWndChild: ThunderRT6OptionButton | hWndChild: 1115734 | hWndParent: 857812 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 155 | ClassNN: ThunderRT6Frame9 | hWndChild: ThunderRT6OptionButton | hWndChild: 2101716 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 156 | ClassNN: ThunderRT6UserControlDC19 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2297518 | hWndParent: 1837600 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 157 | ClassNN: ThunderRT6UserControlDC20 | hWndChild: ThunderRT6UserControlDC | hWndChild: 661014 | hWndParent: 1837600 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 158 | ClassNN: ThunderRT6OptionButton17 | hWndChild: ThunderRT6OptionButton | hWndChild: 2101716 | hWndParent: 1837600 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 159 | ClassNN: ThunderRT6OptionButton18 | hWndChild: ThunderRT6OptionButton | hWndChild: 2362936 | hWndParent: 1837600 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 160 | ClassNN: ThunderRT6UserControlDC21 | hWndChild: ATL:10EE0020 | hWndChild: 2299250 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 161 | ClassNN: ATL:10EE00203 | hWndChild: DT5_PVCombo | hWndChild: 792080 | hWndParent: 661176 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 162 | ClassNN: DT5_PVCombo3 | hWndChild: DT5_PVCombo | hWndChild: 792080 | hWndParent: 2299250 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 163 | ClassNN: ScrollBar3 | hWndChild:  | hWndChild: 0 | hWndParent: 792080 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 164 | ClassNN: ThunderRT6UserControlDC22 | hWndChild: ATL:10EE0020 | hWndChild: 2035326 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 165 | ClassNN: ATL:10EE00204 | hWndChild: DT5_PVCombo | hWndChild: 792078 | hWndParent: 792280 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 166 | ClassNN: DT5_PVCombo4 | hWndChild: DT5_PVCombo | hWndChild: 792078 | hWndParent: 2035326 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 167 | ClassNN: ScrollBar4 | hWndChild:  | hWndChild: 0 | hWndParent: 792078 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 168 | ClassNN: ThunderRT6UserControlDC23 | hWndChild: ATL:10EE0020 | hWndChild: 1315240 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 169 | ClassNN: ATL:10EE00205 | hWndChild: DT5_PVCombo | hWndChild: 2298940 | hWndParent: 3412890 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 170 | ClassNN: DT5_PVCombo5 | hWndChild: DT5_PVCombo | hWndChild: 2298940 | hWndParent: 1315240 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 171 | ClassNN: ScrollBar5 | hWndChild:  | hWndChild: 0 | hWndParent: 2298940 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 172 | ClassNN: ThunderRT6UserControlDC24 | hWndChild: ATL:10EE0020 | hWndChild: 2560068 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 173 | ClassNN: ATL:10EE00206 | hWndChild: DT5_PVCombo | hWndChild: 3149472 | hWndParent: 2495848 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 174 | ClassNN: DT5_PVCombo6 | hWndChild: DT5_PVCombo | hWndChild: 3149472 | hWndParent: 2560068 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 175 | ClassNN: ScrollBar6 | hWndChild:  | hWndChild: 0 | hWndParent: 3149472 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 176 | ClassNN: ThunderRT6UserControlDC25 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2495240 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 177 | ClassNN: ThunderRT6UserControlDC26 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1969800 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 178 | ClassNN: ThunderRT6UserControlDC27 | hWndChild: ThunderRT6UserControlDC | hWndChild: 923094 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 179 | ClassNN: ThunderRT6UserControlDC28 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1511946 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 180 | ClassNN: ThunderRT6UserControlDC29 | hWndChild:  | hWndChild: 0 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 181 | ClassNN: ThunderRT6UserControlDC30 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1050006 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 182 | ClassNN: ThunderRT6UserControlDC31 | hWndChild: ThunderRT6UserControlDC | hWndChild: 3216694 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 183 | ClassNN: ThunderRT6UserControlDC32 | hWndChild: ThunderRT6UserControlDC | hWndChild: 984490 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 184 | ClassNN: ThunderRT6UserControlDC33 | hWndChild: ATL:10EE0020 | hWndChild: 2233402 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 185 | ClassNN: ATL:10EE00207 | hWndChild: DT5_PVCombo | hWndChild: 2099790 | hWndParent: 3085048 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 186 | ClassNN: DT5_PVCombo7 | hWndChild: DT5_PVCombo | hWndChild: 2099790 | hWndParent: 2233402 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 187 | ClassNN: ScrollBar7 | hWndChild:  | hWndChild: 0 | hWndParent: 2099790 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 188 | ClassNN: ThunderRT6UserControlDC34 | hWndChild: ThunderRT6CheckBox | hWndChild: 2035310 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 189 | ClassNN: ThunderRT6CheckBox1 | hWndChild: ThunderRT6CheckBox | hWndChild: 2035310 | hWndParent: 1050020 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 190 | ClassNN: ThunderRT6UserControlDC35 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1315274 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 191 | ClassNN: ThunderRT6UserControlDC36 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1249770 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 192 | ClassNN: ThunderRT6UserControlDC37 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2494134 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 193 | ClassNN: ThunderRT6UserControlDC38 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2233354 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 194 | ClassNN: ThunderRT6UserControlDC39 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1249732 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 195 | ClassNN: ThunderRT6UserControlDC40 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2233228 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 196 | ClassNN: ThunderRT6UserControlDC41 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1969794 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 197 | ClassNN: ThunderRT6UserControlDC42 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1380844 | hWndParent: 595526 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 198 | ClassNN: ThunderRT6Frame10 | hWndChild: ThunderRT6Frame | hWndChild: 3871636 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 199 | ClassNN: ThunderRT6UserControlDC43 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2561286 | hWndParent: 3871636 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 200 | ClassNN: SSUltraGridWndClass1 | hWndChild: SSUltraGridWndClass | hWndChild: 1446392 | hWndParent: 3871636 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 201 | ClassNN: ScrollBar8 | hWndChild: ScrollBar | hWndChild: 4396158 | hWndParent: 1446392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 202 | ClassNN: ThunderRT6UserControlDC44 | hWndChild: ThunderRT6CommandButton | hWndChild: 2952956 | hWndParent: 3871636 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 203 | ClassNN: ThunderRT6CommandButton1 | hWndChild: ThunderRT6CommandButton | hWndChild: 2952956 | hWndParent: 1774472 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 204 | ClassNN: SSTabPanelWndClass1 | hWndChild: SSTabPanelWndClass | hWndChild: 1576526 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 205 | ClassNN: ThunderRT6UserControlDC45 | hWndChild: ThunderRT6CommandButton | hWndChild: 2560818 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 206 | ClassNN: ThunderRT6CommandButton2 | hWndChild: ThunderRT6CommandButton | hWndChild: 2560818 | hWndParent: 4003122 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 207 | ClassNN: ThunderRT6UserControlDC46 | hWndChild: ThunderRT6UserControlDC | hWndChild: 988532 | hWndParent: 595596 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 208 | ClassNN: ThunderRT6UserControlDC47 | hWndChild: ATL:10EE0020 | hWndChild: 919004 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 209 | ClassNN: ATL:10EE00208 | hWndChild: DT5_PVCombo | hWndChild: 857482 | hWndParent: 919010 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 210 | ClassNN: DT5_PVCombo8 | hWndChild: DT5_PVCombo | hWndChild: 857482 | hWndParent: 919004 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 211 | ClassNN: ScrollBar9 | hWndChild:  | hWndChild: 0 | hWndParent: 857482 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 212 | ClassNN: ThunderRT6UserControlDC48 | hWndChild: ATL:10EE0020 | hWndChild: 1643534 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 213 | ClassNN: ATL:10EE00209 | hWndChild: DT5_PVCombo | hWndChild: 791954 | hWndParent: 2167826 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 214 | ClassNN: DT5_PVCombo9 | hWndChild: DT5_PVCombo | hWndChild: 791954 | hWndParent: 1643534 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 215 | ClassNN: ScrollBar10 | hWndChild:  | hWndChild: 0 | hWndParent: 791954 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 216 | ClassNN: ThunderRT6UserControlDC49 | hWndChild: ATL:10EE0020 | hWndChild: 2495796 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 217 | ClassNN: ATL:10EE002010 | hWndChild: DT5_PVCombo | hWndChild: 2889052 | hWndParent: 984536 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 218 | ClassNN: DT5_PVCombo10 | hWndChild: DT5_PVCombo | hWndChild: 2889052 | hWndParent: 2495796 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 219 | ClassNN: ScrollBar11 | hWndChild:  | hWndChild: 0 | hWndParent: 2889052 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 220 | ClassNN: ThunderRT6UserControlDC50 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1250654 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 221 | ClassNN: ThunderRT6UserControlDC51 | hWndChild: ThunderRT6UserControlDC | hWndChild: 595446 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 222 | ClassNN: ThunderRT6UserControlDC52 | hWndChild: ThunderRT6UserControlDC | hWndChild: 923082 | hWndParent: 856486 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 223 | ClassNN: AfxFrameOrView4229 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 224 | ClassNN: AfxWnd4228 | hWndChild: AfxWnd42 | hWndChild: 462542 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 225 | ClassNN: AfxWnd4229 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 226 | ClassNN: ToolbarWindow325 | hWndChild: ToolbarWindow32 | hWndChild: 528096 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 227 | ClassNN: AfxWnd4230 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 228 | ClassNN: AfxFrameOrView4230 | hWndChild:  | hWndChild: 0 | hWndParent: 463392 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 229 | ClassNN: AfxOleControl426 | hWndChild: AfxFrameOrView42 | hWndChild: 593730 | hWndParent: 593758 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 230 | ClassNN: AfxWnd4231 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 231 | ClassNN: AfxWnd4232 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 232 | ClassNN: AfxWnd4233 | hWndChild: AfxWnd42 | hWndChild: 659244 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 233 | ClassNN: AfxFrameOrView4231 | hWndChild: SysTabControl32 | hWndChild: 594376 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 234 | ClassNN: SysTreeView327 | hWndChild: SysTreeView32 | hWndChild: 463398 | hWndParent: 593730 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 235 | ClassNN: SysTabControl323 | hWndChild: SysTabControl32 | hWndChild: 594376 | hWndParent: 593730 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 236 | ClassNN: SysTreeView328 | hWndChild:  | hWndChild: 0 | hWndParent: 593730 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 237 | ClassNN: AfxFrameOrView4232 | hWndChild: AfxFrameOrView42 | hWndChild: 659040 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 238 | ClassNN: AfxFrameOrView4233 | hWndChild: AfxFrameOrView42 | hWndChild: 724582 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 239 | ClassNN: PVSPLITTERWNDCLASS11 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 724542 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 240 | ClassNN: PVSPLITTERWNDCLASS12 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 724842 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 241 | ClassNN: Edit11 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 242 | ClassNN: SysListView326 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 243 | ClassNN: Edit12 | hWndChild:  | hWndChild: 0 | hWndParent: 528946 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 244 | ClassNN: AfxFrameOrView4234 | hWndChild: AfxFrameOrView42 | hWndChild: 528948 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 245 | ClassNN: AfxFrameOrView4235 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 246 | ClassNN: AfxWnd4234 | hWndChild: AfxWnd42 | hWndChild: 1049990 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 247 | ClassNN: AfxWnd4235 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 248 | ClassNN: ToolbarWindow326 | hWndChild: ToolbarWindow32 | hWndChild: 790376 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 249 | ClassNN: AfxWnd4236 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 250 | ClassNN: AfxFrameOrView4236 | hWndChild:  | hWndChild: 0 | hWndParent: 528290 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 251 | ClassNN: ThunderRT6UserControlDC53 | hWndChild: ThunderRT6PictureBoxDC | hWndChild: 332186 | hWndParent: 593758 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 252 | ClassNN: ThunderRT6PictureBoxDC1 | hWndChild: ThunderRT6PictureBoxDC | hWndChild: 332186 | hWndParent: 332182 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 253 | ClassNN: ThunderRT6CommandButton3 | hWndChild: ThunderRT6CommandButton | hWndChild: 332180 | hWndParent: 332186 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 254 | ClassNN: ThunderRT6CommandButton4 | hWndChild: ThunderRT6CommandButton | hWndChild: 332184 | hWndParent: 332186 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 255 | ClassNN: ThunderRT6CommandButton5 | hWndChild: ThunderRT6CommandButton | hWndChild: 332188 | hWndParent: 332186 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 256 | ClassNN: ThunderRT6CommandButton6 | hWndChild: ThunderRT6CommandButton | hWndChild: 332196 | hWndParent: 332186 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 257 | ClassNN: ThunderRT6CommandButton7 | hWndChild: ThunderRT6CommandButton | hWndChild: 332192 | hWndParent: 332186 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 258 | ClassNN: ThunderRT6CommandButton8 | hWndChild: ThunderRT6CommandButton | hWndChild: 332190 | hWndParent: 332186 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670
Index: 259 | ClassNN: SSTracker1 | hWndChild:  | hWndChild: 0 | hWndParent: 396402 | hWndRoot: 396402 | hWndOwner: 0 | CursorHwnd: 71670

Index: 1 | ClassNN: MDIClient1 | hWndChild: ThunderRT6FormDC | hWndChild: 462488 | hWndParent: 4066930 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 2 | ClassNN: ThunderRT6FormDC1 | hWndChild: ThunderRT6UserControlDC | hWndChild: 527438 | hWndParent: 2165322 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 3 | ClassNN: AfxOleControl421 | hWndChild: AfxWnd42 | hWndChild: 989722 | hWndParent: 462488 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 4 | ClassNN: AfxWnd421 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 5 | ClassNN: AfxWnd422 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 6 | ClassNN: AfxWnd423 | hWndChild: AfxWnd42 | hWndChild: 989722 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 7 | ClassNN: AfxFrameOrView421 | hWndChild: SysTreeView32 | hWndChild: 6164922 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 8 | ClassNN: SysTreeView321 | hWndChild: SysTreeView32 | hWndChild: 6164922 | hWndParent: 593338 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 9 | ClassNN: AfxFrameOrView422 | hWndChild: AfxFrameOrView42 | hWndChild: 3150564 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 10 | ClassNN: AfxFrameOrView423 | hWndChild: AfxFrameOrView42 | hWndChild: 1186644 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 11 | ClassNN: PVSPLITTERWNDCLASS1 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 2233968 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 12 | ClassNN: PVSPLITTERWNDCLASS2 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 4657636 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 13 | ClassNN: Edit1 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 14 | ClassNN: SysListView321 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 15 | ClassNN: Edit2 | hWndChild:  | hWndChild: 0 | hWndParent: 1313058 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 16 | ClassNN: AfxFrameOrView424 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 17 | ClassNN: AfxFrameOrView425 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 18 | ClassNN: AfxWnd424 | hWndChild: AfxWnd42 | hWndChild: 3477302 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 19 | ClassNN: AfxWnd425 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 20 | ClassNN: ToolbarWindow321 | hWndChild: ToolbarWindow32 | hWndChild: 335470 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 21 | ClassNN: AfxWnd426 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 22 | ClassNN: AfxFrameOrView426 | hWndChild:  | hWndChild: 0 | hWndParent: 2166616 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 23 | ClassNN: AfxOleControl422 | hWndChild: AfxWnd42 | hWndChild: 334726 | hWndParent: 462488 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 24 | ClassNN: AfxWnd427 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 25 | ClassNN: AfxWnd428 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 26 | ClassNN: AfxWnd429 | hWndChild: AfxWnd42 | hWndChild: 334726 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 27 | ClassNN: AfxFrameOrView427 | hWndChild: SysTreeView32 | hWndChild: 3607728 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 28 | ClassNN: SysTreeView322 | hWndChild: SysTreeView32 | hWndChild: 3607728 | hWndParent: 2623188 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 29 | ClassNN: AfxFrameOrView428 | hWndChild: AfxFrameOrView42 | hWndChild: 531336 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 30 | ClassNN: AfxFrameOrView429 | hWndChild: AfxFrameOrView42 | hWndChild: 465822 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 31 | ClassNN: PVSPLITTERWNDCLASS3 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 4263162 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 32 | ClassNN: PVSPLITTERWNDCLASS4 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 662390 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 33 | ClassNN: Edit3 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 34 | ClassNN: SysListView322 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 35 | ClassNN: Edit4 | hWndChild:  | hWndChild: 0 | hWndParent: 4331572 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 36 | ClassNN: AfxFrameOrView4210 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 37 | ClassNN: AfxFrameOrView4211 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 38 | ClassNN: AfxWnd4210 | hWndChild: AfxWnd42 | hWndChild: 1120754 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 39 | ClassNN: AfxWnd4211 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 40 | ClassNN: ToolbarWindow322 | hWndChild: ToolbarWindow32 | hWndChild: 1578054 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 41 | ClassNN: AfxWnd4212 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 42 | ClassNN: AfxFrameOrView4212 | hWndChild:  | hWndChild: 0 | hWndParent: 2103410 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 43 | ClassNN: AfxOleControl423 | hWndChild: AfxFrameOrView42 | hWndChild: 20581202 | hWndParent: 462488 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 44 | ClassNN: AfxWnd4213 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 45 | ClassNN: AfxWnd4214 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 46 | ClassNN: AfxWnd4215 | hWndChild: AfxWnd42 | hWndChild: 466546 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 47 | ClassNN: AfxFrameOrView4213 | hWndChild: SysTreeView32 | hWndChild: 400700 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 48 | ClassNN: SysTreeView323 | hWndChild: SysTreeView32 | hWndChild: 400700 | hWndParent: 20581202 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 49 | ClassNN: AfxFrameOrView4214 | hWndChild: AfxFrameOrView42 | hWndChild: 262488 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 50 | ClassNN: AfxFrameOrView4215 | hWndChild: AfxFrameOrView42 | hWndChild: 393764 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 51 | ClassNN: PVSPLITTERWNDCLASS5 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 3415118 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 52 | ClassNN: PVSPLITTERWNDCLASS6 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 4332522 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 53 | ClassNN: Edit5 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 54 | ClassNN: SysListView323 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 55 | ClassNN: Edit6 | hWndChild:  | hWndChild: 0 | hWndParent: 2821354 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 56 | ClassNN: AfxFrameOrView4216 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 57 | ClassNN: AfxFrameOrView4217 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 58 | ClassNN: AfxWnd4216 | hWndChild: AfxWnd42 | hWndChild: 334994 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 59 | ClassNN: AfxWnd4217 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 60 | ClassNN: ToolbarWindow323 | hWndChild: ToolbarWindow32 | hWndChild: 400688 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 61 | ClassNN: AfxWnd4218 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 62 | ClassNN: AfxFrameOrView4218 | hWndChild:  | hWndChild: 0 | hWndParent: 328512 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 63 | ClassNN: AfxOleControl424 | hWndChild: AfxWnd42 | hWndChild: 7019602 | hWndParent: 462488 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 64 | ClassNN: AfxWnd4219 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 65 | ClassNN: AfxWnd4220 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 66 | ClassNN: AfxWnd4221 | hWndChild: SysTabControl32 | hWndChild: 4725488 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 67 | ClassNN: SysTabControl321 | hWndChild: SysTabControl32 | hWndChild: 4725488 | hWndParent: 7019602 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 68 | ClassNN: AfxFrameOrView4219 | hWndChild: SysTreeView32 | hWndChild: 393682 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 69 | ClassNN: SysTreeView324 | hWndChild: SysTreeView32 | hWndChild: 393682 | hWndParent: 462742 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 70 | ClassNN: AfxFrameOrView4220 | hWndChild: AfxFrameOrView42 | hWndChild: 4656376 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 71 | ClassNN: AfxFrameOrView4221 | hWndChild: AfxFrameOrView42 | hWndChild: 920944 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 72 | ClassNN: PVSPLITTERWNDCLASS7 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 3804146 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 73 | ClassNN: PVSPLITTERWNDCLASS8 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 1051986 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 74 | ClassNN: Edit7 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 75 | ClassNN: SysListView324 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 76 | ClassNN: Edit8 | hWndChild:  | hWndChild: 0 | hWndParent: 262498 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 77 | ClassNN: AfxFrameOrView4222 | hWndChild: AfxFrameOrView42 | hWndChild: 1646360 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 78 | ClassNN: AfxFrameOrView4223 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 79 | ClassNN: AfxWnd4222 | hWndChild: AfxWnd42 | hWndChild: 4789436 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 80 | ClassNN: AfxWnd4223 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 81 | ClassNN: ToolbarWindow324 | hWndChild: ToolbarWindow32 | hWndChild: 8655408 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 82 | ClassNN: AfxWnd4224 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 83 | ClassNN: AfxFrameOrView4224 | hWndChild:  | hWndChild: 0 | hWndParent: 266104 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 84 | ClassNN: AfxOleControl425 | hWndChild: AfxFrameOrView42 | hWndChild: 262700 | hWndParent: 462488 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 85 | ClassNN: AfxWnd4225 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 86 | ClassNN: Shell Embedding1 | hWndChild:  | hWndChild: 0 | hWndParent: 330870 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 87 | ClassNN: AfxWnd4226 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 88 | ClassNN: AfxWnd4227 | hWndChild: SysTabControl32 | hWndChild: 1120666 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 89 | ClassNN: SysTabControl322 | hWndChild: SysTabControl32 | hWndChild: 1120666 | hWndParent: 266138 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 90 | ClassNN: AfxFrameOrView4225 | hWndChild: SysTabControl32 | hWndChild: 4789206 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 91 | ClassNN: SysTreeView325 | hWndChild: SysTreeView32 | hWndChild: 331638 | hWndParent: 262700 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 92 | ClassNN: SysTabControl323 | hWndChild: SysTabControl32 | hWndChild: 4789206 | hWndParent: 262700 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 93 | ClassNN: SysTreeView326 | hWndChild:  | hWndChild: 0 | hWndParent: 262700 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 94 | ClassNN: AfxFrameOrView4226 | hWndChild: AfxFrameOrView42 | hWndChild: 19406036 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 95 | ClassNN: AfxFrameOrView4227 | hWndChild: AfxFrameOrView42 | hWndChild: 266110 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 96 | ClassNN: PVSPLITTERWNDCLASS9 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 266098 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 97 | ClassNN: PVSPLITTERWNDCLASS10 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 462482 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 98 | ClassNN: Edit9 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 99 | ClassNN: SysListView325 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 100 | ClassNN: Edit10 | hWndChild:  | hWndChild: 0 | hWndParent: 266112 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 101 | ClassNN: AfxFrameOrView4228 | hWndChild: ThunderRT6FormDC | hWndChild: 462802 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 102 | ClassNN: ThunderRT6FormDC2 | hWndChild: ThunderRT6FormDC | hWndChild: 462802 | hWndParent: 266128 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 103 | ClassNN: ProtoViewResizer1 | hWndChild:  | hWndChild: 0 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 104 | ClassNN: ThunderRT6UserControlDC1 | hWndChild: ThunderRT6UserControlDC | hWndChild: 1248262 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 105 | ClassNN: ThunderRT6UserControlDC2 | hWndChild: ThunderRT6UserControlDC | hWndChild: 723964 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 106 | ClassNN: ThunderRT6OptionButton1 | hWndChild: ThunderRT6OptionButton | hWndChild: 1772520 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 107 | ClassNN: ThunderRT6OptionButton2 | hWndChild: ThunderRT6OptionButton | hWndChild: 1246870 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 108 | ClassNN: SSActiveTabsWndClass1 | hWndChild:  | hWndChild: 0 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 109 | ClassNN: SSTabPanelWndClass1 | hWndChild: SSTabPanelWndClass | hWndChild: 527420 | hWndParent: 723580 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 110 | ClassNN: ThunderRT6UserControlDC3 | hWndChild: ThunderRT6CommandButton | hWndChild: 658312 | hWndParent: 723580 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 111 | ClassNN: ThunderRT6CommandButton1 | hWndChild: ThunderRT6CommandButton | hWndChild: 658312 | hWndParent: 658142 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 112 | ClassNN: ThunderRT6UserControlDC4 | hWndChild: Toolbar20WndClass | hWndChild: 1769972 | hWndParent: 723580 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 113 | ClassNN: TX_STATUSBAR111 | hWndChild: TX_STATUSBAR11 | hWndChild: 527454 | hWndParent: 723978 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 114 | ClassNN: ThunderRT6Timer1 | hWndChild:  | hWndChild: 0 | hWndParent: 723978 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 115 | ClassNN: TX111 | hWndChild: TX11 | hWndChild: 459256 | hWndParent: 723978 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 116 | ClassNN: Toolbar20WndClass1 | hWndChild: msvb_lib_toolbar | hWndChild: 1641014 | hWndParent: 723978 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 117 | ClassNN: msvb_lib_toolbar1 | hWndChild: msvb_lib_toolbar | hWndChild: 1641014 | hWndParent: 1769972 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 118 | ClassNN: ThunderRT6UserControlDC5 | hWndChild: ThunderRT6CommandButton | hWndChild: 526800 | hWndParent: 723580 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 119 | ClassNN: ThunderRT6CommandButton2 | hWndChild: ThunderRT6CommandButton | hWndChild: 526800 | hWndParent: 789492 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 120 | ClassNN: ThunderRT6UserControlDC6 | hWndChild: ThunderRT6TextBox | hWndChild: 1710470 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 121 | ClassNN: ThunderRT6TextBox1 | hWndChild: ThunderRT6TextBox | hWndChild: 1710470 | hWndParent: 459316 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 122 | ClassNN: ThunderRT6UserControlDC7 | hWndChild: ThunderRT6TextBox | hWndChild: 1448348 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 123 | ClassNN: ThunderRT6TextBox2 | hWndChild: ThunderRT6TextBox | hWndChild: 1448348 | hWndParent: 465702 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 124 | ClassNN: ThunderRT6UserControlDC8 | hWndChild: ThunderRT6TextBox | hWndChild: 1709282 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 125 | ClassNN: ThunderRT6TextBox3 | hWndChild: ThunderRT6TextBox | hWndChild: 1709282 | hWndParent: 1251670 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 126 | ClassNN: ThunderRT6UserControlDC9 | hWndChild: ThunderRT6UserControlDC | hWndChild: 989408 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 127 | ClassNN: ThunderRT6UserControlDC10 | hWndChild: ThunderRT6UserControlDC | hWndChild: 2889774 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 128 | ClassNN: ThunderRT6UserControlDC11 | hWndChild: ThunderRT6UserControlDC | hWndChild: 989532 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 129 | ClassNN: ThunderRT6UserControlDC12 | hWndChild: ThunderRT6TextBox | hWndChild: 659104 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 130 | ClassNN: ThunderRT6TextBox4 | hWndChild: ThunderRT6TextBox | hWndChild: 659104 | hWndParent: 1382694 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 131 | ClassNN: ThunderRT6UserControlDC13 | hWndChild: ThunderRT6TextBox | hWndChild: 400158 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 132 | ClassNN: ThunderRT6TextBox5 | hWndChild: ThunderRT6TextBox | hWndChild: 400158 | hWndParent: 400160 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 133 | ClassNN: ThunderRT6UserControlDC14 | hWndChild: ThunderRT6UserControlDC | hWndChild: 923998 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 134 | ClassNN: ThunderRT6UserControlDC15 | hWndChild: ThunderRT6UserControlDC | hWndChild: 400164 | hWndParent: 462802 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 135 | ClassNN: AfxFrameOrView4229 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 136 | ClassNN: AfxWnd4228 | hWndChild: AfxWnd42 | hWndChild: 266130 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 137 | ClassNN: AfxWnd4229 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 138 | ClassNN: ToolbarWindow325 | hWndChild: ToolbarWindow32 | hWndChild: 462418 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 139 | ClassNN: AfxWnd4230 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 140 | ClassNN: AfxFrameOrView4230 | hWndChild:  | hWndChild: 0 | hWndParent: 461966 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 141 | ClassNN: AfxOleControl426 | hWndChild: AfxFrameOrView42 | hWndChild: 330904 | hWndParent: 462488 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 142 | ClassNN: AfxWnd4231 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 143 | ClassNN: AfxWnd4232 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 144 | ClassNN: AfxWnd4233 | hWndChild: AfxWnd42 | hWndChild: 330918 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 145 | ClassNN: AfxFrameOrView4231 | hWndChild: SysTreeView32 | hWndChild: 330866 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 146 | ClassNN: SysTreeView327 | hWndChild: SysTreeView32 | hWndChild: 330866 | hWndParent: 330904 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 147 | ClassNN: AfxFrameOrView4232 | hWndChild: AfxFrameOrView42 | hWndChild: 330898 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 148 | ClassNN: AfxFrameOrView4233 | hWndChild: AfxFrameOrView42 | hWndChild: 330902 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 149 | ClassNN: PVSPLITTERWNDCLASS11 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 330876 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 150 | ClassNN: PVSPLITTERWNDCLASS12 | hWndChild: PVSPLITTERWNDCLASS | hWndChild: 330900 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 151 | ClassNN: Edit11 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 152 | ClassNN: SysListView326 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 153 | ClassNN: Edit12 | hWndChild:  | hWndChild: 0 | hWndParent: 1314508 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 154 | ClassNN: AfxFrameOrView4234 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 155 | ClassNN: AfxFrameOrView4235 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 156 | ClassNN: AfxWnd4234 | hWndChild: AfxWnd42 | hWndChild: 330862 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 157 | ClassNN: AfxWnd4235 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 158 | ClassNN: ToolbarWindow326 | hWndChild: ToolbarWindow32 | hWndChild: 330858 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 159 | ClassNN: AfxWnd4236 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 160 | ClassNN: AfxFrameOrView4236 | hWndChild:  | hWndChild: 0 | hWndParent: 396880 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 161 | ClassNN: ThunderRT6UserControlDC16 | hWndChild: ThunderRT6PictureBoxDC | hWndChild: 335484 | hWndParent: 462488 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 162 | ClassNN: ThunderRT6PictureBoxDC1 | hWndChild: ThunderRT6PictureBoxDC | hWndChild: 335484 | hWndParent: 527438 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 163 | ClassNN: ThunderRT6CommandButton3 | hWndChild: ThunderRT6CommandButton | hWndChild: 5378520 | hWndParent: 335484 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 164 | ClassNN: ThunderRT6CommandButton4 | hWndChild: ThunderRT6CommandButton | hWndChild: 400994 | hWndParent: 335484 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 165 | ClassNN: ThunderRT6CommandButton5 | hWndChild: ThunderRT6CommandButton | hWndChild: 1643706 | hWndParent: 335484 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 166 | ClassNN: ThunderRT6CommandButton6 | hWndChild: ThunderRT6CommandButton | hWndChild: 4133586 | hWndParent: 335484 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 167 | ClassNN: ThunderRT6CommandButton7 | hWndChild: ThunderRT6CommandButton | hWndChild: 461842 | hWndParent: 335484 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 168 | ClassNN: ThunderRT6CommandButton8 | hWndChild: ThunderRT6CommandButton | hWndChild: 401074 | hWndParent: 335484 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
Index: 169 | ClassNN: SSTracker1 | hWndChild:  | hWndChild: 0 | hWndParent: 4066930 | hWndRoot: 4066930 | hWndOwner: 0 | CursorHwnd: 4066930
*/


WinGetPos, PosX, PosY, SizeW, SizeH, ahk_id %Gui1UniqueID%
IniWrite, x%PosX% y%PosY% , %IniFile%, Settings, Gui1Pos
IniWrite, %SizeW% , %IniFile%, Settings, Gui1W
IniWrite, %SizeH% , %IniFile%, Settings, Gui1H
IniWrite, %IntGuiStyle%, %IniFile%, Settings, IntGuiStyle
IniWrite, %BolResizeTreeH%, %IniFile%, Settings, BolResizeTreeH
IniWrite, %BolRollUpDown%,  %IniFile%, Settings, BolRollUpDown
IniWrite, %BolAlwaysOnTop%, %IniFile%, Settings, BolAlwaysOnTop
IniWrite, %StrFontName%,    %IniFile%, Settings, StrFontName
IniWrite, %IntFontSize%,    %IniFile%, Settings, IntFontSize
FileAppend, `n`n, %IniFile%
return

:*:WM_NULL::0x0000
:*:WM_CREATE::0x0001
:*:WM_DESTROY::0x0002
:*:WM_MOVE::0x0003
:*:WM_SIZE::0x0005
:*:WM_ACTIVATE::0x0006
:*:WM_SETFOCUS::0x0007
:*:WM_KILLFOCUS::0x0008
:*:WM_ENABLE::0x000A
:*:WM_SETREDRAW::0x000B
:*:WM_SETTEXT::0x000C
:*:WM_GETTEXT::0x000D
:*:WM_GETTEXTLENGTH::0x000E
:*:WM_PAINT::0x000F
:*:WM_CLOSE::0x0010
:*:WM_QUERYENDSESSION::0x0011
:*:WM_QUIT::0x0012
:*:WM_QUERYOPEN::0x0013
:*:WM_ERASEBKGND::0x0014
:*:WM_SYSCOLORCHANGE::0x0015
:*:WM_ENDSESSION::0x0016
:*:WM_SYSTEMERROR::0x0017
:*:WM_SHOWWINDOW::0x0018
:*:WM_CTLCOLOR::0x0019
:*:WM_WININICHANGE::0x001A
:*:WM_SETTINGCHANGE::0x001A
:*:WM_DEVMODECHANGE::0x001B
:*:WM_ACTIVATEAPP::0x001C
:*:WM_FONTCHANGE::0x001D
:*:WM_TIMECHANGE::0x001E
:*:WM_CANCELMODE::0x001F
:*:WM_SETCURSOR::0x0020
:*:WM_MOUSEACTIVATE::0x0021
:*:WM_CHILDACTIVATE::0x0022
:*:WM_QUEUESYNC::0x0023
:*:WM_GETMINMAXINFO::0x0024
:*:WM_PAINTICON::0x0026
:*:WM_ICONERASEBKGND::0x0027
:*:WM_NEXTDLGCTL::0x0028
:*:WM_SPOOLERSTATUS::0x002A
:*:WM_DRAWITEM::0x002B
:*:WM_MEASUREITEM::0x002C
:*:WM_DELETEITEM::0x002D
:*:WM_VKEYTOITEM::0x002E
:*:WM_CHARTOITEM::0x002F

:*:WM_SETFONT::0x0030
:*:WM_GETFONT::0x0031
:*:WM_SETHOTKEY::0x0032
:*:WM_GETHOTKEY::0x0033
:*:WM_QUERYDRAGICON::0x0037
:*:WM_COMPAREITEM::0x0039
:*:WM_COMPACTING::0x0041
:*:WM_WINDOWPOSCHANGING::0x0046
:*:WM_WINDOWPOSCHANGED::0x0047
:*:WM_POWER::0x0048
:*:WM_COPYDATA::0x004A
:*:WM_CANCELJOURNAL::0x004B
:*:WM_NOTIFY::0x004E
:*:WM_INPUTLANGCHANGEREQUEST::0x0050
:*:WM_INPUTLANGCHANGE::0x0051
:*:WM_TCARD::0x0052
:*:WM_HELP::0x0053
:*:WM_USERCHANGED::0x0054
:*:WM_NOTIFYFORMAT::0x0055
:*:WM_CONTEXTMENU::0x007B
:*:WM_STYLECHANGING::0x007C
:*:WM_STYLECHANGED::0x007D
:*:WM_DISPLAYCHANGE::0x007E
:*:WM_GETICON::0x007F
:*:WM_SETICON::0x0080

:*:WM_NCCREATE::0x0081
:*:WM_NCDESTROY::0x0082
:*:WM_NCCALCSIZE::0x0083
:*:WM_NCHITTEST::0x0084
:*:WM_NCPAINT::0x0085
:*:WM_NCACTIVATE::0x0086
:*:WM_GETDLGCODE::0x0087
:*:WM_NCMOUSEMOVE::0x00A0
:*:WM_NCLBUTTONDOWN::0x00A1
:*:WM_NCLBUTTONUP::0x00A2
:*:WM_NCLBUTTONDBLCLK::0x00A3
:*:WM_NCRBUTTONDOWN::0x00A4
:*:WM_NCRBUTTONUP::0x00A5
:*:WM_NCRBUTTONDBLCLK::0x00A6
:*:WM_NCMBUTTONDOWN::0x00A7
:*:WM_NCMBUTTONUP::0x00A8
:*:WM_NCMBUTTONDBLCLK::0x00A9

:*:WM_KEYFIRST::0x0100
:*:WM_KEYDOWN::0x0100
:*:WM_KEYUP::0x0101
:*:WM_CHAR::0x0102
:*:WM_DEADCHAR::0x0103
:*:WM_SYSKEYDOWN::0x0104
:*:WM_SYSKEYUP::0x0105
:*:WM_SYSCHAR::0x0106
:*:WM_SYSDEADCHAR::0x0107
:*:WM_KEYLAST::0x0108

:*:WM_IME_STARTCOMPOSITION::0x010D
:*:WM_IME_ENDCOMPOSITION::0x010E
:*:WM_IME_COMPOSITION::0x010F
:*:WM_IME_KEYLAST::0x010F

:*:WM_INITDIALOG::0x0110
:*:WM_COMMAND::0x0111
:*:WM_SYSCOMMAND::0x0112
:*:WM_TIMER::0x0113
:*:WM_HSCROLL::0x0114
:*:WM_VSCROLL::0x0115
:*:WM_INITMENU::0x0116
:*:WM_INITMENUPOPUP::0x0117
:*:WM_MENUSELECT::0x011F
:*:WM_MENUCHAR::0x0120
:*:WM_ENTERIDLE::0x0121

:*:WM_CTLCOLORMSGBOX::0x0132
:*:WM_CTLCOLOREDIT::0x0133
:*:WM_CTLCOLORLISTBOX::0x0134
:*:WM_CTLCOLORBTN::0x0135
:*:WM_CTLCOLORDLG::0x0136
:*:WM_CTLCOLORSCROLLBAR::0x0137
:*:WM_CTLCOLORSTATIC::0x0138

:*:WM_MOUSEFIRST::0x0200
:*:WM_MOUSEMOVE::0x0200
:*:WM_LBUTTONDOWN::0x0201
:*:WM_LBUTTONUP::0x0202
:*:WM_LBUTTONDBLCLK::0x0203
:*:WM_RBUTTONDOWN::0x0204
:*:WM_RBUTTONUP::0x0205
:*:WM_RBUTTONDBLCLK::0x0206
:*:WM_MBUTTONDOWN::0x0207
:*:WM_MBUTTONUP::0x0208
:*:WM_MBUTTONDBLCLK::0x0209
:*:WM_MOUSEWHEEL::0x020A
:*:WM_MOUSEHWHEEL::0x020E

:*:WM_PARENTNOTIFY::0x0210
:*:WM_ENTERMENULOOP::0x0211
:*:WM_EXITMENULOOP::0x0212
:*:WM_NEXTMENU::0x0213
:*:WM_SIZING::0x0214
:*:WM_CAPTURECHANGED::0x0215
:*:WM_MOVING::0x0216
:*:WM_POWERBROADCAST::0x0218
:*:WM_DEVICECHANGE::0x0219

:*:WM_MDICREATE::0x0220
:*:WM_MDIDESTROY::0x0221
:*:WM_MDIACTIVATE::0x0222
:*:WM_MDIRESTORE::0x0223
:*:WM_MDINEXT::0x0224
:*:WM_MDIMAXIMIZE::0x0225
:*:WM_MDITILE::0x0226
:*:WM_MDICASCADE::0x0227
:*:WM_MDIICONARRANGE::0x0228
:*:WM_MDIGETACTIVE::0x0229
:*:WM_MDISETMENU::0x0230
:*:WM_ENTERSIZEMOVE::0x0231
:*:WM_EXITSIZEMOVE::0x0232
:*:WM_DROPFILES::0x0233
:*:WM_MDIREFRESHMENU::0x0234

:*:WM_IME_SETCONTEXT::0x0281
:*:WM_IME_NOTIFY::0x0282
:*:WM_IME_CONTROL::0x0283
:*:WM_IME_COMPOSITIONFULL::0x0284
:*:WM_IME_SELECT::0x0285
:*:WM_IME_CHAR::0x0286
:*:WM_IME_KEYDOWN::0x0290
:*:WM_IME_KEYUP::0x0291

:*:WM_MOUSEHOVER::0x02A1
:*:WM_NCMOUSELEAVE::0x02A2
:*:WM_MOUSELEAVE::0x02A3

:*:WM_CUT::0x0300
:*:WM_COPY::0x0301
:*:WM_PASTE::0x0302
:*:WM_CLEAR::0x0303
:*:WM_UNDO::0x0304

:*:WM_RENDERFORMAT::0x0305
:*:WM_RENDERALLFORMATS::0x0306
:*:WM_DESTROYCLIPBOARD::0x0307
:*:WM_DRAWCLIPBOARD::0x0308
:*:WM_PAINTCLIPBOARD::0x0309
:*:WM_VSCROLLCLIPBOARD::0x030A
:*:WM_SIZECLIPBOARD::0x030B
:*:WM_ASKCBFORMATNAME::0x030C
:*:WM_CHANGECBCHAIN::0x030D
:*:WM_HSCROLLCLIPBOARD::0x030E
:*:WM_QUERYNEWPALETTE::0x030F
:*:WM_PALETTEISCHANGING::0x0310
:*:WM_PALETTECHANGED::0x0311

:*:WM_HOTKEY::0x0312
:*:WM_PRINT::0x0317
:*:WM_PRINTCLIENT::0x0318

:*:WM_HANDHELDFIRST::0x0358
:*:WM_HANDHELDLAST::0x035F
:*:WM_PENWINFIRST::0x0380
:*:WM_PENWINLAST::0x038F
:*:WM_COALESCE_FIRST::0x0390
:*:WM_COALESCE_LAST::0x039F
:*:WM_DDE_FIRST::0x03E0
:*:WM_DDE_INITIATE::0x03E0
:*:WM_DDE_TERMINATE::0x03E1
:*:WM_DDE_ADVISE::0x03E2
:*:WM_DDE_UNADVISE::0x03E3
:*:WM_DDE_ACK::0x03E4
:*:WM_DDE_DATA::0x03E5
:*:WM_DDE_REQUEST::0x03E6
:*:WM_DDE_POKE::0x03E7
:*:WM_DDE_EXECUTE::0x03E8
:*:WM_DDE_LAST::0x03E8

:*:WM_USER::0x0400
:*:WM_APP::0x8000
:*:VK_LBUTTON::0x01
;============================== End Script ==============================