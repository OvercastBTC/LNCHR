;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; #Warn  ; Enable warnings to assist with detecting common errors.
;SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing 
;SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible. ; (AJB - 05/2023)comment out for testing
;SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing 
;SetWinDelay 0
;SetControlDelay 0
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#Requires AutoHotkey 1.1+
; ----------------------------------------------------------------------------------------------------------------------
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Gui, +AlwaysOnTop
Gui, Add, Text,, WinHook.Shell
Gui, Add, ListView, r25 w1000, Win_Hwnd|Win_Title|Win_Class|Win_Exe|Win_Event
Gui, Show

WinHook.Shell.Add("AllShell") ; no additional filter parameters result in all windows

AllShell(Win_Hwnd, Win_Title, Win_Class, Win_Exe, Win_Event)
{
	LV_Insert(1, "", Win_Hwnd, Win_Title, Win_Class, Win_Exe, Win_Event)
	Loop, 5
		LV_ModifyCol(A_Index, "AutoHdr")
}

return
GuiClose:
ExitApp
