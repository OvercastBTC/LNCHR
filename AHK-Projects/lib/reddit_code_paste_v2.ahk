;+^v::reddit_code_paste()                        ; Use Shift+Ctrl+v to paste formatted code

reddit_code_paste_v2() {
    #Requires AutoHotkey v2.0+                  ; Prevents accidental use in v1 script
    str := ""                                   ; Fresh string to build the end product
    loop parse A_Clipboard, '`n', '`r'          ; Loop through each line of text on the clipboard
        str .= "`n    " A_LoopField             ; Add a new line and 4 spaces to the start of each line of code
    A_Clipboard := str "`n"                     ; Add a new line to the end and stick it on the clipboard
    SendInput('^v')                             ; Paste the code into your post/reply
}