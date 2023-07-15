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
; ************************************ ... First Return ... ****************************************
return
; --------------------------------------------------------------------------------------------------

; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Library_Load(filename)
{
  static ref := {}
  if (!(ptr := p := DllCall("LoadLibrary", "str", filename, "ptr")))
    return 0
  ref[ptr,"count"] := (ref[ptr]) ? ref[ptr,"count"]+1 : 1
  p += NumGet(p+0, 0x3c, "int")+24
  o := {_ptr:ptr, __delete:func("FreeLibrary"), _ref:ref[ptr]}
  if (NumGet(p+0, (A_PtrSize=4) ? 92 : 108, "uint")<1 || (ts := NumGet(p+0, (A_PtrSize=4) ? 96 : 112, "uint")+ptr)=ptr || (te := NumGet(p+0, (A_PtrSize=4) ? 100 : 116, "uint")+ts)=ts)
    return o
  n := ptr+NumGet(ts+0, 32, "uint")
  Loop, % NumGet(ts+0, 24, "uint")
  {
    if (p := NumGet(n+0, (A_Index-1)*4, "uint"))
    {
      o[f := StrGet(ptr+p, "cp0")] := DllCall("GetProcAddress", "ptr", ptr, "astr", f, "ptr")
      if (Substr(f, 0)==((A_IsUnicode) ? "W" : "A"))
        o[Substr(f, 1, -1)] := o[f]
    }
  }
  return o
}

Library_Free(lib)
{
	if (lib._ref.count>=1)
		lib._ref.count -= 1
	if (lib._ref.count<1)
		DllCall("FreeLibrary", "ptr", lib._ptr)
}