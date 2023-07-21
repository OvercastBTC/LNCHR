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

;SplashTextOn, 100, 25, Test, I should be working
;WM_USER + 7174 (0x00002006)
;PostMessage, 0x0111,100,,,ahk_id 0x000a1300
;PostMessage, 0x0111,100,,,ahk_id 0x0018145C
;PostMessage, 0x0111,101,,,ahk_id 0x000a1300
;PostMessage, 0x0111,101,,,ahk_id 0x0018145C
;PostMessage, WM_USER + 3 (0x00000403),0x00000064,,,ahk_id 0x000a1300
;PostMessage, WM_USER + 3 (0x00000403),0x00000065,,,ahk_id 0x000a1300
;PostMessage, WM_USER + 3 (0x00000403),0x00000066,,,ahk_id 0x000a1300

SendMessage, 0x0111,101,,,ahk_id 0x0018145C
SendMessage, 0x0403,0x00000064,,,ahk_id 0x000a1300
SendMessage, 0x0403,0x00000065,,,ahk_id 0x000a1300
SendMessage, 0x0403,0x00000066,,,ahk_id 0x000a1300
SendMessage, 0x0281, 0x00000001, 0xc000000f,, ahk_id 0x00061306
SendMessage, WM_USER + 7246 (0x0000204e), ,0x0019f720,,,ahk_id 0x00061306
SendMessage, WM_USER + 7441 (0x00002111), 0x07050000,,,ahk_id 0x00061306

; --- TX11 - set to italics ---------------------------------------------- ;#[winmenuselectitem_horizon - italics text]
;WM_IME_SETCONTEXT
;SendMessage,WM_IME_SETCONTEXT,0x00000001,0xc000000f,,ahk_id 0x00061306
;wParam: 0x00000001
;lParam: 0xc000000f
;Message Sent
;Time: 23:55:49.0638

;WM_IME_SETCONTEXT	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0638

;WM_GETOBJECT
;wParam: 0xffffffff
;lParam: 0xfffffffc
;Message Sent
;Time: 23:55:49.0639

;WM_GETOBJECT	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0639

;WM_GETOBJECT
;wParam: 0x00000000
;lParam: 0xfffffff4
;Message Sent
;Time: 23:55:49.0639

;WM_GETOBJECT	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0639

;WM_SETFOCUS
;HWND losing focus: 0x000612b2
;Message Sent
;Time: 23:55:49.0640

;WM_IME_NOTIFY
;wParam: 0x0000000b
;lParam: 0x00000000
;Message Sent
;Time: 23:55:49.0642

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0642

;MSIMEQueryPosition (Registered messages)
;wParam: 0x00000001
;lParam: 0x0019e9ac
;Message Sent
;Time: 23:55:49.0643

;MSIMEQueryPosition (Registered messages)	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0643

;WM_IME_NOTIFY
;wParam: 0x00000009
;lParam: 0x00000001
;Message Sent
;Time: 23:55:49.0644

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0644

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019ee40
;Message Sent
;Time: 23:55:49.0645

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0645

;WM_USER + 7441 (0x00002111)
;wParam: 0x07040000
;lParam: 0x00061306
;Message Sent
;Time: 23:55:49.0645

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0645

;WM_SETFOCUS	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0646

;WM_IME_NOTIFY
;wParam: 0x0000000b
;lParam: 0x00000000
;Message Sent
;Time: 23:55:49.0771

;MSIMEQueryPosition (Registered messages)
;wParam: 0x00000001
;lParam: 0x0019d4e8
;Message Sent
;Time: 23:55:49.0772

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019ce60
;Message Sent
;Time: 23:55:49.0772

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0772

;WM_USER + 7441 (0x00002111)
;wParam: 0x070c0000
;lParam: 0x00061306
;Message Sent
;Time: 23:55:49.0772

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0773

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019ce60
;Message Sent
;Time: 23:55:49.0773

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0773

;WM_USER + 7441 (0x00002111)
;wParam: 0x07310000
;lParam: 0x00061306
;Message Sent
;Time: 23:55:49.0774

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0774

;MSIMEQueryPosition (Registered messages)	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0774

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0775

;MSIMEQueryPosition (Registered messages)
;wParam: 0x00000001
;lParam: 0x0019e70c
;Message Sent
;Time: 23:55:49.0776

;MSIMEQueryPosition (Registered messages)	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0776

;WM_IME_NOTIFY
;wParam: 0x00000009
;lParam: 0x00000001
;Message Sent
;Time: 23:55:49.0776

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0776

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019eb88
;Message Sent
;Time: 23:55:49.0776

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0777

;WM_USER + 7441 (0x00002111)
;wParam: 0x07070000
;lParam: 0x00061306
;Message Sent
;Time: 23:55:49.0777

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:49.0777

;WM_KILLFOCUS
;HWND receiving focus: 0x00000000
;Message Sent
;Time: 23:55:53.0889

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019f720
;Message Sent
;Time: 23:55:53.0889

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:53.0889

;WM_KILLFOCUS	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:53.0889

;WM_IME_SETCONTEXT
;wParam: 0x00000000
;lParam: 0xc000000f
;Message Sent
;Time: 23:55:53.0889

;WM_IME_NOTIFY
;wParam: 0x00000001
;lParam: 0x00000000
;Message Sent
;Time: 23:55:53.0889

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:53.0889

;WM_IME_SETCONTEXT	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:53.0890

;WM_USER + 7441 (0x00002111)
;wParam: 0x07050000
;lParam: 0x00061306
;Message Sent
;Time: 23:55:53.0890

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 23:55:53.0890

;WM_NCHITTEST
;Position: 675, 519
;Message Sent
;Time: 23:56:46.0059

;WM_NCHITTEST	Return value
;Hit: HTCLIENT
;Message Sent
;Time: 23:56:46.0059

;WM_NCHITTEST
;Position: 675, 519
;Message Sent
;Time: 23:56:46.0061

;WM_NCHITTEST	Return value
;Hit: HTCLIENT
;Message Sent
;Time: 23:56:46.0061

;WM_SETCURSOR
;Hit test code: HTCLIENT
;Mouse message ID: 512
;Message Sent
;Time: 23:56:46.0061

;WM_SETCURSOR	Return value
;Continue processing: True
;Message Sent
;Time: 23:56:46.0062

;WM_MOUSEMOVE
;POINT: 451, 28
;Message Posted
;Time: 23:56:46.0062

;WM_NCHITTEST
;Position: 675, 519
;Message Sent
;Time: 23:56:46.0062

;WM_NCHITTEST	Return value
;Hit: HTCLIENT
;Message Sent
;Time: 23:56:46.0063

; -- TX11 - Set text to normal ----- ;#[winmenuselectitem_horizon - retore text to normal]
;Window messages created by Winspector
;WM_IME_SETCONTEXT
;wParam: 0x00000001
;lParam: 0xc000000f
;Message Sent
;Time: 00:03:44.0223

;WM_IME_SETCONTEXT	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0223

;WM_GETOBJECT
;wParam: 0xffffffff
;lParam: 0xfffffffc
;Message Sent
;Time: 00:03:44.0224

;WM_GETOBJECT	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0224

;WM_GETOBJECT
;wParam: 0x00000000
;lParam: 0xfffffff4
;Message Sent
;Time: 00:03:44.0224

;WM_GETOBJECT	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0224

;WM_SETFOCUS
;HWND losing focus: 0x000612b2
;Message Sent
;Time: 00:03:44.0224

;WM_IME_NOTIFY
;wParam: 0x0000000b
;lParam: 0x00000000
;Message Sent
;Time: 00:03:44.0224

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0224

;MSIMEQueryPosition (Registered messages)
;wParam: 0x00000001
;lParam: 0x0019e9ac
;Message Sent
;Time: 00:03:44.0225

;MSIMEQueryPosition (Registered messages)	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0225

;WM_IME_NOTIFY
;wParam: 0x00000009
;lParam: 0x00000001
;Message Sent
;Time: 00:03:44.0225

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0225

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019ee40
;Message Sent
;Time: 00:03:44.0225

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0225

;WM_USER + 7441 (0x00002111)
;wParam: 0x07040000
;lParam: 0x00061306
;Message Sent
;Time: 00:03:44.0225

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0225

;WM_SETFOCUS	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0225

;WM_IME_NOTIFY
;wParam: 0x0000000b
;lParam: 0x00000000
;Message Sent
;Time: 00:03:44.0323

;MSIMEQueryPosition (Registered messages)
;wParam: 0x00000001
;lParam: 0x0019d4e8
;Message Sent
;Time: 00:03:44.0323

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019ce60
;Message Sent
;Time: 00:03:44.0323

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0323

;WM_USER + 7441 (0x00002111)
;wParam: 0x070c0000
;lParam: 0x00061306
;Message Sent
;Time: 00:03:44.0324

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0324

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019ce60
;Message Sent
;Time: 00:03:44.0324

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0324

;WM_USER + 7441 (0x00002111)
;wParam: 0x07310000
;lParam: 0x00061306
;Message Sent
;Time: 00:03:44.0324

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0324

;MSIMEQueryPosition (Registered messages)	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0325

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0325

;MSIMEQueryPosition (Registered messages)
;wParam: 0x00000001
;lParam: 0x0019e70c
;Message Sent
;Time: 00:03:44.0326

;MSIMEQueryPosition (Registered messages)	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0326

;WM_IME_NOTIFY
;wParam: 0x00000009
;lParam: 0x00000001
;Message Sent
;Time: 00:03:44.0326

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0326

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019eb88
;Message Sent
;Time: 00:03:44.0328

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0328

;WM_USER + 7441 (0x00002111)
;wParam: 0x07070000
;lParam: 0x00061306
;Message Sent
;Time: 00:03:44.0328

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:44.0329

;WM_KILLFOCUS
;HWND receiving focus: 0x00000000
;Message Sent
;Time: 00:03:48.0369

;WM_USER + 7246 (0x0000204e)
;wParam: 0x00000000
;lParam: 0x0019f720
;Message Sent
;Time: 00:03:48.0370

;WM_USER + 7246	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:48.0370

;WM_KILLFOCUS	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:48.0370

;WM_IME_SETCONTEXT
;wParam: 0x00000000
;lParam: 0xc000000f
;Message Sent
;Time: 00:03:48.0370

;WM_IME_NOTIFY
;wParam: 0x00000001
;lParam: 0x00000000
;Message Sent
;Time: 00:03:48.0370

;WM_IME_NOTIFY	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:48.0371

;WM_IME_SETCONTEXT	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:48.0371

;WM_USER + 7441 (0x00002111)
;wParam: 0x07050000
;lParam: 0x00061306
;Message Sent
;Time: 00:03:48.0371

;WM_USER + 7441	Return value
;Return: 0x00000000
;Message Sent
;Time: 00:03:48.0371

;============================== Includes Section ==============================

; |---------------------------- Optional Sections/Examples ------------------------------| 
;#IfWinActive
;============================== Main Script ==============================

; Your main code here.
; Global hotkeys
; Global hotstrings
; etc...

;============================== Program 1 ==============================
; Evertything between here and the next #IfWinActive will ONLY work in someProgram.exe
; This is called being "context sensitive"
; #IfWinActive, ahk_exe someProgram.exe



; #IfWinActive
;============================== ini Section ============================== ;#[winmenuselectitem_horizon - WindowsMessages]
; Do not remove /* or */ from this section. Only modify if you're
; storing values to this file that need to be permanantly saved.
IniWrite, %value%, %root%lib\%Section%.ini, %Section%, %Key%
Section:="WindowsMessages"
/*
WM_NULL := 0x0000
WM_CREATE := 0x0001
WM_DESTROY := 0x0002
WM_MOVE := 0x0003
WM_SIZE := 0x0005
WM_ACTIVATE := 0x0006
WM_SETFOCUS := 0x0007
WM_KILLFOCUS := 0x0008
WM_ENABLE := 0x000A
WM_SETREDRAW := 0x000B
WM_SETTEXT := 0x000C
WM_GETTEXT := 0x000D
WM_GETTEXTLENGTH := 0x000E
WM_PAINT := 0x000F
WM_CLOSE := 0x0010
WM_QUERYENDSESSION := 0x0011
WM_QUIT := 0x0012
WM_QUERYOPEN := 0x0013
WM_ERASEBKGND := 0x0014
WM_SYSCOLORCHANGE := 0x0015
WM_ENDSESSION := 0x0016
WM_SYSTEMERROR := 0x0017
WM_SHOWWINDOW := 0x0018
WM_CTLCOLOR := 0x0019
WM_WININICHANGE := 0x001A
WM_SETTINGCHANGE := 0x001A
WM_DEVMODECHANGE := 0x001B
WM_ACTIVATEAPP := 0x001C
WM_FONTCHANGE := 0x001D
WM_TIMECHANGE := 0x001E
WM_CANCELMODE := 0x001F
WM_SETCURSOR := 0x0020
WM_MOUSEACTIVATE := 0x0021
WM_CHILDACTIVATE := 0x0022
WM_QUEUESYNC := 0x0023
WM_GETMINMAXINFO := 0x0024
WM_PAINTICON := 0x0026
WM_ICONERASEBKGND := 0x0027
WM_NEXTDLGCTL := 0x0028
WM_SPOOLERSTATUS := 0x002A
WM_DRAWITEM := 0x002B
WM_MEASUREITEM := 0x002C
WM_DELETEITEM := 0x002D
WM_VKEYTOITEM := 0x002E
WM_CHARTOITEM := 0x002F

WM_SETFONT := 0x0030
WM_GETFONT := 0x0031
WM_SETHOTKEY := 0x0032
WM_GETHOTKEY := 0x0033
WM_QUERYDRAGICON := 0x0037
WM_COMPAREITEM := 0x0039
WM_COMPACTING := 0x0041
WM_WINDOWPOSCHANGING := 0x0046
WM_WINDOWPOSCHANGED := 0x0047
WM_POWER := 0x0048
WM_COPYDATA := 0x004A
WM_CANCELJOURNAL := 0x004B
WM_NOTIFY := 0x004E
WM_INPUTLANGCHANGEREQUEST := 0x0050
WM_INPUTLANGCHANGE := 0x0051
WM_TCARD := 0x0052
WM_HELP := 0x0053
WM_USERCHANGED := 0x0054
WM_NOTIFYFORMAT := 0x0055
WM_CONTEXTMENU := 0x007B
WM_STYLECHANGING := 0x007C
WM_STYLECHANGED := 0x007D
WM_DISPLAYCHANGE := 0x007E
WM_GETICON := 0x007F
WM_SETICON := 0x0080

WM_NCCREATE := 0x0081
WM_NCDESTROY := 0x0082
WM_NCCALCSIZE := 0x0083
WM_NCHITTEST := 0x0084
WM_NCPAINT := 0x0085
WM_NCACTIVATE := 0x0086
WM_GETDLGCODE := 0x0087
WM_NCMOUSEMOVE := 0x00A0
WM_NCLBUTTONDOWN := 0x00A1
WM_NCLBUTTONUP := 0x00A2
WM_NCLBUTTONDBLCLK := 0x00A3
WM_NCRBUTTONDOWN := 0x00A4
WM_NCRBUTTONUP := 0x00A5
WM_NCRBUTTONDBLCLK := 0x00A6
WM_NCMBUTTONDOWN := 0x00A7
WM_NCMBUTTONUP := 0x00A8
WM_NCMBUTTONDBLCLK := 0x00A9

WM_KEYFIRST := 0x0100
WM_KEYDOWN := 0x0100
WM_KEYUP := 0x0101
WM_CHAR := 0x0102
WM_DEADCHAR := 0x0103
WM_SYSKEYDOWN := 0x0104
WM_SYSKEYUP := 0x0105
WM_SYSCHAR := 0x0106
WM_SYSDEADCHAR := 0x0107
WM_KEYLAST := 0x0108

WM_IME_STARTCOMPOSITION := 0x010D
WM_IME_ENDCOMPOSITION := 0x010E
WM_IME_COMPOSITION := 0x010F
WM_IME_KEYLAST := 0x010F

WM_INITDIALOG := 0x0110
WM_COMMAND := 0x0111
WM_SYSCOMMAND := 0x0112
WM_TIMER := 0x0113
WM_HSCROLL := 0x0114
WM_VSCROLL := 0x0115
WM_INITMENU := 0x0116
WM_INITMENUPOPUP := 0x0117
WM_MENUSELECT := 0x011F
WM_MENUCHAR := 0x0120
WM_ENTERIDLE := 0x0121

WM_CTLCOLORMSGBOX := 0x0132
WM_CTLCOLOREDIT := 0x0133
WM_CTLCOLORLISTBOX := 0x0134
WM_CTLCOLORBTN := 0x0135
WM_CTLCOLORDLG := 0x0136
WM_CTLCOLORSCROLLBAR := 0x0137
WM_CTLCOLORSTATIC := 0x0138

WM_MOUSEFIRST := 0x0200
WM_MOUSEMOVE := 0x0200
WM_LBUTTONDOWN := 0x0201
WM_LBUTTONUP := 0x0202
WM_LBUTTONDBLCLK := 0x0203
WM_RBUTTONDOWN := 0x0204
WM_RBUTTONUP := 0x0205
WM_RBUTTONDBLCLK := 0x0206
WM_MBUTTONDOWN := 0x0207
WM_MBUTTONUP := 0x0208
WM_MBUTTONDBLCLK := 0x0209
WM_MOUSEWHEEL := 0x020A
WM_MOUSEHWHEEL := 0x020E

WM_PARENTNOTIFY := 0x0210
WM_ENTERMENULOOP := 0x0211
WM_EXITMENULOOP := 0x0212
WM_NEXTMENU := 0x0213
WM_SIZING := 0x0214
WM_CAPTURECHANGED := 0x0215
WM_MOVING := 0x0216
WM_POWERBROADCAST := 0x0218
WM_DEVICECHANGE := 0x0219

WM_MDICREATE := 0x0220
WM_MDIDESTROY := 0x0221
WM_MDIACTIVATE := 0x0222
WM_MDIRESTORE := 0x0223
WM_MDINEXT := 0x0224
WM_MDIMAXIMIZE := 0x0225
WM_MDITILE := 0x0226
WM_MDICASCADE := 0x0227
WM_MDIICONARRANGE := 0x0228
WM_MDIGETACTIVE := 0x0229
WM_MDISETMENU := 0x0230
WM_ENTERSIZEMOVE := 0x0231
WM_EXITSIZEMOVE := 0x0232
WM_DROPFILES := 0x0233
WM_MDIREFRESHMENU := 0x0234

WM_IME_SETCONTEXT := 0x0281
WM_IME_NOTIFY := 0x0282
WM_IME_CONTROL := 0x0283
WM_IME_COMPOSITIONFULL := 0x0284
WM_IME_SELECT := 0x0285
WM_IME_CHAR := 0x0286
WM_IME_KEYDOWN := 0x0290
WM_IME_KEYUP := 0x0291

WM_MOUSEHOVER := 0x02A1
WM_NCMOUSELEAVE := 0x02A2
WM_MOUSELEAVE := 0x02A3

WM_CUT := 0x0300
WM_COPY := 0x0301
WM_PASTE := 0x0302
WM_CLEAR := 0x0303
WM_UNDO := 0x0304

WM_RENDERFORMAT := 0x0305
WM_RENDERALLFORMATS := 0x0306
WM_DESTROYCLIPBOARD := 0x0307
WM_DRAWCLIPBOARD := 0x0308
WM_PAINTCLIPBOARD := 0x0309
WM_VSCROLLCLIPBOARD := 0x030A
WM_SIZECLIPBOARD := 0x030B
WM_ASKCBFORMATNAME := 0x030C
WM_CHANGECBCHAIN := 0x030D
WM_HSCROLLCLIPBOARD := 0x030E
WM_QUERYNEWPALETTE := 0x030F
WM_PALETTEISCHANGING := 0x0310
WM_PALETTECHANGED := 0x0311

WM_HOTKEY := 0x0312
WM_PRINT := 0x0317
WM_PRINTCLIENT := 0x0318

WM_HANDHELDFIRST := 0x0358
WM_HANDHELDLAST := 0x035F
WM_PENWINFIRST := 0x0380
WM_PENWINLAST := 0x038F
WM_COALESCE_FIRST := 0x0390
WM_COALESCE_LAST := 0x039F
WM_DDE_FIRST := 0x03E0
WM_DDE_INITIATE := 0x03E0
WM_DDE_TERMINATE := 0x03E1
WM_DDE_ADVISE := 0x03E2
WM_DDE_UNADVISE := 0x03E3
WM_DDE_ACK := 0x03E4
WM_DDE_DATA := 0x03E5
WM_DDE_REQUEST := 0x03E6
WM_DDE_POKE := 0x03E7
WM_DDE_EXECUTE := 0x03E8
WM_DDE_LAST := 0x03E8

WM_USER := 0x0400
WM_APP := 0x8000
*/
;============================== End Script ==============================