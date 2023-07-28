﻿#Warn All, OutputDebug
#SingleInstance Force
;ListHotkeys
;#NoTrayIcon
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
;           Common Risk Report Recommendations and Quick Parts
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------

;---------------- Weekly Valve Inspection ----------------------------------

:*:wvit::Conduct weekly, documented, fire protection valve inspections.

:*:wvirfm::Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, FM Global offers the free, online, training course Inspecting Fire Protection Valves at https://fmglobaltraining.skillport.com. Records of these inspections should be maintained on file.

:*:wvirafm::Weekly visual inspections of all fire protection control valves will help ensure that the sprinkler system will be operational in the event of a fire. To assist you with the implementation of weekly valve inspections, AFM offers the free, online, training course Inspecting Fire Protection Valves at https://affiliatedfmtraining.skillport.com. Records of these inspections should be maintained on file.


;----------------- Weekly Fire Pump Inspection ----------------------------------

:*:weeklypumpt::Conduct weekly documented fire protection pump tests via pressure drop.

:*:weeklypumpr::Automatic starting should be tested by simulating a drop in system pressure at the fire pump control panel. This is done by releasing pressure in the line leading to the controller's pressure sensor.{Enter}At each test, checks should be made of the operation of the priming devices, the temperature and tightness of the glands, the readings of the suction and discharge gauges, and the condition of the suction supply. Check actual start and stop pressures against pressure switch settings every time the fire pump unit is started.'


;---------------------- UTR Text -------------------------------------------

;:*:uthi::Additional recommendations to reduce the exposures at this facility are contained within this report. These recommendations were not discussed in detail because of the focused nature of this visit. However, by implementing these recommendations the building will be less likely to incur a devastating loss that requires months to repair before normal operations can resume.
:*:utrf::
{ ; V1toV2: Added bracket
A_Clipboard:=""
Sleep(100)
txt:="
(
From the Boiler and Machinery (B&M) perspective, the primary hazard is failure of the electrical infrastructure.

A robust asset integrity program coupled with thorough maintenance, and effective management of change, are essential to ensuring resilience, and reliable production.

Management, operations, and maintenance personnel have been working diligently to improve the maintenance programs and practices. Any gaps in maintenance routines are identified and reviewed for implementation. Site management and maintenance personnel should be commended for their ongoing efforts in this area.

In addition to the formal recommendations made, additional comments have been provided that also represent good loss prevention advice and should be completed.
)"

A_Clipboard:= txt
Errorlevel := !ClipWait(1)
Send("^v")
return
;---------------------- End of UTR Text -------------------------------------------
;---------------------- ICS Comment -------------------------------------------

;:*:uthi::Additional recommendations to reduce the exposures at this facility are contained within this report. These recommendations were not discussed in detail because of the focused nature of this visit. However, by implementing these recommendations the building will be less likely to incur a devastating loss that requires months to repair before normal operations can resume.
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:icscomf::
{ ; V1toV2: Added bracket
SendLevel(1)
Send("^b" . "Industrial Control Systems (ICS) Evaluation:" . "^b" . "`n" . "An evaluation of ICS is now included in boiler and machinery evaluations and was performed for the first time at this facility during this visit.")
return
;---------------------- End ICS Comment -------------------------------------------
} ; V1toV2: Added Bracket before hotkey or Hotstring

:?*:closeconff::
{ ; V1toV2: Added bracket
SendLevel(1)
A_Clipboard := "The closing conference date shown on this report is different than the last day the engineer was onsite. This was due to a request by the client to delay to obtain and provide records. The last day onsite was "
Send("^v")
SetKeyDelay(10, 10)
Send("/week . `", `"")
Send("/month . `", `"")
Send("/day . `", `"")
Send("/year . `".`"")

return
;-------------------------- Red Tag Recommendation ----------------------------------
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:rtpst::Use of the FM Global Red Tag Permit System.

:*:rtpsrfm::A formal, written policy on using of the FM Global Red Tag Permit System to monitor all fire protection system valve closures should be developed. Sprinkler impairments should be submitted to FM Globalâ€™s San Francisco office via phone (888 247 9062), fax (800 736 5564) or online at https://redetag.fmglobal.com. To assist you with the implementation of the FM Global Red Tag Permit System, FM Global offers free, online, training at https://fmglobaltraining.skillport.com.

:*:rtpsrafm::A formal, written policy on using the FM Global Red Tag Permit System to monitor all fire protection system valve closures should be developed. Sprinkler impairments should be submitted to FM Globalâ€™s San Francisco office via phone (888 247 9062), fax (800 736 5564) or online at https://redetag.fmglobal.com. To assist you with the implementation of the FM Global Red Tag Permit System, AFM offers free, online, training at https://affiliatedfmtraining.skillport.com.


;----------------------- Quarterly Waterflow Alarm Title ----------------------------

:*:qwft::Conduct quarterly, documented, waterflow alarm testing.

:*:qwfr::Waterflow alarms should be tested by opening the inspectorâ€™s test valves to flow water through the sprinkler system. For wet-pipe systems, use the inspectorâ€™s test connection at the extreme end of the system. For dry-pipe systems, use the hydraulic test connections at the dry-pipe valve. The waterflow alarm should activate within 90 seconds of the initial waterflow. Testing should be done only by well-trained personnel or by an inspection service to avoid unnecessary local disturbances and response by the public fire department. Following the test, the alarm monitoring company should be contacted to confirm that all test signals are received. Records of all testing should be retained for review.


;------------------ Monthly Physical Valve Inspection ---------------------------------

:*:mvit::Conduct monthly, documented, physical inspections of post-indicator valves.

:*:mvir::Monthly physical testing of post-indicator valves and wall post-indicator valves verifies that valves are open and that indicating mechanisms are properly aligned with the unitâ€™s window. Records of these inspections should be maintained on file.{Enter}Physically inspecting a valve includes:{Enter}Unlocking the valve.{Enter}Turning the hand-wheel or wrench in the fully open position direction.{Enter}Turning in the closed direction two or three turns to ensure operable condition.{Enter}Returning the valve to the full open position (feeling the spring in the shaft).{Enter}Backing off approximately one-quarter turn to relieve the strain.{Enter}Relocking the valve.

;-------------------------- Low Voltage Recs -------------------------------------

:*:rlvf::Improve inspection, testing and maintenance practices for circuit breakers.

;----------------------------- Management of Change ---------------------------------------

:*:mchanget::Utilize FM Global Plan Review services.

:*:mchanger::Get FM Global engineering involved during the initial planning stages (the earlier the better) for any new process or process changes, construction, roofing or roof repairs, changes in fire protection, installation of gas-fired equipment or occupancy changes.  Ideally, design documents should be reviewed early in project planning and no later than the â€˜Schematicsâ€™ design phase, before the project scope and budget are developed. Early involvement by FM Global will allow alternative solutions or recommendations to be considered before budget, scope or schedule changes are required.

;---------------------------- Lock Sprinkler Valves ----------------------------------------

:*:lvt::Lock all fire sprinkler control valves in the wide-open position.

:*:lvr::All sprinkler control valves larger than 1.5 in. should be locked in the fully open position with unbreakable locks and chains. Keys for the locks should be distributed to the personnel directly responsible for fire protection. During the risk evaluation the following valves were found unlocked.

;-------------------------- Install AS Sprinkler Protection --------------------------------

:*:installast::Install automatic sprinkler protection in

:*:installasr::Sprinkler protection should be installed in accordance with FM Global Property Loss Prevention Data Sheet 2-0, Installation Guidelines for Automatic Sprinklers and FM Global Property Loss Prevention Data Sheet 2-8, Earthquake Protection for Water-Based Fire Protection Systems.{Enter}Before completing any such upgrade, FM Global should be contacted to review details of the proposed plans and coordinate the design with the contractor.

;------------------------------ Annual Infrared Inspection -----------------------------------

:*:irt::Perform infrared thermographic surveys on all electrical equipment annually.

:*:irr::Infrared surveys of electrical equipment should be done only by a qualified contractor or employee. If surveys are to be completed in-house a detailed list of all equipment to be surveyed should be created so that the scope of the survey is well defined. Problems found during the survey and corrective action taken should be well documented for historic and trending purposes.

; ----------------------------------- Hot Work ----------------------------------------------

:*:hwpst::Implement the use of the FM Global Hot Work Permit System.

:*:hwpsrfm::The FM Global Hot Work Permit System should be used to monitor any cutting, welding, or other hot-work activity conducted outside areas specifically designated for hot-work operations. A formal, written policy statement should specify who has the authority to issue permits and should apply to hot work conducted by facilities personnel as well as outside contractors. Designated hot-work areas should also incorporate all appropriate precautions outlined in the Hot Work Permit System. To assist you with the implementation of the FM Global Hot Work Permit System, FM Global offers the free, online, training courses Managing Hot Work Using FM Global's Hot Work Permit System and Advancing Your Hot Work Skills at https://fmglobaltraining.skillport.com.

:*:hwpsrfm::The FM Global Hot Work Permit System should be used to monitor any cutting, welding, or other hot-work activity conducted outside areas specifically designated for hot-work operations. A formal, written policy statement should specify who has the authority to issue permits and should apply to hot work conducted by facilities personnel as well as outside contractors. Designated hot-work areas should also incorporate all appropriate precautions outlined in the Hot Work Permit System. To assist you with the implementation of the FM Global Hot Work Permit System, AFM offers the free, online, training courses Managing Hot Work Using FM Global's Hot Work Permit System and Advancing Your Hot Work Skills at https://affiliatedfmtraining.skillport.com.

;---------------------- Emergency Response Plan ------------------------------------------

:*:erpt::Improve the existing emergency response plan (ERP)

:*:erpr::The ERP should include the following positions:{Enter}Person-in-Charge - This person directs actions of personnel, is responsible for keeping the ERP roster current and ensuring personnel are trained.{Enter}Notifier - The notifier is designated to call the fire department.{Enter}Sprinkler Valve Operator - In the event of a fire, this person goes to the valve controlling the fire area and ensures it is open.{Enter}Utilities Operator - This person assists the fire department as needed to shut down utilities and hazardous processes.{Enter}Fire Pump Operator - The fire pump operator is designated to respond to the fire pump and ensure it is operating.{Enter}{Enter}Members of the emergency response team should be provided with quarterly refresher training.

return



; ==========================================================================================================================
; :*:reccom::
; { ; V1toV2: Added bracket
; hCtl := ControlGetClassNN(ControlGetFocus("A"))
; Ctl := ControlGethWnd(hCtl, "A")
; hWndChild := DllCall("RealChildWindowFromPoint", "Ptr", Ctl, "UInt", , "Ptr")
; cCtl := ControlGethWnd(, "ahk_pid " hwndChild)
; ;tooltip % "hCtl: " hCtl "`nCtl: " Ctl "`nhWndChild: " hWndChild "`nchWndChild: " chWndChild "`nErrorLevel: "ErrorLevel
; ;WinGetClass, vCtl, % "ahk_id " hWndChild
; ;msgbox % ASC("Control")
; ;return
; ;clipboard:=""
; ;txt:="Additional Boiler and Machinery (B&M) Minor Recommendations:"
; ;clipboard:= % txt
; ;clipwait 1

; DllCall("keybd_event", "int", 162, "int", 29, "int", 0, "int", 0) 
; DllCall("keybd_event", "int", 0x42, "int", 0, "int", 0)
; ;dllcall("keybd_event", int, 0x42, int, 2, int, 0)
; DllCall("keybd_event", "int", 162, "int", 29, "int", 2, "int", 0)
; ;send ctrl+shift+left without using Send/SendInput/ControlSend
; ;e.g. tested on Notepad (Windows 7)
; ;WinGet, hWnd, ID, A
; ;ControlGetFocus, vCtlClassNN, % "ahk_id " hWnd
; ;if !(vCtlClassNN = "")
; ;ControlGet, hWnd, Hwnd,, % vCtlClassNN, % "ahk_id " hWnd

; ;vTIDAhk := DllCall("kernel32\GetCurrentThreadId", "UInt")
; ;VarSetCapacity(PBYTE1, 256, 0)
; ;DllCall("user32\GetKeyboardState", "Ptr",&PBYTE1)

; ;vTID := DllCall("user32\GetWindowThreadProcessId", "Ptr",hWnd, "Ptr",0, "UInt")
; ;DllCall("user32\AttachThreadInput", "UInt",vTIDAhk, "UInt",vTID, "Int",1)
; ;VarSetCapacity(PBYTE2, 256, 0)
; ;NumPut("UChar", 0x80, PBYTE2, 0x11) ;VK_CONTROL := 0x11
; ;NumPut("UChar", 0x80, PBYTE2, 0x42) ;VK_B := 0x42
; ;DllCall("user32\SetKeyboardState", "Ptr",&PBYTE2)

; ;WM_SYSKEYDOWN:=0x104, WM_SYSKEYUP:=0x105, WM_SYSCHAR:=0x106
; ;SendMessage,0x100, 0x11,,, % "ahk_id " hWnd ;WM_SYSKEYDOWN := 0x104 VK_CONTROL:= 0x11
; ;SendMessage, 0x100, 0x42,,, % "ahk_id " hWnd ;WM_SYSKEYDOWN := 0x104 VK_B:= 0x42
; ;SendMessage, 0x102, 0x42,,, % "ahk_id " hWnd ; WM_SYSCHAR:= 0x106, WM_CHAR:=0x102
; ; should be sent now
; ;SendMessage, 0x101, 0x42,,, % "ahk_id " hWnd ;WM_SYSKEYUP := 0x105, VK_B:= 0x42
; ;SendMessage, 0x101, 0x11,,, % "ahk_id " hWnd ;WM_SYSKEYUP := 0x105, VK_CONTROL:= 0x11
; ;DllCall("user32\AttachThreadInput", "UInt",vTIDAhk, "UInt",vTID, "Int",0)
; ;DllCall("user32\SetKeyboardState", "Ptr",&PBYTE1)
; ;Send "`n`n"
; ;clipboard:=""
; ;txt:="In addition to the formal B&M recommendations made, the following items also represent good loss prevention advice and should be completed."
; ;clipboard:=% txt
; ;clipwait 1
; ;send ^v
; ;clipboard:=""
; ;SendMessage, WM_KEYDOWN:=0x100, VK_CONTROL:=0x11, 0,,ahk_id %ctl%
; ;PostMessage, WM_CHAR, 0x00000062, 0x00300001,,ahk_ID %ctl%
; ;PostMessage, WM_KEYDOWN:=0x100, VK_B:=0x42, 0,,ahk_id %ctl%
; ;PostMessage, WM_CHAR, 0x00000062, 0x00300001,,ahk_ID %ctl%
; ;SendMessage, WM_KEYUP:=0x101, VK_B:=0x42, 0,,ahk_id %ctl%

; ;SendMessage, WM_KEYUP:=0x101,VK_CONTROL:=0x11, 0,,ahk_id %ctl%
; ;Send % chr(98)
; ;ControlSend, ,^b,"ahk_id " Ctl
; ;DllCall("SendMessage", "UInt", 0x0100, "UInt", 265, "UInt", 0x11, "UInt", 17) ; WM_KEYDOWN, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;DllCall("SendMessage", "UInt", 0x0100, "UInt", key: {Ctrl}) ; WM_KEYDOWN, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;MsgBox % ErrorLevel
; ;DllCall("SendMessage", "UInt", 0x0100, Int32, 265, Int32, 0x42) ; WM_KEYDOWN, Value,VK_B == Note: magnumbdb.com has nothing
; ;Sleep 100
; ;Send % txt
; ;DllCall("SendMessage", "UInt", 0x0101, "UInt", 257, "UInt", 0x42) ; WM_KEYUP, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;DllCall("SendMessage", "UInt", 0x0101, "UInt", 257, "UInt", 0x11, "UInt", 17) ; WM_KEYUP, Value,VK_CONTROL, Value == Note: magnumbdb.com says Type is Int32
; ;Sleep 100
; ;Send "`n`n"
; ;Clipboard:=txt1:="In addition to the formal B&M recommendations made, the following items also represent good loss prevention advice and should be completed."
; ;Send ^v
; return
; } ; V1toV2: Added Bracket before hotkey or Hotstring

:*:recresp::
{ ; V1toV2: Added bracket
A_Clipboard:= ""
A_Clipboard := "Management stated they understand the recommendation. When the recommendation is received, the vendor will be engaged to ascertain the scope, cost, and scheduling. No timeline for completion was offered."
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:lvtit::
{ ; V1toV2: Added bracket
A_Clipboard:=""
A_Clipboard:= "Improve asset management of the low voltage switchgear."
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:lowvi::
{ ; V1toV2: Added bracket
A_Clipboard:=""
A_Clipboard:= "Improve inspection, testing, and maintenance (ITM) of the low voltage switchgear per" A_Space
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
SendLevel(1)
;SetKeyDelay,100,10
Send("fmdsf")
Send("{Space}")
;SetKeyDelay,100,10
Send("5-20f")
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:lowvrec::
{ ; V1toV2: Added bracket
A_Clipboard:=""
A_Clipboard:= "
(
The following is summary of guidance in Data Sheet 5-20:

Low Voltage Circuit Breakers:
- Section 2.1.3.2, and Table 1.

Table 1:
Low Rresistance:
- Measuring resistance across bolted connections
Insulation Rresistance:
- Each pole measured phase to ground and phase to phase
Contact Resistance (micro-ohms):
- Measuring resistance across closed contacts
Primary, or secondary, current injection testing
Trip and close coil voltages (if applicable, compare with OEM values)

Motor Controllers:
- Section 2.1.3.3, and Table 2.

Bus Ducts and Cables:
- Section 2.1.3.6, and Table 5.

For full guidance on all applicable sections, please see Data Sheet 5-20.
)"
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return


; ================================== MV SWITCHGEAR  ==========================
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:mvswgrtit::
{ ; V1toV2: Added bracket
A_Clipboard:=""
Sleep(100)
A_Clipboard := "Improve asset management of the medium voltage switchgear."
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:mvswgrrec::
{ ; V1toV2: Added bracket
A_Clipboard:="
(
During the visit, the following deficiency was identified:
- No formal ITM program exists; it is unknown if any recommended ITM has occurred since installation.
- The electrical single-line diagram was created in-house, is out-of-date, and some parts lack critical details such as the current interruption device types/styles (e.g., circuit breaker, switch, fused-switch, ampere rating).

The following is a summary of guidance outlined in Data Sheet 5-19, and includes:

Online: (annual)
Perform online partial discharge surveys every one to three years.

Offline: (every three years)

Circuit Breakers:
- Section 2.1.4.1, and Table 1a/1b.
Switches and Fuses:
- Section 2.1.4.2, and Table 2.
Protection Relays:
- Section 2.1.4.3
Insulators and Busbars:
- Section 2.1.4.6, and Table 4.

Additional Guidance:
- FM Global recommends and is available to review any service agreements (e.g., scope, periodicity, alternative methods) to ensure the intent of the recommendation is met prior to finalizing the maintenance contract and starting work.
- Once the service records/baseline values are obtained, maintain the records for review, tracking, and trend analysis; contact and provide the records to FM Global for review.

Please see the data sheet for full details and additional guidance.
)"
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return

; =================================================================
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:swgruth::
{ ; V1toV2: Added bracket
A_Clipboard:=""
Sleep(100)
A_Clipboard :="
(
The switchgear protects the electrical distribution and downstream production equipment. If this equipment fails to operate as intended, this exposure can result in significant business interruption, delays in testing/certification, loss of in-process and/or controlled storage products, and personnel safety.
)"
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return

; =========================== ECP STUFF ==================================
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:ecprinsr::Management stated they understand the recommendation, and have agreed to add the documents to the existing document review management program. Once the documents are added, reviewed, and updated, FM Global will be provided the documents, and contacted for review prior to closure of the recommendation. No formal timeline for completion was offered.
return

; ==================TRANSFORMERS ==============
:*:xfmrrec::
{ ; V1toV2: Added bracket
A_Clipboard:=""
Sleep(100)
A_Clipboard := "
(
The following guidance is outlined in Data Sheet 5-4 and includes:

Perform baseline/benchmark testing, as applicable, listed in Section 2.1.3.1.1. 

Perform the following electrical tests, listed in Table 2, at least once every three years:

Windings: 
- Insulation resistance
- Winding resistance
- Polarization index
- Turns ratio
- Power factor/capacitance

Bushings: 
- Power factor
- Capacitance testing

Core: 
- Core insulation resistance

Additional Guidance:
Note 1: If any issues are found during testing, Table 3 provides guidance for any additional focused testing requirements.
Note 2: Once baseline/benchmark testing has been completed please provide the results to, and contact, FM Global for review. 

Please see the data sheet for full details.
)"
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return

; ================ PARTIAL DISCHARGE SURVEYS ====================================
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:pdtitle::Implement an annual online partial discharge (PD) survey program.

:*:pdrec::
{ ; V1toV2: Added bracket
A_Clipboard:=""
Sleep(100)
A_Clipboard:= "Perform annual online partial discharge (PD) surveys for switchgear and circuit breakers rated 4 kV and above per "
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
SetKeyDelay(100, 10)
Send("fmdsf")
Sleep(100)
Send("{Space}")
Sleep(100)
Send("5-19f")
Sleep(100)
Send(".`n`n`n")
A_Clipboard:=""
A_Clipboard := "Note: This recommendation is being made due to updated guidance, and associated industry loss history."
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:pduth::
{ ; V1toV2: Added bracket
A_Clipboard:= ""
A_Clipboard := "Partial discharge (PD) and corona activity occur in switchgear rated 4 kV and above and is a good indicator of insulation issues due to incorrect installation, manufacturer defects, and signs of aging. The switchgear protects the electrical distribution and downstream production equipment."
A_Clipboard
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:pdtech::
{ ; V1toV2: Added bracket
A_Clipboard:= ""
Sleep(100)
A_Clipboard := "
(
There are multiple ways to meet the intent of this recommendation. Please utilize a specialized vendor to provide, and review with, the available options.

Partial Discharge (PD) Guidance:
Please see Data Sheet 5-19, Sections 3.2.3, and 3.2.4, for in-depth technical details regarding methods of testing, and continuous monitoring vs. in-service survey PD testing.
)"
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
SetKeyDelay(100, 10)
Send("{Up}")
Sleep(100)
Send("{LShift Down}{Home}{LShift Up}")
Sleep(100)
Send("^#b")
return

; ============================ BATTERY STUFF =====================
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:battitmt::
{ ; V1toV2: Added bracket
A_Clipboard:= ""
Sleep(100)
A_Clipboard := "Improve inspection, testing, and maintenance (ITM) of medium voltage (MV) switchgear batteries."
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:battmgmt::
{ ; V1toV2: Added bracket
A_Clipboard:= ""
Sleep(100)
A_Clipboard := "Improve asset management of medium voltage (MV) switchgear batteries."
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:battrec::
{ ; V1toV2: Added bracket
A_Clipboard:=""
Sleep(100)
A_Clipboard := "Improve the management of medium voltage (MV) switchgear batteries per "
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
SetKeyDelay(100, 10)
Send("fmdsf")
Sleep(100)
Send("{Space}")
Send("5-28f")
Sleep(100)
Send(".`n`n")
A_Clipboard := "
(
- Perform quarterly capacitance (internal ohmic) testing
- Perform five year capacity (performance or discharge) testing
- Monitor, maintain, and control battery room/area temperature at, or near, 77°F
)"
Errorlevel := !ClipWait(1)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring
:*:battuth::
{ ; V1toV2: Added bracket
A_Clipboard := "Switchgear batteries are critical safety devices, and provide the trip voltage necessary to open the breaker(s) in a fault condition. Monitoring and controlling the temperature of the batter room/area, at/near 77°F, is also critical to overall battery life and health. Deterioration of the batteries affects the circuit breaker's arc-interrupting capability."
Errorlevel := !ClipWait(1)
Sleep(100)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:battitmf::
{ ; V1toV2: Added bracket
A_Clipboard:= "
(
The following guidance is outlined in Data Sheet 5-28:

Capacitance (Internal Ohmic) Testing: (see Note 1)
Section 2.5.2 and Table 1: Capacitance testing, maintenance schedule, and other useful information.
- Capacitance, internal ohmic, internal resistance, and internal impedance, are common terms that are synonymous.
- This requires a specific type of testing equipment, and cannot be done with a standard multimeter; a multimeter will provide resistance readings, but this is not the same as internal resistance.

Capacity (Performance or Discharge) Testing: (see Note 2)
Section 2.5.2.4: Periodicity of capacity testing based on battery type, and other useful information.

Failure Modes:
Section 3.3.3 and Table 2: Provides pictures and technical detail on major failure modes of flooded/vented lead acid (VLA) batteries (e.g., sulfating).

Alternatives:
- Note 1: If all of Section 2.3.6.2 (as applicable) parameters are monitored, annual capacitance (internal ohmic) testing is acceptable. The continuously monitored parameters should match Table 1; whatever is not continuously monitored, perform at regular recommended periodicity.  
- Note 2: If all of Table 1, including internal ohmic, is performed, and some additional conditions met (detailed below), it is acceptable not to perform capacity (performance or discharge) testing, due to the battery's application.
- Must meet all of the following conditions: Baseline values are recorded at the recommended intervals; the same testing equipment is utilized throughout battery life; a prescriptive failing/failed battery replacement/capacity testing program is developed, and followed; the batteries do not support any loads other than the medium voltage switchgear, and its associated protective features.

Please see the data sheet for full guidance details.
)"
Send("^v")
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:battmgmf::
{ ; V1toV2: Added bracket
A_Clipboard := "
(
The following guidance is outlined in Data Sheet 5-28:

Temperature Control and Monitoring:
- Section 2.3.1.1: To optimize the performance and aging rate of the batteries, maintain the battery room, or area, as close to 77°F (25°C), or temperature range specified by manufacturer, as possible.
- Section 3.3.2: Provides additional technical detail on temperature control and reduced life.
- This section also includes the critical statement: Continuous operation of batteries at elevated temperature will reduce the life by approximately 50% for every increase of 15°F (8.3°C).

Please see the data sheet for full guidance details.
)"
Errorlevel := !ClipWait(1)
Sleep(100)
Send("^v")
Sleep(100)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

:*:battresp::
{ ; V1toV2: Added bracket
A_Clipboard := "Management stated they understand the recommendation. An assessment will be conducted internally if performing this in-house is practical, or if the existing vendor will be used; if performed in-house, the appropriate battery tester will be purchased as soon as practical, and capacitance testing will begin. No formal timeline for completion was offered."
Errorlevel := !ClipWait(1)
Sleep(100)
Send("^v")
Sleep(100)
}
return