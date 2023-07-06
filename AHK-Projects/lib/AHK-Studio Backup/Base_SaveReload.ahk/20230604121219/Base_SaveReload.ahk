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
#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#Requires AutoHotkey 1.1+
;#NoTrayIcon
; ********************************************** ... First Return ... **************************************************
return
; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; ----------------------------------------------------------------------------------------------------------------------
; Script .....: Reload - On Save - & Copy to AHK Teams
; Resource ...: https://www.autohotkey.com/boards/viewtopic.php?t=91592
; Resource ...: https://www.autohotkey.com/docs/v1/lib/LoopFile.htm#ExFileCopy
; ----------------------------------------------------------------------------------------------------------------------

#IfWinActive ahk_exe AutoHotkeyU32.exe
;#IfWinActive ahk_group ahk_editors
Base_SaveReload()
{
	
	; ----------------------------------------------------------------------------------------------------------------------
	; Section ....: Define Variables
	EnvGet, vUserProfile, USERPROFILE
	EnvGet, vHomeDrive, HOMEDRIVE
	EnvGet, vHomePath, HOMEPATH
	; === quick test section ===
	;ToolTip % "UsrProf: " vUserProfile "`rHomeDrive: " vHomeDrive "`rHomePath: " vHomePath
	;return
	TargetFolder:= % vUserProfile "\OneDrive - FM Global\General - AutoHotKey User Group\Adams Buggy Betas"
	SourceFolder:="C:\AHK-Studio"
	ResourceFolder:=% vUserProfile "\OneDrive - FM Global\3. AHK"
	LibraryFolder:=% vUserProfile "\OneDrive - FM Global\Documents\Autohotkey"
	LastSavedFile:="LastSaved.ini"
	; ----------------------------------------------------------------------------------------------------------------------
	
	; ----------------------------------------------------------------------------------------------------------------------
	; Section ....: INI read and write
	; Notes ......: No longer needed for the purpose of saving due to the function LoopFile_Script
	; Notes ......: Kept to setup AutoUpdate function in the future
	IniRead, LocalSaved, % LibraryFolder "\" LastSavedFile, SavedVariables, LastSaved
	IniRead, ServerSaved, % TargetFolder "\" LastSavedFile, SavedVariables, LastSaved
	IniWrite, %A_Now%, % LibraryFolder "\" LastSavedFile, SavedVariables, LastSaved
	IniWrite, %A_Now%, % TargetFolder "\" LastSavedFile, SavedVariables, LastSaved
	If (A_Now - LocalSaved <5000){
		if ErrorLevel
			MsgBox % "FAILED!!!"
		return
	} Else {
		Reload
	}
	return
	; ----------------------------------------------------------------------------------------------------------------------
	
	; ----------------------------------------------------------------------------------------------------------------------
	; Section ....: Save
	LoopFile_Script(TargetFolder, SourceFolder)
		if ErrorLevel{
			MsgBox % "FAILED!!!"
			return
		} else {
			;return
		}	
		LoopFile_Script(TargetFolder, ResourceFolder)
		if ErrorLevel{
			MsgBox % "FAILED!!!"
			return
		} else {
			;return
		}
		LoopFile_Script(TargetFolder, LibraryFolder)
		if ErrorLevel{
			MsgBox % "FAILED!!!"
			return
		} else {
			MsgBox % A_ThisFunc
			;Reload
			return
		}
	; ----------------------------------------------------------------------------------------------------------------------
	; ----------------------------------------------------------------------------------------------------------------------
	
	reload
	; ----------------------------------------------------------------------------------------------------------------------
}
Return

; ----------------------------------------------------------------------------------------------------------------------
; Section ....: Brute Force Copy
^#s::
SavetoServer:
FileCopyDir, %SourceFolder%, %TargetFolder%, 1
FileCopyDir, %ResourceFolder%, %TargetFolder%, 1
FileCopyDir, %LibraryFolder%, %TargetFolder%, 1
reload
return
; ----------------------------------------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: LoopFile_Script()
; Description ..: Save and Copy all AHK files and resources to the AHK Teams File Folder
; Definition ...: TargetFolder = The destination folder where the files will be copied
; Definition ...: SourceFolder = The folder (and sub-folders) that will be copied to the TargetFolder
; Author .......: Overcast (Adam Bacon)
; AHK Resource .: Function derived from ==> https://www.autohotkey.com/docs/v1/lib/LoopFile.htm#ExFileCopy
; ----------------------------------------------------------------------------------------------------------------------

LoopFile_Script(TargetFolder, SourceFolder){
	
	;CopyIfNewer:
	CopyDest:=% TargetFolder
	; Caller has set the variables CopySourcePattern and CopyDest for us.
	Loop, Files, % SourceFolder, R
	{
		MsgBox % SourceFolder
		copy_it := false
		if not FileExist(TargetFolder "\" A_LoopFileName)  ; Always copy if target file doesn't yet exist.
			copy_it := true
		else
		{
			FileGetTime, time, %TargetFolder%\%A_LoopFileName%
			EnvSub, time, %A_LoopFileTimeModified%, seconds  ; Subtract the source file's time from the destination's.
			if (time < 0)  ; Source file is newer than destination file.
				copy_it := true
		}
		if copy_it
		{
			FileCopy, %A_LoopFileFullPath%, %TargetFolder%\%A_LoopFileName%, 1   ; Copy with overwrite=yes
			if ErrorLevel
				MsgBox, Could not copy "%A_LoopFileFullPath%" to "%TargetFolder%\%A_LoopFileName%".
			else 
				return ErrorLevel
		}
	}
}
Return


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
	Reload
}
#IfWinActive