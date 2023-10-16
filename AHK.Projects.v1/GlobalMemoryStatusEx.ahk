#Requires AutoHotkey v1.1+

; ===============================================================================================================================
; Function......: GlobalMemoryStatusEx
; DLL...........: Kernel32.dll
; Library.......: Kernel32.lib
; U/ANSI........:
; Author........: jNizM
; Modified......:
; Links.........: https://msdn.microsoft.com/en-us/library/aa366589.aspx
;                 https://msdn.microsoft.com/en-us/library/windows/desktop/aa366589.aspx
; ===============================================================================================================================
GlobalMemoryStatusEx(GMS = 1) {
    VarSetCapacity(MEMORYSTATUSEX, 64, 0)
    NumPut(64, MEMORYSTATUSEX)
    DllCall("GlobalMemoryStatusEx", "ptr", &MEMORYSTATUSEX)
    return, % (GMS = "0") ? NumGet(MEMORYSTATUSEX, 0, "Int")
            : (GMS = "1") ? NumGet(MEMORYSTATUSEX, 4, "Int")
            : (GMS = "2") ? Round((NumGet(MEMORYSTATUSEX,  8, "Int64") / 1024**2), 2)
            : (GMS = "3") ? Round((NumGet(MEMORYSTATUSEX, 16, "Int64") / 1024**2), 2)
            : (GMS = "4") ? Round((NumGet(MEMORYSTATUSEX, 24, "Int64") / 1024**2), 2)
            : (GMS = "5") ? Round((NumGet(MEMORYSTATUSEX, 32, "Int64") / 1024**2), 2)
            : (GMS = "6") ? Round((NumGet(MEMORYSTATUSEX, 40, "Int64") / 1024**2), 2)
            : (GMS = "7") ? Round((NumGet(MEMORYSTATUSEX, 48, "Int64") / 1024**2), 2)
            : (GMS = "8") ? NumGet(MEMORYSTATUSEX, 56, "Int")
            : "FAIL"
}

MsgBox, 48, GlobalMemoryStatusEx, % "GlobalMemoryStatusEx function /`n"
        . "MEMORYSTATUSEX structure`n`n"
        . "Length:`t`t`t"				GlobalMemoryStatusEx(0)  "`n`n"
        . "MemoryLoad:`t`t"				GlobalMemoryStatusEx(1)  " %`n`n"
        . "TotalPhys:`t`t"				GetNumberFormatEx(GlobalMemoryStatusEx(2))  " MB`n"
        . "AvailPhys:`t`t"				GetNumberFormatEx(GlobalMemoryStatusEx(3))  " MB`n`n"
        . "TotalPageFile:`t`t"			GetNumberFormatEx(GlobalMemoryStatusEx(4))  " MB`n"
        . "AvailPageFile:`t`t"			GetNumberFormatEx(GlobalMemoryStatusEx(5))  " MB`n`n"
        . "TotalVirtual:`t`t"			GetNumberFormatEx(GlobalMemoryStatusEx(6))  " MB`n"
        . "AvailVirtual:`t`t"			GetNumberFormatEx(GlobalMemoryStatusEx(7))  " MB`n`n"
        . "AvailExtendedVirtual:`t"		GetNumberFormatEx(GlobalMemoryStatusEx(8))  " MB`n"





/* C++ ==========================================================================================================================
BOOL WINAPI GlobalMemoryStatusEx(                                                    // UInt
    _Inout_  LPMEMORYSTATUSEX lpBuffer                                               // Ptr        (64)
);


typedef struct _MEMORYSTATUSEX {
    DWORD     dwLength;                                                              // UInt        4          =>   0
    DWORD     dwMemoryLoad;                                                          // UInt        4          =>   4
    DWORDLONG ullTotalPhys;                                                          // UInt64      8          =>   8
    DWORDLONG ullAvailPhys;                                                          // UInt64      8          =>  16
    DWORDLONG ullTotalPageFile;                                                      // UInt64      8          =>  24
    DWORDLONG ullAvailPageFile;                                                      // UInt64      8          =>  32
    DWORDLONG ullTotalVirtual;                                                       // UInt64      8          =>  40
    DWORDLONG ullAvailVirtual;                                                       // UInt64      8          =>  48
    DWORDLONG ullAvailExtendedVirtual;                                               // UInt64      8          =>  56
} MEMORYSTATUSEX, *LPMEMORYSTATUSEX;
============================================================================================================================== 
*/

; ===============================================================================================================================
; Function ...: GetNumberFormatEx
; Return .....: Formats a number string as a number string customized for a locale specified by name.
; Link .......: https://docs.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-getnumberformatex
; ===============================================================================================================================

GetNumberFormatEx(Value, LocaleName := "!x-sys-default-locale")
{
	if (Size := DllCall("GetNumberFormatEx", "str", LocaleName, "uint", 0, "str", Value, "ptr", 0, "ptr", 0, "int", 0)) {
		VarSetCapacity(NumberStr, Size << !!A_IsUnicode, 0)
		if (DllCall("GetNumberFormatEx", "str", LocaleName, "uint", 0, "str", Value, "ptr", 0, "str", NumberStr, "int", Size))
			return NumberStr
	}
	return false
}

; ===============================================================================================================================

; MsgBox % GetNumberFormatEx(1149.99)                        ; -> 1.149,99         ( LANG_USER_DEFAULT | SUBLANG_DEFAULT    )
; MsgBox % GetNumberFormatEx(1149.99, "en-US")               ; -> 1,149.99         ( LANG_ENGLISH      | SUBLANG_ENGLISH_US )
; MsgBox % GetNumberFormatEx(1149.99, "en-GB")               ; -> 1,149.99         ( LANG_ENGLISH      | SUBLANG_ENGLISH_US )
; MsgBox % GetNumberFormatEx(1149.99, "de-DE")               ; -> 1.149,99         ( LANG_GERMAN       | SUBLANG_GERMAN     )