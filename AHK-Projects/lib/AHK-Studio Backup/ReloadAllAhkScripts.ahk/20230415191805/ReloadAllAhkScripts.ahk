#NoEnv
SetBatchLines -1

~^s:
#IfWinActive ahk_exe AutoHotkeyU32.exe

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
Reload
#IfWinActive
return

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