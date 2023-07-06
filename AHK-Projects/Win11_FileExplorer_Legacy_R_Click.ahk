;============================== Windows File Explorer - Shift Left Click =============================

; https://answers.microsoft.com/en-us/windows/forum/all/restore-old-right-click-context-menu-in-windows-11/a62e797c-eaf3-411b-aeec-e460e6e5a82a
; Restore the old Context Menu in Windows 11

;Right-click the Start button and choose Windows Terminal.

;Copy the command from below, paste it into Windows Terminal Window, and press enter.

;reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

;Restart File Explorer or your computer for the changes to take effect.

;You would see the Legacy Right Click Context menu by default.

; ===================> To do List: make the script for the above guidance <===================

; ==================== Previous Revision (below) - Not 100% ====================
/*
#IfWinExist ahk_class CabinetWClass ;if a file explorer is open (but not necessarily active)
	ControlGetFocus, var1,ahk_class CabinetWClass ; sets var1 to verify that is is an active window (but not necessarily the actual active window)
	While var1 = ahk_class CabinetWClass and var1 != ahk_class Shell_TrayWnd ; while it is an active window (but not necessarily THE active window)
		Rbutton:: ; while the above conditions are true, the Rbutton now equals everything below
		;DetectHiddenText,On		;this should already be on and not necessary
		;DetectHiddenWindows, On		;this should already be on and not necessary
		SetMouseDelay, 100			;!!! definitely needed !!!
		SetControlDelay -1			;May improve reliability - prevents a click and hold
		;ControlClick, CabinetWClass 	;essentially activates the window under the mouse with a pseudo left click
; definitely need each step below... it becomes interesting if you don't
		SendEvent {LShift Down}
		SendEvent {Rbutton Down}
		SendEvent {Rbutton Up}
		SendEvent {LShift Up}
	return
#IfWinExist
;============================== End of Windows File Explorer - Shift Left Click ======================
return
*/
/*
#IfWinExist ahk_exe explorer.exe ;if a file explorer is open (but not necessarily active)
	If(ahk_class = CabinetWClass){
	ControlGetFocus, var1, ahk_class CabinetWClass ; sets var1 to verify that is is an active window (but not necessarily the actual active window)
	While var1 = ahk_class CabinetWClass ;and var1 != ahk_class Shell_TrayWnd ; while it is an active window (but not necessarily THE active window)
		Rbutton:: ; while the above conditions are true, the Rbutton now equals everything below
		DetectHiddenText,On		;this should already be on and not necessary
		DetectHiddenWindows, On		;this should already be on and not necessary
		SetMouseDelay, 100			;!!! definitely needed !!!
		SetControlDelay -1			;May improve reliability - prevents a click and hold
		;ControlClick, CabinetWClass 	;essentially activates the window under the mouse with a pseudo left click
; definitely need each step below... it becomes interesting if you don't
		SendEvent {LShift Down}
		SendEvent {Rbutton Down}
		SendEvent {Rbutton Up}
		SendEvent {LShift Up}
		return
	} else {
		return
	}	
	return
#IfWinExist
;============================== End of Windows File Explorer - Shift Left Click ======================
return
*/