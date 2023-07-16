﻿; ===============================================================================================================================
; Function......: GetIpStatisticsEx
; DLL...........: Iphlpapi.dll
; Library.......: Iphlpapi.lib
; U/ANSI........:
; Author........: jNizM
; Modified......:
; Links.........: https://msdn.microsoft.com/en-us/library/aa365963.aspx
;                 https://msdn.microsoft.com/en-us/library/windows/desktop/aa365963.aspx
; ===============================================================================================================================
GetIpStatisticsEx()
{
    static IPv4 := 2, IPv6 := 23
    static MIB_IPSTATS, init := VarSetCapacity(MIB_IPSTATS, 92, 0) && NumPut(92, MIB_IPSTATS, "UInt")
    if (DllCall("iphlpapi.dll\GetIpStatisticsEx", "Ptr", &MIB_IPSTATS, "UInt", IPv4) != 0)
        return DllCall("kernel32.dll\GetLastError")
    return {  1 : NumGet(MIB_IPSTATS,  0, "UInt"),  2 : NumGet(MIB_IPSTATS,  4, "UInt"),  3 : NumGet(MIB_IPSTATS,  8, "UInt")
           ,  4 : NumGet(MIB_IPSTATS, 12, "UInt"),  5 : NumGet(MIB_IPSTATS, 16, "UInt"),  6 : NumGet(MIB_IPSTATS, 20, "UInt")
           ,  7 : NumGet(MIB_IPSTATS, 24, "UInt"),  8 : NumGet(MIB_IPSTATS, 28, "UInt"),  9 : NumGet(MIB_IPSTATS, 32, "UInt")
           , 10 : NumGet(MIB_IPSTATS, 36, "UInt"), 11 : NumGet(MIB_IPSTATS, 40, "UInt"), 12 : NumGet(MIB_IPSTATS, 44, "UInt")
           , 13 : NumGet(MIB_IPSTATS, 48, "UInt"), 14 : NumGet(MIB_IPSTATS, 52, "UInt"), 15 : NumGet(MIB_IPSTATS, 56, "UInt")
           , 16 : NumGet(MIB_IPSTATS, 60, "UInt"), 17 : NumGet(MIB_IPSTATS, 64, "UInt"), 18 : NumGet(MIB_IPSTATS, 68, "UInt")
           , 19 : NumGet(MIB_IPSTATS, 72, "UInt"), 20 : NumGet(MIB_IPSTATS, 76, "UInt"), 21 : NumGet(MIB_IPSTATS, 80, "UInt")
           , 22 : NumGet(MIB_IPSTATS, 84, "UInt"), 23 : NumGet(MIB_IPSTATS, 88, "UInt") }
}
; ===============================================================================================================================

GetIpStatisticsEx := GetIpStatisticsEx()

MsgBox % "GetIpStatistics function`n"
       . "MIB_IPSTATS structure`n`n"
       . "Forwarding:`t`t"          GetIpStatisticsEx[1]    "`n"
       . "DefaultTTL:`t`t"          GetIpStatisticsEx[2]    "`n"
       . "InReceives:`t`t"          GetIpStatisticsEx[3]    "`n"
       . "InHdrErrors:`t`t"         GetIpStatisticsEx[4]    "`n"
       . "InAddrErrors:`t`t"        GetIpStatisticsEx[5]    "`n"
       . "ForwDatagrams:`t`t"       GetIpStatisticsEx[6]    "`n"
       . "InUnknownProtos:`t`t"     GetIpStatisticsEx[7]    "`n"
       . "InDiscards:`t`t"          GetIpStatisticsEx[8]    "`n"
       . "InDelivers:`t`t`t"        GetIpStatisticsEx[9]    "`n"
       . "OutRequests:`t`t"         GetIpStatisticsEx[10]   "`n"
       . "RoutingDiscards:`t`t"     GetIpStatisticsEx[11]   "`n"
       . "OutDiscards:`t`t"         GetIpStatisticsEx[12]   "`n"
       . "OutNoRoutes:`t`t"         GetIpStatisticsEx[13]   "`n"
       . "ReasmTimeout:`t`t"        GetIpStatisticsEx[14]   "`n"
       . "ReasmReqds:`t`t"          GetIpStatisticsEx[15]   "`n"
       . "ReasmOks:`t`t"            GetIpStatisticsEx[16]   "`n"
       . "ReasmFails:`t`t"          GetIpStatisticsEx[17]   "`n"
       . "FragOks:`t`t`t"           GetIpStatisticsEx[18]   "`n"
       . "FragFails:`t`t`t"         GetIpStatisticsEx[19]   "`n"
       . "FragCreates:`t`t"         GetIpStatisticsEx[20]   "`n"
       . "NumIf:`t`t`t"             GetIpStatisticsEx[21]   "`n"
       . "NumAddr:`t`t"             GetIpStatisticsEx[22]   "`n"
       . "NumRoutes:`t`t"           GetIpStatisticsEx[23]





/* C++ ==========================================================================================================================
DWORD GetIpStatisticsEx(                                                             // UInt
    _Out_  PMIB_IPSTATS pStats,                                                      // Ptr        (92)
    _In_   DWORD dwFamily                                                            // UInt
);


typedef struct _MIB_IPSTATS {
    DWORD dwForwarding;                                                              // UInt        4          =>   0
    DWORD dwDefaultTTL;                                                              // UInt        4          =>   4
    DWORD dwInReceives;                                                              // UInt        4          =>   8
    DWORD dwInHdrErrors;                                                             // UInt        4          =>  12
    DWORD dwInAddrErrors;                                                            // UInt        4          =>  16
    DWORD dwForwDatagrams;                                                           // UInt        4          =>  20
    DWORD dwInUnknownProtos;                                                         // UInt        4          =>  24
    DWORD dwInDiscards;                                                              // UInt        4          =>  28
    DWORD dwInDelivers;                                                              // UInt        4          =>  32
    DWORD dwOutRequests;                                                             // UInt        4          =>  36
    DWORD dwRoutingDiscards;                                                         // UInt        4          =>  40
    DWORD dwOutDiscards;                                                             // UInt        4          =>  44
    DWORD dwOutNoRoutes;                                                             // UInt        4          =>  48
    DWORD dwReasmTimeout;                                                            // UInt        4          =>  52
    DWORD dwReasmReqds;                                                              // UInt        4          =>  56
    DWORD dwReasmOks;                                                                // UInt        4          =>  60
    DWORD dwReasmFails;                                                              // UInt        4          =>  64
    DWORD dwFragOks;                                                                 // UInt        4          =>  68
    DWORD dwFragFails;                                                               // UInt        4          =>  72
    DWORD dwFragCreates;                                                             // UInt        4          =>  76
    DWORD dwNumIf;                                                                   // UInt        4          =>  80
    DWORD dwNumAddr;                                                                 // UInt        4          =>  84
    DWORD dwNumRoutes;                                                               // UInt        4          =>  88
} MIB_IPSTATS, *PMIB_IPSTATS;
============================================================================================================================== */