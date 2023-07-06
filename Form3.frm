VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form3 
   Caption         =   "Enumerate Menus"
   ClientHeight    =   4275
   ClientLeft      =   2550
   ClientTop       =   2370
   ClientWidth     =   4935
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   4275
   ScaleWidth      =   4935
   Begin MSComctlLib.TreeView TreeView1 
      Height          =   3375
      Left            =   15
      TabIndex        =   0
      Top             =   75
      Width           =   4890
      _ExtentX        =   8625
      _ExtentY        =   5953
      _Version        =   393217
      LineStyle       =   1
      Style           =   7
      Appearance      =   1
   End
   Begin VB.Frame Frame1 
      Height          =   735
      Left            =   30
      TabIndex        =   1
      Top             =   3480
      Width           =   4860
      Begin VB.CommandButton Command2 
         Caption         =   "&Expand All"
         Height          =   375
         Left            =   2430
         TabIndex        =   4
         Top             =   225
         Width           =   1065
      End
      Begin VB.CommandButton Command1 
         Caption         =   "&Close"
         Height          =   375
         Left            =   3630
         TabIndex        =   3
         Top             =   225
         Width           =   1065
      End
      Begin VB.CheckBox Check1 
         Caption         =   "&Bring Window to Top"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         ToolTipText     =   "When Menu action takes place, the relative window will be given focus, otherwise not"
         Top             =   290
         Value           =   1  'Checked
         Width           =   1815
      End
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Command1_Click()
 Unload Me
End Sub
Private Sub Command2_Click()
 Dim i As Integer
    
 For i = 1 To TreeView1.Nodes.Count
   TreeView1.Nodes(i).Expanded = True
 Next i
End Sub
Private Sub TreeView1_DblClick()
 On Error GoTo hwndE
    
 Dim id As Long, l As Long
    
 If Check1.Value = vbChecked Then
   BringWindowToTop MyHandle
 End If
    
 id = CLng(Right(TreeView1.SelectedItem.Key, Len(TreeView1.SelectedItem.Key) - 1)) - 15000
    
 l = PostMessage(MyHandle, WM_COMMAND, id, 0&)

 Exit Sub
hwndE:
 MsgBox "Error: Form3.TreeView1_DblClick"
End Sub
