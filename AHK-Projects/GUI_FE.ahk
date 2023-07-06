;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
;#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
;SetWinDelay, -1
;SetControlDelay, -1
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;#NoTrayIcon
;============================== End Auto-Execution Section ==============================

;--------------------------------------------------------------------------
;          Shift+Ctrl+WIN+O to Open OS
;--------------------------------------------------------------------------
;^+#o::
#Include GUI_Options.ahk

EnvGet, vUserProfile, USERPROFILE
EnvGet, vHomeDrive, HOMEDRIVE
EnvGet, vHomePath, HOMEPATH
; === quick test section ===
;MsgBox UsrProf: %vUserProfile%`r`nHomeDrive: %vHomeDrive%`r`nHomePath: %vHomePath%
os_dir:="\FM Global\Operating Standards - Documents\opstds\"
ds_dir:="\FM Global\Operating Standards - Documents\ds\"
le_guide_dir:="\FM Global\Operating Standards - Documents\general\"
; os:= "fm"
; ds:= "FMDS"
;templates section
rss_templts = C:\Users\bacona\OneDrive - FM Global\1. Sites\0.01 Resources
templts = \Templates
font = Calibri
ftype_pdf = .pdf
ftype_xl = .xlsx
gui_name:= "====> Field Engineer Quick Resources <===="
global input:=""

Gui, Destroy
Gui, 1:New,, % gui_name
Gui,+AlwaysOnTop +Caption +Border +Resize +SysMenu +Theme
Gui,Color,Gray
Gui,Font,s10 Q4, %font% UI Black
;Gui,Add,Text, cAqua xm w30 h20 Border Center gTag, OC
Gui,Add,Text,cBlue x+100 w120 h20 Border Center gMove_window,Move Window
Gui,Add,Checkbox,cLime xm+135 Center Checked vAlways gAOT,AlwaysOnTop
Gui,Add,Button, section xm w200 gSet_Next_On_Top -Theme,Set Next Win On Top
Gui,Add,Button,x+5 w200 vgSet_Last_On_Top -Theme,Set Last Win On Top
Gui, Add, Text, section xm+150,Enter OS/DS #:
Gui, Add, Edit, TabStop section Center R1 vInput xm+170 W50,
Gui, Add, Button, TabStop Default gOS xm+150, &OS
Gui, Add, Button, TabStop gDS x+30, &DS
Gui, Add, Text,section xm+110,OS (default) or DS? (e.g., 5-19)
Gui, Add, Text, section xm+130, Press "Enter" to continue...
Gui, Add, Text, cBlue section xm, ===================================================
Gui, Add, Text,xm+25,Keyword Search (optional): (e.g.`, Operations and Maintenance)
Gui, Add, Edit, TabStop vSearch xm+125,
Gui, Add, Text, cBlue section xm, ===================================================
Gui, Add, Button, section gLEGuide xm, &B&&M LE Guide
Gui, Add, Button, gHorizon x+20, &Horizon
Gui, Add, Button, gITM x+10, &ITM Recorder
;Gui, Add, Text, section xm, Optional: Search for:
;Gui, Add, Edit, vSearch1 x+15, Switchgear - Panels
Gui, Add, Text, cBlue section xm, ===================================================
Gui, Add, Text, cLime section xm+135,Resources && Templates
Gui, Add, Button, section gLECalc xm, &LE Calculator (blank)
Gui, Add, Button, gICS x+10, &ICS Diagram Template
Gui, Add, Button, gRecs section xm, &Recommendation Template
Gui, Add, Button, gSC4 section xm, &Scriptlett v4 (Rec Template)
Gui, Add, Button, section gCancel xm+350, Cancel
Gui, Show, AutoSize ;, % gui_name
Gui, Submit,Nohide
;return

GuiControlGet, input,, Input, Text
GuiControlGet, search,, Search, Edit
GuiControlGet, search1,, Search1, Edit
return

; ============================== Horizon =============================================
Horizon:
SetMouseDelay, 100			;!!! definitely needed !!!
SetControlDelay -1			;May improve reliability - prevents a click and hold
;WinGet,  mgr_process,  ProcessName, ahk_exe hznHorizonmgr.exe
WinGet,  h_process,  ProcessName, A
;h:= % h_process
;m:= % mgr_process
;a_process:= "hznhorizon.exe"
;m_process:= "hznhorizonmgr.exe"
If WinExist(ahk_exe hznhorizon.exe){
	
	;MsgBox 1
	Control, Uncheck,,Always, A
	Sleep 100
	ControlClick,,ahk_exe Hznhorizon.exe
	Sleep 100
	WinActivate, ahk_exe Hznhorizon.exe
} else if WinExist(ahk_exe hznhorizonmgr.exe){
	WinActivate
	MsgBox 2
} else {
	Run, hznhorizonmgr.exe, C:\Program Files\FMGlobal\Horizon\
	MsgBox 3
}
return
;If WinExist("ahk_exe hznhorizon.exe"){
;WinActivate
;}	
/*
	If (m != m_process){
		Control, Uncheck,,Always, A
		Run C:\Program Files\FMGlobal\Horizon\hznhorizonmgr.exe
		MsgBox run mgr_process
	}else if (h != a_process){
		;Control, Uncheck,,Always, A
		ControlClick,, ahk_exe hznhorizonmgr.exe
		MsgBox activate mgr_process
	}else {
		;Control, Uncheck,,Always, A
		WinActivate, "ahk_exe hznhorizon.exe"
		ControlClick,,ahk_exe hznhorizon.exe
		MsgBox activate Horizon
	}
	Control, Uncheck,,Always, ahk_class AutoHotkeyGUI
	;MsgBox total fail
	return
*/
; ============================== SC4 =============================================
SC4:
Run, Scriptlet_Library_v4.ahk, C:\AHK-Studio\AHK-Projects\
Control, Uncheck,,Always, A
return

; ============================== Recs =============================================
Recs:
Recs = C:\Users\bacona\OneDrive - FM Global\1. Sites\0.01 Resources\Templates\Rec*.xlsx

Loop Files, %Recs%, R  ; Recurse into subfolders.
{
	;MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
	;MsgBox, %A_LoopFileFullPath%
	Run, %A_LoopFileFullPath%
	FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
}
Control, Uncheck,,Always, A
return

; ============================== ITM =============================================
ITM:
ITM = C:\Users\bacona\OneDrive - FM Global\1. Sites\0.01 Resources\Templates\*ITM*.xlsx

Loop Files, %ITM%, R  ; Recurse into subfolders.
{
	;MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
	;MsgBox, %A_LoopFileFullPath%
	Run, %A_LoopFileFullPath%
	FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
}
Control, Uncheck,,Always, A
return

; ============================== ICS =============================================
ICS:
ICS = C:\Users\bacona\OneDrive - FM Global\Training\ICS\ICS Quick Reference\ICS - Template *new*.vsdx

Loop Files, %ITM%, R  ; Recurse into subfolders.
{
	;MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
	;MsgBox, %A_LoopFileFullPath%
	Run, %A_LoopFileFullPath%
	FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
}
Control, Uncheck,,Always, A
return

; ============================== LE Calculator ===================================
LECalc:
;WinMove, OS or DS,, 0, 0
;Clipboard:= % search1
le_calc = LE Calcs
LEout = %o_d_path%%le_guide_dir%
le_calc = %rss_templts%%templts%\*%le_calc%*.xlsx

Loop Files, %le_calc%, R  ; Recurse into subfolders.
{
	;MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
	;MsgBox, %A_LoopFileFullPath%
	Run, %A_LoopFileFullPath%
	FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
}
Control, Uncheck,,Always, A
return

; ============================== B&M LE Guide ======================================
LEGuide:
WinMove, OS or DS,, 0, 0
;Clipboard:= % search1
le_guide_name = Loss Expectancy Guide
LEout = %o_d_path%%le_guide_dir%
le_guide = %LEout%\*%le_guide_name%*.xlsx

Loop Files, %le_guide%, R  ; Recurse into subfolders.
{
	;MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
	;MsgBox, %A_LoopFileFullPath%
	Run, %A_LoopFileFullPath%
	FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
}
Control, Uncheck,,Always, A
return

;while (OS or DS !=1)
;Gui, Submit,Nohide
;Clipboard:= % search

;---------------------Default Button--------------------
; ================= Operating Standards (default button) ==========================
OS:

MsgBox % input
;i:= StrSplit(number, "-")
;MsgBox % i
;if i[1] < 10
;number = %number%
;StringReplace, input, input, -, , All
;if i[2] < 10
;number = %number%
;StringReplace, input, input, -, , All  

OS:= "C:\Users\bacona\FM Global\Operating Standards - Documents\opstds\*" %input% "*fm.pdf"
Loop Files, %OS%, F  ; Recurse into subfolders.
{
	if(!input){
		Run, AcroRD32.exe C:\Users\bacona\FM Global\Operating Standards - Documents\contents.pdf
		Control, Uncheck,,Always, A
		return
	} else {
		Run, AcroRD32.exe %OS%
		Control, Uncheck,,Always, A
		return
	}
	;Run, AcroRD32.exe %A_LoopFileFullPath%
	;FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
}
Control, Uncheck,,Always, A
return
if(!input){
	Run, AcroRD32.exe C:\Users\bacona\FM Global\Operating Standards - Documents\contents.pdf
	Control, Uncheck,,Always, A
	return
} else {
	Run, AcroRD32.exe %o_d_path%%os_dir%%input%%outputos%%ftype_pdf%
	Control, Uncheck,,Always, A
	return
}
return

;------------------Data Sheets------------------
DS:
i:= StrSplit(input, "-")
if i[1] < 10
	input = 0%input%
StringReplace, input, input, -, , All
if i[2] < 10
	input = 0%input%
StringReplace, input, input, -, , All

if(!input){
	Run, fmdata.pdf, C:\Users\bacona\FM Global\Operating Standards - Documents\
	Control, Uncheck,,Always, A
	return
} else {
	Run, %o_d_path%%ds_dir%%outputds%%input%%ftype_pdf%
	Control, Uncheck,,Always, A
	return
}
return

;Gui, OS_DS:Destroy

GuiCancel:
GuiEscape:
ExitApp

*^ESC::ExitApp

Reload

return