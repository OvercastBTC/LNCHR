;============================== Start Auto-Execution Section ==============================
; #Warn  ; Enable warnings to assist with detecting common errors.
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
;#SingleInstance,Force
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
;SetWinDelay, -1
;SetControlDelay, -1
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;============================== Group Section ==============================
;GroupAdd, saveReload, %A_ScriptName%
;GroupAdd, AllWindows,,,,hznhorizon.exe
;GroupAdd, horizon, hznhorizon.exe
;============================== End Auto-Execution Section ================================
;#+^i:
#Include GUI_Options.ahk

Gui, 1:New, ,Select Site Name
Gui, Add, ListBox, vListBox_ClList gSelect x16 y10 w370 h125

BasePath:= "C:\Users\bacona\OneDrive - FM Global\1. Sites\"
FileList:= ""
loop, Files, % BasePath "*.*", D
	FileList .= A_LoopFileFullPath "|"
FileList := RTrim(FileList, "|")
Sort, FileList, D|
FileList := StrReplace(FileList, BasePath)
GuiControl,, ListBox_ClList, %FileList% 
Gui, Show
return

Select:
if (A_GuiEvent = "DoubleClick") {
	GuiControlGet, Selection,, ListBox_ClList
	ToolTip, % Selection
}
Return
Site:= % Selection
acc = 4

SiteNameINI:= % Site ".ini"
if not (FileExist(SiteNameINI)) { ; creates the ini file if it does not exist
	FileAppend,
(
[Design]
Size=11 ft. dia. x 13 ft.
Motor=900 HP
Mill RPM=unk
TPH (Max)=120 TPH
TPH (Used/Avg)=100 TPH
Ring Gear (Cast or Forged)=Cast
Ring Gear Reversable?=unk
Rotation Reversal=N/A

[Motor Design] 
HP=900 hp
RPM=897 rpm
FLA=114 Amps
Voltage=4.16 kV
Phase(s)=3 phases
Freq=60 Hz
Relays (ANSI #s)=P61

[Spares]
Spare=Pinion gears  
Spare=Motor
Spare=ring gear (forged or cast?)
Spare=bearings

[ITM]
Temp Monitoring=Temp gun: every shift
Vib=continuous
NDE=Annual UT (Metzo); tracking/trending cracks (in-progress)
C&SD=Annual

[Ring Gear] 
Visuals=
Walkdown=Shift
Strobe inspection=Shift
Temp gun=Shift
Lube Oil Visual=every shift
IR scan=No. Discussed w/ site and showed examples
Lining=PIN Profile
Lining Inspections=Quarterly, replacements every 24 mo
Slurry racing inspections=
Charge monitoring=via kW

[NDE]
Type=UT
Objects=trunnion (feed and disch.), ring gear, pinion, segment bolts
Indications=Yes
Last performed=4/2023

[Continuous Monitoring]
Vibration=motor
Bearings (Oil Bath)=temperature (motor only)
Bearings (via sump)=temperature, pressure, flow (all other mill bearings)
Ring Gear=

Additional Eqpt Notes:
Note=
Note=
Note=
Note=
Note=
Note=
Note=

[Extra History]
Note=Updated RV to $7.8 M per EVG
Note=
Note=
Note=
Note=
Note=
Note=
), % SiteNameINI ;, utf-16 ; save your ini file asUTF-16LE
}

IniRead, $sections, %$ini%
;MsgBox Sections in %$ini% `n`n %$sections%


Loop, parse, $sections, `n
{
	IniRead, _thisSection, %$ini%, %A_LoopField%
	;MsgBox Section [%A_LoopField%]`n`n%_thisSection%
}

IniRead, var, % SiteNameIni, Logins, Senhas ; reads the value from the ini file specifying its section and the key
oIni:={}
oKeys:={}
IniRead,sectNames,% SiteName
for a,b in oSectNames:=StrSplit(sectNames,"`n","`r")
{	oIni[b]:={}
	IniRead,Section,iniFile.ini,% b
	ddl.=b "|"
	for c,d in StrSplit(Section,"`n","`r")
	{	RegExMatch(d,"^([^=]*?)=(.*)",match)
		if oKeys.HasKey(match1)
			MsgBox,% "Key already exits: """ match1 """"
		else
		{	oKeys[match1]:=match2
			oIni[b,match1]:=match2
		}
	}
}
for a,b in oIni[oSectNames[1]]
	Lb.=a "|"
Gui, Add, DropDownList, x12 y9 w150 r3 Choose1 vvSection ggSelectSect,% SubStr(ddl,1,-1) ; List of Section's
Gui, Add, Button, x172 y9 w90 h20 ggNewTemplate vvNewTemplate, New Template
Gui, Add, Button, x292 y9 w90 h20 ggUpdateTemplate vvUpdateTemplate, Update
Gui, Add, Button, x292 y9 w90 h20 ggSaveTemplate vvSaveTemplate, Save
Gui, Add, Button, x412 y9 w90 h20 ggDeleteTemplate vvDeleteTemplate, Delete
Gui, Add, ListBox, x12 y39 w150 h200 vvLb ggInsertVal,% SubStr(Lb,1,-1) ; List of Keys from Section selected in DropDownList.
Gui, Add, Edit, y39 x12 h20 w150 vvNewKey
Gui, Add, Edit, x172 y39 w340 h200 vvEdit ; Key Value based on Key selected in Listbox.
Gui, Show, w526 h254, Untitled GUI
GuiControl, hide, vNewKey
GuiControl, hide, vSaveTemplate
return

InsertVal:
Gui Submit, NoHide
GuiControl,,vEdit,% oKeys[vLb]
return

SelectSect:
Gui Submit, NoHide
Lb:="|"
for a,b in oIni[vSection]
	Lb.=a "|"
GuiControl,,vLb,% SubStr(Lb,1,-1)
return

NewTemplate:
if hide {
	GuiControl, Show, vLb
	GuiControl, hide, vNewKey
	GuiControl,,vEdit,% oKeys[vLb]
	GuiControl,,vNewTemplate, New Template
	GuiControl, Show, vUpdateTemplate	
	GuiControl, Hide, vSaveTemplate
	GuiControl, Show, vDeleteTemplate
}
else {
	GuiControl, Hide, vLb
	GuiControl, show, vNewKey
	GuiControl,,vEdit
	GuiControl,,vNewTemplate, Template list
	GuiControl, hide, vUpdateTemplate	
	GuiControl, Show, vSaveTemplate
	GuiControl, Hide, vDeleteTemplate
}
hide:=not hide
return

UpdateTemplate:
Gui, Submit, NoHide
MsgBox, 1,Update Template?, Template: %vLb%`n%vEdit%
IfMsgBox OK
	MsgBox You pressed OK.
else
	MsgBox You pressed Cancel.
return

SaveTemplate:
Gui, Submit, NoHide
MsgBox, 1,Save Template?, Category: %vSection%`nKey: %vNewKey%`n%vEdit%
IfMsgBox OK
	MsgBox You pressed OK.
else
	MsgBox You pressed Cancel.
return

DeleteTemplate:
Gui, Submit, NoHide
MsgBox, 4,Delete Template?, Are you sure you want to delete template: %vLb%?
IfMsgBox Yes
	MsgBox You pressed Yes.
else
	MsgBox You pressed No.
return

;GuiClose:
;ExitApp

;Gui, Destroy
;Gui, Add, Edit, x8 w400 r2 vLocalPath gLocalEnter -VScroll, C:\		; Create 2 line edit control and remove the vscroll (enter does not work in a 1 line edit control)
;GuiControl, Move, LocalPath, h20									; Resize it to appear to be a 1 line edit control
;Gui, Add, Button, x+6 yp w50 gLocalButton, Local
;Gui, Add, Button, xp yp+25 w50 gLocalBack, Back
;Gui, Add, DropDownList, vLocalDDL AltSubmit x8 yp w400 gLocalDDLSub
;Gui, Add, ActiveX, xm w400 h400 vWBLocal, Shell.Explorer
;ComObjConnect(WBLocal, WBLocal_events)  ; Connect WBLocal's events to the WBLocal_events class object.
;WBLocal.Navigate("C:\Users\bacona\OneDrive - FM Global\1. Sites\")

;Gui, Add, Edit, x480 y7 w400 r2 vRemotePath gRemoteEnter -VScroll
;GuiControl, Move, RemotePath, h20
;Gui, Add, Button, x+6 yp w50 gRemoteButton, Remote
;Gui, Add, Button, xp yp+25 w50 gRemoteBack, Back
;Gui, Add, DropDownList, vRemoteDDL AltSubmit x480 yp w400 gRemoteDDLSub
;Gui, Add, ActiveX, x480 yp+25 w400 h400 vWBRemote, Shell.Explorer
;ComObjConnect(WBRemote, WBRemote_events)

;Gui, Show
;Return

;LocalEnter:
;Gui Submit, NoHide
;if LocalPath contains `n						; Check to see if enter was pressed, otherwise do nothing
;{
	;StringReplace, LocalPath, LocalPath, `n,,	; Remove the newline character
	;GuiControl,, LocalPath, %LocalPath%		; Update the edit control
	;SubmitPathFunction(LocalPath,WBLocal)		; Submit the path
	;varini:= "*.ini"	
	;Loop, %LocalPath% *ini,1,1 ; checks folder + subfolders
	;{ ; little info bot (you can remove it if you don't need it). It will show you the current path (since there can be many pdfs).
		;GuiControl, +Redraw, A
		;MsgBox,4,, %A_LoopFileFullPath%
		
		;IfMsgBox Yes ; press yes to choose the path and run the pdf 
		;{
			;Run, %A_LoopFileFullPath%
			;return
		;} ; else it will just loop on
	;}
	;return
	
;}
;return

;RemoteEnter:
;Gui Submit, NoHide
;if RemotePath contains `n
;{
	;StringReplace, RemotePath, RemotePath, `n,,
	;GuiControl,, RemotePath, %RemotePath%
	;SubmitPathFunction(RemotePath,WBRemote)
;}
;return

;LocalButton:
;Gui Submit, NoHide
;SubmitPathFunction(LocalPath,WBLocal)
;return

;RemoteButton:
;Gui Submit, NoHide
;SubmitPathFunction(RemotePath,WBRemote)
;return

;LocalBack:
;BackFunction(LocalFolderArray,WBLocal)
;Return

;RemoteBack:
;BackFunction(RemoteFolderArray,WBRemote)
;Return

;UpdateLocalDDL:
;Gui, Submit, NoHide
;GetArrayFunction(LocalPath)									; Create an array from LocalPath
;LocalFolderArray := FolderArray								; Assign the array to LocalFolderArray

;GuiControl,, LocalDDL, |									; Clear LocalDDL
;Loop % LocalFolderArray.MaxIndex()							; Recreate LocalDDL from LocalFolderArray
;GuiControl,, LocalDDL, % LocalFolderArray[a_index]
;GuiControl, Choose, LocalDDL, % LocalFolderArray.MaxIndex()	; Choose the last item in LocalDDL
;Return

;UpdateRemoteDDL:
;Gui, Submit, NoHide
;GetArrayFunction(RemotePath)
;RemoteFolderArray := FolderArray

;GuiControl,, RemoteDDL, |
;Loop % RemoteFolderArray.MaxIndex()
;GuiControl,, RemoteDDL, % RemoteFolderArray[a_index]
;GuiControl, Choose, RemoteDDL, % RemoteFolderArray.MaxIndex()
;Return

;LocalDDLSub:
;Gui, Submit, NoHide
;NewLocalDDLPath =										; Clear NewLocalDDLPath
;Loop, %LocalDDL%										; If you selected the 3rd item in the DropDownList, it will loop 3 times
;{
	;NewLocalDDLPath .= LocalFolderArray[a_index] "\"	; Get the new path adding "\" between each item in the array
;}
;WBLocal.Navigate(NewLocalDDLPath)						; Navigate to the new path
;Return

;RemoteDDLSub:
;Gui, Submit, NoHide
;NewRemoteDDLPath =
;Loop, %RemoteDDL%
;{
	;NewRemoteDDLPath .= RemoteFolderArray[a_index] "\"
;}
;WBRemote.Navigate(NewRemoteDDLPath)
;Return

;GuiClose:
;ExitApp

;class WBLocal_events
;{
	;NavigateComplete2(WBLocal, NewLocalPath)
	;{
		;GuiControl,, LocalPath, %NewLocalPath%  ; Update the LocalPath edit control.
		;Send, {end}								; Move the cursor to the right in the edit control
		;Gosub, UpdateLocalDDL					; You always want to update the DDL after the path has changed
	;}
;}

;class WBRemote_events
;{
	;NavigateComplete2(WBRemote, NewRemotePath)
	;{
		;GuiControl,, RemotePath, %NewRemotePath%
		;Send, {end}
		;Gosub, UpdateRemoteDDL
	;}
;}

;SubmitPathFunction(NewPath,WBLocation)
;{
	;StringReplace, NewPath, NewPath,/,\, All				; Replace "/" with "\" to reduce path issues
	;If SubStr(NewPath, 1, 2) = "\\"							; Check to see if the first 2 characters are "\\"
	;StringReplace, NewPath, NewPath,\\,??,				; If so, change them to "??" to protect them from the next replace
	;Loop
	;{
		;StringReplace, NewPath, NewPath,\\,\, UseErrorLevel	; Replace "\\" with "\" to reduce path issues
		;if ErrorLevel = 0									; Loop until all occurances have been replaced
		;Break
	;}
	;StringReplace, NewPath, NewPath,?,\, All				; Replace "?" with "\" to restore beginning path
	;If SubStr(NewPath, 0, 1) = ":"							; Check to see if ":" is the last (right-most) character
	;NewPath := NewPath "\"								; If so, append a "\" to the end.  This prevents entering "C:" to error the script
	;IfNotExist %NewPath%									; #### Added to prevent internet access ####
	;{														; IfNotExist only works on folders and files, NOT on URL's
		;msgbox, 262208, Invalid Path,%NewPath% is not a valid path!!
		;Send, {end}
		;Return
	;}
	;WBLocation.Navigate(NewPath)						; Navigate to the new path
;}

;BackFunction(BackFolderArray,WBLocation)
;{
	;If BackFolderArray.MaxIndex() < 2					; If number of items in the array is less than 2, do nothing
	;Return
	;BackPathIndex := BackFolderArray.MaxIndex() - 1		; Subtract 1 from number of items in the array (to go back 1)
	;BackPath =											; Clear BackPath variable
	;Loop, %BackPathIndex%								; Loop to create new path
	;{
		;BackPath .= BackFolderArray[a_index] "\"		; Get the new path adding "\" between each item in the array
	;}
	;WBLocation.Navigate(BackPath)						; Navigate to the new path
;}

GetArrayFunction(Path)
{
	Global FolderArray
	FolderArray :=											; Clear FolderArray array
	StringReplace, Path, Path,\\,//,						; Replace "\\" with "//" so they are not used in StrSplit function
	
	FolderArray := StrSplit(Path, "\")						; Take the path and split it using "\" as delimiter to create an array
	If InStr(FolderArray[1], "//")							; If first element contains "//" assume it is a remote computer
	{														; If it is a remote computer combine 1st and 2nd elements (\\OtherSystem\c$)
		FirstFolder := FolderArray[1]						; Create a temporary variable
		StringReplace, FirstFolder, FirstFolder,//,\\,		; Change "//" back to "\\"
		FolderArray[1] := FirstFolder						; Write it back to the first element in the array
		FolderArray[1] := FolderArray[1] "\" FolderArray[2]	; Combine 1st element with 2nd element with "\" between them
		FolderArray.Remove(2)								; Remove the 2nd element
	}
	
	FolderCount := FolderArray.MaxIndex()					; Create a temporary variable
	TempFolder := FolderArray[FolderCount]					; Create a temporary variable
	If TempFolder =
		FolderArray.Remove(FolderCount)						; If the last element in the array is empty, remove it
}
return
Result := ChooseFile( [0, "Dialog title - ChooseFile.."]
                     , A_ComSpec
                     , {All: "`n*.*", Music: "*.mp3", Images: "`n*.jpg;*.png", Videos: "*.avi;*.mp4;*.mkv;*.wmp", Documents: "*.txt"}
                     , [A_WinDir,A_Desktop,A_Temp,A_Startup,A_ProgramFiles]
                     , 0x10000000 | 0x02000000 | 0x00000200 | 0x00001000 )
If ((List := "") == "" && Result != FALSE)
	For Each, File in Result.FileFullPath
		List .= File . "`n"
MsgBox % "You Chose Filter: " Result.FilterIndex "`n" List
ExitApp

; FUNCTIONS

DirExist(DirName)
{
	loop Files, % DirName, D
		return A_LoopFileAttrib
}
StrPutVar(string, ByRef var, encoding)
{
	; Ensure capacity.
	VarSetCapacity( var, StrPut(string, encoding)
	; StrPut returns char count, but VarSetCapacity needs bytes.
	* ((encoding="utf-16"||encoding="cp1200") ? 2 : 1) )
	; Copy or convert the string.
	return StrPut(string, &var, encoding)
} ; https://www.autohotkey.com/docs/commands/StrPut.htm#Examples

/*
	Displays a standard dialog that allows the user to open file(s).
	Parameters:
	Owner / Title:
	The identifier of the window that owns this dialog. This value can be zero.
	An Array with the identifier of the owner window and the title. If the title is an empty string, it is set to the default.
	FileName:
	The path to the file or directory selected by default. If you specify a directory, it must end with a backslash.
	Filter:
	Specify a file filter. You must specify an object, each key represents the description and the value the file types.
	To specify the filter selected by default, add the "`n" character to the value.
	CustomPlaces:
	Specify an Array with the custom directories that will be displayed in the left pane. Missing directories will be omitted.
	To specify the location in the list, specify an Array with the directory and its location (0 = Lower, 1 = Upper).
	Options:
	Determines the behavior of the dialog. This parameter must be one or more of the following values.
	0x00000200 (FOS_ALLOWMULTISELECT) = Enables the user to select multiple items in the open dialog.
	0x00001000    (FOS_FILEMUSTEXIST) = The item returned must exist.
	0x00040000 (FOS_HIDEPINNEDPLACES) = Hide items shown by default in the view's navigation pane.
	0x02000000  (FOS_DONTADDTORECENT) = Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
	0x10000000  (FOS_FORCESHOWHIDDEN) = Include hidden and system items.
	You can check all available values ​​at https://msdn.microsoft.com/en-us/library/windows/desktop/dn457282(v=vs.85).aspx.
	Return:
	Returns 0 if the user canceled the dialog, otherwise returns the path of the selected file.
	If you specified the FOS_ALLOWMULTISELECT option and the function succeeded, it returns an Array with the path of the selected files.
*/
ChooseFile(Owner, FileName := "", Filter := "", CustomPlaces := "", Options := 0x1000)
{
	; IFileOpenDialog interface
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775834(v=vs.85).aspx
	local IFileOpenDialog := ComObjCreate("{DC1C5A9C-E88A-4DDE-A5A1-60F82A20AEF7}", "{D57C7288-D4AD-4768-BE02-9D969532D960}")
        ,           Title := IsObject(Owner) ? Owner[2] . "" : ""
        ,           Flags := Options     ; FILEOPENDIALOGOPTIONS enumeration (https://msdn.microsoft.com/en-us/library/windows/desktop/dn457282(v=vs.85).aspx)
        ,      IShellItem := PIDL := 0   ; PIDL recibe la dirección de memoria a la estructura ITEMIDLIST que debe ser liberada con la función CoTaskMemFree
        ,             Obj := {COMDLG_FILTERSPEC: ""}, foo := bar := ""
        ,       Directory := FileName
	Owner := IsObject(Owner) ? Owner[1] : (WinExist("ahk_id" . Owner) ? Owner : 0)
	Filter := IsObject(Filter) ? Filter : {"All files": "*.*"}
	
	
	if ( FileName != "" )
	{
		if ( InStr(FileName, "\") )
		{
			if !( FileName ~= "\\$" )    ; si «FileName» termina con "\" se trata de una carpeta
			{
				local File := ""
				SplitPath FileName, File, Directory
				; IFileDialog::SetFileName
				; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775974(v=vs.85).aspx
				StrPutVar(File, FileW, "UTF-16")
				DllCall(NumGet(NumGet(IFileOpenDialog+0)+15*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", &FileW)
			}
			
			while ( InStr(Directory,"\") && !DirExist(Directory) )                   ; si el directorio no existe buscamos directorios superiores
				Directory := SubStr(Directory, 1, InStr(Directory, "\",, -1) - 1)    ; recupera el directorio superior
			if ( DirExist(Directory) )
			{
				StrPutVar(Directory, DirectoryW, "UTF-16")
				DllCall("Shell32.dll\SHParseDisplayName", "UPtr", &DirectoryW, "Ptr", 0, "UPtrP", PIDL, "UInt", 0, "UInt", 0)
				DllCall("Shell32.dll\SHCreateShellItem", "Ptr", 0, "Ptr", 0, "UPtr", PIDL, "UPtrP", IShellItem)
				ObjRawSet(Obj, IShellItem, PIDL)
				; IFileDialog::SetFolder method
				; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761828(v=vs.85).aspx
				DllCall(NumGet(NumGet(IFileOpenDialog+0)+12*A_PtrSize), "Ptr", IFileOpenDialog, "UPtr", IShellItem)
			}
		}
		else
		{
			StrPutVar(FileName, FileNameW, "UTF-16")
			DllCall(NumGet(NumGet(IFileOpenDialog+0)+15*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", &FileNameW)
		}
	}
	
	
	; COMDLG_FILTERSPEC structure
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb773221(v=vs.85).aspx
	local Description := "", FileTypes := "", FileTypeIndex := 1
	ObjSetCapacity(Obj, "COMDLG_FILTERSPEC", 2*Filter.Count() * A_PtrSize)
	for Description, FileTypes in Filter
	{
		FileTypeIndex := InStr(FileTypes,"`n") ? A_Index : FileTypeIndex
		StrPutVar(Trim(Description), desc_%A_Index%, "UTF-16")
		StrPutVar(Trim(StrReplace(FileTypes,"`n")), ft_%A_Index%, "UTF-16")
		NumPut(&desc_%A_Index%, ObjGetAddress(Obj,"COMDLG_FILTERSPEC") + A_PtrSize * 2*(A_Index-1))        ; COMDLG_FILTERSPEC.pszName
		NumPut(&ft_%A_Index%, ObjGetAddress(Obj,"COMDLG_FILTERSPEC") + A_PtrSize * (2*(A_Index-1)+1))    ; COMDLG_FILTERSPEC.pszSpec
	}
	
	; IFileDialog::SetFileTypes method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775980(v=vs.85).aspx
	DllCall(NumGet(NumGet(IFileOpenDialog+0)+4*A_PtrSize), "UPtr", IFileOpenDialog, "UInt", Filter.Count(), "UPtr", ObjGetAddress(Obj,"COMDLG_FILTERSPEC"))
	
	; IFileDialog::SetFileTypeIndex method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775978(v=vs.85).aspx
	DllCall(NumGet(NumGet(IFileOpenDialog+0)+5*A_PtrSize), "UPtr", IFileOpenDialog, "UInt", FileTypeIndex)
	
	
	if ( IsObject(CustomPlaces := IsObject(CustomPlaces) || CustomPlaces == "" ? CustomPlaces : [CustomPlaces]) )
	{
		for foo, Directory in CustomPlaces    ; foo = index
		{
			foo := IsObject(Directory) ? Directory[2] : 0    ; FDAP enumeration (https://msdn.microsoft.com/en-us/library/windows/desktop/bb762502(v=vs.85).aspx)
			if ( DirExist(Directory := IsObject(Directory) ? Directory[1] : Directory) )
			{
				StrPutVar(Directory, DirectoryW, "UTF-16")
				DllCall("Shell32.dll\SHParseDisplayName", "UPtr", &DirectoryW, "Ptr", 0, "UPtrP", PIDL, "UInt", 0, "UInt", 0)
				DllCall("Shell32.dll\SHCreateShellItem", "Ptr", 0, "Ptr", 0, "UPtr", PIDL, "UPtrP", IShellItem)
				ObjRawSet(Obj, IShellItem, PIDL)
				; IFileDialog::AddPlace method
				; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775946(v=vs.85).aspx
				DllCall(NumGet(NumGet(IFileOpenDialog+0)+21*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", IShellItem, "UInt", foo)
			}
		}
	}
	
	
	; IFileDialog::SetTitle method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761834(v=vs.85).aspx
	StrPutVar(Title, TitleW, "UTF-16")
	DllCall(NumGet(NumGet(IFileOpenDialog+0)+17*A_PtrSize), "UPtr", IFileOpenDialog, "UPtr", Title == "" ? 0 : &TitleW)
	
	; IFileDialog::SetOptions method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761832(v=vs.85).aspx
	DllCall(NumGet(NumGet(IFileOpenDialog+0)+9*A_PtrSize), "UPtr", IFileOpenDialog, "UInt", Flags)
	
	
	; IModalWindow::Show method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761688(v=vs.85).aspx
	local Result := []
	if ( !DllCall(NumGet(NumGet(IFileOpenDialog+0)+3*A_PtrSize), "UPtr", IFileOpenDialog, "Ptr", Owner, "UInt") )
	{
		; IFileOpenDialog::GetResults method
		; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775831(v=vs.85).aspx
		local IShellItemArray := 0    ; IShellItemArray interface (https://msdn.microsoft.com/en-us/library/windows/desktop/bb761106(v=vs.85).aspx)
		DllCall(NumGet(NumGet(IFileOpenDialog+0)+27*A_PtrSize), "UPtr", IFileOpenDialog, "UPtrP", IShellItemArray)
		
		; IShellItemArray::GetCount method
		; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761098(v=vs.85).aspx
		local Count := 0    ; pdwNumItems
		DllCall(NumGet(NumGet(IShellItemArray+0)+7*A_PtrSize), "UPtr", IShellItemArray, "UIntP", Count, "UInt")
		
		local Buffer := ""
		loop % 0*VarSetCapacity(Buffer,32767 * 2) + Count
		{
			; IShellItemArray::GetItemAt method
			; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761100(v=vs.85).aspx
			DllCall(NumGet(NumGet(IShellItemArray+0)+8*A_PtrSize), "UPtr", IShellItemArray, "UInt", A_Index-1, "UPtrP", IShellItem)
			DllCall("Shell32.dll\SHGetIDListFromObject", "UPtr", IShellItem, "UPtrP", PIDL)
			DllCall("Shell32.dll\SHGetPathFromIDListEx", "UPtr", PIDL, "Str", Buffer, "UInt", 32767, "UInt", 0)
			ObjRawSet(Obj, IShellItem, PIDL), ObjPush(Result, StrGet(&Buffer, "UTF-16"))
		}
		
		ObjRelease(IShellItemArray)
	}
	
	; IFileDialog::GetFileTypeIndex method
	; https://msdn.microsoft.com/es-es/bb775958
	DllCall(NumGet(NumGet(IFileOpenDialog+0)+6*A_PtrSize), "UPtr", IFileOpenDialog, "UIntP", FileTypeIndex)
	msgbox %FileTypeIndex%
	
	for foo, bar in Obj    ; foo = IShellItem interface (ptr)  |  bar = PIDL structure (ptr)
		if foo is integer    ; IShellItem?
			ObjRelease(foo), DllCall("Ole32.dll\CoTaskMemFree", "UPtr", bar)
	ObjRelease(IFileOpenDialog)
	
	return ObjLength(Result) ? {FileFullPath:(Options & 0x200 ? Result : Result[1]),FilterIndex:FileTypeIndex} : FALSE
}
Result := SaveFile( [0, "save the file with your chosen extension"]    ; [owner, title/prompt]
             , ""    ; RootDir\Filename
             , {Text: "*.txt", Document: "`n*.doc", Music: "*.mp3", Video: "*.mp4"}     ; Filter
             , ""    ; CustomPlaces
             , 2)    ; Options ( 2 = FOS_OVERWRITEPROMPT )
MsgBox % "You Chose Filter: " Result.FilterIndex "`n" Result.FileFullPath
ExitApp

; FUNCTIONS
/* DUPLICATED ABOVE
		
	DirExist(DirName)
	{
		loop Files, % DirName, D
			return A_LoopFileAttrib
	}
	StrPutVar(string, ByRef var, encoding)
	{
		; Ensure capacity.
		VarSetCapacity( var, StrPut(string, encoding)
		; StrPut returns char count, but VarSetCapacity needs bytes.
		* ((encoding="utf-16"||encoding="cp1200") ? 2 : 1) )
		; Copy or convert the string.
		return StrPut(string, &var, encoding)
	} ; https://www.autohotkey.com/docs/commands/StrPut.htm#Examples
*/
/*
	Displays a standard dialog that allows the user to save a file.
	Parameters:
	Owner / Title:
	The identifier of the window that owns this dialog. This value can be zero.
	An Array with the identifier of the owner window and the title. If the title is an empty string, it is set to the default.
	FileName:
	The path to the file or directory selected by default. If you specify a directory, it must end with a backslash.
	Filter:
	Specify a file filter. You must specify an object, each key represents the description and the value the file types.
	To specify the filter selected by default, add the "`n" character to the value.
	CustomPlaces:
	Specify an Array with the custom directories that will be displayed in the left pane. Missing directories will be omitted.
	To specify the location in the list, specify an Array with the directory and its location (0 = Lower, 1 = Upper).
	Options:
	Determines the behavior of the dialog. This parameter must be one or more of the following values.
	0x00000002  (FOS_OVERWRITEPROMPT) = When saving a file, prompt before overwriting an existing file of the same name.
	0x00000004  (FOS_STRICTFILETYPES) = Only allow the user to choose a file that has one of the file name extensions specified through Filter.
	0x00040000 (FOS_HIDEPINNEDPLACES) = Hide items shown by default in the view's navigation pane.
	0x10000000  (FOS_FORCESHOWHIDDEN) = Include hidden and system items.
	0x02000000  (FOS_DONTADDTORECENT) = Do not add the item being opened or saved to the recent documents list (SHAddToRecentDocs).
	You can check all available values at https://msdn.microsoft.com/en-us/library/windows/desktop/dn457282(v=vs.85).aspx.
	Return:
	Returns 0 if the user canceled the dialog, otherwise:
	callervariable.File = Chosen File Full Path
	callervariable.FileTypeIndex = index of chosen filter
*/
SaveFile(Owner, FileName := "", Filter := "", CustomPlaces := "", Options := 0x6)
{
	; IFileSaveDialog interface
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775688(v=vs.85).aspx
	local IFileSaveDialog := ComObjCreate("{C0B4E2F3-BA21-4773-8DBA-335EC946EB8B}", "{84BCCD23-5FDE-4CDB-AEA4-AF64B83D78AB}")
        ,           Title := IsObject(Owner) ? Owner[2] . "" : ""
        ,           Flags := Options     ; FILEOPENDIALOGOPTIONS enumeration (https://msdn.microsoft.com/en-us/library/windows/desktop/dn457282(v=vs.85).aspx)
        ,      IShellItem := PIDL := 0   ; PIDL recibe la dirección de memoria a la estructura ITEMIDLIST que debe ser liberada con la función CoTaskMemFree
        ,             Obj := {}, foo := bar := ""
        ,       Directory := FileName
	Owner := IsObject(Owner) ? Owner[1] : (WinExist("ahk_id" . Owner) ? Owner : 0)
	Filter := IsObject(Filter) ? Filter : {"All files": "*.*"}
	
	
	if ( FileName != "" )
	{
		if ( InStr(FileName, "\") )
		{
			if !( FileName ~= "\\$" )    ; si «FileName» termina con "\" se trata de una carpeta
			{
				local File := ""
				SplitPath FileName, File, Directory
				; IFileDialog::SetFileName
				; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775974(v=vs.85).aspx
				StrPutVar(File, FileW, "UTF-16")
				DllCall(NumGet(NumGet(IFileSaveDialog+0)+15*A_PtrSize), "UPtr", IFileSaveDialog, "UPtr", &FileW)
			}
			
			while ( InStr(Directory,"\") && !DirExist(Directory) )                   ; si el directorio no existe buscamos directorios superiores
				Directory := SubStr(Directory, 1, InStr(Directory, "\",, -1) - 1)    ; recupera el directorio superior
			if ( DirExist(Directory) )
			{
				StrPutVar(Directory, DirectoryW, "UTF-16")
				DllCall("Shell32.dll\SHParseDisplayName", "UPtr", &DirectoryW, "Ptr", 0, "UPtrP", PIDL, "UInt", 0, "UInt", 0)
				DllCall("Shell32.dll\SHCreateShellItem", "Ptr", 0, "Ptr", 0, "UPtr", PIDL, "UPtrP", IShellItem)
				ObjRawSet(Obj, IShellItem, PIDL)
				; IFileDialog::SetFolder method
				; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761828(v=vs.85).aspx
				DllCall(NumGet(NumGet(IFileSaveDialog+0)+12*A_PtrSize), "Ptr", IFileSaveDialog, "UPtr", IShellItem)
			}
		}
		else
		{
			StrPutVar(FileName, FileNameW, "UTF-16")
			DllCall(NumGet(NumGet(IFileSaveDialog+0)+15*A_PtrSize), "UPtr", IFileSaveDialog, "UPtr", &FileNameW)
		}
	}
	
	
	; COMDLG_FILTERSPEC structure
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb773221(v=vs.85).aspx
	local Description := "", FileTypes := "", FileTypeIndex := 1
	ObjSetCapacity(Obj, "COMDLG_FILTERSPEC", 2*Filter.Count() * A_PtrSize)
	for Description, FileTypes in Filter
	{
		FileTypeIndex := InStr(FileTypes,"`n") ? A_Index : FileTypeIndex
		StrPutVar(Trim(Description), desc_%A_Index%, "UTF-16")
		StrPutVar(Trim(StrReplace(FileTypes,"`n")), ft_%A_Index%, "UTF-16")
		NumPut(&desc_%A_Index%, ObjGetAddress(Obj,"COMDLG_FILTERSPEC") + A_PtrSize * 2*(A_Index-1))        ; COMDLG_FILTERSPEC.pszName
		NumPut(&ft_%A_Index%, ObjGetAddress(Obj,"COMDLG_FILTERSPEC") + A_PtrSize * (2*(A_Index-1)+1))    ; COMDLG_FILTERSPEC.pszSpec
	}
	
	; IFileDialog::SetFileTypes method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775980(v=vs.85).aspx
	DllCall(NumGet(NumGet(IFileSaveDialog+0)+4*A_PtrSize), "UPtr", IFileSaveDialog, "UInt", Filter.Count(), "UPtr", ObjGetAddress(Obj,"COMDLG_FILTERSPEC"))
	
	; IFileDialog::SetFileTypeIndex method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775978(v=vs.85).aspx
	DllCall(NumGet(NumGet(IFileSaveDialog+0)+5*A_PtrSize), "UPtr", IFileSaveDialog, "UInt", FileTypeIndex)
	
	
	if ( IsObject(CustomPlaces := IsObject(CustomPlaces) || CustomPlaces == "" ? CustomPlaces : [CustomPlaces]) )
	{
		for foo, Directory in CustomPlaces    ; foo = index
		{
			foo := IsObject(Directory) ? Directory[2] : 0    ; FDAP enumeration (https://msdn.microsoft.com/en-us/library/windows/desktop/bb762502(v=vs.85).aspx)
			if ( DirExist(Directory := IsObject(Directory) ? Directory[1] : Directory) )
			{
				StrPutVar(Directory, DirectoryW, "UTF-16")
				DllCall("Shell32.dll\SHParseDisplayName", "UPtr", &DirectoryW, "Ptr", 0, "UPtrP", PIDL, "UInt", 0, "UInt", 0)
				DllCall("Shell32.dll\SHCreateShellItem", "Ptr", 0, "Ptr", 0, "UPtr", PIDL, "UPtrP", IShellItem)
				ObjRawSet(Obj, IShellItem, PIDL)
				; IFileDialog::AddPlace method
				; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775946(v=vs.85).aspx
				DllCall(NumGet(NumGet(IFileSaveDialog+0)+21*A_PtrSize), "UPtr", IFileSaveDialog, "UPtr", IShellItem, "UInt", foo)
			}
		}
	}
	
	
	; IFileDialog::SetTitle method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761834(v=vs.85).aspx
	StrPutVar(Title, TitleW, "UTF-16")
	DllCall(NumGet(NumGet(IFileSaveDialog+0)+17*A_PtrSize), "UPtr", IFileSaveDialog, "UPtr", Title == "" ? 0 : &TitleW)
	
	; IFileDialog::SetOptions method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761832(v=vs.85).aspx
	DllCall(NumGet(NumGet(IFileSaveDialog+0)+9*A_PtrSize), "UPtr", IFileSaveDialog, "UInt", Flags)
	
	
	; IModalWindow::Show method
	; https://msdn.microsoft.com/en-us/library/windows/desktop/bb761688(v=vs.85).aspx
	local Result := FALSE
	if ( !DllCall(NumGet(NumGet(IFileSaveDialog+0)+3*A_PtrSize), "UPtr", IFileSaveDialog, "Ptr", Owner, "UInt") )
	{
		; IFileDialog::GetFileTypeIndex method
		; https://msdn.microsoft.com/es-es/bb775958
		DllCall(NumGet(NumGet(IFileSaveDialog+0)+6*A_PtrSize), "UPtr", IFileSaveDialog, "UIntP", FileTypeIndex)
		
		; IFileDialog::GetResult method
		; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775964(v=vs.85).aspx
		if ( !DllCall(NumGet(NumGet(IFileSaveDialog+0)+20*A_PtrSize), "UPtr", IFileSaveDialog, "UPtrP", IShellItem) )
		{
			VarSetCapacity(Result, 32767 * 2, 0)
			DllCall("Shell32.dll\SHGetIDListFromObject", "UPtr", IShellItem, "UPtrP", PIDL)
			DllCall("Shell32.dll\SHGetPathFromIDListEx", "UPtr", PIDL, "Str", Result, "UInt", 2000, "UInt", 0)
			Result := StrGet(&Result, "UTF-16")
			ObjRawSet(Obj, IShellItem, PIDL)
		}
	}
	
	
	for foo, bar in Obj      ; foo = IShellItem interface (ptr)  |  bar = PIDL structure (ptr)
		if foo is integer    ; IShellItem?
			ObjRelease(foo), DllCall("Ole32.dll\CoTaskMemFree", "UPtr", bar)
	ObjRelease(IFileSaveDialog)
	
	return (Result!=FALSE) ? {FileFullPath:Result,FilterIndex:FileTypeIndex} : FALSE
}
; ==================================================================================================================================
; Shows a dialog to select a folder.
; Depending on the OS version the function will use either the built-in FileSelectFolder command (XP and previous)
; or the Common Item Dialog (Vista and later).
; Parameter:
;     StartingFolder -  the full path of a folder which will be preselected.
;     Prompt         -  a text used as window title (Common Item Dialog) or as text displayed withing the dialog.
;     ----------------  Common Item Dialog only:
;     OwnerHwnd      -  HWND of the Gui which owns the dialog. If you pass a valid HWND the dialog will become modal.
;     BtnLabel       -  a text to be used as caption for the apply button.
;  Return values:
;     On success the function returns the full path of selected folder; otherwise it returns an empty string.
; MSDN:
;     Common Item Dialog -> msdn.microsoft.com/en-us/library/bb776913%28v=vs.85%29.aspx
;     IFileDialog        -> msdn.microsoft.com/en-us/library/bb775966%28v=vs.85%29.aspx
;     IShellItem         -> msdn.microsoft.com/en-us/library/bb761140%28v=vs.85%29.aspx
; ==================================================================================================================================
SelectFolderEx(StartingFolder:="", Prompt:="", OwnerHwnd:=0, OkBtnLabel:="", comboList:="", desiredDefault:=1, comboLabel:="", CustomPlaces:="", pickFoldersOnly:=1) {
	; ==================================================================================================================================
	; Shows a dialog to select a folder.
	; Depending on the OS version the function will use either the built-in FileSelectFolder command (XP and previous)
	; or the Common Item Dialog (Vista and later).
	;
	; Parameter:
	;     StartingFolder -  the full path of a folder which will be preselected.
	;     Prompt         -  a text used as window title (Common Item Dialog) or as text displayed withing the dialog.
	;     ----------------  Common Item Dialog only:
	;     OwnerHwnd      -  HWND of the Gui which owns the dialog. If you pass a valid HWND the dialog will become modal.
	;     BtnLabel       -  a text to be used as caption for the apply button.
	;     comboList      -  a string with possible drop-down options, separated by `n [new line]
	;     desiredDefault -  the default selected drop-down row
	;     comboLabel     -  the drop-down label to display
	;     CustomPlaces   -  custom directories that will be displayed in the left pane of the dialog; missing directories will be omitted; a string separated by `n [newline]
	;     pickFoldersOnly - boolean option [0, 1]
	;
	;  Return values:
	;     On success the function returns an object with the full path of the selected/file folder
	;     and combobox selected [if any]; otherwise it returns an empty string.
	;
	; MSDN:
	;     Common Item Dialog -> msdn.microsoft.com/en-us/library/bb776913%28v=vs.85%29.aspx
	;     IFileDialog        -> msdn.microsoft.com/en-us/library/bb775966%28v=vs.85%29.aspx
	;     IShellItem         -> msdn.microsoft.com/en-us/library/bb761140%28v=vs.85%29.aspx
	; ==================================================================================================================================
	; Source https://www.autohotkey.com/boards/viewtopic.php?f=6&t=18939
	; by «just me»
	; modified by Marius Șucan on: vendredi 8 mai 2020
	; to allow ComboBox and CustomPlaces
	;
	; options flags
	; FOS_OVERWRITEPROMPT  = 0x2,
	; FOS_STRICTFILETYPES  = 0x4,
	; FOS_NOCHANGEDIR  = 0x8,
	; FOS_PICKFOLDERS  = 0x20,
	; FOS_FORCEFILESYSTEM  = 0x40,
	; FOS_ALLNONSTORAGEITEMS  = 0x80,
	; FOS_NOVALIDATE  = 0x100,
	; FOS_ALLOWMULTISELECT  = 0x200,
	; FOS_PATHMUSTEXIST  = 0x800,
	; FOS_FILEMUSTEXIST  = 0x1000,
	; FOS_CREATEPROMPT  = 0x2000,
	; FOS_SHAREAWARE  = 0x4000,
	; FOS_NOREADONLYRETURN  = 0x8000,
	; FOS_NOTESTFILECREATE  = 0x10000,
	; FOS_HIDEMRUPLACES  = 0x20000,
	; FOS_HIDEPINNEDPLACES  = 0x40000,
	; FOS_NODEREFERENCELINKS  = 0x100000,
	; FOS_OKBUTTONNEEDSINTERACTION  = 0x200000,
	; FOS_DONTADDTORECENT  = 0x2000000,
	; FOS_FORCESHOWHIDDEN  = 0x10000000,
	; FOS_DEFAULTNOMINIMODE  = 0x20000000,
	; FOS_FORCEPREVIEWPANEON  = 0x40000000,
	; FOS_SUPPORTSTREAMABLEITEMS  = 0x80000000
	
	; IFileDialog vtable offsets
	; 0   QueryInterface
	; 1   AddRef 
	; 2   Release 
	; 3   Show 
	; 4   SetFileTypes 
	; 5   SetFileTypeIndex 
	; 6   GetFileTypeIndex 
	; 7   Advise 
	; 8   Unadvise 
	; 9   SetOptions 
	; 10  GetOptions 
	; 11  SetDefaultFolder 
	; 12  SetFolder 
	; 13  GetFolder 
	; 14  GetCurrentSelection 
	; 15  SetFileName 
	; 16  GetFileName 
	; 17  SetTitle 
	; 18  SetOkButtonLabel 
	; 19  SetFileNameLabel 
	; 20  GetResult 
	; 21  AddPlace 
	; 22  SetDefaultExtension 
	; 23  Close 
	; 24  SetClientGuid 
	; 25  ClearClientData 
	; 26  SetFilter
	
	
	Static OsVersion := DllCall("GetVersion", "UChar")
        , IID_IShellItem := 0
        , InitIID := VarSetCapacity(IID_IShellItem, 16, 0)
	& DllCall("Ole32.dll\IIDFromString", "WStr", "{43826d1e-e718-42ee-bc55-a1e261c37bfe}", "Ptr", &IID_IShellItem)
        , Show := A_PtrSize * 3
        , SetOptions := A_PtrSize * 9
        , SetFolder := A_PtrSize * 12
        , SetTitle := A_PtrSize * 17
        , SetOkButtonLabel := A_PtrSize * 18
        , GetResult := A_PtrSize * 20
        , ComDlgObj := {COMDLG_FILTERSPEC: ""}
	
	SelectedFolder := ""
	If (OsVersion<6)
	{
		; IFileDialog requires Win Vista+, so revert to FileSelectFolder
		FileSelectFolder, SelectedFolder, *%StartingFolder%, 3, %Prompt%
		Return SelectedFolder
	}
	
	OwnerHwnd := DllCall("IsWindow", "Ptr", OwnerHwnd, "UInt") ? OwnerHwnd : 0
	If !(FileDialog := ComObjCreate("{DC1C5A9C-E88A-4dde-A5A1-60F82A20AEF7}", "{42f85136-db7e-439c-85f1-e4075d135fc8}"))
		Return ""
	
	VTBL := NumGet(FileDialog + 0, "UPtr")
	dialogOptions := 0x8 | 0x800  ;  FOS_NOCHANGEDIR | FOS_PATHMUSTEXIST
	dialogOptions |= (pickFoldersOnly=1) ? 0x20 : 0x1000    ; FOS_PICKFOLDERS : FOS_FILEMUSTEXIST
	
	DllCall(NumGet(VTBL + SetOptions, "UPtr"), "Ptr", FileDialog, "UInt", dialogOptions, "UInt")
	If StartingFolder
	{
		If !DllCall("Shell32.dll\SHCreateItemFromParsingName", "WStr", StartingFolder, "Ptr", 0, "Ptr", &IID_IShellItem, "PtrP", FolderItem)
			DllCall(NumGet(VTBL + SetFolder, "UPtr"), "Ptr", FileDialog, "Ptr", FolderItem, "UInt")
	}
	
	If Prompt
		DllCall(NumGet(VTBL + SetTitle, "UPtr"), "Ptr", FileDialog, "WStr", Prompt, "UInt")
	If OkBtnLabel
		DllCall(NumGet(VTBL + SetOkButtonLabel, "UPtr"), "Ptr", FileDialog, "WStr", OkBtnLabel, "UInt")
	
	If CustomPlaces
	{
		Loop, Parse, CustomPlaces, `n
		{
			If InStr(FileExist(A_LoopField), "D")
			{
				foo := 1, Directory := A_LoopField
				DllCall("Shell32.dll\SHParseDisplayName", "UPtr", &Directory, "Ptr", 0, "UPtrP", PIDL, "UInt", 0, "UInt", 0)
				DllCall("Shell32.dll\SHCreateShellItem", "Ptr", 0, "Ptr", 0, "UPtr", PIDL, "UPtrP", IShellItem)
				ObjRawSet(ComDlgObj, IShellItem, PIDL)
				; IFileDialog::AddPlace method
				; https://msdn.microsoft.com/en-us/library/windows/desktop/bb775946(v=vs.85).aspx
				DllCall(NumGet(NumGet(FileDialog+0)+21*A_PtrSize), "UPtr", FileDialog, "UPtr", IShellItem, "UInt", foo)
			}
		}
	}
	
	If (comboList && comboLabel)
	{
		Try If ((FileDialogCustomize := ComObjQuery(FileDialog, "{e6fdd21a-163f-4975-9c8c-a69f1ba37034}")))
		{
			groupId := 616 ; arbitrarily chosen IDs
			comboboxId := 93270
			DllCall(NumGet(NumGet(FileDialogCustomize+0)+26*A_PtrSize), "Ptr", FileDialogCustomize, "UInt", groupId, "WStr", comboLabel) ; IFileDialogCustomize::StartVisualGroup
			DllCall(NumGet(NumGet(FileDialogCustomize+0)+6*A_PtrSize), "Ptr", FileDialogCustomize, "UInt", comboboxId) ; IFileDialogCustomize::AddComboBox
			; DllCall(NumGet(NumGet(FileDialogCustomize+0)+19*A_PtrSize), "Ptr", FileDialogCustomize, "UInt", comboboxId, "UInt", itemOneId, "WStr", "Current folder") ; IFileDialogCustomize::AddControlItem
			
			entriesArray := []
			Loop, Parse, comboList,`n
			{
				Random, varA, 2, 900
				Random, varB, 2, 900
				thisID := varA varB
				If A_LoopField
				{
					If (A_Index=desiredDefault)
						desiredIDdefault := thisID
					
					entriesArray[thisId] := A_LoopField
					DllCall(NumGet(NumGet(FileDialogCustomize+0)+19*A_PtrSize), "Ptr", FileDialogCustomize, "UInt", comboboxId, "UInt", thisID, "WStr", A_LoopField)
				}
			}
			
			DllCall(NumGet(NumGet(FileDialogCustomize+0)+25*A_PtrSize), "Ptr", FileDialogCustomize, "UInt", comboboxId, "UInt", desiredIDdefault) ; IFileDialogCustomize::SetSelectedControlItem
			DllCall(NumGet(NumGet(FileDialogCustomize+0)+27*A_PtrSize), "Ptr", FileDialogCustomize) ; IFileDialogCustomize::EndVisualGroup
		}
		
	}
	
	If !DllCall(NumGet(VTBL + Show, "UPtr"), "Ptr", FileDialog, "Ptr", OwnerHwnd, "UInt")
	{
		If !DllCall(NumGet(VTBL + GetResult, "UPtr"), "Ptr", FileDialog, "PtrP", ShellItem, "UInt")
		{
			GetDisplayName := NumGet(NumGet(ShellItem + 0, "UPtr"), A_PtrSize * 5, "UPtr")
			If !DllCall(GetDisplayName, "Ptr", ShellItem, "UInt", 0x80028000, "PtrP", StrPtr) ; SIGDN_DESKTOPABSOLUTEPARSING
				SelectedFolder := StrGet(StrPtr, "UTF-16"), DllCall("Ole32.dll\CoTaskMemFree", "Ptr", StrPtr)
			
			ObjRelease(ShellItem)
			if (FileDialogCustomize)
			{
				if (DllCall(NumGet(NumGet(FileDialogCustomize+0)+24*A_PtrSize), "Ptr", FileDialogCustomize, "UInt", comboboxId, "UInt*", selectedItemId) == 0)
				{ ; IFileDialogCustomize::GetSelectedControlItem
					if selectedItemId
						thisComboSelected := entriesArray[selectedItemId]
				}   
			}
		}
	}
	If (FolderItem)
		ObjRelease(FolderItem)
	
	if (FileDialogCustomize)
		ObjRelease(FileDialogCustomize)
	
	ObjRelease(FileDialog)
	r := []
	r.SelectedDir := SelectedFolder
	r.SelectedCombo := thisComboSelected
	Return r
}
return