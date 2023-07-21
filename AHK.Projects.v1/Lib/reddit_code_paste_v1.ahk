#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

reddit_code_paste_v1() {
    #Requires AutoHotkey v1.1+                  ; Prevents accidental use in v2 script
    str := ""                                   ; Fresh string to build the end product
    Loop, Parse, % Clipboard, `n, `r            ; Loop through each line of text on the clipboard
        str .= "`n    " A_LoopField             ; Add a new line and 4 spaces to the start of each line of code
    Clipboard := str "`n"                       ; Add a new line to the end and stick it on the clipboard
    SendInput, ^v                               ; Paste the code into your post/reply
}