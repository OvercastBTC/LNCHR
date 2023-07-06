#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent ; Keeps script permanently running
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
; Note: References found below

;================================= Main Script 1=================================
; .dotx is a Word template, but .doc and .docx will also work
FilePath := "C:\AHK-Studio\lib\MyDocument.dotx"
;Text:= % Clipboard
Text:="Switchgear and Circuit Breakers"
Clipboard = ""
oWord := ComObjCreate("Word.Application") ; create MS Word object
oWord.Documents.Add(FilePath) ; Open the template

wdApp.Hidden
oWord.Visible := false
oWord.Selection.Font.Italic := 1 ; italic
;oWord.Selection.Font.Bold := 1 ; bold
oWord.Selection.TypeText(Text) ; type text
oWord.Selection.WholeStory ; https://www.autohotkey.com/boards/viewtopic.php?t=55567
oWord.Selection.Copy

WinActivate, ahk_exe hznHorizon.exe
Send, ^v
;============================== Reference Scripts ==============================
/*
; original script found at https://www.autohotkey.com/boards/viewtopic.php?t=17357	
; .dotx is a Word template, but .doc and .docx will also work
FilePath := "C:\AHK-Studio\lib\MyDocument.dotx"
wdApp := ComObjCreate("Word.Application") ; Create an instance of Word

; You can remove this after testing so that Word stays invisible. 
; Confirm that the script closes Word at the end so you don't get a bunch of
; invisible Word applications open in the background.
wdApp.Visible := true

MyDocNew := wdApp.Documents.Add(FilePath) ; Open the template
FormatTime, MyTime,, h:mm tt dddd MMMM d, yyyy

; Put the text into the bookmarks
;MyDocNew.Bookmarks("MyBookmark1").Range.Text := MyTime
;MyDocNew.Bookmarks("MyBookmark2").Range.Text := "Hello World!"

;MyDocNew.PrintOut() ; Print the document with the default printer
MyDocNew.Close(0) ; Close the document without saving
wdApp.Quit() ; Quit Word
return
*/
/*
; original script found at https://www.autohotkey.com/board/topic/56987-com-object-reference-autohotkey-v11/://autohotkey.com/board/topic/56987-com-object-reference-autohotkey-v11/page-3?&#entry373523	
oWord := ComObjCreate("Word.Application") ; create MS Word object
oWord.Documents.Add ; create new document

oWord.Selection.Font.Bold := 1 ; bold
oWord.Selection.TypeText("Visit ") ; type text
oWord.ActiveDocument.Hyperlinks.Add(oWord.Selection.Range, "http://www.autohotkey.com/forum/topic61509.html"
,"","","COM Object Reference [AutoHotkey_L]") ; insert hyperlink
oWord.Selection.TypeText("and learn how to work with ") ; type text
oWord.Selection.Font.Italic := 1 ; italic
oWord.Selection.TypeText("COM objects") ; type text
oWord.Selection.Font.Bold := 0, oWord.Selection.Font.Italic := 0 ; bold and italic off
oWord.Selection.TypeText(".") ; type text
oWord.Selection.TypeParagraph ; type paragraph (enter, new line)

oWord.Visible := 1, oWord.Activate ; make it visible and activate it.
ExitApp
*/