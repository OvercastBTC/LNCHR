Gui, Font, s10
le_guide_name = Loss Expectancy Guide
LEout = %o_d_path%%le_guide_dir%
le_guide = %LEout%\*%le_guide_name%*.xlsx

Loop Files, %le_guide%, R  ; Recurse into subfolders.
{
	;MsgBox, 4, , Filename = %A_LoopFileFullPath%`n`nContinue?
	;MsgBox, %A_LoopFileFullPath%
	;Run, %A_LoopFileFullPath%
	;FileName = %A_LoopFileName%
	
	;IfMsgBox, No
	;	break
	file := "C:\Users\bacona\FM Global\Operating Standards - Documents\general\B`+M Loss Expectancy Guide - Jan 2023.xlsx", cb := [], Clipboard := "", cols := 0 
	xl := ComObjCreate("Excel.Application"), Wrkbk := xl.Workbooks.Open(file), xl.ActiveSheet1.UsedRange.copy
	xl := ComObjCreate("Excel.Application"), Wrkbk := xl.Workbooks.Open(file), xl.ActiveSheet3.UsedRange.copy
	xl := ComObjCreate("Excel.Application"), Wrkbk := xl.Workbooks.Open(file), xl.ActiveSheet4.UsedRange.copy
	xl := ComObjCreate("Excel.Application"), Wrkbk := xl.Workbooks.Open(file), xl.ActiveSheet5.UsedRange.copy
	xl := ComObjCreate("Excel.Application"), Wrkbk := xl.Workbooks.Open(file), xl.ActiveSheet6.UsedRange.copy
	ClipWait, 0
	If ErrorLevel {
		MsgBox, 48, Error, An error occurred while waiting for the clipboard. Aborting.
		Return
	}
	For row, line in StrSplit(Trim(Clipboard, "`r`n"), "`n")
		For col, item in StrSplit(line, "`t")
			cb[col] .= item (row = 1 ? "||" : "|"), cols += row = 1
	Loop, %cols%
		Gui, Add, ComboBox, w275 vitem%A_Index%, % cb[A_Index]
	Wrkbk.Close(0), xl.Quit()
	GuiControl, Focus, item1
	Gosub, F11
	
	F11::Gui, Show, w300, Items
}
return

GuiEscape:
GuiClose:
Gui, Hide
Return