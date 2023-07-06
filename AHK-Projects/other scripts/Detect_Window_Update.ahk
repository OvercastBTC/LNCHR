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
;============================== End Auto-Execution Section ==============================

;============================== Includes Section ==============================
/*
#include WinClip_API.ahk
#Include WinClip_base.ahk
return
*/
;============================== ini Section ==============================
; Do not remove /* or */ from this section. Only modify if you're
; storing values to this file that need to be permanantly saved.
/*
	[SavedVariables]
	Key=Value
*/

~LAlt:: ; update the current active window if Alt-Tab is used
state_alt:= GetKeyState("LAlt")
GetKeyState("LAlt")

state_tab:= GetKeyState("Tab")
if (state_alt = "T")
	Loop
	{
	Sleep, 10
	if !GetKeyState("LAlt", "P") ; The key has been release, so break out of the loop.
		break
	if GetKeyState("LAlt", "T")
		GetKeyState("Tab")
			if !GetKeyState("Tab", "P")
				Gosub, Update_Window_1
			break
	If GetKeyState("Tab", "T")
		Gosub, Update_Window_1
	return
}
Sleep 2250
SplashTextOff
return

~LButton::
state:= GetKeyState("LButton")
GetKeyState("LButton")
;SplashTextOn, 100, 50,, % state
if (state = "T")
	Loop
	{
		Sleep, 10
		if GetKeyState("LButton", "T")
			Gosub, Update_Window_1
		Sleep, 10
		if !GetKeyState("LButton", "P") ; The key has been release, so break out of the loop.
			break
		
		return
}
Sleep 2250
SplashTextOff
return

^+!0::
Update_Window_1:
DetectHiddenWindows, On								; https://autohotkey.com/docs/commands/DetectHiddenWindows.htm
	;SetTitleMatchMode,									; https://autohotkey.com/docs/commands/SetTitleMatchMode.htm
;WinGet, Current_Window,ID,A							; https://autohotkey.com/docs/commands/WinGet.htm
WinGet, Current_Window,ProcessName,A					; https://autohotkey.com/docs/commands/WinGet.htm
;WinGet, Current_Window,PID,A							; https://autohotkey.com/docs/commands/WinGet.htm
;WinGetClass,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetClass.htm
;WinGetText,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetText.htm
;WinGetTitle,Current_Window,A							; https://autohotkey.com/docs/commands/WinGetTitle.htm
;MsgBox % Current_Window
ToolTip,% Current_Window "`n" Last_Window "`n" Old_Window, x+w,0+h
SetTimer, RemoveToolTip, 5000
Current_Windown = a_process
If(state_alt = "T"){
	SplashTextOn, 200, 100,, % "1=On/Down`n "state_alt "LAlt is On `n" "The active process is: " a_process
}else{
	return
}
If(state = "T"){
	SplashTextOn, 200, 100,, % "1=On/Down`n "state "LAlt is On `n" "The active process is: " a_process
}else{
	return
}	

if(Current_Window!=Last_Window)
	Old_Window:=Last_Window,Last_Window:=Current_Window
return

RemoveToolTip:
ToolTip
return

send_os_title(os_title_full)
{
	WinGet,  a_process,  ProcessName,  A
	h_process:="hznhorizon.exe"
	if (a_process=h_process){
		send_italic(os_title_full)
		return
	} else {
		Send, ^i				
		Send %os_title_full%
		Send, ^i
		return
	}
}
return
/*
;#[Horizon Hotstrings]
;============================== Horizon ==============================

:*:1-0f::1-0, Safeguards During Construction, Alteration and Demolition
:*:1-1f::1-1, Firesafe Building Construction and Materials
:*:1-2f::1-2, Earthquakes
:*:1-3f::1-3, High-Rise Buildings
:*:1-4f::1-4, Fire Tests
:*:1-6f::1-6, Cooling Towers
:*:1-8f::1-8, Antenna Towers and Signs
:*:1-9f::1-9, Roof Anchorage for Older, Wood-Roofed Buildings
:*:1-10f::1-10, Smoke and Heat Venting in Sprinklered Buildings
:*:1-11f::1-11, Fire Following Earthquakes
:*:1-12f::1-12, Ceilings and Concealed Spaces
:*:1-13f::1-13, Chimneys
:*:1-15f::1-15, Roof Mounted Solar Photovoltaic Panels
:*:1-17f::1-17, Reflective Ceiling Insulation
:*:1-20f::1-20, Protection Against Exterior Fire Exposure
:*:1-21f::1-21, Fire Resistance of Building Assemblies
:*:1-22f::1-22, Maximum Foreseeable Loss
:*:1-24f::1-24, Protection Against Liquid Damage
:*:1-26f::1-26, Steep-Slope Roof Systems
:*:1-27f::1-27, Windstorm  Retrofit and Loss Expectancy (LE) Guidelines
:*:1-28f::1-28, Wind Design
:*:1-29f::1-29, Roof Deck Securement and Above-Deck Roofing  Components
:*:1-30f::1-30, Repair of Wind Damaged Roof Systems
:*:1-31f::1-31, Panel Roof Systems
:*:1-32f::1-32, Inspection and Maintenance of Roof Assemblies
:*:1-33f::1-33, Safeguarding Torch - Applied Roof Installations
:*:1-34f::1-34, Hail Damage
:*:1-35f::1-35, Vegetative Roof Systems Vegetative Roof Systems, Occupied Roof Areas & Decks 
:*:1-36f::1-36, Mass Engineered Timber
:*:1-37f::1-37, Hospitals 
:*:1-40f::1-40, Flood
:*:1-41f::1-41, Dam Evaluations
:*:1-42f::1-42, MFL Limiting Factors 
:*:1-44f::1-44, Damage-Limiting Construction
:*:1-45f::1-45, Air Conditioning and Ventilating Systems
:*:1-49f::1-49, Perimeter Flashing
:*:1-52f::1-52, Field  Verification of Roof Wind Uplift Resistance
:*:1-53f::1-53, Anechoic Chambers
:*:1-54f::1-54, Roof Loads and Drainage
:*:1-55f::1-55, Weak Construction and Design
:*:1-56f::1-56, Cleanrooms
:*:1-57f::1-57, Plastics in Construction
:*:1-59f::1-59, Fabric and Membrane Covered Structures
:*:1-60f::1-60, Asphalt-Coated/Protected Metal Buildings
:*:1-61f::1-61, Impregnated Fire-Retardant Lumber
:*:1-62f::1-62, Cranes
:*:1-63f::1-63, Exterior Insulation and Finish Systems
:*:1-64f::1-64, Exterior Walls and Facades
:*:2-0f::2-0, Installation Guidelines for Automatic Sprinklers
:*:2-1f::2-1, Corrosion in Automatic Sprinkler Systems
:*:2-8f::2-8, Earthquake Protection for Water-Based Fire Protection Systems
:*:2-81f::2-81, Fire Safety Inspections and Sprinkler System Maintenance
:*:2-89f::2-89, Pipe Friction Loss Tables
:*:3-0f::3-0, Hydraulics of Fire Protection Systems
:*:3-1f::3-1, Tanks and Reservoirs for Interconnected Fire Service and Public Mains
:*:3-2f::3-2, Water Tanks for Fire Protection
:*:3-3f::3-3, Cross Connections
:*:3-4f::3-4, Embankment-Supported Fabric Tanks
:*:3-6f::3-6, Lined Earth Reservoirs for Fire Protection
:*:3-7f::3-7, Fire Protection Pump
:*:3-10f::3-10, Installation/Maintenance of  Fire Service Mains
:*:3-11f::3-11, Flow and Pressure Regulating Devices for Fire Protection Service
:*:3-26f::3-26, Fire Protection Water Demand for Nonstorage Sprinklered Properties
:*:3-29f::3-29, Reliability of Fire Protection Water Supplies
:*:4-0f::4-0, Special Protection Systems
:*:4-1Nf::4-1N, Fixed Water Spray Systems for Fire Protection
:*:4-2f::4-2, Water Mist Systems
:*:4-3Nf::4-3N, Medium and High Expansion Foam Systems
:*:4-4Nf::4-4N, Standpipe and Hose Systems
:*:4-5f::4-5, Portable Extinguishers
:*:4-6f::4-6, Hybrid Fire Extinguishing Systems
:*:4-8Nf::4-8N, Halon 1301 Extinguishing Systems
:*:4-9f::4-9, Halocarbon and Inert Gas (Clean Agent) Fire Extinguishing Systems
:*:4-10f::4-10, Dry Chemical Systems
:*:4-11Nf::4-11N, Carbon Dioxide Extinguishing Systems (NFPA)
:*:4-12f::4-12, Foam Water Extinguishing  Systems
:*:4-13f::4-13, Oxygen Reduction Systems
:*:5-1f::5-1, Electrical Equipment in Hazardous (Classified) Locations
:*:5-3f::5-3, Hydroelectric Power Plants
:*:5-4f::5-4, Transformers
:*:5-8f::5-8, Static Electricity
:*:5-11f::5-11, Lightning and Surge Protection for Electrical Systems
:*:5-12f::5-12, Electric AC Generators
:*:5-14f::5-14, Telecommunications
:*:5-17f::5-17, Motors & Adjustable Speed Drives
:*:5-18f::5-18, Protection of Electrical Equipment
:*:5-19f::
Send 5-19,{Space} 
os_title_full:= "Switchgear and Circuit Breakers"
send_os_title(os_title_full)
;send_italic("Switchgear and Circuit Breakers")
;str_in = Switchgear and Circuit Breakers
;Send ^!v
:*:5-20f::5-20, Electrical Testing
:*:5-21f::5-21, Metal Halide High-Intensity Discharge Lighting
:*:5-23f::5-23, Design and Fire Protection for Emergency and Standby Power Systems
:*:5-24f::5-24, Miscellaneous Electrical Equipment
:*:5-25f::5-25, High Voltage Direct Current Converter  Stations
:*:5-28f::5-28, DC Battery Systems
:*:5-30f::5-30, Power Factor Correction and Static Reactive Compensator Systems
:*:5-31f::5-31, Cables and Bus Bars
:*:5-32f::5-32, Data Centers and Related Facilities
:*:5-33f::5-33, Electrical Energy Storage Systems 
:*:5-40f::5-40, Fire Alarm Systems
:*:5-48f::5-48, Automatic Fire Detection
:*:5-49f::5-49, Gas and Vapor Detectors and Analysis Systems
:*:6-0f::6-0, Elements of Industrial Heating Equipment
:*:6-2f::6-2, Pulverized Coal Fired  Boilers
:*:6-3f::6-3, Induction and Dielectric Heating Equipment
:*:6-4f::6-4, Oil- and Gas-Fired Single-Burner Boilers
:*:6-5f::6-5, Oil- or Gas-Fired Multiple Burner Boilers
:*:6-6f::6-6, Boiler-Furnaces Implosions
:*:6-7f::6-7, Fluidized Bed Combustors
:*:6-8f::6-8, Combustion Air Heaters
:*:6-9f::6-9, Industrial Ovens and Dryers
:*:6-10f::6-10, Process Furnaces
:*:6-11f::6-11, Thermal and Regenerative Catalytic Oxidizers
:*:6-12f::6-12, Low-Water Protection
:*:6-13f::6-13, Waste Fuel Fired Facilities
:*:6-14f::6-14, Waste Heat Boilers
:*:6-17f::6-17, Rotary Kilns and Dryers
:*:6-21f::6-21, Chemical Recovery Boilers
:*:6-22f::6-22, Firetube Boilers
:*:6-23f::6-23, Watertube Boilers
:*:7-0f::7-0, Causes and Effects of Fires and Explosions
:*:7-1f::7-1, Fire Protection for Textile Mills
:*:7-2f::7-2, Waste Solvent Recovery
:*:7-3f::7-3, Flight Simulator System Protection
:*:7-4f::7-4, Paper Machines and Pulp Dryers
:*:7-6f::7-6, Heated Plastic and Plastic-Lined Tanks
:*:7-7f::7-7, Semiconductor Fabrication Facilities
:*:7-9f::7-9, Dip Tanks, Flow Coaters and Roll Coaters
:*:7-10f::7-10, Wood Processing and Woodworking Facilities
:*:7-11f::7-11, Belt Conveyors
:*:7-12f::7-12, Mining and Mineral Processing
:*:7-13f::7-13, Mechanical Refrigeration
:*:7-14f::7-14, Fire Protection for Chemical Plants
:*:7-15f::7-15, Garages
:*:7-17f::7-17, Explosion Suppression Systems
:*:7-19Nf::7-19N, Fire Hazard Properties of Flammable Liquids, Gases, and Volatile Solids
:*:7-20f::7-20, Oil Cookers
:*:7-21f::7-21, Rolling Mills
:*:7-22f::7-22, Hydrazine and its Derivatives
:*:7-23f::7-23, Data on General Class of Chemicals
:*:7-23Nf::7-23N, Hazardous Chemicals Data
:*:7-24f::7-24, Blowing Agents
:*:7-25f::7-25, Molten Steel Production
:*:7-26f::7-26, Glass Manufacturing
:*:7-27f::7-27, Spray Application of Ignitable and Combustible Materials
:*:7-28f::7-28, Energetic Materials
:*:7-29f::7-29, Ignitable Liquid Storage in Portable Containers
:*:7-31f::7-31, Storage of Aerosol Products
:*:7-32f::7-32, Ignitable Liquid Operations
:*:7-33f::7-33, High-Temperature Molten Materials
:*:7-35f::7-35, Air Separation Processes
:*:7-36f::7-36, Pharmaceutical Operations
:*:7-37f::7-37, Cutting Fluids
:*:7-39f::7-39, Industrial Trucks
:*:7-40f::7-40, Heavy Duty Mobile Equipment
:*:7-41f::7-41, Heat Treating of Materials Using Oil Quenching and Molten Salt Baths
:*:7-42f::7-42, Vapor Cloud Explosions
:*:7-43f::7-43, Process Safety
:*:7-45f::7-45, Instrumentation and Control in Safety Applications
:*:7-46f::7-46, Chemical Reactors and Reactions
:*:7-49f::7-49, Emergency Venting of Vessels
:*:7-50f::7-50, Compressed Gases in Cylinders
:*:7-51f::7-51, Acetylene
:*:7-53f::7-53, Liquefied Natural Gas (LNG)
:*:7-54f::7-54, Natural Gas and Gas Piping
:*:7-55f::7-55, Liquefied Petroleum Gas
:*:7-58f::7-58, Chlorine Dioxide
:*:7-59f::7-59, Inerting and Purging of Vessels and Equipment
:*:7-61f::7-61, Facilities Processing Radioactive Materials
:*:7-64f::7-64, Aluminum Industries
:*:7-72f::7-72, Reformer and Cracking Furnace
:*:7-73f::7-73, Dust Collectors and Collection Systems
:*:7-74f::7-74, Distilleries
:*:7-75f::7-75, Grain Storage and Milling
:*:7-76f::7-76, Prevention and Mitigation of Combustible Dust Explosions and Fires
:*:7-77f::7-77, Testing Internal Combustion Engines and Accessories
:*:7-78f::7-78, Industrial Exhaust Systems
:*:7-79f::7-79, Fire Protection for Gas Turbine and Electric Generators
:*:7-80f::7-80, Organic Peroxides
:*:7-83f::7-83, Drainage Systems for Ignitable Liquids
:*:7-85f::7-85, Combustible and Reactive Metals
:*:7-86f::7-86, Cellulose Nitrate
:*:7-88f::7-88, Outdoor Ignitable Storage Tanks
:*:7-89f::7-89, Ammonium Nitrate and Mixed Fertilizers Containing Ammonium Nitrate
:*:7-91f::7-91, Hydrogen
:*:7-92f::7-92, Ethylene Oxide
:*:7-93f::7-93, Aircraft Hangars, Aircraft Manufacturing / Assembly Facilities and Protection of Aircraft Interior During Assembly
:*:7-95f::7-95, Compressors
:*:7-96f::7-96, Printing Plants
:*:7-97f::7-97, Metal Cleaning
:*:7-98f::7-98, Hydraulic Fluids
:*:7-99f::7-99, Heat Transfer Fluid Systems
:*:7-101f::7-101, Fire Protection for Steam Turbines and Electric Generators
:*:7-103f::7-103, Turpentine Recovery in Pulp and Paper Mills
:*:7-104f::7-104, Metal Treatment Processes for Steel Mills
:*:7-105f::7-105, Concentrating Solar Power
:*:7-106f::7-106, Ground Mounted Photovoltaic Solar Power
:*:7-107f::7-107, Natural Gas Transmission and Storage
:*:7-108f::7-108, Silane
:*:7-109f::7-109, Fuel Fired Thermal Electric Power Generation Facilities
:*:7-110f::7-110, Industrial Control Systems 
:*:7-111f::7-111, Chemical Process Industries 
:*:7-111Af::7-111A, Fuel-Grade Ethanol 
:*:7-111Bf::7-111B, Carbon Black 
:*:7-111Cf::7-111C, Titanium Dioxide
:*:7-111Df::7-111D, Oilseed Processing 
:*:7-111Ef::7-111E, Chloro-Alkali 
:*:7-111Ff::7-111F, Sulfuric Acid 
:*:7-111Gf::7-111G, Ammonia and Ammonia Derivatives 
:*:7-111Hf::7-111H, Olefins
:*:7-111If::7-111I, Ink, Paint and Coating Formulations
:*:8-1f::8-1, Commodity Classification
:*:8-3f::8-3, Rubber Tire Storage
:*:8-7f::8-7, Baled Fiber Storage
:*:8-9f::8-9, Storage of Class 1, 2, 3, 4 and Plastic Commodities
:*:8-10f::8-10, Coal and Charcoal Storage
:*:8-18f::8-18, Storage of Hanging Garments
:*:8-21f::8-21, Roll Paper Storage
:*:8-22f::8-22, Storage of Baled Waste Paper
:*:8-23f::8-23, Rolled Nonwoven Fabric Storage
:*:8-24f::8-24, Idle Pallet Storage
:*:8-27f::8-27, Storage of Wood Chips
:*:8-28f::8-28, Pulpwood and Outdoor Log Storage
:*:8-30f::8-30, Storage of Carpets
:*:8-33f::8-33, Carousel Storage and Retrieval Systems
:*:8-34f::8-34, Protection for Automatic Storage and Retrieval Systems
:*:9-0f::9-0, Asset Integrity
:*:9-1f::9-1, Supervision of Property
:*:9-16f::9-16, Burglary and Theft
:*:9-18f::9-18, Prevention of Freeze-ups
:*:9-19f::9-19, Wildland Fire
:*:10-0f::10-0, The Human Factor of Property Conservation
:*:10-1f::10-1, Pre-Incident Planning with the Public Fire Service
:*:10-3f::10-3, Hot Work Management
:*:10-4f::10-4, Contractor Management
:*:10-5f::10-5, Disaster Recovery and Contingency Plan
:*:10-6f::10-6, Protection Against Arson and Other Incendiary Fires
:*:10-7f::10-7, Fire Protection Impairment Management
:*:10-8f::10-8, Operators
:*:12-2f::12-2, Vessels & Piping
:*:12-3f::12-3, Continuous Digesters & Related Vessels
:*:12-6f::12-6, Batch Digesters & Related Vessels
:*:12-43f::12-43, Pressure Relief Devices
:*:12-53f::12-53, Absorption Refrigeration Systems
:*:13-1f::13-1, Cold Mechanical Repairs
:*:13-2f::13-2, Hydroelectric Power Plants
:*:13-3f::13-3, Steam Turbines
:*:13-6f::13-6, Flywheels and Pulleys
:*:13-7f::13-7, Gears
:*:13-8f::13-8, Power Presses
:*:13-10f::13-10, Wind Turbines and Farms
:*:13-17f::13-17, Gas Turbines
:*:13-18f::13-18, Industrial Clutches and Clutch Couplings
:*:13-24f::13-24, Fans and Blowers
:*:13-26f::13-26, Internal Combustion Engines
:*:13-27f::13-27, Heavy Duty Mobile Equipment
:*:13-28f::13-28, Aluminum Industries
:*:17-0f::17-0, Asset Integrity
:*:17-2f::17-2, Process Safety
:*:17-4f::17-4, Monitoring and Diagnosis of Vibration in Rotating Machinery
:*:17-11f::17-11, Chemical Reactors and Reactions
:*:17-12f::17-12, Semiconductor Fabrication Facilities
:*:17-16f::17-16, Cranes