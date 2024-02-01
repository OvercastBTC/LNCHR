#Requires AutoHotkey v1


;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
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
run detect_ActiveProcess.ahk
;============================== Group Section ==============================
GroupAdd, saveReload, %A_ScriptName%
GroupAdd, AllWindows,,,,hznhorizon.exe
GroupAdd, horizon, hznhorizon.exe

; Tray Icon and Menu Options
Menu, Tray, Icon, shell32.dll, 16 ; this changes the icon into a little laptop thing.
Menu, Tray, NoStandard
addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
addTrayMenuOption()
addTrayMenuOption("Run at startup", "runAtStartup")
Menu, Tray, % fileExist(startup_shortcut) ? "check" : "unCheck", Run at startup ; update the tray menu status on startup
addTrayMenuOption("Presentation mode {Win+Shift+P}", "togglePresentationMode")
addTrayMenuOption("Keyboard shortcuts {Ctrl+Shift+Alt+\}", "viewKeyboardShortcuts")
addTrayMenuOption("Open file location", "openFileLocation")
addTrayMenuOption()
;addTrayMenuOption("View in GitHub", "viewInGitHub")
addTrayMenuOption("See AutoHotKey documentation", "viewAHKDoc")
addTrayMenuOption()
Menu, Tray, Standard
return
;============================== Begin Includes Section ==============================

; Enabled
Sleep 100
#Include GUI_FE.ahk
#Include GUI_ITM_Mills.ahk
#Include GUI_INI.ahk
#Include GUI_Options.ahk
#Include WinClipAPI.ahk
#Include WinClip.ahk
#Include send_italic.ahk
;#Include MakeOSItalic.ahk
#Include Common_Abbrevations.ahk
#Include Common_HumanElement.ahk
#Include Common_Rec_Texts.ahk
#Include autoahkHotstrings.ahk
;#Include Detect_Window_Active.ahk
#Include Detect_Window_Info.ahk
#Include Detect_Window_Update.ahk
;#Include autocorrect.ahk
#Include AutoCorrect.ahk
#Include horizontest.ahk
#Include ..\..\Users\bacona\OneDrive - FM Global\Documents\Autohotkey\Lib\Base_SaveReload.ahk
#Include windows-ahk-master\WINDOWS.ahk
#Include Win11_FileExplorer_Legacy_R_Click.ahk
run detect_ActiveProcess.ahk
; Disabled - Error - Re-enable -------------------------
;#Include RichEdit_Editor_1.0.ahk
;#Include powergen_gui.ahk                        ;some error

; Disabled - Saved -------------------------------------
;#Include FmtSecs.ahk
;#Include <CGUI.ahk>
;#Include italicer.ahk
;#Include ..\lib\SB.ahk						; This is likely included in another file (I forget which one)
;#Include Includes.ahk
return

;============================== End Includes Section ==============================

;-------------------------------------------------------------------------------

;============================== Test Programs ==============================
; https://www.autohotkey.com/board/topic/53443-found-the-top-level-handle-one-hwnd-to-rule-them-all/
^!#h::
ControlHwnd:= 
ControlSend, , {Click}, ahk_id %ControlHwnd%
return
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

;--------------------------------------------------------------------------
;          Temporary Text Hot Key
;--------------------------------------------------------------------------
; Use SendEvent so that the script's own hotkeys can be triggered.
Hotkey, ^+z
{
	SendEvent ^c
	Sleep 50
	TempHotKey = %clipboard%
	:*:tmp::
	Send % TempHotKey
	Return
}
Return
;---------------------------------------------------------------------------
;                Win+NumLock Temporarily Suspend AutoHotkey 
;---------------------------------------------------------------------------

;#NumLock::Suspend ; Win + NumLock
;return

;---------------------------------------------------------------------------
;                Ctrl+Shift+Alt+r Reload AutoHotKey Script (to load changes)
;---------------------------------------------------------------------------

;#IfWinExist ahk_id WINDOW.ahk
;while true
	;return
;while false
	;^+!r::
;ReloadAllAhkScripts()
TrayTip
Reload
;return
;#IfWinExist

;---------------------------------------------------------------------------
;                  Personal Abbreviations 
;---------------------------------------------------------------------------


;--------------------------------------------------------------------------
;     DSP Email Subject Endings for Quick Entry ;#[AHK Script - DSPs]
;--------------------------------------------------------------------------


;---------------------------------------------------------------------------
;      Shift+WIN+m Button to Click on Window Anywhere to Drag
;---------------------------------------------------------------------------
; This script is from the Automator

^#m::
CoordMode, Mouse, Screen
MouseGetPos, x, y
WinMove A,, %x%,%y%
return
;---------------------------------------------------------------------------
;                       Time Stamp Code
;---------------------------------------------------------------------------

:*:ts::
FormatTime Date, %A_Now%, MM/yyyy ; format month and year
Send (AJB - %Date%)
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
/*
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
return

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

:*:degf::
SendEvent % chr(176)
return
:*:prisec::
Send 1
SendEvent % chr(176) 
Send /2
SendEvent % chr(176)
Send {Space}Inj testing
:*:hrsgf::heat recovery steam generator (HRSG)
:*:mocf::management of change (MOC)
::ag::Approval Guide
::FMDSf::FM Global Property Loss Prevention Data Sheet
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
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return
