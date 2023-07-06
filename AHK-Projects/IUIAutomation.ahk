#NoEnv
SetWorkingDir %A_ScriptDir%

GetAllYtvLinks(wTitle*) {
	ErrorLevel := 0
	if !(wId := WinExist(wTitle*)) {
		ErrorLevel := 1
		return
	}
	IUIAutomation := ComObjCreate(CLSID_CUIAutomation := "{ff48dba4-60ef-4201-aa87-54103eef594e}", IID_IUIAutomation := "{30cbe57d-d9d0-452a-ab13-7ac5ac4825ee}")
	VarSetCapacity(var,8+2*A_PtrSize), NumPut(3,var,0,"short"), NumPut(UIA_HyperlinkControlTypeId := 50005,var,8,"ptr")
	if (A_PtrSize == 4) 
		DllCall(NumGet(NumGet(IUIAutomation+0)+23*A_PtrSize), "ptr",IUIAutomation, "int", UIA_ControlTypePropertyId := 30003, "int64", NumGet(var, 0, "int64"), "int64", NumGet(var, 8, "int64"), "ptr*",linkCondition) ; IUIAutomation::CreatePropertyCondition
	else 
		DllCall(NumGet(NumGet(IUIAutomation+0)+23*A_PtrSize), "ptr",IUIAutomation, "int", UIA_ControlTypePropertyId := 30003, "ptr",&var, "ptr*",linkCondition) ; IUIAutomation::CreatePropertyCondition
	DllCall(NumGet(NumGet(IUIAutomation+0)+6*A_PtrSize), "ptr", IUIAutomation, "ptr", wId, "ptr*", elementMain)   ; IUIAutomation::ElementFromHandle
	DllCall(NumGet(NumGet(elementMain+0)+6*A_PtrSize), "ptr", elementMain, "int", TreeScope_Descendants := 0x4, "ptr", linkCondition, "ptr*", elementArray)   ; IUIAutomationElement::FindAll
	DllCall(NumGet(NumGet(elementArray+0)+3*A_PtrSize), "ptr", elementArray, "ptr*", aLen)   ; IUIAutomationElementArray::get_Length
	Loop, %aLen%
		DllCall(NumGet(NumGet(elementArray+0)+4*A_PtrSize), "ptr", elementArray, "int", A_Index-1, "ptr*", currentElement)   ; IUIAutomationElementArray::GetElement
		,DllCall(NumGet(NumGet(currentElement+0)+10*A_PtrSize),"ptr",currentElement,"uint",30045,"ptr",(VarSetCapacity(currentValue,8+2*A_PtrSize)+NumPut(0,currentValue,0,"short")+NumPut(0,currentValue,8,"ptr"))*0+&currentValue)   ;IUIAutomationElement::GetCurrentPropertyValue
		,log.=InStr(v:=StrGet(NumGet(currentValue,8,"ptr"),"utf-16"),".youtube.com/watch?v=") ? v "`n" : ""
	ObjRelease(IUIAutomation)
	Clipboard := RegExReplace(RegExMatch(log, "i)\.youtube\.com/watch\?v=.+?&index=") ? RegExReplace(log, "im`a)^(?!.+?\.youtube\.com/watch\?v=.+?&index=).+?(\R|$)") : log, "im`a)&(list|pageId)=.+?(?=\R|$)")
	If StrLen(Clipboard)
		MsgBox,, YouTube Video Links, Retrieved, 1
	Else MsgBox, No YouTube video link(s) found.
	return Clipboard
}

F1::GetAllYtvLinks("A")