
; Version: 2022.07.01.1
; https://gist.github.com/cd70e009792fc2eb866f9f5caf1e395a

/*
	Message.Listen(Callback) ; Listen
	Message.Listen()         ; Stop listening
	Message.Send(Message, Target[, Timeout := 5000ms])
	ErrorLevel
		-1 = Target not found
		 0 = Message accepted
		 1 = Message ignored
*/

class Message
{

	Listen(Callback := "")
	{
		if (Callback = "") {
			OnMessage(0x004A, "")
			return
		}
		if (!IsObject(Callback)) {
			if (!IsFunc(Callback))
				throw Exception("Not a function.", -1, Callback)
			Callback := Func(Callback)
		}
		Callback := ObjBindMethod(Message, "_Receive", Callback)
		OnMessage(0x004A, Callback) ; 0x004A = WM_COPYDATA
	}

	Send(Msg, Target, Timeout := 5000)
	{
		VarSetCapacity(COPYDATASTRUCT, 3 * A_PtrSize)
		NumPut(StrPut(Msg) * 2, COPYDATASTRUCT, A_PtrSize)
		NumPut(&Msg, COPYDATASTRUCT, 2 * A_PtrSize)
		Message._Modes(1)
		SendMessage 0x004A, 0, &COPYDATASTRUCT,, % Target,,,, % Timeout
		result := ErrorLevel
		Message._Modes(0)
		ErrorLevel := (result = "FAIL" ? -1 : !result)
	}

	; Private

	_Modes(Mode)
	{
		static dhw, tmm

		if (Mode) {
			dhw := A_DetectHiddenWindows
			tmm := A_TitleMatchMode
		}
		DetectHiddenWindows % {0:dhw, 1:1}[Mode]
		SetTitleMatchMode % {0:tmm, 1:2}[Mode]
	}

	_Receive(Callback, wParam, lParam)
	{
		lParam := NumGet(lParam + 2 * A_PtrSize)
		msg := StrGet(lParam)
		return true, Callback.Call(msg)
	}

}
