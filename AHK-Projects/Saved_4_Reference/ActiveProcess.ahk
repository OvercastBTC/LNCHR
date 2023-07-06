;-------------------------------------------------------------------------------
Watchdog(wParam) { ; calls the guard
;-------------------------------------------------------------------------------
    ; HSHELL_WINDOWCREATED      = 1
    ; HSHELL_WINDOWACTIVATED    = 4
    ; HSHELL_RUDEAPPACTIVATED   = 32772 (fullscreen app activated)
    ;---------------------------------------------------------------------------
    static init   := DllCall("RegisterShellHookWindow", Ptr, A_ScriptHwnd)
        , MsgNum  := DllCall("RegisterWindowMessage", Str, "SHELLHOOK")
        , neglect := OnMessage(MsgNum, "Watchdog")
        , CleanUp := {base: {__Delete: "Watchdog"}}

    If Not IsObject(CleanUp) {
        OnMessage(MsgNum, "")
        DllCall("DeregisterShellHookWindow", Ptr, A_ScriptHwnd)
    }

    If (wParam = 1 Or wParam = 4 Or wParam = 32772)
        Guard()
}



;-------------------------------------------------------------------------------
Guard() { ; code to check ...
;-------------------------------------------------------------------------------
    global hznon, Script1, Script2, h_process, nothznon
    static PID_hzn, PID_nothzn
WinGet,  a_process,  ProcessName,  A
SetTimer,Update_Window,100

if (a_process=h_process){
	WinActivate, ahk_exe hznHorizon.exe
	#Include h_os_list.ahk
	;Run, %Script1%,, PID_hzn
	;SplashTextOn, 300, 300, Process,  %a_process%
	;sleep,  1000
	;WinMove,  Process, , 0,0 
	;MsgBox, Press OK to Exit
	;SplashTextOff
} else{
	;SplashTextOff
	#Include oslist.ahk
}
return
    If WinExist("ahk_exe hznhorizon.exe") and (hznon = 0) {
        Run, %Script1%,, PID_hzn
        hznon := 1
    }

    If !WinExist("ahk_exe hznhorizon.exe") and (hznon = 1) {
        WinClose, ahk_pid %PID_hzn%
        hznon := 0
    }

	If WinExist(a_process!=h_process) and (nothznon = 0) {
		Run, %Script2%,, PID_nothzn
	   exelon := 1
	{
	
	If !WinExist(a_process=h_process) and (nothznon = 1) {
		WinClose, ahk_pid %PID_nothzn%
		nothznon := 0
	}
}
