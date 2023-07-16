; =================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
; =================================================================================================
; SetWinDelay 0 ; (06/2023) - comment out for testing
; SetControlDelay 0 ; (06/2023) - comment out for testing
; SetBatchLines, -1 ; scrip run speed, The value -1 = max speed possible. ; (05/2023)comment out for testing
; https://www.autohotkey.com/docs/v1/lib/SetBatchLines.htm
; SetWinDelay, -1 ; (05/2023) - comment out for testing
; SetControlDelay, -1 ; (05/2023) - comment out for testing
; #MaxMem 4095 ; Allows the maximum amount of MB per variable.
; #MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
#Warn All, OutputDebug
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir % A_ScriptDir  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText, On
DetectHiddenWindows, On
#Requires AutoHotkey 1.1+
;#Include, gdip.ahk ; gdip added to the bottom of the script
Library_Load(winuser.dll)
Library_Load(processthreadsapi.dll)
Library_Load(memoryapi.dll)

; --------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; --------------------------------------------------------------------------------------------------
; Name .........: Horizon Button == A Horizon function library
; Description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
; AHK Version ..: AHK 1.1+ x32/64 Unicode
; Author .......: Overcast (Adam Bacon), Terry Keatts, and special assistance from Descolada
; License ......: WTFPL - http://www.wtfpl.net/txt/copying/
; Changelog ....: ??? - v0.1 - First version. Added Ctrl-I, Ctrl-B
; ..............: ??? - v0.2 - Broke lots of things, and "fixed" them
; ..............: ??? - v0.3 - Broke lots of things, and "fixed" them... again. Added Ctrl-A
; ..............: ??? - v0.4 - Broke lots of things, and "fixed" them... again
; ..............: 05/23/2023 - v0.5 - Fixed issue where Ctrl-A didn't work in the Equipment Section.
; ..............: 05/31/2023 - v0.6 - Transferred all data sheets to a .ini file (OSTitle.ini).
; ..............: 06/01/2023 - v0.7 - Changed the MakeOSItalic() to read the key: Title= only => see Common_Abbrevations
; . Continued .....................: See Common_Abbrevations.ahk for additional details.
; ..............: 06/04/2023 - v0.8 - Added icon, tray menu, separated MakeOSItalic() function
; . Continued ..: => Tray Menu has the "option" to run an startup ==> this needs to change to always for .exe
; ..............: 06/04/2023 - v0.9 - Added "CloseHandle" and "GlobalFree" dllcalls to attempt correction of weirdness
; . Continued ..: after running the HznButton() function.
; ..............: 06/05/2023 - v1.0 - removed CloseHandle and GlobalFree => made it worse.
; . Continued ..: Simplified the button clicking process using the ?: ternary opeartor
; ..............: Various Dates - v2.0 - Embedded the ICON, cleaned up some code, made the b()
; --------------------------------------------------------------------------------------------------

;<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|
; --------------------------------------------------------------------------------------------------
; Sub-Section .....: Script Name, Startup Path, and icon
; --------------------------------------------------------------------------------------------------


; --------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Icon File
; Reference .......: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=101960&p=527471#p527471
; Credit ..........: Hellbent
; --------------------------------------------------------------------------------------------------

;<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|
; Step ............: Load the GDI+ lib
Gdip_Startup()
; Step ............: The Base 64 string for the icon image
; .................: This was moved to the end of the script via MyIcon_B64()
icostr := MyIcon_B64()
; Step ............: create a pBitmap from the Base 64 string.
HznIcon_pBitmap := B64ToPBitmap( icostr )
; Step ............: create a hBitmap from the icon pBitmap
HznIcon_hIcon := Gdip_CreateHICONFromBitmap( HznIcon_pBitmap )
; Step ............: Dispose of the icon pBitmap to free memory.
Gdip_DisposeImage( HznIcon_pBitmap )
; Step ............: Set the icon
Menu, Tray, Icon, % "HICON:" . HznIcon_hIcon
;<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|<<<---#####--->>>|
OutputDebug % A_ScriptName
;ICON := "HznHorizon.ico" => changed to embeded icon via MyIcon_B64 and icostr
;splitPath, A_ScriptName,,, A_Script, A_Script_Name
;A_Script_Full_Name := A_Script_Name "." A_Script_Ext
Startup_Shortcut := A_Startup "\" A_ScriptName ".lnk"
; -------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu
; -------------------------------------------------------------------------------------------------
OS := % A_OSVersion
OutputDebug % OS
CreateTrayMenu()

; -------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu Functions
; Description .....: addTrayMenuOption() ; madeBy() ; runAtStartup() ; trayNotify()
; -------------------------------------------------------------------------------------------------
CreateTrayMenu()
{
    ;Menu, Tray, Icon, % hICON ; this changes the icon into a little Horizon thing.
    Menu, Tray, NoStandard
    addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
    addTrayMenuOption()
    addTrayMenuOption("Run at startup", "runAtStartup")
    Menu, Tray, % fileExist(Startup_Shortcut)
                ? "check"
                : "unCheck", Run at startup ; update the tray menu status on startup
    addTrayMenuOption()
    Menu, Tray, Standard
}

addTrayMenuOption(label := "", command := "")
{
	if (label = "" && command = "") {
		Menu, Tray, Add
	} else {
		Menu, Tray, Add, % label, % command
	}
}

madeBy()
{
	; visit authors website
	;Run, https://bibeka.com.np/
	MsgBox This was made by nerds, for nerds. Regular people are ok too, lol.`nModified by Adam Bacon`nCredit:Made with ❤️ by Bibek Aryal
}

runAtStartup()
{
	if (FileExist(startup_shortcut)) {
		FileDelete, % startup_shortcut
		Menu, Tray, % "unCheck", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut removed", "This script will not run when you turn on your computer.")
	} else {
		FileCreateShortcut, % A_ScriptFullPath, % startup_shortcut
        Menu, Tray, % "check", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut added", "This script will now automatically run when your turn on your computer.")
	}

}

trayNotify(title, message, seconds = "", options = 0) {
    TrayTip, % title, % message, % seconds, % options
}

/*
trayNotify(title, message, seconds = "", options = 0,)
{
	title := % A_ScriptName
    TrayTip, % title, % message, %seconds , % options
    sleep 2000
    HideTrayTip()
}
*/
HideTrayTip()
{
    TrayTip
    ;if SubStr(A_OSVersion,1,3) = "10."
    ;    {
    ;        Menu, Tray, NoIcon
    ;        Sleep 200
    ;        Menu, Tray, Icon
    ;    }   
}
; ************************************ ... First Return ... ****************************************
return
; ...............: End Sub-Section
; ==================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#IfWinActive ahk_exe hznhorizon.exe

; --------------------------------------------------------------------------------------------------
; Function .....: Horizon {Enter} ==> Select Option
; Description ..: Hotkeys (shortcuts) sending {Enter} in leu of "Double Click"
; Author .......: Overcast (Adam Bacon)
; TODO .........: Still doesn't work. Might have to not use the WinActive() function
; --------------------------------------------------------------------------------------------------
#If WinActive("ahk_exe hznhorizonmgr.exe") or WinActive("ahk_exe hznhorizon.exe")
{
	ControlGetFocus, fCtl, A
	ControlGet, hCtl, hWnd,,% fCtl, A
	Shift & Enter::DllCall("PostMessage", Ptr, Ctl, UInt,0x0203,Ptr, 0, Ptr, 0)
}
return
#If

; --------------------------------------------------------------------------------------------------
; Function .....: Horizon Buttons/Hotkeys
; Description ..: Hotkeys (shortcuts) for normal Windows hotkeys: 
; . Continued ..: CTRL+I (italics)
; . Continued ..: CTRL+B (bold)
; . Continued ..: CTRL+U (underline) - Where Applicable - else same as CTRL+B (I dunno why).
; . Continued ..: CTRL+A (select all)
; . Continued ..: In ideal land, this will be a single function call. Right now this works.
; Author .......: Overcast (Adam Bacon)
; TODO .........: Reduce to a single HznButton function call
; ChangeLog ....: see above
; Special Notes : The below indexes, or n from the HznButton(hWndToolbar, n) function, depend on what screen you are on
; . Continued ..: 1=Bold, 2=Italics, (everything after this changes depending on what screen you are on)
; . Continued ..: where underline is an option is index 9 or 10, else it reverts to CTRL+B or CTRL+I
; ..................................................................................................
; . Continued ..: >>>>>>>>> THIS NEEDS TO BE FULLY VALIDATED FOR EACH SCREEN <<<<<<<<<<
; Notes: (AJB - 06/2023) as of this timestamp, none of this below is fully validated and changes
; . Continued ..: 10=Cut, 11=Copy, 12=Paste, 14=Undo, 15=Redo, 17=Bulleted List, 18=Spell Check
; . Continued ..: ===== Human Element Section =====
; . Continued ..: 20=Super/Sub Script, 21=Find/Replace
; . Continued ..: Mystery or Spacers: 3-9, 13, 16, 19=?Bold?
; . Continued ..: ===== Equipment Section =====
; . Continued ..: Nothing?=1,2; Same: 21,20,18,17,
; -------------------------------------------------------------------------------------------------

; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Horizon Button Function <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; -------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Italic, Bold, and Underline (***where applicable***)
; ChangeLog ....: 06/05/2023 - CTRL+I and CTRL+B validated for all screens
; . Continued ..: CTRL+U only valid for screens which have it listed as a button
; . Continued ..: else it reverts to CTRL+B or CTRL+I
; -------------------------------------------------------------------------------------------------
#If WinActive("ahk_exe hznhorizon.exe")

^i::button()
^b::button()
^u::button()

; --------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Cut, Copy, Paste, Undo, Redo
; ChangeLog ....: 06/05/2023 - Validated for the Human Element Screen only. Commented out due to irratic behavior.
; --------------------------------------------------------------------------------------------------

/*
^x::b()
^c::b()
^v::b()
^z::b()
^y::b()
ControlGetFocus, focus, A
bID:= SubStr(focus, 0, 1)
hIDx := A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
     :  A_ThisHotkey = "^c" ? 13 ; ........: copy
     :  A_ThisHotkey = "^v" ? 16 ; ........: paste
     :  A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
     :  A_ThisHotkey = "^y" ? 20 : 20 ; ...: redo
ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
HznButton(hToolbar,hIDx)
return
*/
; -------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkey - Select-All (Ctrl-A)
; -------------------------------------------------------------------------------------------------

^a::HznSelectAll()

HznSelectAll()
{
    Static Msg := EM_SETSEL := 177, wParam := 0, lParam := -1
	ControlGetFocus, fCtl, A
    ControlGet, hCtl, hWnd,,% fCtl, A
    DllCall("SendMessage", "Ptr", hCtl, "UInt", Msg, "UInt", wParam, "UIntP", lParam)
}
Return

; .................................................................................................
;if (ErrorLevel != 1) {
;ToolTip % "SendMessge Error: " ErrorLevel "`n" hCtl "`n" Ctl
;}
;WinGetClass, vCtl, % "ahk_id " Ctl
;DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 0xB1, "Ptr", 0, "Ptr", -1))
;((vCtl = "TX11") ? DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 177, "PtrP", 0, "PtrP", -1) : DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 0xB1, "Ptr", 0, "Ptr", -1))
;((vCtl = "TX11") ? SendMessage,0xB1,"","",,ahk_id %Ctl% : SendMessage,0xB1,0,-1,,ahk_id %Ctl%) ; doesn't work

;ToolTip % "1: " hCtl "`n2: " vCtl, 0,0,1

;MsgBox % "xCtl: " xCtl  "`nyCtl: " yCtl
;hWndChild := DllCall("RealChildWindowFromPoint","Ptr",Ctl,"UInt",4,"Ptr")
;Ctl := DllCall("RealChildWindowFromPoint","Ptr",hCtl,"UInt",4,"Ptr")
;VarSetCapacity(cClass, 261*2, 0)
;DllCall("GetClassName","Ptr",Ctl,"Str",cClass,"Int",261)
;VarSetCapacity(cClass, 64*2, 0)
;DllCall("GetClassName","Ptr",Ctl,"Str",cClass,"Int",64)
;WinGetClass, vCtl, % "ahk_id " hWndChild

;((cClass = "TX11") ? DllCall("SendMessage","Ptr",Ctl,"UInt",0x00B1) : DllCall("SendMessage","Ptr",Ctl,"UInt",0xB1, "Ptr", 0, "Ptr", -1))
;DllCall("SendMessage","Ptr",Ctl,"UInt",0xB1, "Ptr", 0, "Ptr", -1)

return
; -------------------------------------------------------------------------------------------------
; Function .....: button()
; Description ..: Call the Horizon msvb_lib_toolbar buttons
; Definition ...: A_ThisHotkey => AHK's built in variable
; Author .......: Overcast (Adam Bacon)
; -------------------------------------------------------------------------------------------------
button()
{
    SendLevel 1
    ControlGetFocus, fCtl, A
    bID := SubStr(fCtl, 0, 1)
    ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
    hIDx:= A_ThisHotkey = "^i" ? 2 ; .........: italic = 2
        :  A_ThisHotkey = "^b" ? 1 ; .........: bold = 1
        :  A_ThisHotkey = "^u" ? 9 ; .........: underline = 9 and 10 (if exist, else italic or bold)
        :  A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
        :  A_ThisHotkey = "^c" ? 13 ; ........: copy
        :  A_ThisHotkey = "^v" ? 16 ; ........: paste
        :  A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
        :  A_ThisHotkey = "^y" ? 20 : 20 ; ...: redo
    HznButton(hToolbar,hIDx)
}    
return
; -------------------------------------------------------------------------------------------------
; Function .....: HznButton()
; Description ..: Find and Control-Click the Horizon msvb_lib_toolbar buttons
; Definition ...: hWndToolbar = the toolbar window's handle
; Definition ...: n = the index for the specified button
; Author .......: Descolada, Overcast (Adam Bacon)
; -------------------------------------------------------------------------------------------------

HznButton(hToolbar, n)
{
	static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETITEMRECT := 0x41D ; set the static variables
	SendMessage, TB_BUTTONCOUNT, 0, 0,,% "ahk_id " hToolbar ; count and load all the msvb_lib_toolbar buttons into memory
	;DllCall("SendMessage", "Ptr", hToolbar, "Ptr", TB_BUTTONCOUNT, "Ptr", 0, "Ptr", 0)
	buttonCount := ErrorLevel
	if (n >= 1 && n <= buttonCount) {
		;Ptr := A_PtrSize ? "UPtr" : "UInt", PtrP := Ptr . "*"
		DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UIntP", targetProcessID)
		; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
		hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		; Allocate memory for the TBBUTTON structure in the target process's address space
		remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")
		SendMessage, TB_GETITEMRECT, % n-1, remoteMemory, ,% "ahk_id " hToolbar
		VarSetCapacity(RECT, 16, 0)
		DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
		DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
        ;result := DllCall( "VirtualFreeEx" 
        DllCall( "VirtualFreeEx" 
            ;, "UInt", hpRemote 
            , "UInt", hProcess 
            ;, "UInt", remote_buffer 
            , "UInt", remoteMemory 
            , "UInt", 0 
            , "UInt", 0x8000 )     ; MEM_RELEASE 
		; get the bounding rectangle for the specified button
		X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y ;, prevDelay := A_ControlDelay
		
		ControlClick, % "x" (X+W//2) " y" (Y+H//2), % "ahk_id " hToolbar,,,, NA
		;SetControlDelay, %prevDelay%
	} else {
		MsgBox, 48, Error, % "The specified index " n " is out of range. Please specify a valid index between 1 and " buttonCount "."
	}
	DllCall("FreeLibrary", "Ptr", hProcess) ; added 06.23.2023
}
; reload ; make sure you reload or it... does weird stuff ; commented out 06.23.2023 with the "FreeLibrary" DllCall() 
; return

;#IfWinActive
; DllCall("CloseHandle", "Ptr", hProcess) ; this and the below "GlobalFree" may have fixed the need for a reload.
; DllCall("GlobalFree", "Ptr", hWndToolbar) ; this and the above "CloseHandle" may have fixed the need for a reload.
; (AJB - 06/2023) - Nope, both? of those make it worse

/*
If(vCtl = "ThunderRT6TextBox"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}
If(vCtl = "TX11"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}else {
	;PostMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	;SendMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1, Ptr, 0, Ptr, -1) 	; works in eqpt
}
;reload
*/
; return

; ------------------------------------------
; Function .....: Horizon Button - Italics (Ctrl-I)
; ------------------------------------------
; ..........: Leave until conversion to AHK v2 ==> backup for conflict with SetBatchLines, SetWinDelay, SetControlDelay
/*
ci:
cb:
cu:
ControlGetFocus, focus, A
bID:= SubStr(focus, 0, 1)
ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
hIDx:= A_ThisLabel = "ci" ? 2 ; ..............: italic = 2
	   : A_ThisLabel = "cb" ? 1 ; ..............: bold = 1
	   : A_ThisLabel = "cu" ? 9 : 10 ; .........: underline = 9 and 10 (if available, else italic or bold)
HznButton(hToolbar,hIDx)
return
*/
; ................................................................................................


#6::
#Warn All, OutputDebug
SendLevel 1
ControlGetFocus, fCtl, A
bID:= SubStr(fCtl, 0, 1)
ControlGet, ctrlhwnd, hWnd,,% "msvb_lib_toolbar" bID, A
;EnumToolbarButtons(ctrlhwnd)
Toolbar.ctrlhwnd.Customize()

return

EnumToolbarButtons(ctrlhwnd, is_apply_scale:=false) {
	; Thanks to LabelControl code from 
	; https://www.donationcoder.com/Software/Skrommel/
	;
	; ctrlhwnd is the toolbar hwnd.
	; Return an array of objects, with element:
	; * .x .y .w .h (button position relative to the toolbar)
	; * .cmd  (command id of the button)
	; * .text  (text displayed on the button)
	;
	; is_apply_scale should keep false; true is only for testing purpose
  /*
	; DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UIntP", targetProcessID)
  ; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
  ; hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
  ; Allocate memory for the TBBUTTON structure in the target process's address space
  ; remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")

  */
  ; SendMessage, TB_GETITEMRECT, % n-1, remoteMemory, ,% "ahk_id " hToolbar
  ; VarSetCapacity(RECT, 16, 0)
  ; DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
  ; DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
  ; get the bounding rectangle for the specified button
	arbtn := []
	
	ControlGetPos, ctrlx, ctrly, ctrlw, ctrlh,, % "ahk_id " ctrlhwnd
	
	;MsgBox % "X: "ctrlx " Y: "ctrly " W: " ctrlw " H: " ctrlh ; 06.25.2023 .. THIS WORKS!!!
	;MouseMove, ctrlx, ctrly ; 06.25.2023 .. THIS WORKS!!! It actually moves the mouse to the right location!!!
	;pid_target := ""
  /*
  pid_target := DllCall( "GetWindowThreadProcessId"
                    , "Ptr", ctrlhwnd)
  ;                  , "UIntP") ;, pid_target)
  OutputDebug, % "pid_target: " . pid_target

*/

  WinGet, pid_target, PID, % "ahk_id " ctrlhwnd ; ==> replaced with above DllCall()
  OutputDebug, % "pid_targetW: " . pid_target . "`n"
  ; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
	hpRemote := DllCall( "OpenProcess" 
	;                  , "uint", 0x18    ; PROCESS_VM_OPERATION|PROCESS_VM_READ ; ==> original
                    , "UInt", 0x0018 | 0x0010 | 0x0020
                    , "Int", false
                    , "UInt", pid_target )
	
  ; hpRemote: Remote process handle
	if(!hpRemote) {
		tooltip, % "Autohotkey: Cannot OpenProcess(pid=" . pid_target . ")"
		return
	}
	; Allocate memory for the TBBUTTON structure in the target process's address space
  
  remote_buffer := DllCall( "VirtualAllocEx" 
  ;                  , "UInt", hpRemote     ; == original
                    , "Ptr", hpRemote
  ;                  , "Ptr", hProcess      ; ==> from HznButton()
                    , "Ptr", 0              ; LPVOID lpAddress ("uint" tolerable)
  ;                  , "Ptr", 0 ; ==> from HznButton() => same
  ;                  , "UInt", 0x1000        ; size to allocate, 4KB
                    , "UPtr", 16            ; ==> from HznButton()           
                    , "UInt", 0x1000        ; MEM_COMMIT
  ;                  , "UInt", 0x1000       ; ==> from HznButton() => same
  ;                  , "UInt", 0x4)          ; PAGE_READWRITE
                    , "UInt", 0x04         ; ==> from HznButton() => same?
                    , "Ptr")               ; ==> from HznButton()
	
  x1 :="", x2 :="", y1 :="", y2 :=""
	
  Static WM_USER        := 0x400
	, TB_GETSTATE       := WM_USER+18
	, TB_GETBITMAP      := WM_USER+44 ; only for test
	, TB_GETBUTTONSIZE  := WM_USER+58 ; only for test
	, TB_GETBUTTON      := WM_USER+23
	, TB_GETBUTTONTEXTA := WM_USER+45 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
	, TB_GETBUTTONTEXTW := WM_USER+75 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
	, TB_GETITEMRECT    := WM_USER+29
	, TB_BUTTONCOUNT    := WM_USER+24 ; or 0x418 (hex)
    , WM_GETDLGCODE     := 135        ;(decimal) or 0x0087 (hex)
    , WM_NEXTDLGCTL     := 40         ;(decimal) or 0x0028 (hex)
	, TB_COMMANDTOINDEX := 1049       ;(decimal) or 0x0419 (hex)
    , TB_GETBUTTONINFOW := 1087       ;(decimal) or 0x043f (hex)	
	
  Static Msg := TB_BUTTONCOUNT, wParam := 0, lParam := 0, control := ""
  SendMessage,% TB_BUTTONCOUNT,% wParam,% lParam,% control, % "ahk_id " ctrlhwnd
	buttons := ErrorLevel
	OutputDebug, % "buttons: " . buttons . "`n" ;tooltip, buttons=%buttons%	 ; OK
	
	VarSetCapacity( rect, 16, 0 ) 
	VarSetCapacity( BtnStruct, 32, 0 ) ; Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86)
	/*
		typedef struct _TBBUTTON {
			int       iBitmap; 
			int       idCommand; 
			BYTE      fsState; 
			BYTE      fsStyle; 
			#ifdef _WIN64
			BYTE      bReserved[6]     // padding for alignment
			#elif defined(_WIN32)
			BYTE      bReserved[2]     // padding for alignment
			#endif
			DWORD_PTR dwData; 
			INT_PTR   iString; 
		} TBBUTTON, NEAR* PTBBUTTON, FAR* LPTBBUTTON; 
	*/
	
	Loop,% buttons
	{
		; Try to get button text. Two steps: 
		; 1. get command-id from button-index,
		; 2. get button text from command-id
		SendMessage, TB_GETBUTTON, % A_Index-1, remote_buffer, , % "ahk_id " ctrlhwnd
		ReadRemoteBuffer(hpRemote, remote_buffer, BtnStruct, 32)
		
		idButton := NumGet(BtnStruct, 4, "IntP")
    OutputDebug, % "idButton: " . idButton . "`n"	
		
		SendMessage, TB_COMMANDTOINDEX,% idButton,0,, % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnvar1 := % " Cmd2Indx: " . ErrorLevel
		OutputDebug, % "Cmd2Indx: " . btnvar1 . "`n"

		SendMessage, TB_GETBUTTONINFOW,% btnvar1,remote_buffer,, % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnvar2 := % " Info:" . ErrorLevel

		SendMessage, % TB_GETSTATE, % idButton, 0, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnstate := ErrorLevel
    OutputDebug, % "btnstate: " . btnstate . "`n"

		SendMessage, % TB_GETBUTTONTEXTW, % idButton, remote_buffer, ,% "ahk_id " ctrlhwnd ; hope that 4KB is enough
		btntextcharsW := ErrorLevel
    OutputDebug, % "btntextcharsW: " . btntextcharsW . "`n"
    
		if(btntextcharsW>0){
			btntextbytes := A_IsUnicode ? btntextcharsW*2 : btntextcharsW
      
			VarSetCapacity(BtnTextBuf, btntextbytes+2, 0) ; +2 is for trailing-NUL
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			BtnTextW := StrGet(BtnTextBuf,,"UTF-16")
		} else {
			BtnTextW := ""
		}
    OutputDebug, % "BtnTextW: " . BtnTextW . "`n"
    
    /*

    SendMessage, % TB_GETBUTTONTEXTA, % idButton, remote_buffer, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough
		btntextcharsA := ErrorLevel
    OutputDebug, % "btntextcharsA: " . btntextcharsA . "`n"
    
		if(btntextcharsA>0){
      btntextbytes := A_IsUnicode ? btntextcharsA*2 : btntextcharsA
			VarSetCapacity(BtnTextBuf, btntextbytes+2, 0) ; +2 is for trailing-NUL
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			BtnTextA := StrGet(&BtnTextBuf,99,0)
		} else {
      BtnTextA := ""
		}
    OutputDebug, % "BtnTextA: " . BtnTextA . "`n"
    */
		
    ;FileAppend, % A_Index . ":" . idButton . "(" . btntextchars . ")" . BtnText . "`n", _emeditor_toolbar_buttons.txt ; debug
		
		SendMessage,% TB_GETITEMRECT,% A_Index-1, remote_buffer, ,% "ahk_id " ctrlhwnd
		
		ReadRemoteBuffer(hpRemote, remote_buffer, rect, 32)
		oldx1:=x1
		oldx2:=x2
		oldy1:=y1
		x1 := NumGet(rect, 0, "Int") 
		x2 := NumGet(rect, 8, "Int") 
		y1 := NumGet(rect, 4, "Int") 
		y2 := NumGet(rect, 12,"Int")
		
		FileAppend, % A_Index . ":" . idButton . "(" . btntextcharsW . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . Btnvar1 . Btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n", _emeditor_toolbar_buttons.txt  ; debug
		OutputDebug % A_Index . ":" . idButton . "(" . btntextcharsW . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . Btnvar1 . Btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n"                                 ; debug
    
		;MouseMove % ctrlx + (x2+x1//2), ctrly + (y2+y1//2)
		;if(is_apply_scale) {
		;scale := Get_DPIScale()
		;x1 /= scale
		;y1 /= scale
		;x2 /= scale
		;y2 /= scale
		;}
		
		If (x1=oldx1 And y1=oldy1 And x2=oldx2)
			Continue
		If (x2-x1<10)
			Continue
		If (x1>ctrlw Or y1>ctrlh)
			Continue
		
    arbtn.Insert({"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnTextW})
    ;arbtn.Insert( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
    ;line:=100000000+Floor((ctrly+y1)/same)*10000+(ctrlx+x1)
    ;lines=%lines%%line%%A_Tab%%ctrlid%%A_Tab%%class%`n
		arbtn := ({"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnTextW})
		For key, value in arbtn{
			FileAppend, % "Key:" . key . " = " . value . "`n", _arbtn.txt
    }
	}
  
	result := DllCall( "VirtualFreeEx"
                  , "UInt", hpRemote
                  , "UInt", remote_buffer
                  , "UInt", 0
                  , "UInt", 0x8000 )     ; MEM_RELEASE 
	result := DllCall( "CloseHandle", "UInt", hpRemote )
	return arbtn
}

ReadRemoteBuffer(hpRemote, RemoteBuffer, ByRef LocalVar, bytes) {
	result := DllCall( "ReadProcessMemory"
                  , "Ptr", hpRemote
                  , "Ptr", RemoteBuffer
                  , "Ptr", &LocalVar
                  , "UInt", bytes
                  , "UInt", 0 ) 
}

#IfWinActive

;=======================================================================================
;
;                    Class Toolbar
;
; Author:            Pulover [Rodolfo U. Batista]
; AHK version:       1.1.23.01
;
;                    Class for AutoHotkey Toolbar custom controls
;=======================================================================================
;
; This class provides intuitive methods to work with Toolbar controls created via
;    Gui, Add, Custom, ClassToolbarWindow32.
;
; Note: It's recommended to call any method only after Gui, Show. Adding or modifying
;     buttons of a toolbar in a Gui that is not yet visible might fail eventually.
;
;=======================================================================================
;
; Toolbar Methods:
;    Add([Options, Label1[=Text]:Icon[(Options)], Label2[=Text]:Icon[(Options)]...])
;    AutoSize()
;    Customize()
;    Delete(Button)
;    Export()
;    Get([HotItem, TextRows, Rows, BtnWidth, BtnHeight, Style, ExStyle])
;    GetButton(Button [, ID, Text, State, Style, Icon, Label, Index])
;    GetButtonPos(Button [, OutX, OutY, OutW, OutH])
;    GetButtonState(Button, StateQuerry)
;    GetCount()
;    GetHiddenButtons()
;    Insert(Position [, Options, Label1[=Text]:Icon[(Options)], Label2[=Text]:Icon[(Options)]...])
;    LabelToIndex(Label)
;    ModifyButton(Button, State [, Set])
;    ModifyButtonInfo(Button, Property, Value)
;    MoveButton(Button, Target)
;    OnMessage(CommandID)
;    OnNotify(Param [, MenuXPos, MenuYPos, Label, ID, AllowCustom])
;    Reset()
;    SetButtonSize(W, H)
;    SetDefault([Options, Label1[=Text]:Icon[(Options)], Label2[=Text]:Icon[(Options)]...])
;    SetExStyle(Style)
;    SetHotItem(Button)
;    SetImageList(IL_Default [, IL_Hot, IL_Pressed, IL_Disabled])
;    SetIndent(Value)
;    SetListGap(Value)
;    SetMaxTextRows([MaxRows])
;    SetPadding(X, Y)
;    SetRows([Rows, AddMore])
;    ToggleStyle(Style)
;
; Presets Methods:
;    Presets.Delete(Slot)
;    Presets.Export(Slot, [ArrayOut])
;    Presets.Import(Slot, [Options, Label1[=Text]:Icon, Label2[=Text]:Icon, Label3[=Text]:Icon...])
;    Presets.Load(Slot)
;    Presets.Save(Slot, Buttons)
;
;=======================================================================================
;
; Useful Toolbar Styles:   Styles can be applied to Gui command options, e.g.:
;                              Gui, Add, Custom, ClassToolbarWindow32 0x0800 0x0100
;
; TBSTYLE_FLAT      := 0x0800 - Shows separators as bars.
; TBSTYLE_LIST      := 0x1000 - Shows buttons text on their side.
; TBSTYLE_TOOLTIPS  := 0x0100 - Shows buttons text as tooltips.
; CCS_ADJUSTABLE    := 0x0020 - Allows customization by double-click and shift-drag.
; CCS_NODIVIDER     := 0x0040 - Removes the separator line above the toolbar.
; CCS_NOPARENTALIGN := 0x0008 - Allows positioning and moving toolbars.
; CCS_NORESIZE      := 0x0004 - Allows resizing toolbars.
; CCS_VERT          := 0x0080 - Creates a vertical toolbar (add WRAP to button options).
;
;=======================================================================================
Class Toolbar extends Toolbar.Private
{
;=======================================================================================
;    Method:             Add
;    Description:        Add button(s) to the end the toolbar. The Buttons parameters
;                            sets target Label, text caption and icon index for each
;                            button. If not a valid label name, a function name can be
;                            used instead.
;                        To add a separator call this method without parameters.
;                        Prepend any non letter or digit symbol, such as "-" or "*"
;                            to the label to add a hidden button. Hidden buttons won't
;                            be visible when Gui is shown but will still be available
;                            in the customize window. E.g.: "-Label=New:1", "*Label:2".
;    Parameters:
;        Options:        Enter zero or more words, separated by space or tab, from the
;                            following list to set buttons' initial states and styles:
;                            Checked, Ellipses, Enabled, Hidden, Indeterminate, Marked,
;                            Pressed, Wrap, Button, Sep, Check, Group, CheckGroup,
;                            Dropdown, AutoSize, NoPrefix, ShowText, WholeDropdown.
;                        You can also set the minimum and maximum button width,
;                            for example W20-100 would set min to 20 and max to 100.
;                        This option affects all buttons in the toolbar when added or
;                            inserted but does not prevent modifying button sizes.
;                        If this parameter is blank it defaults to "Enabled", otherwise
;                            you must set this parameter to enable buttons.
;                        You may pass integer values that correspond to (a combination of)
;                            button styles. You cannot set states this way (it will always
;                            be set to "Enabled").
;        Buttons:        Buttons can be added in the following format: Label=Text:1,
;                            where "Label" is the target label to execute when the
;                            button is pressed, "Text" is caption to be displayed
;                            with the button or as a Tooltip if the toolbar has the
;                            TBSTYLE_TOOLTIPS style (this parameter can be omitted) and
;                            "1" can be any numeric value that represents the icon index
;                            in the ImageList (0 means no icon).
;                        You can include specific states and styles for a button appending
;                            them inside parenthesis after the icon. E.g.:
;                            "Label=Text:3(Enabled Dropdown)". This option can also be
;                            an Integer value, in this case the general options are
;                            ignored for that button.
;                        To add a separator between buttons specify "" or equivalent.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Add(Options := "Enabled", Buttons*)
    {
        If (!Buttons.Length())
        {
            Struct := this.BtnSep(TBBUTTON, Options), this.DefaultBtnInfo.Push(Struct)
            SendMessage, this.TB_ADDBUTTONS, 1, &TBBUTTON,, % "ahk_id " this.tbHwnd
            If (ErrorLevel = "FAIL")
                return false
        }
        Else If (Options = "")
            Options := "Enabled"
        For each, Button in Buttons
        {
            If !(this.SendMessage(Button, Options, this.TB_ADDBUTTONS, 1))
                return false
        }
        this.AutoSize()
        return true
    }
;=======================================================================================
;    Method:             AutoSize
;    Description:        Auto-sizes toolbar.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    AutoSize()
    {
        PostMessage, this.TB_AUTOSIZE, 0, 0,, % "ahk_id " this.tbHwnd
        return ErrorLevel ? false : true
    }
;=======================================================================================
;    Method:             Customize
;    Description:        Displays the Customize Toolbar dialog box.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Customize()
    {
        SendMessage, this.TB_CUSTOMIZE, 0, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             Delete
;    Description:        Delete one or all buttons.
;    Parameters:
;        Button:         1-based index of the button. If omitted deletes all buttons.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Delete(Button := "")
    {
        If (!Button)
        {
            Loop, % this.GetCount()
                this.Delete(1)
        }
        Else
            SendMessage, this.TB_DELETEBUTTON, Button-1, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             Export()
;    Description:        Returns a text string with current buttons and order in Add and
;                            Insert methods compatible format (this includes button's
;                            styles but not states). Duplicate labels are ignored.
;    Parameters:
;        ArrayOut:       Set to TRUE to return an object array. The returned object
;                            format is compatible with Presets.Save and Presets.Load
;                            methods, which can be used to save and load layout presets.
;    HidMark:            Changes the default symbol to prepend to hidden buttons.
;    Return:             A text string with current buttons information to be exported.
;=======================================================================================
    Export(ArrayOut := false, HidMark := "-")
    {
        BtnArray := [], IncLabels := ":"
        Loop, % this.GetCount()
        {
            this.GetButton(A_Index, ID, Text, State, Style, Icon)
        ,   Label := this.Labels[ID], IncLabels .= Label ":"
        ,   cString := (Label ? (Label (Text ? "=" Text : "")
                    .    ":" Icon (Style ? "(" Style ")" : "")) : "") ", "
        ,   BtnString .= cString
            If (ArrayOut)
                BtnArray.Push({Icon: Icon-1, ID: ID, State: State
                                , Style: Style, Text: Text, Label: Label})
        }
        For i, Button in this.DefaultBtnInfo
        {
            If (!InStr(IncLabels, ":" (Label := this.Labels[Button.ID]) ":"))
            {
                If (!Label)
                    continue
                oString := Label (Button.Text ? "=" Button.Text : "")
                        .    ":" Button.Icon+1 (Button.Style ? "(" Button.Style ")" : "")
                BtnString .= HidMark oString ", "
            }
        }
        return ArrayOut ? BtnArray : RTrim(BtnString, ", ")
    }
;=======================================================================================
;    Method:             Get
;    Description:        Retrieves information from the toolbar.
;    Parameters:
;        HotItem:        OutputVar to store the 1-based index of current HotItem.
;        TextRows:       OutputVar to store the number of text rows
;        Rows:           OutputVar to store the number of rows for vertical toolbars.
;        BtnWidth:       OutputVar to store the buttons' width in pixels.
;        BtnHeight:      OutputVar to store the buttons' heigth in pixels.
;        Style:          OutputVar to store the current styles numeric value.
;        ExStyle:        OutputVar to store the current extended styles numeric value.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Get(ByRef HotItem := "", ByRef TextRows := "", ByRef Rows := ""
    ,   ByRef BtnWidth := "", ByRef BtnHeight := "", ByRef Style := "", ByRef ExStyle := "")
    {
        SendMessage, this.TB_GETHOTITEM, 0, 0,, % "ahk_id " this.tbHwnd
            HotItem := (ErrorLevel = 4294967295) ? 0 : ErrorLevel+1
        SendMessage, this.TB_GETTEXTROWS, 0, 0,, % "ahk_id " this.tbHwnd
            TextRows := ErrorLevel
        SendMessage, this.TB_GETROWS, 0, 0,, % "ahk_id " this.tbHwnd
            Rows := ErrorLevel
        SendMessage, this.TB_GETBUTTONSIZE, 0, 0,, % "ahk_id " this.tbHwnd
            this.MakeShort(ErrorLevel, BtnWidth, BtnHeight)
        SendMessage, this.TB_GETSTYLE, 0, 0,, % "ahk_id " this.tbHwnd
            Style := ErrorLevel
        SendMessage, this.TB_GETEXTENDEDSTYLE, 0, 0,, % "ahk_id " this.tbHwnd
            ExStyle := ErrorLevel
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             GetButton
;    Description:        Retrieves information from the toolbar buttons.
;    Parameters:
;        Button:         1-based index of the button.
;        ID:             OutputVar to store the button's command ID.
;        Text:           OutputVar to store the button's text caption.
;        State:          OutputVar to store the button's state numeric value.
;        Style:          OutputVar to store the button's style numeric value.
;        Icon:           OutputVar to store the button's icon index.
;        Label:          OutputVar to store the button's associated script label or function.
;        Index:          OutputVar to store the button's text string index.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    GetButton(Button, ByRef ID := "", ByRef Text := "", ByRef State := "", ByRef Style := ""
    ,   ByRef Icon := "", ByRef Label := "", ByRef Index := "")
    {
        VarSetCapacity(BtnVar, 8 + (A_PtrSize * 3), 0)
        SendMessage, this.TB_GETBUTTON, Button-1, &BtnVar,, % "ahk_id " this.tbHwnd
        ID := NumGet(&BtnVar, 4, "Int"), Icon := NumGet(&BtnVar, 0, "Int")+1
    ,   State := NumGet(&BtnVar, 8, "Char"), Style := NumGet(&BtnVar, 9, "Char")
    ,   Index := NumGet(&BtnVar, 8 + (A_PtrSize * 2), "Int"), Label := this.Labels[ID]
        SendMessage, this.TB_GETBUTTONTEXT, ID, 0,, % "ahk_id " this.tbHwnd
        VarSetCapacity(Buffer, ErrorLevel * (A_IsUnicode ? 2 : 1), 0)
        SendMessage, this.TB_GETBUTTONTEXT, ID, &Buffer,, % "ahk_id " this.tbHwnd
        Text := StrGet(&Buffer)
        return (ErrorLevel = "FAIL") ? false : true
        ; Alternative way to retrieve the button state.
        ; SendMessage, this.TB_GETSTATE, ID, 0,, % "ahk_id " this.tbHwnd
        ; State := ErrorLevel
    }
;=======================================================================================
;    Method:             GetButtonPos
;    Description:        Retrieves position and size of a specific button, relative to
;                            the toolbar control.
;    Parameters:
;        Button:         1-based index of the button.
;        OutX:           OutputVar to store the button's horizontal position.
;        OutY:           OutputVar to store the button's vertical position.
;        OutW:           OutputVar to store the button's width.
;        OutH:           OutputVar to store the button's height.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    GetButtonPos(Button, ByRef OutX := "", ByRef OutY := "", ByRef OutW := "", ByRef OutH := "")
    {
        this.GetButton(Button, BtnID), VarSetCapacity(RECT, 16, 0)
        SendMessage, this.TB_GETRECT, BtnID, &RECT,, % "ahk_id " this.tbHwnd
        OutX := NumGet(&RECT, 0, "Int"), OutY := NumGet(&RECT, 4, "Int")
    ,   OutW := NumGet(&RECT, 8, "Int") - OutX, OutH := NumGet(&RECT, 12, "Int") - OutY
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             GetButtonState
;    Description:        Retrieves the state of a button based on a querry.
;    Parameters:
;        StateQuerry:    Enter one of the following words to get the state of the button:
;                            Checked, Enabled, Hidden, Highlighted, Indeterminate, Pressed.
;    Return:             The TRUE if the StateQuerry is true, FALSE if it's not.
;=======================================================================================
    GetButtonState(Button, StateQuerry)
    {
        this.GetButton(Button, BtnID)
        If (this[ "TB_ISBUTTON" StateQuerry] )
            Msg := this[ "TB_ISBUTTON" StateQuerry ]
        SendMessage, Msg, BtnID, 0,, % "ahk_id " this.tbHwnd
        return ErrorLevel ? true : false
    }
;=======================================================================================
;    Method:             GetCount
;    Description:        Retrieves the total number of buttons.
;    Return:             The total number of buttons in the toolbar.
;=======================================================================================
    GetCount()
    {
        SendMessage, this.TB_BUTTONCOUNT, 0, 0,, % "ahk_id " this.tbHwnd
        return ErrorLevel
    }
;=======================================================================================
;    Method:             GetHiddenButtons
;    Description:        Retrieves which buttons are hidden when the toolbar size is 
;                            smaller then the total size of the buttons it has.
;                        This method is most useful when the toolbar is a child window of
;                            a Rebar control, in order to show a menu when the chevron is
;                            pushed. It does not retrieve buttons hidden by gui size.
;    Return:             An array with all buttons hidden by the Rebar band. Each key
;                            in the array has 4 properties: ID, Text, Label and Icon.
;=======================================================================================
    GetHiddenButtons()
    {
        ControlGetPos,,, tbWidth,,, % "ahk_id " this.tbHwnd
        VarSetCapacity(RECT, 16, 0), HiddenButtons := []
        Loop, % this.GetCount()
        {
            SendMessage, this.TB_GETITEMRECT, A_Index-1, &RECT,, % "ahk_id " this.tbHwnd
            If (NumGet(&RECT, 8, "Int") > tbWidth)
                this.GetButton(A_Index, ID, Text, "", "", Icon)
            ,   HiddenButtons.Push({ID: ID, Text: Text, Label: this.Labels[ID], Icon: Icon})
        }
        return HiddenButtons
    }
;=======================================================================================
;    Method:             Insert
;    Description:        Insert button(s) in specified postion.
;                        To insert a separator call this method without parameters.
;    Parameters:
;        Position:       1-based index of button position to insert the new buttons.
;        Options:        Same as Add().
;        Buttons:        Same as Add().
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Insert(Position, Options := "Enabled", Buttons*)
    {
        If (!Buttons.Length())
        {
            this.BtnSep(TBBUTTON, Options)
            SendMessage, this.TB_INSERTBUTTON, Position-1, &TBBUTTON,, % "ahk_id " this.tbHwnd
            If (ErrorLevel = "FAIL")
                return false
        }
        Else If (Options = "")
            Options := "Enabled"
        For i, Button in Buttons
        {
            If !(this.SendMessage(Button, Options, this.TB_INSERTBUTTON, (Position-1)+(i-1)))
                return false
        }
        return true
    }
;=======================================================================================
;    Method:             LabelToIndex
;    Description:        Converts a button label to its index in a toolbar.
;    Parameters:
;        Label:          Button's associated label or function.
;    Return:             The 1-based index for the button or FALSE if Label is invalid.
;=======================================================================================
    LabelToIndex(Label)
    {
        For ID, L in this.Labels
        {
            If (L = Label)
            {
                SendMessage, this.TB_COMMANDTOINDEX, ID, 0,, % "ahk_id " this.tbHwnd
                return ErrorLevel+1
            }
        }
        return false
    }
;=======================================================================================
;    Method:             ModifyButton
;    Description:        Sets button states.
;    Parameters:
;        Button:         1-based index of the button.
;        State:          Enter one word from the follwing list to change a button's
;                            state: Check, Enable, Hide, Mark, Press.
;        Set:            Enter TRUE or FALSE to set the state on/off.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    ModifyButton(Button, State, Set := true)
    {
        If State not in CHECK,ENABLE,HIDE,MARK,PRESS
            return false
        Message := this[ "TB_" State "BUTTON"]
    ,   this.GetButton(Button, BtnID)
        SendMessage, Message, BtnID, Set,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             ModifyButtonInfo
;    Description:        Sets button parameters such as Icon and CommandID.
;    Parameters:
;        Button:         1-based index of the button.
;        Property:       Enter one word from the following list to select the Property
;                            to be set: Command, Image, Size, State, Style, Text, Label.
;        Value:          The value to be set in the selected Property.
;                            If Property is State or Style you can enter named values as
;                            in the Add options.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    ModifyButtonInfo(Button, Property, Value)
    {
        If (Property = "Label")
        {
            this.GetButton(Button, ID), this.Labels[ID] := Value
            return true
        }
        If (Property = "State") || (Property = "Style")
        {
            If Value is Integer
                Value := Value
            Else
            {
                Loop, Parse, Value, %A_Space%%A_Tab%
                {
                    If (this[ "TBSTATE_" A_LoopField ])
                        tbState += this[ "TBSTATE_" A_LoopField ]
                    Else If (this[ "BTNS_" A_LoopField ] )
                        tbStyle += this[ "BTNS_" A_LoopField ]
                }
                Value := tb%Property%
            }
        }
        If (Property = "Command")
            this.GetButton(Button, "", "", "", "", "", Label), this.Labels[Value] := Label
        this.DefineBtnInfoStruct(TBBUTTONINFO, Property, Value)
    ,   this.GetButton(Button, BtnID)
        SendMessage, this.TB_SETBUTTONINFO, BtnID, &TBBUTTONINFO,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             MoveButton
;    Description:        Moves a toolbar button (change order).
;    Parameters:
;        Button:         1-based index of the button to be moved.
;        Target:         1-based index of the new position.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    MoveButton(Button, Target)
    {
        SendMessage, this.TB_MOVEBUTTON, Button-1, Target-1,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             OnMessage
;    Description:        Run label associated with button's Command identifier.
;                        This method should be called from a function monitoring the
;                            WM_COMMAND message. Pass the wParam as the CommandID.
;    Parameters:
;        CommandID:      Command ID associated with the button. This is send via
;                            WM_COMMAND message, you must pass the wParam from
;                            inside a function that monitors this message.
;        FuncParams:     In case the button is associated with a valid function,
;                            you may pass optional parameters for the function call.
;                            You can pass any number of parameters.
;    Return:             TRUE if target label or function exists, or FALSE otherwise.
;=======================================================================================
    OnMessage(CommandID, FuncParams*)
    {
        If (IsLabel(this.Labels[CommandID]))
        {
            GoSub, % this.Labels[CommandID]
            return true
        }
		Else If (IsFunc(this.Labels[CommandID]))
		{
			BtnFunc := this.Labels[CommandID]
		,	%BtnFunc%(FuncParams*)
			return true
		}
        Else
            return false
    }
;=======================================================================================
;    Method:             OnNotify
;    Description:        Handles toolbar notifications.
;                        This method should be called from a function monitoring the
;                            WM_NOTIFY message. Pass the lParam as the Param.
;                            The returned value should be used as return value for
;                            the monitoring function as well.
;    Parameters:
;        Param:          The lParam from WM_NOTIFY message.
;        MenuXPos:       OutputVar to store the horizontal position for a menu.
;        MenuYPos:       OutputVar to store the vertical position for a menu.
;        BtnLabel:       OutputVar to store the label or function name associated with the button.
;        ID:             OutputVar to store the button's Command ID.
;        AllowCustom:    Set to FALSE to prevent customization of toolbars.
;        AllowReset:     Set to FALSE to prevent Reset button from restoring original buttons.
;        HideHelp:       Set to FALSE to show the Help button in the customize dialog.
;    Return:             The required return value for the function monitoring
;                            the the WM_NOTIFY message.
;=======================================================================================
    OnNotify(ByRef Param, ByRef MenuXPos := "", ByRef MenuYPos := "", ByRef BtnLabel := "", ByRef ID := ""
    ,   AllowCustom := true, AllowReset := true, HideHelp := true)
    {
        nCode  := NumGet(Param + (A_PtrSize * 2), 0, "Int"), tbHwnd := NumGet(Param + 0, 0, "UPtr")
        If (tbHwnd != this.tbHwnd)
            return ""
        If (nCode = this.TBN_DROPDOWN)
        {
            ID  := NumGet(Param + (A_PtrSize * 3), 0, "Int"), BtnLabel := this.Labels[ID]
        ,   VarSetCapacity(RECT, 16, 0)
            SendMessage, this.TB_GETRECT, ID, &RECT,, % "ahk_id " this.tbHwnd
            ControlGetPos, TBX, TBY,,,, % "ahk_id " this.tbHwnd
            MenuXPos := TBX + NumGet(&RECT, 0, "Int"), MenuYPos := TBY + NumGet(&RECT, 12, "Int")
            return false
        }
        Else
            BtnLabel := "", ID := ""
        If (nCode = this.TBN_QUERYINSERT)
            return AllowCustom
        If (nCode = this.TBN_QUERYDELETE)
            return AllowCustom
        If (nCode = this.TBN_GETBUTTONINFO)
        {
            iItem := NumGet(Param + (A_PtrSize * 3), 0, "Int")
            If (iItem = this.DefaultBtnInfo.Length())
                return false
            For each, Member in this.DefaultBtnInfo[iItem+1]
                %each% := Member
            If (Text != "")
            {
                VarSetCapacity(BTNSTR, (StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))
            ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2)
                SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                Index := ErrorLevel, this.DefaultBtnInfo[iItem+1]["Index"] := Index
            ,   this.DefaultBtnInfo[iItem+1]["Text"] := Text
            }
            NumPut(Icon, Param + (A_PtrSize * 4), 0, "Int") ; iBitmap
        ,   NumPut(ID, Param + (A_PtrSize * 4), 4, "Int") ; idCommand
        ,   NumPut(State, Param + (A_PtrSize * 4), 8, "Char") ; tbState
        ,   NumPut(Style, Param + (A_PtrSize * 4), 9, "Char") ; tbStyle
        ,   NumPut(Index, Param + (A_PtrSize * 4), 8 + (A_PtrSize * 2), "Int") ; iString
            return true
        }
        If (nCode = this.TBN_TOOLBARCHANGE)
        {
            CurrentButtons := this.Export(true)
        ,   this.Presets.Load(CurrentButtons)
        ,   CurrentButtons := ""
        }
        If (nCode = this.TBN_RESET)
        {
            If (AllowReset)
            {
                this.Reset()
                return 2
            }
        }
        If (nCode = this.TBN_INITCUSTOMIZE)
            return HideHelp
        return ""
    }
;=======================================================================================
;    Method:             Reset
;    Description:        Restores all toolbar's buttons to default layout.
;                        Default layout is set by the buttons added. This can be changed
;                            calling the SetDefault method.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Reset()
    {
        BtnsArray := IsObject(CustomArray) ? CustomArray : this.DefaultBtnInfo
    ,   this.Get("", "", Rows)
        Loop, % this.GetCount()
            this.Delete(1)
        For each, Button in BtnsArray
        {
            For each, Member in Button
                %each% := Member
            If ((Rows > 1) && (Style = this.BTNS_SEP))
                State := 0x24
            If (Text != "")
            {
                VarSetCapacity(BTNSTR, (StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))
            ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2)
                SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                Index := ErrorLevel
            }
            VarSetCapacity(TBBUTTON, 8 + (A_PtrSize * 3), 0)
        ,   NumPut(Icon, TBBUTTON, 0, "Int")
        ,   NumPut(ID, TBBUTTON, 4, "Int")
        ,   NumPut(State, TBBUTTON, 8, "Char")
        ,   NumPut(Style, TBBUTTON, 9, "Char")
        ,   NumPut(Index, TBBUTTON, 8 + (A_PtrSize * 2), "Int")
            SendMessage, this.TB_ADDBUTTONS, 1, &TBBUTTON,, % "ahk_id " this.tbHwnd
        }
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetButtonSize
;    Description:        Sets the size of buttons on a toolbar. Affects current buttons.
;    Parameters:
;        W:              Width of buttons, in pixels
;        H:              Height of buttons, in pixels
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetButtonSize(W, H)
    {
        Long := this.MakeLong(W, H)
        SendMessage, this.TB_SETBUTTONSIZE, 0, Long,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetDefault
;    Description:        Sets the internal default layout to be used when customizing or
;                        when the Reset method is called.
;    Parameters:
;        Options:        Same as Add().
;        Buttons:        Same as Add().
;    Return:             Always TRUE.
;=======================================================================================
    SetDefault(Options := "Enabled", Buttons*)
    {
        this.DefaultBtnInfo := []
        If (!Buttons.Length())
            this.DefaultBtnInfo.Push({Icon: -1, ID: "", State: ""
                                       , Style: this.BTNS_SEP, Text: "", Label: ""})
        If (Options = "")
            Options := "Enabled"
        For each, Button in Buttons
            this.SendMessage(Button, Options)
        return true
    }
;=======================================================================================
;    Method:             SetExStyle
;    Description:        Sets toolbar's extended style.
;    Parameters:
;        Style:          Enter one or more words, separated by space or tab, from the
;                            following list to set toolbar's extended styles:
;                            Doublebuffer, DrawDDArrows, HideClippedButtons,
;                            MixedButtons.
;                        You may also enter an integer value to define the style.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetExStyle(Style)
    {
        If Style is Integer
            tbStyle_Ex_ := Style
        Else
        {
            Loop, Parse, Style, %A_Space%%A_Tab%
            {
                If (this[ "TBSTYLE_EX_" A_LoopField ] )
                    tbStyle_Ex_ += this[ "TBSTYLE_EX_" A_LoopField ]
            }
        }
        SendMessage, this.TB_SETEXTENDEDSTYLE, 0, tbStyle_Ex_,, % "ahk_id " this.tbHwnd
    }
;=======================================================================================
;    Method:             SetHotItem
;    Description:        Sets the hot item on a toolbar.
;    Parameters:
;        Button:         1-based index of the button.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetHotItem(Button)
    {
        SendMessage, this.TB_SETHOTITEM, Button-1, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetImageList
;    Description:        Sets an ImageList to the toolbar control.
;    Parameters:
;        IL_Default:     ImageList ID of default ImageList.
;        IL_Hot:         ImageList ID of Hot ImageList.
;        IL_Pressed:     ImageList ID of Pressed ImageList.
;        IL_Disabled:    ImageList ID of Disabled ImageList.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetImageList(IL_Default, IL_Hot := "", IL_Pressed := "", IL_Disabled := "")
    {
        SendMessage, this.TB_SETIMAGELIST, 0, IL_Default,, % "ahk_id " this.tbHwnd
        If (IL_Hot)
            SendMessage, this.TB_SETHOTIMAGELIST, 0, IL_Hot,, % "ahk_id " this.tbHwnd
        If (IL_Pressed)
            SendMessage, this.TB_SETPRESSEDIMAGELIST, 0, IL_Pressed,, % "ahk_id " this.tbHwnd
        If (IL_Disabled)
            SendMessage, this.TB_SETDISABLEDIMAGELIST, 0, IL_Disabled,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetIndent
;    Description:        Sets the indentation for the first button on a toolbar.
;    Parameters:
;        Value:          Value specifying the indentation, in pixels.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetIndent(Value)
    {
        SendMessage, this.TB_SETINDENT, Value, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetListGap
;    Description:        Sets the distance between icons and text on a toolbar.
;    Parameters:
;        Value:          The gap, in pixels, between buttons on the toolbar.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetListGap(Value)
    {
        SendMessage, this.TB_SETLISTGAP, Value, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetMaxTextRows
;    Description:        Sets maximum number of text rows for button captions.
;    Parameters:
;        MaxRows:        Maximum number of text rows. If omitted defaults to 0.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetMaxTextRows(MaxRows := 0)
    {
        SendMessage, this.TB_SETMAXTEXTROWS, MaxRows, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetPadding
;    Description:        Sets the padding for icons a toolbar. 
;    Parameters:
;        X:              Horizontal padding, in pixels
;        Y:              Vertical padding, in pixels
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetPadding(X, Y)
    {
        Long := this.MakeLong(X, Y)
        SendMessage, this.TB_SETPADDING, 0, Long,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetRows
;    Description:        Sets the number of rows for a toolbar.
;    Parameters:
;        Rows:           Number of rows to set. If omitted defaults to 0.
;        AddMore:        Indicates whether to create more rows than requested when the
;                            system cannot create the number of rows specified.
;                            If TRUE, the system creates more rows. If FALSE, the system
;                            creates fewer rows.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetRows(Rows := 0, AddMore := false)
    {
        Long := this.MakeLong(Rows, AddMore)
        SendMessage, this.TB_SETROWS, Long,,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             ToggleStyle
;    Description:        Toggles toolbar's style.
;    Parameters:
;        Style:          Enter zero or more words, separated by space or tab, from the
;                            following list to toggle toolbar's styles:
;                            AltDrag, CustomErase, Flat, List, RegisterDrop, Tooltips,
;                            Transparent, Wrapable, Adjustable, Border, ThickFrame,
;                            TabStop.
;                        You may also enter an integer value to define the style.
;    Return:             TRUE if a valid style is passed, or FALSE otherwise.
;=======================================================================================
    ToggleStyle(Style)
    {
        If Style is Integer
            tbStyle := Style
        Else
        {
            Loop, Parse, Style, %A_Space%%A_Tab%
            {
                If (this[ "TBSTYLE_" A_LoopField ] )
                    tbStyle += this[ "TBSTYLE_" A_LoopField ]
            }
        }
        ; TB_SETSTYLE moves the toolbar away from its position for some reason.
        ; SendMessage, this.TB_SETSTYLE, 0, tbStyle,, % "ahk_id " this.tbHwnd
        If (tbStyle != "")
        {
            WinSet, Style, ^%tbStyle%, % "ahk_id " this.tbHwnd
            return true
        }
        Else
            return false
    }
;=======================================================================================
;    Presets Methods     These methods are used exclusively by the Presets Object.
;                        Presets can be used to quickly change buttons of a toolbar
;                            to predetermined or saved layouts.
;=======================================================================================
    Class tbPresets extends Toolbar.Private
    {
;=======================================================================================
;    Method:             Presets.Delete
;    Description:        Deletes the layout of the specified slot. 
;    Parameters:
;        Slot:           Number of the slot containing the layout to be deleted.
;    Return:             TRUE if the slot contains a layout, or FALSE otherwise.
;=======================================================================================
        Delete(Slot)
        {
            If (IsObject(this[Slot]))
            {
                this.Delete(Slot)
                return true
            }
            Else
                return false
        }
;=======================================================================================
;    Method:             Presets.Export
;    Description:        Returns a text string with buttons and order in Add and
;                            Insert methods compatible format from the specified slot.
;    Parameters:
;        Slot:           Number of the slot in which to save the layout.
;        ArrayOut:       Set to TRUE to return an object array. The returned object
;                            format is compatible with Presets.Save and Presets.Load
;                            methods, which can be used to save and load layout presets.
;    Return:             A text string with buttons information to be exported.
;=======================================================================================
        Export(Slot, ArrayOut := false)
        {
            BtnArray := []
            For i, Button in this[Slot]
            {
                For each, Member in Button
                    %each% := Member
                BtnString .= (Label ? (Label (Text ? "=" Text : "")
                        .    ":" Icon+1 (Style ? "(" Style ")" : "")) : "") ", "
                If (ArrayOut)
                    BtnArray.Push({Icon: Icon, ID: ID, State: State
                                   , Style: Style, Text: Text, Label: Label})
            }
            return ArrayOut ? BtnArray : RTrim(BtnString, ", ")
        }
;=======================================================================================
;    Method:             Presets.Import
;    Description:        Imports a buttons layout from a string in Add/Insert methods
;                            format and saves it into the specified slot.
;    Parameters:
;        Slot:           Number of the slot in which to save the layout.
;        Options:        Same as Add().
;        Buttons:        Same as Add().
;    Return:             Always TRUE.
;=======================================================================================
        Import(Slot, Options := "Enabled", Buttons*)
        {
            BtnArray := []
            If (Options = "")
                Options := "Enabled"
            For each, Button in Buttons
            {
                If (RegExMatch(Button, "^(\W?)(\w+)[=\s]?(.*)?:(\d+)\(?(.*?)?\)?$", Key))
                {
                    If (Key1)
                        continue
                    idCommand := this.GenerateRandomID()
                ,   iString := Key3, iBitmap := Key4
                ,   Struct := this.DefineBtnStruct(TBBUTTON, iBitmap, idCommand, iString, Key5 ? Key5 : Options)
                ,   Struct.Label := Key2, BtnArray.Push(Struct)
                }
                Else
                    Struct := this.BtnSep(TBBUTTON, Options), BtnArray.Push(Struct)
            }
            this[Slot] := BtnArray
            return true
        }
;=======================================================================================
;    Method:             Presets.Load
;    Description:        Loads a layout from the specified slot.
;    Parameters:
;        Slot:           Number of the slot containing the layout to be loaded.
;                        For convenience and internal operations this parameter can be an
;                            object in the same format of Presets.Save Buttons parameter.
;    Return:             TRUE if the slot contains a layout, or FALSE otherwise.
;=======================================================================================
        Load(Slot)
        {
            If (IsObject(Slot))
                Buttons := Slot
            Else
                Buttons := this[Slot]
            If (!IsObject(Buttons))
                return false
            SendMessage, this.TB_GETROWS, 0, 0,, % "ahk_id " this.tbHwnd
                Rows := ErrorLevel
            SendMessage, this.TB_BUTTONCOUNT, 0, 0,, % "ahk_id " this.tbHwnd
            Loop, % ErrorLevel
                SendMessage, this.TB_DELETEBUTTON, 0, 0,, % "ahk_id " this.tbHwnd
            For each, Button in Buttons
            {
                For each, Member in Button
                    %each% := Member
                If ((Rows > 1) && (Style = this.BTNS_SEP))
                    State := 0x24
                If (Text != "")
                {
                    VarSetCapacity(BTNSTR, (StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))
                ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2)
                    SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                    Index := ErrorLevel
                }
                VarSetCapacity(TBBUTTON, 8 + (A_PtrSize * 3), 0)
            ,   NumPut(Icon, TBBUTTON, 0, "Int")
            ,   NumPut(ID, TBBUTTON, 4, "Int")
            ,   NumPut(State, TBBUTTON, 8, "Char")
            ,   NumPut(Style, TBBUTTON, 9, "Char")
            ,   NumPut(Index, TBBUTTON, 8 + (A_PtrSize * 2), "Int")
                SendMessage, this.TB_ADDBUTTONS, 1, &TBBUTTON,, % "ahk_id " this.tbHwnd
            }
            return (ErrorLevel = "FAIL") ? false : true
        }
;=======================================================================================
;    Method:             Presets.Save
;    Description:        Saves a buttons layout as a preset into the specified slot. 
;    Parameters:
;        Slot:           Number of the slot in which to save the layout. There is no
;                            predefined limit of slots.
;        Buttons:        Buttons array must be in a valid format. You can use the Export
;                            Toolbar Method (not the Preset Method of the same name)
;                            passing TRUE to the ArrayOut parameter to return a valid
;                            array to be used with this method.
;    Return:             TRUE if Buttons is an object, or FALSE otherwise.
;=======================================================================================
        Save(Slot, Buttons)
        {
            If (IsObject(Buttons))
            {
                this[Slot] := Buttons
                return true
            }
            Else
                return false
        }
    }
;=======================================================================================
;    Private Class       This class is used internally.
;=======================================================================================
    Class Private
    {
;=======================================================================================
;    Private Properties
;=======================================================================================
        ; Messages
        Static TB_ADDBUTTONS            := 0x0414
        Static TB_ADDSTRING             := A_IsUnicode ? 0x044D : 0x041C
        Static TB_AUTOSIZE              := 0x0421
        Static TB_BUTTONCOUNT           := 0x0418
        Static TB_CHECKBUTTON           := 0x0402
        Static TB_COMMANDTOINDEX        := 0x0419
        Static TB_CUSTOMIZE             := 0x041B
        Static TB_DELETEBUTTON          := 0x0416
        Static TB_ENABLEBUTTON          := 0x0401
        Static TB_GETBUTTON             := 0x0417
        Static TB_GETBUTTONSIZE         := 0x043A
        Static TB_GETBUTTONTEXT         := A_IsUnicode ? 0x044B : 0x042D
        Static TB_GETEXTENDEDSTYLE      := 0x0455
        Static TB_GETHOTITEM            := 0x0447
        Static TB_GETIMAGELIST          := 0x0431
        Static TB_GETIMAGELISTCOUNT     := 0x0462
        Static TB_GETITEMDROPDOWNRECT   := 0x0467
        Static TB_GETITEMRECT           := 0x041D
        Static TB_GETMAXSIZE            := 0x0453
        Static TB_GETPADDING            := 0x0456
        Static TB_GETRECT               := 0x0433
        Static TB_GETROWS               := 0x0428
        Static TB_GETSTATE              := 0x0412
        Static TB_GETSTYLE              := 0x0439
        Static TB_GETSTRING             := A_IsUnicode ? :0x045B 0x045C
        Static TB_GETTEXTROWS           := 0x043D
        Static TB_HIDEBUTTON            := 0x0404
        Static TB_INDETERMINATE         := 0x0405
        Static TB_INSERTBUTTON          := A_IsUnicode ? 0x0443 : 0x0415
        Static TB_ISBUTTONCHECKED       := 0x040A
        Static TB_ISBUTTONENABLED       := 0x0409
        Static TB_ISBUTTONHIDDEN        := 0x040C
        Static TB_ISBUTTONHIGHLIGHTED   := 0x040E
        Static TB_ISBUTTONINDETERMINATE := 0x040D
        Static TB_ISBUTTONPRESSED       := 0x040B
        Static TB_MARKBUTTON            := 0x0406
        Static TB_MOVEBUTTON            := 0x0452
        Static TB_PRESSBUTTON           := 0x0403
        Static TB_SETBUTTONINFO         := A_IsUnicode ? 0x0440 : 0x0442
        Static TB_SETBUTTONSIZE         := 0x041F
        Static TB_SETBUTTONWIDTH        := 0x043B
        Static TB_SETDISABLEDIMAGELIST  := 0x0436
        Static TB_SETEXTENDEDSTYLE      := 0x0454
        Static TB_SETHOTIMAGELIST       := 0x0434
        Static TB_SETHOTITEM            := 0x0448
        Static TB_SETHOTITEM2           := 0x045E
        Static TB_SETIMAGELIST          := 0x0430
        Static TB_SETINDENT             := 0x042F
        Static TB_SETLISTGAP            := 0x0460
        Static TB_SETMAXTEXTROWS        := 0x043C
        Static TB_SETPADDING            := 0x0457
        Static TB_SETPRESSEDIMAGELIST   := 0x0468
        Static TB_SETROWS               := 0x0427
        Static TB_SETSTATE              := 0x0411
        Static TB_SETSTYLE              := 0x0438
        ; Styles
        Static TBSTYLE_ALTDRAG      := 0x0400
        Static TBSTYLE_CUSTOMERASE  := 0x2000
        Static TBSTYLE_FLAT         := 0x0800
        Static TBSTYLE_LIST         := 0x1000
        Static TBSTYLE_REGISTERDROP := 0x4000
        Static TBSTYLE_TOOLTIPS     := 0x0100
        Static TBSTYLE_TRANSPARENT  := 0x8000
        Static TBSTYLE_WRAPABLE     := 0x0200
        Static TBSTYLE_ADJUSTABLE   := 0x20
        Static TBSTYLE_BORDER       := 0x800000
        Static TBSTYLE_THICKFRAME   := 0x40000
        Static TBSTYLE_TABSTOP      := 0x10000
        ; ExStyles
        Static TBSTYLE_EX_DOUBLEBUFFER       := 0x80 ; // Double Buffer the toolbar
        Static TBSTYLE_EX_DRAWDDARROWS       := 0x01
        Static TBSTYLE_EX_HIDECLIPPEDBUTTONS := 0x10 ; // don't show partially obscured buttons
        Static TBSTYLE_EX_MIXEDBUTTONS       := 0x08
        Static TBSTYLE_EX_MULTICOLUMN        := 0x02 ; // Intended for internal use; not recommended for use in applications.
        Static TBSTYLE_EX_VERTICAL           := 0x04 ; // Intended for internal use; not recommended for use in applications.
        ; Button states
        Static TBSTATE_CHECKED       := 0x01
        Static TBSTATE_ELLIPSES      := 0x40
        Static TBSTATE_ENABLED       := 0x04
        Static TBSTATE_HIDDEN        := 0x08
        Static TBSTATE_INDETERMINATE := 0x10
        Static TBSTATE_MARKED        := 0x80
        Static TBSTATE_PRESSED       := 0x02
        Static TBSTATE_WRAP          := 0x20
        ; Button styles
        Static BTNS_BUTTON        := 0x00 ; TBSTYLE_BUTTON
        Static BTNS_SEP           := 0x01 ; TBSTYLE_SEP
        Static BTNS_CHECK         := 0x02 ; TBSTYLE_CHECK
        Static BTNS_GROUP         := 0x04 ; TBSTYLE_GROUP
        Static BTNS_CHECKGROUP    := 0x06 ; TBSTYLE_CHECKGROUP  // (TBSTYLE_GROUP | TBSTYLE_CHECK)
        Static BTNS_DROPDOWN      := 0x08 ; TBSTYLE_DROPDOWN
        Static BTNS_AUTOSIZE      := 0x10 ; TBSTYLE_AUTOSIZE    // automatically calculate the cx of the button
        Static BTNS_NOPREFIX      := 0x20 ; TBSTYLE_NOPREFIX    // this button should not have accel prefix
        Static BTNS_SHOWTEXT      := 0x40 ; // ignored unless TBSTYLE_EX_MIXEDBUTTONS is set
        Static BTNS_WHOLEDROPDOWN := 0x80 ; // draw drop-down arrow, but without split arrow section
        ; TB_GETBITMAPFLAGS
        Static TBBF_LARGE   := 0x00000001
        Static TBIF_BYINDEX := 0x80000000 ; // this specifies that the wparam in Get/SetButtonInfo is an index, not id
        Static TBIF_COMMAND := 0x00000020
        Static TBIF_IMAGE   := 0x00000001
        Static TBIF_LPARAM  := 0x00000010
        Static TBIF_SIZE    := 0x00000040
        Static TBIF_STATE   := 0x00000004
        Static TBIF_STYLE   := 0x00000008
        Static TBIF_TEXT    := 0x00000002
        ; Notifications
        Static TBN_BEGINADJUST     := -703
        Static TBN_BEGINDRAG       := -701
        Static TBN_CUSTHELP        := -709
        Static TBN_DELETINGBUTTON  := -715
        Static TBN_DRAGOUT         := -714
        Static TBN_DRAGOVER        := -727
        Static TBN_DROPDOWN        := -710
        Static TBN_DUPACCELERATOR  := -725
        Static TBN_ENDADJUST       := -704
        Static TBN_ENDDRAG         := -702
        Static TBN_GETBUTTONINFO   := -720 ; A_IsUnicode ? -720 : -700
        Static TBN_GETDISPINFO     := A_IsUnicode ? -717 : -716
        Static TBN_GETINFOTIP      := A_IsUnicode ? -719 : -718
        Static TBN_GETOBJECT       := -712
        Static TBN_HOTITEMCHANGE   := -713
        Static TBN_INITCUSTOMIZE   := -723
        Static TBN_MAPACCELERATOR  := -728
        Static TBN_QUERYDELETE     := -707
        Static TBN_QUERYINSERT     := -706
        Static TBN_RESET           := -705
        Static TBN_RESTORE         := -721
        Static TBN_SAVE            := -722
        Static TBN_TOOLBARCHANGE   := -708
        Static TBN_WRAPACCELERATOR := -726
        Static TBN_WRAPHOTITEM     := -724
;=======================================================================================
;    Meta-Functions
;
;    Properties:
;        tbHwnd:            Toolbar's Hwnd.
;        DefaultBtnInfo:    Stores information about button's original structures.
;        Presets:           This is a special object used to save and load buttons
;                               layouts. It has its own methods.
;=======================================================================================
        __New(hToolbar)
        {
            this.tbHwnd := hToolbar
        ,   this.DefaultBtnInfo := []
        ,   this.Presets := {tbHwnd: hToolbar, Base: Toolbar.tbPresets}
        }
;=======================================================================================
        __Delete()
        {
            this.RemoveAt(1, this.Length())
        ,   this.SetCapacity(0)
        ,   this.base := ""
        }
;=======================================================================================
;    Private Methods
;=======================================================================================
;    Method:             SendMessage
;    Description:        Sends a message to create or modify a button.
;=======================================================================================
        SendMessage(Button, Options, Message := "", Param := "")
        {
            If (RegExMatch(Button, "^(\W?)(\w+)[=\s]?(.*)?:(\d+)\(?(.*?)?\)?$", Key))
            {
                idCommand := this.GenerateRandomID()
            ,   iString := Key3, iBitmap := Key4
            ,   this.Labels[idCommand] := Key2
            ,   Struct := this.DefineBtnStruct(TBBUTTON, iBitmap, idCommand, iString, Key5 ? Key5 : Options)
            ,   this.DefaultBtnInfo.Push(Struct)
                If !(Key1) && (Message)
                {
                    SendMessage, Message, Param, &TBBUTTON,, % "ahk_id " this.tbHwnd
                    If (ErrorLevel = "FAIL")
                        return false
                }
            }
            Else
            {
                Struct := this.BtnSep(TBBUTTON, Options), this.DefaultBtnInfo.Push(Struct)
                If (Message)
                {
                    SendMessage, Message, Param, &TBBUTTON,, % "ahk_id " this.tbHwnd
                    If (ErrorLevel = "FAIL")
                        return false
                }
            }
            return true
        }
;=======================================================================================
;    Method:             DefineBtnStruct
;    Description:        Creates a TBBUTTON structure.
;    Return:             An array with the button structure values.
;=======================================================================================
        DefineBtnStruct(ByRef BtnVar, iBitmap := 0, idCommand := 0, iString := "", Options := "")
        {
            If Options is Integer
                tbStyle := Options, tbState := this.TBSTATE_ENABLED
            Else
            {
                Loop, Parse, Options, %A_Space%%A_Tab%
                {
                    If (this[ "TBSTATE_" A_LoopField ])
                        tbState += this[ "TBSTATE_" A_LoopField ]
                    Else If (this[ "BTNS_" A_LoopField ] )
                        tbStyle += this[ "BTNS_" A_LoopField ]
                    Else If (RegExMatch(A_LoopField, "i)W(\d+)-(\d+)", MW))
                    {
                        Long := this.MakeLong(MW1, MW2)
                        SendMessage, this.TB_SETBUTTONWIDTH, 0, Long,, % "ahk_id " this.tbHwnd
                    }
                }
            }
            If (iString != "")
            {
                VarSetCapacity(BTNSTR, (StrPut(iString) * (A_IsUnicode ? 2 : 1), 0))
            ,   StrPut(iString, &BTNSTR, StrPut(iString) * 2)
                SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                StrIdx := ErrorLevel
            }
            Else
                StrIdx := -1
            VarSetCapacity(BtnVar, 8 + (A_PtrSize * 3), 0)
        ,   NumPut(iBitmap-1, BtnVar, 0, "Int")
        ,   NumPut(idCommand, BtnVar, 4, "Int")
        ,   NumPut(tbState, BtnVar, 8, "Char")
        ,   NumPut(tbStyle, BtnVar, 9, "Char")
        ,   NumPut(StrIdx, BtnVar, 8 + (A_PtrSize * 2), "Ptr")
            return {Icon: iBitmap-1, ID: idCommand, State: tbState
                   , Style: tbStyle, Text: iString, Label: this.Labels[idCommand]}
        }
;=======================================================================================
;    Method:             DefineBtnInfoStruct
;    Description:        Creates a TBBUTTONINFO structure for a specific member.
;=======================================================================================
        DefineBtnInfoStruct(ByRef BtnVar, Member, ByRef Value)
        {
            Static cbSize := 16 + (A_PtrSize * 4)
            
            VarSetCapacity(BtnVar, cbSize, 0)
        ,   NumPut(cbSize, BtnVar, 0, "UInt")
            If (this[ "TBIF_" Member] )
                dwMask := this[ "TBIF_" Member ]
            ,   NumPut(dwMask, BtnVar, 4, "UInt")
            If (dwMask = this.TBIF_COMMAND)
                NumPut(Value, BtnVar, 8, "Int") ; idCommand
            Else If (dwMask = this.TBIF_IMAGE)
                Value := Value-1
            ,   NumPut(Value, BtnVar, 12, "Int") ; iImage
            Else If (dwMask = this.TBIF_STATE)
                Value := (this[ "TBSTATE_" Value ]) ? this[ "TBSTATE_" Value ] : Value
            ,   NumPut(Value, BtnVar, 16, "Char") ; fsState
            Else If (dwMask = this.TBIF_STYLE)
                Value := (this[ "BTNS_" Value ]) ? this[ "BTNS_" Value ] : Value
            ,   NumPut(Value, BtnVar, 17, "Char") ; fsStyle
            Else If (dwMask = this.TBIF_SIZE)
                NumPut(Value, BtnVar, 18, "Short") ; cx
            Else If (dwMask = this.TBIF_TEXT)
                NumPut(&Value, BtnVar, 16 + (A_PtrSize * 2), "UPtr") ; pszText
        }
;=======================================================================================
;    Method:             BtnSep
;    Description:        Creates a TBBUTTON structure for a separator.
;    Return:             An array with the button structure values.
;=======================================================================================
        BtnSep(ByRef BtnVar, Options := "")
        {
            tbStyle := this.BTNS_SEP
            Loop, Parse, Options, %A_Space%%A_Tab%
            {
                If (this[ "TBSTATE_" A_LoopField ])
                    tbState += this[ "TBSTATE_" A_LoopField ]
            }
            VarSetCapacity(BtnVar, 8 + (A_PtrSize * 3), 0)
        ,   NumPut(tbState, BtnVar, 8, "Char")
        ,   NumPut(tbStyle, BtnVar, 9, "Char")
            return {Icon: -1, ID: "", State: tbState, Style: tbStyle, Text: "", Label: ""}
        }
;=======================================================================================
;    Method:             GenerateRandomID
;    Description:        Returns a random number to be used as Command ID.
;=======================================================================================
        GenerateRandomID()
        {
            While, (!Number || this.Labels.HasKey(Number))
                Random, Number, 1, 9999
            return Number
        }
;=======================================================================================
;    Method:             MakeLong
;    Description:        Creates a LongWord from a LoWord and a HiWord.
;=======================================================================================
        MakeLong(LoWord, HiWord)
        {
            return (HiWord << 16) | (LoWord & 0xffff)
        }
;=======================================================================================
;    Method:             MakeLong
;    Description:        Extracts LoWord and HiWord from a LongWord.
;=======================================================================================
        MakeShort(Long, ByRef LoWord, ByRef HiWord)
        {
            LoWord := Long & 0xffff
        ,   HiWord := Long >> 16
        }
    }
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Save
; ChangeLog ....: 06/08/2023 - v1 - With #IfWinActive ahk_exe hznhorizon.exe, added CTRL+S
; . Continued ..: Added FindText() function to bottom of script using the-automator.com script
; . Continued ..: Added the "specific text", which is really a picture convereted to base64 (to text) of the Save icon
; ----------------------------------------------------------------------------------------------------------------------
/*
^s::

Text:="|<>*152$47.0000000000000000000000000000000003zzz0000Dzzz0000P00q0000q01w0001g03s0003M06k0006k0BU000BU0P0000P00q0000q01g0001g03M00037zsk0006DzlU000A0030000Mzzq0000lzzg0001XzXM00037z6k0006DyBU000ATwP00007zzy01"

if ok:=FindText(23,92,150000,150000,0,0,Text)
{
	CoordMode, Mouse
	X:=ok.1, Y:=ok.2, W:=ok.3, H:=ok.4, Comment:=ok.5
	ControlClick, X+W//2, Y+H//2
}
return
*/
;===== Copy The Following Functions To Your Own Code Just once =====


; Note: parameters of the X,Y is the center of the coordinates,
; and the W,H is the offset distance to the center,
; So the search range is (X-W, Y-H)-->(X+W, Y+H).
; err1 is the character "0" fault-tolerant in percentage.
; err0 is the character "_" fault-tolerant in percentage.
; Text can be a lot of text to find, separated by "|".
; ruturn is a array, contains the X,Y,W,H,Comment results of Each Find.
/*


FindText(x,y,w,h,err1,err0,text)
{
  xywh2xywh(x-w,y-h,2*w+1,2*h+1,x,y,w,h)
  if (w<1 or h<1)
    return, 0
  bch:=A_BatchLines
  SetBatchLines, -1
  ;--------------------------------------
  GetBitsFromScreen(x,y,w,h,Scan0,Stride,bits)
  ;--------------------------------------
  sx:=0, sy:=0, sw:=w, sh:=h, arr:=[]
  Loop, 2 {
  Loop, Parse, text, |
  {
    v:=A_LoopField
    IfNotInString, v, $, Continue
    Comment:="", e1:=err1, e0:=err0
    ; You Can Add Comment Text within The <>
    if RegExMatch(v,"<([^>]*)>",r)
      v:=StrReplace(v,r), Comment:=Trim(r1)
    ; You can Add two fault-tolerant in the [], separated by commas
    if RegExMatch(v,"\[([^\]]*)]",r)
    {
      v:=StrReplace(v,r), r1.=","
      StringSplit, r, r1, `,
      e1:=r1, e0:=r2
    }
    StringSplit, r, v, $
    color:=r1, v:=r2
    StringSplit, r, v, .
    w1:=r1, v:=base64tobit(r2), h1:=StrLen(v)//w1
    if (r0<2 or h1<1 or w1>sw or h1>sh or StrLen(v)!=w1*h1)
      Continue
    ;--------------------------------------------
    if InStr(color,"-")
    {
      r:=e1, e1:=e0, e0:=r, v:=StrReplace(v,"1","_")
      v:=StrReplace(StrReplace(v,"0","1"),"_","0")
    }
    mode:=InStr(color,"*") ? 1:0
    color:=RegExReplace(color,"[*\-]") . "@"
    StringSplit, r, color, @
    color:=Round(r1), n:=Round(r2,2)+(!r2)
    n:=Floor(255*3*(1-n)), k:=StrLen(v)*4
    VarSetCapacity(ss, sw*sh, Asc("0"))
    VarSetCapacity(s1, k, 0), VarSetCapacity(s0, k, 0)
    VarSetCapacity(rx, 8, 0), VarSetCapacity(ry, 8, 0)
    len1:=len0:=0, j:=sw-w1+1, i:=-j
    ListLines, Off
    Loop, Parse, v
    {
      i:=Mod(A_Index,w1)=1 ? i+j : i+1
      if A_LoopField
        NumPut(i, s1, 4*len1++, "int")
      else
        NumPut(i, s0, 4*len0++, "int")
    }
    ListLines, On
    e1:=Round(len1*e1), e0:=Round(len0*e0)
    ;--------------------------------------------
    if PicFind(mode,color,n,Scan0,Stride,sx,sy,sw,sh
      ,ss,s1,s0,len1,len0,e1,e0,w1,h1,rx,ry)
    {
      rx+=x, ry+=y
      arr.Push(rx,ry,w1,h1,Comment)
    }
  }
  if (arr.MaxIndex())
    Break
  if (A_Index=1 and err1=0 and err0=0)
    err1:=0.05, err0:=0.05
  else Break
  }
  SetBatchLines, %bch%
  return, arr.MaxIndex() ? arr:0
}

PicFind(mode, color, n, Scan0, Stride
  , sx, sy, sw, sh, ByRef ss, ByRef s1, ByRef s0
  , len1, len0, err1, err0, w, h, ByRef rx, ByRef ry)
{
  static MyFunc
  if !MyFunc
  {
    x32:="5589E583EC408B45200FAF45188B551CC1E20201D08945F"
    . "48B5524B80000000029D0C1E00289C28B451801D08945D8C74"
    . "5F000000000837D08000F85F00000008B450CC1E81025FF000"
    . "0008945D48B450CC1E80825FF0000008945D08B450C25FF000"
    . "0008945CCC745F800000000E9AC000000C745FC00000000E98"
    . "A0000008B45F483C00289C28B451401D00FB6000FB6C02B45D"
    . "48945EC8B45F483C00189C28B451401D00FB6000FB6C02B45D"
    . "08945E88B55F48B451401D00FB6000FB6C02B45CC8945E4837"
    . "DEC007903F75DEC837DE8007903F75DE8837DE4007903F75DE"
    . "48B55EC8B45E801C28B45E401D03B45107F0B8B55F08B452C0"
    . "1D0C600318345FC018345F4048345F0018B45FC3B45240F8C6"
    . "AFFFFFF8345F8018B45D80145F48B45F83B45280F8C48FFFFF"
    . "FE9A30000008B450C83C00169C0E803000089450CC745F8000"
    . "00000EB7FC745FC00000000EB648B45F483C00289C28B45140"
    . "1D00FB6000FB6C069D02B0100008B45F483C00189C18B45140"
    . "1C80FB6000FB6C069C04B0200008D0C028B55F48B451401D00"
    . "FB6000FB6C06BC07201C83B450C730B8B55F08B452C01D0C60"
    . "0318345FC018345F4048345F0018B45FC3B45247C948345F80"
    . "18B45D80145F48B45F83B45280F8C75FFFFFF8B45242B45488"
    . "3C0018945488B45282B454C83C00189454C8B453839453C0F4"
    . "D453C8945D8C745F800000000E9E3000000C745FC00000000E"
    . "9C70000008B45F80FAF452489C28B45FC01D08945F48B45408"
    . "945E08B45448945DCC745F000000000EB708B45F03B45387D2"
    . "E8B45F08D1485000000008B453001D08B108B45F401D089C28"
    . "B452C01D00FB6003C31740A836DE001837DE00078638B45F03"
    . "B453C7D2E8B45F08D1485000000008B453401D08B108B45F40"
    . "1D089C28B452C01D00FB6003C30740A836DDC01837DDC00783"
    . "08345F0018B45F03B45D87C888B551C8B45FC01C28B4550891"
    . "08B55208B45F801C28B45548910B801000000EB2990EB01908"
    . "345FC018B45FC3B45480F8C2DFFFFFF8345F8018B45F83B454"
    . "C0F8C11FFFFFFB800000000C9C25000"
    x64:="554889E54883EC40894D10895518448945204C894D288B4"
    . "5400FAF45308B5538C1E20201D08945F48B5548B8000000002"
    . "9D0C1E00289C28B453001D08945D8C745F000000000837D100"
    . "00F85000100008B4518C1E81025FF0000008945D48B4518C1E"
    . "80825FF0000008945D08B451825FF0000008945CCC745F8000"
    . "00000E9BC000000C745FC00000000E99A0000008B45F483C00"
    . "24863D0488B45284801D00FB6000FB6C02B45D48945EC8B45F"
    . "483C0014863D0488B45284801D00FB6000FB6C02B45D08945E"
    . "88B45F44863D0488B45284801D00FB6000FB6C02B45CC8945E"
    . "4837DEC007903F75DEC837DE8007903F75DE8837DE4007903F"
    . "75DE48B55EC8B45E801C28B45E401D03B45207F108B45F0486"
    . "3D0488B45584801D0C600318345FC018345F4048345F0018B4"
    . "5FC3B45480F8C5AFFFFFF8345F8018B45D80145F48B45F83B4"
    . "5500F8C38FFFFFFE9B60000008B451883C00169C0E80300008"
    . "94518C745F800000000E98F000000C745FC00000000EB748B4"
    . "5F483C0024863D0488B45284801D00FB6000FB6C069D02B010"
    . "0008B45F483C0014863C8488B45284801C80FB6000FB6C069C"
    . "04B0200008D0C028B45F44863D0488B45284801D00FB6000FB"
    . "6C06BC07201C83B451873108B45F04863D0488B45584801D0C"
    . "600318345FC018345F4048345F0018B45FC3B45487C848345F"
    . "8018B45D80145F48B45F83B45500F8C65FFFFFF8B45482B859"
    . "000000083C0018985900000008B45502B859800000083C0018"
    . "985980000008B45703945780F4D45788945D8C745F80000000"
    . "0E90B010000C745FC00000000E9EC0000008B45F80FAF45488"
    . "9C28B45FC01D08945F48B85800000008945E08B85880000008"
    . "945DCC745F000000000E9800000008B45F03B45707D368B45F"
    . "04898488D148500000000488B45604801D08B108B45F401D04"
    . "863D0488B45584801D00FB6003C31740A836DE001837DE0007"
    . "8778B45F03B45787D368B45F04898488D148500000000488B4"
    . "5684801D08B108B45F401D04863D0488B45584801D00FB6003"
    . "C30740A836DDC01837DDC00783C8345F0018B45F03B45D80F8"
    . "C74FFFFFF8B55388B45FC01C2488B85A000000089108B55408"
    . "B45F801C2488B85A80000008910B801000000EB2F90EB01908"
    . "345FC018B45FC3B85900000000F8C05FFFFFF8345F8018B45F"
    . "83B85980000000F8CE6FEFFFFB8000000004883C4405DC390"
    MCode(MyFunc, A_PtrSize=8 ? x64:x32)
  }
  return, DllCall(&MyFunc, "int",mode
    , "uint",color, "int",n, "ptr",Scan0, "int",Stride
    , "int",sx, "int",sy, "int",sw, "int",sh
    , "ptr",&ss, "ptr",&s1, "ptr",&s0
    , "int",len1, "int",len0, "int",err1, "int",err0
    , "int",w, "int",h, "int*",rx, "int*",ry)
}

xywh2xywh(x1,y1,w1,h1,ByRef x,ByRef y,ByRef w,ByRef h)
{
  SysGet, zx, 76
  SysGet, zy, 77
  SysGet, zw, 78
  SysGet, zh, 79
  left:=x1, right:=x1+w1-1, up:=y1, down:=y1+h1-1
  left:=left<zx ? zx:left, right:=right>zx+zw-1 ? zx+zw-1:right
  up:=up<zy ? zy:up, down:=down>zy+zh-1 ? zy+zh-1:down
  x:=left, y:=up, w:=right-left+1, h:=down-up+1
}

GetBitsFromScreen(x,y,w,h,ByRef Scan0,ByRef Stride,ByRef bits)
{
  VarSetCapacity(bits,w*h*4,0), bpp:=32
  Scan0:=&bits, Stride:=((w*bpp+31)//32)*4
  Ptr:=A_PtrSize ? "UPtr" : "UInt", PtrP:=Ptr . "*"
  win:=DllCall("GetDesktopWindow", Ptr)
  hDC:=DllCall("GetWindowDC", Ptr,win, Ptr)
  mDC:=DllCall("CreateCompatibleDC", Ptr,hDC, Ptr)
  ;-------------------------
  VarSetCapacity(bi, 40, 0), NumPut(40, bi, 0, "int")
  NumPut(w, bi, 4, "int"), NumPut(-h, bi, 8, "int")
  NumPut(1, bi, 12, "short"), NumPut(bpp, bi, 14, "short")
  ;-------------------------
  if hBM:=DllCall("CreateDIBSection", Ptr,mDC, Ptr,&bi
    , "int",0, PtrP,ppvBits, Ptr,0, "int",0, Ptr)
  {
    oBM:=DllCall("SelectObject", Ptr,mDC, Ptr,hBM, Ptr)
    DllCall("BitBlt", Ptr,mDC, "int",0, "int",0, "int",w, "int",h
      , Ptr,hDC, "int",x, "int",y, "uint",0x00CC0020|0x40000000)
    DllCall("RtlMoveMemory","ptr",Scan0,"ptr",ppvBits,"ptr",Stride*h)
    DllCall("SelectObject", Ptr,mDC, Ptr,oBM)
    DllCall("DeleteObject", Ptr,hBM)
  }
  DllCall("DeleteDC", Ptr,mDC)
  DllCall("ReleaseDC", Ptr,win, Ptr,hDC)
}

base64tobit(s)
{
  ListLines, Off
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  SetFormat, IntegerFast, d
  StringCaseSense, On
  Loop, Parse, Chars
  {
    i:=A_Index-1, v:=(i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
    s:=StrReplace(s,A_LoopField,v)
  }
  StringCaseSense, Off
  s:=SubStr(s,1,InStr(s,"1",0,0)-1)
  s:=RegExReplace(s,"[^01]+")
  ListLines, On
  return, s
}

bit2base64(s)
{
  ListLines, Off
  s:=RegExReplace(s,"[^01]+")
  s.=SubStr("100000",1,6-Mod(StrLen(s),6))
  s:=RegExReplace(s,".{6}","|$0")
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  SetFormat, IntegerFast, d
  Loop, Parse, Chars
  {
    i:=A_Index-1, v:="|" . (i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
    s:=StrReplace(s,v,A_LoopField)
  }
  ListLines, On
  return, s
}

ASCII(s){
  if RegExMatch(s,"(\d+)\.([\w+/]{3,})",r)
  {
    s:=RegExReplace(base64tobit(r2),".{" r1 "}","$0`n")
    s:=StrReplace(StrReplace(s,"0","_"),"1","0")
  }
  else s=
  return, s
}

MCode(ByRef code, hex){
  ListLines, Off
  bch:=A_BatchLines
  SetBatchLines, -1
  VarSetCapacity(code, StrLen(hex)//2)
  Loop, % StrLen(hex)//2
    NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "char")
  Ptr:=A_PtrSize ? "UPtr" : "UInt"
  DllCall("VirtualProtect", Ptr,&code, Ptr
    ,VarSetCapacity(code), "uint",0x40, Ptr . "*",0)
  SetBatchLines, %bch%
  ListLines, On
}

; You can put the text library at the beginning of the script, and Use Pic(Text,1) to add the text library to Pic()'s Lib,
; Use Pic("comment1|comment2|...") to get text images from Lib
Pic(comments, add_to_Lib=0) {
  static Lib:=[]
  if (add_to_Lib)
  {
    re:="<([^>]*)>[^$]+\$\d+\.[\w+/]{3,}"
    Loop, Parse, comments, |
      if RegExMatch(A_LoopField,re,r)
        Lib[Trim(r1)]:=r
  }
  else
  {
    text:=""
    Loop, Parse, comments, |
      text.="|" . Lib[Trim(A_LoopField)]
    return, text
  }
}
return

Specify_Area:
run FindText_get_coordinates.ahk
return
*/

;Convert a Base 64 string into a pBitmap
B64ToPBitmap( Input ){
	local ptr , uptr , pBitmap , pStream , hData , pData , Dec , DecLen , B64
	VarSetCapacity( B64 , strlen( Input ) << !!A_IsUnicode )
	B64 := Input
	If !DllCall("Crypt32.dll\CryptStringToBinary" ( ( A_IsUnicode ) ? ( "W" ) : ( "A" ) ), Ptr := A_PtrSize ? "Ptr" : "UInt" , &B64, "UInt", 0, "UInt", 0x01, Ptr, 0, "UIntP", DecLen, Ptr, 0, Ptr, 0)
		Return False
	VarSetCapacity( Dec , DecLen , 0 )
	If !DllCall("Crypt32.dll\CryptStringToBinary" (A_IsUnicode ? "W" : "A"), Ptr, &B64, "UInt", 0, "UInt", 0x01, Ptr, &Dec, "UIntP", DecLen, Ptr, 0, Ptr, 0)
		Return False
	DllCall("Kernel32.dll\RtlMoveMemory", Ptr, pData := DllCall("Kernel32.dll\GlobalLock", Ptr, hData := DllCall( "Kernel32.dll\GlobalAlloc", "UInt", 2,  UPtr := A_PtrSize ? "UPtr" : "UInt" , DecLen, UPtr), UPtr) , Ptr, &Dec, UPtr, DecLen)
	DllCall("Kernel32.dll\GlobalUnlock", Ptr, hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal", Ptr, hData, "Int", True, Ptr "P", pStream)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  Ptr, pStream, Ptr "P", pBitmap)
	return pBitmap
}

Library_Load(filename)
{
  static ref := {}
  if (!(ptr := p := DllCall("LoadLibrary", "str", filename, "ptr")))
    return 0
  ref[ptr,"count"] := (ref[ptr]) ? ref[ptr,"count"]+1 : 1
  p += NumGet(p+0, 0x3c, "int")+24
  o := {_ptr:ptr, __delete:func("FreeLibrary"), _ref:ref[ptr]}
  if (NumGet(p+0, (A_PtrSize=4) ? 92 : 108, "uint")<1 || (ts := NumGet(p+0, (A_PtrSize=4) ? 96 : 112, "uint")+ptr)=ptr || (te := NumGet(p+0, (A_PtrSize=4) ? 100 : 116, "uint")+ts)=ts)
    return o
  n := ptr+NumGet(ts+0, 32, "uint")
  Loop, % NumGet(ts+0, 24, "uint")
  {
    if (p := NumGet(n+0, (A_Index-1)*4, "uint"))
    {
      o[f := StrGet(ptr+p, "cp0")] := DllCall("GetProcAddress", "ptr", ptr, "astr", f, "ptr")
      if (Substr(f, 0)==((A_IsUnicode) ? "W" : "A"))
        o[Substr(f, 1, -1)] := o[f]
    }
  }
  return o
}

Library_Free(lib)
{
	if (lib._ref.count>=1)
		lib._ref.count -= 1
	if (lib._ref.count<1)
		DllCall("FreeLibrary", "ptr", lib._ptr)
}
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
;
; Updated 2/20/2014 - fixed Gdip_CreateRegion() and Gdip_GetClipRegion() on AHK Unicode x86
; Updated 5/13/2013 - fixed Gdip_SetBitmapToClipboard() on AHK Unicode x64
;
;#####################################################################################
;#####################################################################################
; STATUS ENUMERATION
; Return values for functions specified to have status enumerated return type
;#####################################################################################
;
; Ok =						= 0
; GenericError				= 1
; InvalidParameter			= 2
; OutOfMemory				= 3
; ObjectBusy				= 4
; InsufficientBuffer		= 5
; NotImplemented			= 6
; Win32Error				= 7
; WrongState				= 8
; Aborted					= 9
; FileNotFound				= 10
; ValueOverflow				= 11
; AccessDenied				= 12
; UnknownImageFormat		= 13
; FontFamilyNotFound		= 14
; FontStyleNotFound			= 15
; NotTrueTypeFont			= 16
; UnsupportedGdiplusVersion	= 17
; GdiplusNotInitialized		= 18
; PropertyNotFound			= 19
; PropertyNotSupported		= 20
; ProfileNotFound			= 21
;
;#####################################################################################
;#####################################################################################
; FUNCTIONS
;#####################################################################################
;
; UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
; BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
; StretchBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, sw, sh, Raster="")
; SetImage(hwnd, hBitmap)
; Gdip_BitmapFromScreen(Screen=0, Raster="")
; CreateRectF(ByRef RectF, x, y, w, h)
; CreateSizeF(ByRef SizeF, w, h)
; CreateDIBSection
;
;#####################################################################################

; Function:     			UpdateLayeredWindow
; Description:  			Updates a layered window with the handle to the DC of a gdi bitmap
; 
; hwnd        				Handle of the layered window to update
; hdc           			Handle to the DC of the GDI bitmap to update the window with
; Layeredx      			x position to place the window
; Layeredy      			y position to place the window
; Layeredw      			Width of the window
; Layeredh      			Height of the window
; Alpha         			Default = 255 : The transparency (0-255) to set the window transparency
;
; return      				If the function succeeds, the return value is nonzero
;
; notes						If x or y omitted, then layered window will use its current coordinates
;							If w or h omitted then current width and height will be used

UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if ((x != "") && (y != ""))
		VarSetCapacity(pt, 8), NumPut(x, pt, 0, "UInt"), NumPut(y, pt, 4, "UInt")

	if (w = "") ||(h = "")
		WinGetPos,,, w, h, ahk_id %hwnd%
   
	return DllCall("UpdateLayeredWindow"
					, Ptr, hwnd
					, Ptr, 0
					, Ptr, ((x = "") && (y = "")) ? 0 : &pt
					, "int64*", w|h<<32
					, Ptr, hdc
					, "int64*", 0
					, "uint", 0
					, "UInt*", Alpha<<16|1<<24
					, "uint", 2)
}

;#####################################################################################

; Function				BitBlt
; Description			The BitBlt function performs a bit-block transfer of the color data corresponding to a rectangle 
;						of pixels from the specified source device context into a destination device context.
;
; dDC					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of the area to copy
; dh					height of the area to copy
; sDC					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used, which copies the source directly to the destination rectangle
;
; BLACKNESS				= 0x00000042
; NOTSRCERASE			= 0x001100A6
; NOTSRCCOPY			= 0x00330008
; SRCERASE				= 0x00440328
; DSTINVERT				= 0x00550009
; PATINVERT				= 0x005A0049
; SRCINVERT				= 0x00660046
; SRCAND				= 0x008800C6
; MERGEPAINT			= 0x00BB0226
; MERGECOPY				= 0x00C000CA
; SRCCOPY				= 0x00CC0020
; SRCPAINT				= 0x00EE0086
; PATCOPY				= 0x00F00021
; PATPAINT				= 0x00FB0A09
; WHITENESS				= 0x00FF0062
; CAPTUREBLT			= 0x40000000
; NOMIRRORBITMAP		= 0x80000000

BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdi32\BitBlt"
					, Ptr, dDC
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sDC
					, "int", sx
					, "int", sy
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				StretchBlt
; Description			The StretchBlt function copies a bitmap from a source rectangle into a destination rectangle, 
;						stretching or compressing the bitmap to fit the dimensions of the destination rectangle, if necessary.
;						The system stretches or compresses the bitmap according to the stretching mode currently set in the destination device context.
;
; ddc					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination rectangle
; dh					height of destination rectangle
; sdc					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used. It uses the same raster operations as BitBlt		

StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdi32\StretchBlt"
					, Ptr, ddc
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sdc
					, "int", sx
					, "int", sy
					, "int", sw
					, "int", sh
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				SetStretchBltMode
; Description			The SetStretchBltMode function sets the bitmap stretching mode in the specified device context
;
; hdc					handle to the DC
; iStretchMode			The stretching mode, describing how the target will be stretched
;
; return				If the function succeeds, the return value is the previous stretching mode. If it fails it will return 0
;
; STRETCH_ANDSCANS 		= 0x01
; STRETCH_ORSCANS 		= 0x02
; STRETCH_DELETESCANS 	= 0x03
; STRETCH_HALFTONE 		= 0x04

SetStretchBltMode(hdc, iStretchMode=4)
{
	return DllCall("gdi32\SetStretchBltMode"
					, A_PtrSize ? "UPtr" : "UInt", hdc
					, "int", iStretchMode)
}

;#####################################################################################

; Function				SetImage
; Description			Associates a new image with a static control
;
; hwnd					handle of the control to update
; hBitmap				a gdi bitmap to associate the static control with
;
; return				If the function succeeds, the return value is nonzero

SetImage(hwnd, hBitmap)
{
	SendMessage, 0x172, 0x0, hBitmap,, ahk_id %hwnd%
	E := ErrorLevel
	DeleteObject(E)
	return E
}

;#####################################################################################

; Function				SetSysColorToControl
; Description			Sets a solid colour to a control
;
; hwnd					handle of the control to update
; SysColor				A system colour to set to the control
;
; return				If the function succeeds, the return value is zero
;
; notes					A control must have the 0xE style set to it so it is recognised as a bitmap
;						By default SysColor=15 is used which is COLOR_3DFACE. This is the standard background for a control
;
; COLOR_3DDKSHADOW				= 21
; COLOR_3DFACE					= 15
; COLOR_3DHIGHLIGHT				= 20
; COLOR_3DHILIGHT				= 20
; COLOR_3DLIGHT					= 22
; COLOR_3DSHADOW				= 16
; COLOR_ACTIVEBORDER			= 10
; COLOR_ACTIVECAPTION			= 2
; COLOR_APPWORKSPACE			= 12
; COLOR_BACKGROUND				= 1
; COLOR_BTNFACE					= 15
; COLOR_BTNHIGHLIGHT			= 20
; COLOR_BTNHILIGHT				= 20
; COLOR_BTNSHADOW				= 16
; COLOR_BTNTEXT					= 18
; COLOR_CAPTIONTEXT				= 9
; COLOR_DESKTOP					= 1
; COLOR_GRADIENTACTIVECAPTION	= 27
; COLOR_GRADIENTINACTIVECAPTION	= 28
; COLOR_GRAYTEXT				= 17
; COLOR_HIGHLIGHT				= 13
; COLOR_HIGHLIGHTTEXT			= 14
; COLOR_HOTLIGHT				= 26
; COLOR_INACTIVEBORDER			= 11
; COLOR_INACTIVECAPTION			= 3
; COLOR_INACTIVECAPTIONTEXT		= 19
; COLOR_INFOBK					= 24
; COLOR_INFOTEXT				= 23
; COLOR_MENU					= 4
; COLOR_MENUHILIGHT				= 29
; COLOR_MENUBAR					= 30
; COLOR_MENUTEXT				= 7
; COLOR_SCROLLBAR				= 0
; COLOR_WINDOW					= 5
; COLOR_WINDOWFRAME				= 6
; COLOR_WINDOWTEXT				= 8

SetSysColorToControl(hwnd, SysColor=15)
{
   WinGetPos,,, w, h, ahk_id %hwnd%
   bc := DllCall("GetSysColor", "Int", SysColor, "UInt")
   pBrushClear := Gdip_BrushCreateSolid(0xff000000 | (bc >> 16 | bc & 0xff00 | (bc & 0xff) << 16))
   pBitmap := Gdip_CreateBitmap(w, h), G := Gdip_GraphicsFromImage(pBitmap)
   Gdip_FillRectangle(G, pBrushClear, 0, 0, w, h)
   hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
   SetImage(hwnd, hBitmap)
   Gdip_DeleteBrush(pBrushClear)
   Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
   return 0
}

;#####################################################################################

; Function				Gdip_BitmapFromScreen
; Description			Gets a gdi+ bitmap from the screen
;
; Screen				0 = All screens
;						Any numerical value = Just that screen
;						x|y|w|h = Take specific coordinates with a width and height
; Raster				raster operation code
;
; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1:		one or more of x,y,w,h not passed properly
;
; notes					If no raster operation is specified, then SRCCOPY is used to the returned bitmap

Gdip_BitmapFromScreen(Screen=0, Raster="")
{
	if (Screen = 0)
	{
		Sysget, x, 76
		Sysget, y, 77	
		Sysget, w, 78
		Sysget, h, 79
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist( "ahk_id " Screen)
			return -2
		WinGetPos,,, w, h, ahk_id %Screen%
		x := y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if (Screen&1 != "")
	{
		Sysget, M, Monitor, %Screen%
		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
	}
	else
	{
		StringSplit, S, Screen, |
		x := S1, y := S2, w := S3, h := S4
	}

	if (x = "") || (y = "") || (w = "") || (h = "")
		return -1

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)
	
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}

;#####################################################################################

; Function				Gdip_BitmapFromHWND
; Description			Uses PrintWindow to get a handle to the specified window and return a bitmap from it
;
; hwnd					handle to the window to get a bitmap from
;
; return				If the function succeeds, the return value is a pointer to a gdi+ bitmap
;
; notes					Window must not be not minimised in order to get a handle to it's client area

Gdip_BitmapFromHWND(hwnd)
{
	WinGetPos,,, Width, Height, ahk_id %hwnd%
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	PrintWindow(hwnd, hdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}

;#####################################################################################

; Function    			CreateRectF
; Description			Creates a RectF object, containing a the coordinates and dimensions of a rectangle
;
; RectF       			Name to call the RectF object
; x            			x-coordinate of the upper left corner of the rectangle
; y            			y-coordinate of the upper left corner of the rectangle
; w            			Width of the rectangle
; h            			Height of the rectangle
;
; return      			No return value

CreateRectF(ByRef RectF, x, y, w, h)
{
   VarSetCapacity(RectF, 16)
   NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}

;#####################################################################################

; Function    			CreateRect
; Description			Creates a Rect object, containing a the coordinates and dimensions of a rectangle
;
; RectF       			Name to call the RectF object
; x            			x-coordinate of the upper left corner of the rectangle
; y            			y-coordinate of the upper left corner of the rectangle
; w            			Width of the rectangle
; h            			Height of the rectangle
;
; return      			No return value

CreateRect(ByRef Rect, x, y, w, h)
{
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
;#####################################################################################

; Function		    	CreateSizeF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF         		Name to call the SizeF object
; w            			w-value for the SizeF object
; h            			h-value for the SizeF object
;
; return      			No Return value

CreateSizeF(ByRef SizeF, w, h)
{
   VarSetCapacity(SizeF, 8)
   NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")     
}
;#####################################################################################

; Function		    	CreatePointF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF         		Name to call the SizeF object
; w            			w-value for the SizeF object
; h            			h-value for the SizeF object
;
; return      			No Return value

CreatePointF(ByRef PointF, x, y)
{
   VarSetCapacity(PointF, 8)
   NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")     
}
;{#####################################################################################

; Function				CreateDIBSection
; Description			The CreateDIBSection function creates a DIB (Device Independent Bitmap) that applications can write to directly
;
; w						width of the bitmap to create
; h						height of the bitmap to create
; hdc					a handle to the device context to use the palette from
; bpp					bits per pixel (32 = ARGB)
; ppvBits				A pointer to a variable that receives a pointer to the location of the DIB bit values
;
; return				returns a DIB. A gdi bitmap
;
; notes					ppvBits will receive the location of the pixels in the DIB
;}
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	
	NumPut(w, bi, 4, "uint")
	, NumPut(h, bi, 8, "uint")
	, NumPut(40, bi, 0, "uint")
	, NumPut(1, bi, 12, "ushort")
	, NumPut(0, bi, 16, "uInt")
	, NumPut(bpp, bi, 14, "ushort")
	
	hbm := DllCall("CreateDIBSection"
					, Ptr, hdc2
					, Ptr, &bi
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "uint*", ppvBits
					, Ptr, 0
					, "uint", 0, Ptr)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}

;{#####################################################################################

; Function				PrintWindow
; Description			The PrintWindow function copies a visual window into the specified device context (DC), typically a printer DC
;
; hwnd					A handle to the window that will be copied
; hdc					A handle to the device context
; Flags					Drawing options
;
; return				If the function succeeds, it returns a nonzero value
;
; PW_CLIENTONLY			= 1
;}
PrintWindow(hwnd, hdc, Flags=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("PrintWindow", Ptr, hwnd, Ptr, hdc, "uint", Flags)
}

;{#####################################################################################

; Function				DestroyIcon
; Description			Destroys an icon and frees any memory the icon occupied
;
; hIcon					Handle to the icon to be destroyed. The icon must not be in use
;
; return				If the function succeeds, the return value is nonzero
;}
DestroyIcon(hIcon)
{
	return DllCall("DestroyIcon", A_PtrSize ? "UPtr" : "UInt", hIcon)
}

;#####################################################################################

PaintDesktop(hdc)
{
	return DllCall("PaintDesktop", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;#####################################################################################

CreateCompatibleBitmap(hdc, w, h)
{
	return DllCall("gdi32\CreateCompatibleBitmap", A_PtrSize ? "UPtr" : "UInt", hdc, "int", w, "int", h)
}

;{#####################################################################################

; Function				CreateCompatibleDC
; Description			This function creates a memory device context (DC) compatible with the specified device
;
; hdc					Handle to an existing device context					
;
; return				returns the handle to a device context or 0 on failure
;
; notes					If this handle is 0 (by default), the function creates a memory device context compatible with the application's current screen
;}
CreateCompatibleDC(hdc=0)
{
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;{#####################################################################################

; Function				SelectObject
; Description			The SelectObject function selects an object into the specified device context (DC). The new object replaces the previous object of the same type
;
; hdc					Handle to a DC
; hgdiobj				A handle to the object to be selected into the DC
;
; return				If the selected object is not a region and the function succeeds, the return value is a handle to the object being replaced
;
; notes					The specified object must have been created by using one of the following functions
;						Bitmap - CreateBitmap, CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection (A single bitmap cannot be selected into more than one DC at the same time)
;						Brush - CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush, CreatePatternBrush, CreateSolidBrush
;						Font - CreateFont, CreateFontIndirect
;						Pen - CreatePen, CreatePenIndirect
;						Region - CombineRgn, CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect
;
; notes					If the selected object is a region and the function succeeds, the return value is one of the following value
;
; SIMPLEREGION			= 2 Region consists of a single rectangle
; COMPLEXREGION			= 3 Region consists of more than one rectangle
; NULLREGION			= 1 Region is empty
;}
SelectObject(hdc, hgdiobj)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}

;{#####################################################################################

; Function				DeleteObject
; Description			This function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system resources associated with the object
;						After the object is deleted, the specified handle is no longer valid
;
; hObject				Handle to a logical pen, brush, font, bitmap, region, or palette to delete
;
; return				Nonzero indicates success. Zero indicates that the specified handle is not valid or that the handle is currently selected into a device context
;}
DeleteObject(hObject)
{
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}

;{#####################################################################################

; Function				GetDC
; Description			This function retrieves a handle to a display device context (DC) for the client area of the specified window.
;						The display device context can be used in subsequent graphics display interface (GDI) functions to draw in the client area of the window. 
;
; hwnd					Handle to the window whose device context is to be retrieved. If this value is NULL, GetDC retrieves the device context for the entire screen					
;
; return				The handle the device context for the specified window's client area indicates success. NULL indicates failure
;}
GetDC(hwnd=0)
{
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}

;{#####################################################################################

; DCX_CACHE = 0x2
; DCX_CLIPCHILDREN = 0x8
; DCX_CLIPSIBLINGS = 0x10
; DCX_EXCLUDERGN = 0x40
; DCX_EXCLUDEUPDATE = 0x100
; DCX_INTERSECTRGN = 0x80
; DCX_INTERSECTUPDATE = 0x200
; DCX_LOCKWINDOWUPDATE = 0x400
; DCX_NORECOMPUTE = 0x100000
; DCX_NORESETATTRS = 0x4
; DCX_PARENTCLIP = 0x20
; DCX_VALIDATE = 0x200000
; DCX_WINDOW = 0x1
;}
GetDCEx(hwnd, flags=0, hrgnClip=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}

;{#####################################################################################

; Function				ReleaseDC
; Description			This function releases a device context (DC), freeing it for use by other applications. The effect of ReleaseDC depends on the type of device context
;
; hdc					Handle to the device context to be released
; hwnd					Handle to the window whose device context is to be released
;
; return				1 = released
;						0 = not released
;
; notes					The application must call the ReleaseDC function for each call to the GetWindowDC function and for each call to the GetDC function that retrieves a common device context
;						An application cannot use the ReleaseDC function to release a device context that was created by calling the CreateDC function; instead, it must use the DeleteDC function. 
;}
ReleaseDC(hdc, hwnd=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}

;{#####################################################################################

; Function				DeleteDC
; Description			The DeleteDC function deletes the specified device context (DC)
;
; hdc					A handle to the device context
;
; return				If the function succeeds, the return value is nonzero
;
; notes					An application must not delete a DC whose handle was obtained by calling the GetDC function. Instead, it must call the ReleaseDC function to free the DC
;}
DeleteDC(hdc)
{
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
;{#####################################################################################

; Function				Gdip_LibraryVersion
; Description			Get the current library version
;
; return				the library version
;
; notes					This is useful for non compiled programs to ensure that a person doesn't run an old version when testing your scripts
;}
Gdip_LibraryVersion()
{
	return 1.45
}

;{#####################################################################################

; Function				Gdip_LibrarySubVersion
; Description			Get the current library sub version
;
; return				the library sub version
;
; notes					This is the sub-version currently maintained by Rseding91
;}
Gdip_LibrarySubVersion()
{
	return 1.47
}

;{#####################################################################################

; Function:    			Gdip_BitmapFromBRA
; Description: 			Gets a pointer to a gdi+ bitmap from a BRA file
;
; BRAFromMemIn			The variable for a BRA file read to memory
; File					The name of the file, or its number that you would like (This depends on alternate parameter)
; Alternate				Changes whether the File parameter is the file name or its number
;
; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1 = The BRA variable is empty
;						-2 = The BRA has an incorrect header
;						-3 = The BRA has information missing
;						-4 = Could not find file inside the BRA
;}
Gdip_BitmapFromBRA(ByRef BRAFromMemIn, File, Alternate=0)
{
	Static FName = "ObjRelease"
	
	if !BRAFromMemIn
		return -1
	Loop, Parse, BRAFromMemIn, `n
	{
		if (A_Index = 1)
		{
			StringSplit, Header, A_LoopField, |
			if (Header0 != 4 || Header2 != "BRA!")
				return -2
		}
		else if (A_Index = 2)
		{
			StringSplit, Info, A_LoopField, |
			if (Info0 != 3)
				return -3
		}
		else
			break
	}
	if !Alternate
		StringReplace, File, File, \, \\, All
	RegExMatch(BRAFromMemIn, "mi`n)^" (Alternate ? File "\|.+?\|(\d+)\|(\d+)" : "\d+\|" File "\|(\d+)\|(\d+)") "$", FileInfo)
	if !FileInfo
		return -4
	
	hData := DllCall("GlobalAlloc", "uint", 2, Ptr, FileInfo2, Ptr)
	pData := DllCall("GlobalLock", Ptr, hData, Ptr)
	DllCall("RtlMoveMemory", Ptr, pData, Ptr, &BRAFromMemIn+Info2+FileInfo1, Ptr, FileInfo2)
	DllCall("GlobalUnlock", Ptr, hData)
	DllCall("ole32\CreateStreamOnHGlobal", Ptr, hData, "int", 1, A_PtrSize ? "UPtr*" : "UInt*", pStream)
	DllCall("gdiplus\GdipCreateBitmapFromStream", Ptr, pStream, A_PtrSize ? "UPtr*" : "UInt*", pBitmap)
	If (A_PtrSize)
		%FName%(pStream)
	Else
		DllCall(NumGet(NumGet(1*pStream)+8), "uint", pStream)
	return pBitmap
}

;{#####################################################################################

; Function				Gdip_DrawRectangle
; Description			This function uses a pen to draw the outline of a rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
;}
Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;{#####################################################################################

; Function				Gdip_DrawRoundedRectangle
; Description			This function uses a pen to draw the outline of a rounded rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
;}
Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r)
{
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_ResetClip(pGraphics)
	return E
}

;{#####################################################################################

; Function				Gdip_DrawEllipse
; Description			This function uses a pen to draw the outline of an ellipse into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle the ellipse will be drawn into
; y						y-coordinate of the top left of the rectangle the ellipse will be drawn into
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
;}
Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;{#####################################################################################

; Function				Gdip_DrawBezier
; Description			This function uses a pen to draw the outline of a bezier (a weighted curve) into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the bezier
; y1					y-coordinate of the start of the bezier
; x2					x-coordinate of the first arc of the bezier
; y2					y-coordinate of the first arc of the bezier
; x3					x-coordinate of the second arc of the bezier
; y3					y-coordinate of the second arc of the bezier
; x4					x-coordinate of the end of the bezier
; y4					y-coordinate of the end of the bezier
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
;}
Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawBezier"
					, Ptr, pgraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2
					, "float", x3
					, "float", y3
					, "float", x4
					, "float", y4)
}

;{#####################################################################################

; Function				Gdip_DrawArc
; Description			This function uses a pen to draw the outline of an arc into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the arc
; y						y-coordinate of the start of the arc
; w						width of the arc
; h						height of the arc
; StartAngle			specifies the angle between the x-axis and the starting point of the arc
; SweepAngle			specifies the angle between the starting and ending points of the arc
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
;}
Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawArc"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;{#####################################################################################

; Function				Gdip_DrawPie
; Description			This function uses a pen to draw the outline of a pie into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the pie
; y						y-coordinate of the start of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
;}
Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}

;{#####################################################################################

; Function				Gdip_DrawLine
; Description			This function uses a pen to draw a line into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the line
; y1					y-coordinate of the start of the line
; x2					x-coordinate of the end of the line
; y2					y-coordinate of the end of the line
;
; return				status enumeration. 0 = success		
;}
Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipDrawLine"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2)
}

;{#####################################################################################

; Function				Gdip_DrawLines
; Description			This function uses a pen to draw a series of joined lines into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success				
;}
Gdip_DrawLines(pGraphics, pPen, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", Points0)
}

;{#####################################################################################

; Function				Gdip_FillRectangle
; Description			This function uses a brush to fill a rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success
;}
Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillRectangle"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h)
}

;{#####################################################################################

; Function				Gdip_FillRoundedRectangle
; Description			This function uses a brush to fill a rounded rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success
;}
Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r)
{
	Region := Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_DeleteRegion(Region)
	return E
}

;{#####################################################################################

; Function				Gdip_FillPolygon
; Description			This function uses a brush to fill a polygon in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success
;
; notes					Alternate will fill the polygon as a whole, wheras winding will fill each new "segment"
; Alternate 			= 0
; Winding 				= 1
;}
Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}   
	return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", Points0, "int", FillMode)
}

;{#####################################################################################

; Function				Gdip_FillPie
; Description			This function uses a brush to fill a pie in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the pie
; y						y-coordinate of the top left of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success
;}
Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillPie"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;{#####################################################################################

; Function				Gdip_FillEllipse
; Description			This function uses a brush to fill an ellipse in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the ellipse
; y						y-coordinate of the top left of the ellipse
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success
;}
Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}

;{#####################################################################################

; Function				Gdip_FillRegion
; Description			This function uses a brush to fill a region in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Region
;
; return				status enumeration. 0 = success
;
; notes					You can create a region Gdip_CreateRegion() and then add to this
;}
Gdip_FillRegion(pGraphics, pBrush, Region)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}

;{#####################################################################################

; Function				Gdip_FillPath
; Description			This function uses a brush to fill a path in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Path
;
; return				status enumeration. 0 = success
;}
Gdip_FillPath(pGraphics, pBrush, Path)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, Path)
}

;{#####################################################################################

; Function				Gdip_DrawImagePointsRect
; Description			This function draws a bitmap into the Graphics of another bitmap and skews it
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; Points				Points passed as x1,y1|x2,y2|x3,y3 (3 points: top left, top right, bottom left) describing the drawing of the bitmap
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter
;}
Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx="", sy="", sw="", sh="", Matrix=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}

	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
		
	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		sx := 0, sy := 0
		sw := Gdip_GetImageWidth(pBitmap)
		sh := Gdip_GetImageHeight(pBitmap)
	}

	E := DllCall("gdiplus\GdipDrawImagePointsRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, Ptr, &PointF
				, "int", Points0
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}

;{#####################################################################################

; Function				Gdip_DrawImage
; Description			This function draws a bitmap into the Graphics of another bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination image
; dh					height of destination image
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source image
; sh					height of source image
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Gdip_DrawImage performs faster
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter. For example:
;						MatrixBright=
;						(
;						1.5		|0		|0		|0		|0
;						0		|1.5	|0		|0		|0
;						0		|0		|1.5	|0		|0
;						0		|0		|0		|1		|0
;						0.05	|0.05	|0.05	|0		|1
;						)
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1
;}
Gdip_DrawImage(pGraphics, pBitmap, dx="", dy="", dw="", dh="", sx="", sy="", sw="", sh="", Matrix=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (Matrix&1 = "")
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		if (dx = "" && dy = "" && dw = "" && dh = "")
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	E := DllCall("gdiplus\GdipDrawImageRectRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, "float", dx
				, "float", dy
				, "float", dw
				, "float", dh
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return E
}

;{#####################################################################################

; Function				Gdip_SetImageAttributesColorMatrix
; Description			This function creates an image matrix ready for drawing
;
; Matrix				a matrix used to alter image attributes when drawing
;						passed with any delimeter
;
; return				returns an image matrix on sucess or 0 if it fails
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1
;}
Gdip_SetImageAttributesColorMatrix(Matrix)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", "", 1), "[^\d-\.]+", "|")
	StringSplit, Matrix, Matrix, |
	Loop, 25
	{
		Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(Matrix, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
	return ImageAttr
}

;{#####################################################################################

; Function				Gdip_GraphicsFromImage
; Description			This function gets the graphics for a bitmap used for drawing functions
;
; pBitmap				Pointer to a bitmap to get the pointer to its graphics
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					a bitmap can be drawn into the graphics of another bitmap
;}
Gdip_GraphicsFromImage(pBitmap)
{
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}

;{#####################################################################################

; Function				Gdip_GraphicsFromHDC
; Description			This function gets the graphics from the handle to a device context
;
; hdc					This is the handle to the device context
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					You can draw a bitmap into the graphics of another bitmap
;}
Gdip_GraphicsFromHDC(hdc)
{
    DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
    return pGraphics
}

;{#####################################################################################

; Function				Gdip_GetDC
; Description			This function gets the device context of the passed Graphics
;
; hdc					This is the handle to the device context
;
; return				returns the device context for the graphics of a bitmap
;}
Gdip_GetDC(pGraphics)
{
	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
	return hdc
}

;{#####################################################################################

; Function				Gdip_ReleaseDC
; Description			This function releases a device context from use for further use
;
; pGraphics				Pointer to the graphics of a bitmap
; hdc					This is the handle to the device context
;
; return				status enumeration. 0 = success
;}
Gdip_ReleaseDC(pGraphics, hdc)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipReleaseDC", Ptr, pGraphics, Ptr, hdc)
}

;{#####################################################################################

; Function				Gdip_GraphicsClear
; Description			Clears the graphics of a bitmap ready for further drawing
;
; pGraphics				Pointer to the graphics of a bitmap
; ARGB					The colour to clear the graphics to
;
; return				status enumeration. 0 = success
;
; notes					By default this will make the background invisible
;						Using clipping regions you can clear a particular area on the graphics rather than clearing the entire graphics
;}
Gdip_GraphicsClear(pGraphics, ARGB=0x00ffffff)
{
    return DllCall("gdiplus\GdipGraphicsClear", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", ARGB)
}

;{#####################################################################################

; Function				Gdip_BlurBitmap
; Description			Gives a pointer to a blurred bitmap from a pointer to a bitmap
;
; pBitmap				Pointer to a bitmap to be blurred
; Blur					The Amount to blur a bitmap by from 1 (least blur) to 100 (most blur)
;
; return				If the function succeeds, the return value is a pointer to the new blurred bitmap
;						-1 = The blur parameter is outside the range 1-100
;
; notes					This function will not dispose of the original bitmap
;}
Gdip_BlurBitmap(pBitmap, Blur)
{
	if (Blur > 100) || (Blur < 1)
		return -1	
	
	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
	dWidth := sWidth//Blur, dHeight := sHeight//Blur

	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
	G1 := Gdip_GraphicsFromImage(pBitmap1)
	Gdip_SetInterpolationMode(G1, 7)
	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)

	Gdip_DeleteGraphics(G1)

	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
	G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_SetInterpolationMode(G2, 7)
	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)

	Gdip_DeleteGraphics(G2)
	Gdip_DisposeImage(pBitmap1)
	return pBitmap2
}

;{#####################################################################################

; Function:     		Gdip_SaveBitmapToFile
; Description:  		Saves a bitmap to a file in any supported format onto disk
;   
; pBitmap				Pointer to a bitmap
; sOutput      			The name of the file that the bitmap will be saved to. Supported extensions are: .BMP,.DIB,.RLE,.JPG,.JPEG,.JPE,.JFIF,.GIF,.TIF,.TIFF,.PNG
; Quality      			If saving as jpg (.JPG,.JPEG,.JPE,.JFIF) then quality can be 1-100 with default at maximum quality
;
; return      			If the function succeeds, the return value is zero, otherwise:
;						-1 = Extension supplied is not a supported file format
;						-2 = Could not get a list of encoders on system
;						-3 = Could not find matching encoder for specified file format
;						-4 = Could not get WideChar name of output file
;						-5 = Could not save file to disk
;
; notes					This function will use the extension supplied from the sOutput parameter to determine the output format
;}
Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality=75)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	SplitPath, sOutput,,, Extension
	if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Extension

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2
	
	If (A_IsUnicode){
		StrGet_Name := "StrGet"
		Loop, %nCount%
		{
			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue
			
			pCodec := &ci+idx
			break
		}
	} else {
		Loop, %nCount%
		{
			Location := NumGet(ci, 76*(A_Index-1)+44)
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue
			
			pCodec := &ci+76*(A_Index-1)
			break
		}
	}
	
	if !pCodec
		return -3

	if (Quality != 75)
	{
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if Extension in .JPG,.JPEG,.JPE,.JFIF
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			Loop, % NumGet(EncoderParameters, "UInt")      ;%
			{
				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
				{
					p := elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
					break
				}
			}      
		}
	}

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", p ? p : 0)
	}
	else
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", p ? p : 0)
	return E ? -5 : 0
}

;{#####################################################################################

; Function				Gdip_GetPixel
; Description			Gets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				Returns the ARGB value of the pixel
;}
Gdip_GetPixel(pBitmap, x, y)
{
	DllCall("gdiplus\GdipBitmapGetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "uint*", ARGB)
	return ARGB
}

;{#####################################################################################

; Function				Gdip_SetPixel
; Description			Sets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				status enumeration. 0 = success
;}
Gdip_SetPixel(pBitmap, x, y, ARGB)
{
   return DllCall("gdiplus\GdipBitmapSetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "int", ARGB)
}

;{#####################################################################################

; Function				Gdip_GetImageWidth
; Description			Gives the width of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the width in pixels of the supplied bitmap

Gdip_GetImageWidth(pBitmap)
{
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}

;{#####################################################################################

; Function				Gdip_GetImageHeight
; Description			Gives the height of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the height in pixels of the supplied bitmap

Gdip_GetImageHeight(pBitmap)
{
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}

;{#####################################################################################

; Function				Gdip_GetDimensions
; Description			Gives the width and height of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DllCall("gdiplus\GdipGetImageWidth", Ptr, pBitmap, "uint*", Width)
	DllCall("gdiplus\GdipGetImageHeight", Ptr, pBitmap, "uint*", Height)
}

;#####################################################################################

Gdip_GetDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Gdip_GetImageDimensions(pBitmap, Width, Height)
}

;#####################################################################################

Gdip_GetImagePixelFormat(pBitmap)
{
	DllCall("gdiplus\GdipGetImagePixelFormat", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", Format)
	return Format
}

;#####################################################################################

; Function				Gdip_GetDpiX
; Description			Gives the horizontal dots per inch of the graphics of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetDpiX(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiX", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetDpiY(pGraphics)
{
	DllCall("gdiplus\GdipGetDpiY", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################
Gdip_GetImageHorizontalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageHorizontalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpix)
	return Round(dpix)
}
;#####################################################################################
Gdip_GetImageVerticalResolution(pBitmap)
{
	DllCall("gdiplus\GdipGetImageVerticalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpiy)
	return Round(dpiy)
}
;#####################################################################################
Gdip_BitmapSetResolution(pBitmap, dpix, dpiy)
{
	return DllCall("gdiplus\GdipBitmapSetResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float", dpix, "float", dpiy)
}
;#####################################################################################
Gdip_CreateBitmapFromFile(sFile, IconNumber=1, IconSize="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	
	SplitPath, sFile,,, ext
	if ext in exe,dll
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))
		
		VarSetCapacity(buf, BufSize, 0)
		Loop, Parse, Sizes, |
		{
			DllCall("PrivateExtractIcons", "str", sFile, "int", IconNumber-1, "int", A_LoopField, "int", A_LoopField, PtrA, hIcon, PtrA, 0, "uint", 1, "uint", 0)
			
			if !hIcon
				continue

			if !DllCall("GetIconInfo", Ptr, hIcon, Ptr, &buf)
			{
				DestroyIcon(hIcon)
				continue
			}
			
			hbmMask  := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4))
			hbmColor := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4) + (A_PtrSize ? A_PtrSize : 4))
			if !(hbmColor && DllCall("GetObject", Ptr, hbmColor, "int", BufSize, Ptr, &buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if !hIcon
			return -1

		Width := NumGet(buf, 4, "int"), Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
		if !DllCall("DrawIconEx", Ptr, hdc, "int", 0, "int", 0, Ptr, hIcon, "uint", Width, "uint", Height, "uint", 0, Ptr, 0, "uint", 3)
		{
			DestroyIcon(hIcon)
			return -2
		}
		
		VarSetCapacity(dib, 104)
		DllCall("GetObject", Ptr, hbm, "int", A_PtrSize = 8 ? 104 : 84, Ptr, &dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Stride := NumGet(dib, 12, "Int"), Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0)) ; padding
		DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", Stride, "int", 0x26200A, Ptr, Bits, PtrA, pBitmapOld)
		pBitmap := Gdip_CreateBitmap(Width, Height)
		G := Gdip_GraphicsFromImage(pBitmap)
		, Gdip_DrawImage(G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wFile, 1024)
			DllCall("kernel32\MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sFile, "int", -1, Ptr, &wFile, "int", 512)
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &wFile, PtrA, pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &sFile, PtrA, pBitmap)
	}
	
	return pBitmap
}
;#####################################################################################
Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}
;#####################################################################################
Gdip_CreateHBITMAPFromBitmap(pBitmap, Background=0xffffffff)
{
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}
;#####################################################################################
Gdip_CreateBitmapFromHICON(hIcon)
{
	DllCall("gdiplus\GdipCreateBitmapFromHICON", A_PtrSize ? "UPtr" : "UInt", hIcon, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}
;#####################################################################################
Gdip_CreateHICONFromBitmap(pBitmap)
{
	DllCall("gdiplus\GdipCreateHICONFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hIcon)
	return hIcon
}
;#####################################################################################
Gdip_CreateBitmap(Width, Height, Format=0x26200A)
{
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
    Return pBitmap
}
;#####################################################################################
Gdip_CreateBitmapFromClipboard()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if !DllCall("OpenClipboard", Ptr, 0)
		return -1
	if !DllCall("IsClipboardFormatAvailable", "uint", 8)
		return -2
	if !hBitmap := DllCall("GetClipboardData", "uint", 2, Ptr)
		return -3
	if !pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
		return -4
	if !DllCall("CloseClipboard")
		return -5
	DeleteObject(hBitmap)
	return pBitmap
}
;#####################################################################################
Gdip_SetBitmapToClipboard(pBitmap)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	off1 := A_PtrSize = 8 ? 52 : 44, off2 := A_PtrSize = 8 ? 32 : 24
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	DllCall("GetObject", Ptr, hBitmap, "int", VarSetCapacity(oi, A_PtrSize = 8 ? 104 : 84, 0), Ptr, &oi)
	hdib := DllCall("GlobalAlloc", "uint", 2, Ptr, 40+NumGet(oi, off1, "UInt"), Ptr)
	pdib := DllCall("GlobalLock", Ptr, hdib, Ptr)
	DllCall("RtlMoveMemory", Ptr, pdib, Ptr, &oi+off2, Ptr, 40)
	DllCall("RtlMoveMemory", Ptr, pdib+40, Ptr, NumGet(oi, off2 - (A_PtrSize ? A_PtrSize : 4), Ptr), Ptr, NumGet(oi, off1, "UInt"))
	DllCall("GlobalUnlock", Ptr, hdib)
	DllCall("DeleteObject", Ptr, hBitmap)
	DllCall("OpenClipboard", Ptr, 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "uint", 8, Ptr, hdib)
	DllCall("CloseClipboard")
}
;#####################################################################################
Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format=0x26200A)
{
	DllCall("gdiplus\GdipCloneBitmapArea"
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "int", Format
					, A_PtrSize ? "UPtr" : "UInt", pBitmap
					, A_PtrSize ? "UPtr*" : "UInt*", pBitmapDest)
	return pBitmapDest
}
;#####################################################################################
; Create resources
;#####################################################################################
Gdip_CreatePen(ARGB, w)
{
   DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
   return pPen
}
;#####################################################################################
Gdip_CreatePenFromBrush(pBrush, w)
{
	DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}
;#####################################################################################
Gdip_BrushCreateSolid(ARGB=0xff000000)
{
	DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}
;{#####################################################################################

; HatchStyleHorizontal = 0
; HatchStyleVertical = 1
; HatchStyleForwardDiagonal = 2
; HatchStyleBackwardDiagonal = 3
; HatchStyleCross = 4
; HatchStyleDiagonalCross = 5
; HatchStyle05Percent = 6
; HatchStyle10Percent = 7
; HatchStyle20Percent = 8
; HatchStyle25Percent = 9
; HatchStyle30Percent = 10
; HatchStyle40Percent = 11
; HatchStyle50Percent = 12
; HatchStyle60Percent = 13
; HatchStyle70Percent = 14
; HatchStyle75Percent = 15
; HatchStyle80Percent = 16
; HatchStyle90Percent = 17
; HatchStyleLightDownwardDiagonal = 18
; HatchStyleLightUpwardDiagonal = 19
; HatchStyleDarkDownwardDiagonal = 20
; HatchStyleDarkUpwardDiagonal = 21
; HatchStyleWideDownwardDiagonal = 22
; HatchStyleWideUpwardDiagonal = 23
; HatchStyleLightVertical = 24
; HatchStyleLightHorizontal = 25
; HatchStyleNarrowVertical = 26
; HatchStyleNarrowHorizontal = 27
; HatchStyleDarkVertical = 28
; HatchStyleDarkHorizontal = 29
; HatchStyleDashedDownwardDiagonal = 30
; HatchStyleDashedUpwardDiagonal = 31
; HatchStyleDashedHorizontal = 32
; HatchStyleDashedVertical = 33
; HatchStyleSmallConfetti = 34
; HatchStyleLargeConfetti = 35
; HatchStyleZigZag = 36
; HatchStyleWave = 37
; HatchStyleDiagonalBrick = 38
; HatchStyleHorizontalBrick = 39
; HatchStyleWeave = 40
; HatchStylePlaid = 41
; HatchStyleDivot = 42
; HatchStyleDottedGrid = 43
; HatchStyleDottedDiamond = 44
; HatchStyleShingle = 45
; HatchStyleTrellis = 46
; HatchStyleSphere = 47
; HatchStyleSmallGrid = 48
; HatchStyleSmallCheckerBoard = 49
; HatchStyleLargeCheckerBoard = 50
; HatchStyleOutlinedDiamond = 51
; HatchStyleSolidDiamond = 52
; HatchStyleTotal = 53
;}
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle=0)
{
	DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}
;#####################################################################################
Gdip_CreateTextureBrush(pBitmap, WrapMode=1, x=0, y=0, w="", h="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	
	if !(w && h)
		DllCall("gdiplus\GdipCreateTexture", Ptr, pBitmap, "int", WrapMode, PtrA, pBrush)
	else
		DllCall("gdiplus\GdipCreateTexture2", Ptr, pBitmap, "int", WrapMode, "float", x, "float", y, "float", w, "float", h, PtrA, pBrush)
	return pBrush
}
;{#####################################################################################

; WrapModeTile = 0
; WrapModeTileFlipX = 1
; WrapModeTileFlipY = 2
; WrapModeTileFlipXY = 3
; WrapModeClamp = 4
;}
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}
;{#####################################################################################

; LinearGradientModeHorizontal = 0
; LinearGradientModeVertical = 1
; LinearGradientModeForwardDiagonal = 2
; LinearGradientModeBackwardDiagonal = 3
;}
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode=1, WrapMode=1)
{
	CreateRectF(RectF, x, y, w, h)
	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}
;#####################################################################################
Gdip_CloneBrush(pBrush)
{
	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
	return pBrushClone
}

;#####################################################################################
; Delete resources
;#####################################################################################
Gdip_DeletePen(pPen)
{
   return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}
;#####################################################################################
Gdip_DeleteBrush(pBrush)
{
   return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}
;#####################################################################################
Gdip_DisposeImage(pBitmap)
{
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}
;#####################################################################################
Gdip_DeleteGraphics(pGraphics)
{
   return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}
;#####################################################################################
Gdip_DisposeImageAttributes(ImageAttr)
{
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}
;#####################################################################################
Gdip_DeleteFont(hFont)
{
   return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}
;#####################################################################################
Gdip_DeleteStringFormat(hFormat)
{
   return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}
;#####################################################################################
Gdip_DeleteFontFamily(hFamily)
{
   return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}
;#####################################################################################
Gdip_DeleteMatrix(Matrix)
{
   return DllCall("gdiplus\GdipDeleteMatrix", A_PtrSize ? "UPtr" : "UInt", Matrix)
}
;#####################################################################################
; Text functions
;#####################################################################################

Gdip_TextToGraphics(pGraphics, Text, Options, Font="Arial", Width="", Height="", Measure=0)
{
	IWidth := Width, IHeight:= Height
	
	RegExMatch(Options, "i)X([\-\d\.]+)(p*)", xpos)
	RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", ypos)
	RegExMatch(Options, "i)W([\-\d\.]+)(p*)", Width)
	RegExMatch(Options, "i)H([\-\d\.]+)(p*)", Height)
	RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", Colour)
	RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", vPos)
	RegExMatch(Options, "i)NoWrap", NoWrap)
	RegExMatch(Options, "i)R(\d)", Rendering)
	RegExMatch(Options, "i)S(\d+)(p*)", Size)

	if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
		PassBrush := 1, pBrush := Colour2
	
	if !(IWidth && IHeight) && (xpos2 || ypos2 || Width2 || Height2 || Size2)
		return -1

	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	Loop, Parse, Styles, |
	{
		if RegExMatch(Options, "\b" A_loopField)
		Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
	}
  
	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
	Loop, Parse, Alignments, |
	{
		if RegExMatch(Options, "\b" A_loopField)
			Align |= A_Index//2.1      ; 0|0|1|1|2|2
	}

	xpos := (xpos1 != "") ? xpos2 ? IWidth*(xpos1/100) : xpos1 : 0
	ypos := (ypos1 != "") ? ypos2 ? IHeight*(ypos1/100) : ypos1 : 0
	Width := Width1 ? Width2 ? IWidth*(Width1/100) : Width1 : IWidth
	Height := Height1 ? Height2 ? IHeight*(Height1/100) : Height1 : IHeight
	if !PassBrush
		Colour := "0x" (Colour2 ? Colour2 : "ff000000")
	Rendering := ((Rendering1 >= 0) && (Rendering1 <= 5)) ? Rendering1 : 4
	Size := (Size1 > 0) ? Size2 ? IHeight*(Size1/100) : Size1 : 12

	hFamily := Gdip_FontFamilyCreate(Font)
	hFont := Gdip_FontCreate(hFamily, Size, Style)
	FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
	hFormat := Gdip_StringFormatCreate(FormatStyle)
	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
   
	CreateRectF(RC, xpos, ypos, Width, Height)
	Gdip_SetStringFormatAlign(hFormat, Align)
	Gdip_SetTextRenderingHint(pGraphics, Rendering)
	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

	if vPos
	{
		StringSplit, ReturnRC, ReturnRC, |
		
		if (vPos = "vCentre") || (vPos = "vCenter")
			ypos += (Height-ReturnRC4)//2
		else if (vPos = "Top") || (vPos = "Up")
			ypos := 0
		else if (vPos = "Bottom") || (vPos = "Down")
			ypos := Height-ReturnRC4
		
		CreateRectF(RC, xpos, ypos, Width, ReturnRC4)
		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	}

	if !Measure
		E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

	if !PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)   
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return E ? E : ReturnRC
}

;#####################################################################################

Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	
	return DllCall("gdiplus\GdipDrawString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, pBrush)
}

;#####################################################################################

Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)   
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}
	
	DllCall("gdiplus\GdipMeasureString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, &RC
					, "uint*", Chars
					, "uint*", Lines)
	
	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}

; Near = 0
; Center = 1
; Far = 2
Gdip_SetStringFormatAlign(hFormat, Align)
{
   return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}

; StringFormatFlagsDirectionRightToLeft    = 0x00000001
; StringFormatFlagsDirectionVertical       = 0x00000002
; StringFormatFlagsNoFitBlackBox           = 0x00000004
; StringFormatFlagsDisplayFormatControl    = 0x00000020
; StringFormatFlagsNoFontFallback          = 0x00000400
; StringFormatFlagsMeasureTrailingSpaces   = 0x00000800
; StringFormatFlagsNoWrap                  = 0x00001000
; StringFormatFlagsLineLimit               = 0x00002000
; StringFormatFlagsNoClip                  = 0x00004000 
Gdip_StringFormatCreate(Format=0, Lang=0)
{
   DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
   return hFormat
}

; Regular = 0
; Bold = 1
; Italic = 2
; BoldItalic = 3
; Underline = 4
; Strikeout = 8
Gdip_FontCreate(hFamily, Size, Style=0)
{
   DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
   return hFont
}

Gdip_FontFamilyCreate(Font)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
	}
	
	DllCall("gdiplus\GdipCreateFontFamilyFromName"
					, Ptr, A_IsUnicode ? &Font : &wFont
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
	
	return hFamily
}

;#####################################################################################
; Matrix functions
;#####################################################################################

Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y)
{
   DllCall("gdiplus\GdipCreateMatrix2", "float", m11, "float", m12, "float", m21, "float", m22, "float", x, "float", y, A_PtrSize ? "UPtr*" : "UInt*", Matrix)
   return Matrix
}

Gdip_CreateMatrix()
{
   DllCall("gdiplus\GdipCreateMatrix", A_PtrSize ? "UPtr*" : "UInt*", Matrix)
   return Matrix
}

;#####################################################################################
; GraphicsPath functions
;#####################################################################################

; Alternate = 0
; Winding = 1
Gdip_CreatePath(BrushMode=0)
{
	DllCall("gdiplus\GdipCreatePath", "int", BrushMode, A_PtrSize ? "UPtr*" : "UInt*", Path)
	return Path
}

Gdip_AddPathEllipse(Path, x, y, w, h)
{
	return DllCall("gdiplus\GdipAddPathEllipse", A_PtrSize ? "UPtr" : "UInt", Path, "float", x, "float", y, "float", w, "float", h)
}

Gdip_AddPathPolygon(Path, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	StringSplit, Points, Points, |
	VarSetCapacity(PointF, 8*Points0)   
	Loop, %Points0%
	{
		StringSplit, Coord, Points%A_Index%, `,
		NumPut(Coord1, PointF, 8*(A_Index-1), "float"), NumPut(Coord2, PointF, (8*(A_Index-1))+4, "float")
	}   

	return DllCall("gdiplus\GdipAddPathPolygon", Ptr, Path, Ptr, &PointF, "int", Points0)
}

Gdip_DeletePath(Path)
{
	return DllCall("gdiplus\GdipDeletePath", A_PtrSize ? "UPtr" : "UInt", Path)
}

;#####################################################################################
; Quality functions
;#####################################################################################

; SystemDefault = 0
; SingleBitPerPixelGridFit = 1
; SingleBitPerPixel = 2
; AntiAliasGridFit = 3
; AntiAlias = 4
Gdip_SetTextRenderingHint(pGraphics, RenderingHint)
{
	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}

; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
{
   return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", InterpolationMode)
}

; Default = 0
; HighSpeed = 1
; HighQuality = 2
; None = 3
; AntiAlias = 4
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
{
   return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}

; CompositingModeSourceOver = 0 (blended)
; CompositingModeSourceCopy = 1 (overwrite)
Gdip_SetCompositingMode(pGraphics, CompositingMode=0)
{
   return DllCall("gdiplus\GdipSetCompositingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", CompositingMode)
}

;#####################################################################################
; Extra functions
;#####################################################################################

Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}

Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}

; Prepend = 0; The new operation is applied before the old operation.
; Append = 1; The new operation is applied after the old operation.
Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipRotateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", Angle, "int", MatrixOrder)
}

Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipScaleWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder=0)
{
	return DllCall("gdiplus\GdipTranslateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_ResetWorldTransform(pGraphics)
{
	return DllCall("gdiplus\GdipResetWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetRotatedTranslation(Width, Height, Angle, ByRef xTranslation, ByRef yTranslation)
{
	pi := 3.14159, TAngle := Angle*(pi/180)	

	Bound := (Angle >= 0) ? Mod(Angle, 360) : 360-Mod(-Angle, -360)
	if ((Bound >= 0) && (Bound <= 90))
		xTranslation := Height*Sin(TAngle), yTranslation := 0
	else if ((Bound > 90) && (Bound <= 180))
		xTranslation := (Height*Sin(TAngle))-(Width*Cos(TAngle)), yTranslation := -Height*Cos(TAngle)
	else if ((Bound > 180) && (Bound <= 270))
		xTranslation := -(Width*Cos(TAngle)), yTranslation := -(Height*Cos(TAngle))-(Width*Sin(TAngle))
	else if ((Bound > 270) && (Bound <= 360))
		xTranslation := 0, yTranslation := -Width*Sin(TAngle)
}

Gdip_GetRotatedDimensions(Width, Height, Angle, ByRef RWidth, ByRef RHeight)
{
	pi := 3.14159, TAngle := Angle*(pi/180)
	if !(Width && Height)
		return -1
	RWidth := Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
	RHeight := Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}

; RotateNoneFlipNone   = 0
; Rotate90FlipNone     = 1
; Rotate180FlipNone    = 2
; Rotate270FlipNone    = 3
; RotateNoneFlipX      = 4
; Rotate90FlipX        = 5
; Rotate180FlipX       = 6
; Rotate270FlipX       = 7
; RotateNoneFlipY      = Rotate180FlipX
; Rotate90FlipY        = Rotate270FlipX
; Rotate180FlipY       = RotateNoneFlipX
; Rotate270FlipY       = Rotate90FlipX
; RotateNoneFlipXY     = Rotate180FlipNone
; Rotate90FlipXY       = Rotate270FlipNone
; Rotate180FlipXY      = RotateNoneFlipNone
; Rotate270FlipXY      = Rotate90FlipNone 

Gdip_ImageRotateFlip(pBitmap, RotateFlipType=1)
{
	return DllCall("gdiplus\GdipImageRotateFlip", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", RotateFlipType)
}

; Replace = 0
; Intersect = 1
; Union = 2
; Xor = 3
; Exclude = 4
; Complement = 5
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode=0)
{
   return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}

Gdip_SetClipPath(pGraphics, Path, CombineMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, Path, "int", CombineMode)
}

Gdip_ResetClip(pGraphics)
{
   return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetClipRegion(pGraphics)
{
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt*", Region)
	return Region
}

Gdip_SetClipRegion(pGraphics, Region, CombineMode=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}

Gdip_CreateRegion()
{
	DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
	return Region
}

Gdip_DeleteRegion(Region)
{
	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}

;#####################################################################################
; BitmapLockBits
;#####################################################################################

Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode = 3, PixelFormat = 0x26200a)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	CreateRect(Rect, x, y, w, h)
	VarSetCapacity(BitmapData, 16+2*(A_PtrSize ? A_PtrSize : 4), 0)
	E := DllCall("Gdiplus\GdipBitmapLockBits", Ptr, pBitmap, Ptr, &Rect, "uint", LockMode, "int", PixelFormat, Ptr, &BitmapData)
	Stride := NumGet(BitmapData, 8, "Int")
	Scan0 := NumGet(BitmapData, 16, Ptr)
	return E
}

;#####################################################################################

Gdip_UnlockBits(pBitmap, ByRef BitmapData)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	return DllCall("Gdiplus\GdipBitmapUnlockBits", Ptr, pBitmap, Ptr, &BitmapData)
}

;#####################################################################################

Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride)
{
	Numput(ARGB, Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_GetLockBitPixel(Scan0, x, y, Stride)
{
	return NumGet(Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_PixelateBitmap(pBitmap, ByRef pBitmapOut, BlockSize)
{
	static PixelateBitmap
	
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if (!PixelateBitmap)
	{
		if A_PtrSize != 8 ; x86 machine code
		MCode_PixelateBitmap =
		(LTrim Join
		558BEC83EC3C8B4514538B5D1C99F7FB56578BC88955EC894DD885C90F8E830200008B451099F7FB8365DC008365E000894DC88955F08945E833FF897DD4
		397DE80F8E160100008BCB0FAFCB894DCC33C08945F88945FC89451C8945143BD87E608B45088D50028BC82BCA8BF02BF2418945F48B45E02955F4894DC4
		8D0CB80FAFCB03CA895DD08BD1895DE40FB64416030145140FB60201451C8B45C40FB604100145FC8B45F40FB604020145F883C204FF4DE475D6034D18FF
		4DD075C98B4DCC8B451499F7F98945148B451C99F7F989451C8B45FC99F7F98945FC8B45F899F7F98945F885DB7E648B450C8D50028BC82BCA83C103894D
		C48BC82BCA41894DF48B4DD48945E48B45E02955E48D0C880FAFCB03CA895DD08BD18BF38A45148B7DC48804178A451C8B7DF488028A45FC8804178A45F8
		8B7DE488043A83C2044E75DA034D18FF4DD075CE8B4DCC8B7DD447897DD43B7DE80F8CF2FEFFFF837DF0000F842C01000033C08945F88945FC89451C8945
		148945E43BD87E65837DF0007E578B4DDC034DE48B75E80FAF4D180FAFF38B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945CC0F
		B6440E030145140FB60101451C0FB6440F010145FC8B45F40FB604010145F883C104FF4DCC75D8FF45E4395DE47C9B8B4DF00FAFCB85C9740B8B451499F7
		F9894514EB048365140033F63BCE740B8B451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB
		038975F88975E43BDE7E5A837DF0007E4C8B4DDC034DE48B75E80FAF4D180FAFF38B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955CC8A55
		1488540E038A551C88118A55FC88540F018A55F888140183C104FF4DCC75DFFF45E4395DE47CA68B45180145E0015DDCFF4DC80F8594FDFFFF8B451099F7
		FB8955F08945E885C00F8E450100008B45EC0FAFC38365DC008945D48B45E88945CC33C08945F88945FC89451C8945148945103945EC7E6085DB7E518B4D
		D88B45080FAFCB034D108D50020FAF4D18034DDC8BF08BF88945F403CA2BF22BFA2955F4895DC80FB6440E030145140FB60101451C0FB6440F010145FC8B
		45F40FB604080145F883C104FF4DC875D8FF45108B45103B45EC7CA08B4DD485C9740B8B451499F7F9894514EB048365140033F63BCE740B8B451C99F7F9
		89451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975103975EC7E5585DB7E468B4DD88B450C
		0FAFCB034D108D50020FAF4D18034DDC8BF08BF803CA2BF22BFA2BC2895DC88A551488540E038A551C88118A55FC88540F018A55F888140183C104FF4DC8
		75DFFF45108B45103B45EC7CAB8BC3C1E0020145DCFF4DCC0F85CEFEFFFF8B4DEC33C08945F88945FC89451C8945148945103BC87E6C3945F07E5C8B4DD8
		8B75E80FAFCB034D100FAFF30FAF4D188B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945C80FB6440E030145140FB60101451C0F
		B6440F010145FC8B45F40FB604010145F883C104FF4DC875D833C0FF45108B4DEC394D107C940FAF4DF03BC874068B451499F7F933F68945143BCE740B8B
		451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975083975EC7E63EB0233F639
		75F07E4F8B4DD88B75E80FAFCB034D080FAFF30FAF4D188B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955108A551488540E038A551C8811
		8A55FC88540F018A55F888140883C104FF4D1075DFFF45088B45083B45EC7C9F5F5E33C05BC9C21800
		)
		else ; x64 machine code
		MCode_PixelateBitmap =
		(LTrim Join
		4489442418488954241048894C24085355565741544155415641574883EC28418BC1448B8C24980000004C8BDA99488BD941F7F9448BD0448BFA8954240C
		448994248800000085C00F8E9D020000418BC04533E4458BF299448924244C8954241041F7F933C9898C24980000008BEA89542404448BE889442408EB05
		4C8B5C24784585ED0F8E1A010000458BF1418BFD48897C2418450FAFF14533D233F633ED4533E44533ED4585C97E5B4C63BC2490000000418D040A410FAF
		C148984C8D441802498BD9498BD04D8BD90FB642010FB64AFF4403E80FB60203E90FB64AFE4883C2044403E003F149FFCB75DE4D03C748FFCB75D0488B7C
		24188B8C24980000004C8B5C2478418BC59941F7FE448BE8418BC49941F7FE448BE08BC59941F7FE8BE88BC69941F7FE8BF04585C97E4048639C24900000
		004103CA4D8BC1410FAFC94863C94A8D541902488BCA498BC144886901448821408869FF408871FE4883C10448FFC875E84803D349FFC875DA8B8C249800
		0000488B5C24704C8B5C24784183C20448FFCF48897C24180F850AFFFFFF8B6C2404448B2424448B6C24084C8B74241085ED0F840A01000033FF33DB4533
		DB4533D24533C04585C97E53488B74247085ED7E42438D0C04418BC50FAF8C2490000000410FAFC18D04814863C8488D5431028BCD0FB642014403D00FB6
		024883C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC17CB28BCD410FAFC985C9740A418BC299F7F98BF0EB0233F685C9740B418BC3
		99F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585C97E4D4C8B74247885ED7E3841
		8D0C14418BC50FAF8C2490000000410FAFC18D04814863C84A8D4431028BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2413BD17CBD
		4C8B7424108B8C2498000000038C2490000000488B5C24704503E149FFCE44892424898C24980000004C897424100F859EFDFFFF448B7C240C448B842480
		000000418BC09941F7F98BE8448BEA89942498000000896C240C85C00F8E3B010000448BAC2488000000418BCF448BF5410FAFC9898C248000000033FF33
		ED33F64533DB4533D24533C04585FF7E524585C97E40418BC5410FAFC14103C00FAF84249000000003C74898488D541802498BD90FB642014403D00FB602
		4883C2044403D80FB642FB03F00FB642FA03E848FFCB75DE488B5C247041FFC0453BC77CAE85C9740B418BC299F7F9448BE0EB034533E485C9740A418BC3
		99F7F98BD8EB0233DB85C9740A8BC699F7F9448BD8EB034533DB85C9740A8BC599F7F9448BD0EB034533D24533C04585FF7E4E488B4C24784585C97E3541
		8BC5410FAFC14103C00FAF84249000000003C74898488D540802498BC144886201881A44885AFF448852FE4883C20448FFC875E941FFC0453BC77CBE8B8C
		2480000000488B5C2470418BC1C1E00203F849FFCE0F85ECFEFFFF448BAC24980000008B6C240C448BA4248800000033FF33DB4533DB4533D24533C04585
		FF7E5A488B7424704585ED7E48418BCC8BC5410FAFC94103C80FAF8C2490000000410FAFC18D04814863C8488D543102418BCD0FB642014403D00FB60248
		83C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC77CAB418BCF410FAFCD85C9740A418BC299F7F98BF0EB0233F685C9740B418BC399
		F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585FF7E4E4585ED7E42418BCC8BC541
		0FAFC903CA0FAF8C2490000000410FAFC18D04814863C8488B442478488D440102418BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2
		413BD77CB233C04883C428415F415E415D415C5F5E5D5BC3
		)
		
		VarSetCapacity(PixelateBitmap, StrLen(MCode_PixelateBitmap)//2)
		Loop % StrLen(MCode_PixelateBitmap)//2		;%
			NumPut("0x" SubStr(MCode_PixelateBitmap, (2*A_Index)-1, 2), PixelateBitmap, A_Index-1, "UChar")
		DllCall("VirtualProtect", Ptr, &PixelateBitmap, Ptr, VarSetCapacity(PixelateBitmap), "uint", 0x40, A_PtrSize ? "UPtr*" : "UInt*", 0)
	}

	Gdip_GetImageDimensions(pBitmap, Width, Height)
	
	if (Width != Gdip_GetImageWidth(pBitmapOut) || Height != Gdip_GetImageHeight(pBitmapOut))
		return -1
	if (BlockSize > Width || BlockSize > Height)
		return -2

	E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1)
	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width, Height, Stride2, Scan02, BitmapData2)
	if (E1 || E2)
		return -3

	E := DllCall(&PixelateBitmap, Ptr, Scan01, Ptr, Scan02, "int", Width, "int", Height, "int", Stride1, "int", BlockSize)
	
	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)
	return 0
}

;#####################################################################################

Gdip_ToARGB(A, R, G, B)
{
	return (A << 24) | (R << 16) | (G << 8) | B
}

;#####################################################################################

Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B)
{
	A := (0xff000000 & ARGB) >> 24
	R := (0x00ff0000 & ARGB) >> 16
	G := (0x0000ff00 & ARGB) >> 8
	B := 0x000000ff & ARGB
}

;#####################################################################################

Gdip_AFromARGB(ARGB)
{
	return (0xff000000 & ARGB) >> 24
}

;#####################################################################################

Gdip_RFromARGB(ARGB)
{
	return (0x00ff0000 & ARGB) >> 16
}

;#####################################################################################

Gdip_GFromARGB(ARGB)
{
	return (0x0000ff00 & ARGB) >> 8
}

;#####################################################################################

Gdip_BFromARGB(ARGB)
{
	return 0x000000ff & ARGB
}

;#####################################################################################

StrGetB(Address, Length=-1, Encoding=0)
{
	; Flexible parameter handling:
	if Length is not integer
	Encoding := Length,  Length := -1

	; Check for obvious errors.
	if (Address+0 < 1024)
		return

	; Ensure 'Encoding' contains a numeric identifier.
	if Encoding = UTF-16
		Encoding = 1200
	else if Encoding = UTF-8
		Encoding = 65001
	else if SubStr(Encoding,1,2)="CP"
		Encoding := SubStr(Encoding,3)

	if !Encoding ; "" or 0
	{
		; No conversion necessary, but we might not want the whole string.
		if (Length == -1)
			Length := DllCall("lstrlen", "uint", Address)
		VarSetCapacity(String, Length)
		DllCall("lstrcpyn", "str", String, "uint", Address, "int", Length + 1)
	}
	else if Encoding = 1200 ; UTF-16
	{
		char_count := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "uint", 0, "uint", 0, "uint", 0, "uint", 0)
		VarSetCapacity(String, char_count)
		DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "str", String, "int", char_count, "uint", 0, "uint", 0)
	}
	else if Encoding is integer
	{
		; Convert from target encoding to UTF-16 then to the active code page.
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", 0, "int", 0)
		VarSetCapacity(String, char_count * 2)
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", &String, "int", char_count * 2)
		String := StrGetB(&String, char_count, 1200)
	}
	
	return String
}


; ...........................................................................................

/*q:: ;Notepad - set active position (caret) at right
PostMessage, 0xB1, 5, 10, Edit1, A ;EM_SETSEL := 0xB1
return

w:: ;Notepad - set active position (caret) at left
PostMessage, 0xB1, 10, 5, Edit1, A ;EM_SETSEL := 0xB1
return
*/
JEE_EditGetRange(hCtl, ByRef vPos1, ByRef vPos2)
{
    VarSetCapacity(vPos1, 4), VarSetCapacity(vPos2, 4)
    SendMessage, 0xB0, % &vPos1, % &vPos2,, % "ahk_id " hCtl ;EM_GETSEL := 0xB0 ;(left, right)
    vPos1 := NumGet(&vPos1, 0, "UInt"), vPos2 := NumGet(&vPos2, 0, "UInt")
}

;==================================================

JEE_EditSetRange(hCtl, vPos1, vPos2, vDoScroll:=0)
{
    SendMessage, 0xB1, % vPos1, % vPos2,, % "ahk_id " hCtl ;EM_SETSEL := 0xB1 ;(anchor, active)
    if vDoScroll
        SendMessage, 0xB7, 0, 0,, % "ahk_id " hCtl ;EM_SCROLLCARET := 0xB7
}

;==================================================

;note: although this involves deselecting and selecting it seems to happen invisibly
JEE_EditGetRangeAnchorActive(hCtl, ByRef vPos1, ByRef vPos2)
{
    ;get selection
    VarSetCapacity(vPos1, 4), VarSetCapacity(vPos2, 4)
    SendMessage, 0xB0, % &vPos1, % &vPos2,, % "ahk_id " hCtl ;EM_GETSEL := 0xB0
    vPos1 := NumGet(&vPos1, 0, "UInt"), vPos2 := NumGet(&vPos2, 0, "UInt")
    if (vPos1 = vPos2)
        return
    vPos1X := vPos1, vPos2X := vPos2

    ;set selection to 0 characters and get active position
    SendMessage, 0xB1, -1, 0,, % "ahk_id " hCtl ;EM_SETSEL := 0xB1
    VarSetCapacity(vPos2, 4)
    SendMessage, 0xB0, % &vPos2, 0,, % "ahk_id " hCtl ;EM_GETSEL := 0xB0
    vPos2 := NumGet(&vPos2, 0, "UInt")

    ;restore selection
    vPos1 := (vPos2 = vPos2X) ? vPos1X : vPos2X
    SendMessage, 0xB1, % vPos1, % vPos2,, % "ahk_id " hCtl ;EM_SETSEL := 0xB1 ;(anchor, active)
}

MyIcon_B64()
{
    static icostr
    icostr := "
    (LTrim Join
    AAABAAEAICAAAAEAIACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAgBAAAGAbAABgGwAAAAAAAAAAAAD7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////f/////RERE//tcQv/7XEL////////////////////////////////////////////////3/////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////f/////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////90RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////////////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////////////////////f////3////9/////f///////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
    )"
    return icostr
} 
