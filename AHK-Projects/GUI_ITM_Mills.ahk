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

#Include GUI_Options.ahk
+!i::
;EnvGet, vUserProfile, USERPROFILE
;EnvGet, vHomeDrive, HOMEDRIVE
EnvGet, vHomePath, HOMEPATH
m_dir=\FM Global\Operating Standards - Documents\
os_dir=opstds\
ds_dir=ds\
le_guide_dir=general\
o_d_path = C:%vHomePath%%m_dir%
outputos = fm
outputds = FMDS
;templates section
rss_templts = C:\Users\bacona\OneDrive - FM Global\1. Sites\0.01 Resources
templts = \Templates
font = Calibri
ftype_pdf = .pdf
ftype_xl = .xlsx
splitPath, A_ScriptFullPath, , , script_ext, script_name
global script_full_name := script_name "." script_ext
file:= this.script_name

IniRead, v_iniRead, %file%.ini
FileRead, v_iniRead, %file%.ini
v_iniFormat := StrReplace(v_iniRead, "]", "]`n")
ar_INI := []
ar_INI := StrSplit(StrReplace(v_iniFormat, "=" , "`n") , "`n")



Gui, Destroy
;- a basic Listview-Test with 2-TABs and 2 columns / Create 2 text-files  

;- MODIFIED=20140605
;----------------------------------------------
;- ADD     = Button-ADD
;- MODIFY  = Rightclick ROW
;- DELETE  = DEL-key delete ROW
;- SEARCH  = use EDIT for search
;- PRINT   = print content from Listview
;- RUN     = doubleclick row to run url or file
;----------------------------------------------



;- Listview   >>>   ADD_NEW  / MODIFY / DELETE / SEARCH
MainWindowTitle=ListView_Test1
transform,T,chr,09
delim = `,
gosub,test1    ;-- create 2 text-files for 2 ListViews  ( test )
Gui,2:default
Gui,2: Font,CDefault,Fixedsys
Gui,2: Margin, 10, 10
Tabnumber:=1
gui,2:add, Tab2, x10 y10 w540 h250 gtabchange vTabnumber AltSubmit, Links|Regex
gui,2:tab, Links
gui,2:add, listview,x10 y40 w520 h400 grid cWhite backgroundteal hwndLV1 vLV1 gListViewEvents +altsubmit -multi, A|B
gosub,fill1
gosub,width1
Gui,2:add,button, x10  y450 gPrintLV1,Print
;Gui,2:Add, Edit,  x100 y450 w250 gFind vSrch1,
Gui,2:add,button, x400 y450 gAddNew1,ADD_NEW
gui,2:tab, Regex
gui,2:add, listview,x10 y40 w520 h400 grid cWhite backgroundteal hwndLV2 vLV2 gListViewEvents +altsubmit -multi, A|B
gosub,fill2
gosub,width1
Gui,2:add,button, x10 y450 gPrintLV1,Print
Gui,2:Add, Edit,  x100 y450 w250 gFind vSrch2,
Gui,2:add,button, x400 y450 gAddNew1,ADD_NEW
gui,2: show,x10 y1 w600 h500,%MainWindowTitle%
gosub,tabchange
RETURN
2Guiclose:
exitapp
width1:
T1=300
T2=200
LV_ModifyCol(1,T1)
LV_ModifyCol(2,T2)
;LV_ModifyCol(2,"Integer")
return
;-------------------------------------------------------------------------------------
tabchange:
GuiControlGet, Tabnumber
GuiControl,2:Focus,srch%tabnumber%
Return
;-------------------------------------------------------------------------------------
;---------------- SEARCH -------------------
Findtab:
Gui,2: Submit, Nohide
Gui,2:listview, LV%Tabnumber%
Fx=%A_scriptdir%\test%tabnumber%.txt
src:= % srch%Tabnumber%
if (SRC="")
{
   goto,Fill%Tabnumber%
   return
   }
LV_Delete()
  loop,read,%fx%
  {
  LR=%A_loopReadLine%
  if SRC<>
     {
     if LR contains %src%
       {
       stringsplit,C,A_LoopReadLine,%delim%
       LV_Add("",C1,C2)
       }
     }
  else
   continue
   }
LV_Modify(LV_GetCount(), "Vis")
if (SRC="")
  goto,Fill%Tabnumber%
return
;------------------- LISTVIEW --------------
ListViewEvents:
Gui,2:default
Gui,2:listview, LV%Tabnumber%
    if(A_GuiEvent == "Normal")
         {
         LV_GetText(C1, A_EventInfo, 1)
         LV_GetText(C2, A_EventInfo, 2)
         }
    if(A_GuiEvent == "DoubleClick")
        {
        LV_GetText(C2, A_EventInfo, 2)
        stringmid,url1,c2,1,7
        stringmid,pth1,c2,2,2
        if ((url1="http://") or (pth1=":\"))
          run,%c2%
        return
        }
    if(A_GuiEvent == "RightClick")
        {
        LV_GetText(C1, A_EventInfo, 1)
        LV_GetText(C2, A_EventInfo, 2)
        gosub,Modify1
        return
        }
    if A_GuiEvent=K
       {
       GetKeyState,state,DEL        ;- << DELETE
       if state=D
         {
         RowNumber:=LV_GetNext()
         LV_Delete(RowNumber)
         gosub,Modify2
         return
        }
      return
      }
RETURN
;--------------------------------------------------------------
;----------------   MODIFY  ----------------
Modify1:
Gui,3: +AlwaysonTop
Gui,3: Font, s10, Verdana
gui, 3:listview, LV%Tabnumber%
    Gui,3:add, edit, w300 h30 vC1, %C1%
    Gui,3:add, edit, w300 h30 vC2, %C2%
    Gui,3: Add,Button,   x12 gACCEPT1 default, Accept
    Gui,3: Add,Button,   x+4 gCANCEL1, Cancel
Gui,3:show,center, LV_Modify
return
accept1:
Gui,2:default
Gui,3:submit,nohide
gui 3:listview, LV%Tabnumber%
RowNumber := LV_GetNext()
c1:= % c1
c2:= % c2
lv_modify(rownumber, "col1" , C1 )
lv_modify(rownumber, "col2" , C2 )
gosub,modify2
Gui,3:destroy
return
cancel1:
3Guiclose:
Gui,3:destroy
return
;-----------------------------------------------------------------
;----------------   ADD NEW  ----------------
ADDNEW1:
Gui,4: +AlwaysonTop
Gui,4: Font, s10, Verdana
Gui,4:listview, LV%Tabnumber%
    Gui,4:add, edit, w300 h30 vC1,
    Gui,4:add, edit, w300 h30 vC2,
    Gui,4: Add,Button,   x12 gACCEPT4 default, Accept
    Gui,4: Add,Button,   x+4 gCANCEL4, Cancel
Gui,4:show,center,Add_NEW
return
accept4:
Gui,2:default
Gui,4:submit,nohide
Gui,4:listview, LV%Tabnumber%
Fx=%A_scriptdir%\test%tabnumber%.txt
Fileappend,%c1%%delim%%c2%`r`n,%fx%
gosub,fill%tabnumber%
Gui,4:destroy
return
cancel4:
4Guiclose:
Gui,4:destroy
return
;-----------------------------------------------------------------
;------------------ FILL ----------------------------
Fill1:
gui,2:listview, listview%Tabnumber%
LV_Delete()
loop,read,%F1%
  {
  LR=%A_loopReadLine%
  if LR=
     continue
          C1 =
          C2 =
         stringsplit,C,LR,%delim%,
   LV_Add("", c1,c2)
  }
LV_ModifyCol(1, "Sort CaseLocale")   ; or "Sort CaseLocale"
LV_Modify(LV_GetCount(), "Vis")      ;scrolls down
return
Fill2:
gui, 2:listview, listview%Tabnumber%
LV_Delete()
loop,read,%F2%
  {
  LR=%A_loopReadLine%
  if LR=
     continue
          C1 =
          C2 =
         stringsplit,C,LR,%delim%,
   LV_Add("", c1,c2)
  }
LV_ModifyCol(1, "Sort CaseLocale")   ; or "Sort CaseLocale"
LV_Modify(LV_GetCount(), "Vis")      ;scrolls down
return
;---------------------------------------------------
;------------------- Modify Text -------------------------
Modify2:
Fx=%A_scriptdir%\test%tabnumber%.txt
ifexist,%fx%
   filedelete,%fx%
ControlGet,AA,List,,SysListView32%tabnumber%,%MainWindowTitle%        ;<< the correct name of listview
if aa<>
 {
 stringreplace,AA,AA,%t%,%delim%,all                                   ;<< replaces TAB with Delimiter
 stringreplace,AA,AA,`n,`r`n,all
 ;msgbox, 262208, ,%aa%
 fileappend,%AA%,%fx%
 aa=
 return
 }
return
;------------------------------------------------------------------
;------------------- PRINT-Listview -------------------------
PrintLv1:
FileTest=%a_scriptdir%\PrintListview55.txt
ifexist,%filetest%
   filedelete,%filetest%
ControlGet,AA,List,,SysListView32%tabnumber%,%MainWindowTitle%        ;<< the correct name of listview
if aa<>
 {
 stringreplace,AA,AA,%t%,%delim%,all                                   ;<< replaces TAB with Delimiter
 stringreplace,AA,AA,`n,`r`n,all
 ;msgbox, 262208, ,%aa%
 fileappend,%AA%,%filetest%
 aa=
 run,%filetest%
 return
 }
return
;------------------------------------------------------------------
;--- create a testfile ---------------
test1:
;delim = `,
F1=%A_scriptdir%\test1.txt
ifnotexist,%f1%
{
  e1=
  (Ltrim Join`r`n
  1-Youtube Monty Python%delim%http://www.youtube.com/MontyPython
  1-Li Xianglan wikipedia%delim%http://en.wikipedia.org/wiki/Li_Xianglan
  )
Fileappend,%e1%`r`n,%f1%
}
F2=%A_scriptdir%\test2.txt
ifnotexist,%f2%
{
  e2=
  (Ltrim Join`r`n
  2-REGEX ahk%delim%http://www.autohotkey.com/docs/misc/RegEx-QuickRef.htm
  2-REGEX regular%delim%http://www.regular-expressions.info/
  2-Regex 101%delim%https://regex101.com/
  )
Fileappend,%e2%`r`n,%f2%
}
e1=
e2=
return
;--- end create a testfile -----------
;================== END script ==========================================================

^#5::
Gui, 1:New
Gui,+AlwaysOnTop +Caption +Border +Resize +SysMenu +Theme
Gui,Color,Gray
Gui,Font,s10 Q4, %font% UI Black
;Gui,Add,Progress,x0 y0 w240 h2 BackgroundYellow 
;Gui,Add,Progress,x0 y123 w240 h2 BackgroundYellow 
;Gui,Add,Progress,x238 y0 w2 h125 BackgroundYellow 

Gui,Add,Text, cAqua section xm w30 h20 Border Center gTag, OC
;Gui,Font, s11 Underline Q4, %font% UI Black
;Gui,Add,Text,cGreen x60 y2 w120 h20 Border Center gMove_window,Move Window
Gui,Add,Text,cBlue x+100 w120 h20 Border Center gMove_window,Move Window

;Gui,Font,s18 Q4, %font% UI Black
;Gui,Add,Text,cRed x+125 w20 h20 Border Center gMin_window, -
;Gui,Add,Text,cRed x+0 w20 h20 Border Center gGuiClose, X

;Gui,Font,s11 %font% Q4
;Gui,Add,Checkbox,cLime x10 y+7 Checked vAlways gAOT,AlwaysOnTop
Gui,Add,Checkbox,cLime x+100 Center Checked vAlways gAOT,AlwaysOnTop
;Gui,Add,Button, section xm w200 gSet_Next_On_Top -Theme,Set Next Win On Top
;Gui,Add,Button,x+5 w200 vgSet_Last_On_Top -Theme,Set Last Win On Top

;Gui, Add, Text, cBlue section xm, =====================> Design <=====================
Gui, Add, Tab,xm,Design|Motor|Spares|ITM|Ring Gear
Gui Tab, Design
Gui, Add, Text, xm,Size (d x l):
;Gui, Add, Edit, TabStop vInput1 x+5 W20,
Gui, Add, Edit, TabStop ys W20,
Gui, Add, Text, section ys,ft. x 
Gui, Add, Edit, TabStop ys W20,
Gui, Add, Text, section ys,ft.
Gui, Add, Text, xs,Motor: 900 HP
Gui, Add, Text, xm,Mill RPM: [unk] 
Gui, Add, Text, xm,TPH (Max): 120 TPH
Gui, Add, Text, xm,TPH (Used/Avg): 100 TPH
Gui, Add, Text, xm,Ring Gear (Cast or Forged): Cast
Gui, Add, Text, xm,Ring Gear Reversable?: [unk]
Gui, Add, Text, xm,Rotation Reversal: N/A
Gui Tab, 2
Gui, Add, Text, section xm,Motor Design: 
Gui, Add, Text, section xm,HP: 900 hp
Gui, Add, Text, section xm,RPM: 897 rpm
Gui, Add, Text, section xm,FLA: 114 Amps
Gui, Add, Text, section xm,Voltage: 4.16 kV
Gui, Add, Text, section xm,Phase(s): 3 phases
Gui, Add, Text, section xm,Freq: 60 Hz
Gui, Add, Text, section xm,Relays (ANSI #s): P61
Gui Tab, 3
Gui, Add, Text, section xm,Spares:
Gui, Add, Text, section xm,- Pinion gears  
Gui, Add, Text, section xm,- Motor
Gui, Add, Text, section xm,- ring gear (forged or cast?)
Gui, Add, Text, section xm,- bearings
Gui Tab, 4
Gui, Add, Text, section xm,ITM:
Gui, Add, Text, section xm,Temp Monitoring:
Gui, Add, Text, section xm,- Temp gun: every shift
Gui, Add, Text, section xm,Vib - continuous
Gui, Add, Text, section xm,NDE: Annual UT (Metzo); tracking/trending cracks (in-progress)
Gui, Add, Text, section xm,C&SD: Annual
Gui Tab, 5
Gui, Add, Text, section xm,Ring Gear: 
Gui, Add, Text, section xm,- Visuals:
Gui, Add, Text, section xm,- Walkdown: Shift
Gui, Add, Text, section xm,- Strobe inspection: Shift
Gui, Add, Text, section xm,- Temp gun: Shift
Gui, Add, Text, section xm,- Lube Oil visual - every shift
Gui, Add, Text, section xm,- IR scan: No. Discussed w/ site and showed examples
Gui, Add, Text, section xm,- Lining (PIN Profile)
Gui, Add, Text, section xm,- Quarterly, replacements every 24 mo
Gui, Add, Text, section xm,- Slurry racing inspections
Gui, Add, Text, section xm,- Charge monitoring - via kW
Gui, Add, Text, section xm,
Gui, Add, Text, section xm,NDE:
Gui, Add, Text, section xm,Type: UT
Gui, Add, Text, section xm,Objects: trunnion (feed and disch.), ring gear, pinion, segment bolts
Gui, Add, Text, section xm,Indications: Yes
Gui, Add, Text, section xm,Last performed: 4/2023
Gui, Add, Text, section xm,
Gui, Add, Text, section xm,Continuous Monitoring:
Gui, Add, Text, section xm,- Vibration: motor
Gui, Add, Text, section xm,- Temperature: bearings, L/O, ring gear L/O
Gui, Add, Text, section xm,- Pressure, Flow: bearing L/O
Gui, Add, Text, section xm,
Gui, Add, Text, section xm,Additional Eqpt Notes:
Gui, Add, Text, section xm,Final Drive Pinion - inst
Gui, Add, Text, section xm,
Gui, Add, Text, section xm,Extra History:
Gui, Add, Text, section xm,- Updated RV to $7.8 M per EVG
;Gui, Add, Text, x+30, |
;Gui, Add, Edit, TabStop section R1 vInput xm+170 W50,
;Gui, Add, Button, TabStop Default gOS xm+150, &OS
;Gui, Add, Button, TabStop gDS x+30, &DS
;Gui, Add, Text,section xm+110,OS (default) or DS? (e.g., 5-19)
;Gui, Add, Text, section xm+130, Press "Enter" to continue...
;Gui, Add, Text,xm+25,Keyword Search (optional): (e.g.`, Operations and Maintenance)
;Gui, Add, Edit, TabStop vSearch xm+125,
;Gui, Add, Text, cBlue section xm, ===================================================
;Gui, Add, Button, section gLEGuide xm, &B&&M LE Guide
;Gui, Add, Button, gHorizon x+20, &Horizon
;Gui, Add, Button, gITM x+10, &ITM Recorder
;Gui, Add, Text, section xm, Optional: Search for:
;Gui, Add, Edit, vSearch1 x+15, Switchgear - Panels
;Gui, Add, Text, cBlue section xm, ===================================================
;Gui, Add, Text, cLime section xm+135,Resources && Templates
;Gui, Add, Button, section gLECalc xm, &LE Calculator (blank)
;Gui, Add, Button, gICS x+10, &ICS Diagram Template
;Gui, Add, Button, gRecs section xm, &Recommendation Template
;Gui, Add, Button, gSC4 section xm, &Scriptlett v4 (Rec Template)
Gui, Add, Button, section gCancel xm+350, Cancel
Gui, Submit,Nohide
Gui, Show, AutoSize


GuiControlGet, input,, Input, Edit
GuiControlGet, search,, Search, Edit
GuiControlGet, search1,, Search1, Edit
return
/*
;Design:
;Size: 11 ft. dia. x 13 ft.
text =
(
Motor: 900 HP
Mill RPM: [unk] 
TPH (Max): 120 TPH
TPH (Used/Avg): 100 TPH
Ring Gear (Cast or Forged): Cast
Ring Gear Reversable?: [unk]
Rotation Reversal: N/A

Motor Design: 
HP: 900 hp
RPM: 897 rpm
FLA: 114 Amps
Voltage: 4.16 kV
Phase(s): 3 phases
Freq: 60 Hz
Relays (ANSI #s): P61

Spares:
- Pinion gears  
- Motor
- ring gear (forged or cast?)
- bearings

ITM:
Temp Monitoring:
- Temp gun: every shift
Vib - continuous
NDE: Annual UT (Metzo); tracking/trending cracks (in-progress)
C&SD: Annual

Ring Gear: 
- Visuals:
- Walkdown: Shift
- Strobe inspection: Shift
- Temp gun: Shift
- Lube Oil visual - every shift
- IR scan: No. Discussed w/ site and showed examples
- Lining (PIN Profile)
- Quarterly, replacements every 24 mo
- Slurry racing inspections
- Charge monitoring - via kW

NDE:
Type: UT
Objects: trunnion (feed and disch.), ring gear, pinion, segment bolts
Indications: Yes
Last performed: 4/2023

Continuous Monitoring:
- Vibration: motor
- Temperature: bearings, L/O, ring gear L/O
- Pressure, Flow: bearing L/O

Additional Eqpt Notes:
Final Drive Pinion - inst

Extra History:
- Updated RV to $7.8 M per EVG
)
*/
/*
Horizon:
SetMouseDelay, 100			;!!! definitely needed !!!
SetControlDelay -1			;May improve reliability - prevents a click and hold
WinGet,  mgr_process,  ProcessName, ahk_exe hznhorizonmgr.exe
WinGet,  h_process,  ProcessName, ahk_exe hznhorizon.exe

If(mgr_process = true and h_process = true)
	ControlClick,,ahk_exe hznhorizon.exe
return
If(mgr_process = true and h_process = false)
	ControlClick,, ahk_exe hznhorizonmgr.exe
return
If(mgr_process = false)
	Run C:\Program Files\FMGlobal\Horizon\hznhorizonmgr.exe
Control, Uncheck,,Always
return



SC4:
Run, Scriptlet_Library_v4.ahk, C:\AHK-Studio\AHK-Projects\
Control, Uncheck,,Always
return

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
Control, Uncheck,,Always
return

ITM:
ITM = C:\Users\bacona\OneDrive - FM Global\1. Sites\1. Mining - DSP\1.0 ITM & Other Rss\ITM*.xlsx

Loop Files, %ITM%, R  ; Recurse into subfolders.
{
	;MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
	;MsgBox, %A_LoopFileFullPath%
	Run, %A_LoopFileFullPath%
	FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
}
Control, Uncheck,,Always
return

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
Control, Uncheck,,Always
return

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
Control, Uncheck,,Always
return

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
Control, Uncheck,,Always
return

;while (OS or DS !=1)
;Gui, Submit,Nohide
;Clipboard:= % search
;---------------------Default Button--------------------
;------------------Operating Standards------------------

OS:
OSout = %o_d_path%%os_dir%%input%%outputos%%ftype_pdf%
if(input = ""){
	Run, AcroRD32.exe C:\Users\bacona\FM Global\Operating Standards - Documents\contents.pdf
} else {
	Run, AcroRD32.exe %OSout%
}
i:= StrSplit(input, "-")
if i[1] < 10
	input = %input%
StringReplace, input, input, -, , All
if i[2] < 10
	input = %input%
StringReplace, input, input, -, , All  
WinWait, 1
;Send, ^f
;Send, ^v{Enter}
Control, Uncheck,,Always
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
DSout = %o_d_path%%ds_dir%%outputds%%input%%ftype_pdf%
if(input = ""){
	Run, C:\Users\bacona\FM Global\Operating Standards - Documents\fmdata.pdf
	} else {
	Run, %DSout%
}	
WinWait, 1
;Send, ^f
;Clipboard = %search%
;Send, ^v{Enter}
Control, Uncheck,,Always
return

;Gui, OS_DS:Destroy

GuiCancel:
GuiEscape:
ExitApp

*^ESC::ExitApp

Reload

return
*/