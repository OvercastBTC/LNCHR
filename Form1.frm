VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form1 
   Caption         =   "Enumerate All Windows"
   ClientHeight    =   5220
   ClientLeft      =   1650
   ClientTop       =   1920
   ClientWidth     =   10905
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   5220
   ScaleWidth      =   10905
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox Check1 
      Caption         =   "&Windows with captions"
      Height          =   195
      Left            =   1920
      TabIndex        =   6
      Top             =   4920
      Width           =   1935
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Change Text"
      Height          =   375
      Left            =   5295
      TabIndex        =   5
      ToolTipText     =   "Change text of any window :)"
      Top             =   4800
      Width           =   1350
   End
   Begin MSComctlLib.ListView ListView2 
      Height          =   4215
      Left            =   5280
      TabIndex        =   4
      ToolTipText     =   "Child windows"
      Top             =   480
      Width           =   5625
      _ExtentX        =   9922
      _ExtentY        =   7435
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      _Version        =   393217
      ForeColor       =   12582912
      BackColor       =   16777215
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   0
   End
   Begin MSComctlLib.ListView ListView1 
      Height          =   4215
      Left            =   0
      TabIndex        =   2
      ToolTipText     =   "Parent windows"
      Top             =   480
      Width           =   5250
      _ExtentX        =   9260
      _ExtentY        =   7435
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      _Version        =   393217
      ForeColor       =   12582912
      BackColor       =   16777215
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   0
   End
   Begin VB.CommandButton Command2 
      Caption         =   "E&numThem"
      Height          =   375
      Left            =   60
      TabIndex        =   0
      Top             =   4800
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Exit"
      Height          =   375
      Left            =   9660
      TabIndex        =   1
      Top             =   4800
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Left or Right click the Handles to see what happens"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   4215
   End
   Begin VB.Menu Options 
      Caption         =   "Options"
      Visible         =   0   'False
      Begin VB.Menu Show 
         Caption         =   "&Show Window using ShowWindow API"
      End
      Begin VB.Menu Show_BWTT 
         Caption         =   "Show &Window using BringWindowToTop API"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu Max 
         Caption         =   "Ma&ximize"
      End
      Begin VB.Menu Min 
         Caption         =   "Mi&nimize"
      End
      Begin VB.Menu Restore 
         Caption         =   "&Restore"
      End
      Begin VB.Menu Hide 
         Caption         =   "&Hide"
      End
      Begin VB.Menu Close 
         Caption         =   "&Close this Window"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu EnumMenus 
         Caption         =   "Enum Menus"
      End
   End
   Begin VB.Menu menu2 
      Caption         =   "menu2"
      Visible         =   0   'False
      Begin VB.Menu BnClick 
         Caption         =   "&Click"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
 (ByVal hwnd As Long, _
  ByVal lpOperation As String, _
  ByVal lpFile As String, _
  ByVal lpParameters As String, _
  ByVal lpDirectory As String, _
  ByVal nShowCmd As Long) As Long
Private Sub BnClick_Click()
 SendMessage Val(ListView2.SelectedItem), BM_CLICK, 0, 0
End Sub
Private Sub Close_Click()
 'close window code goes here:
 Dim lhwnd As Long
    
 On Error Resume Next
    
 lhwnd = Val(ListView1.SelectedItem)
 SendMessage lhwnd, WM_CLOSE, 0, 0
End Sub
Private Sub Command1_Click()
 Unload Me
End Sub
Private Sub Command2_Click()
 Command2.Caption = "&Refresh"
 
 ListView1.ListItems.Clear
 ListView2.ListItems.Clear
 ListView1.GridLines = True
 
 Dim myLong As Long
 
 VCount = 1
 
 myLong = EnumWindows(AddressOf WndEnumProc, ListView1)
End Sub
Private Sub Command3_Click()
 Form2.Show vbModal
End Sub
Private Sub Form_Load()
 ListView1.View = lvwReport
    
 With ListView1.ColumnHeaders
   .Add , , "Handle", 1000
   .Add , , "Class Name", 1500
   .Add , , "Text", 4500
 End With
    
 VCount = 1
    
 ListView2.View = lvwReport
    
 With ListView2.ColumnHeaders
   .Add , , "Handle", 1000
   .Add , , "Class Name", 1500
   .Add , , "Text", 4500
   .Add , , "IsPassword field", 1000
 End With
    
 ICount = 1
End Sub
Private Sub Form_Unload(Cancel As Integer)
 Dim i As Integer
  
 For i = Forms.Count - 1 To 1 Step -1
   Unload Forms(i)
 Next
End Sub
Private Sub Hide_Click()
 ShowWindow Val(ListView1.SelectedItem), SW_HIDE
End Sub
Private Sub Max_Click()
 ShowWindow Val(ListView1.SelectedItem), SW_MAXIMIZE
End Sub
Private Sub Min_Click()
 ShowWindow Val(ListView1.SelectedItem), SW_MINIMIZE
End Sub
Private Sub Restore_Click()
 ShowWindow Val(ListView1.SelectedItem), SW_RESTORE
End Sub
Private Sub Show_BWTT_Click()
 Dim lhwnd As Long
    
 On Error GoTo bugging
    
 lhwnd = Val(ListView1.SelectedItem)
 'ShowWindow lhwnd, SW_SHOW
 BringWindowToTop lhwnd
   
 Exit Sub
bugging:
 ' Do Nothing
End Sub
Private Sub Show_Click()
 'show window code goes here:
 Dim lhwnd As Long
 On Error Resume Next

 lhwnd = Val(ListView1.SelectedItem)
 ShowWindow lhwnd, SW_SHOW
End Sub
Private Sub EnumMenus_Click()
 Dim st As RECT
    
 Form3.Show
 MyHandle = Val(ListView1.SelectedItem)
 Form3.TreeView1.Nodes.Clear
    
 'If its a MDI type window and its child windows are maximized
 'then 'GetMenuItemInfo' crashes the 'EnumerationX'.
 'I tried to cascade the windows of other app but that doesnt
 'happen, do you know how I can do this?
 'MsgBox CascadeWindows(MyHandle, MDITILE_SKIPDISABLED, st, 0, 0)
 'SendMessage MyHandle, WM_MDICASCADE, MDITILE_SKIPDISABLED, 0
 'SendMessage MyHandle, WM_MDITILE, MDITILE_HORIZONTAL, 0
    
 SMenu GetMenu(MyHandle), Form3.TreeView1
End Sub
Private Sub ListView1_Click()
 GotoChild
End Sub
Private Sub ListView1_KeyUp(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyUp Or KeyCode = vbKeyDown Then GotoChild
                
 'So that you are able to see child windows easily by
 'scrolling through up-down arrow keys instead of
 'clicking the parent window handle every time.
End Sub
Private Sub GotoChild()
 On Error GoTo HandleErrorPlz
    
 Dim Num As Long
 Dim myLong As Long
    
 Num = Val(ListView1.SelectedItem)
 
 ListView2.ListItems.Clear
 ListView2.GridLines = True
    
 ICount = 1
    
 myLong = EnumChildWindows(Num, AddressOf WndEnumChildProc, ListView2)

HandleErrorPlz:
End Sub
Private Sub ListView1_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = vbRightButton And ListView1.ListItems.Count > 0 Then
   If GetMenu(Val(ListView1.SelectedItem)) > 0 Then
     EnumMenus.Enabled = True
   Else
     EnumMenus.Enabled = False
   End If
               
   PopupMenu Options
 End If
End Sub
Private Sub ListView2_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = vbRightButton And ListView2.ListItems.Count > 0 Then
   PopupMenu menu2
 End If
End Sub
