;============================== Start Auto-Execution Section ==============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
;============================== Begin Script ==============================
;q:: ;an attempt to retrieve custom and dll functions from the AHK source code (these can then be filtered by checking if the functions exist in a dll)
;[download AHK source code from:]
;GitHub - Lexikos/AutoHotkey_L: AutoHotkey - macro-creation and automation-oriented scripting utility for Windows.
;https://github.com/Lexikos/AutoHotkey_L

vDir1 = C:\Users\bacona\OneDrive - FM Global\Downloads\AutoHotkey-alpha
if !FileExist(vDir1)
{
	MsgBox, % "error: folder not found"
	return
}
vOutput := ""
VarSetCapacity(vOutput, 1000000*2)
vIsV1 := !!SubStr(1,0)
Loop, Files, % vDir1 "\*.cpp", FR
{
	vPath := A_LoopFileFullPath
	SplitPath, vPath, vName, vDir, vExt, vNameNoExt, vDrive
	FileRead, vText, % vPath
	vList := "`r`n!)*,."">;[]:/`t#$%&-+='~|{}<?@\^``"
	Loop, Parse, vList
		vText := StrReplace(vText, A_LoopField, "")
	Loop, Parse, vText, % " "
	{
		vTemp := A_LoopField
		while (SubStr(vTemp, 1, 1) = "(")
			vTemp := SubStr(vTemp, 2)
		if (vPos := InStr(vTemp, "(", 0, vIsV1-1))
			vOutput .= SubStr(vTemp, 1, vPos-1) "`n"
	}
}

while InStr(vOutput, "((")
	vOutput := StrReplace(vOutput, "((", "(")
vOutput := StrReplace(vOutput, "(`n", "`n")
vOutput := StrReplace(vOutput, "(", "`n")

Sort, vOutput, U
vOutput := StrReplace(vOutput, "`n", "`r`n")
Clipboard := vOutput
MsgBox, % "done"
return

;q:: ;list a dll's functions
;[list of 30 dlls from the AutoHotkey_H documentation]
;[28 if remove duplicate of Kernel32 and if remove Winspool]
;list converted to lowercase from: https://hotkeyit.github.io/v2/docs/commands/WinApi.htm
vListDll := "advapi32,comctl32,comdlg32,crypt32,gdi32,gdiplus,glu32,hid,kernel32,ole32,oleacc,oleaut32,opengl32,psapi,rasapi32,rasdlg,rasman,shell32,shlwapi,tapi32,user32,userenv,uxtheme,version,winhttp,wininet,winmm,ws2_32"
;list converted to lowercase from: AHK exe list of memory regions via process hacker
;vListDll := "advapi32,apisetschema,comctl32,comdlg32,cryptbase,dwmapi,gdi32,imm32,kernel32,kernelbase,lpk,msctf,msvcrt,nsi,ntdll,ole32,oleaut32,psapi,rpcrt4,sechost,shell32,shlwapi,sspicli,user32,usp10,uxtheme,version,winmm,wow64,wow64cpu,wow64win,ws2_32,wsock32"
vOutput := ""
VarSetCapacity(vOutput, 1000000*2)
Loop, Parse, vListDll, % ","
{
	vTemp := "[" A_LoopField "]`n" DllListExports(A_LoopField ".dll")
	vTemp := StrReplace(vTemp, "`n", "`n" A_LoopField "\")
	vOutput .= vTemp "`n"
}
vOutput := StrReplace(vOutput, "`n", "`r`n")
Clipboard := vOutput
MsgBox, % "done"
return

;==================================================

;DllListExports() - List of Function exports of a DLL - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=6&t=4563

DllListExports( DLL, Hdr := 0 ) {   ;   By SKAN,  http://goo.gl/DsMqa6 ,  CD:26/Aug/2010 | MD:14/Sep/2014
	
	Local LOADED_IMAGE, nSize := VarSetCapacity( LOADED_IMAGE, 84, 0 ), pMappedAddress, pFileHeader
    , pIMGDIR_EN_EXP, IMAGE_DIRECTORY_ENTRY_EXPORT := 0, RVA, VA, LIST := ""
    , hModule := DllCall( "LoadLibrary", "Str","ImageHlp.dll", "Ptr" )
	
	If ! DllCall( "ImageHlp\MapAndLoad", "AStr",DLL, "Int",0, "Ptr",&LOADED_IMAGE, "Int",True, "Int",True )
		Return
	
	pMappedAddress := NumGet( LOADED_IMAGE, ( A_PtrSize = 4 ) ?  8 : 16 )
	pFileHeader    := NumGet( LOADED_IMAGE, ( A_PtrSize = 4 ) ? 12 : 24 )
	
	pIMGDIR_EN_EXP := DllCall( "ImageHlp\ImageDirectoryEntryToData", "Ptr",pMappedAddress
                           , "Int",False, "UShort",IMAGE_DIRECTORY_ENTRY_EXPORT, "PtrP",nSize, "Ptr" )
	
	VA  := DllCall( "ImageHlp\ImageRvaToVa", "Ptr",pFileHeader, "Ptr",pMappedAddress, "UInt"
, RVA := NumGet( pIMGDIR_EN_EXP + 12 ), "Ptr",0, "Ptr" )
	
	If ( VA ) {
		VarSetCapacity( LIST, nSize, 0 )
		Loop % NumGet( pIMGDIR_EN_EXP + 24, "UInt" ) + 1
			LIST .= StrGet( Va + StrLen( LIST ), "" ) "`n"
             ,  ( Hdr = 0 and A_Index = 1 and ( Va := Va + StrLen( LIST ) ) ? LIST := "" : "" )
	}
	
	DllCall( "ImageHlp\UnMapAndLoad", "Ptr",&LOADED_IMAGE ),   DllCall( "FreeLibrary", "Ptr",hModule )
	
	Return RTrim( List, "`n" )
}