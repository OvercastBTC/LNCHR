
#Warn All, OutputDebug

; Wait for incoming messages
Message.Listen("MyCallback")


return ; End of auto-execute


#Include %A_LineFile%\..\Message.ahk

MyCallback(MessageText)
{
	if (StrLen(MessageText) < 10)
		return false ; Message ignored
	MsgBox 0x40040, Message received, % MessageText
	return true ; Message accepted
}
