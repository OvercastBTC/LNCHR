;#Requires AutoHotkey v

sourcePath := %root%
destPath := %OneDrive%%teams%%t_script%

userFunc := Func("ShowProgress").Bind(100, 100) ; x = 100, y = 100
CopyFile(sourcePath, destPath, userFunc, true)
Return

CopyFile(sourcePath, destPath, userFunc, overwrite := false) {
   destPath := RegExReplace(destPath, "\\\*?(\.\*)?$")
   SplitPath, destPath,, destDir
   SplitPath, sourcePath, sourceFileName
   
   if InStr( FileExist(destPath), "D" )
      destPath := (destDir := destPath) . "\" . sourceFileName
   else if !InStr( FileExist(destDir), "D" )
      throw Exception("Destination folder does not exist!")
   
   if (!overwrite && FileExist(destPath)) {
      MsgBox, Destination file already exists!
      Return
   }
   info := {source: sourceFileName, dest: destDir, func: userFunc}
   pInfo := Object(info)
   pCallBack := RegisterCallback("LPPROGRESS_ROUTINE", "F", 2, pInfo)
   ObjRelease(pInfo)
   if !DllCall("CopyFileEx", Str, sourcePath, Str, destPath, Ptr, pCallBack, Ptr, 0, UInt, 0, UInt, 0)
      throw Exception("Can't copy file. A_LastError: " . A_LastError)
}

LPPROGRESS_ROUTINE(TotalFileSize, TotalBytesTransferred) {
   oInfo := Object(A_EventInfo)
   if (TotalBytesTransferred != TotalFileSize)
      oInfo.func.Call(TotalBytesTransferred/TotalFileSize*100, oInfo.source, oInfo.dest)
   else
      oInfo.func.Call("Off")
}

ShowProgress(x := "", y := "", percent := 0, fileName := "", destFolder := "") {
	if !WinExist("MyProgress ahk_class AutoHotkey2")
		Progress, x%x% y%y% w300 b1, % "to " . destFolder, % fileName . " is being copied...", MyProgress
	Progress, % percent
}