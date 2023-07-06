CopyIfNewer:
; Caller has set the variables CopySourcePattern and CopyDest for us.
Loop, Files, 
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