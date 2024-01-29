;Blank Template written by GroggyOtter

;============================== Start Auto-Execution Section ==============================
#Requires AutoHotkey v1.1+


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
GroupAdd, saveReload, %A_ScriptName%
;============================== Includes Section ==============================
/*
	#include WinClip_API.ahk
	#Include WinClip_base.ahk
	return
*/
;============================== ini Section ==============================
; Do not remove /* or */ from this section. Only modify if you're
; storing values to this file that need to be permanantly saved.
/*
	[SavedVariables]
	Key=Value
*/
;#IfWinActive
;============================== Main Script ==============================
^#b::GetFont()
GetFont(hWnd*) {
   static WM_GETFONT := 0x31
   hFont := DllCall("SendMessage", "Ptr", hWnd, "UInt", WM_GETFONT, "Ptr", 0, "Ptr", 0, "Ptr")
   if !hFont {
      Gui, Add, Text, xp yp wp hp Hidden hwndhText
      hFont := DllCall("SendMessage", "Ptr", hText, "UInt", WM_GETFONT, "Ptr", 0, "Ptr", 0, "Ptr")
      DllCall("DestroyWindow", "Ptr", hText)
   }
   size := DllCall("GetObject", "Ptr", hFont, "Int", 0, "Ptr", 0)
   VarSetCapacity(LOGFONT, size, 0)
   DllCall("GetObject", "Ptr", hFont, "Int", size, "Ptr", &LOGFONT)
   msg:= StrGet(&LOGFONT + 28)
   Return StrGet(&LOGFONT + 28)
   ToolTip % msg
}
