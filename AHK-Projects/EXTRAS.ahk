; ========================================================
; Int to Hex
; ========================================================
int2hex(int)
{
	HEX_INT := 8
	while (HEX_INT--)
	{
	    n := (int >> (HEX_INT * 4)) & 0xf
	    ret .= n > 9 ? chr(55 + n) : n
	    if (HEX_INT == 0 && HEX_INT//2 == 0)
	        ret .= " "
	}
	return "0x" ret
}

MsgBox % int2hex(130)        ; 0x00000077
int2hex(130)
; ========================================================
; Convert Base
; ========================================================
ConvertBase(InputBase, OutputBase, nptr)    ; Base 2 - 36
{
	static u := A_IsUnicode ? "_wcstoui64" : "_strtoui64"
	static v := A_IsUnicode ? "_i64tow"    : "_i64toa"
	VarSetCapacity(s, 66, 0)
	value := DllCall("msvcrt.dll\" u, "Str", nptr, "UInt", 0, "UInt", InputBase, "CDECL Int64")
	DllCall("msvcrt.dll\" v, "Int64", value, "Str", s, "UInt", OutputBase, "CDECL")
	return s
}

MsgBox % ConvertBase(10, 16, 119)        ; Dec to Hex: 77
MsgBox % ConvertBase(16, 10, 77)         ; Hex to Dec: 119

; ========================================================
; Hex to Str
; ========================================================
hex2str(hex)
{
	static u := A_IsUnicode ? "_wcstoui64" : "_strtoui64"
	loop, parse, hex, " "
	{
	    char .= Chr(DllCall("msvcrt.dll\" u, "Str", A_LoopField, "Uint", 0, "UInt", 16, "CDECL Int64"))
	}
	return char
}

MsgBox % hex2str("0x41 0x75 0x74 0x48 0x6f 0x74 0x6b 0x65 0x79")        ; AutoHotkey

; ========================================================
; Str to Hex
; ========================================================
str2hex(str)
{
	static v := A_IsUnicode ? "_i64tow" : "_i64toa"
	loop, parse, str
	{
	    VarSetCapacity(s, 65, 0)
	    DllCall("msvcrt.dll\" v, "Int64", Asc(A_LoopField), "Str", s, "UInt", 16, "CDECL")
	    hex .= "0x" s " "
	}
	return SubStr(hex, 1, (StrLen(hex) - 1))
}

MsgBox % str2hex("AutHotkey")        ; 0x41 0x75 0x74 0x48 0x6f 0x74 0x6b 0x65 0x79