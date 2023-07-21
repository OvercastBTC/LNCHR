#NoEnv
#Persistent
#SingleInstance, Force

DetectHiddenWindows, on
SetTitleMatchMode, 2


;if(not A_IsAdmin)
;{
	;run *RunAs "%A_ScriptFullPath%"
	;ExitApp
;}

scriptpaths := []
pathnum =5
num=pathnum

path1 := A_ScriptDir "/codecompleter.ahk"
path2 := A_ScriptDir "/httpserver.ahk"
path3 := A_ScriptDir "/rsjukebox.ahk"
path4 := A_ScriptDir "/test.ahk"
path5 := A_ScriptDir "/logs_and_generalHKs.ahk"
path6 := A_ScriptDir "/youtubedl.ahk"
path7 := A_ScriptDir "/comnavigate.ahk"
path8 := A_ScriptDir "/counter.ahk"
;~ path9 := A_ScriptDir "/wordlookup.ahk"
path10 := A_ScriptDir "/GUIsearch/Host.ahk"
path11 := A_ScriptDir "/MoveInactiveWin/MoveInactiveWin.ahk"
path12 := A_ScriptDir "/Captain/Captain.ahk"
;~ path13 := A_ScriptDir "/networkanddrivescheck.ahk"
path14 := A_ScriptDir "/animatedgif/makinggifs.ahk"
path15 := A_ScriptDir "/fileExplorer/ExplorerGetPathsMenu.ahk"
;path16 := A_ScriptDir "/mystopwatch.ahk"
path17 := A_ScriptDir "/animatedgif/animatedGIF.ahk"
path18 := A_ScriptDir "/activateprograms.ahk"
path19 := A_ScriptDir "/spleeter/GUIExtractVocalsOrMusic.ahk"



scriptpaths.InsertAt(1, path1)
scriptpaths.InsertAt(2, path2)
scriptpaths.InsertAt(3, path3)
scriptpaths.InsertAt(4, path4)
scriptpaths.InsertAt(scriptpaths.Length() +1, path5)
scriptpaths.InsertAt(scriptpaths.Length() +1, path6)
scriptpaths.InsertAt(scriptpaths.Length() +1, path7)
scriptpaths.InsertAt(scriptpaths.Length() +1, path8)
;~ scriptpaths.InsertAt(scriptpaths.Length() +1, path9)
scriptpaths.InsertAt(scriptpaths.Length() +1, path10)
scriptpaths.InsertAt(scriptpaths.Length() +1, path11)
scriptpaths.InsertAt(scriptpaths.Length() +1, path12)
;~ scriptpaths.InsertAt(scriptpaths.Length() +1, path13)
scriptpaths.InsertAt(scriptpaths.Length() +1, path14)
scriptpaths.InsertAt(scriptpaths.Length() +1, path15)
;scriptpaths.InsertAt(scriptpaths.Length() +1, path16)
scriptpaths.InsertAt(scriptpaths.Length() +1, path17)
scriptpaths.InsertAt(scriptpaths.Length() +1, path18)
scriptpaths.InsertAt(scriptpaths.Length() +1, path19)


:*:master_run::
for index, element in scriptpaths
{
	run %element% 
}

return
:*:master_reload::


WinGet, List, List, ahk_class AutoHotkey 

Loop %List% 
  { 
    WinGet, PID, PID, % "ahk_id " List%A_Index% 
    If ( PID <> DllCall("GetCurrentProcessId") ) 
         PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index% 
}
return