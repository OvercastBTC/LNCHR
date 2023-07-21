#NoEnv
SetWorkingDir %A_ScriptDir%

#include <UIA_Interface>
^+F1::
UIA := UIA_Interface()

;GetAllYtvLinks(wTitle*) {
;	ErrorLevel := 0
;	if !(wId := WinExist(wTitle*)) {
;		ErrorLevel := 1
;		return
;	}
;	for _, value in % UIA.ElementFromHandle(wId).FindAll(UIA.CreatePropertyCondition(UIA_ControlTypePropertyId, UIA_HyperlinkControlTypeId))
;		log.=InStr(v:=value.GetCurrentValue(),".youtube.com/watch?v=") ? v "`n" : ""
;	Clipboard := RegExReplace(RegExMatch(log, "i)\.youtube\.com/watch\?v=.+?&index=") ? RegExReplace(log, "im`a)^(?!.+?\.youtube\.com/watch\?v=.+?&index=).+?(\R|$)") : log, "im`a)&(list|pageId)=.+?(?=\R|$)")
;	If StrLen(Clipboard)
;		MsgBox,, YouTube Video Links, Retrieved, 1
;	Else MsgBox, Not Any YouTube Video Link Is Found
;	return Clipboard
;}

;GetAllYtvLinks("A")
Element:= UIA.ElementFromHandle(WinExist("ahk_exe hznhorizon.exe"))

MsgBox % element.dumpAll()
return