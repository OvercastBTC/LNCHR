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
SendMessage, WM_USER + 3 (0x00000403),0x00000064,,,ahk_id 0x000a1300
SendMessage, WM_USER + 3 (0x00000403),0x00000065,,,ahk_id 0x000a1300
SendMessage, WM_USER + 3 (0x00000403),0x00000066,,,ahk_id 0x000a1300
SendMessage, 0X0281, 0x00000001, 0xc000000f,, ahk_id 0x00061306
SendMessage, WM_USER + 7441 (0x00002111), 0x07050000,,,ahk_id 0x00061306

; --- TX11 - set to italics ---------------------------------------------- ;#[winmenuselectitem_horizon - italics text]
;WM_IME_SETCONTEXT
SendMessage,WM_IME_SETCONTEXT,0x00000001,0xc000000f,,ahk_id 0x00061306
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
;============================== ini Section ==============================
; Do not remove /* or */ from this section. Only modify if you're
; storing values to this file that need to be permanantly saved.
/*
[SavedVariables]
Key=Value
*/
;============================== End Script ==============================