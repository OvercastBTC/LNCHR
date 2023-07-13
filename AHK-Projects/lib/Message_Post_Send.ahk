﻿;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
#Warn All, OutputDebug
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

; ================= Global Declares - Horizon ==================

;global list of all WM_ stuff
WM_NULL:=0x0000
WM_CREATE:=0x0001
WM_DESTROY:=0x0002
WM_MOVE:=0x0003
WM_SIZE:=0x0005
WM_ACTIVATE:=0x0006
WM_SETFOCUS:=0x0007
WM_KILLFOCUS:=0x0008
WM_ENABLE:=0x000A
WM_SETREDRAW:=0x000B
WM_SETTEXT:=0x000C
WM_GETTEXT:=0x000D
WM_GETTEXTLENGTH:=0x000E
WM_PAINT:=0x000F
WM_CLOSE:=0x0010
WM_QUERYENDSESSION:=0x0011
WM_QUIT:=0x0012
WM_QUERYOPEN:=0x0013
WM_ERASEBKGND:=0x0014
WM_SYSCOLORCHANGE:=0x0015
WM_ENDSESSION:=0x0016
WM_SYSTEMERROR:=0x0017
WM_SHOWWINDOW:=0x0018
WM_CTLCOLOR:=0x0019
WM_WININICHANGE:=0x001A
WM_SETTINGCHANGE:=0x001A
WM_DEVMODECHANGE:=0x001B
WM_ACTIVATEAPP:=0x001C
WM_FONTCHANGE:=0x001D
WM_TIMECHANGE:=0x001E
WM_CANCELMODE:=0x001F
WM_SETCURSOR:=0x0020
WM_MOUSEACTIVATE:=0x0021
WM_CHILDACTIVATE:=0x0022
WM_QUEUESYNC:=0x0023
WM_GETMINMAXINFO:=0x0024
WM_PAINTICON:=0x0026
WM_ICONERASEBKGND:=0x0027
WM_NEXTDLGCTL:=0x0028
WM_SPOOLERSTATUS:=0x002A
WM_DRAWITEM:=0x002B
WM_MEASUREITEM:=0x002C
WM_DELETEITEM:=0x002D
WM_VKEYTOITEM:=0x002E
WM_CHARTOITEM:=0x002F

WM_SETFONT:=0x0030
WM_GETFONT:=0x0031
WM_SETHOTKEY:=0x0032
WM_GETHOTKEY:=0x0033
WM_QUERYDRAGICON:=0x0037
WM_COMPAREITEM:=0x0039
WM_COMPACTING:=0x0041
WM_WINDOWPOSCHANGING:=0x0046
WM_WINDOWPOSCHANGED:=0x0047
WM_POWER:=0x0048
WM_COPYDATA:=0x004A
WM_CANCELJOURNAL:=0x004B
WM_NOTIFY:=0x004E
WM_INPUTLANGCHANGEREQUEST:=0x0050
WM_INPUTLANGCHANGE:=0x0051
WM_TCARD:=0x0052
WM_HELP:=0x0053
WM_USERCHANGED:=0x0054
WM_NOTIFYFORMAT:=0x0055
WM_CONTEXTMENU:=0x007B
WM_STYLECHANGING:=0x007C
WM_STYLECHANGED:=0x007D
WM_DISPLAYCHANGE:=0x007E
WM_GETICON:=0x007F
WM_SETICON:=0x0080

WM_NCCREATE:=0x0081
WM_NCDESTROY:=0x0082
WM_NCCALCSIZE:=0x0083
WM_NCHITTEST:=0x0084
WM_NCPAINT:=0x0085
WM_NCACTIVATE:=0x0086
WM_GETDLGCODE:=0x0087
WM_NCMOUSEMOVE:=0x00A0
WM_NCLBUTTONDOWN:=0x00A1
WM_NCLBUTTONUP:=0x00A2
WM_NCLBUTTONDBLCLK:=0x00A3
WM_NCRBUTTONDOWN:=0x00A4
WM_NCRBUTTONUP:=0x00A5
WM_NCRBUTTONDBLCLK:=0x00A6
WM_NCMBUTTONDOWN:=0x00A7
WM_NCMBUTTONUP:=0x00A8
WM_NCMBUTTONDBLCLK:=0x00A9

WM_KEYFIRST:=0x0100
WM_KEYDOWN:=0x0100
WM_KEYUP:=0x0101
WM_CHAR:=0x0102
WM_DEADCHAR:=0x0103
WM_SYSKEYDOWN:=0x0104
WM_SYSKEYUP:=0x0105
WM_SYSCHAR:=0x0106
WM_SYSDEADCHAR:=0x0107
WM_KEYLAST:=0x0108

WM_IME_STARTCOMPOSITION:=0x010D
WM_IME_ENDCOMPOSITION:=0x010E
WM_IME_COMPOSITION:=0x010F
WM_IME_KEYLAST:=0x010F

WM_INITDIALOG:=0x0110
WM_COMMAND:=0x0111
WM_SYSCOMMAND:=0x0112
WM_TIMER:=0x0113
WM_HSCROLL:=0x0114
WM_VSCROLL:=0x0115
WM_INITMENU:=0x0116
WM_INITMENUPOPUP:=0x0117
WM_MENUSELECT:=0x011F
WM_MENUCHAR:=0x0120
WM_ENTERIDLE:=0x0121

WM_CTLCOLORMSGBOX:=0x0132
WM_CTLCOLOREDIT:=0x0133
WM_CTLCOLORLISTBOX:=0x0134
WM_CTLCOLORBTN:=0x0135
WM_CTLCOLORDLG:=0x0136
WM_CTLCOLORSCROLLBAR:=0x0137
WM_CTLCOLORSTATIC:=0x0138

WM_MOUSEFIRST:=0x0200
WM_MOUSEMOVE:=0x0200
WM_LBUTTONDOWN:=0x0201
WM_LBUTTONUP:=0x0202
WM_LBUTTONDBLCLK:=0x0203
WM_RBUTTONDOWN:=0x0204
WM_RBUTTONUP:=0x0205
WM_RBUTTONDBLCLK:=0x0206
WM_MBUTTONDOWN:=0x0207
WM_MBUTTONUP:=0x0208
WM_MBUTTONDBLCLK:=0x0209
WM_MOUSEWHEEL:=0x020A
WM_MOUSEHWHEEL:=0x020E

WM_PARENTNOTIFY:=0x0210
WM_ENTERMENULOOP:=0x0211
WM_EXITMENULOOP:=0x0212
WM_NEXTMENU:=0x0213
WM_SIZING:=0x0214
WM_CAPTURECHANGED:=0x0215
WM_MOVING:=0x0216
WM_POWERBROADCAST:=0x0218
WM_DEVICECHANGE:=0x0219

WM_MDICREATE:=0x0220
WM_MDIDESTROY:=0x0221
WM_MDIACTIVATE:=0x0222
WM_MDIRESTORE:=0x0223
WM_MDINEXT:=0x0224
WM_MDIMAXIMIZE:=0x0225
WM_MDITILE:=0x0226
WM_MDICASCADE:=0x0227
WM_MDIICONARRANGE:=0x0228
WM_MDIGETACTIVE:=0x0229
WM_MDISETMENU:=0x0230
WM_ENTERSIZEMOVE:=0x0231
WM_EXITSIZEMOVE:=0x0232
WM_DROPFILES:=0x0233
WM_MDIREFRESHMENU:=0x0234

WM_IME_SETCONTEXT:=0x0281
WM_IME_NOTIFY:=0x0282
WM_IME_CONTROL:=0x0283
WM_IME_COMPOSITIONFULL:=0x0284
WM_IME_SELECT:=0x0285
WM_IME_CHAR:=0x0286
WM_IME_KEYDOWN:=0x0290
WM_IME_KEYUP:=0x0291

WM_MOUSEHOVER:=0x02A1
WM_NCMOUSELEAVE:=0x02A2
WM_MOUSELEAVE:=0x02A3

WM_CUT:=0x0300
WM_COPY:=0x0301
WM_PASTE:=0x0302
WM_CLEAR:=0x0303
WM_UNDO:=0x0304

WM_RENDERFORMAT:=0x0305
WM_RENDERALLFORMATS:=0x0306
WM_DESTROYCLIPBOARD:=0x0307
WM_DRAWCLIPBOARD:=0x0308
WM_PAINTCLIPBOARD:=0x0309
WM_VSCROLLCLIPBOARD:=0x030A
WM_SIZECLIPBOARD:=0x030B
WM_ASKCBFORMATNAME:=0x030C
WM_CHANGECBCHAIN:=0x030D
WM_HSCROLLCLIPBOARD:=0x030E
WM_QUERYNEWPALETTE:=0x030F
WM_PALETTEISCHANGING:=0x0310
WM_PALETTECHANGED:=0x0311

WM_HOTKEY:=0x0312
WM_PRINT:=0x0317
WM_PRINTCLIENT:=0x0318

WM_HANDHELDFIRST:=0x0358
WM_HANDHELDLAST:=0x035F
WM_PENWINFIRST:=0x0380
WM_PENWINLAST:=0x038F
WM_COALESCE_FIRST:=0x0390
WM_COALESCE_LAST:=0x039F
WM_DDE_FIRST:=0x03E0
WM_DDE_INITIATE:=0x03E0
WM_DDE_TERMINATE:=0x03E1
WM_DDE_ADVISE:=0x03E2
WM_DDE_UNADVISE:=0x03E3
WM_DDE_ACK:=0x03E4
WM_DDE_DATA:=0x03E5
WM_DDE_REQUEST:=0x03E6
WM_DDE_POKE:=0x03E7
WM_DDE_EXECUTE:=0x03E8
WM_DDE_LAST:=0x03E8

WM_USER:=0x0400
WM_APP:=0x8000
VK_LBUTTON:=0x01
*/
;============================== ini Section ==============================

;ControlType: 50033 (Pane)
;LocalizedControlType: pane
;Name:
;Value:
;AutomationId:
;Boundingectangle: l: 362 t: 213 r: 1909 b: 1083
;ClassName: SSUltraGridWndClass
;...
;ProcessId: 2356

/* ; ini and gui stuffs
	
	
	SplitPath, A_ScriptName, , , , OutNameNoExt
	IniFile = %OutNameNoExt%.ini
	IniRead, Gui1Pos,        %IniFile%, Settings, Gui1Pos,        %A_Space%
	IniRead, Gui1W,          %IniFile%, Settings, Gui1W,          %A_Space%
	IniRead, Gui1H,          %IniFile%, Settings, Gui1H,          %A_Space%
	IniRead, BolResizeTreeH, %IniFile%, Settings, BolResizeTreeH, 1
	IniRead, BolRollUpDown,  %IniFile%, Settings, BolRollUpDown,  0
	IniRead, BolAlwaysOnTop, %IniFile%, Settings, BolAlwaysOnTop, 1
	IniRead, IntGuiStyle,    %IniFile%, Settings, IntGuiStyle,    1
	IniRead, StrFontName,    %IniFile%, Settings, StrFontName,    Times New Roman
	IniRead, IntFontSize,    %IniFile%, Settings, IntFontSize,    11
	;/*
	Gui, Destroy
	
	
	Gui, PM_SM:New,, Post/SendMessage
	Gui,+AlwaysOnTop +Caption +Border +Resize +SysMenu +Theme
	Gui,Color,Gray
	Gui,Font,s10 Q4, Segoe UI Black
	
	Gui, Add, Text, xm,Enter Msg #: (WM_ or 0x)
	Gui, Add, Edit, Section vMsg xm,					;Message box for Msg
	Gui, Add, Text,section xm,wParam (optional):
	Gui, Add, Edit, vWParam xm,
	Gui, Add, Text,section R1 xm,lParam (optional):
	Gui, Add, Edit, vLParam xm,
	Gui, Add, Text,Section xm,Control ID (optional):
	Gui, Add, Edit, vControlID xm,
	Gui, Add, Text,Section xm,Window
	Gui, Add, Edit, vWindow gWindow xm,
	Gui, Add, Text, Section xm,Post (default) or Send?
	Gui, Add, Button, Section Default vPost gPost xm, &Post
	Gui, Add, Button, vSend gSend x+10, &Send
	
	Gui, Add, Text, section xm, Press "Enter" to continue...
	Gui, Add, Button, section gControlList xm, ControlList & HWND
	;Gui, Add, Button, section gTestM xm, Test Message
	Gui, Add, Button, section gCancel x+25, Cancel
	
	; disabled so the gui doesn't run for the moment
	;Gui, Submit,Nohide
	;Gui, Show, AutoSize
	;return
	
	
	Window:
	Gui, Submit, NoHide
	return
	
	ControlList:
	WinGet, cList, ControlList, ahk_class msvb_lib_toolbar1
	WinGet, cListH, ControlListHwnd, A
	MsgBox %cList%`n %cListH%
	return
	
	Post:
	GuiControlGet, Msg,,,Edit
	GuiControlGet, wParam,,,Edit
	GuiControlGet, lParam,,,Edit
	GuiControlGet, ControlID,,,Edit
	GuiControlGet, Window,,,Edit
	GuiControlGet, ControlList,,,Edit
	GuiControlGet, Send,,,Edit
	GuiControlGet, Post,,,Edit
	
	Gui, Submit,Nohide
	;WinActivate, ahk_class ThunderRT6MDIForm
	PostMessage, %Msg% , %wParam%, %lParam%, %Control%, %Window% ;, %WinText%, %ExcludeTitle%, %ExcludeText%
	;MsgBox Msg: %Msg%`nWParam: %wParam%`nlParam: %lParam%`nControlID: %ControlID%`nErrorLevel: %ErrorLevel%
	return
	
	Send:
	GuiControlGet, Msg,,,Edit
	GuiControlGet, wParam,,,Edit
	GuiControlGet, lParam,,,Edit
	GuiControlGet, ControlID,,,Edit
	GuiControlGet, Window,,,Edit
	GuiControlGet, ControlList,,,Edit
	GuiControlGet, Send,,,Edit
	GuiControlGet, Post,,,Edit
	
	Gui, Submit,Nohide
	;WinActivate, ahk_class ThunderRT6MDIForm
	SendMessage, %Msg% , %wParam%, %lParam%, %Control%, %Window% ;, %WinText%, %ExcludeTitle%, %ExcludeText%
	;MsgBox Msg: %Msg%`nWParam: %wParam%`nlParam: %lParam%`nControlID: %ControlID%`nErrorLevel: %ErrorLevel%
	return
*/

; === vars ===
hCtl:="msvb_lib_toolbar1"
tCtl:="TX11"
hzn:="ahk_exe hznhorizon.exe"
; ========== Human Element - Horizon - Bold ==============
^+2::
;#Persistent
SetTimer, WatchCursor5, 1000
WinGet, hWnd, ID, A
;ToolTip % hWnd
;WinGet, vCtlList, ControlList, % "ahk_id " hWnd
WinGet, vCtlList, ControlList, % "ahk_id " hWnd
vOutput := ""
return

WatchCursor5:
MouseGetPos, CursorX, CursorY , id, control,
ControlGetFocus, vCtlClassNN, A
ControlGet, hCtl, Hwnd,, % vCtlClassNN, A
WinGetClass, vCtlClass, % "ahk_id " hCtl
ControlGetText, vText, % vCtlClassNN, A
ControlGet, vText2, List,, % vCtlClassNN, A
;hWndChild := DllCall("RealChildWindowFromPoint", Ptr,hCtl, UInt,, Ptr)
;hWndParent := DllCall("DefMDIChildProcW", Ptr,hCtl, UInt,, Ptr) ;
;WinGet, chWnd, ID, 
;WinGetClass, vWinClass1, % "ahk_id " hWndChild
;WinGetClass, vWinClass2, % "ahk_id " hWndParent
;ToolTip % vWinClass1 " ID:"id "`r`n" vWinClass2
;return
;Clipboard:= % vText
Loop, Parse, vCtlList, `n
{
	vCtlClassNN := A_LoopField
	ControlGet, hCtl, Hwnd,, % vCtlClassNN, % "ahk_id " hWnd
	hWndParent := DllCall("GetAncestor", Ptr,hCtl, UInt,1, Ptr) ;GA_PARENT := 1
	hWndRoot := DllCall("GetAncestor", Ptr,hCtl, UInt,2, Ptr) ;GA_ROOT := 2
	hWndOwner := DllCall("GetWindow", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
	hWndChild := DllCall("RealChildWindowFromPoint", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
	CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
	WinGetClass, vWinClass1, % "ahk_id " hWndParent
	WinGetClass, vWinClass2, % "ahk_id " hWndRoot
	WinGetClass, vWinClass3, % "ahk_id " hWndOwner
	WinGetClass, vWinClass4, % "ahk_id " hWndChild
	WinGetClass, vWinClass5, % "ahk_id " CursorHwnd
	vOutput .= A_Index ": Focus: " vCtlClassNN "| Parent: " vWinClass1 "| Root: " vWinClass2 "| Owner: " vWinClass3 "| Child: " vWinClass4 "| WindowFromPoint: " vWinClass5 "`r`n"
}
;Clipboard := vOutput 
;ToolTip, % vCtlClassNN,x+1,0
ToolTip, % vOutput, xm,0
;MsgBox, % vOutput
return
*/
^+4::
Title:= "Post Send Message"
#If WinActive(%Title%)
; For performance and memory conservation, call RegisterCallback() only once for a given callback:
if not EnumAddress  ; Fast-mode is okay because it will be called only from this thread:
	^#T:: 
SetTimer, WatchCaret, % (Toggle:=!Toggle) ? "Off" : "On"
return
WatchCaret:
MouseGetPos,,,win,hCtl
If Toggle
	EnumAddress := RegisterCallback("EnumWindowsProc", "Fast")
Return

DetectHiddenWindows On  ; Due to fast-mode, this setting will go into effect for the callback too.

; Pass control to EnumWindows(), which calls the callback repeatedly:
DllCall("EnumWindows", "Ptr", EnumAddress, "Ptr", 0)
MsgBox % "Output: " Output  ; Display the information accumulated by the callback.

EnumWindowsProc(hwnd, lParam)
{
	global Output
	WinGetTitle, title, ahk_id %hwnd%
	WinGetClass, class, ahk_id %hwnd%
	
	;MouseGetPos, CursorX, CursorY , id, control,
	ControlGetFocus, cCtl, A
	ControlGet, ghCtl, Hwnd,, %cCtl%, A
	WinGetClass, vCtlClass, % "ahk_id " hCtl
	if title
		Output .= "HWND: " . hwnd . "`tTitle: " . title . "`tClass: " . class . "`nWin: " win "`nhCtl: " hCtl "`nghCtl: " ghCtl "`ncCtl: " cCtl "`nvCtlClass: " vCtlClass
	return true  ; Tell EnumWindows() to continue until all windows have been enumerated.
}
return
#If
/*
	#5::
	global ghWndToolbar:= % Ctl
	global gToolbarWind:= % hCtl
	SetTimer, WatchCursor8, off
	;WinGet, hWnd, ID, A
	;WinGet, vCtlList, ControlList, % "ahk_id " hWnd
	WinGet, vCtlList, ControlList, % "ahk_id " ghWndToolbar
	vOutput := ""
	Loop, Parse, vCtlList, `n
	{
		vCtlClassNN := A_LoopField
		ControlGet, hCtl, Hwnd,, % vCtlClassNN, % "ahk_id " hWnd
		hWndParent := DllCall("user32\GetAncestor", Ptr,&hCtl, UInt,1, Ptr) ;GA_PARENT := 1
		hWndRoot := DllCall("user32\GetAncestor", Ptr, &hCtl, UInt,2, Ptr) ;GA_ROOT := 2
		hWndOwner := DllCall("user32\GetWindow", Ptr,&hCtl, UInt,4, Ptr) ;GW_OWNER = 4
		hWndChild := DllCall("RealChildWindowFromPoint", Ptr,&hCtl, UInt,4, Ptr) ;GW_OWNER = 4
		;CursorHwnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
		WinGetClass, vWinClass1, % "ahk_id " hWndParent
		WinGetClass, vWinClass2, % "ahk_id " hWndRoot
		WinGetClass, vWinClass3, % "ahk_id " hWndOwner
		WinGetClass, vWinClass4, % "ahk_id " hWndChild
		vOutput .= A_Index ":" "`r`n" vCtlClassNN "|" vWinClass1 "|" vWinClass2 "|" vWinClass3 "|" vWinClass4 "`r`n" ;"|" vWinClass4 "`r`n"
		;vOutput .= A_Index ":" "`r`n" vCtlClassNN "`r`n" vWinClass4 "`r`n" ;"|" vWinClass1 "|" vWinClass2 "|" vWinClass3 "|" vWinClass4 "`r`n" ;"|" vWinClass4 "`r`n"
	}
	Clipboard := vOutput 
	;ToolTip, % vCtlClassNN,x+1,0
	ToolTip, % vOutput, xm,0
	;MsgBox, % vOutput
	return
*/

/* Horizon bold, italics, cut bottons via #1,2,3
	#1::
	;ControlGet, Ctlh, hWnd,,% hCtl, A
	ControlGet, Ctlt, hWnd,,% tCtl, A
	CoordMode, Mouse, Client
	; bold button
	PostMessage,0x0201,,,, ahk_id %Ctlh% ;L_Button Down
	PostMessage,0x0202,,,, ahk_id %Ctlh% ;L_Button Up
	return
	
	; ========== Human Element - Horizon - Italics ==============
	#2::
	;ToolTip
	ControlGet, Ctlh, hWnd,,% hCtl, A
	ControlGet, Ctlt, hWnd,,% tCtl, A
	CoordMode, Mouse, Client
	; italics button
	PostMessage,0x0201,,40,, ahk_id %Ctlh% ;L_Button Down
	PostMessage,0x0202,,40,, ahk_id %Ctlh% ;L_Button Up
	return
	
	#3:: ; Cut Button
	ControlGet, Ctlh, hWnd,,% hCtl, A
	ControlGet, Ctlt, hWnd,,% tCtl, A
	CoordMode, Mouse, Client
	; Cut button
	PostMessage,0x0201,,70,, ahk_id %Ctlh% ;L_Button Down
	PostMessage,0x0202,,70,, ahk_id %Ctlh% ;L_Button Up
	return
	
	WatchCursor3:
	MouseGetPos, , , id, control, 3
	ControlGetFocus, vCtlClassNN, A
	ControlGet, hCtl, Hwnd,, % vCtlClassNN, A
	WinGetClass, vCtlClass, % "ahk_id " hCtl
	ControlGetText, vText, % vCtlClassNN, A
	ControlGet, vText2, List,, % vCtlClassNN, A
	;MsgBox, % vCtlClass
	;MsgBox, % vText
	ToolTip % vCtlClass " ID:"id
	;Clipboard:= % vText
	;MsgBox, % vText2
	return
*/
#7::
q:: ;list child windows (controls)/windows

;get active window
WinGet, hWnd, ID, A
hWnd2 := DllCall("GetForegroundWindow", Ptr)
MsgBox, % hWnd "`r`n" Format("0x{:x}", hWnd2)

;window get class
WinGetClass, vWinClass, % "ahk_id " hWnd
vWinClass2 := ""
VarSetCapacity(vWinClass2, 261*2, 0)
DllCall("GetClassName", Ptr,hWnd, Str,vWinClass2, Int,261)
MsgBox, % vWinClass "`r`n" vWinClass2

;==============================

;list child windows (controls)
EnumFunc("", "c")
pEnumFunc := RegisterCallback("EnumFunc", "F", 2)
DllCall("EnumChildWindows", Ptr,hWnd, Ptr,pEnumFunc, Ptr,0)
vList := EnumFunc("", "r")
MsgBox, % StrSplit(vList, "`n").Length() "`n" vList

;list child windows (controls)
WinGet, vCtlList, ControlListHwnd, % "ahk_id " hWnd
vList := ""
Loop, Parse, vCtlList, `n
{
	hCtl := A_LoopField
	vList .= (hCtl+0) "`r`n"
}
vList := SubStr(vList, 1, -1)
MsgBox, % StrSplit(vList, "`n").Length() "`n" vList

;==============================

;list all windows
EnumFunc("", "c")
pEnumFunc := RegisterCallback("EnumFunc", "F", 2)
DllCall("EnumWindows", Ptr,pEnumFunc, Ptr,0)
vList := EnumFunc("", "r")
MsgBox, % StrSplit(vList, "`n").Length() "`n" vList

;list all windows
DetectHiddenWindows, On
WinGet, vWinList, List
vList := ""
Loop, % vWinList
{
	hWnd := vWinList%A_Index%
	vList .= (hWnd+0) "`n"
}
vList := SubStr(vList, 1, -1)
MsgBox, % StrSplit(vList, "`n").Length() "`n" vList

;==============================

;list hidden windows
EnumFunc("", "c")
pEnumFunc := RegisterCallback("EnumFunc", "F", 2)
DllCall("EnumWindows", Ptr,pEnumFunc, Ptr,0)
vListAll := EnumFunc("", "r")
vList := ""
Loop, Parse, vListAll, % "`n"
{
	if DllCall("user32\IsWindowVisible", Ptr,A_LoopField)
		vList .= A_LoopField "`n"
}
vList := SubStr(vList, 1, -1)
MsgBox, % StrSplit(vList, "`n").Length() "`n" vList

;list hidden windows
DetectHiddenWindows, Off
WinGet, vWinList, List
vList := ""
Loop, % vWinList
{
	hWnd := vWinList%A_Index%
	vList .= (hWnd+0) "`n"
}
vList := SubStr(vList, 1, -1)
MsgBox, % StrSplit(vList, "`n").Length() "`n" vList

;==============================

return

;==================================================

EnumFunc(hWnd, vMode)
{
	static vList
	if (vMode = "c") ;clear
		return vList := ""
	else if (vMode = "r") ;return
		return RTrim(vList, "`n")
	vList .= hWnd "`n"
	return 1
}

;==================================================
return
/*
#1::
#Persistent
;ToolTip
;SendMessage,0x0081,0,0,% Ctl,% hCtl
OnMessage(WC_*, "MyMessageMonitor")
MyMessageMonitor(msg, wParam, lParam, hwnd)
{
	MsgBox Message %msg% arrived:`nWPARAM: %wParam%`nLPARAM: %lParam%
}
return
*/
#4::
Title:= % "WatchCursor" A_ThisHotkey
SetTimer,WatchCursor4, 100
return

WatchCursor4:
MouseGetPos, , , vWin, vCtrl
;compatibility types
UPtr := A_PtrSize ? "UPtr" : "UInt"
AStr := A_IsUnicode ? "AStr" : "Str"
ptr:= A_PtrSize ? "Ptr" : "UInt"
char_size:= A_IsUnicode ? 2 : 1

hWnd:=dllcall("GetActiveWindow", Ptr, vWin)

ToolTip % hWnd,,,4

#IfWinActive WatchCursor4
	If Toggle
		Tooltip,,,,4
	Return
#IfWinActive	
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

/*
	#IfWinActive ahk_exe AutoHotkeyU32.exe
*/
^+1::
SetTimer,CursorhWnd, 100

CursorhWnd:
ptr:= A_PtrSize ? "Ptr" : "UInt"
char_size:= A_IsUnicode ? 2 : 1
WfPhWnd := DllCall("WindowFromPoint", int64, CursorX | (CursorY << 32), Ptr)
ControlGet, CtlW, hWnd,,, % "ahk_id" WfPhWnd
CwFpHwnd := DllCall("RealChildWindowFromPoint", int64, CursorXc | (CursorYc << 32), ptr)
ControlGet, CtlC, hWnd,,, % "ahk_id" CwFpHwnd
ToolTip % "WindowFromPoint: " WfPhWnd " , hWnd: " CtlW "`n" CwFpHwnd ":"CtlC
Return
/*
	#If
*/


#8:: ;SetTimer,WatchCursor8, % ((toggle := !toggle) ? "100" : "Off")
 
toggle := !toggle
if (toggle)
	SetTimer, WatchCursor8, 100
else
	SetTimer,, Off
return

;% (Toggle := !Toggle) ? "SetTimer, WatchCursor8, 100"  : "SetTimer, WatchCursor8, Off"
;On Toggle, Toggle = 1							 
;SetTimer, WatchCursor8, 100
;global win
;global Ctl

WatchCursor8:
MouseGetPos,,,win, fCtl
ControlGet, hCtl, hWnd,, %fCtl%, A
;WfPhWnd := DllCall("WindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")
;cfPhWnd := DllCall("RealChildWindowFromPoint", "int64", CursorX | (CursorY << 32), "Ptr")

ToolTip % "Control: " fCtl " ahk_id " hCtl
return
#!8::
A_Clipboard := % "Control: " fCtl " ahk_id " hCtl
Return

; Function: ClickToolbarItem
; Description: Clicks the nth item in a toolbar.
; Parameters:
;   - hWndToolbar: The handle of the toolbar control.
;   - n: The index of the toolbar item to click.

; File Title: file:///C:/Users/bacona/AppData/Local/Temp/Horizon/20230521/302
; Use: file:///C:/Users/bacona/AppData/Local/Temp/Horizon/20230521/

; ========================================= ClickToolbarItem() Call Function ==========================================
#6::
; Control: ThunderRT6FormDC1 ahk_id 0x90b68
MouseGetPos,,,win, fCtl
ControlGet, hCtl, hWnd,, %fCtl%, A
hToolbar := % hCtl
ControlGet, hToolbar, hWnd,,%gToolbarWind%, A
SendMessage, % TB_BUTTONCOUNT := 0x418, 0, 0, , ahk_id %hToolbar%
MsgBox % hToolbar ? "Toolbar handle: " hToolbar "`nButton count: " ErrorLevel : "Didn't find toolbar!"
return
;ClickToolbarItem(hToolbar,9)
;return
; 1=Bold, 2=Italics, 10=Cut, 11=Copy, 12=Paste, 14=Undo, 15=Redo
; 17=Bulleted List, 18=Spell Check, 20=Super/Sub Script, 21=Find/Replace
; Mystery or Spacers: 3-9, 13, 16, 19=?Bold?
; ==== eqpt =====
; Nothing?=1,2
; Same: 21,20,18,17,
/* ; rev2
	#6::
	ControlGet, hToolbar, hWnd,,%gToolbarWind%, A
	SendMessage, % TB_BUTTONCOUNT := 0x418, 0, 0, , ahk_id %hToolbar%
	MsgBox % hToolbar ? "Toolbar handle: " hToolbar "`nButton count: " ErrorLevel : "Didn't find toolbar!"
	return
*/
/* rev 1
	; === my failed attempt using #8, #5, then #6 ===
	#6::
	;hWndToolbar:= % hCtl
	ControlGet, Ctlh, hWnd,,%hCtl%, A
	ClickToolbarItem(Ctlh, 1)
	ToolTip % Ctlh
	return
*/

/*
	#5::
	MouseGetPos,,,win, hCtl
	ControlGet, Ctl, hWnd,, %hCtl%, A
	global ghWndToolbar:= % Ctl
	global gToolbarWind:= % hCtl
	;LVM_GETITEMCOUNT := 0x1004, LVM_APPROXIMATEVIEWRECT := 0x1040, LVM_GETSUBITEMRECT := 0x1038, LVM_GETSELECTEDCOUNT := 0x1032, LVM_GETITEMRECT := 0x100e, LVM_FIRST := 0x1000, LVM_GETNEXTITEM := 0x100c
	;ControlGet, hToolbar, hWnd,,%gToolbarWind%, A
	ControlGet, hToolbar, hWnd,,% gToolbarWind, A
	;ClickListView(hListView, 1)
	;SendMessage, % TB_BUTTONCOUNT := 0x418, 0, 0, , ahk_id %hToolbar%
	PostMessage, % WM_GETOBJECT := 0x003d,0xffffffff,0xfffffffc, , ahk_id %hToolbar%
	X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
	;MsgBox % hToolbar ? "Toolbar handle: " hToolbar "`nButton count: " ErrorLevel : "Didn't find toolbar!"
	MsgBox % hToolbar ? "Toolbar Window: " gToolbarWind  "`nToolbar handle: " hToolbar "`nCount: " ErrorLevel "`nX: " X " Y: " Y " W: " W " H: " H " #: " buttonCount ErrorLevel : "Didn't find LV!" 
	;MsgBox % "X: " X " Y: " Y " W: " W " H: " H " #: " buttonCount
	
	
	;MsgBox Control: %gToolbarWind%`nhWnd: %ghWndToolbar%
	return
*/

; Function: ClickToolbarItem
; Description: Clicks the nth item in a toolbar.
; Parameters:
;   - hWndToolbar: The handle of the toolbar control.
;   - n: The index of the toolbar item to click.

; ========================================= ClickToolbarItem() Function ==========================================
; ClickToolbar Function
ClickToolbarItem(hWndToolbar, n) {
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
		;ToolTip % "X: " X " Y: " Y " W: " W " H: " H " #: " buttonCount
		;CoordMode, Mouse, Client ; not working
		;MouseMove, X, Y
	} else {
		MsgBox, 48, Error, The specified index %n% is out of range. Please specify a valid index between 1 and %buttonCount%.
	}
	return
}
reload

; ============================== End of ClickToolbarItem Function ==============================================
ClickListViewItem(hWndToolbar, n) {
	static LVM_GETITEMCOUNT := 0x1004, LVM_APPROXIMATEVIEWRECT := 0x1040, LVM_GETSUBITEMRECT := 0x1038, LVM_GETSELECTEDCOUNT := 0x1032, LVM_GETITEMRECT := 0x100e, LVM_FIRST := 0x1000, LVM_GETNEXTITEM := 0x100c						
	SendMessage, 0x1004, 0, 0, , ahk_id %hWndToolbar%
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
		;CoordMode, Mouse, Client ; not working
		;MouseMove, X, Y
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
:*:WM_GETTEXT ::0x000D
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
#IfWinActive Message_Post_Send
+r::Reload
+x::ExitApp
Return
#If	