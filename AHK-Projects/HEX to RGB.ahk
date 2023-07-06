hex2rgb(CR)
{
	H := InStr(CR, "0x") ? CR : (InStr(CR, "#") ? "0x" SubStr(CR, 2) : "0x" CR)
	return (H & 0xFF0000) >> 16 "," (H & 0xFF00) >> 8 "," (H & 0xFF)
}

MsgBox % hex2rgb("0x77c8d2")        ; 119,200,210
MsgBox % hex2rgb("#77c8d2")         ; 119,200,210
MsgBox % hex2rgb("77c8d2")          ; 119,200,210

; ==================================================================================================

hex2rgb(CR)
{
	H := InStr(CR, "0x") ? CR : (InStr(CR, "#") ? "0x" SubStr(CR, 2) : "0x" CR)
	return (H / 65536) & 255 "," (H / 256) & 255 "," H & 255
}

MsgBox % hex2rgb("0x77c8d2")        ; 119,200,210
MsgBox % hex2rgb("#77c8d2")         ; 119,200,210
MsgBox % hex2rgb("77c8d2")          ; 119,200,210

; ==================================================================================================

hex2rgb(CR)
{
	NumPut((InStr(CR, "#") ? "0x" SubStr(CR, 2) : "0x") SubStr(CR, -5), (V := "000000"))
	return NumGet(V, 2, "UChar") "," NumGet(V, 1, "UChar") "," NumGet(V, 0, "UChar")
}

MsgBox % hex2rgb("0x77c8d2")        ; 119,200,210
MsgBox % hex2rgb("#77c8d2")         ; 119,200,210
MsgBox % hex2rgb("77c8d2")          ; 119,200,210