; Makes a Cross Reference list (& Function Map etc) for AHK, DOS, C, JS scripts
#NoEnv                               ; For performance & future compatibility
#Warn                                ; For catching common errors
SendMode Input                       ; For superior speed and reliability
SetBatchLines -1                     ; Run at full speed
vn := "  v2023.02.07"    ; y.m.d     ; Author: TAC109
;@Ahk2Exe-SetVersion     %A_PriorLine~U)^(.+"){1} *v(.+)".*$~$2%
#SingleInstance Off
; ================================  Program  ===================================
scr:=rr(A_ScriptName,"\.[^.]+$"), ck=" checked", id=im=q=[], gz=" xp-20 yp+21 "
gf:=["Verdana"], gb=" w60 h25 ", gy=" xp+20 yp+21 ", sc=" Script", n="`n"
DL:=Chr(127), nf:={"for(":2,"if(":3,"switch(":2,"until(":1,"while(":3} ; Not fn
nr:=" number right ", c3=" Check3 ", ini=A_ScriptDir "\" scr ".ini" 
df:="<defaults>",sd=" (subset)",L1="^\d+\D+",L2="\D+\d+$",z="es script options "
y:="&'Update' ", udd={-1:y "eras" z, 0:y "saves all as default", 1:y "sav" z}
z:="&Tighten report format", trd:={-1:z " further",0:z, 1:z}, y=" library links"
z:="AHK: &#Include ", ipd:={-1:z "- full" y,0:z "processing",1:z "- partial" y}
z:="&Print report", prd:={-1:z " and exit Notepad",0:z,1:z}, _="/", b2=2*10**9
z:="&Add Lone Words list", lod:={-1:z ", no XRef", 0:z, 1:z}, gxy=" x110 yp+20 "
z:="Add &Function Map", fmd:={-1:z ", no XRef", 0:z, 1:z}, lt=" longer than"
z:="AHK: Match Gui &V ", y:=" labels", vgd:={-1:z "&& G" y, 0:z "&& G" y, 1:z y}
af:=["{}/F/{1}/{4}/{2}"n,"{}/L/{5}/{}/{4}/{2}`n{5}/{}/R/{4}/{2}/{1}"n] ; Fn Map

A_:={AhkPath:2,AppDataCommon:2,AppData:2,ComputerName:2    ; A_xxx variables
,ComSpec:2,Desktop:2,DesktopCommon:2,MyDocuments:2,IsCompiled:2,ProgramFiles:2
,Programs:2,ProgramsCommon:2,Space:2,StartMenu:2,StartMenuCommon:2,Startup:2
,StartupCommon:2,Tab:2,Temp:2,UserName:2,WinDir:2}
xe:=A_AhkPath, fc=fx=0, (%fc%&&rr(%true%,"^.+\.")="exe")?(fc:=fx:=1, xe=%fc%):0
                                                           ;^ Arg1=.exe?=AhkPath
rpt:                                         ; <========== ; Get next file name
mkg(,["d",0]),(%false%-fx)?(fc++,fi:=FileExist(%fc%)?%fc%:0):fi:=0
IfEqual true, % fc-fx&&!fi, MsgBox 48,, % """" %fc% """ not found!" ; Fn params?
IfEqual fi,0, FileSelectFile fi,3,,% scr " - Select next AHK, DOS, C, or JS"
. " source file  (Cancel to exit)", Scripts (*.ah??;*.bat;*.nt;*.c*;*.h*;*.js)
IfEqual fi,, ExitApp                                       ; Finished?

Loop Files, %fi%, FD                      ; Convert any short names to full name
  ext:=rr(fi:=A_LoopFileFullPath,"^.+\.") ;v File ext, ex=AHK=a;DOS=d;C,JS=c
fn:=rr(fi,"^.+\\"), ex:={ahk:"a",ah2:"a",ahk2:"a",bat:"d",cmd:"d",nt:"d"}[ext]
ex:=ex?ex:"c",co:=ex="d"?":":"\({):,",co.=ex="a"?"\x{7F}-\x{10FFFF}":"" ;Unicode
ac:=";", ae="``", i2=lh=lw="", f#=g=ic=lb=le=mn=nz=ud=0, ldd(,0) ; Init vars
SetWorkingDir % rr(fi,ph:="\\[^\\]+$"), da:=(ex="a"?"":" disabled") ck

mkg(,["f",["s10 bold",gf],"a",["t",["w460 Center" ; <===== ; Make Gui
. ",`nCross Reference for AHK, DOS, C, and JS scripts"]], "f",["s9 norm",gf]
, "a",["StatusBar",0],["t",["w460 Center,Syntax analysis is rudimentary, and"
. " quoted data is always included.`n`nThe report file is created with the same"
. " path and name`n as the input file, but with an extension of '.xref'." 
. "`n`nIf requested, the optional Function Map analysis requires that`n"
. {a:"AHK function headers spanning lines must use commas for continuation."
,c:"C and JS files must be in a 'pretty print' format, i.e. function definition"
. "`nlines must start in col 1, while references must be earlier or indented."
,  d:"any DOS 'call :label' words must be on the same line."}[ex] "`n'With all"
. "...' works best if function/label names differ from variables.`n"],"g"
,["w280 r12 x100 cGreen,Options"],"c",[ck lo c3 gxy "vlo w240 gck3, " lod[lo]
,ck fm c3 "vfm w240 gck3, " fmd[fm],   ck fa gy  "vfa, &With all references"
,ck cm gz "vcm, &Insert comment data",ck hy " vhy, &Hyphenate names (>1/up)"]
,"t",["x145 yp+22,S&kip words" lt],"e",[nr "w30 h17 yp-1 xp-35 vsk," sk],"c",[
,ck tr c3 "vtr w240 gck3, " trd[tr],  da vg c3 "vvg w240 gck3, "vgd[ex="a"?vg:0]
,da ip c3 "vip w240 gck3, "ipd[ex="a"?ip:0],da bi gy "vbi, &Block auto-includes"
,ck pr c3 gz "vpr w240 gck3, " prd[pr],     ck dr " vdr, &Delete report file"
,"yp+30 glno vlg, &Get script subset (may alter Options)",c3 "vud w340 gck3, "
. udd[ud]],"b",[gb "Default gBtnOk,&Ok",gb "xp+66 gGuiClose,E&xit",gb "xp+66 "
. "gBtnUpd,&Update",gb "xp+66 grpt,&Select"],"g",["w280 r4 x100 cGreen,Setup"]
,"t",["x180 yp+25,&Characters/line (maximum)"],"e",[nr "w60 yp-2 xp-70 vlz," lz]
,"t",["x180 yp+25,&Lines/page (for >1/up report)"],"e",[nr "w60 yp-2 xp-70 "
. "vpz," pz],"b",[gb "w60 h22 x110 yp+23 gBtnMono,&Mono"]
,"t",["xp+70 yp+2,Set various Notepad defaults"]], "s",[[fn hd " - " scr vn]]])
IfEqual false,% fc-fx, return                ;  Fall through if file name params

BtnOk:                                       ; <========== ; User pressed OK
mkg(,["su",["NoHide",0]]), id=[], im=[], out="", wy=0      ; Empty arrays, etc
IfLess pz,3, IfNotEqual pz,0, MsgBox 8240,,Lines/page must be 0 or >2!
IfLess pz,3, IfNotEqual pz,0, return                       ; Validate lines/page
FormatTime dt,% ("R D0 T2", SB_SetText("Analysing script...")) ; Heading date
A_.ScriptFullPath:=fi, A_.ScriptDir:=rr(fi,ph), A_.ScriptName:=fn
rf(fi,mn++,lb,le), em="Error: cannot do auto-includes as " ; Process script
(ex="a"&&ip&&!bi&&!xe)?id[em "an AutoHotkey exe was not found!",0]:=0 _ _ _ _:0 
if (ex="a"&&ip&&!bi&&xe && z:="/script") ;^ Auto-includes? ;v Make temp files
{ ib:=A_Temp "\ilib" A_TickCount, ie=ib ".err",il=ib ".ahk",io("Delete",ib ".*")
  RunWait "%comspec%" /c ""%xe%" %z% /iLib "%il%" /ErrorStdOut "%fi%" 2>"%ie%""
  , % A_.ScriptDir, UseErrorLevel Hide  ;^ Editor may flag but it's valid syntax
  FileRead iee, % (ie, el := ErrorLevel)                   ;^ Get auto-includes
  (el=2)?(id[Trim(iee,"`r`n"),0]:=0 _ _ _ _
        , id[em "script contains syntax errors!",0]:=0 _ _ _ _)
  :(el) ? id[em "error '" el "' occurred!",0]      :=0 _ _ _ _:0
  (FileExist(il))?rf(il,"",,,ip=1?"U":"F",ip=1?"Q":"R",ip=1?"Z":" ",1):0
  io("Delete",ib ".*")                                     ;^ Do auto-includes
}                                  ;v Sizes (module#, module alpha, ln#+1, item)
agv:=ex="a"&&vg?vg=1?{V:"A"}:{G:"V",V:"A"}:{}, SB_SetText(""), mnz:=StrLen(--mn)
maz:=StrLen(mna(mn)), s=dp(maz+ ++nz), iz=StrLen(ic), y=(maz+nz)*4
IfLess lz, % y, MsgBox 8240,,Characters/line must be %y% or greater!
try goto % "rpt" (lz<y?"":_), ak:={" ":1,F:2,R:2}, aa:={A:" ",U:"F",V:"R"}
SB_SetText("Creating XRef..."), x:="}/{:", am:={A:1,U:2,V:2} ; Pad #s to max sz
Loop Parse,% RTrim(i2,n),% (n, i3="", y="{}/{6}/{2:"mnz x nz "}{:-"maz x iz "}")
  w:=StrSplit(A_LoopField,_), v:=SubStr(w.1,2), (w.6="Q")?0:(i3.=Format(y n,w*)
  ,((w.6:=agv[SubStr(w.1,1,1)])&&v+0!=v)?(w.1:=v, i3.=Format(y n,w*)):0) ;Q=>nul
;   1   2   3   4   5   6      1   2  3    4     5       1 2   3    4     5   6
;^ wrd/md#/ln#/mda/itm#/fn => wrd/fn/md#/ln#mda/itm# =>v /wrd/md#/ln#mda/itm#/fn
;v Include library partial fn's, drop non-matching v-variables & g-labels
Loop Parse,% RTrim(Sort(i3,1),n),% (n,i2=p1=p2="",y="/{}/{3}/{}/{}/{2}",nz+=maz)
  w:=StrSplit(A_LoopField,_) ;w.2=A=v-var,F=fn,R=fnref,U=fn part,V=g-lab," "=rst
  , (z:=ak[w.2])?p%z%:=w.1:0, (z:=am[w.2])?(""w.1=p%z%)?w.2:=aa[w.2]:z:=0:z:=1
  , (z)?(i2.=Format(y n,w*), z=StrLen(w.1), wy:=wy>z?wy:z, im[w.3,0]:=1):0

;v w.1>1=new md#/2=new mda, k>full path or message/w.2>3=md#/w.3>4=ln#,w.4>mda
for k, v in id, i3="", wz=0, z:=ip=1?"Partial":"Full"      ; #Include list?
  if (id["Selection:- " z (bi?", Blocked":""),0]:=_ _ _ _)
    break
for k, v in id, z="{3:" mnz "}/{1:"maz "}  {}/{4:"mnz "}/{:"nz-maz "}{:-"maz "}"
 for x, y in v, x=StrLen(k)+maz+2, wz:=wz>x?wz:x           ; Largest word size
  w:=StrSplit(y,_), (x)?w.1:=u:u:=w.1, i3.=Format(z n,mna(im[w.1,0]?w.1:0),k,w*)
(i3)?(Sort(i3), hdg("#Include List",dt,out), fmt(,,,3)):0  ; Sort, print Include
    op:=["c"][cm]                                          ;<v Add opts to hdg
 . ["h"][hy] . ["vg",,"v"][vg*(ex="a")+2] (sk?sk:""), op:=op?" (" op ") ":""
Sort(i2), (fm<0||lo<0)?0:(hdg("Cross Reference",dt,out,op), wz=wy, fmt(,hy,tr))
                                                              ;^ Do XRef list
IfNotEqual lo, 0, Loop Parse, % i2, % (n, i3=f#=pw="",x=wz=1) ;  Do Lone Words
  z:=StrSplit(y:=A_LoopField,_), (""pw=z.2) ? x++ : ((i3.=x?"":f# n)
  , pw:=z.2, f#:=y, x:=0, w:=StrLen(pw), wz:=wz>w?wz:w)
(lo) ? (hdg("Lone Words",dt,out,op), fmt(,hy,tr,3)) : 0

if (fm&&(1,hdg((fa?"Full ":"") "Function Map",dt,out,op), f#=i3=pw="")) ;Fn map?
{ SB_SetText("Creating Function Map...")                   ; with? keep all
  Loop Parse,% RTrim(i2,n),% (n, y="{3}/{1}/{6}/{4}/{}"n,arf={F:"R",R:"F"},wz=0)
    w:=StrSplit(A_LoopField,_), x=StrLen(w.1), i3.=fa||w.6!=" "?Format(y
    , arf[w.6=" "?"R":w.6],w*):"", (w.6="F")?(im[w.3,0]:=2, wz:=wz>x?wz:x):0
;    1  2   3    4    5        1    2      3   4    5   6   7 or 4   5   6    7
; > wrd/fn/itm#/md#/ln#mda >v md#/ln#mda/fn=R/itm#/wrd/md#/ref, md#/ref/itm#/wrd
  Loop Parse,% RTrim(Sort(i3,1,"R"),n),% (n, i2="")        ;v New word?
    w:=StrSplit(A_LoopField,_), w.2:=arf[w.2], f#:=""pw=w.1?f#:"", pw:=w.1
  , z:=!f#&&w.2="F"?1:F#?2:0, f#:=z=1?w.4 _ w.5:f#, i2.=z?Format(af[z],f#,W*):""
  for k, v in im, z:="{:" mnz "}/{:" nz-maz "}{:-" maz "}/F////{}" n
    (v.0=2&&k)?(i2.=Format(z,k,"","","") Format(z,k,"",mna(k),v.1)
    , x=StrLen(v.1)-nz, wz:=wz>x?wz:x):0                   ;^ Add #Include names
  Sort(i2), fmt(1,hy,tr)                                   ; Sort, print Fn Map
}

fo:=rr(fi,"\.[^.]+$") lh ".xref",io("Delete",fo),io("Append",fo,out) ; XRef file
Run notepad.exe %fo%                                       ; Display XRef file
sw("*" rr(fo,"^.+\\")), (pr)?sw("&|*Print|?E|*Notepad|*",,1,8):0 ; Print?
(pr<0)?sw("?X"):0, (dr)?io("Delete",fo):0  ; Exit Notepad? ; Delete XRef file?
IfNotEqual pr, -1, SetTimer swap, 50                       ; Notepad to front
goto % (fc-fx&&fc=%false%?"GuiClose":"rpt")                ; Finish or repeat

; =========================  Miscellaneous routines  ===========================
BtnMono()                                    ; <========== ; Notepad to defaults
{ Loop Reg, HKCU\Software\Microsoft\Notepad
  { if SubStr(A_LoopRegName,1,7)="iMargin"||SubStr(A_LoopRegName,1,2)="lf"
      RegDelete                                            ; Erase margins, font
    IfEqual A_LoopRegName,lfFaceName,RegWrite Lucida Console ; Set default font
    IfEqual A_LoopRegName,iPointSize,RegWrite 100          ; Set default size
  } SB_SetText("Notepad set to mono-spaced font")
}

lno:                                         ; <========== ; Get line numbers
gui +OwnDialogs                                            ; Must action first
IfEqual g,0, InputBox lb,,Enter start`, end line numbers`, spaced apart,,200,160
IfEqual g,0, IfNotEqual ErrorLevel, 0, SetEnv lb,          ; Cancel?
IfEqual lb,, GuiControl,, lg,0                             ; If nothing entered,
IfEqual lb,, return                                        ;    reset checkbox
le:=g?0:rr(lb,L1), lb=g?0:rr(lb,L2), lh=g?"":" ("lb "-"le ")", ldd(g:=!g)
GuiControl,,% " &'Upd",% " " udd[ud] (g?sd:"")             ; Adjust 'Update'
return 
                                             ; <========== ; Process 'check3's
ck3(a=0,b=0,c=0,d=0,e="lo;fm;tr;ip;pr;vg;ud",f="ip|vg")
{ local z:=a?A_GuiControl:b, y:=z~=f&&ex!="a",x=a?mkg(,["su",["NoHide",0]]):0
  IfInString e,%z%, GuiControl Text,% z,% " " %z%d[y?0:%z%] (g&&z="ud"?sd:"")
} ;^^ If called directly by code, b=gui v-name & a, c, d, e, f must default 

hdg(h,t,ByRef o, i="", q:="""")              ; <========== ; Do heading
{ local L:=StrLen(h t fn lh)+9, x,y=StrReplace(o,n,,x), z=pz?pz-Mod(x,pz):o?2:0
  o.=dp(z=pz?0:z,n) dp(lz,,h " for " q fn q lh ", " t) n dp(lz,,dp(L,"=",i))n
} ;^^ h=heading, t=date&time, o=output to, i=insert into '=', q=internal only 

rr(ByRef h, n, r="", ByRef c="", l=-1, s=1)  ; <========== ; Shorten
{ return RegExReplace(h, n, r, c, l, s)                    ;   RegExReplace
}

dp(n, s:=" ", i:="")                         ; <========== ; Dups [s], [n] times
{ local c:=StrLen(i), a=(n-c)//2, b=(c-n)//2, o:=i=""?"":dp(a,s) i dp(n-a-c,s)
  IfEqual i,, Loop, % n                                    ;^ Centre [i] in line
    o.=s
  return (n<c)?SubStr(i,b+1,n):o                           ; Trim [i] if needed
}

mkg(n="", a="")                              ; <========== ; Make Gui
{ local k,v,p,q,t1={a:"dd",d:"estroy",f:"ont",m:"enu",s:"how",su:"bmit"},z="box"
,t2={b:"utton",c:"heck"z,co:"mbo"z,e:"dit",g:"roup"z,l:"ist"z,r:"adio",t:"ext"}
  for k, v in a ; 'a' format=["p1",["p2",["p3,p4",…],"p2",["p3,p4",…]],"p1",[…]]
    IfEqual   false, % IsObject(v)||v=0, SetEnv p,% t1[v]?v t1[v]:v, q=""
    else   for k, v in IsObject(v)? v:  [[""]] ;^^ Can shorten above p1 p2 words
      IfEqual false, % IsObject(v)||v=0, SetEnv q,% t2[v]?v t2[v]:v ;^^ [] vital
      else for k, v in IsObject(v)? v:   [""]  ; If no p3,append value of 0 e.g.
  {   ; MsgBox Gui %n%%p%`,%q%`,%v%            ;    […,"p1",0,…,"p1",["p2",0],…]
    Gui %n%%p%,% (q,k:=InStr(v,",")),% k?SubStr(v,1,k-1):v,% k?SubStr(v,k+1):""
} } ;^^ n=Gui name with :, a=simple array of nested Gui p1, p2 & p3,p4 params

findinc(f,p)                                 ; <========== ; Find included file
{ local z:=A_WorkingDir, e:="", x:=VarSetCapacity(e,520)
  if !FileExist(f)
  { SetWorkingDir % p
    IfExist %f%, DllCall("GetFullPathName",str,f,uint,260,str,e,ptr,0,uint)
    SetWorkingDir % z
  } else         DllCall("GetFullPathName",str,f,uint,260,str,e,ptr,0,uint)
  return e
} ;^^ f=file name, p=alternate path, returns full name or "" if not found

rf(fi,mf,lb=0,le=0,ef="F",ar="R",sp=" ",ai=0) ; <========= ; Read file
{ local c1, cr, fr, k, L, Ln, ln#=0, ma:=mna(mf), q="""", x, y, y1, y2, y3, z
  , z1, z2, z3, olf=A_.LineFile, wd2:=rr(fi,ph)
  A_.LineFile:=fi   ;^^ fi=source file name, mf=module #, lb/e=line begin/end,
  Loop Read, %fi%   ;^^ ef/ar/sp=function def/ref/etc codes, ai=1=auto-includes
  { If (ex="c")                                            ; C, JS?
    { L:="", z:=A_LoopReadLine, x=1, c1:=z~="^[^\s#]"      ; 1st not whitespce,#
      IfEqual true,% !(z~="/\*|\*/|//")&&cm!=2, SetEnv L,%z% ; No comments? skip
      else while x<=StrLen(z)                              ; Strip C JS comments
      { y:=SubStr(z,x,2), (cm=2&&y="*/")?(cm:=0, L.=" ", x++)
                        : (cm=0&&y="/*")?(cm:=2, L.=" ", x++):0
        IfEqual cm, 0, IfEqual y, //, break
        (cm=2)?x++:L.=SubStr(z,x++,1)
    } } else { L:=A_LoopReadLine                          ;v Keep AHK directives
      (ex="a")?L:=rr(L,"i)^\s*(\Q" ac "\E|/\*)(@Ahk2Exe-.*$)","$2"):0
ln:=cm=1?"":SubStr(LTrim(L),1,2), cm:=ex="a"&&ln="/*"?2:cm  ;<v AHK/DOS comment
IfEqual true,% ex="d"&&ln="::"||ex="a"&&cm=2&&L~="\*/"&&!(cm:=0)||cm=2, continue
      (cm)?(ex="a")?(L:=rr(L,"(^|\s+)(\Q" ac "\E.*)$"," " DL " $2")):0
      :    (L:=rr(L,ex="d"?"i)(^|\(|&)\s*rem(\s.*|)$":"(^|\s+)\Q" ac "\E.*$"))
    }                 ;^^ Chr(127) (DL) can be used as special AHK comment flag
    (ex="a"&&RegExMatch(L,"i)^\s*#CommentFlag\s*,?\s*(\S+)",z))?ac:=z1:0
    (ex="a"&&RegExMatch(L, "i)^\s*#EscapeChar\s*,?\s*(\S+)",z))?ae:=z1:0
    IfEqual true,% (ln#:=A_Index)<lb, continue             ; Skip lines < subset
    IfEqual true,%  ln#>le&&le,       break                ; Skip lines > subset

                                             ; <========== ; Process #Include
    if(ip&&ex="a"&&!(y3:="")&&RegExMatch(L   ; z1='again'/copy z3, z3=file name,
    ,"i)^\s*#Include(Again)?\s*,?\s*(\*i\s)?[""']?(.*?)[""']?\s*(\s"DL "|$)",z))
    { if ((z1:=z3)&&RegExMatch(z3,"^(<)(.+)(>)$",y)) ;Lib #Incl,y2=lib name,y3=>
      { y:=[A_WorkingDir,A_MyDocuments "\AutoHotkey",rr(xe,ph)] ;^^ z2='*i'
        for k, x in [y2,InStr(y2,"_")?SubStr(y2,1,InStr(y2,"_")-1):""]
          for k, y1 in y                     ; y2=lib name ;^ Handle "_" in name
            IfEqual true,% FileExist(z:=y1 "\lib\" x "." ext)&&(z1:=z), break 2
      } else { z1:=unref(z3)                               ; !Lib; deref name
        if InStr(FileExist(z1),"D")&&(wd2:=z1)             ; Folder?
          SetWorkingDir %z1%
      }                                                    ;v Setup info to keep
      if !InStr(FileExist(z1),"D")&&(x:=ai?_ _ _ _:_ mf _ ln# _ ma _ z3)
      { if (z3:=rr(z1,"^.+\\"))&&!(z:=findinc(z1,wd2))
          id[(z2?"Optional":"Error")": cannot find """z1 (z2?"""":"""!"),0]:=0 x
        else if (!id[q z q]&&(id[q z q,0]:=mn x))&&(im[mn,1]:=q z3 q) ;Once only
          y:=y3=">"&&ip=1, rf(z,mn++,,,y?"U":ef,y?"Q":ar,y?"Z":sp,ai)
        else id[q z q].Push(mn x)                          ; Duplicate #Include
    } }
                                             ; <========== ; Line to words
    IfEqual mf,, continue                                  ; Skip auto-include
    L:=rr(rr(L,":="," "),":",ex="d"?" :":ex="a"?": ":" ")  ; DOS/AHK label
  L:=rr(rr(ex="c"?rr(L,"\s+\(","("):L,"(\()","$1 "),"((" ae ".)|{|\)|,)"," $1 ")
    L:=Trim(rr(L,"[^\w#@$" co "``]+"," ")), cr=0           ; Specials=>space
    Loop Parse, L, %A_Space%              ; ^^ c?[ (=>(] [(=>$1 ] [`?{),=> $1 ]
    { z:=A_LoopField,y:=SubStr(z,1,1),cr:=ex!="a"||cr?cr:y=DL
      (ex="a"&&A_Index=1&&z<>","&&z<>"{")?f#:=0:0          ; AHK not fn def
      fr:=ex="d"?y=":"?A_Index=1?ef:lw~="i)^(call|goto)$"?ar:sp:sp ;DOS fn/ref
        :ex="c"? SubStr(z,0)="("?c1&&!cr++&&!(nf[z]&2)?ef:ar:sp ; C fn/ref
        :ex="a"&&SubStr(z,0)="("&&!(nf[z]&1)?ar:sp         ; AHK fn/ref
      (ex="a"&&SubStr(z,0)="("&&A_Index>1)?f#:=0:0         ; AHK not fn def
      (ex="a"&&z="{"&&lw=")"&&f#&&i2)?i2:=SubStr(i2,1,f#) ef SubStr(i2,f#+2):0
    (ex="a")?(SubStr(z,0)=":"&&A_Index=1?fr:=ef:lw~="i)^go(sub|to)$"?fr:=ar:0):0
      lw:=cr?lw:z, x:=rr(z,"(^[{:]+)|([({" DL ":,)]+$)")   ;v Lib partial links
      IfEqual true,% fr="Z"||Trim(x)=""||sk&&StrLen(x)>sk,continue 
                                                      ;v 1   2   3   4    5    6
      i2.=x _ mf _ ln# _ ma _ . ++ic _ fr n           ; Wrd/md#/line/mda/itm#/fn
(ex="a"&&A_Index=1&&!(nf[z]&1)&&z~="\($"&&!(z~="^__"))?f#:=StrLen(i2)-2:0 ;AHfn?
      IfEqual ex, d, IfEqual A_Index, 1, IfEqual y, :, IfNotEqual cm, 1, break
  } }                                                      ;^ DOS label comment
  nz:=nz>StrLen(ln#)?nz:StrLen(ln#), A_.LineFile:=olf      ; Max line # size
}                                                          ;^ Reset A_LineFile

fmt(f=0,hy=0,tr=0,i=2)                      ; <==========  ; Format 1-20/up rpts
{ global ;^ f=function map?, hy=hyphenation?, tr=tighten report?, i=item list #
  for k in q:=[{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}] ; 20
  { ez:=lz//k, q[k].ez:=ez:=ez-Mod(ez,nz)                  ; Entry size
    q[k].ps:=ps:=k>1&&!Mod(lz//k,nz)?" ":"", pw="", x=0    ; Lead space, etc
    q[k].sz:=z:=!hy&&k>1&&wz+!!ps+f*2*nz>ez||k>1&&!pz||ez<(3+f-(tr<0))*nz?b2:0
    IfNotEqual z, 0, continue ;^ Fit w/no hyph?, >1/up&page size, entry size ok?
    Loop Parse, % RTrim(i%i%,n), %n%                       ; Read all references
      w:=StrSplit(A_LoopField,_), z:=w.3="R"     ; w.2=word, w.3=fn, w.4=ln# mda
      , (f)?(w.2.=" " w[z?5:7], w.4:=w[z?7:5]):(w.3:=" ", w.2:=tr?"*" w.2:w.2)
      , w.2:=w.3="R"?s w.2:w.2, (""pw!=w.2)?(y:=StrLen(ps w.2) ; New word?
        , u=x, v=y>ez?hyph(w.2,f?s "  " (w.3="R"?s:""):" "):ps w.2
        , y=StrLen(v), z=Mod(y,nz), z=z?nz-z:0, ((pw!="")?q[k].t[u] ;Pad out old
        .=dp((ez-p)//nz*nz):0), p:=y+z, q[k].t[u:=++x]:=v dp(z), pw=w.2):0
      , (w.3!="F")?((p+nz>ez)?(q[k].t[u:=++x]:=w.3="L"||w.3="R"?s s:tr?"":s
      , p:=nz+(w.3="L"||w.3="R"?nz:tr?-nz:0)):0, q[k].t[x].=w.4, p+=nz) ;Line #s
(i%i%)?(q[k].t[u].=dp((ez-p)//nz*nz), q[k].sz:=u//k+!!Mod(u,k)):0 ; Pad, list sz
  } ;^^ sizes (ez=entry, nz=#+1, wz=max word, pz=page, sz=list), ps=""/" "
  q[k+1,"sz"]:=b2, nup()                      ; Set last+1 high & do n/up report
}

hyph(wd,pd)                                  ; <========== ; Hyphenate
{ local w:=ps wd, p:="", z                                 ; wd=word to split
  while StrLen(p w)>ez                                     ; pd=leading pad ch
z:=StrLen(p), q[k].t[++x]:=p SubStr(w,1,ez-1-z) "-", w:=ps SubStr(w,ez-z), p=pd
  return p w
}

nup()                                        ; <========== ; Output n/up report
{ local b, ez, j, k:=q.Length(), pg:=2, pw:=pz?pz-2:b2, ps, tz, x:=0, z
  for j in q                                               ; Pick smallest list
    (q[j].sz<q[k].sz)?(k:=j, ps:=!!q[k].ps+1, ez:=q[k].ez):0 ;v # of entries
  q[k].t.Push(dp(ez,,q[k].ps "*** List end ***")), tz:=q[k].t.Length()
  out.=b:=dp((lz-((ez+2-ps)*k-1))//2)                      ; Centre list
  while q[k].t[x+1]                                        ; v Next page size
  { (x)?(x+=pw*(k-1), pw:=pz-1):0, z=tz-x, z=z//k+!!Mod(z,k), pw=z<pw?z:pw
    out.=x&&q[k].t[x+1]?"`n" b dp((ez+2-ps)*k-1,"-"," Page " pg++ " top "):""
    Loop % pw                                              ; Format a page
    { (q[k].t[x++])?out.="`n" b:0                          ; Line gets n/l
      Loop % k                          ; v (k)/up, drop any lead space, divider
        z:=A_Index, y=SubStr(q[k].t[x+(z-1)*pw],ps), out.=y ((z=k||!y)?"":"|")
} } } ;^^ sizes (ez=entry, pz=page, sz=list), ps=1/2(""/" "), pw=lines/page

mna(n,u=1,v=53,s="",w=26,x=70,y=64,z=0)      ; <========== ; Module # to alpha
{ return (n-=u)<0?s:(n//(z:=v-u)?mna(n//z,0):s) Chr((z:=Mod(n,z))+u+(z>w-u?x:y))
} ;^^ n=# to convert. Rest internal only. (u=units?). Returns ""/@, A-Z, a-z

unref(str)                                   ; <========== ; Deref string
{ local bits:=StrSplit(str,"%"), n:=2, y, z, out:=bits.1   ; 1st bit always data
  while n<bits.Length()                                    ; Do all bits
  { if(SubStr(bits[n],1,2)="A_"&&z:=A_[y:=SubStr(bits[n],3)]) ; In 'A_' table?
      y:="A_" y, out.=(z=2?%y%:z) bits[++n], ++n           ; Value=2=deref
    else out.="%" bits[n++]                                ;   else use value
  } return out (n=bits.Length()?"%" bits[n]:"")            ;^ Just data 
}

io(typ, fil, ByRef str="",fl="", ky="")      ; <========== ; Output routine with
{ Loop                                                     ;    error handling
  { ErrorLevel:=0
    IfEqual typ, Delete, IfExist %fil%, FileDelete %fil%
    IfEqual typ, Append,  FileAppend %str%, %fil%, UTF-8
    IfEqual typ, IniWrite,  IniWrite %fl%,  %fil%, %str%, %ky%
    IfEqual typ,IniDelete,IfEqual    ky,, IniDelete   %fil%, %str%
    IfEqual typ,IniDelete,IfNotEqual ky,, IniDelete   %fil%, %str%, %ky%
    IfEqual ErrorLevel, 0, return
    MsgBox 21,, Error %ErrorLevel% on File %typ% of '%fil%'!
    IfMsgBox Cancel, Exit
} }

Sort(ByRef var, ret=0, rev="", opt="CL")     ; <========== ; Sort
{ Sort var, %rev% %opt%                                    ; rev=R=reverse
  IfEqual ret,1, return var                                ; ret=1=return data
}

sw(l,t:="",g="",h="",i="",j="",k="",a="&")   ; <========== ; Send & wait
{ local b:=d:="",x,y,z,m:=g?g a:b, n:=h?h a:b, o:=i?i a:b, p:=j?j a:b,q:=k?k a:b
  loop Parse,% rr(l,"\?X(\d*)","!{F4 $1}"),| ;^ l=| delim list, (g-k=[sub]menus)
  { y:=SubStr(x:=A_LoopField,1,1),z=SubStr(x,2),d:=x="*"&&y!="*"?z:d ;t=WWC secs
         IfEqual x, , Sleep 100                            ; Empty item = Sleep
    else IfEqual x,*, WinWaitClose %d%,,%t%                ; *  = WinWaitClose 
    else IfEqual y,*, WinWaitActive %z%,,4                 ; *+ = WinWait <4secs
    else IfEqual x,&, WinMenuSelectItem A,,%m%,%n%,%o%,%p%,%q% ; & = [sub]menus
    else Send % rr(rr(x,"\?T(\d*)","{tab $1}"),"\?E(\d*)","{enter $1}") ;Send it
} }   ;^ In sent items, ?E[n]=>{enter [n]}, ?T[n]=>{tab [n]}, ?X[n]=>!{F4 [n]}

ldd(t=0, g=1)                                ; <========== ; Load .ini defaults
{ local k, v, k1, v1, x, d=" Defaults", s=sc, y, z        ; t=1=Subset (=do all)
  for k1,v1 in x:=t?[df, fn, df sd, fn sd]:[df, fn], y=[d,s d,d sd,s d sd],hd=""
    for k,v in vd:=StrSplit("fm/fa/cm/hy/tr/ip/bi/pr/dr/lo/vg/sk/lz/pz",_) 
    { IfEqual k,1, IniRead z,%ini%,%v1%,%v%,9 ; ^ 'lz/pz' must be last, 'fm' 1st
      IniRead %v%, %ini%, %v1%, %v%, % (k1=1?v="lz"?80:0:%v%,hd:=z=9?hd:y[k1])
      IfEqual k1,% x.Count(), GuiControl,,%v%,% (%v%,ck3(,v)) ; Set gui item
    } hd:=hd?" -" hd:hd, (g)?mkg(,["s",[[fn hd " - " scr vn]]]):0 ; g=show gui
} ;(sc=" script",sd=" (subset)",df="<defaults>",fn=script name) hd=glbl ini type

BtnUpd:                                      ; <========== ; Update defaults
IniRead y, %ini%, %df%, ver,% 0, z:=vd.Length()-1 ; (adj z for # setup items -1)
if (y != (ver:=4))                                         ; Check .ini version
{ IniRead x, %ini%                                         ; Get all sections
  Loop Parse, x, `n, `r                                    ; Get list scripts
  { for k,v in vd
    { IniRead w, %ini%, %A_LoopField%, %v%, 9              ; if no key write 0
      (w=9&&k<z) ? io("IniWrite", ini, A_LoopField, 0, v) : 0
    }                                                      ;v'en'&'ft' redundant
    io("IniDelete",ini,A_LoopField,,"en"), io("IniDelete",ini,A_LoopField,,"ft")
  } io("IniWrite", ini, df, ver, "ver")                    ; Set latest version
}
for k, v in vd, mkg(,["su",["NoHide",0]])                  ; Save/erase options
{ (ud=0||ud=1&&k<z) ? io("IniWrite", ini, (ud?fn:df) (g?sd:""), %v%, v) : 0
  IfEqual ud,-1, IfNotInString hd, %sc%, MsgBox 8240,, No script entry to erase!
  IfEqual ud,-1, IfNotInString hd, %sc%, return
} (ud=-1) ? io("IniDelete", ini, fn (g?sd:"")) : 0, ldd(g) ; Del keys, new dflts
SB_SetText(rr(rr(SubStr(udd[ud],11),"es","ed"),"(^.)","$U1") (g?sd:""))
return

swap:                                        ; <========== ; Notepad to front
IfWinActive XRef -,,,, SetTimer,,Off                       ; If next file prompt
IfWinActive XRef -,,,, WinActivate % rr(fo,"^.+\\")        ;    Show Notepad
return

GuiEscape:                                   ; <========== ; User pressed escape
GuiClose:                                                  ; Pressed X or alt+F4
ExitApp

; ===========================  Compile Settings  ===============================
;@Ahk2Exe-Let ScriptName =     %A_ScriptName~\.[^\.]+$%    ; Drop extension
;@Ahk2Exe-SetName              %U_ScriptName~_.*$%         ; Drop any '_Compile'
;@Ahk2Exe-SetDescription       XRef: makes Cross Reference lists from scripts
;@Ahk2Exe-SetCopyright         TAC109      ; (SetVersion is near start)
;@Ahk2Exe-SetLanguage          0x1409
;@Ahk2Exe-SetMainIcon          %U_ScriptName~_.*$%.ico     ; Drop any '_Compile'







; ===============================  Debugging  ==================================
#F2::sol(gol("q"))                                         ; Win+F2
#F3::sol(gol(["id","im"]))                                 ; Win+F3

sol(ByRef mes="")                            ; <========== ; Show object list
{ GuiControl dbg1:,Edit1,% mes, mkg("dbg1:",["f",["s9",["Lucida Console"]]
  ,"a",["e",["r55 w900 HScroll ReadOnly"]], "+LastFound",0, "s",0])
  WinWaitClose                                             ;^ Make Gui, big mes
dbg1GuiEscape:
dbg1GuiClose:
  return 0, mkg("dbg1:",["d",0])                           ; Make_Gui 'Destroy'
}

gol(n="", i="  ", a="", t="")                ; <========== ; Get object list
{ local c:=0, k, o=a?a:IsObject(n)?0:%n%, s=IsObject(n)?"":n " {`n", v
  IfEqual true, % IsObject(n), for k, v in n ; If lone array name for analysis =
    s.=gol(v,i,,t) "`n`n", c=A_Index         ;  internal name, add as 'a' param.
  else { IfEqual false, % IsObject(o), return "'" n "' is not an object!"
    for k,v in o
      (IsObject(v))?v:=IsFunc(v.name)?"Function":gol(,i,v,i t):0 ; Handle object
      , s.=i t k " :" v ",`n", c++                         ; Key :value, +count
    (IsObject(o.base))?(s.=i t "base:" gol(,i,o.base,i t) ",`n", c++):0
  }	return s (IsObject(n)?"(":t "} (") c ")"
} ;^^ n=quoted object name or an array of same, i=indent chrs; a,t=internal only
; ==============================  End of file  =================================