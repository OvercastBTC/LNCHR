Try{
	oExcel := ComObjActive("Excel.Application") ; Create a connection to an Excel Application object
}
Catch{
	oExcel := ComObjCreate("Excel.Application") ; Create an Excel Application object
	oExcel.Visible := true
}

oWorkSheet := oExcel.ActiveSheet
Attribute VB_Name := "API_Powered_Module"
Option Explicit

Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Public Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Public Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Public Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Public Declare Function EnumChildWindows Lib "user32" (ByVal hwndParent As Long, ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Public Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Public Declare Function BringWindowToTop Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function CascadeWindows Lib "user32" (ByVal hwndParent As Long, ByVal wHow As Long, lpRect As RECT, ByVal cKids As Long, lpkids As Long) As Integer

Public Declare Function GetMenu Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function GetMenuItemCount Lib "user32" (ByVal hMenu As Long) As Long
Public Declare Function GetMenuItemID Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Public Declare Function GetMenuItemInfo Lib "user32" Alias "GetMenuItemInfoA" (ByVal hMenu As Long, ByVal un As Long, ByVal b As Long, lpMenuItemInfo As MENUITEMINFO) As Long
Public Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

Public Type MENUITEMINFO
  cbSize As Long
  fMask As Long
  fType As Long
  fState As Long
  wID As Long
  hSubMenu As Long
  hbmpChecked As Long
  hbmpUnchecked As Long
  dwItemData As Long
  dwTypeData As String ;* 255
  cch As Long
End Type

Public Type RECT
  Left As Long
  Top As Long
  Right As Long
  Bottom As Long
End Type

Public Const WM_COMMAND := &H111
Public Const MIIM_TYPE := &H10
Public Const MFT_STRING := &H0&

Public Const WM_SETFOCUS := &H7
Public Const WM_CLOSE := &H10                    ;Closing window
Public Const SW_SHOW := 5                        ;showing window
Public Const WM_SETTEXT := &HC                   ;Setting text of child window
Public Const WM_GETTEXT := &HD                   ;Getting text of child window
Public Const WM_GETTEXTLENGTH := &HE
Public Const EM_GETPASSWORDCHAR := &HD2          ;Checking if its a password field or not
Public Const BM_CLICK := &HF5                    ;Clicking a button
Public Const SW_MAXIMIZE := 3
Public Const SW_MINIMIZE := 6
Public Const SW_HIDE := 0
Public Const SW_RESTORE := 9
Public Const WM_MDICASCADE := &H227              ;Cascading windows
Public Const MDITILE_HORIZONTAL := &H1
Public Const MDITILE_SKIPDISABLED := &H2
Public Const WM_MDITILE := &H226

Public VCount As Integer, ICount As Integer
Public MyHandle As Long
Public Function WndEnumProc(ByVal hwnd As Long, ByVal lParam As ListView) As Long
 ; Dim WText As String * 512
 ; Dim bRet As Long, WLen As Long
 ; Dim WClass As String * 50
        
 WLen := GetWindowTextLength(hwnd)
 bRet := GetWindowText(hwnd, WText, WLen + 1)
 GetClassName hwnd, WClass, 50

 If((Form1.Check1.Value = vbUnchecked)){
 Insert hwnd, lParam, WText, WClass
}
 Else If((Form1.Check1.Value := vbChecked And WLen <> 0)){
 Insert hwnd, lParam, WText, WClass
 }
    
 WndEnumProc := 1
End Function
Private Sub Insert(iHwnd As Long, lParam As ListView, iText As String, iClass As String)
 lParam.ListItems.Add.Text := Str(iHwnd)
 lParam.ListItems.Item(VCount).SubItems(1) := iClass
 lParam.ListItems.Item(VCount).SubItems(2) := iText
 VCount := VCount + 1
return
}
Public Function WndEnumChildProc(ByVal hwnd As Long, ByVal lParam As ListView) As Long
 ; Dim bRet As Long
 ; Dim myStr As String * 50

 bRet := GetClassName(hwnd, myStr, 50)
 ;if you want the text for only Edit class then use the if statement:
 ;If (Left(myStr, 4) := "Edit") Then
 ;lParam.Sorted := False

 oWith2 := lParam.ListItems
 oWith2.Add.Text := Str(hwnd)
 oWith2.Item(ICount).SubItems(1) := myStr
 oWith2.Item(ICount).SubItems(2) := GetText(hwnd)
 
 If(SendMessage(hwnd, EM_GETPASSWORDCHAR, 0, 0) = 0){
 oWith2.Item(ICount).SubItems(3) := "No"
 }
 Else{
 oWith2.Item(ICount).SubItems(3) := "Yes"
 }
    
 ICount := ICount + 1

 ;lParam.Sorted := True
 ;End If
 WndEnumChildProc := 1
End Function
Function GetText(iHwnd As Long) As String
 ; Dim Textlen As Long
 ; Dim Text As String

 Textlen := SendMessage(iHwnd, WM_GETTEXTLENGTH, 0, 0)
    
 If(Textlen = 0){
   GetText := ">No text for this class<"
   Exit Function
 }
    
 Textlen := Textlen + 1
 Text := Space(Textlen)
    
 ;
 ; The ;ByVal' keyword is necessary or you'll get an invalid page fault
 ; and the app crashes, and takes VB with it.
 ;
 Textlen := SendMessage(iHwnd, WM_GETTEXT, Textlen, ByVal Text)
 
 GetText := Left(Text, Textlen)
End Function
Public Sub SMenu(Mhwnd As Long, Tree As TreeView, Optional tmpKey As String, Optional iSubFlag As Boolean)
 ;
 ; This is a recursive function ;cuz ya know any menus can have ne number of sub menus
 ; and the sub menus can have more sub menus in them, so all of them can be captured
 ; with recursion
 ;
 Static iKey As Integer
 ; Dim n As Long, c As Long, i As Long
 ; Dim iNode As Node
 ; Dim menusX As MENUITEMINFO
 ; Dim temp As String

 On Error Resume Next
    
 n := GetMenuItemCount(Mhwnd)
    
 For i := 0 To n - 1
   c := GetMenuItemID(Mhwnd, i)
        
   ;----Here we get the text of the menu if any-----
   menusX.cbSize := Len(menusX)
   menusX.fMask := MIIM_TYPE
   menusX.fType := MFT_STRING
   menusX.dwTypeData := Space(255)
   menusX.cch := 255
   GetMenuItemInfo Mhwnd, i, True, menusX
   menusX.dwTypeData := Trim(menusX.dwTypeData)
   ;------------------------------------------------
        
   ;this'll make the key unique <hopefully>:
   If((menusX.dwTypeData = "" Or c = -1)){
     c := iKey
     iKey := iKey + 1
   }
   Else{
     c := c + 15000
   }
        
   If(iSubFlag = False){
     If(tmpKey <> ""){
       iNode := Tree.Nodes.Add(tmpKey, tvwNext, , menusX.dwTypeData)
     }
     Else{
       iNode := Tree.Nodes.Add(, tvwLast, , menusX.dwTypeData)
     }
            
     If(GetSubMenu(Mhwnd, i) > 1){
       iSubFlag := True
       iNode.Key := "k" CStr(c)
       tmpKey := iNode.Key
       SMenu GetSubMenu(Mhwnd, i), Tree, tmpKey, True
       iSubFlag := False
     }
   }
   Else{
     iNode := Tree.Nodes.Add(tmpKey, tvwChild, "k" CStr(c), menusX.dwTypeData)
            
     If(GetSubMenu(Mhwnd, i) > 1){
       iSubFlag := True
       iNode.Key := "k" CStr(c)
       temp := tmpKey
       tmpKey := iNode.Key
       SMenu GetSubMenu(Mhwnd, i), Tree, tmpKey, True
       tmpKey := temp
     }
   }
 Next i
return
}

