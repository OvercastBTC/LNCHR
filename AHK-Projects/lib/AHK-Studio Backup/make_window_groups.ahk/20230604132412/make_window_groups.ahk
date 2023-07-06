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
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Make_Window_Groups()
; Description ..: Create groups
; Author .......: GroggtOtter, Overcast (Adam Bacon)
; ToDo .........: Fix me
; ----------------------------------------------------------------------------------------------------------------------
make_w_groups()
{
	;-------- advanced_editors ----------
	GroupAdd, advanced_editors, ahk_exe WindowsTerminal.exe
	GroupAdd, advanced_editors, ahk_exe Code.exe
	;-------- basic_editors ----------
	GroupAdd, basic_editors, ahk_exe notepad.exe
	GroupAdd, basic_editors, ahk_exe notepad++.exe
	GroupAdd, basic_editors, ahk_exe AutoHotkeyU32.exe
	GroupAdd, basic_editors, ahk_exe AutoHotkeyU64.exe
	GroupAdd, basic_editors, ahk_exe AutoHotkey.exe
	;-------- AHK Variations ----------
	GroupAdd, ahk_editors, ahk_exe AutoHotkeyU32.exe
	GroupAdd, ahk_editors, ahk_exe AutoHotkeyU64.exe
	GroupAdd, ahk_editors, ahk_exe AutoHotkey.exe
	
	;-------- report_editors ----------
	GroupAdd, report_editors, ahk_exe hznhorizon.exe
}