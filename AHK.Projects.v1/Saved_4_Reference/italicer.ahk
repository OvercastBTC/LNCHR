#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#H::
Gui, Italicer:New,, Italicer
Gui, Add, Text,, Word to trigger the hotstring goes Here:""
Gui, Add, Edit, R1 W200 vTrigger -WantReturn -WantTab
Gui, Add, Text,, New Word Goes Here (Can be multiline):
Gui, Add, Edit, R7 vNewW W200, Text
Gui, Add, Checkbox, vItalic YM+90, Italic Letters
Gui, Add, Checkbox, vBold, Bold Letters
Gui, Add, Checkbox, vUnderLine, Underline Letters
Gui, Add, Button, gAdd Y190 X90 Section, Add new Word
Gui, Add, Button, gCancel YS, Cancel
Gui, Show, AutoSize
Return

Add:
GuiControlGet, IsItalic,, Italic
GuiControlGet, IsBold,, Bold
GuiControlGet, IsUnderLine,, Underline
GuiControlGet, Trigger,, Trigger, Edit
GuiControlGet, NewWord,, NewW, Edit
IF (IsItalic = 1)
{
	NewWord := "^i" . NewWord . "^i"
}
IF (IsBold = 1)
{
	NewWord := "^n" . NewWord . "^n"
}
IF (IsUnderLine = 1)
{
	NewWord := "^s" . NewWord . "^s"
}
FileAppend, `n:X:%Trigger%::Send`,`n(`n%NewWord%`n)`nReturn`n, %A_ScriptName%
Gui, Italicer:Destroy
MsgBox, Word Succesfully Added!
Reload
Return

; -----------------------------------------------------------------