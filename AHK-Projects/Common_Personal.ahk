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
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
;#SingleInstance,Force
;#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;DetectHiddenText,On
;DetectHiddenWindows, On
;#Requires AutoHotkey 1.1+
;#NoTrayIcon
; ************************************ ... First Return ... ************************************
;return
;-----------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


;---------------------------------------------------------------------------
;                  Personal Abbreviations 
;---------------------------------------------------------------------------

:*:peml::adam.bacon80@icloud.com												; Personal Email
:*:eml::adam.bacon@fmglobal.com													; Email
:*:emp#::52906																	; Employee Number
:*:officeaddress::FM Global: 601 108th Ave NE, Suite 1400, Bellevue, WA 98004 	; Office Address
:*:paddrf::1378 Fenmore Ave, Sanger, CA 93657									; My Address
:*:pwnotes::
; =============================== + FM Stuff + =============================
:*:fmusr::bacona				; workstation username
:*:fmpw::{!}980ab**HD{!}9KB		; fm 
#If WinActive("EngNET")
	:*:usr::bacona
	:*:pw::{!}980ab**HD{!}9KB
#If
#If WinActive("Xfinity")
	:*:usr::harmony_bacon@comcast.net
	:*:pw::Ah{!}9801988
#If
#If WinActive("AT&T")
	:*:usr::bacon942882
	:*:pw::Ah_19801988
#If
#If WinActive("Marriott")
	:*:usr::063194266
	:*:pw::HDBacon{!}9801988
#If
#If WinActive("GitHub")
	:*:usr::OvercastBTC
	:*:pw::HDBacon{!}980{!}988
#If
#If WinActive("AutoHotKey")
	:*:usr::OvercastBTC
	:*:pw::HDBacon{!}980{!}988
#If
;============================== Other =============================================
;SendEvent ; Use SendEvent so that the script's own hotkeys can be triggered.
:?*:epw::HDBacon{!}9801988									; other password
:?*:gpwf::80**19HDabKB									; g password
:?*:wifionboard::Ah{!}980198812
; wifi onboard title window Sign in - Alaska Airlines - Google Chrome
/*
	#IfWinActive ahk_class CabinetWClass
	#InputLevel 1
	RButton::
	SendEvent {Shift down}
	SendEvent RButton
	SendEvent {Shift up}
	;SendEvent {Blind}{LButton up}
	;SendEvent {Blind}{LShift up}
	ToolTip You pressed %A_ThisHotkey%.
	Sleep 3000
	ToolTip
	;Send {ShiftDown}
	;PostMessage,0x0204,,,,ahk_exe explorer.exe 
	;PostMessage,0x0205,,,,ahk_exe explorer.exe 
	;send {ShiftUp}
	return
	#InputLevel
	#IfWinActive
*/
#IfWinActive Reddit	
:*:usr::Comfortable_Kick_776
:*:pw:: 80ab**HD!9KB20!9
redditpw:
; fmjobapp ---------------------
#IfWinActive intranet-fmglobal.icims.com
if false
		:*:joblog::
	SendLevel 1
site:= "https://intranet-fmglobal.icims.com/jobs/candidate?back=dashboard"
Run % site
return
:*:eml::adam.bacon@fmglobal.com
:*:usr::adambacon160807
:*:pw::80ab**HD{!}9KB{!}9
return
#IfWinActive
; Marsh ---------------------
#IfWinActive kiteworks
:*:marshlog::
site:= "https://us-mmc-datatransfer.mmc.com/login?#/"
Run % site
return
:*:usr::
Send, adam.bacon@fmglobal.com
Clipboard = HDBacon{!}9801988
return
#IfWinActive
; Delta---------------------
#IfWinActive Delta
:*:deltalog::
site:= "https://www.delta.com/mydelta/walletMyReceiptSummary"
Run % site
return
:*:usr::9339385271
:*:pw::HDBacon{!}9801988
return
#IfWinActive
; Alaska--------------------
#IfWinActive Alaska Airlines
:*:aklog::
site:= "https://www.alaskaair.com"
Run % site
;WinWaitActive, Account | Alaska Airlines - Google Chrome ;https://www.autohotkey.com/docs/v1/lib/WinWait.htm
while (Title = site)
	:*:usr::72832631
	:*:pw::Ah{!}9801988
	Return
#IfWinActive
; Hilton---------------------------------------
#IfWinActive Hilton
:*:hiltonlog::
site:= "https://www.hilton.com/"
Run % site
return
:*:usr::942499799
:*:pw::HDBacon{!}9801988
return
#IfWinActive
; the-automator.com----------------------------
#IfWinActive the-Automator
:*:automatorlog::
SendLevel 1
site:= "https://https://www.the-automator.com/wp-login.php"
Run % site
return
:*:usr::adam.bacon80@icloud.com
:*:pw::HDBacon{!}9801988
return
#IfWinActive
; iCloud ---------------------------------------
#IfWinActive iCloud
:*:icloudlog::
site:= "https://www.icloud.com/"
Run % site
return
:*:usr::adamjcdbacon@hotmail.com
:*:pw::80ab**HD{!}9KB20{!}9
return
#IfWinActive
; Discord ---------------------------------------
#IfWinActive Discord
:*:discordlog::
site:= "https://discord.com/channels/@me"
Run % site
return
:*:usr::adam.bacon8073@gmail.com
:*:pw::HDBacon{!}980{!}988
return
#IfWinActive
; Avis ---------------------------------------
#IfWinActive Avis
:*:avislog::
site:= "https://www.avis.com/"
Run % site
return
:*:usr::S4K347
:*:pw::HDBacon{!}9801988
return
#IfWinActive
#IfWinActive United
:*:unitedlog::
site:= "https://www.united.com/"
Run % site
return
:*:usr::MP216222
:*:pw::HDBacon{!}9801988
return
#IfWinActive
/*
MileIQ: 80ab**HD19KB
Marriott: 063194266 , HDBacon!9801988
ATT: Ah_19801988
UID: 1170ON
(VAHealth)idme: Ah!980198819
FCM: 80ab**HD19KB1
Xf: Ah!....
Hilton: 942499799 , HDBacon!9801988
United: MP216222 , HDBacon!9801988
Alaska: 72832631 , Ah!9801988
Delta: 9339385271, HDBacon!9801988
Hertz: 21082776 , HD
Carey: fm email, HD
Expense Report Format:

Business Travel - Airfare - 
Business Travel - Meal - 
Business Travel - Rental Car - 

FM Approvals: 80ab**HD19KB
*/