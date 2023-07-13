#Requires AutoHotKey 1.1+

q::
vText = %A_ScriptDir%\MyFile.txt`r`n%A_Desktop%\MyFile.txt
vList2 := "A_ScriptDir,A_Desktop,A_MyDocuments,A_YYYY,A_MM,A_AppData,A_DesktopCommon,A_StartMenu,A_StartMenuCommon,A_Programs,A_ProgramsCommon,A_Startup,A_StartupCommon"
Loop, Parse, vList2, % ","
{
	if !InStr(vText, "%A_")
		break
	if InStr(vText, "%" A_LoopField "%")
		vText := StrReplace(vText, "%" A_LoopField "%", %A_LoopField%)
}
MsgBox, % vText
;MsgBox, % vText . "`n" . A_ScriptDir . "`n" . A_Desktop ."`n" . A_MyDocuments . A_YYYY . "`n" . A_MM ."`n" . A_AppData ."`n" . A_DesktopCommon ."`n" . A_StartMenu ."`n" . A_StartMenuCommon ."`n" . A_Programs ."`n" . A_ProgramsCommon ."`n" . A_Startup ."`n" . A_StartupCommon
return
