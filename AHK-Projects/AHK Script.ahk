;================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
#Warn All, OutputDebug
;SetWinDelay 0 ; ..... (AJB - 06/2023) - comment out for testing
;SetControlDelay 0 ; . (AJB - 06/2023) - comment out for testing
;SetBatchLines, 0 ; .. (AJB - 06/2023)  - comment out for testing
;SetWinDelay, -1 ; ... (AJB - 06/2023) re-enabled 06.15.23 
;SetControlDelay, -1 ; (AJB - 06/2023) re-enabled 06.15.23 
;SetBatchLines, -1 ; . (AJB - 06/2023) re-enabled 06.15.23
#NoEnv  ; Recommended for performance and compatibility
#Persistent ; Keeps script permanently running
#SingleInstance,Force
;#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#Requires AutoHotkey 1.1+
;ListHotkeys
; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: Make Window Groups
; ----------------------------------------------------------------------------------------------------------------------
make_window_groups()
; ----------------------------------------------------------------------------------------------------------------------
; ----------------------------------------------------------------------------------------------------------------------
; .................: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: Tray Icon and Menu Options
; ----------------------------------------------------------------------------------------------------------------------
Menu, Tray, Icon, shell32.dll, 16 ; this changes the icon into a little laptop thing.
Menu, Tray, NoStandard
;addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
;addTrayMenuOption()
;addTrayMenuOption("Run at startup", "runAtStartup")
;Menu, Tray, % fileExist(startup_shortcut) ? "check" : "unCheck", Run at startup ; update the tray menu status on startup
;addTrayMenuOption("Presentation mode {Win+Shift+P}", "togglePresentationMode")
;addTrayMenuOption("Keyboard shortcuts {Ctrl+Shift+Alt+\}", "viewKeyboardShortcuts")
addTrayMenuOption("Open file location", "openFileLocation")
addTrayMenuOption()
addTrayMenuOption("Run GUI_FE", "GUIFE")
addTrayMenuOption("Run WindowsListMenu.ahk", "WindowListMenu")
addTrayMenuOption("Run GUI_ListofFiles.ahk", "GUI_ListofFiles")
addTrayMenuOption("Run WindowProbe.ahk", "WindowProbe")
addTrayMenuOption("Run Windows_Data_Types_offline.ahk", "Windows_Data_Types_offline")
addTrayMenuOption()
;addTrayMenuOption("View in GitHub", "viewInGitHub")
addTrayMenuOption("See AutoHotKey documentation", "viewAHKDoc")
addTrayMenuOption()
Menu, Tray, Standard
; -------------------------------------------------------------------------------------------------------
; .............: End Sub-Section
; -------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; -------------------------------------------------------------------------------------------------------
; Section .........: Auto-Execution
; Sub-Section .....: Includes
; -------------------------------------------------------------------------------------------------------
#Include Common_Abbrevations.ahk
#Include Common_HumanElement.ahk
#Include Common_OSTitles.ahk
#Include Common_Personal.ahk
;#Include Common_Rec_Texts.ahk
run Common_Rec_Texts.ahk
;#Include autoahkHotstrings.ahk
#Include windows-ahk-master\WINDOWS.ahk
;return
; ----------------------------------------------------------------------------------------------------------------------
; .................: End Sub-Section
; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


; ................: End Sub-Section
; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------



; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ... First Return ... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Return
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; ToolTip Mouse Menu (requires XP/2k/NT) -- by Rajat
; https://www.autohotkey.com
; This script displays a popup menu in response to briefly holding down
; the middle mouse button.  Select a menu item by left-clicking it.
; Cancel the menu by left-clicking outside of it.  A recent improvement
; is that the contents of the menu can change depending on which type of
; window is active (Notepad and Word are used as examples here).

; You can set any title here for the menu:
MenuTitle = -=-=-=-=-=-=-=-

; This is how long the mouse button must be held to cause the menu to appear:
UMDelay = 20

SetFormat, float, 0.0
SetBatchLines, 10ms 
SetTitleMatchMode, 2
#SingleInstance


;___________________________________________
;_____Menu Definitions______________________

; Create / Edit Menu Items here.
; You can't use spaces in keys/values/section names.

; Don't worry about the order, the menu will be sorted.

MenuItems = Notepad/Calculator/Section 3/Section 4/Section 5


;___________________________________________
;______Dynamic menuitems here_______________

; Syntax:
;     Dyn# = MenuItem|Window title

Dyn1 = MS Word|- Microsoft Word
Dyn2 = Notepad II|- Notepad

;___________________________________________

Exit


;___________________________________________
;_____Menu Sections_________________________

; Create / Edit Menu Sections here.

Notepad:
Run, Notepad.exe
Return

Calculator:
Run, Calc
Return

Section3:
MsgBox, You selected 3
Return

Section4:
MsgBox, You selected 4
Return

Section5:
MsgBox, You selected 5
Return

MSWord:
MsgBox, this is a dynamic entry (word)
Return

NotepadII:
MsgBox, this is a dynamic entry (notepad)
Return


;___________________________________________
;_____Hotkey Section________________________

~+]::
HowLong = 0
Loop
{
	HowLong ++
	Sleep, 10
	GetKeyState, state, ], P
	IfEqual, state, U, Break
}
IfLess, HowLong, %UMDelay%, Return


;prepares dynamic menu
DynMenu =
Loop
{
	IfEqual, Dyn%A_Index%,, Break

	StringGetPos, ppos, dyn%A_Index%, |
	StringLeft, item, dyn%A_Index%, %ppos%
	ppos += 2
	StringMid, win, dyn%A_Index%, %ppos%, 1000

	IfWinActive, %win%,
		DynMenu = %DynMenu%/%item%
}


;Joins sorted main menu and dynamic menu
Sort, MenuItems, D/
TempMenu = %MenuItems%%DynMenu%


;clears earlier entries
Loop
{
	IfEqual, MenuItem%A_Index%,, Break
	MenuItem%A_Index% =
}

;creates new entries
Loop, Parse, TempMenu, /
{
	MenuItem%A_Index% = %A_LoopField%
}

;creates the menu
Menu = %MenuTitle%
Loop
{
	IfEqual, MenuItem%A_Index%,, Break
	numItems ++
	StringTrimLeft, MenuText, MenuItem%A_Index%, 0
	Menu = %Menu%`n%MenuText%
}

MouseGetPos, mX, mY
Hotkey, ~LButton, MenuClick
Hotkey, ~LButton, On
ToolTip, %Menu%, %mX%, %mY%
WinActivate, %MenuTitle%
Return


MenuClick:
Hotkey, ~LButton, Off
IfWinNotActive, %MenuTitle%
{
	ToolTip
	Return
}

MouseGetPos, mX, mY
ToolTip
mY -= 3		;space after which first line starts
mY /= 13	;space taken by each line
IfLess, mY, 1, Return
IfGreater, mY, %numItems%, Return
StringTrimLeft, TargetSection, MenuItem%mY%, 0
StringReplace, TargetSection, TargetSection, %A_Space%,, A
Gosub, %TargetSection%
Return


; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; Autohotkey.exe
; autohotkeyu32.exe
; autohotkeyu64.exe
; ----------------------------------------------------------------------------------------------------------------------
; .............: Begin Section
; Section .....: Save with Hotkey Function
; Function ....: Base_SaveReload()
; ----------------------------------------------------------------------------------------------------------------------
;SetTitleMatchMode RegEx
;#If WinActive("i)autohotkey*[A-Za-z]{0,1}[0-9]{0,2}\.exe") ; ahk_exe AutoHotKey.exe or AutoHotkeyU32.exe or AutoHotkeyU64.exe
;#If A_Process = Autohotkey ; WinActive("ahk_exe autohotkey.exe") or WinActive("ahk_exe AutoHotkeyU32.exe") or WinActive("ahk_exe AutoHotkeyU64.exe") ; ahk_exe AutoHotKey.exe or AutoHotkeyU32.exe or AutoHotkeyU64.exe
#If A_Process == Code.exe
~^s::
ToolTip Saved
;Sleep 1000
ToolTip
ReloadAllAhkScripts()
reload
return
/*Base_SaveReload()
ToolTip Saved to Server
Sleep 1000
Reload
;ToolTip
return
*/
#If ;WinActive
; ----------------------------------------------------------------------------------------------------------------------
; .............: End Section
; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; .............: Begin Section
; Section .....: Functions
; Function ....: Run scripts selection from the Script Tray Icon
; ----------------------------------------------------------------------------------------------------------------------
^+#1::
GUIFE(){
	Run, GUI_FE.ahk
}
return
; list
^+#2::
WindowListMenu(){
	Run WindowListMenu.ahk
}	
return
^+#3::
WindowProbe(){
	Run, WindowProbe.ahk, C:\Users\bacona\OneDrive - FM Global\3. AHK\
}
return
^+#4::
GUI_ListofFiles(){
	Run GUI_ListofFiles.ahk
}
return
^+#5::
Windows_Data_Types_offline(){
	Run,Windows_Data_Types_offline.ahk , C:\Users\bacona\OneDrive - FM Global\3. AHK\AutoHotkey_MSDN_Types-master\src\v1.1_deprecated\
}
return
#o::
Detect_Window_Info(){
	Run, Detect_Window_Info.ahk
}
return
^+#6::
Detect_Window_Update(){
	edit Detect_Window_Update.ahk
}
return
^+#7::
test_script(){
	Run, test_script.ahk
}
return
; ----------------------------------------------------------------------------------------------------------------------
; .............: End Section
; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

;-------------------------------------------------------------------------------
;============================== Test Programs ==============================
#Numpad0::
; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
; Parameter #3: Pass 1 instead of 0 to disable all wake events.
DllCall("PowrProf\SetSuspendState", "Int", 1, "Int", 0, "Int", 0)
return
; ----------------------------------------------------------------------------------------------------------------------
; https://www.autohotkey.com/board/topic/53443-found-the-top-level-handle-one-hwnd-to-rule-them-all/
^!#h::
ControlHwnd:= ""
ControlSend, , {Click}, ahk_id %ControlHwnd%
return
; ----------------------------------------------------------------------------------------------------------------------
; ----------------------------------------------------------------------------------------------------------------------
^!#g::
setformat, integerFast, H
msgbox % "Desktop Window: " dllCall("GetDesktopWindow") "`nClassName: "dllCall("GetClassName") "`nWindowA: " dllCall("FindWindowA") "`nClassInfoA: "dllCall("GetClassInfoA") "`nClassLongA: " dllCall("GetClassLongA") "`nClassWord: " dllCall("GetClassWord") "`nNextWindow: " dllCall("GetNextWindow") "`nNextWindow: " dllCall("GetNextWindow") "`nTitleBarInfo: " dllCall("GetTitleBarInfo")
;msgbox % "Desktop Window: " dllCall("GetDesktopWindow")+0 "`nClassName: "dllCall("GetClassName")+0 "`nWindowA: " dllCall("FindWindowA")+0 "`nClassInfoA: "dllCall("GetClassInfoA")+0 "`nClassLongA: " dllCall("GetClassLongA")+0 "`nClassWord: " dllCall("GetClassWord")+0 "`nNextWindow: " dllCall("GetNextWindow")+0 "`nNextWindow: " dllCall("GetNextWindow")+0 "`nTitleBarInfo: " dllCall("GetTitleBarInfo")+0
;msgbox % dllCall("GetDesktopWindow")+0
;msgbox % dllCall("GetClassName")+0
;msgbox % dllCall("FindWindowA")+0
;msgbox % dllCall("GetClassInfoA")+0
;msgbox % dllCall("GetClassLongA")+0
;msgbox % dllCall("GetClassWord")+0
;msgbox % dllCall("GetNextWindow")+0
;msgbox % dllCall("GetNextWindow")+0
;msgbox % dllCall("GetTitleBarInfo")+0
return
; ----------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------
;                Ctrl+Shift+Alt+r Reload AutoHotKey Script (to load changes)
;---------------------------------------------------------------------------
^+!r::

Base_ReloadAllAhkScripts()
;Reload
return
; Chrome River----------------------------------
#IfWinActive Chrome River - Google Chrome
;while #IfWinActive = true
	SendMode Event
	:*:bt::Business Travel -{Space} 
	:*:air::Business Travel - Airfare -
	:*:seat::Business Travel - Airline Fee - Seat Upgrade -
	:*:inter::Business Travel - Airline Fee - Internet - 
	:*:bags::Business Travel - Airline Fee - Baggage Fee - 
	:*:ho::Business Travel - Hotel -{Space}
;:*:bmeal::Business Travel - Meal - 
	:*:me::Business Travel - Meal - 
	:*:car::Business Travel - Car Service -
	:*:rent::Business Travel - Rental Car -
	:*:mob::Business Mobile
	:*:bint::Business Internet
	:*:comp::Company Vehicle
	:*:off::Office Supplies - risk file organization folders for site visit efficiency 
return	
; Outlook data:
; Search bar:
; ControlType:= 50004
; Name:= Search
; ClassName:= NetUISearchBoxTextbox
; AutomatioinId:= SearchTextBox
; HelpText:= Search (Ctrl+E / Alt+Q)
; AccessKey:= Alt, Y
#IfWinActive	

;:*:planeml::Edward Evatt, FM Global, edward.evatt@fmglobal.com{Enter}Terry Keatts, FM Global, terry.keatts@fmglobal.com ;Plan Review email additions
;:*:plansig::Terry Keatts, P.E.{Enter}Sr. Engineering Specialist{Enter}FM Global â€“ Seattle Office{Enter}ENGSanFranciscoPlanReviewSM@fmglobal.com{Enter}(925) 287-4336

;--------------------------------------------------------------------------
;     DSP Email Subject Endings for Quick Entry ;#[AHK Script - DSPs]
;--------------------------------------------------------------------------

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

:*:Varex::Varex Imaging Corporation [SLC UT] / 075053.23-07

:*:Cytivaf::Danaher Corporation "Cytiva" [Logan UT] / Index No. 001338.79-02
:*:Cytivas::Danaher Corp. - Cytiva (001338.79-02)

;---------------------------------------------------------------------------
;      Shift+WIN+m Button to Click on Window Anywhere to Drag
;---------------------------------------------------------------------------
; This script is from the Automator

!LButton::
CoordMode, Mouse, Screen
MouseGetPos, x, y
WinMove A,, %x%,%y%
return
;---------------------------------------------------------------------------
;                       Time Stamp Code
;---------------------------------------------------------------------------
:*:ts::
; format month and year
FormatTime,date, %A_Now%, MM/yyyy
Send % "(AJB - " date ")" 
return

;--------------------------------------------------------------------------
;                    Quick Launch Websites (and Log In)
;--------------------------------------------------------------------------

^+g::Run "https://www.google.com/?safe=active&ssui=on" ; use ctrl+Shift+g
return

;^+e::Run "https://engnet/Engnet/engnet/engnet.asp" ; use ctrl+Shift+e
;return

/* Commented out due to conflict with "reply to all keyboard shortcut in Outlook"
	^+r::Run "http://riskview/RiskView_1_0/Home/MainPage" ; use ctrl+Shift+r
	return
*/
/* Commented out JOL
	^+j::
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
	^+a::
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
;          Shift+Ctrl+C to Google Search for Highlighted Text
;--------------------------------------------------------------------------

^+c::
{
	Send, ^c
	Sleep 50
	Run, http://www.google.com/search?q=%clipboard%
	Return
}

;--------------------------------------------------------------------------
;          Permanently Set Caplocks Off, NumLock On and Scroll Lock Off
;--------------------------------------------------------------------------

SetNumlockState, AlwaysOn
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
return

;--------------------------------------------------------------------------
;                Win+Delete to Empty Recycle Bin
;--------------------------------------------------------------------------

#Del::FileRecycleEmpty ; win + del

;---------------------------------------------------------------------------
;                      Helpful Stuff
;---------------------------------------------------------------------------
GetMouse:
CoordMode,Mouse,Screen
MouseGetPos,mx,my
CoordMode,Mouse,Relative
Return

PutMouse:
CoordMode,Mouse,Screen
MouseMove,%mx%,%my%,0
CoordMode,Mouse,Relative
Return

:*:attext::	; Timestamp
FormatTime Date, %A_Now%, MM/dd/yyyy	; format month, day and year
InputBox, npht, Air Tank, Nameplate Head Thickness (after 0.),,300,125
InputBox, npst, Air Tank, Nameplate Shell Thickness (after 0.),,300,125
InputBox, aht, Air Tank, Actual Head Thickness (after 0.),,300,125
InputBox, ast, Air Tank, Actual Shell Thickness (after 0.),,300,125
Send Nameplate HD: 0.%npht% / SH: 0.%npst% // %Date% TJK HD: 0.%aht% / SH: 0.%ast%
Return

Join(sep, params*) {
	for index,param in params
		str .= param . sep
	return SubStr(str, 1, -StrLen(sep))
}
;MsgBox % Join("`n", "one", "two", "three")

;---------------------------------------------------------------------------
;                          General Abbreviations
;---------------------------------------------------------------------------

^!0::
var = ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÑÒÓÔŒÕÖØÙÚÛÜßàáâãäåæçèéêëìíîïñòóôœõöøùúûüÿ¿¡«»§¶†‡•-–—™©®¢€¥£₤¤αβγδεζηθικλμνξοπρσςτυφχψωΓΔΘΛΞΠΣΦΨΩ∫∑∏√−±∞≈∝≡≠≤≥×·÷∂′″∇‰°∴ø∈∩∪⊂⊃⊆⊇¬∧∨∃∀⇒⇔→↔↑ℵ∉°₀₁₂₃₄₅₆₇₈₉⁰¹²³⁴⁵⁶⁷⁸⁹

w:=20, cnt := 14, arr := strsplit(var)
gui, new
gui, -caption
gui, margin, 0,0
gui, font, s10
loop,% arr.count()
{
	x := mod((a_index - 1),cnt) * w, y := floor((a_index - 1)/ cnt) * w
	gui, add, text, x%x% y%y% w%w% h%w% center vz%a_index% ginsert,% arr[a_index]
}
gui, show
return

insert:
gui,submit
Send % arr[substr(A_GuiControl,2)]
return


:?*X:nm::Send {Blind}≠ ; used for testing

:?*:not equal::
:?*:notequ::
:?*:not=::
A_Clipboard := "≠"
Send ^v
return
#If WinActive("ahk_exe Hznhorizon.exe")
	:?*:>=::
	A_Clipboard := "≥"
	Send ^v
	Return
#If
:?*:^i::^{i}

:?*X:microm::Send % chr(181) "m"
:?*X:3/4::Send % chr(190)
:?*X:1/2::Send % chr(189)
:?*X:1/4::Send % chr(188)
:?*X:+-::Send % chr(177)
:?*X:regtmf::Send % chr(174) ;®
:?*:trademarkf::™
:?*:circlec::©
:?*:copywritef::©
:?*:>=::
:?*:greater than or equal to::
A_Clipboard := "≥"
Send ^v
return
:?*X:degf::Send % chr(176) "F"
:?*X:degc::Send % chr(176) "C"
:?*X:prisec::Send % "1" chr(176) "/2 " chr(176) A_Space "Inj testing"
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
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
if EWD_WinState = 0  ; Only if the window isn't maximized 
	SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
	SetTimer, EWD_WatchMouse, off
	return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
{
	SetTimer, EWD_WatchMouse, off
	WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
	return
}
;Otherwise, reposition the window to match the change in mouse coordinates caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
;SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return
