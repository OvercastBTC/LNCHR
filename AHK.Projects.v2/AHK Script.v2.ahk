﻿; -=================================================================================
; Section .....: Auto-Execution
; ----------------------------------------------------------------------------------
; -=================================================================================
#Warn All, OutputDebug
#SingleInstance Force
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetTitleMatchMode(2) ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText(true)
DetectHiddenWindows(true)
#Requires Autohotkey v2.0+

; --------------------------------------------------------------------------------
; This is kinda cool, I like this ; Sub-Section .....: Make Window Groups
; --------------------------------------------------------------------------------
; make_window_groups()
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: Tray Icon and Menu Options
; --------------------------------------------------------------------------------
TraySetIcon("shell32.dll","16") ; this changes the icon into a little laptop thing.
Tray := A_TrayMenu
Tray.Delete() ; V1toV2: not 100% replacement of NoStandard, Only if NoStandard is used at the beginning
; ; Tray.Add("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
; ; Tray.Add()
; ; Tray.Add("Run at startup", "runAtStartup")
; ; Menu, Tray, % fileExist(startup_shortcut) ? "check" : "unCheck", Run at startup ; update the tray menu status on startup
; ; Tray.Add("Presentation mode {Win+Shift+P}", "togglePresentationMode")
; ; Tray.Add("Keyboard shortcuts {Ctrl+Shift+Alt+\}", "viewKeyboardShortcuts")
; Tray.Add("Open file location", "openFileLocation")
; Tray.Add()
; Tray.Add("Run GUI_FE", "GUIFE")
; Tray.Add("Run WindowsListMenu.ahk", "WindowListMenu")
; Tray.Add("Run GUI_ListofFiles.ahk", "GUI_ListofFiles")
; Tray.Add("Run WindowProbe.ahk", "WindowProbe")
; Tray.Add("Run Windows_Data_Types_offline.ahk", "Windows_Data_Types_offline")
; Tray.Add()
; ; Tray.Add("View in GitHub", "viewInGitHub")
; Tray.Add("See AutoHotKey documentation", "viewAHKDoc")
; Tray.Add()
Tray.AddStandard()
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
; Section .........: Auto-Execution
; --------------------------------------------------------------------------------
#Include <Common_Abbrevations>
#Include <Common_HumanElement>
#Include <Common_OSTitles>
#Include <Common_Personal>
#Include <Common_Rec_Texts>
#Include WINDOWS.v2.ahk
; --------------------------------------------------------------------------------

; <<<<< ... First Return ... <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Return
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; Comment .....:
:*:;...::; {< 5} {. 3} First Return {. 3} {< 53}`nReturn`n; {< 80}
:*:;---::; {- 80}
:*:;,,,::; {< 80}
:*:;sect::; {- 80} `r; {< 80}`r; {- 80}
; -------------------------------------------------------------------------------- 
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; --------------------------------------------------------------------------------
; Section .....: Save with Hotkey Function
; Function ....: ReloadAllAHKScripts()
; --------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe Code.exe")
~^s::
{
	ReloadAllAhkScripts()
}

ReloadAllAhkScripts()
{
	DetectHiddenWindows(true)
	static oList := WinGetList("ahk_class AutoHotkey",,,)
	aList := Array()
	List := oList.Length
	For v in oList
	{
		aList.Push(v)
	}
	scripts := ""
	Loop aList.Length
		{
			title := WinGetTitle("ahk_id " aList[A_Index])
			;PostMessage(0x111,65414,0,,"ahk_id " aList[A_Index])
			dnrList := [A_ScriptName, "Scriptlet_Library"]
			rmList := InStr(title, "Scriptlet_Library", false)
			
			If (title = A_ScriptName)
				Continue
			If (title = "Scriptlet_Library")
				continue
			PostMessage(0x111,65400,0,,"ahk_id " aList[A_Index])
			; Note: I think the 654*** is for v2 => avoid the 653***'s
			; [x] Reload:		65400
			; [x] Help: 		65411 ; 65401 doesn't really work or do anything that I can tell
			; [x] Spy: 			65402
			; [x] Pause: 		65403
			; [x] Suspend: 		65404
			; [x] Exit: 		65405
			; [x] Variables:	65406
			; [x] Lines Exec:	65407 & 65410
			; [x] HotKeys:		65408
			; [x] Key History:	65409
			; [x] AHK Website:	65412 ; Opens https://www.autohotkey.com/ in default browser; and 65413
			; [x] Save?:		65414
			; Don't use these => ;//static a := { Open: 65300, Help:    65301, Spy: 65302, XXX (nonononono) Reload: 65303 [bad reload like Reload()], Edit: 65304, Suspend: 65305, Pause: 65306, Exit:   65307 }
			; scripts .=  (scripts ? "`r`n" : "") . RegExReplace(title, " - AutoHotkey v[\.0-9]+$")
			scripts .=  (scripts ? "`r`n" : "") . RegExReplace(title, " - AutoHotkey v[\.0-9]+$")
		}
	OutputDebug(scripts)
	OutputDebug(rmList)
	return
}
#HotIf
; --------------------------------------------------------------------------------
; Section .....: Functions
; Function ....: Run scripts selection from the Script Tray Icon
; --------------------------------------------------------------------------------
^+#1::
GUIFE(*){
	Run("GUI_FE.ahk")
}
return
; list
^+#2::
WindowListMenu(*){
	Run("WindowListMenu.ahk")
}	
return
^+#3::
WindowProbe(*){
	Run("WindowProbe.ahk", "C:\Users\bacona\OneDrive - FM Global\3. AHK\")
}
return
^+#4::
GUI_ListofFiles(*){
	Run("GUI_ListofFiles.ahk")
}
return
^+#5::
{
Windows_Data_Types_offline(*){
	Run("Windows_Data_Types_offline.ahk", "C:\Users\bacona\OneDrive - FM Global\3. AHK\AutoHotkey_MSDN_Types-master\src\v1.1_deprecated\")
}
}
return
#o::
Detect_Window_Info(*){
	Run("Detect_Window_Info.ahk")
}
return
^+#6::
Detect_Window_Update(*){
	Edit()
}
return
^+#7::
test_script(*){
	Run("test_script.ahk")
}
return
; --------------------------------------------------------------------------------
;============================== Test Programs ==============================
#Numpad0::
; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
; Parameter #3: Pass 1 instead of 0 to disable all wake events.
{ ; V1toV2: Added bracket
DllCall("PowrProf\SetSuspendState", "Int", 1, "Int", 0, "Int", 0)
return
; --------------------------------------------------------------------------------
; https://www.autohotkey.com/board/topic/53443-found-the-top-level-handle-one-hwnd-to-rule-them-all/
} ; V1toV2: Added Bracket before hotkey or Hotstring
^!#h::
{ ; V1toV2: Added bracket
	ControlHwnd := ""
	ControlSend("{Click}", , "ahk_id " ControlHwnd)
} ; V1toV2: Added Bracket before hotkey or Hotstring
return
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
; ^!#g::
; { ; V1toV2: Added bracket
; MsgBox("Desktop Window: " DllCall("GetDesktopWindow") "`nClassName: "DllCall("GetClassName") "`nWindowA: " DllCall("FindWindowA") "`nClassInfoA: "DllCall("GetClassInfoA") "`nClassLongA: " DllCall("GetClassLongA") "`nClassWord: " DllCall("GetClassWord") "`nNextWindow: " DllCall("GetNextWindow") "`nNextWindow: " DllCall("GetNextWindow") "`nTitleBarInfo: " DllCall("GetTitleBarInfo"))
; ;msgbox % "Desktop Window: " dllCall("GetDesktopWindow")+0 "`nClassName: "dllCall("GetClassName")+0 "`nWindowA: " dllCall("FindWindowA")+0 "`nClassInfoA: "dllCall("GetClassInfoA")+0 "`nClassLongA: " dllCall("GetClassLongA")+0 "`nClassWord: " dllCall("GetClassWord")+0 "`nNextWindow: " dllCall("GetNextWindow")+0 "`nNextWindow: " dllCall("GetNextWindow")+0 "`nTitleBarInfo: " dllCall("GetTitleBarInfo")+0
; ;msgbox % dllCall("GetDesktopWindow")+0
; ;msgbox % dllCall("GetClassName")+0
; ;msgbox % dllCall("FindWindowA")+0
; ;msgbox % dllCall("GetClassInfoA")+0
; ;msgbox % dllCall("GetClassLongA")+0
; ;msgbox % dllCall("GetClassWord")+0
; ;msgbox % dllCall("GetNextWindow")+0
; ;msgbox % dllCall("GetNextWindow")+0
; ;msgbox % dllCall("GetTitleBarInfo")+0
; } ; V1toV2: Added Bracket before hotkey or Hotstring
; return
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
;                Ctrl+Shift+Alt+r Reload AutoHotKey Script (to load changes)
; --------------------------------------------------------------------------------
^+!r::ReloadAllAhkScripts()
; - Chrome River----------------------------------
#HotIf WinActive("Chrome River - Google Chrome")
	; SendMode("Event")
	:*:bt::Business Travel -{Space} 
	:*:air::Business Travel - Airfare -
	:*:seat::Business Travel - Airline Fee - Seat Upgrade -
	:*:inter::Business Travel - Airline Fee - Internet - 
	:*:bags::Business Travel - Airline Fee - Baggage Fee - 
	:*:ho::Business Travel - Hotel -{Space}
	:*:me::Business Travel - Meal - 
	:*:car::Business Travel - Car Service -
	:*:rent::Business Travel - Rental Car -
	:*:mob::Business Mobile
	:*:bint::Business Internet
	:*:comp::Company Vehicle
	:*:off::Office Supplies - risk file organization folders for site visit efficiency 
return 
#HotIf

;:*:planeml::Edward Evatt, FM Global, edward.evatt@fmglobal.com{Enter}Terry Keatts, FM Global, terry.keatts@fmglobal.com ;Plan Review email additions
;:*:plansig::Terry Keatts, P.E.{Enter}Sr. Engineering Specialist{Enter}FM Global â€“ Seattle Office{Enter}ENGSanFranciscoPlanReviewSM@fmglobal.com{Enter}(925) 287-4336

; --------------------------------------------------------------------------------
;     DSP Email Subject Endings for Quick Entry ;#[AHK Script - DSPs]
; --------------------------------------------------------------------------------

:*:cinerf::Ciner Enterprises Inc. "Sisecam Wyoming LLC" [Green River WY] / 001131.69-01
:*:ciners::Ciner-Sisecam (001131.69-01)

:*:solvaygf::Solvay S.A. "Solvay Soda Ash Joint Venture / Soda Ash Expansion / Chemicals" / 000968.17-01
:*:solvaygs::Solvay (000968.17-01)

:*:heclagcf::Hecla Mining Company "Greens Creek Mine" [Admiralty Island AK] / 092010.60-03
:*:heclagcs::Hecla-Greens Creek (092010.60-03)
:*:heclags::Hecla-Greens Creek

:*:heclalff::Hecla Mining Company "Lucky Friday Mine" [Mullan ID] / 079127.30-07
:*:heclalfs::Hecla-Lucky Friday (079127.30-07)
:*:heclals::Hecla-Lucky Friday

:*:montanarssf::Montana Resources, LLC "Continental Mine and Operations" / 075346.68-03
:*:genesisf::Genesis Alkali Holdings LLC "Genesis Alkali Holdings LLC - Green River" / 075548.55-01
:*:pogof::Northern Star Resources Limited "Pogo Mine" / 000084.00-01
:*:materionf::Materion Corporation "Materion Natural Resources Inc." [Delta UT] / 075107.62-01
:*:reddogf::Teck Resources Limited " Red Dog Mine & Port Sites" [Kivalina, AK] / 092024.83-04 & 092024.83-05

:*:caesf::Cobham Group Limited "Microelectronic Solutions" [San Jose CA] / Index No. 000258.83-01
:*:cobhamf::Cobham Group Limited "Microelectronic Solutions" [San Jose CA] / Index No. 000258.83-01

:*:trinityf::Trinity Health Corporation "Saint Agnes Medical Center, Saint Agnes Medical Providers. Inc. & Trinity Information Services - Fresno" [Fresno CA] / 076602.13-04
:*:trinitys::Trinity (076602.13-04)

:*:mtcemf::Eagle Materials Inc. "Mountain Cement Company-EM" [Laramie WY] / Index No. 075554.08-02
:*:mtcems::Mountain Cement Co. (075554.08-02)

:*:Varexf::Varex Imaging Corporation [SLC UT] / 075053.23-07

:*:Cytivaf::Danaher Corporation "Cytiva" [Logan UT] / Index No. 001338.79-02
:*:Cytivas::Danaher Corp. - Cytiva (001338.79-02)

;---------------------------------------------------------------------------
;      Shift+WIN+m Button to Click on Window Anywhere to Drag
;---------------------------------------------------------------------------
; This script is from the Automator

!LButton::
{ ; V1toV2: Added bracket
CoordMode("Mouse", "Screen")
MouseGetPos(&x, &y)
WinMove(x, y, , , "A")
return
;---------------------------------------------------------------------------
;                       Time Stamp Code
;---------------------------------------------------------------------------
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:ts::
; format month and year
{ ; V1toV2: Added bracket
date := FormatTime(A_Now, "MM/yyyy")
Send("(AJB - " date ")")
return

;--------------------------------------------------------------------------
;                    Quick Launch Websites (and Log In)
;--------------------------------------------------------------------------
} ; V1toV2: Added Bracket before hotkey or Hotstring

; ^+g::Run("`"https://www.google.com/?safe=active&ssui=on`"") ; use ctrl+Shift+g
; return

;^+e::Run("`"https://engnet/Engnet/engnet/engnet.asp`"") ; use ctrl+Shift+e
;return

/* Commented out due to conflict with "reply to all keyboard shortcut in Outlook"
	^+r::Run "http://riskview/RiskView_1_0/Home/MainPage" ; use ctrl+Shift+r
	return
*/
/* Commented out JOL
	^+j::
{ ; V1toV2: Added bracket
	Run "https://www.jurisdictiononline.com/" ; use ctrl+Shift+j
	Sleep 3000
	Send, {Tab}PASSWORD ;Note my username is saved in Edge and already populated. If yours is not, you will need to alter this script. Replace text after tab with your own credential
	Sleep 50
	Send, {Tab}
	Sleep 50
	Send, {Enter}
	return
*/

;^+!f::
;Run "https://portal.fcm.travel/Account/Login" ; use ctrl+Shift+f
;Sleep 3000
;Send, {Tab}{Tab}{Tab}{Tab}FIRST.LAST@fmglobal.com{Tab}PASSWORD{Tab} ;Replace text after tab with your own credential
;Sleep 50
;Send, {Enter}
;return

/*
} ; V1toV2: Added Bracket before hotkey or Hotstring
	^+a::
{ ; V1toV2: Added bracket
	Run "https://www.approvalguide.com//" ; use ctrl+Shift+a
	Sleep 3500
	Send, {Tab}{Tab}{Enter}
	Sleep 1500
	Send,FIRST.LAST@fmglobal.com{Tab}{Enter} ;Replace email with your own credential
	Sleep 2000
	Send, PASSWORD{Enter} ;Replace text with your own credentials
	return
*/

;--------------------------------------------------------------------------
; Function:  Shift+Ctrl+C to Google Search for Highlighted Text
;--------------------------------------------------------------------------

^+c::
{
	Send("^c")
	Sleep(50)
	Run("http://www.google.com/search?q=" A_Clipboard)
	Return
}

;--------------------------------------------------------------------------
;          Permanently Set Caplocks Off, NumLock On and Scroll Lock Off
;--------------------------------------------------------------------------

SetNumLockState("AlwaysOn")
SetCapsLockState("AlwaysOff")
SetScrollLockState("AlwaysOff")
return

;--------------------------------------------------------------------------
;                Win+Delete to Empty Recycle Bin
;--------------------------------------------------------------------------

#Del::FileRecycleEmpty() ; win + del

;---------------------------------------------------------------------------
;                      Helpful Stuff
;---------------------------------------------------------------------------
GetMouse:
CoordMode("Mouse", "Screen")
MouseGetPos(&mx, &my)
CoordMode("Mouse", "Window")
Return

PutMouse:
CoordMode("Mouse", "Screen")
MouseMove(mx, my, 0)
CoordMode("Mouse", "Window")
Return

:*:attext::	; Timestamp
{ ; V1toV2: Added bracket
Date := FormatTime(A_Now, "MM/dd/yyyy")	; format month, day and year
IB := InputBox("Nameplate Head Thickness (after 0.)", "Air Tank", "w300 h125"), npht := IB.Value
IB := InputBox("Nameplate Shell Thickness (after 0.)", "Air Tank", "w300 h125"), npst := IB.Value
IB := InputBox("Actual Head Thickness (after 0.)", "Air Tank", "w300 h125"), aht := IB.Value
IB := InputBox("Actual Shell Thickness (after 0.)", "Air Tank", "w300 h125"), ast := IB.Value
Send("Nameplate HD: 0." npht " / SH: 0." npst " // " Date " TJK HD: 0." aht " / SH: 0." ast)
Return
} ; Added bracket before function

Join(sep, params*) {
	for index,param in params
		str .= param . sep
	return SubStr(str, 1, -StrLen(sep))
}
;MsgBox % Join("`n", "one", "two", "three")

;---------------------------------------------------------------------------
;                          General Abbreviations
;---------------------------------------------------------------------------

; ^!0::
; { ; V1toV2: Added bracket
; static var := "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÑÒÓÔŒÕÖØÙÚÛÜßàáâãäåæçèéêëìíîïñòóôœõöøùúûüÿ¿¡«»§¶†‡•-–—™©®¢€¥£₤¤αβγδεζηθικλμνξοπρσςτυφχψωΓΔΘΛΞΠΣΦΨΩ∫∑∏√−±∞≈∝≡≠≤≥×·÷∂′″∇‰°∴ø∈∩∪⊂⊃⊆⊇¬∧∨∃∀⇒⇔→↔↑ℵ∉°₀₁₂₃₄₅₆₇₈₉⁰¹²³⁴⁵⁶⁷⁸⁹"

; static w:=20, cnt := 14, arr := strsplit(var)
; static myGui := Gui()
; myGui.new()
; myGui.Opt("-caption")
; myGui.MarginX := "0", myGui.MarginY := "0"
; myGui.SetFont("s10")
; Loop arr.count()
; {
; 	x := mod((a_index - 1),cnt) * w, y := floor((a_index - 1)/ cnt) * w
; 	ogctextz := myGui.add("text", "x" . x . " y" . y . " w" . w . " h" . w . " center vz" . a_index, arr[a_index])
; 	ogctextz.OnEvent("Click", myGui.insert.Bind("Normal"))
; }
; myGui.show()
; return
; } ; Added bracket before function

; ; insert(A_GuiEvent, GuiCtrlObj, Info, *)
; ; { ; V1toV2: Added bracket
; ; 	myGui := 
; ; 	oSaved := myGui.submit()
; ; 	Send(arr[SubStr(A_GuiControl, 2)])
; ; }
; ; return

:?*X:nm::Send("{Blind}≠") ; used for testing

:?*:not equal::
:?*:notequ::
:?*:not=::
:?*:!=::
{ ; V1toV2: Added bracket
A_Clipboard := "≠"
Send("^v")
return
} ; V1toV2: Added bracket in the end
#HotIf WinActive("ahk_exe Hznhorizon.exe")
	:?*:>=::
{ ; V1toV2: Added bracket
	A_Clipboard := "≥"
	Send("^v")
	Return
} ; V1toV2: Added bracket in the end
#HotIf
:?*:^i::^{i}

:?*X:microm::Send(chr(181) "m")
:?*X:3/4::Send(chr(190))
:?*X:1/2::Send(chr(189))
:?*X:1/4::Send(chr(188))
:?*X:+-::Send(chr(177))
:?*X:regtmf::Send(chr(174)) ;®
:?*:trademarkf::™
:?*:circlec::©
:?*:copywritef::©
:?*:>=::
:?*:greater than or equal to::
{ ; V1toV2: Added bracket
A_Clipboard := "≥"
Send("^v")
return
} ; V1toV2: Added Bracket before hotkey or Hotstring
:?*X:degf::Send(chr(176) "F")
:?*X:degc::Send(chr(176) "C")
:?*X:prisec::Send("1" chr(176) "/2 " chr(176) A_Space "Inj testing")
:*:hrsgf::heat recovery steam generator (HRSG)
:*:mocf::management of change (MOC)
::agf::Approval Guide
:*:FMDSf::FM Global Property Loss Prevention Data Sheet
::sgsv::seismic gas shutoff valve
::erpf::emergency response plan
::ferpf::flood emergency response plan
::wst::water supply tool
::efc::eFC
::wdt::water delivery time
::wpivf::wall post-indicator valve
::pivf::post-indicator valve
::ulf::Underwriters Laboratories
::uupf::uncartoned unexpanded plastic
::uepf::uncartoned expanded plastic
::cupf::cartoned unexpanded plastic
::cepf::cartoned expanded plastic
::sopf::standard operating procedure
::eopf::emergency operating procedure
::ooo::out of office
::OSY::OS&Y
::sq.ft.::sq. ft.
::oemf::original equipment manufacturer
::ndef::nondestructive examination (NDE)
::ndtf::nondestructive testing (NDT)
::ndetf::nondestructive examination/testing (NDE/NDT)
::mehpf::minimum end head pressure
::mawpf::maximum allowable working pressure
::mipf::metal insulating panels
:*:lwco::LWCO
::LWCOf::low water cutout (LWCO)
::lfpil::low flash point ignitable liquid
::hfpil::high flash point ignitable liquid
:*:lmgtfy::https://letmegooglethat.com/?q=
::ITMf::inspection, testing, and maintenance (ITM)
::itm::ITM
::iras::in-rack automatic sprinklers
::il::ignitable liquid
::hrl::higher RelativeLikelihood
::htf::heat transfer fluid
::gp::generally protected
:*:FMRTPS::FM Global Red Tag Permit System
:*:FMHWPS::FM Global Hot Work Permit System
::FMDSl::FM Global Data Sheet
:*:FMA::FM Approved
::FRPf::fiber-reinforced plastic panels
::epof::emergency power off
::blrbf::black liquor recovery boiler
::efile::eFile
::icsf::industrial control system
::otf::operational technology network
::itf::information technology network
::mfaf::multi-factor authentication
:?*:exerie::experie


;---------------------------------------------------------------------------
;      Alt+Left Mouse Button to Click on Window Anywhere to Drag
;---------------------------------------------------------------------------
; This script modified from the original: http://www.autohotkey.com/docs/scripts/EasyWindowDrag.htm

Alt & ~LButton::
{ ; V1toV2: Added bracket
	global EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin, EWD_OriginalPosX, EWD_OriginalPosY
	EWD_OriginalPosX := "", EWD_OriginalPosY := ""
	CoordMode("Mouse")  ; Switch to screen/absolute coordinates.
	MouseGetPos(&EWD_MouseStartX, &EWD_MouseStartY, &EWD_MouseWin,,2)
	WinGetClientPos(&EWD_OriginalPosX, &EWD_OriginalPosY,&EWD_OriginalH, &EWD_OriginalW, "ahk_id " EWD_MouseWin)
	;WinGetPos(&EWD_OriginalPosX, &EWD_OriginalPosY, , , "ahk_id " EWD_MouseWin)
	EWD_WinState := WinGetMinMax("ahk_id " EWD_MouseWin)
	if (EWD_WinState = 0)  ; Only if the window isn't maximized 
		SetTimer(EWD_WatchMouse,10) ; Track the mouse as the user drags it.
	return
} ; V1toV2: Added Bracket before label


EWD_WatchMouse()
{ ; V1toV2: Added bracket
EWD_LButtonState := GetKeyState("LButton", "P") ? "D" : "U"
if (EWD_LButtonState = "U")  ; Button has been released, so drag is complete.
{
	SetTimer(EWD_WatchMouse,0)
	return
}
EWD_EscapeState := GetKeyState("Escape", "P") ? "D" : "U"
if (EWD_EscapeState = "D")  ; Escape has been pressed, so drag is cancelled.
{
	SetTimer(EWD_WatchMouse,0)
	WinMove(EWD_OriginalPosX, EWD_OriginalPosY, , , "ahk_id " EWD_MouseWin)
	return
}
;Otherwise, reposition the window to match the change in mouse coordinates caused by the user having dragged the mouse:
CoordMode("Mouse")
MouseGetPos(&EWD_MouseX, &EWD_MouseY)
WinGetPos(&EWD_WinX, &EWD_WinY, , , "ahk_id " EWD_MouseWin)
;SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove(EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY, , , "ahk_id " EWD_MouseWin)
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return
} ; V1toV2: Added bracket in the end
