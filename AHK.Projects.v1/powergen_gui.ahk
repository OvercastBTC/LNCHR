#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!p::
Gui, Powergen:New,, Powergen
Gui, Add, Text,, Enter the client name:""
Gui, Add, Edit, R1 vclient_name W200, Text
Gui, Add, Text,, Enter the client index:""
Gui, Add, Edit, R1 vclient_index W200, Text
Gui, Add, Edit, R1 W200 vTrigger -WantReturn -WantTab
Gui, Add, Text,, New Word Goes Here (Can be multiline):
Gui, Add, Edit, R1 vNewW W200, Text
Gui, Add, Checkbox, vItalic YM+90, Italic Letters
;Gui, Add, Checkbox, vBold, Bold Letters
;Gui, Add, Checkbox, vUnderLine, Underline Letters
Gui, Add, Button, gAdd, Save
Gui, Add, Button, gCancel, Cancel
Gui, Show, AutoSize Center
Return

vAdd:
GuiControlGet, IsItalic,, Italic
;GuiControlGet, IsBold,, Bold
;GuiControlGet, IsUnderLine,, Underline
GuiControlGet, Trigger,, Trigger, Edit
GuiControlGet, NewWord,, NewW, Edit
IF (IsItalic = 1)
{
		NewWord := "^i" . NewWord . "^i"
	}
	IF (IsBold = 1)
	{
		NewWord := "^n" . NewWord . "^n"
	}
	IF (IsUnderLine = 1)
	{
		NewWord := "^s" . NewWord . "^s"
	}
	FileAppend, `n:X:%Trigger%::Send`,`n(`n%NewWord%`n)`nReturn`n, %A_ScriptName%
	Gui, Powergen:Destroy
	MsgBox, do I work? ;Word Succesfully Added!
	Reload
	Return
	
*/
; Client Info
client_name = 
client_index =
date = A_MM.A_DD.A_YYYY

; Name Plate Data
rating_watts =					; kW or MW
rating_oem =					; Original Equipment Manufacturer (OEM)
rating_sn =					; Serial Number
rating_manu_date =				; Date of Manufacturer
rating_dry_wet_fire =			; Dry or Wet Fire
rating_txt =					; Notes/Comments

; Operating Profile
op_pro =						; Operating Profile
op_load =						; Load % when running
op_as_of =					; As of Date
op_fired_sts =					; Fired Starts
op_fired_hrs =					; Fired Hours
op_pro_txt =					; Operating Profile Explanation

; Asset Managment Strategy (AMS)
sa_type =						; LTSA or CSA; ; Service Agreement - Long Term or Custom (LTSA/CSA)
sa_txt =						; LTSA/CSA Notes/Comments
ams_iaw_oem =					; Is ITM IAW OEM?
ams_method =					; Method - Effective Operating Hrs (EOH), condition based maint.(CBM)
ams_periodicity =				; What determins the frequency?
ams_performer =				; Who does the ITM?
itm_starts_ci =				; Combustion Inspection - Starts Limit
itm_hours_ci =					; Hot Gas Section(Frame)/Path(Aero) - Minor Hours Limit
si_hours =					; Service Interval Hours
si_starts =					; Service Interval Starts
proj_hrs =					; Projected Hours
proj_starts =					; Projected Starts
boro_freq =					; Boroscope Frequency
boro_last =					; Boroscope Last Performed
boro_txt =					; Boroscope Notes/Comments

; Controls & Safety Devices (CSD)
csd_iaw_13_7_tbl1 =				; Safety inter-locks and trips provided include all listed on Table 1, 2.2 OS 13-17 and meet the req's of this standard.
csd_test =					; C&SD Testing Freq. (Annual)
csd_txt =						; C&SD Notes/Comments

; Overspeeds - Mechanical, Electrical, Electronic (Digital)
o_s_m =						; Overspeed Mechanical
o_s_e =						; Overspeed Electrical
o_s_d =						; Overspeed Digital/Electronic
o_s_last =					; Overspeed Last Test Date 
o_s_txt =						; Overspeed Notes/Comments

; Vibration Analysis
vib_type =					; Manual, Continuous
vib_txt1 =					; Notes/Comments (e.g., no step changes)
vib_txt2 = 					; Additional Notes

; Lube Oil
lo_samp_freq =					; Quarterly, None - Annual changeout
lo_samp_txt =					; Notes/Comments/Issues
lo_pmp_alop =					; Attached Lube Oil Pump
lo_pmp_aux =					; Auxiliary Lube Oil Pump AC/Steam
lo_pmp_elop =					; Emergency Lube Oil Pump AC/Steam/DC
lo_pmp_aux_test =				; Aux LOP Testing 
lo_pmp_elop_test =				; Emergency LOP Testing
lo_pmp_elop_filt =				; Does ELOP bypass filters?
lo_pmp_elop_overload =			; Are the ELOP Thermal Overloads disabled?

; Documents and Records
lo_pid =						; Lube Oil P&ID
itm_minor =					; Last Minor (CI)
itm_major =					; Last Major (HGS/HGP)

; Steam Turbine
vlv_msv_nde =					; Main Stop/Isolation Valve
vlv_msv_exer =					; MSV/MIV Exercising/Stroking
vlv_tg_ctrl =					; Turbine Control Valve
nrv_test =					; Nonreturn Valve (Extraction Steam?)
vlv_exerc =					; Valve Exercising
vlv_txt =						; Valve Notes/Comments
L0_nde =						; What are you doing? IAW OEM?
L1_nde =						; What are you doing? IAW OEM?
EOL = 						; End of Life study


; Optional Upgrades
purge =						; Purge - HRSG & CTG - Installation of NFPA 85 gas trains
purge_txt = 
upgrd_1 =
upgrd_2 =

/*notes = 
(	
	Equipment Factor Comments: Operators due to lacking oil fire and DC power procedures rates USAT:
	
	These units were operated as simple cycle peakers for ten years. HRSGs were installed and the plant was updated to combined-cycle peaking operations in 2012. The two CTs reportedly operated for an average of 100 hours per year prior to the update. The operating profile of the plant is 6AM to 11PM Monday through Saturday. 
	
	The HRSG duct burners and CT natural gas mains in Q4 2018 were modified in accordance with NFPA 85 for purge credit thereby eliminating requirement for purge cycles.
	
	Overspeed protection is an Emerson Ovation Controls triple redundant electronic system. Annual overspeed testing is done while fired and coming up to speed; speed adjustment is set to 300 rpm for each channel. This ensures all CT and ST valving closes as required during an emergency overspeed.  
	
	Vibration monitoring is provided and is continuous. No step increases in unit vibration have been reported.
	
	Lube oil is analyzed quarterly. Sampling and analysis are up-to-date. No issues have been reported.
	
	This combustion turbine is provided with an AC and DC-power auxiliary and emergency lube-oil pumps, respectively. Testing of the auxiliary lube-oil pump is conducted daily, while the emergency lube-oil pump is tested (pressure drop) monthly. The DC LO pump piping is upstream of filters preventing isolation if filters are plugged and/or shut-off. The thermal overload protective devices are not in-service.
	
	Safety inter-locks and trips provided include all listed on Table 1, 2.2 OS 13-17 and meet the requirements of this standard. Annual I&C documented inspection and calibration is performed.
	
	Both units are reported to have been updated to 2055 F firing temperatures.
	Both units are reported to have been updated to 2055 F firing temperatures.
	
	ISO Rating is 84.9MW
	
	Maintenance:
	Asset management follows OEM: 600 starts/1200 hours CI and 1200 starts/24,000 hours HGP - Major planed May 2021
	
	Client advised based on profile, maintenance follows starts.
	
	Borescope inspections of combustion turbines are conducted semi-annually by OEM - GE Power Inspection & Life Extension Services.
	
	Performance monitoring is not done due to profile: don't have ability to run full load and so run at partial load. Heat rate is monitored on curve - no step changes. No annual performance testing done, and PPA to test RATTA twice per year but not done since 2016. Performance degradation curve is what GE expects; tracking nearly 4-1/2% based on 50,000 hours curve.
	
	TIL's are properly managed by the maintenance manager Nick Van Haeften, Maintenance Manager. GE online tracking and spreadsheet is used for various SB, PB, TILS. Compliance required (C) and maintenance (M) items are completed through the site preventive maintenance (PM) system. Once the PM's are completed, the status is updated. All TIL's are up-to-date.
	
	Foreign Material Exclusion (FME) management policy exist and is required to be followed for in-house and contracted services.
	
	No LTSA/CSA is in place.
	
	Key Factors:
	Load 100% when operational.
	As of Feb 14, 2019: 
	Fired starts 1,748
	Fired hours 20,588
	
	History:
	The Wood Group completed a borescope inspection in November 2014. Rolled metal of the compressor hub/blades was observed. No other issues were identified by the inspection contractor. No recommendations were offered by the inspection contractor. 
	
	Hot-gas path dismantle inspection occurred spring 2016.
	
	Oct 2018: Borescope reports done in Oct 2017,and May 2018 were completed by OEM. Blade tip rub and role-over were observed in the 6 O'clock position. The change over time appears to be minor and is reflective to the Wood Group assessment made in 2014. The OEM recommendation was to submit the findings to the OEM for engineering review; a formal recommendation has been offered. Another concern is several of the borescope access ports are seized so observations in both reports were limited. In some cases only 33% of the machine could be observed. The recommendation to restore the ports is expected when review is completed by the OEM. No conclusive statements for unit being fit for service have been made.
	
	Mar 2019: Borescope reports done in Nov 2018 were completed by OEM. During prospect an OEM engineering review was recommended as the prior BSI did not include conclusive statements; this was done. Three TIL's were also addressed as documented in the BSI report. The report indicated Stage 4 compressor had FOD impact. Fresh and old blade tip rubbing was observed on multiple compressor stages; OEM recommended conditioning at next MI. Transition pieces for Can 1 exhibited TBC cracking and were replaced. Unit still has a few plugs seized, but OEM indicated they were able to get to the front of Stage 1 and TE of 3 and 2; did not make formal recommendation to repair plugs. The plugs are to be addressed at next MI. And based on unit rotation where it came to rest during each BSI, different parts of the machine are observed. Overall OEM deemed fit for service.
)*/