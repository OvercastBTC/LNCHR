#Include, reddit_code_paste_v2.ahk
#Include, reddit_code_paste_v1.ahk

+^v::reddit_code_paste()                        ; Use Shift+Ctrl+v to paste formatted code

reddit_code_paste(){
    tooltip % A_AhkVersion    
    If(A_AhkVersion > 1 ){
        reddit_code_paste_v2()
    } else {
        reddit_code_paste_v1()
    }
}
return