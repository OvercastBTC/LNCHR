;============================== Start Auto-Execution Section ==============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
; #Warn  ; Enable warnings to assist with detecting common errors.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1 ; Determines how fast a script will run (affects CPU utilization). ; The value -1 means the script will run at it's max speed possible.
SetWinDelay, -1
SetControlDelay, -1
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"

CSend(String,ID)
{
	SC_Table := Object()
	SC_Table := {1:"61",2:"62",3:"63",4:"64",5:"65",6:"66",7:"67",8:"68",9:"69",10:"6A",11:"6B",12:"6C",13:"6D",14:"6E",15:"6F",16:"70",17:"71",18:"72",19:"73",20:"74",21:"75",22:"76",23:"77",24:"78",25:"79",26:"7A",27:"41",28:"42",29:"43",30:"44",31:"45",32:"46",33:"47",34:"48",35:"49",36:"4A",37:"4B",38:"4C",39:"4D",40:"4E",41:"4F",42:"50",43:"51",44:"52",45:"53",46:"54",47:"55",48:"56",49:"57",50:"58",51:"59",52:"5A",53:"30",54:"31",55:"32",56:"33",57:"34",58:"35",59:"36",60:"37",61:"38",62:"39",63:"21",64:"40",65:"23",66:"24",67:"25",68:"26",69:"5F",70:"2B",71:"2D",72:"3D",73:"2C",74:"27",75:"20",76:"3B",77:"28",78:"29",79:"",80:"",81:"",82:"",83:"",84:"",85:"",86:"",87:"",88:"",89:"",90:"",91:"",92:"",93:"",94:"",95:"",96:"",97:"",98:"",99:"",100:""}
	ID_Table := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&_+-=,' ()"
	Loop % StrLen(String)
	{
		Part := SubStr(String,A_Index,1)
		Pos := InStr(ID_Table,Part,1,1,1)
		SC := SC_Table[Pos]
		ControlSend,,{u+%SC%},AHK_ID %ID%
}}
;============================== End Script ==============================