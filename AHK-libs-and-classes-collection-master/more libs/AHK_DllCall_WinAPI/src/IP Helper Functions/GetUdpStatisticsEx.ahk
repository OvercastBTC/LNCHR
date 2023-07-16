﻿; ===============================================================================================================================
; Function......: GetUdpStatisticsEx
; DLL...........: Iphlpapi.dll
; Library.......: Iphlpapi.lib
; U/ANSI........:
; Author........: jNizM
; Modified......:
; Links.........: https://msdn.microsoft.com/en-us/library/aa366031.aspx
;                 https://msdn.microsoft.com/en-us/library/windows/desktop/aa366031.aspx
; ===============================================================================================================================
GetUdpStatisticsEx()
{
    static IPv4 := 2, IPv6 := 23
    static MIB_UDPSTATS, init := VarSetCapacity(MIB_UDPSTATS, 20, 0) && NumPut(20, MIB_UDPSTATS, "UInt")
    if (DllCall("iphlpapi.dll\GetUdpStatisticsEx", "Ptr", &MIB_UDPSTATS, "UInt", IPv4) != 0)
        return DllCall("kernel32.dll\GetLastError")
    return {  1 : NumGet(MIB_UDPSTATS,  0, "UInt"), 2 : NumGet(MIB_UDPSTATS,  4, "UInt"), 3 : NumGet(MIB_UDPSTATS,  8, "UInt")
           ,  4 : NumGet(MIB_UDPSTATS, 12, "UInt"), 5 : NumGet(MIB_UDPSTATS, 16, "UInt") }
}
; ===============================================================================================================================

GetUdpStatisticsEx := GetUdpStatisticsEx()

MsgBox % "GetUdpStatisticsEx function`n"
       . "MIB_UDPSTATS structure`n`n"
       . "InDatagrams:`t`t"      GetUdpStatisticsEx[1]   "`n"
       . "NoPorts:`t`t`t"        GetUdpStatisticsEx[2]   "`n"
       . "InErrors:`t`t`t"       GetUdpStatisticsEx[3]   "`n"
       . "OutDatagrams:`t`t"     GetUdpStatisticsEx[4]   "`n"
       . "NumAddrs:`t`t"         GetUdpStatisticsEx[5]





/* C++ ==========================================================================================================================
DWORD GetUdpStatisticsEx(                                                            // UInt
    _Out_  PMIB_UDPSTATS pStats,                                                     // Ptr        (20)
    _In_   DWORD dwFamily                                                            // UInt
);


typedef struct _MIB_UDPSTATS {
    DWORD dwInDatagrams;                                                             // UInt        4          =>   0
    DWORD dwNoPorts;                                                                 // UInt        4          =>   4
    DWORD dwInErrors;                                                                // UInt        4          =>   8
    DWORD dwOutDatagrams;                                                            // UInt        4          =>  12
    DWORD dwNumAddrs;                                                                // UInt        4          =>  16
} MIB_UDPSTATS, *PMIB_UDPSTATS;
============================================================================================================================== */