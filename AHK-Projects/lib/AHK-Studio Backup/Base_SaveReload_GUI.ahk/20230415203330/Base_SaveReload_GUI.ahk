;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"

; ahk-Sushi: Anime Icon + Progressbar in Statusbar
; (w) Nov 2008 by DerRaphael(at)oleco.net

gui,add,text,w180 center y10,Demo anime Icon`n+ Progressbar in StatusbarControl
gui,add,button,x+10 yp-3 w90 gRestart vBtn1 default, Restart!
Gui,add,statusbar, hwndhwndBar
gui,show,w300,Saving

gui +LastFound
WinGet GUI_hWnd,ID
GroupAdd GUI_Group,% "ahk_id" . GUI_hWnd



SB_SetParts(20,200,100)
SB_SetText("demotext",2,0)
hIS     := SB_SetIcon(A_AhkPath,1,1)
hWndSBP := SB_AddProgress(hwndBar,3)
Gosub, Prep_Animation

Restart:
   GuiControl,Disable,Btn1
   pp := 0
   SetTimer,ProgressAnimation,50
   Running:=true
return

ProgressAnimation:
   SB_SetProgress(hWndSBP,   pp++)
   R := mod(pp+,8)//2+1
   SendMessage, 0x40F, 0, hI%R%,, ahk_id %hwndBar%     ; SB_SETICON := (WM_USER:=0x400) + 15 - icon animation!
   if (pp=100) {
      SendMessage, 0x40F, 0, hIS,, ahk_id %hwndBar%   ; StandardIcon hIS
      SB_SetText("`tSave Complete",2,0)              ; update Text 
      SetTimer,ProgressAnimation,Off                  ; Timer OFF
      GuiControl,Enable,Btn1
      Running:=false
   } else ; update Text
      SB_SetText("`tSaving in Progress: " pp " %",2,0)
Return

Prep_Animation:
; Prepare Animation - Load 4 Icons and make their handle available
Loop,4 {
   if !(FileExist(fn:="i" (A_Index-1) ".ico"))
      URLDownloadToFile,http://itholic.org/img/%fn%,%fn%
   hI%A_Index% := DllCall("LoadImage", "UInt", 0
                     , "Str", fn, "UInt", 1, "Int", 16, "Int", 16, "UInt", 0x10|0x2000)
}
Return


;--------------------------------------------- Added Stop routine
Stop:
SetTimer,ProgressAnimation,Off
SendMessage, 0x40F, 0, hIS,, ahk_id %hwndBar%   ; StandardIcon hIS
SB_SetText("demo text",2,0)                     ; Reset text
SB_SetProgress(hWndSBP,0)
GuiControl,Enable,Btn1
Running:=false
return


;;;;;GUIEscape:
GuiClose:
   exitapp


;--------------------------------------------- Added context sensitive hotkey
#IfWinActive ahk_group GUI_Group
Escape::
if Running
    gosub Stop
 else
    gosub GUIClose
return
#IfWinActive


; [Remarks]
; These functions are in an early development stage and therefor usage might change in future
; releases. 

SB_AddProgress(hwndBar,Segment) { ; v0.1 (w) Nov 12, 2008 by DerRaphael / Released under EUPL 1.0
   static SB_GETRECT  := 0x40a   ; (WM_USER:=0x400) + 10
   VarSetCapacity(RECT,16,0)     ; RECT = 4*4 Bytes / 4 Byte <=> Int
   ; Segment Size :: 0-base Index => 1. Element -> #0
   SendMessage,SB_GETRECT,Segment-1,&RECT,,ahk_id %hwndBar%
   If ErrorLevel
      Loop,4
         n%A_index% := NumGet(RECT,(a_index-1)*4,"Int")
   else
      return -1
   hCtrl := DllCall("CreateWindowEx","uint",0,"str","msctls_progress32"
      ,"uint",0,"uint",0x50000001      ; dwStyle WS_CHILD|WS_VISIBLE|PBS_SMOOTH
      ,"int",0,"int",0,"int",0,"int",0 ; segment-progress :: X/Y/W/H 
      ,"uint",DllCall("GetAncestor","uInt",hwndBar,"uInt",1) ; gui hwnd
      ,"uint",0,"uint",0,"uint",0)
   ControlGetPos,xb,yb,,,,ahk_id %hwndBar%
   ControlMove,,xb+n1,yb+n2,n3-n1,n4-n2,ahk_id %hCtrl%
   return hCtrl
}

SB_SetProgress(hWndProg,value) { ; v0.1 (w) Nov 12, 2008 by DerRaphael / Released under EUPL 1.0
	SendMessage,0x402,value,0,,ahk_id %hWndProg% ; PBM_SETPOS := (WM_USER:=0x400) + 2)
}