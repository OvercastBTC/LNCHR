;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
/*
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
*/
;#SingleInstance,Force
;============================== Begin Includes Section ==============================

; Enabled
;#Include GUI_FE.ahk
;#Include GUI_ITM_Mills.ahk
;#Include GUI_Options.ahk
;#Include If_Horizon.ahk
;#Include RichEdit_Editor_1.0.ahk
;#Include WinClipAPI.ahk
;#Include WinClip.ahk
;#Include send_italic.ahk
;#Include MakeOSItalic.ahk
;#Include <CGUI.ahk>
;#Include Common_Abbrevations.ahk
;#Include Common_HumanElement.ahk
;#Include Common_Rec_Texts.ahk
;#Include autoahkHotstrings.ahk
;#Include Detect_Window_Active.ahk
;#Include Detect_Window_Info.ahk
;#Include Detect_Window_Update.ahk
;#Include autocorrect.ahk
;#Include horizontest.ahk
;#Include ..\..\Users\bacona\OneDrive - FM Global\Documents\Autohotkey\Lib\Base_SaveReload.ahk
;#Include windows-ahk-master\WINDOWS.ahk
;#Include FmtSecs.ahk
;#Include Win11_FileExplorer_Legacy_R_Click.ahk

; Disabled - Error - Re-enable -------------------------
;#Include powergen_gui.ahk                        ;some error

; Disabled - Saved -------------------------------------
;#Include italicer.ahk
;#Include ..\lib\SB.ahk						; This is likely included in another file (I forget which one)
;return

;============================== End Includes Section ==============================