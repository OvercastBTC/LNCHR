/*
; https://www.autohotkey.com/boards/viewtopic.php?t=91592
/*
	*Start Variables
	*Global theme:= "+Border -SysMenu" ;+Resize  +Theme
	*Global OnTop:= "+AlwaysOnTop"
	*Global NotOnTop:= "-AlwaysOnTop"
	*Global root:= "C:\AHK-Studio\"
	*Global OneDrive:= "C:\Users\bacona\OneDrive - FM Global\"
	*Global teams:= "General - AutoHotKey User Group\"
	*Global t_script:= "Adams Buggy Betas\"
	*Global root_RSS:= "3. AHK\"
	
/*
; script name and startup path
	splitPath, a_ScriptFullPath, , , script_ext, script_name
	global sName:= script_name
	global script_full_name:= script_name "." script_ext
	global startup_shortcut:= A_Startup "\" script_full_name ".lnk"
	global startTime
	global finishTime
	IniRead, tSaved, %root%lib\LastSaved.ini, SavedVariables, LastSaved
	global startTime := tSaved
	global finishTime := A_Now
	; A_Startup = C:\Users\<UserName>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
	; End Variables
*/	
/*
	SavetoServer:
	FileCopyDir, %root%, %OneDrive%%teams%%t_script%, 1
	FileCopyDir, %OneDrive%%root_RSS%, %OneDrive%%teams%RSS, 1
	return
*/
/*
	Mode
	If blank or omitted, only files are included and subdirectories are not recursed into. Otherwise, specify one or more of the following letters:
		
	D = Include directories (folders).
	F = Include files. If both F and D are omitted, files are included but not folders.
	R = Recurse into subdirectories (subfolders). If R is omitted, files and folders in subfolders are not included.
*/
CopyDest:= % path

LoopFile-Script(path)

;CopyIfNewer:
; Caller has set the variables CopySourcePattern and CopyDest for us.
Loop, Files, % fileList, R
{
	copy_it := false
	if not FileExist(CopyDest "\" A_LoopFileName)  ; Always copy if target file doesn't yet exist.
		copy_it := true
	else
	{
		FileGetTime, time, %CopyDest%\%A_LoopFileName%
		EnvSub, time, %A_LoopFileTimeModified%, seconds  ; Subtract the source file's time from the destination's.
		if (time < 0)  ; Source file is newer than destination file.
			copy_it := true
	}
	if copy_it
	{
		FileCopy, %A_LoopFileFullPath%, %CopyDest%\%A_LoopFileName%, 1   ; Copy with overwrite=yes
		if ErrorLevel
			MsgBox, Could not copy "%A_LoopFileFullPath%" to "%CopyDest%\%A_LoopFileName%".
	}
}
Return