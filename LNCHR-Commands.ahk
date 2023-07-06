lngui_run_commands(input){if ((input == "todo") and (UsingAnyWorkcomputer)) ; View Tasks (Outlook) {close_lngui()tryrun('"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /recycle /select outlook:tasks')return}if ((input == "cal") and (UsingAnyWorkcomputer)) ; Work Calendar {close_lngui()tryrun('"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /recycle /select outlook:calendar')return}if ((input == "com") and (UsingAnyWorkcomputer)) ; Compose {close_lngui()outlookApp := GetOutlookCom()
MailItem := outlookApp.CreateItem(0)
MailItem.Displayreturn}if ((input == "inb") and (UsingAnyWorkcomputer)) ; Work inbox {close_lngui()tryrun('"C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE" /recycle /select outlook:inbox')return}if ((input == "task") and (UsingAnyWorkcomputer)) ; Task (Outlook) {close_lngui()outlookApp := GetOutlookCom()
MailItem := outlookApp.CreateItem(3)
MailItem.Displayreturn}if input == "?" ; Help {tryrun("HELP-Commands.txt")
Sleep(100)
close_lngui()
build_lngui()return}if input == "a dir" ; Launcher Dir {close_lngui()tryrun('%A_ScriptDir%\..\')return}if input == "a edit" ; Launcher edit in Pycharm {close_lngui()tryrun('pycharm64 %A_ScriptDir%\..\.')return}if input == "a kill" ; Kill {close_lngui()tryrun('%A_ScriptDir%\..\..\KillAHK.ahk')return}if input == "a rel" ; Reload {close_lngui()Reloadreturn}if input == "a show" ; AHK show scripts {close_lngui()tryrun('%A_ScriptDir%\..\ShowAHKScripts.ahk')return}if input == "a sta" ; Start {close_lngui()tryrun('%A_ScriptDir%\..\..\AHKstartup.ahk')return}if input == "a xk" ; Key Replace Excel Mgt {close_lngui()tryrun('%A_ScriptDir%\..\..\TextReplacementsGenerator.xlsm')return}if input == "a xl" ; Launcher Excel Mgr {close_lngui()tryrun('%A_ScriptDir%\..\LNCHR-CommandsGenerator.xlsm')return}if input == "awa" ; Awake {close_lngui()tryrun('%A_ScriptDir%\..\..\StayAwake.ahk')return}if input == "mik" ; MiKTeX {close_lngui()tryrun('mpm')return}if input == "not" ; Notepad {close_lngui()tryrun('Notepad')return}if input == "pai" ; Paint {close_lngui()tryrun('C:\Windows\system32\mspaint.exe')return}if input == "pho" ; Your Phone {close_lngui()tryrun('shell:AppsFolder\Microsoft.YourPhone_8wekyb3d8bbwe!App')return}if input == "qt" ; Questrade IQ Edge {close_lngui()tryrun('https://www.questrade.com/home')return}if input == "zoo" ; ZooMagnifier {close_lngui()tryrun('%A_ScriptDir%\..\..\ZooMagnifier.ahk')return}if input == " h" ; Hibernate {close_lngui()DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)return}if input == " l" ; Log out {close_lngui()Shutdown(0)return}if input == " p" ; Power {close_lngui()Shutdown(2)return}if input == " r" ; Restart {close_lngui()Shutdown(1)return}if input == " s" ; Sleep {close_lngui()DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)return}if input == "caps" ; CapsLock Toggle {close_lngui()if GetKeyState("CapsLock", "T") == 1
 {
   SetCapsLockState False
 }
else if GetKeyState("CapsLock", "F") == 0
 {
   SetCapsLockState True
 }return}if input == "doc" ; Documents {close_lngui()tryrun('"C:\Users\' A_Username '\Documents"')return}if input == "down" ; Downloads {close_lngui()tryrun('"C:\Users\' A_Username '\Downloads"')return}if input == "pro" ; Projects {close_lngui()tryrun('"C:\Users\' A_Username '\Projects"')return}if input == "rec" ; Recycling Bin {close_lngui()tryrun('::{645FF040-5081-101B-9F08-00AA002F954E}')return}if input == "pc" ; This PC {close_lngui()tryrun('explorer =')return}if input == "msc" ; MSc Folder {close_lngui()tryrun('"C:\Users\' A_Username '\MScThesis"')return}if input == "pydir" ; Python 310 Dir {close_lngui()tryrun('"C:\Users\' A_Username '\AppData\Local\Programs\Python\Python310"')return}if input == "pys" ; Pystuff {close_lngui()tryrun('C:\pystuff')return}if input == "too" ; Tools {close_lngui()tryrun('%A_ScriptDir%\..\..\')return}if input == "/" ; r/ {lngui_enable_query("r/", make_run_ReplaceTexts_func("https://www.reddit.com/r/REPLACEME"))return}if input == "c " ; Calculator {lngui_enable_calc()return}if input == "e " ; Everything {lngui_enable_query("Everything", make_run_ReplaceTexts_func("C:\Program Files\Everything\Everything.exe -search REPLACEME"))return}if input == "g " ; Google {lngui_enable_query("Google", make_run_ReplaceTexts_func("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l="))return}if input == "i " ; Google Private {lngui_enable_query("Google Private", make_run_ReplaceTexts_func("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME"))return}if input == "m " ; Multi Search {lngui_enable_query("Multi Search", make_run_ReplaceTexts_func("https://www.google.com/search?&q=REPLACEME","https://duckduckgo.com/?q=REPLACEME"))return}if input == "o " ; Outlook {lngui_enable_query("Outlook", OutlookSearch)return}if input == "r " ; Run {lngui_enable_query("Run", make_run_ReplaceTexts_func("REPLACEME"))return}if input == "s " ; Spotify {lngui_enable_query("Spotify", make_run_ReplaceTexts_func("https://open.spotify.com/search/REPLACEME"))return}if input == "t " ; Torrents {lngui_enable_query("Torrents", make_run_ReplaceTexts_func("https://www.google.com/search?&q=REPLACEME","https://www.google.com/search?&q=REPLACEME"))return}if input == "td " ; TeX Doc {lngui_enable_query("TeX Doc", make_run_ReplaceTexts_func("https://texdoc.org/serve/REPLACEME/0"))return}if input == "w " ; Wolfram Alpha {lngui_enable_query("Wolfram Alpha", make_run_ReplaceTexts_func("https://www.wolframalpha.com/input/?i=REPLACEME"))return}if input == "y " ; YouTube {lngui_enable_query("YouTube", make_run_ReplaceTexts_func("https://www.youtube.com/results?search_query=REPLACEME"))return}if input == "cal" ; Calendar {close_lngui()tryrun('https://www.google.com/calendar')return}if input == "dri" ; Drive {close_lngui()tryrun('www.drive.google.com/')return}if input == "git" ; Github {close_lngui()tryrun('https://github.com/')return}if input == "gma" ; Gmail {close_lngui()tryrun('https://mail.google.com/')return}if input == "kee" ; Google Keep Notes {close_lngui()tryrun('https://keep.google.com/')return}if input == "map" ; Maps {close_lngui()tryrun('https://www.google.com/maps/')return}if input == "ovr" ; Overleaf {close_lngui()tryrun('https://www.overleaf.com/project')return}if input == "red" ; Reddit {close_lngui()tryrun('www.reddit.com')return}if input == "reg" ; Regex {close_lngui()tryrun('https://regex101.com/')return}if input == "wea" ; Weather {close_lngui()tryrun('https://weawow.com/')return}if input == "wha" ; WhatsApp {close_lngui()tryrun('https://web.whatsapp.com')return}if input == "sou" ; Sound {close_lngui()tryrun('"' A_ScriptDir '\..\SoundCardCheck.ahk"')return}if input == "c?" ; Calculator Help {close_lngui()tryrun('TODO')return}if input == "cli" ; Clipboard {close_lngui()Send '^``'return}if input == "cmd" ; Command Prompt {close_lngui()tryrun('"cmd.exe "')return}if input == "col" ; Color Picker {close_lngui()Send '#+c'return}if input == "cont" ; Control Panel {close_lngui()tryrun('control')return}if input == "draw" ; draw.io {close_lngui()tryrun('"C:\Program Files\draw.io\draw.io.exe"')return}if input == "emo" ; Emojis {close_lngui()Send '#.'return}if input == "env" ; Environment Variables {close_lngui()tryrun('""C:\Windows\system32\rundll32.exe" sysdm.cpl`,EditEnvironmentVariables "')return}if input == "ext" ; Extract text {close_lngui()Send '#+e'return}if input == "ip" ; Python Console {close_lngui()SetWorkingDir("C:\Users\" A_Username "\Desktop") 
tryrun('ipython --no-banner --automagic')return}if input == "k?" ; Keyboard Shortcut Help {close_lngui()tryrun('TODO')return}if input == "mag" ; Magnifier {close_lngui()tryrun("C:\Users\" A_Username "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility\Magnify.lnk")return}if input == "mou" ; Mouse Highlighter {close_lngui()SendLevel(0)
Send "^!#m"
SendLevel(1)return}if input == "mut" ; Mute mic and cam {close_lngui()Send '#+n'return}if input == "resx" ; Resetart explorer {close_lngui()run 'taskkill /f /im explorer.exe'
run 'explorer.exe'return}if input == "rul" ; Ruler {close_lngui()Send '#+m'return}if input == "sni" ; Snip n Sketch {close_lngui()Send '#+s'return}if input == "tm" ; Task Manager {close_lngui()tryrun('taskmgr')return}if input == "top" ; Set Window on top {close_lngui()Send '#^t'return}if input == "xmag" ; Exit Magnifier {close_lngui()tryrun('TODO')return}if input == "zon" ; FancyZones {close_lngui()Send '#+``'return}}