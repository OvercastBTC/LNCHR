rgb2hex(R, G, B, H := 1) ; just me
{
	H := ((H = 1) ? "#" : ((H = 2) ? "0x" : ""))
	VarSetCapacity(Hex, 17 << !!A_IsUnicode, 0)
	DllCall("Shlwapi.dll\wnsprintf", "Str", Hex, "Int", 17, "Str", "%016I64X", "UInt64", (R << 16) + (G << 8) + B, "Int")
	return H SubStr(Hex, StrLen(Hex) - 6 + 1)
}

MsgBox % rgb2hex("119", "200", "210", 0)        ; 77C8D2
MsgBox % rgb2hex("119", "200", "210", 1)        ; #77C8D2
MsgBox % rgb2hex("119", "200", "210", 2)        ; 0x77C8D2

; ==================================================================================================

rgb2hex(R, G, B, H := 1)
{
	static U := A_IsUnicode ? "_wcstoui64" : "_strtoui64"
	static V := A_IsUnicode ? "_i64tow"    : "_i64toa"
	rgb := ((R << 16) + (G << 8) + B)
	H := ((H = 1) ? "#" : ((H = 2) ? "0x" : ""))
	VarSetCapacity(S, 66, 0)
	value := DllCall("msvcrt.dll\" U, "Str", rgb , "UInt", 0, "UInt", 10, "CDECL Int64")
	DllCall("msvcrt.dll\" V, "Int64", value, "Str", S, "UInt", 16, "CDECL")
	return H S
}

MsgBox % rgb2hex("119", "200", "210", 0)        ; 77C8D2
MsgBox % rgb2hex("119", "200", "210", 1)        ; #77C8D2