;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
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

Gui, +AlwaysOnTop
Gui, Add, ListView, h200 w870, Count|WinTitle|ahk_class|hWinEventHook|event|hwnd|idObject|idChild|dwEventThread|dwmsEventTime
for Col, Width in [50, 150, 100, 100, 50, 80, 80, 50, 100, 100]
	LV_ModifyCol(Col, Width)
Gui, Show, x10 y10
OnExit, UnHook

; ExcelPID is used for the idProcess parameter when calling SetWinEventHook
WinGet, Process, ProcessName, ahk_exe Hznhorizon.exe ;Process, Exist, Hznhorizon.exe
if ErrorLevel
	ExcelPID := ErrorLevel

/*  HWINEVENTHOOK WINAPI SetWinEventHook
 *      - http://msdn.microsoft.com/en-us/library/windows/desktop/dd373640%28v=vs.85%29.aspx
 *  Event Constants
 *      - http://msdn.microsoft.com/en-us/library/windows/desktop/dd318066%28v=vs.85%29.aspx
 */
EVENT_OBJECT_CREATE := 0x8000
EVENT_OBJECT_FOCUS := 0x8005
EVENT_OBJECT_LOCATIONCHANGE := 0x800B
EVENT_SYSTEM_MOVESIZEEND := 0x000B
EVENT_SYSTEM_MOVESIZESTART := 0x000A
WINEVENT_OUTOFCONTEXT := 0x0
WINEVENT_SKIPOWNPROCESS := 0x2
Hook := DllCall("SetWinEventHook"
    , "UInt",   EVENT_SYSTEM_MOVESIZESTART                      ;_In_  UINT eventMin
    , "UInt",   EVENT_SYSTEM_MOVESIZEEND                        ;_In_  UINT eventMax
    , "Ptr" ,   0x0                                             ;_In_  HMODULE hmodWinEventProc
    , "Ptr" ,   RegisterCallback("WinEventProc")                ;_In_  WINEVENTPROC lpfnWinEventProc
    , "UInt",   ExcelPID                                        ;_In_  DWORD idProcess
    , "UInt",   0x0                                             ;_In_  DWORD idThread
    , "UInt",   WINEVENT_OUTOFCONTEXT|WINEVENT_SKIPOWNPROCESS)  ;_In_  UINT dwflags
return


/*  WinEventProc callback function
 *      - http://msdn.microsoft.com/en-us/library/windows/desktop/dd373885%28v=vs.85%29.aspx
 */
WinEventProc(hWinEventHook, event, hwnd, idObject, idChild, dwEventThread, dwmsEventTime) {
    static Count := 0
    WinGetTitle, WinTitle, ahk_id %hwnd%
    WinGetClass, WinClass, ahk_id %hwnd%
    LV_Insert(1, "", ++Count, WinTitle, WinClass, hWinEventHook, event, hwnd, idObject, idChild, dwEventThread, dwmsEventTime)
    return
}

UnHook:
DllCall("UnhookWinEvent", "Ptr",Hook)
GuiEscape:
GuiClose:
ExitApp