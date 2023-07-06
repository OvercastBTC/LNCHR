#NoEnv
SetBatchLines -1


#IfWinActive ahk_exe AutoHotkeyU32.exe
;---------------------------------------------------------------------------
;                Ctrl+Shift+Alt+r Reload AutoHotKey Script (to load changes)
;---------------------------------------------------------------------------

^+!r::
ReloadAllAhkScripts()
;TrayTip
;Reload
;return

ReloadAllAhkScripts() {
	DetectHiddenWindows, On
	SetTitleMatchMode, 2
	WinGet, allAhkExe, List, ahk_class AutoHotkey
	Loop, % allAhkExe {
		hwnd := allAhkExe%A_Index%
		if (hwnd = A_ScriptHwnd)  ; ignore the current window for reloading
		{
			continue
		}
		PostMessage, 0x0111, 65303,,, % "ahk_id" . hwnd
	}
	
}
Reload
#IfWinActive