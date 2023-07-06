;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; #Warn  ; Enable warnings to assist with detecting common errors.
; SetWinDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetControlDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 = max speed possible. ; (AJB - 05/2023)comment out for testing
; SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing 
; SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing 
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

;#NoTrayIcon

; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: MakeOSItalic()
; Description ..: Associated Press (AP), and Brand Assurance (BA) approved Operating Starndard (OS) citing method.
; ..............: Italicize the OS title.
; Author .......: Terry Keatts, Overcast (Adam Bacon)
; ToDo .........: Test/Fix Make_Window_Groups
; ----------------------------------------------------------------------------------------------------------------------
MakeOSItalic(OSTitle)
{
	
	;WinGet,  a_process,  ProcessName, A
	Msgbox % a_process ; Pops a message box so I know the process name to add to the logic below.
	Clipboard:=""
	If(a_process = "notepad.exe" or a_process = "notepad++.exe" or a_process = "AutoHotkeyU32.exe") ; Don't do italics in plain text editors
	{
		SendLevel 1
		IniRead, OST, OSTitle.ini,% OSTitle, Title
		Clipboard:=% ", " OST
		Send ^v
		Send, {Space}
		return
	}
	
	If(a_process = "hznhorizon.exe") ; Do Italic Font Specific to Horizon
	{
		SendLevel 1
		Clipboard:=""
		Send % ", "
		IniRead, OST, OSTitle.ini,% OSTitle, Title
		Clipboard:= % OST
		ClipWait 1
		Send ^i
		Send ^v
		Send ^i
		Send, {Space}
		return
	}
	
	Else
	{
		;Msgbox % OSTitle
		SendLevel 1
		;Clipboard:=""
		Send % ", "
		IniRead, OST, OSTitle.ini,% OSTitle, Title
		Clipboard:= % OST
		ClipWait 1
		Sleep 100
		Send ^i
		Send ^v
		Send ^i
		Send, {Space}
		return
	}
	
	return
}

#IfWinActive
	
/*
	MakeOSItalic(OSTitle)
{
	
	WinGet,  a_process,  ProcessName, A
	;	Msgbox % a_process ; Pops a message box so I know the process name to add to the logic below.
	
	If(a_process = "notepad.exe" or a_process = "notepad++.exe") ; Don't do italics in plain text editors
	{
		;OSSplit := StrSplit(OSTitle,",",,2) ; original
		;Send % OSSplit[1] "," ; original
		;Send % OSSplit[2] ; original
		IniRead, OS, OSTitle.ini,OS, %OSTitle%
		Clipboard:=% OS
		Send ^v
		Send, {Space}
		return
	}
	
	;If(a_process = "hznhorizon.exe") ; Do Italic Font Specific to Horizon
	;{
		;SendLevel 1
		;OSSplit := StrSplit(OSTitle,",",,2)
		;Send % OSSplit[1] ","
		;Sleep 100
		;Send ^i
		;sleep 100
		;Clipboard:= % OSSplit[2]
		;ClipWait 1
		;Send ^v
		;sleep 100
		;Send ^i
		;Sleep 100
		;Send, {Space}
		;return
	;}
	
	Else
	{
		SendLevel 1
		IniRead, OSN, OSTitle.ini,% OSTitle, OS
		Clipboard:= % OSN
		ClipWait 1
		Send ^v
		Send {Space}
		IniRead, OST, OSTitle.ini,% OSTitle, Title
		sleep 100
		Clipboard:= % OSN
		ClipWait 1
		Send ^v
		Clipboard:=""
		Sleep 100
		Send ^i
		sleep 100
		Clipboard:= % OST
		ClipWait 1
		Send ^v
		sleep 100
		Send ^i
		Sleep 100
		Send, {Space}
		return
	}
	Clipboard:=""
	return
}
*/