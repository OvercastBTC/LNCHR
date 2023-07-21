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

;============================== ini Section ==============================
^!#9\:

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
;Gui, Submit,Nohide
;Gui, Show, AutoSize
;return

;GuiControlGet, Msg,,,Edit
;GuiControlGet, wParam,,,Edit
;GuiControlGet, lParam,,,Edit
;GuiControlGet, ControlID,,,Edit
;GuiControlGet, Window,,,Edit
;GuiControlGet, ControlList,,,Edit
;GuiControlGet, Send,,,Edit
;GuiControlGet, Post,,,Edit

;MsgBox Msg: %Msg%`nWParam: %wParam%`nlParam: %lParam%`nControlID: %ControlID%`nErrorLevel: %ErrorLevel%

Window:
Gui, Submit, NoHide
return
#9::
ControlList:
WinGet, cList, ControlList, ahk_class msvb_lib_toolbar1
WinGet, cListH, ControlListHwnd, A
MsgBox %cList% `n %cListH%
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
return

#1::
;TestM:

;PostMessage,0x0201,,,, ahk_id 0x00040df4
;PostMessage,0x0202,,,, ahk_id 0x00040df4
PostMessage,0x0201,,,, ahk_id 0x00020cc2
;Sleep 100
PostMessage,0x0202,,,, ahk_id 0x00020cc2
MsgBox % HWND
;Sleep 100
return
#7::

#8::
#Persistent
CoordMode, Mouse, Window
SetTimer, WatchCursor8, 500
WatchCursor8:
MouseGetPos,,, win, control

;compatibility types
UPtr := A_PtrSize ? "UPtr" : "UInt"
AStr := A_IsUnicode ? "AStr" : "Str"

cinfo:= DllCall("ChildWindowFromPointEx", Int, 1, Ptr, 0, UInt,0x0000)
;HWND ChildWindowFromPointEx(
;[in] HWND  hwnd,
;[in] POINT pt,
;[in] UINT  flags
;);
;[in, optional] HINSTANCE   hInstance,
;[in]           LPCWSTR     lpClassName,
;[out]          LPWNDCLASSW lpWndClass")
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

;SendMessage 0x30, hfont, True, %control%, ahk_id %win%
ToolTip C: %cinfo% Control: %control% ahk_id %win%
Return
*/
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
hWndChild := DllCall("RealChildWindowFromPoint", Ptr,hCtl, UInt,, Ptr)
hWndParent := DllCall("DefMDIChildProcW", Ptr,hCtl, UInt,, Ptr) ;
WinGet, chWnd, ID, 
WinGetClass, vWinClass1, % "ahk_id " hWndChild
WinGetClass, vWinClass2, % "ahk_id " hWndParent
ToolTip % vWinClass1 " ID:"id "`r`n" vWinClass2
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
/*
#2::
WinGet, hWnd, ID, A
;WinGet, vCtlList, ControlList, % "ahk_id " hWnd
WinGet, vCtlList, ControlList, % "ahk_id " hWnd
vOutput := ""
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
*/
#3:: ;control, list controls within it
;q:: ;active control - get class (and get text if control compatible)
#Persistent
SetTimer, WatchCursor3, 500
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
#4::
#Persistent
SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos, , , id, control, 3
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
WinGet, ControlList, ControlList, A
;ToolTip, %ControlList%
ToolTip, ahk_id %id%`nahk_class %class%`n%title%`nControl: %control%`nControlList: %ControlList%`n

return

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
/*
MDIClient1|ThunderRT6MDIForm|ThunderRT6MDIForm|
ThunderRT6FormDC1|MDIClient|ThunderRT6MDIForm|
AfxOleControl421|ThunderRT6FormDC|ThunderRT6MDIForm|
AfxWnd421|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd422|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd423|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView421|AfxOleControl42|ThunderRT6MDIForm|
SysTreeView321|AfxFrameOrView42|ThunderRT6MDIForm|
AfxFrameOrView422|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView423|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS1|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS2|AfxOleControl42|ThunderRT6MDIForm|
Edit1|AfxOleControl42|ThunderRT6MDIForm|
SysListView321|AfxOleControl42|ThunderRT6MDIForm|
Edit2|SysListView32|ThunderRT6MDIForm|
AfxFrameOrView424|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView425|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd424|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd425|AfxOleControl42|ThunderRT6MDIForm|
ToolbarWindow321|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd426|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView426|AfxOleControl42|ThunderRT6MDIForm|
AfxOleControl422|ThunderRT6FormDC|ThunderRT6MDIForm|
AfxWnd427|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd428|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd429|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView427|AfxOleControl42|ThunderRT6MDIForm|
SysTreeView322|AfxFrameOrView42|ThunderRT6MDIForm|
AfxFrameOrView428|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView429|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS3|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS4|AfxOleControl42|ThunderRT6MDIForm|
Edit3|AfxOleControl42|ThunderRT6MDIForm|
SysListView322|AfxOleControl42|ThunderRT6MDIForm|
Edit4|SysListView32|ThunderRT6MDIForm|
AfxFrameOrView4210|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4211|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4210|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4211|AfxOleControl42|ThunderRT6MDIForm|
ToolbarWindow322|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4212|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4212|AfxOleControl42|ThunderRT6MDIForm|
AfxOleControl423|ThunderRT6FormDC|ThunderRT6MDIForm|
AfxWnd4213|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4214|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4215|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4213|AfxOleControl42|ThunderRT6MDIForm|
SysTreeView323|AfxFrameOrView42|ThunderRT6MDIForm|
AfxFrameOrView4214|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4215|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS5|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS6|AfxOleControl42|ThunderRT6MDIForm|
Edit5|AfxOleControl42|ThunderRT6MDIForm|
SysListView323|AfxOleControl42|ThunderRT6MDIForm|
Edit6|SysListView32|ThunderRT6MDIForm|
AfxFrameOrView4216|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4217|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4216|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4217|AfxOleControl42|ThunderRT6MDIForm|
ToolbarWindow323|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4218|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4218|AfxOleControl42|ThunderRT6MDIForm|
AfxOleControl424|ThunderRT6FormDC|ThunderRT6MDIForm|
AfxWnd4219|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4220|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4221|AfxOleControl42|ThunderRT6MDIForm|
SysTabControl321|AfxWnd42|ThunderRT6MDIForm|
AfxFrameOrView4219|AfxOleControl42|ThunderRT6MDIForm|
SysTreeView324|AfxFrameOrView42|ThunderRT6MDIForm|
AfxFrameOrView4220|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4221|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS7|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS8|AfxOleControl42|ThunderRT6MDIForm|
Edit7|AfxOleControl42|ThunderRT6MDIForm|
SysListView324|AfxOleControl42|ThunderRT6MDIForm|
Edit8|SysListView32|ThunderRT6MDIForm|
AfxFrameOrView4222|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4223|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4222|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4223|AfxOleControl42|ThunderRT6MDIForm|
ToolbarWindow324|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4224|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4224|AfxOleControl42|ThunderRT6MDIForm|
AfxOleControl425|ThunderRT6FormDC|ThunderRT6MDIForm|
AfxWnd4225|AfxOleControl42|ThunderRT6MDIForm|
Shell Embedding1|AfxWnd42|ThunderRT6MDIForm|
AfxWnd4226|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4227|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4225|AfxOleControl42|ThunderRT6MDIForm|
SysTreeView325|AfxFrameOrView42|ThunderRT6MDIForm|
AfxFrameOrView4226|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4227|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS9|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS10|AfxOleControl42|ThunderRT6MDIForm|
Edit9|AfxOleControl42|ThunderRT6MDIForm|
SysListView325|AfxOleControl42|ThunderRT6MDIForm|
Edit10|SysListView32|ThunderRT6MDIForm|
AfxFrameOrView4228|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4229|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4228|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4229|AfxOleControl42|ThunderRT6MDIForm|
ToolbarWindow325|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4230|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4230|AfxOleControl42|ThunderRT6MDIForm|
AfxOleControl426|ThunderRT6FormDC|ThunderRT6MDIForm|
AfxWnd4231|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4232|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4233|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4231|AfxOleControl42|ThunderRT6MDIForm|
SysTreeView326|AfxFrameOrView42|ThunderRT6MDIForm|
SysTabControl322|AfxFrameOrView42|ThunderRT6MDIForm|
SysTreeView327|AfxFrameOrView42|ThunderRT6MDIForm|
AfxFrameOrView4232|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4233|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS11|AfxOleControl42|ThunderRT6MDIForm|
PVSPLITTERWNDCLASS12|AfxOleControl42|ThunderRT6MDIForm|
Edit11|AfxOleControl42|ThunderRT6MDIForm|
SysListView326|AfxOleControl42|ThunderRT6MDIForm|
Edit12|SysListView32|ThunderRT6MDIForm|
AfxFrameOrView4234|AfxOleControl42|ThunderRT6MDIForm|
ThunderRT6FormDC2|AfxFrameOrView42|ThunderRT6MDIForm|ThunderRT6Main
ProtoViewResizer1|ThunderRT6FormDC|ThunderRT6MDIForm|
ThunderRT6Frame1|ThunderRT6FormDC|ThunderRT6MDIForm|
ThunderRT6UserControlDC1|ThunderRT6Frame|ThunderRT6MDIForm|
TX_STATUSBAR111|ThunderRT6UserControlDC|ThunderRT6MDIForm|
ThunderRT6Timer1|ThunderRT6UserControlDC|ThunderRT6MDIForm|
TX111|ThunderRT6UserControlDC|ThunderRT6MDIForm|
Toolbar20WndClass1|ThunderRT6UserControlDC|ThunderRT6MDIForm|
msvb_lib_toolbar1|Toolbar20WndClass|ThunderRT6MDIForm|
ThunderRT6UserControlDC2|ThunderRT6Frame|ThunderRT6MDIForm|
ATL:0B8000201|ThunderRT6UserControlDC|ThunderRT6MDIForm|
DT5_PVCombo1|ATL:0B800020|ThunderRT6MDIForm|
ScrollBar1|DT5_PVCombo|ThunderRT6MDIForm|
SSUltraGridWndClass1|ThunderRT6Frame|ThunderRT6MDIForm|
ScrollBar2|SSUltraGridWndClass|ThunderRT6MDIForm|
ScrollBar3|SSUltraGridWndClass|ThunderRT6MDIForm|
ThunderRT6UserControlDC3|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6TextBox1|ThunderRT6UserControlDC|ThunderRT6MDIForm|
ThunderRT6UserControlDC4|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6ComboBox1|ThunderRT6UserControlDC|ThunderRT6MDIForm|
ThunderRT6UserControlDC5|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6CommandButton1|ThunderRT6UserControlDC|ThunderRT6MDIForm|
ThunderRT6UserControlDC6|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6CommandButton2|ThunderRT6UserControlDC|ThunderRT6MDIForm|
ThunderRT6UserControlDC7|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6CommandButton3|ThunderRT6UserControlDC|ThunderRT6MDIForm|
ThunderRT6UserControlDC8|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6UserControlDC9|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6UserControlDC10|ThunderRT6Frame|ThunderRT6MDIForm|
ThunderRT6UserControlDC11|ThunderRT6Frame|ThunderRT6MDIForm|
SSUltraGridWndClass2|ThunderRT6FormDC|ThunderRT6MDIForm|
ScrollBar4|SSUltraGridWndClass|ThunderRT6MDIForm|
ThunderRT6UserControlDC12|ThunderRT6FormDC|ThunderRT6MDIForm|
ThunderRT6CommandButton4|ThunderRT6UserControlDC|ThunderRT6MDIForm|
AfxFrameOrView4235|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4234|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4235|AfxOleControl42|ThunderRT6MDIForm|
ToolbarWindow326|AfxOleControl42|ThunderRT6MDIForm|
AfxWnd4236|AfxOleControl42|ThunderRT6MDIForm|
AfxFrameOrView4236|AfxOleControl42|ThunderRT6MDIForm|
ThunderRT6UserControlDC13|ThunderRT6FormDC|ThunderRT6MDIForm|
ThunderRT6PictureBoxDC1|ThunderRT6UserControlDC|ThunderRT6MDIForm|
ThunderRT6CommandButton5|ThunderRT6PictureBoxDC|ThunderRT6MDIForm|
ThunderRT6CommandButton6|ThunderRT6PictureBoxDC|ThunderRT6MDIForm|
ThunderRT6CommandButton7|ThunderRT6PictureBoxDC|ThunderRT6MDIForm|
ThunderRT6CommandButton8|ThunderRT6PictureBoxDC|ThunderRT6MDIForm|
ThunderRT6CommandButton9|ThunderRT6PictureBoxDC|ThunderRT6MDIForm|
ThunderRT6CommandButton10|ThunderRT6PictureBoxDC|ThunderRT6MDIForm|
SSTracker1|ThunderRT6MDIForm|ThunderRT6MDIForm|
*/
;============================== End Script ==============================