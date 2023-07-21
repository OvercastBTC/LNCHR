;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; How fast a script will run (affects CPU utilization). ; -1 = script will run @ max speed.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; Title matching 1 = starts with; 2 = containing; 3 = exact
DetectHiddenText,On
DetectHiddenWindows, On

; Create Setting Gui
Gui, New,, Hotkey Helper
Gui,+AlwaysOnTop +Caption +Border +Resize +SysMenu +Theme
Gui, Font, s11
Gui, Add, Text, x120 y10 w200 h20 , Hotkey Help - Pick Settings
Gui, Add, Text, x30 y40 w390 h2 0x7
Gui, Add, CheckBox, x60 y50 w380 h30 vSet_ShowBlank, Show Files With No Hotkeys
Gui, Add, CheckBox, x60 y80 w380 h30 vSet_ShowBlankInclude, Show Include Files With No Hotkeys
Gui, Add, CheckBox, x60 y110 w380 h30 vSet_ShowExe, Show EXE Files (Help Comments Do Not Exist in EXE)
Gui, Add, CheckBox, x60 y140 w380 h30 vSet_AhkExe, Scan AHK File with Same Name as Running EXE
Gui, Add, CheckBox, x60 y170 w380 h30 vSet_AhkTxt, Scan Text Files with Same Name as Running Script
Gui, Add, CheckBox, x60 y200 w380 h30 vSet_AhkTxtOver, Text File Help will Overwrite Duplicate Help
Gui, Add, CheckBox, x60 y230 w380 h30 vSet_ShowHotkey, Show Created with Hotkey Command
Gui, Add, CheckBox, x60 y260 w380 h30 vSet_VarHotkey, Attempt to Resolve Variables in Dynamic Hotkeys
Gui, Add, CheckBox, x60 y290 w380 h30 vSet_FlagHotkey, Flag Hotkeys created with the Hotkey Command with <HK>
Gui, Add, CheckBox, x60 y320 w380 h30 vSet_SortInfo, Sort by Hotkey Description (Otherwise by Hotkey Name)
Gui, Add, CheckBox, x60 y350 w180 h30 vSet_CapHotkey, Hotkey Capitalization
Gui, Add, Radio, x240 y380 w80 h30 vSet_CapHotkey_Radio, Title
Gui, Add, Radio, x320 y380 w120 h30, UPPER
Gui, Add, CheckBox, x60 y410 w380 h30 vSet_ShowString, Show Hotstrings
Gui, Add, CheckBox, x60 y440 w380 h30 vSet_HideFold, Hide Fold Start  `;`{  from Help Comment
Gui, Add, CheckBox, x60 y470 w380 h30 vSet_IniSet, Use INI File to Save Settings
Gui, Add, CheckBox, x60 y500 w380 h30 vSet_IniExcluded, Use INI File to Save Excluded Files and Hotkeys
Gui, Add, ComboBox, x60 y530 w60 h30 R5 Choose1 vSet_Hotkey_Mod_Delimiter, "%Set_Hotkey_Mod_Delimiter%"|"+"|"-"|" + "|" - "
Gui, Add, Text, x130 y560 w250 h30, Delimiter to Separate Hotkey Modifiers
Gui, Add, Button, Default x60 y580 w330 h30, Finished
Gui, Show, AutoSize, Hotkey Helper
Gui, Submit,Nohide
;WinMove, Hotkey Helper,, 0, 0