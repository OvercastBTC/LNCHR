;============================== Start Auto-Execution Section ==============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On

;============================== ini Section ==============================
^!#9\:

SplitPath, A_ScriptName, , , , OutNameNoExt
IniFile = %OutNameNoExt%.ini
IniRead, Gui1Pos,        %IniFile%, Settings, Gui1Pos,        %A_Space%
IniRead, Gui1W,          %IniFile%, Settings, Gui1W,          %A_Space%
IniRead, Gui1H,          %IniFile%, Settings, Gui1H,          %A_Space%
IniRead, BolResizeTreeH, %IniFile%, Settings, BolResizeTreeH, 1
IniRead, BolRollUpDown,  %IniFile%, Settings, BolRollUpDown,  0
IniRead, BolAlwaysOnTop, %IniFile%, Settings, BolAlwaysOnTop, 1
IniRead, IntGuiStyle,    %IniFile%, Settings, IntGuiStyle,    1
IniRead, StrFontName,    %IniFile%, Settings, StrFontName,    Times New Roman
IniRead, IntFontSize,    %IniFile%, Settings, IntFontSize,    11
;/*
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
            Gui,2:Add, Edit,  x100 y450 w250 gFind vSrch1,
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
Find:
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

/*
Gui, PM_SM:New,, Post/SendMessage
Gui,+AlwaysOnTop +Caption +Border +Resize +SysMenu +Theme
Gui,Color,Gray
Gui,Font,s11 Q4, Segoe UI Black

Gui, Add, Text, xm,Enter Msg #: (WM_ or 0x)
Gui, Add, Edit, Section vMsg xm,					;Message box for Msg
Gui, Add, Text,section xm,wParam (optional):
Gui, Add, Edit, vWParam xm,
Gui, Add, Text,section R1 xm,lParam (optional):
Gui, Add, Edit, vLParam xm,
Gui, Add, Text,Section xm,Control ID (optional):
Gui, Add, Edit, vControlID xm,
Gui, Add, Text, Section xm,Post (default) or Send?
Gui, Add, Button, Section Default vPost gPost xm, &Post
Gui, Add, Button, vSend gSend x+10, &Send
;Gui, Add, Edit, vInput xm+20 -5 W30, 
Gui, Add, Text, section xm, Press "Enter" to continue...
Gui, Add, Button, section gControlList xm, ControlList & HWND
Gui, Add, Button, section gTestM xm, Test Message
;Gui, Add, Edit, vSearch1 x+15, Switchgear - Panels
Gui, Add, Button, section gCancel x+25, Cancel
Gui, Submit,Nohide
Gui, Show, AutoSize
return
*/
GuiControlGet, Msg,,,Edit
GuiControlGet, wParam,,,Edit
GuiControlGet, lParam,,,Edit
GuiControlGet, ControlID,,,Edit
GuiControlGet, ControlList,,,Edit
GuiControlGet, Send,,,Edit
GuiControlGet, Post,,,Edit

MsgBox Msg: %Msg%`nWParam: %wParam%`nlParam: %lParam%`nControlID: %ControlID%`nErrorLevel: %ErrorLevel%

^+!c:
ControlList:
WinGet, cList, ControlList, ahk_class ThunderRT6MDIForm 
WinGet, cListH, ControlListHwnd, A
MsgBox %cList% `n %cListH%
return

cmd1 = 0x0111 ; WM_COMMAND
cmd2 = 0x0201 ; WM_LBUTTONDOWN
cmd3 =
wParam = 
lParam =
param = 0x0000
code1 = 1804
code2 = 1799
code3 =
ahkid = ahk_id
ahkexe = ahk_exe hznhorizon.exe
ctlid1 = 0x00210dc
ctlid2 = 0xFFFF

;Title: Trinity Health Corporation - 07660213 04 - 0000823061-67   2444933  Fresno, CA US  - [Main]
;Class: ahk_classThunderRT6MDIForm
;Control: msvb_lib_toolbar1
;Active Control: TX111

Post:
WinActivate, ahk_class ThunderRT6MDIForm
PostMessage, %Msg% , %wParam%, %lParam%, %Control%, ahk_class ThunderRT6MDIForm ;, %WinText%, %ExcludeTitle%, %ExcludeText%
MsgBox Msg: %Msg%`nWParam: %wParam%`nlParam: %lParam%`nControlID: %ControlID%`nErrorLevel: %ErrorLevel%
return

Send:
WinActivate, ahk_class ThunderRT6MDIForm
SendMessage, %Msg% , %wParam%, %lParam%, %Control%, ahk_class ThunderRT6MDIForm ;, %WinText%, %ExcludeTitle%, %ExcludeText%, %Timeout%
MsgBox Msg: %Msg%`nWParam: %wParam%`nlParam: %lParam%`nControlID: %ControlID%`nErrorLevel: %ErrorLevel%
return

TestM:
;WinActivate, ahk_class ThunderRT6MDIForm
PostMessage, 0x0111 , 0, , 101, ahk_class ThunderRT6MDIForm ;, %WinText%, %ExcludeTitle%, %ExcludeText%
MsgBox Msg: %Msg%`nWParam: %wParam%`nlParam: %lParam%`nControlID: %ControlID%`nErrorLevel: %ErrorLevel%
return 

;ControlClick, x15 y12, ahk_id 0x617da
;PostMessage, WM_PARENTNOTIFY,WM_LBUTTONDOWN,,100,ahk_id 0x617da
;PostMessage, 0x0111,0x0202,,100,ahk_id 0x617da

;SendMessage, 0x0403,0x00000064,,,ahk_id 0x000a1300
;SendMessage, 0x0403,0x00000065,,,ahk_id 0x000a1300
;SendMessage, 0x0403,0x00000066,,,ahk_id 0x000a1300
;SendMessage, 0x0281, 0x00000001, 0xc000000f,, ahk_id 0x00061306
;WinGet, a_process, Process, ahk_exe hznhorizon.exe
;SendMessage, 0xC, 0, "Switchgear and Circuit Breakers", 101, ahk_exe hznhorizon.exe
;SendMessage, WM_USER + 7246 (0x0000204e), ,0x0019f720,,,ahk_id 0x00061306
;SendMessage, WM_USER + 7441 (0x00002111), 0x07050000,,,ahk_id 0x00061306
WinGetPos, PosX, PosY, SizeW, SizeH, ahk_id %Gui1UniqueID%
IniWrite, x%PosX% y%PosY% , %IniFile%, Settings, Gui1Pos
IniWrite, %SizeW% , %IniFile%, Settings, Gui1W
IniWrite, %SizeH% , %IniFile%, Settings, Gui1H
IniWrite, %IntGuiStyle%, %IniFile%, Settings, IntGuiStyle
IniWrite, %BolResizeTreeH%, %IniFile%, Settings, BolResizeTreeH
IniWrite, %BolRollUpDown%,  %IniFile%, Settings, BolRollUpDown
IniWrite, %BolAlwaysOnTop%, %IniFile%, Settings, BolAlwaysOnTop
IniWrite, %StrFontName%,    %IniFile%, Settings, StrFontName
IniWrite, %IntFontSize%,    %IniFile%, Settings, IntFontSize
FileAppend, `n`n, %IniFile%
return

;SplashTextOn, 100, 25, Test, I should be working
;WM_USER + 7174 (0x00002006)
;PostMessage, 0x0111,100,,,ahk_id 0x000a1300
;PostMessage, 0x0111,100,,,ahk_id 0x0018145C
;PostMessage, 0x0111,101,,,ahk_id 0x000a1300
;PostMessage, 0x0111,101,,,ahk_id 0x0018145C
;PostMessage, WM_USER + 3 (0x00000403),0x00000064,,,ahk_id 0x000a1300
;PostMessage, WM_USER + 3 (0x00000403),0x00000065,,,ahk_id 0x000a1300
;PostMessage, WM_USER + 3 (0x00000403),0x00000066,,,ahk_id 0x000a1300

; WM_PARENTNOTIFY := 0x0210
; WM_LBUTTONDOWN := 0x0201
; WM_NCLBUTTONDOWN::0x00A1
; WM_NCLBUTTONUP::0x00A2
; WM_COMMAND Code: 1796 ControlID: 0 Control HWND: 0x000210dc
;PostMessage, 0x111, 65405,,, % "ahk_id " hWnd ;WM_COMMAND := 0x111 ;ID_FILE_EXIT := 65405


PostMessage, %cmd1%,1799,,,%ahkid% %ctlid1%
MsgBox %ErrorLevel%`n%Code1%`n%ahkid% %ctlid1%
;PostMessage, %cmd1%,%code2%,%lParam%,%ctlid1%,ahk_id %ctlid1%
;MsgBox %ErrorLevel%`n%Code2%
;PostMessage, 0x0111,0x00001804,,,ahk_id 0xFFFF
;PostMessage, 0x0111,0x00001799,,,ahk_id 0xFFFF

;SendMessage, 0x0111,101,,,ahk_id 0x0018145C


;IniWrite, %value%, %root%lib\%Section%.ini, %Section%, %Key%
;Section:="WindowsMessages"
;StrSplit(str_in,":= ",,2)
/*Unique ID: ahk_id 0xa0820
Title: Trinity Health Corporation - 07660213 04 - 0000823061-67   2444933  Fresno, CA US  - [Main]
Class: ahk_classThunderRT6MDIForm
Control: msvb_lib_toolbar1
Active Control: ThunderRT6CommandButton3
*/
/*
WM_NULL::0x0000
WM_CREATE::0x0001
WM_DESTROY::0x0002
WM_MOVE::0x0003
WM_SIZE::0x0005
WM_ACTIVATE::0x0006
WM_SETFOCUS::0x0007
WM_KILLFOCUS::0x0008
WM_ENABLE::0x000A
WM_SETREDRAW::0x000B
WM_SETTEXT::0x000C
WM_GETTEXT::0x000D
WM_GETTEXTLENGTH::0x000E
WM_PAINT::0x000F
WM_CLOSE::0x0010
WM_QUERYENDSESSION::0x0011
WM_QUIT::0x0012
WM_QUERYOPEN::0x0013
WM_ERASEBKGND::0x0014
WM_SYSCOLORCHANGE::0x0015
WM_ENDSESSION::0x0016
WM_SYSTEMERROR::0x0017
WM_SHOWWINDOW::0x0018
WM_CTLCOLOR::0x0019
WM_WININICHANGE::0x001A
WM_SETTINGCHANGE::0x001A
WM_DEVMODECHANGE::0x001B
WM_ACTIVATEAPP::0x001C
WM_FONTCHANGE::0x001D
WM_TIMECHANGE::0x001E
WM_CANCELMODE::0x001F
WM_SETCURSOR::0x0020
WM_MOUSEACTIVATE::0x0021
WM_CHILDACTIVATE::0x0022
WM_QUEUESYNC::0x0023
WM_GETMINMAXINFO::0x0024
WM_PAINTICON::0x0026
WM_ICONERASEBKGND::0x0027
WM_NEXTDLGCTL::0x0028
WM_SPOOLERSTATUS::0x002A
WM_DRAWITEM::0x002B
WM_MEASUREITEM::0x002C
WM_DELETEITEM::0x002D
WM_VKEYTOITEM::0x002E
WM_CHARTOITEM::0x002F

WM_SETFONT::0x0030
WM_GETFONT::0x0031
WM_SETHOTKEY::0x0032
WM_GETHOTKEY::0x0033
WM_QUERYDRAGICON::0x0037
WM_COMPAREITEM::0x0039
WM_COMPACTING::0x0041
WM_WINDOWPOSCHANGING::0x0046
WM_WINDOWPOSCHANGED::0x0047
WM_POWER::0x0048
WM_COPYDATA::0x004A
WM_CANCELJOURNAL::0x004B
WM_NOTIFY::0x004E
WM_INPUTLANGCHANGEREQUEST::0x0050
WM_INPUTLANGCHANGE::0x0051
WM_TCARD::0x0052
WM_HELP::0x0053
WM_USERCHANGED::0x0054
WM_NOTIFYFORMAT::0x0055
WM_CONTEXTMENU::0x007B
WM_STYLECHANGING::0x007C
WM_STYLECHANGED::0x007D
WM_DISPLAYCHANGE::0x007E
WM_GETICON::0x007F
WM_SETICON::0x0080

WM_NCCREATE::0x0081
WM_NCDESTROY::0x0082
WM_NCCALCSIZE::0x0083
WM_NCHITTEST::0x0084
WM_NCPAINT::0x0085
WM_NCACTIVATE::0x0086
WM_GETDLGCODE::0x0087
WM_NCMOUSEMOVE::0x00A0
WM_NCLBUTTONDOWN::0x00A1
WM_NCLBUTTONUP::0x00A2
WM_NCLBUTTONDBLCLK::0x00A3
WM_NCRBUTTONDOWN::0x00A4
WM_NCRBUTTONUP::0x00A5
WM_NCRBUTTONDBLCLK::0x00A6
WM_NCMBUTTONDOWN::0x00A7
WM_NCMBUTTONUP::0x00A8
WM_NCMBUTTONDBLCLK::0x00A9

WM_KEYFIRST::0x0100
WM_KEYDOWN::0x0100
WM_KEYUP::0x0101
WM_CHAR::0x0102
WM_DEADCHAR::0x0103
WM_SYSKEYDOWN::0x0104
WM_SYSKEYUP::0x0105
WM_SYSCHAR::0x0106
WM_SYSDEADCHAR::0x0107
WM_KEYLAST::0x0108

WM_IME_STARTCOMPOSITION::0x010D
WM_IME_ENDCOMPOSITION::0x010E
WM_IME_COMPOSITION::0x010F
WM_IME_KEYLAST::0x010F

WM_INITDIALOG::0x0110
WM_COMMAND::0x0111
WM_SYSCOMMAND::0x0112
WM_TIMER::0x0113
WM_HSCROLL::0x0114
WM_VSCROLL::0x0115
WM_INITMENU::0x0116
WM_INITMENUPOPUP::0x0117
WM_MENUSELECT::0x011F
WM_MENUCHAR::0x0120
WM_ENTERIDLE::0x0121

WM_CTLCOLORMSGBOX::0x0132
WM_CTLCOLOREDIT::0x0133
WM_CTLCOLORLISTBOX::0x0134
WM_CTLCOLORBTN::0x0135
WM_CTLCOLORDLG::0x0136
WM_CTLCOLORSCROLLBAR::0x0137
WM_CTLCOLORSTATIC::0x0138

WM_MOUSEFIRST::0x0200
WM_MOUSEMOVE::0x0200
WM_LBUTTONDOWN::0x0201
WM_LBUTTONUP::0x0202
WM_LBUTTONDBLCLK::0x0203
WM_RBUTTONDOWN::0x0204
WM_RBUTTONUP::0x0205
WM_RBUTTONDBLCLK::0x0206
WM_MBUTTONDOWN::0x0207
WM_MBUTTONUP::0x0208
WM_MBUTTONDBLCLK::0x0209
WM_MOUSEWHEEL::0x020A
WM_MOUSEHWHEEL::0x020E

WM_PARENTNOTIFY::0x0210
WM_ENTERMENULOOP::0x0211
WM_EXITMENULOOP::0x0212
WM_NEXTMENU::0x0213
WM_SIZING::0x0214
WM_CAPTURECHANGED::0x0215
WM_MOVING::0x0216
WM_POWERBROADCAST::0x0218
WM_DEVICECHANGE::0x0219

WM_MDICREATE::0x0220
WM_MDIDESTROY::0x0221
WM_MDIACTIVATE::0x0222
WM_MDIRESTORE::0x0223
WM_MDINEXT::0x0224
WM_MDIMAXIMIZE::0x0225
WM_MDITILE::0x0226
WM_MDICASCADE::0x0227
WM_MDIICONARRANGE::0x0228
WM_MDIGETACTIVE::0x0229
WM_MDISETMENU::0x0230
WM_ENTERSIZEMOVE::0x0231
WM_EXITSIZEMOVE::0x0232
WM_DROPFILES::0x0233
WM_MDIREFRESHMENU::0x0234

WM_IME_SETCONTEXT::0x0281
WM_IME_NOTIFY::0x0282
WM_IME_CONTROL::0x0283
WM_IME_COMPOSITIONFULL::0x0284
WM_IME_SELECT::0x0285
WM_IME_CHAR::0x0286
WM_IME_KEYDOWN::0x0290
WM_IME_KEYUP::0x0291

WM_MOUSEHOVER::0x02A1
WM_NCMOUSELEAVE::0x02A2
WM_MOUSELEAVE::0x02A3

WM_CUT::0x0300
WM_COPY::0x0301
WM_PASTE::0x0302
WM_CLEAR::0x0303
WM_UNDO::0x0304

WM_RENDERFORMAT::0x0305
WM_RENDERALLFORMATS::0x0306
WM_DESTROYCLIPBOARD::0x0307
WM_DRAWCLIPBOARD::0x0308
WM_PAINTCLIPBOARD::0x0309
WM_VSCROLLCLIPBOARD::0x030A
WM_SIZECLIPBOARD::0x030B
WM_ASKCBFORMATNAME::0x030C
WM_CHANGECBCHAIN::0x030D
WM_HSCROLLCLIPBOARD::0x030E
WM_QUERYNEWPALETTE::0x030F
WM_PALETTEISCHANGING::0x0310
WM_PALETTECHANGED::0x0311

WM_HOTKEY::0x0312
WM_PRINT::0x0317
WM_PRINTCLIENT::0x0318

WM_HANDHELDFIRST::0x0358
WM_HANDHELDLAST::0x035F
WM_PENWINFIRST::0x0380
WM_PENWINLAST::0x038F
WM_COALESCE_FIRST::0x0390
WM_COALESCE_LAST::0x039F
WM_DDE_FIRST::0x03E0
WM_DDE_INITIATE::0x03E0
WM_DDE_TERMINATE::0x03E1
WM_DDE_ADVISE::0x03E2
WM_DDE_UNADVISE::0x03E3
WM_DDE_ACK::0x03E4
WM_DDE_DATA::0x03E5
WM_DDE_REQUEST::0x03E6
WM_DDE_POKE::0x03E7
WM_DDE_EXECUTE::0x03E8
WM_DDE_LAST::0x03E8

WM_USER::0x0400
WM_APP::0x8000
*/
;============================== End Script ==============================