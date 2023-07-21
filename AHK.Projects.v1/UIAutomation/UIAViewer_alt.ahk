full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            ;Run *RunAs "%A_ScriptFullPath%" /restart
            Run "%A_ScriptFullPath%" /restart
        else
            ;Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
            Run "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}


#Include Lib\UIA_Interface.ahk
uia := UIA_Interface()

F8::
Element := uia.ElementFromPoint()

itemID := Element.GetCurrentPropertyValue(30011)
if (itemID == "")
	itemID := "No Automation ID"
itemValue := Element.GetCurrentPropertyValue(30045)
if (itemValue == "")
	itemValue := "No text/value"
itemName := Element.GetCurrentPropertyValue(30005)
if (itemName == "")
	itemName := "No 'Name'"
itemClass := Element.GetCurrentPropertyValue(30012)
if (itemClass == "")
	itemClass := "No 'Class'"
itemLegacy := Element.GetCurrentPropertyValue(30090)
if (ItemLegacy == -1)
	itemLegacy := "Legacy Info Available : yes"
else itemLegacy := "Legacy Info Available : no"
	itemLegacyValue := Element.GetCurrentPropertyValue(30093)
if (itemLegacyValue == "")
	itemLegacyValue := "No Legacy value present"
itemLegacyShortcut := Element.GetCurrentPropertyValue(30098)
if (itemLegacyShortcut == "")
	itemLegacyShortcut := "No Legacy keyboard shortcut"
itemLegacyChildId := Element.GetCurrentPropertyValue(30091)
if (itemLegacyChildId == "")
	itemLegacyChildId := "No Legacy ChildID"
itemLegacyDefaultAction := Element.GetCurrentPropertyValue(30100)
if (itemLegacyDefaultAction == "")
	itemLegacyDefaultAction := "No Legacy default action"
itemLegacyHelp := Element.GetCurrentPropertyValue(30097)
if (itemLegacyHelp == "")
	itemLegacyHelp := "No Legacy help"
itemLegacyRole := Element.GetCurrentPropertyValue(30095)
if (itemLegacyRole == "")
	itemLegacyRole := "No Legacy role"
windowModal := Element.GetCurrentPropertyValue(30077)
if (windowModal == "" || windowModal == false)
	windowModal := "Not modal"
else windowModal := "Modal window"
itemAccessKey := Element.GetCurrentPropertyValue(30007)
if (itemAccessKey == "" || !(itemAccessKey))
	itemAccessKey := "No Access Key"

	



msg =
(
Text: %itemValue%
ID: %itemID%
Name: %itemName%
Class: %itemClass%
Legacy: %itemLegacy%
Legacy Value: %itemLegacyValue%
Legacy Shortcut: %itemLegacyShortcut%
Legacy Child ID: %itemLegacyChildId%
Legacy Default Action: %itemLegacyDefaultAction%
Legacy Help: %itemLegacyHelp%
Legacy Role: %itemLegacyRole%
Modal State: %windowModal%
Access Key: %itemAccessKey%
)
msgbox %msg%
Clipboard := msg



return

^!Esc::ExitApp


