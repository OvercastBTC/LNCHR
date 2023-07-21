; Section .....: Auto-Execution
#SingleInstance Force
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetTitleMatchMode(2) ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText(true)
DetectHiddenWindows(true)
#Requires Autohotkey v2.0

; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; ----------------------------------------------------------------------------------------------------------------------
; Script .....: Reload - On Save - & Copy to AHK Teams
; Resource ...: https://www.autohotkey.com/boards/viewtopic.php?t=91592
; Resource ...: https://www.autohotkey.com/docs/v1/lib/LoopFile.htm#ExFileCopy
; ----------------------------------------------------------------------------------------------------------------------

Base_ReloadAllAhkScripts() {
	DetectHiddenWindows(true)
	SetTitleMatchMode(2)
	oallAhkExe := WinGetList("ahk_class AutoHotkey",,,)
	aallAhkExe := Array()
	allAhkExe := oallAhkExe.Length
	For v in oallAhkExe
	{   aallAhkExe.Push(v)
	}
	Loop aallAhkExe.Length {
		hwnd := aallAhkExe[A_Index]
		if (hwnd = A_ScriptHwnd or WinActive("ahk_class JeanLalonde.ca"))  ; ignore the current window for reloading
		{
			continue
		}
		PostMessage(0x0111, 65303, , , "ahk_id" . hwnd)
	}
	; Reload()
}
