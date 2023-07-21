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

Gui 1:+Resize

Gui 1:Add, Button, vB1, Test Button1

Gui 1:Add, Text,, This is a test1

Gui 1:Add, Text,, ... another test1...

Gui 1:Show, x300 h150



Gui 2:+Resize

Gui 2:Add, Button, vB2, Test Button2

Gui 2:Add, Text,, This is a test2

Gui 2:Add, Text,, ... another test2...

Gui 2:Show, x700 h150



Bar2 := SB_Segments(2)           ; Status Bar of one segment on GUI:2

SB_Text(Bar2, 0, "GUI = 2")

SB_Icon(Bar2, 0, "shell32.dll",1)



Bar1 := SB_Segments(1,"20,99,-1")

SB_Icon(Bar1, 0, "shell32.dll",5)

SB_Text(Bar1, 1, "GUI = 1")

Return



GuiSize:                         ; BarID must be in Bar1 for Gui1, Bar2 for Gui2...

2GuiSize:

Bar := Bar%A_Gui%

SendMessage 5,0,0,,ahk_id %Bar%

Return



SB_Segments(GUI,segs=-1) ; Create Status Bar for GUI = 1.., divide it into segments, return its handle

{                   ; segs = right-edge positions of segments in string "10,20,-1" (-1 = right border)
	
	Gui %GUI%:Show
	
	;  WinGetPos,,,,H,A              ; uncomment these 2 lines for ...
	
	;  Gui %GUI%:Show, % "h" H-15    ; extending GUI windows down by 30-15 pixels
	
	; \/  WS_CHILD (0x40000000) + WS_VISIBLE (0x10000000)
	
	BarHWND := DllCall("CreateStatusWindow", int, 0x50000000, str, "", UInt, WinExist("A"), UInt, 5555)
	
	StringReplace segs,segs,`,,`,,UseErrorLevel
	
	n := ErrorLevel + 1           ; # segments
	
	VarSetCapacity( parts, 4*n )  ; Reserve 4 Bytes for each segment
	
	Loop Parse, segs, `,          ; Fill the var 'parts' with the positions
		
	InsertInteger( A_LoopField, &parts + 4*A_Index-4 )
	
	SendMessage 0x404,%n%,&parts,,ahk_id %BarHWND%  ; Send number of segments, positions to status bar
	
	Return BarHWND
	
}



SB_Icon(BarHWND, seg, file, idx) ; Add icon 'idx' from 'file' to segment 'seg' = 0,1.. in the status bar

{
	
	If (InStr(file,".dll") OR InStr(file,".exe")){
		
		hiconL:= DllCall("Shell32\ExtractIconA", UInt, NULL, Str, file, UInt, idx - 1)
		
		hicon := DllCall("CopyImage", UInt, hiconL, UInt, 1, UInt, 16, UInt, 16, UInt, 0)
		
	} Else
		
	hicon := DllCall("LoadImage", UInt, NULL, Str, file, UInt, 1, Int, 16, Int, 16, UInt, 0x2010)
	
	SendMessage 0x40F,seg,hicon,,ahk_id %BarHWND% ; 0x40F = SB_SETICON
	
}



SB_Text(BarHWND, seg, text)      ; Add 'text' to segment 'seg' = 0,1.. in the status bar

{
	
	SendMessage 0x401,seg,&text,,ahk_id %BarHWND%   ; 0x401 = SB_SETTEXT
	
}



InsertInteger(pInteger, pAddress, pSize = 4)

{                                ; Copy bytes in pInteger into pAddress as raw binary data
	
	Loop %pSize%
		
	DllCall("RtlFillMemory", UInt,pAddress+A_Index-1, UInt,1, UChar, pInteger >> 8*A_Index-8 & 0xFF )
	
}