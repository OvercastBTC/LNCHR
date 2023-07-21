;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; ; #Warn  ; Enable warnings to assist with detecting common errors.
;SetWinDelay 0 ; ..... (AJB - 06/2023) - comment out for testing
;SetControlDelay 0 ; . (AJB - 06/2023) - comment out for testing
;SetBatchLines, 0 ; .. (AJB - 06/2023)  - comment out for testing
;SetWinDelay, -1 ; ... (AJB - 06/2023) re-enabled 06.15.23 
;SetControlDelay, -1 ; (AJB - 06/2023) re-enabled 06.15.23 
;SetBatchLines, -1 ; . (AJB - 06/2023) re-enabled 06.15.23
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
;#Persistent ; Keeps script permanently running
;#SingleInstance,Force
;#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
;DetectHiddenText,On
;DetectHiddenWindows, On
;#Requires AutoHotkey 1.1+
;#NoTrayIcon
; ----------------------------------------------------------------------------------------------------------------------
; .............: End Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


; ----------------------------------------------------------------------------------------------------------------------
; Name .........: Common_Abbrevations
; Section ......: CHANGELOG
; Description ..: This is a hotstring library to call the MakeOSItalic() function [located in personal Lib folder]
; AHK Version ..: AHK 1.1+ x32/64 Unicode
; Author .......: Overcast (Adam Bacon), and Terry Keatts
; License ......: WTFPL - http://www.wtfpl.net/txt/copying/
; Changelog ....: 2/24/2023 ..: v1.0 - First version. 
; ..............: Status: Published
; ..............: Notes: Modified to correct a few standard titles and add the "densityf" hotstring with input for the varibles.
; ..............: Also modified to break this script out into a sub-script to make maintenance easier for users, so they
; ..............: are not forced to update the starter script with all the personal information, which likely won't change
; ..............: as much as the sub-scripts.
; ..............: 
; ..............: 03/06/2023 ..: v2.0 
; ..............: Status: Published
; ..............: Notes: Added the Shift+Ctrl+WIN+O hot key for fast launch of a specific OS.
; ..............: 
; ..............: 03/07/2023 ..: v3.0 
; ..............: Status: Published
; ..............: Notes: OS Titles now input in italics except for Horizon.
; ..............: 
; ..............: ??? .........: v?.?
; ..............: Status: Published
; ..............: Notes: OS Titles now input in italics for Horizon.
; ..............: 
; ..............: 04/11/2023 ..: v3.1 
; ..............: Status: Published
; ..............: Notes: Updated OS 10-1 title. Improved fast launch of OS GUI.
; ..............: 
; ..............: 04/27/2023 ..: v3.2 
; ..............: Status: Published
; ..............: Notes: Updated OS 7-11 title.
; ..............: 
; ..............: 05/03/2023 ..: v3.3 
; ..............: Status: Published
; ..............: Notes: Added case specific hot string areas to reduce rework on strange cases.
; ..............: 
; ..............: 05/30/2023 ..: v3.4 
; ..............: Status: Published
; ..............: Notes: Changed "sgsv" to "sgsvf" based on user feedback. Added "degf" for addeding a degree symbol.
; ..............: Notes: Added "degf" for addeding a degree symbol..
; ..............: 
; ..............: 05/31/2023 ..: v4.0 
; ..............: Status: Un-Published, Pending review by Terry Keatts
; ..............: Notes: Added #Hotstring C1 O B0
; ..............: Notes: #Hotstring EndChars f ; ===> the "f" can be modified to whatever you chose <===
; ..............: Cont.: ===> TODO <=== Make this an initial input for the user to choose. Currently set to existing "f"
; ..............: Notes: Added SendLevel 1 - this is to ensure that a hotstring can call another hotstring and/or hotkey
; ..............: Notes: All OS numbers and titles transferred to OSTitle.ini
; ..............: Notes: Modified hotstring modifier from :*:#-##:: to ::#-##:: => "*" = ending character not required.  
; ..............: Cont.: Added B0 to remove any backspacing (e.g., replacement previously used by ":*:")
; ..............: Notes: Removed "f" from end of hotstring (see above) => ::1-0f:: to ::1-0::
; ..............: Notes: See MakeOSItalic.ahk for additional details.
; ..............: Notes: Used this regex to update =>>> MakeOSItalic\("[0-9].*-[0-9].*, [a-z].*[A-Z].*+
; ..............: 
; ..............: 06/01/2023 ..: v5.0 
; ..............: Status: Un-Published, Pending review by Terry Keatts
; ..............: Notes: Used this regex to update =>>> MakeOSItalic\([A-z].*+\nreturn
; ..............: 
; ..............: 00/00/0000 ..: v0.0 
; ..............: Status: 
; ..............: Notes: 
; ********************************************** ... First Return ... **************************************************
;return
; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; .............: Begin Section
; Section .....: Functions
; Function ....: Run() script function and scripts
; ----------------------------------------------------------------------------------------------------------------------
:*:1-0f::
SendLevel 1
SetKeyDelay, 100, 0
Send % "1-0," A_Space . "^{i}" . "Safeguards During Construction, Alteration and Demolition" . "^{i}" . A_Space
return
:*:1-1f::
SendLevel 1
Send % "1-1," A_Space "^{i}Firesafe Building Construction and Materials^{i}" A_Space
return
:*:1-2f::
SendLevel 1
Send % "1-2," A_Space "^{i}Earthquakes^{i}" A_Space
return
:*:1-3f::
SendLevel 1
Send % "1-3," A_Space "^{i}High-Rise Buildings^{i}" A_Space
return
:*:1-4f::
SendLevel 1
Send % "1-4," A_Space "^{i}Fire Tests^{i}" A_Space
return
:*:1-6f::
SendLevel 1
Send % "1-6," A_Space "^{i}Cooling Towers^{i}" A_Space
return
:*:1-8f::
SendLevel 1
Send % "1-8," A_Space "^{i}Antenna Towers and Signs^{i}" A_Space
return
:*:1-9f::
SendLevel 1
Send % "1-9," A_Space "^{i}Roof Anchorage for Older, Wood-Roofed Buildings^{i}" A_Space
return
:*:1-10f::
SendLevel 1
Send % "1-10," A_Space "^{i}Smoke and Heat Venting in Sprinklered Buildings^{i}" A_Space
return
:*:1-11f::
SendLevel 1
Send % "1-11," A_Space "^{i}Fire Following Earthquakes^{i}" A_Space
return
:*:1-12f::
SendLevel 1
Send % "1-12," A_Space "^{i}Ceilings and Concealed Spaces^{i}" A_Space
return
:*:1-13f::
SendLevel 1
Send % "1-13," A_Space "^{i}Chimneys^{i}" A_Space
return
:*:1-15f::
SendLevel 1
Send % "1-15," A_Space "^{i}Roof Mounted Solar Photovoltaic Panels^{i}" A_Space
return
:*:1-17f::
SendLevel 1
Send % "1-17," A_Space "^{i}Reflective Ceiling Insulation^{i}" A_Space
return
:*:1-20f::
SendLevel 1
Send % "1-20," . A_Space . "^{i}" . "Protection Against Exterior Fire Exposure" . "^{i}" A_Space
return
:*:1-21f::
SendLevel 1
Send % "1-21," . A_Space "^{i}" . "Fire Resistance of Building Assemblies" . "^{i}" . A_Space
return
:*:1-22f::
SendLevel 1
Send % "1-22, " . "^{i}" . "Maximum Foreseeable Loss" . "^{i}" . A_Space
return
:*:1-24f::
SendLevel 1
Send % "1-24," A_Space "^{i}Protection Against Liquid Damage^{i}" A_Space
return
:*:1-26f::
SendLevel 1
Send % "1-26," A_Space "^{i}Steep-Slope Roof Systems^{i}" A_Space
return
:*:1-27f::
SendLevel 1
Send % "1-27," A_Space "^{i}Windstorm  Retrofit and Loss Expectancy (LE) Guidelines^{i}" A_Space
return
:*:1-28f::
SendLevel 1
Send % "1-28," A_Space "^{i}Wind Design^{i}" A_Space
return
:*:1-29f::
SendLevel 1
Send % "1-29," A_Space "^{i}Roof Deck Securement and Above-Deck Roofing  Components^{i}" A_Space
return
:*:1-30f::
SendLevel 1
Send % "1-30," A_Space "^{i}Repair of Wind Damaged Roof Systems^{i}" A_Space
return
:*:1-31f::
SendLevel 1
Send % "1-31," A_Space "^{i}Panel Roof Systems^{i}" A_Space
return
:*:1-32f::
SendLevel 1
Send % "1-32," A_Space "^{i}Inspection and Maintenance of Roof Assemblies^{i}" A_Space
return
:*:1-33f::
SendLevel 1
Send % "1-33," A_Space "^{i}Safeguarding Torch - Applied Roof Installations^{i}" A_Space
return
:*:1-34f::
SendLevel 1
Send % "1-34," A_Space "^{i}Hail Damage^{i}" A_Space
return
:*:1-35f::
SendLevel 1
Send % "1-35, " . "^{i}" . "Vegetative Roof Systems Vegetative Roof Systems, Occupied Roof Areas & Decks" . "^{i} "
return
:*:1-36f::
SendLevel 1
Send % "1-36," A_Space "^{i}Mass Engineered Timber^{i}" A_Space
return
:*:1-37f::
SendLevel 1
Send % "1-37," A_Space "^{i}Hospitals ^{i}" A_Space
return
:*:1-40f::
SendLevel 1
Send % "1-40," A_Space "^{i}Flood^{i}" A_Space
return
:*:1-41f::
SendLevel 1
Send % "1-41," A_Space "^{i}Dam Evaluations^{i}" A_Space
return
:*:1-42f::
SendLevel 1
Send % "1-42," A_Space "^{i}MFL Limiting Factors ^{i}" A_Space
return
:*:1-44f::
SendLevel 1
Send % "1-44," A_Space "^{i}Damage-Limiting Construction^{i}" A_Space
return
:*:1-45f::
SendLevel 1
Send % "1-45," A_Space "^{i}Air Conditioning and Ventilating Systems^{i}" A_Space
return
:*:1-49f::
SendLevel 1
Send % "1-49," A_Space "^{i}Perimeter Flashing^{i}" A_Space
return
:*:1-52f::
SendLevel 1
Send % "1-52," A_Space "^{i}Field  Verification of Roof Wind Uplift Resistance^{i}" A_Space
return
:*:1-53f::
SendLevel 1
Send % "1-53," A_Space "^{i}Anechoic Chambers^{i}" A_Space
return
:*:1-54f::
SendLevel 1
Send % "1-54," A_Space "^{i}Roof Loads and Drainage^{i}" A_Space
return
:*:1-55f::
SendLevel 1
Send % "1-55," A_Space "^{i}Weak Construction and Design^{i}" A_Space
return
:*:1-56f::
SendLevel 1
Send % "1-56," A_Space "^{i}Cleanrooms^{i}" A_Space
return
:*:1-57f::
SendLevel 1
Send % "1-57," A_Space "^{i}Plastics in Construction^{i}" A_Space
return
:*:1-59f::
SendLevel 1
Send % "1-59," A_Space "^{i}Fabric and Membrane Covered Structures^{i}" A_Space
return
:*:1-60f::
SendLevel 1
Send % "1-60," A_Space "^{i}Asphalt-Coated/Protected Metal Buildings^{i}" A_Space
return
:*:1-61f::
SendLevel 1
Send % "1-61," A_Space "^{i}Impregnated Fire-Retardant Lumber^{i}" A_Space
return
:*:1-62f::
SendLevel 1
Send % "1-62," A_Space "^{i}Cranes^{i}" A_Space
return
:*:1-63f::
SendLevel 1
Send % "1-63," A_Space "^{i}Exterior Insulation and Finish Systems^{i}" A_Space
return
:*:1-64f::
SendLevel 1
Send % "1-64," A_Space "^{i}Exterior Walls and Facades^{i}" A_Space
return
:*:2-0f::
SendLevel 1
Send % "2-0," A_Space "^{i}Installation Guidelines for Automatic Sprinklers^{i}" A_Space
return
:*:2-1f::
SendLevel 1
Send % "2-1," A_Space "^{i}Corrosion in Automatic Sprinkler Systems^{i}" A_Space
return
:*:2-8f::
SendLevel 1
Send % "2-8," A_Space "^{i}Earthquake Protection for Water-Based Fire Protection Systems^{i}" A_Space
return
:*:2-81f::
SendLevel 1
Send % "2-81," A_Space "^{i}Fire Safety Inspections and Sprinkler System Maintenance^{i}" A_Space
return
:*:2-89f::
SendLevel 1
Send % "2-89," A_Space "^{i}Pipe Friction Loss Tables^{i}" A_Space
return
:*:3-0f::
SendLevel 1
Send % "3-0," A_Space "^{i}Hydraulics of Fire Protection Systems^{i}" A_Space
return
:*:3-1f::
SendLevel 1
Send % "3-1," A_Space "^{i}Tanks and Reservoirs for Interconnected Fire Service and Public Mains^{i}" A_Space
return
:*:3-2f::
SendLevel 1
Send % "3-2," A_Space "^{i}Water Tanks for Fire Protection^{i}" A_Space
return
:*:3-3f::
SendLevel 1
Send % "3-3," A_Space "^{i}Cross Connections^{i}" A_Space
return
:*:3-4f::
SendLevel 1
Send % "3-4," A_Space "^{i}Embankment-Supported Fabric Tanks^{i}" A_Space
return
:*:3-6f::
SendLevel 1
Send % "3-6," A_Space "^{i}Lined Earth Reservoirs for Fire Protection^{i}" A_Space
return
:*:3-7f::
SendLevel 1
Send % "3-7," A_Space "^{i}Fire Protection Pump^{i}" A_Space
return
:*:3-10f::
SendLevel 1
Send % "3-10," A_Space "^{i}Installation/Maintenance of  Fire Service Mains^{i}" A_Space
return
:*:3-11f::
SendLevel 1
Send % "3-11," A_Space "^{i}Flow and Pressure Regulating Devices for Fire Protection Service^{i}" A_Space
return
:*:3-26f::
SendLevel 1
Send % "3-26," A_Space "^{i}Fire Protection Water Demand for Nonstorage Sprinklered Properties^{i}" A_Space
return
:*:3-29f::
SendLevel 1
Send % "3-29," A_Space "^{i}Reliability of Fire Protection Water Supplies^{i}" A_Space
return
:*:4-0f::
SendLevel 1
Send % "4-0," A_Space "^{i}Special Protection Systems^{i}" A_Space
return
:*:4-1Nf::
SendLevel 1
Send % "4-1N," A_Space "^{i}Fixed Water Spray Systems for Fire Protection^{i}" A_Space
return
:*:4-2f::
SendLevel 1
Send % "4-2," A_Space "^{i}Water Mist Systems^{i}" A_Space
return
:*:4-3Nf::
SendLevel 1
Send % "4-3N," A_Space "^{i}Medium and High Expansion Foam Systems^{i}" A_Space
return
:*:4-4Nf::
SendLevel 1
Send % "4-4N," A_Space "^{i}Standpipe and Hose Systems^{i}" A_Space
return
:*:4-5f::
SendLevel 1
Send % "4-5," A_Space "^{i}Portable Extinguishers^{i}" A_Space
return
:*:4-6f::
SendLevel 1
Send % "4-6," A_Space "^{i}Hybrid Fire Extinguishing Systems^{i}" A_Space
return
:*:4-8Nf::
SendLevel 1
Send % "4-8N," A_Space "^{i}Halon 1301 Extinguishing Systems^{i}" A_Space
return
:*:4-9f::
SendLevel 1
Send % "4-9," A_Space "^{i}Halocarbon and Inert Gas (Clean Agent) Fire Extinguishing Systems^{i}" A_Space
return
:*:4-10f::
SendLevel 1
Send % "4-10," A_Space "^{i}Dry Chemical Systems^{i}" A_Space
return
:*:4-11Nf::
SendLevel 1
Send % "4-11N," A_Space "^{i}Carbon Dioxide Extinguishing Systems (NFPA)^{i}" A_Space
return
:*:4-12f::
SendLevel 1
Send % "4-12," A_Space "^{i}Foam Water Extinguishing  Systems^{i}" A_Space
return
:*:4-13f::
SendLevel 1
Send % "4-13," A_Space "^{i}Oxygen Reduction Systems^{i}" A_Space
return
:*:5-1f::
SendLevel 1
Send % "5-1," A_Space "^{i}Electrical Equipment in Hazardous (Classified) Locations^{i}" A_Space
return
:*:5-3f::
SendLevel 1
Send % "5-3," A_Space "^{i}Hydroelectric Power Plants^{i}" A_Space
return
:*:5-4f::
SendLevel 1
Send % "5-4," A_Space "^{i}Transformers^{i}" A_Space
return
:*:5-8f::
SendLevel 1
Send % "5-8," A_Space "^{i}Static Electricity^{i}" A_Space
return
:*:5-11f::
SendLevel 1
Send % "5-11," A_Space "^{i}Lightning and Surge Protection for Electrical Systems^{i}" A_Space
return
:*:5-12f::
SendLevel 1
Send % "5-12," A_Space "^{i}Electric AC Generators^{i}" A_Space
return
:*:5-14f::
SendLevel 1
Send % "5-14," A_Space "^{i}Telecommunications^{i}" A_Space
return
:*:5-17f::
SendLevel 1
Send % "5-17," A_Space "^{i}Motors & Adjustable Speed Drives^{i}" A_Space
return
:*:5-18f::
SendLevel 1
Send % "5-18," A_Space "^{i}Protection of Electrical Equipment^{i}" A_Space
return
:*:5-19f::
SendLevel 1
Send % "5-19," . "^{i}" . "Switchgear and Circuit Breakers" . "^{i}" . A_Space
return
:*:5-20f::
SendLevel 1
Send % "5-20," A_Space "^{i}Electrical Testing^{i}" A_Space
return
:*:5-21f::
SendLevel 1
Send % "5-21," A_Space "^{i}Metal Halide High-Intensity Discharge Lighting^{i}" A_Space
return
:*:5-23f::
SendLevel 1
Send % "5-23," A_Space "^{i}Design and Fire Protection for Emergency and Standby Power Systems^{i}" A_Space
return
:*:5-24f::
SendLevel 1
Send % "5-24," A_Space "^{i}Miscellaneous Electrical Equipment^{i}" A_Space
return
:*:5-25f::
SendLevel 1
Send % "5-25," A_Space "^{i}High Voltage Direct Current Converter  Stations^{i}" A_Space
return
:*:5-28f::
SendLevel 1
Send % "5-28," A_Space "^{i}DC Battery Systems^{i}" A_Space
return
:*:5-30f::
SendLevel 1
Send % "5-30," A_Space "^{i}Power Factor Correction and Static Reactive Compensator Systems^{i}" A_Space
return
:*:5-31f::
SendLevel 1
Send % "5-31," A_Space "^{i}Cables and Bus Bars^{i}" A_Space
return
:*:5-32f::
SendLevel 1
Send % "5-32," A_Space "^{i}Data Centers and Related Facilities^{i}" A_Space
return
:*:5-33f::
SendLevel 1
Send % "5-33," A_Space "^{i}Electrical Energy Storage Systems ^{i}" A_Space
return
:*:5-40f::
SendLevel 1
Send % "5-40," A_Space "^{i}Fire Alarm Systems^{i}" A_Space
return
:*:5-48f::
SendLevel 1
Send % "5-48," A_Space "^{i}Automatic Fire Detection^{i}" A_Space
return
:*:5-49f::
SendLevel 1
Send % "5-49," A_Space "^{i}Gas and Vapor Detectors and Analysis Systems^{i}" A_Space
return
:*:6-0f::
SendLevel 1
Send % "6-0," A_Space "^{i}Elements of Industrial Heating Equipment^{i}" A_Space
return
:*:6-2f::
SendLevel 1
Send % "6-2," A_Space "^{i}Pulverized Coal Fired  Boilers^{i}" A_Space
return
:*:6-3f::
SendLevel 1
Send % "6-3," A_Space "^{i}Induction and Dielectric Heating Equipment^{i}" A_Space
return
:*:6-4f::
SendLevel 1
Send % "6-4," A_Space "^{i}Oil- and Gas-Fired Single-Burner Boilers^{i}" A_Space
return
:*:6-5f::
SendLevel 1
Send % "6-5," A_Space "^{i}Oil- or Gas-Fired Multiple Burner Boilers^{i}" A_Space
return
:*:6-6f::
SendLevel 1
Send % "6-6," A_Space "^{i}Boiler-Furnaces Implosions^{i}" A_Space
return
:*:6-7f::
SendLevel 1
Send % "6-7," A_Space "^{i}Fluidized Bed Combustors^{i}" A_Space
return
:*:6-8f::
SendLevel 1
Send % "6-8," A_Space "^{i}Combustion Air Heaters^{i}" A_Space
return
:*:6-9f::
SendLevel 1
Send % "6-9," A_Space "^{i}Industrial Ovens and Dryers^{i}" A_Space
return
:*:6-10f::
SendLevel 1
Send % "6-10," A_Space "^{i}Process Furnaces^{i}" A_Space
return
:*:6-11f::
SendLevel 1
Send % "6-11," A_Space "^{i}Thermal and Regenerative Catalytic Oxidizers^{i}" A_Space
return
:*:6-12f::
SendLevel 1
Send % "6-12," A_Space "^{i}Low-Water Protection^{i}" A_Space
return
:*:6-13f::
SendLevel 1
Send % "6-13," A_Space "^{i}Waste Fuel Fired Facilities^{i}" A_Space
return
:*:6-14f::
SendLevel 1
Send % "6-14," A_Space "^{i}Waste Heat Boilers^{i}" A_Space
return
:*:6-17f::
SendLevel 1
Send % "6-17," A_Space "^{i}Rotary Kilns and Dryers^{i}" A_Space
return
:*:6-21f::
SendLevel 1
Send % "6-21," A_Space "^{i}Chemical Recovery Boilers^{i}" A_Space
return
:*:6-22f::
SendLevel 1
Send % "6-22," A_Space "^{i}Firetube Boilers^{i}" A_Space
return
:*:6-23f::
SendLevel 1
Send % "6-23," A_Space "^{i}Watertube Boilers^{i}" A_Space
return
:*:7-0f::
SendLevel 1
Send % "7-0," A_Space "^{i}Causes and Effects of Fires and Explosions^{i}" A_Space
return
:*:7-1f::
SendLevel 1
Send % "7-1," A_Space "^{i}Fire Protection for Textile Mills^{i}" A_Space
return
:*:7-2f::
SendLevel 1
Send % "7-2," A_Space "^{i}Waste Solvent Recovery^{i}" A_Space
return
:*:7-3f::
SendLevel 1
Send % "7-3," A_Space "^{i}Flight Simulator System Protection^{i}" A_Space
return
:*:7-4f::
SendLevel 1
Send % "7-4," A_Space "^{i}Paper Machines and Pulp Dryers^{i}" A_Space
return
:*:7-6f::
SendLevel 1
Send % "7-6," A_Space "^{i}Heated Plastic and Plastic-Lined Tanks^{i}" A_Space
return
:*:7-7f::
SendLevel 1
Send % "7-7," A_Space "^{i}Semiconductor Fabrication Facilities^{i}" A_Space
return
:*:7-9f::
SendLevel 1
Send % "7-9," A_Space "^{i}Dip Tanks, Flow Coaters and Roll Coaters^{i}" A_Space
return
:*:7-10f::
SendLevel 1
Send % "7-10," A_Space "^{i}Wood Processing and Woodworking Facilities^{i}" A_Space
return
:*:7-11f::
SendLevel 1
Send % "7-11," A_Space "^{i}Belt Conveyors^{i}" A_Space
return
:*:7-12f::
SendLevel 1
Send % "7-12," A_Space "^{i}Mining and Mineral Processing^{i}" A_Space
return
:*:7-13f::
SendLevel 1
Send % "7-13," A_Space "^{i}Mechanical Refrigeration^{i}" A_Space
return
:*:7-14f::
SendLevel 1
Send % "7-14," A_Space "^{i}Fire Protection for Chemical Plants^{i}" A_Space
return
:*:7-15f::
SendLevel 1
Send % "7-15," A_Space "^{i}Garages^{i}" A_Space
return
:*:7-17f::
SendLevel 1
Send % "7-17," A_Space "^{i}Explosion Suppression Systems^{i}" A_Space
return
:*:7-19Nf::
SendLevel 1
Send % "7-19N," A_Space "^{i}Fire Hazard Properties of Flammable Liquids, Gases, and Volatile Solids^{i}" A_Space
return
:*:7-20f::
SendLevel 1
Send % "7-20," A_Space "^{i}Oil Cookers^{i}" A_Space
return
:*:7-21f::
SendLevel 1
Send % "7-21," A_Space "^{i}Rolling Mills^{i}" A_Space
return
:*:7-22f::
SendLevel 1
Send % "7-22," A_Space "^{i}Hydrazine and its Derivatives^{i}" A_Space
return
:*:7-23f::
SendLevel 1
Send % "7-23," A_Space "^{i}Data on General Class of Chemicals^{i}" A_Space
return
:*:7-23Nf::
SendLevel 1
Send % "7-23N," A_Space "^{i}Hazardous Chemicals Data^{i}" A_Space
return
:*:7-24f::
SendLevel 1
Send % "7-24," A_Space "^{i}Blowing Agents^{i}" A_Space
return
:*:7-25f::
SendLevel 1
Send % "7-25," A_Space "^{i}Molten Steel Production^{i}" A_Space
return
:*:7-26f::
SendLevel 1
Send % "7-26," A_Space "^{i}Glass Manufacturing^{i}" A_Space
return
:*:7-27f::
SendLevel 1
Send % "7-27," A_Space "^{i}Spray Application of Ignitable and Combustible Materials^{i}" A_Space
return
:*:7-28f::
SendLevel 1
Send % "7-28," A_Space "^{i}Energetic Materials^{i}" A_Space
return
:*:7-29f::
SendLevel 1
Send % "7-29," A_Space "^{i}Ignitable Liquid Storage in Portable Containers^{i}" A_Space
return
:*:7-31f::
SendLevel 1
Send % "7-31," A_Space "^{i}Storage of Aerosol Products^{i}" A_Space
return
:*:7-32f::
SendLevel 1
Send % "7-32," A_Space "^{i}Ignitable Liquid Operations^{i}" A_Space
return
:*:7-33f::
SendLevel 1
Send % "7-33," A_Space "^{i}High-Temperature Molten Materials^{i}" A_Space
return
:*:7-35f::
SendLevel 1
Send % "7-35," A_Space "^{i}Air Separation Processes^{i}" A_Space
return
:*:7-36f::
SendLevel 1
Send % "7-36," A_Space "^{i}Pharmaceutical Operations^{i}" A_Space
return
:*:7-37f::
SendLevel 1
Send % "7-37," A_Space "^{i}Cutting Fluids^{i}" A_Space
return
:*:7-39f::
SendLevel 1
Send % "7-39," A_Space "^{i}Industrial Trucks^{i}" A_Space
return
:*:7-40f::
SendLevel 1
Send % "7-40," A_Space "^{i}Heavy Duty Mobile Equipment^{i}" A_Space
return
:*:7-41f::
SendLevel 1
Send % "7-41," A_Space "^{i}Heat Treating of Materials Using Oil Quenching and Molten Salt Baths^{i}" A_Space
return
:*:7-42f::
SendLevel 1
Send % "7-42," A_Space "^{i}Vapor Cloud Explosions^{i}" A_Space
return
:*:7-43f::
SendLevel 1
Send % "7-43," A_Space "^{i}Process Safety^{i}" A_Space
return
:*:7-45f::
SendLevel 1
Send % "7-45," A_Space "^{i}Instrumentation and Control in Safety Applications^{i}" A_Space
return
:*:7-46f::
SendLevel 1
Send % "7-46," A_Space "^{i}Chemical Reactors and Reactions^{i}" A_Space
return
:*:7-49f::
SendLevel 1
Send % "7-49," A_Space "^{i}Emergency Venting of Vessels^{i}" A_Space
return
:*:7-50f::
SendLevel 1
Send % "7-50," A_Space "^{i}Compressed Gases in Cylinders^{i}" A_Space
return
:*:7-51f::
SendLevel 1
Send % "7-51," A_Space "^{i}Acetylene^{i}" A_Space
return
:*:7-53f::
SendLevel 1
Send % "7-53," A_Space "^{i}Liquefied Natural Gas (LNG)^{i}" A_Space
return
:*:7-54f::
SendLevel 1
Send % "7-54," A_Space "^{i}Natural Gas and Gas Piping^{i}" A_Space
return
:*:7-55f::
SendLevel 1
Send % "7-55," A_Space "^{i}Liquefied Petroleum Gas^{i}" A_Space
return
:*:7-58f::
SendLevel 1
Send % "7-58," A_Space "^{i}Chlorine Dioxide^{i}" A_Space
return
:*:7-59f::
SendLevel 1
Send % "7-59," A_Space "^{i}Inerting and Purging of Vessels and Equipment^{i}" A_Space
return
:*:7-61f::
SendLevel 1
Send % "7-61," A_Space "^{i}Facilities Processing Radioactive Materials^{i}" A_Space
return
:*:7-64f::
SendLevel 1
Send % "7-64," A_Space "^{i}Aluminum Industries^{i}" A_Space
return
:*:7-72f::
SendLevel 1
Send % "7-72," A_Space "^{i}Reformer and Cracking Furnace^{i}" A_Space
return
:*:7-73f::
SendLevel 1
Send % "7-73," A_Space "^{i}Dust Collectors and Collection Systems^{i}" A_Space
return
:*:7-74f::
SendLevel 1
Send % "7-74," A_Space "^{i}Distilleries^{i}" A_Space
return
:*:7-75f::
SendLevel 1
Send % "7-75," A_Space "^{i}Grain Storage and Milling^{i}" A_Space
return
:*:7-76f::
SendLevel 1
Send % "7-76," A_Space "^{i}Prevention and Mitigation of Combustible Dust Explosions and Fires^{i}" A_Space
return
:*:7-77f::
SendLevel 1
Send % "7-77," A_Space "^{i}Testing Internal Combustion Engines and Accessories^{i}" A_Space
return
:*:7-78f::
SendLevel 1
Send % "7-78," A_Space "^{i}Industrial Exhaust Systems^{i}" A_Space
return
:*:7-79f::
SendLevel 1
Send % "7-79," A_Space "^{i}Fire Protection for Gas Turbine and Electric Generators^{i}" A_Space
return
:*:7-80f::
SendLevel 1
Send % "7-80," A_Space "^{i}Organic Peroxides^{i}" A_Space
return
:*:7-83f::
SendLevel 1
Send % "7-83," A_Space "^{i}Drainage Systems for Ignitable Liquids^{i}" A_Space
return
:*:7-85f::
SendLevel 1
Send % "7-85," A_Space "^{i}Combustible and Reactive Metals^{i}" A_Space
return
:*:7-86f::
SendLevel 1
Send % "7-86," A_Space "^{i}Cellulose Nitrate^{i}" A_Space
return
:*:7-88f::
SendLevel 1
Send % "7-88," A_Space "^{i}Outdoor Ignitable Storage Tanks^{i}" A_Space
return
:*:7-89f::
SendLevel 1
Send % "7-89," A_Space "^{i}Ammonium Nitrate and Mixed Fertilizers Containing Ammonium Nitrate^{i}" A_Space
return
:*:7-91f::
SendLevel 1
Send % "7-91," A_Space "^{i}Hydrogen^{i}" A_Space
return
:*:7-92f::
SendLevel 1
Send % "7-92," A_Space "^{i}Ethylene Oxide^{i}" A_Space
return
:*:7-93f::
SendLevel 1
Send % "7-93," A_Space "^{i}Aircraft Hangars, Aircraft Manufacturing / Assembly Facilities and Protection of Aircraft Interior During Assembly^{i}" A_Space
return
:*:7-95f::
SendLevel 1
Send % "7-95," A_Space "^{i}Compressors^{i}" A_Space
return
:*:7-96f::
SendLevel 1
Send % "7-96," A_Space "^{i}Printing Plants^{i}" A_Space
return
:*:7-97f::
SendLevel 1
Send % "7-97," A_Space "^{i}Metal Cleaning^{i}" A_Space
return
:*:7-98f::
SendLevel 1
Send % "7-98," A_Space "^{i}Hydraulic Fluids^{i}" A_Space
return
:*:7-99f::
SendLevel 1
Send % "7-99," A_Space "^{i}Heat Transfer Fluid Systems^{i}" A_Space
return
:*:7-101f::
SendLevel 1
Send % "7-101," A_Space "^{i}Fire Protection for Steam Turbines and Electric Generators^{i}" A_Space
return
:*:7-103f::
SendLevel 1
Send % "7-103," A_Space "^{i}Turpentine Recovery in Pulp and Paper Mills^{i}" A_Space
return
:*:7-104f::
SendLevel 1
Send % "7-104," A_Space "^{i}Metal Treatment Processes for Steel Mills^{i}" A_Space
return
:*:7-105f::
SendLevel 1
Send % "7-105," A_Space "^{i}Concentrating Solar Power^{i}" A_Space
return
:*:7-106f::
SendLevel 1
Send % "7-106," A_Space "^{i}Ground Mounted Photovoltaic Solar Power^{i}" A_Space
return
:*:7-107f::
SendLevel 1
Send % "7-107," A_Space "^{i}Natural Gas Transmission and Storage^{i}" A_Space
return
:*:7-108f::
SendLevel 1
Send % "7-108," A_Space "^{i}Silane^{i}" A_Space
return
:*:7-109f::
SendLevel 1
Send % "7-109," A_Space "^{i}Fuel Fired Thermal Electric Power Generation Facilities^{i}" A_Space
return
:*:7-110f::
SendLevel 1
Send % "7-110," A_Space "^{i}Industrial Control Systems ^{i}" A_Space
return
:*:7-111f::
SendLevel 1
Send % "7-111," A_Space "^{i}Chemical Process Industries ^{i}" A_Space
return
:*:7-111Af::
SendLevel 1
Send % "7-111A," A_Space "^{i}Fuel-Grade Ethanol ^{i}" A_Space
return
:*:7-111Bf::
SendLevel 1
Send % "7-111B," A_Space "^{i}Carbon Black ^{i}" A_Space
return
:*:7-111Cf::
SendLevel 1
Send % "7-111C," A_Space "^{i}Titanium Dioxide^{i}" A_Space
return
:*:7-111Df::
SendLevel 1
Send % "7-111D," A_Space "^{i}Oilseed Processing ^{i}" A_Space
return
:*:7-111Ef::
SendLevel 1
Send % "7-111E," A_Space "^{i}Chloro-Alkali ^{i}" A_Space
return
:*:7-111Ff::
SendLevel 1
Send % "7-111F," A_Space "^{i}Sulfuric Acid ^{i}" A_Space
return
:*:7-111Gf::
SendLevel 1
Send % "7-111G," A_Space "^{i}Ammonia and Ammonia Derivatives ^{i}" A_Space
return
:*:7-111Hf::
SendLevel 1
Send % "7-111H," A_Space "^{i}Olefins^{i}" A_Space
return
:*:7-111If::
SendLevel 1
Send % "7-111I," A_Space "^{i}Ink, Paint and Coating Formulations^{i}" A_Space
return
:*:8-1f::
SendLevel 1
Send % "8-1," A_Space "^{i}Commodity Classification^{i}" A_Space
return
:*:8-3f::
SendLevel 1
Send % "8-3," A_Space "^{i}Rubber Tire Storage^{i}" A_Space
return
:*:8-7f::
SendLevel 1
Send % "8-7," A_Space "^{i}Baled Fiber Storage^{i}" A_Space
return
:*:8-9f::
SendLevel 1
Send % "8-9," A_Space "^{i}Storage of Class 1, 2, 3, 4 and Plastic Commodities^{i}" A_Space
return
:*:8-10f::
SendLevel 1
Send % "8-10," A_Space "^{i}Coal and Charcoal Storage^{i}" A_Space
return
:*:8-18f::
SendLevel 1
Send % "8-18," A_Space "^{i}Storage of Hanging Garments^{i}" A_Space
return
:*:8-21f::
SendLevel 1
Send % "8-21," A_Space "^{i}Roll Paper Storage^{i}" A_Space
return
:*:8-22f::
SendLevel 1
Send % "8-22," A_Space "^{i}Storage of Baled Waste Paper^{i}" A_Space
return
:*:8-23f::
SendLevel 1
Send % "8-23," A_Space "^{i}Rolled Nonwoven Fabric Storage^{i}" A_Space
return
:*:8-24f::
SendLevel 1
Send % "8-24," A_Space "^{i}Idle Pallet Storage^{i}" A_Space
return
:*:8-27f::
SendLevel 1
Send % "8-27," A_Space "^{i}Storage of Wood Chips^{i}" A_Space
return
:*:8-28f::
SendLevel 1
Send % "8-28," A_Space "^{i}Pulpwood and Outdoor Log Storage^{i}" A_Space
return
:*:8-30f::
SendLevel 1
Send % "8-30," A_Space "^{i}Storage of Carpets^{i}" A_Space
return
:*:8-33f::
SendLevel 1
Send % "8-33," A_Space "^{i}Carousel Storage and Retrieval Systems^{i}" A_Space
return
:*:8-34f::
SendLevel 1
Send % "8-34," A_Space "^{i}Protection for Automatic Storage and Retrieval Systems^{i}" A_Space
return
:*:9-0f::
SendLevel 1
Send % "9-0," A_Space "^{i}Asset Integrity^{i}" A_Space
return
:*:9-1f::
SendLevel 1
Send % "9-1," A_Space "^{i}Supervision of Property^{i}" A_Space
return
:*:9-16f::
SendLevel 1
Send % "9-16," A_Space "^{i}Burglary and Theft^{i}" A_Space
return
:*:9-18f::
SendLevel 1
Send % "9-18," A_Space "^{i}Prevention of Freeze-ups^{i}" A_Space
return
:*:9-19f::
SendLevel 1
Send % "9-19," A_Space "^{i}Wildland Fire^{i}" A_Space
return
:*:10-0f::
SendLevel 1
Send % "10-0," A_Space "^{i}The Human Factor of Property Conservation^{i}" A_Space
return
:*:10-1f::
SendLevel 1
Send % "10-1," A_Space "^{i}Pre-Incident Planning with the Public Fire Service^{i}" A_Space
return
:*:10-3f::
SendLevel 1
Send % "10-3," A_Space "^{i}Hot Work Management^{i}" A_Space
return
:*:10-4f::
SendLevel 1
Send % "10-4," A_Space "^{i}Contractor Management^{i}" A_Space
return
:*:10-5f::
SendLevel 1
Send % "10-5," A_Space "^{i}Disaster Recovery and Contingency Plan^{i}" A_Space
return
:*:10-6f::
SendLevel 1
Send % "10-6," A_Space "^{i}Protection Against Arson and Other Incendiary Fires^{i}" A_Space
return
:*:10-7f::
SendLevel 1
Send % "10-7," A_Space "^{i}Fire Protection Impairment Management^{i}" A_Space
return
:*:10-8f::
SendLevel 1
Send % "10-8," A_Space "^{i}Operators^{i}" A_Space
return
:*:12-2f::
SendLevel 1
Send % "12-2," A_Space "^{i}Vessels & Piping^{i}" A_Space
return
:*:12-3f::
SendLevel 1
Send % "12-3," A_Space "^{i}Continuous Digesters & Related Vessels^{i}" A_Space
return
:*:12-6f::
SendLevel 1
Send % "12-6," A_Space "^{i}Batch Digesters & Related Vessels^{i}" A_Space
return
:*:12-43f::
SendLevel 1
Send % "12-43," A_Space "^{i}Pressure Relief Devices^{i}" A_Space
return
:*:12-53f::
SendLevel 1
Send % "12-53," A_Space "^{i}Absorption Refrigeration Systems^{i}" A_Space
return
:*:13-1f::
SendLevel 1
Send % "13-1," A_Space "^{i}Cold Mechanical Repairs^{i}" A_Space
return
:*:13-2f::
SendLevel 1
Send % "13-2," A_Space "^{i}Hydroelectric Power Plants^{i}" A_Space
return
:*:13-3f::
SendLevel 1
Send % "13-3," A_Space "^{i}Steam Turbines^{i}" A_Space
return
:*:13-6f::
SendLevel 1
Send % "13-6," A_Space "^{i}Flywheels and Pulleys^{i}" A_Space
return
:*:13-7f::
SendLevel 1
Send % "13-7," A_Space "^{i}Gears^{i}" A_Space
return
:*:13-8f::
SendLevel 1
Send % "13-8," A_Space "^{i}Power Presses^{i}" A_Space
return
:*:13-10f::
SendLevel 1
Send % "13-10," A_Space "^{i}Wind Turbines and Farms^{i}" A_Space
return
:*:13-17f::
SendLevel 1
Send % "13-17," A_Space "^{i}Gas Turbines^{i}" A_Space
return
:*:13-18f::
SendLevel 1
Send % "13-18," A_Space "^{i}Industrial Clutches and Clutch Couplings^{i}" A_Space
return
:*:13-24f::
SendLevel 1
Send % "13-24," A_Space "^{i}Fans and Blowers^{i}" A_Space
return
:*:13-26f::
SendLevel 1
Send % "13-26," A_Space "^{i}Internal Combustion Engines^{i}" A_Space
return
:*:13-27f::
SendLevel 1
Send % "13-27," A_Space "^{i}Heavy Duty Mobile Equipment^{i}" A_Space
return
:*:13-28f::
SendLevel 1
Send % "13-28," A_Space "^{i}Aluminum Industries^{i}" A_Space
return
:*:17-0f::
SendLevel 1
Send % "17-0," A_Space "^{i}Asset Integrity^{i}" A_Space
return
:*:17-2f::
SendLevel 1
Send % "17-2," A_Space "^{i}Process Safety^{i}" A_Space
return
:*:17-4f::
SendLevel 1
Send % "17-4," A_Space "^{i}Monitoring and Diagnosis of Vibration in Rotating Machinery^{i}" A_Space
return
:*:17-11f::
SendLevel 1
Send % "17-11," A_Space "^{i}Chemical Reactors and Reactions^{i}" A_Space
return
:*:17-12f::
SendLevel 1
Send % "17-12," A_Space "^{i}Semiconductor Fabrication Facilities^{i}" A_Space
return
:*:17-16f::
SendLevel 1
Send % "17-16," A_Space "^{i}Cranes^{i}" A_Space
return



::nfpa 13::
SendLevel 1
Send % "NFPA 13," A_Space "^{i}Installation of Sprinkler Systems^{i}" A_Space

::nfpa 25::
SendLevel 1
Send % "NFPA 25," A_Space "^{i}Installation of Sprinkler Systems^{i}" A_Space
return
/*
;#[AHK Script - OS Numbers and Titles Italicized]
;#Hotstring C1 B0 O EndChars f
#Hotstring B0
#Hotstring O
#Hotstring EndChars f ; the "f" can be modified to whatever you chose
;SendLevel 1 ; ...: 100% required in order to actuate another hotstring
; ...............: apparently not required. 
::1-0::
::1-1::
::1-2::
::1-3::
::1-4::
::1-6::
::1-8::
::1-9::
::1-10::
::1-11::
::1-12::
::1-13::
::1-15::
::1-17::
::1-20::
::1-21::
::1-22::
::1-24::
::1-26::
::1-27::
::1-28::
::1-29::
::1-30::
::1-31::
::1-32::
::1-33::
::1-34::
::1-35::
::1-36::
::1-37::
::1-40::
::1-41::
::1-42::
::1-44::
::1-45::
::1-49::
::1-52::
::1-53::
::1-54::
::1-55::
::1-56::
::1-57::
::1-59::
::1-60::
::1-61::
::1-62::
::1-63::
::1-64::
::2-0::
::2-1::
::2-8::
::2-81::
::2-89::
::3-0::
::3-1::
::3-2::
::3-3::
::3-4::
::3-6::
::3-7::
::3-10::
::3-11::
::3-26::
::3-29::
::4-0::
::4-1N::
::4-2::
::4-3N::
::4-4N::
::4-5::
::4-6::
::4-8N::
::4-9::
::4-10::
::4-11N::
::4-12::
::4-13::
::5-1::
::5-3::
::5-4::
::5-8::
::5-11::
::5-12::
::5-14::
::5-17::
::5-18::
::5-19::
::5-20::
::5-21::
::5-23::
::5-24::
::5-25::
::5-28::
::5-30::
::5-31::
::5-32::
::5-33::
::5-40::
::5-48::
::5-49::
::6-0::
::6-2::
::6-3::
::6-4::
::6-5::
::6-6::
::6-7::
::6-8::
::6-9::
::6-10::
::6-11::
::6-12::
::6-13::
::6-14::
::6-17::
::6-21::
::6-22::
::6-23::
::7-0::
::7-1::
::7-2::
::7-3::
::7-4::
::7-6::
::7-7::
::7-9::
::7-10::
::7-11::
::7-12::
::7-13::
::7-14::
::7-15::
::7-17::
::7-19N::
::7-20::
::7-21::
::7-22::
::7-23::
::7-23N::
::7-24::
::7-25::
::7-26::
::7-27::
::7-28::
::7-29::
::7-31::
::7-32::
::7-33::
::7-35::
::7-36::
::7-37::
::7-39::
::7-40::
::7-41::
::7-42::
::7-43::
::7-45::
::7-46::
::7-49::
::7-50::
::7-51::
::7-53::
::7-54::
::7-55::
::7-58::
::7-59::
::7-61::
::7-64::
::7-72::
::7-73::
::7-74::
::7-75::
::7-76::
::7-77::
::7-78::
::7-79::
::7-80::
::7-83::
::7-85::
::7-86::
::7-88::
::7-89::
::7-91::
::7-92::
::7-93::
::7-95::
::7-96::
::7-97::
::7-98::
::7-99::
::7-101::
::7-103::
::7-104::
::7-105::
::7-106::
::7-107::
::7-108::
::7-109::
::7-110::
::7-111::
::7-111A::
::7-111B::
::7-111C::
::7-111D::
::7-111E::
::7-111F::
::7-111G::
::7-111H::
::7-111I::
::8-1::
::8-3::
::8-7::
::8-9::
::8-10::
::8-18::
::8-21::
::8-22::
::8-23::
::8-24::
::8-27::
::8-28::
::8-30::
::8-33::
::8-34::
::9-0::
::9-1::
::9-16::
::9-18::
::9-19::
::10-0::
::10-1::
::10-3::
::10-4::
::10-5::
::10-6::
::10-7::
::10-8::
::12-2::
::12-3::
::12-6::
::12-43::
::12-53::
::13-1::
::13-2::
::13-3::
::13-6::
::13-7::
::13-8::
::13-10::
::13-17::
::13-18::
::13-24::
::13-26::
::13-27::
::13-28::
::17-0::
::17-2::
::17-4::
::17-11::
::17-12::
::17-16::
SendLevel 1
MakeOSItalic(A_ThisLabel)
#Hotstring B O0
#Hotstring EndChars
*/
;---------------------------------------------------------------------------
;                      Version 4 - OS Abbreviations
;---------------------------------------------------------------------------
/* ; Version 4 - Working Hotstrings
::1-0::
MakeOSItalic(A_ThisLabel)
return
::1-1::
MakeOSItalic(A_ThisLabel)
return
::1-2::
MakeOSItalic(A_ThisHotKey)
return
::1-3::
MakeOSItalic(A_ThisLabel)
return
::1-4::
MakeOSItalic(A_ThisLabel)
return
::1-6::
MakeOSItalic(A_ThisLabel)
return
::1-8::
MakeOSItalic(A_ThisLabel)
return
::1-9::
MakeOSItalic(A_ThisLabel)
return
::1-10::
MakeOSItalic(A_ThisLabel)
return
::1-11::
MakeOSItalic(A_ThisLabel)
return
::1-12::
MakeOSItalic(A_ThisLabel)
return
::1-13::
MakeOSItalic(A_ThisLabel)
return
::1-15::
MakeOSItalic(A_ThisLabel)
return
::1-17::
MakeOSItalic(A_ThisLabel)
return
::1-20::
MakeOSItalic(A_ThisLabel)
return
::1-21::
MakeOSItalic(A_ThisLabel)
return
::1-22::
MakeOSItalic(A_ThisLabel)
return
::1-24::
MakeOSItalic(A_ThisLabel)
return
::1-26::
MakeOSItalic(A_ThisLabel)
return
::1-27::
MakeOSItalic(A_ThisLabel)
return
::1-28::
MakeOSItalic(A_ThisLabel)
return
::1-29::
MakeOSItalic(A_ThisLabel)
return
::1-30::
MakeOSItalic(A_ThisLabel)
return
::1-31::
MakeOSItalic(A_ThisLabel)
return
::1-32::
MakeOSItalic(A_ThisLabel)
return
::1-33::
MakeOSItalic(A_ThisLabel)
return
::1-34::
MakeOSItalic(A_ThisLabel)
return
::1-35::
MakeOSItalic(A_ThisLabel)
return
::1-36::
MakeOSItalic(A_ThisLabel)
return
::1-37::
MakeOSItalic(A_ThisLabel)
return
::1-40::
MakeOSItalic(A_ThisLabel)
return
::1-41::
MakeOSItalic(A_ThisLabel)
return
::1-42::
MakeOSItalic(A_ThisLabel)
return
::1-44::
MakeOSItalic(A_ThisLabel)
return
::1-45::
MakeOSItalic(A_ThisLabel)
return
::1-49::
MakeOSItalic(A_ThisLabel)
return
::1-52::
MakeOSItalic(A_ThisLabel)
return
::1-53::
MakeOSItalic(A_ThisLabel)
return
::1-54::
MakeOSItalic(A_ThisLabel)
return
::1-55::
MakeOSItalic(A_ThisLabel)
return
::1-56::
MakeOSItalic(A_ThisLabel)
return
::1-57::
MakeOSItalic(A_ThisLabel)
return
::1-59::
MakeOSItalic(A_ThisLabel)
return
::1-60::
MakeOSItalic(A_ThisLabel)
return
::1-61::
MakeOSItalic(A_ThisLabel)
return
::1-62::
MakeOSItalic(A_ThisLabel)
return
::1-63::
MakeOSItalic(A_ThisLabel)
return
::1-64::
MakeOSItalic(A_ThisLabel)
return
::2-0::
MakeOSItalic(A_ThisLabel)
return
::2-1::
MakeOSItalic(A_ThisLabel)
return
::2-8::
MakeOSItalic(A_ThisLabel)
return
::2-81::
MakeOSItalic(A_ThisLabel)
return
::2-89::
MakeOSItalic(A_ThisLabel)
return
::3-0::
MakeOSItalic(A_ThisLabel)
return
::3-1::
MakeOSItalic(A_ThisLabel)
return
::3-2::
MakeOSItalic(A_ThisLabel)
return
::3-3::
MakeOSItalic(A_ThisLabel)
return
::3-4::
MakeOSItalic(A_ThisLabel)
return
::3-6::
MakeOSItalic(A_ThisLabel)
return
::3-7::
MakeOSItalic(A_ThisLabel)
return
::3-10::
MakeOSItalic(A_ThisLabel)
return
::3-11::
MakeOSItalic(A_ThisLabel)
return
::3-26::
MakeOSItalic(A_ThisLabel)
return
::3-29::
MakeOSItalic(A_ThisLabel)
return
::4-0::
MakeOSItalic(A_ThisLabel)
return
::4-1N::
MakeOSItalic(A_ThisLabel)
return
::4-2::
MakeOSItalic(A_ThisLabel)
return
::4-3N::
MakeOSItalic(A_ThisLabel)
return
::4-4N::
MakeOSItalic(A_ThisLabel)
return
::4-5::
MakeOSItalic(A_ThisLabel)
return
::4-6::
MakeOSItalic(A_ThisLabel)
return
::4-8N::
MakeOSItalic(A_ThisLabel)
return
::4-9::
MakeOSItalic(A_ThisLabel)
return
::4-10::
MakeOSItalic(A_ThisLabel)
return
::4-11N::
MakeOSItalic(A_ThisLabel)
return
::4-12::
MakeOSItalic(A_ThisLabel)
return
::4-13::
MakeOSItalic(A_ThisLabel)
return
::5-1::
MakeOSItalic(A_ThisLabel)
return
::5-3::
MakeOSItalic(A_ThisLabel)
return
::5-4::
MakeOSItalic(A_ThisLabel)
return
::5-8::
MakeOSItalic(A_ThisLabel)
return
::5-11::
MakeOSItalic(A_ThisLabel)
return
::5-12::
MakeOSItalic(A_ThisLabel)
return
::5-14::
MakeOSItalic(A_ThisLabel)
return
::5-17::
MakeOSItalic(A_ThisLabel)
return
::5-18::
MakeOSItalic(A_ThisLabel)
return
::5-19::
;MakeOSItalic(A_ThisLabel)
;return
::5-20::
MakeOSItalic(A_ThisLabel)
return
::5-21::
MakeOSItalic(A_ThisLabel)
return
::5-23::
MakeOSItalic(A_ThisLabel)
return
::5-24::
MakeOSItalic(A_ThisLabel)
return
::5-25::
MakeOSItalic(A_ThisLabel)
return
::5-28::
MakeOSItalic(A_ThisLabel)
return
::5-30::
MakeOSItalic(A_ThisLabel)
return
::5-31::
MakeOSItalic(A_ThisLabel)
return
::5-32::
MakeOSItalic(A_ThisLabel)
return
::5-33::
MakeOSItalic(A_ThisLabel)
return
::5-40::
MakeOSItalic(A_ThisLabel)
return
::5-48::
MakeOSItalic(A_ThisLabel)
return
::5-49::
MakeOSItalic(A_ThisLabel)
return
::6-0::
MakeOSItalic(A_ThisLabel)
return
::6-2::
MakeOSItalic(A_ThisLabel)
return
::6-3::
MakeOSItalic(A_ThisLabel)
return
::6-4::
MakeOSItalic(A_ThisLabel)
return
::6-5::
MakeOSItalic(A_ThisLabel)
return
::6-6::
MakeOSItalic(A_ThisLabel)
return
::6-7::
MakeOSItalic(A_ThisLabel)
return
::6-8::
MakeOSItalic(A_ThisLabel)
return
::6-9::
MakeOSItalic(A_ThisLabel)
return
::6-10::
MakeOSItalic(A_ThisLabel)
return
::6-11::
MakeOSItalic(A_ThisLabel)
return
::6-12::
MakeOSItalic(A_ThisLabel)
return
::6-13::
MakeOSItalic(A_ThisLabel)
return
::6-14::
MakeOSItalic(A_ThisLabel)
return
::6-17::
MakeOSItalic(A_ThisLabel)
return
::6-21::
MakeOSItalic(A_ThisLabel)
return
::6-22::
MakeOSItalic(A_ThisLabel)
return
::6-23::
MakeOSItalic(A_ThisLabel)
return
::7-0::
MakeOSItalic(A_ThisLabel)
return
::7-1::
MakeOSItalic(A_ThisLabel)
return
::7-2::
MakeOSItalic(A_ThisLabel)
return
::7-3::
MakeOSItalic(A_ThisLabel)
return
::7-4::
MakeOSItalic(A_ThisLabel)
return
::7-6::
MakeOSItalic(A_ThisLabel)
return
::7-7::
MakeOSItalic(A_ThisLabel)
return
::7-9::
MakeOSItalic(A_ThisLabel)
return
::7-10::
MakeOSItalic(A_ThisLabel)
return
::7-11::
MakeOSItalic(A_ThisLabel)
return
::7-12::
MakeOSItalic(A_ThisLabel)
return
::7-13::
MakeOSItalic(A_ThisLabel)
return
::7-14::
MakeOSItalic(A_ThisLabel)
return
::7-15::
MakeOSItalic(A_ThisLabel)
return
::7-17::
MakeOSItalic(A_ThisLabel)
return
::7-19N::
MakeOSItalic(A_ThisLabel)
return
::7-20::
MakeOSItalic(A_ThisLabel)
return
::7-21::
MakeOSItalic(A_ThisLabel)
return
::7-22::
MakeOSItalic(A_ThisLabel)
return
::7-23::
MakeOSItalic(A_ThisLabel)
return
::7-23N::
MakeOSItalic(A_ThisLabel)
return
::7-24::
MakeOSItalic(A_ThisLabel)
return
::7-25::
MakeOSItalic(A_ThisLabel)
return
::7-26::
MakeOSItalic(A_ThisLabel)
return
::7-27::
MakeOSItalic(A_ThisLabel)
return
::7-28::
MakeOSItalic(A_ThisLabel)
return
::7-29::
MakeOSItalic(A_ThisLabel)
return
::7-31::
MakeOSItalic(A_ThisLabel)
return
::7-32::
MakeOSItalic(A_ThisLabel)
return
::7-33::
MakeOSItalic(A_ThisLabel)
return
::7-35::
MakeOSItalic(A_ThisLabel)
return
::7-36::
MakeOSItalic(A_ThisLabel)
return
::7-37::
MakeOSItalic(A_ThisLabel)
return
::7-39::
MakeOSItalic(A_ThisLabel)
return
::7-40::
MakeOSItalic(A_ThisLabel)
return
::7-41::
MakeOSItalic(A_ThisLabel)
return
::7-42::
MakeOSItalic(A_ThisLabel)
return
::7-43::
MakeOSItalic(A_ThisLabel)
return
::7-45::
MakeOSItalic(A_ThisLabel)
return
::7-46::
MakeOSItalic(A_ThisLabel)
return
::7-49::
MakeOSItalic(A_ThisLabel)
return
::7-50::
MakeOSItalic(A_ThisLabel)
return
::7-51::
MakeOSItalic(A_ThisLabel)
return
::7-53::
MakeOSItalic(A_ThisLabel)
return
::7-54::
MakeOSItalic(A_ThisLabel)
return
::7-55::
MakeOSItalic(A_ThisLabel)
return
::7-58::
MakeOSItalic(A_ThisLabel)
return
::7-59::
MakeOSItalic(A_ThisLabel)
return
::7-61::
MakeOSItalic(A_ThisLabel)
return
::7-64::
MakeOSItalic(A_ThisLabel)
return
::7-72::
MakeOSItalic(A_ThisLabel)
return
::7-73::
MakeOSItalic(A_ThisLabel)
return
::7-74::
MakeOSItalic(A_ThisLabel)
return
::7-75::
MakeOSItalic(A_ThisLabel)
return
::7-76::
MakeOSItalic(A_ThisLabel)
return
::7-77::
MakeOSItalic(A_ThisLabel)
return
::7-78::
MakeOSItalic(A_ThisLabel)
return
::7-79::
MakeOSItalic(A_ThisLabel)
return
::7-80::
MakeOSItalic(A_ThisLabel)
return
::7-83::
MakeOSItalic(A_ThisLabel)
return
::7-85::
MakeOSItalic(A_ThisLabel)
return
::7-86::
MakeOSItalic(A_ThisLabel)
return
::7-88::
MakeOSItalic(A_ThisLabel)
return
::7-89::
MakeOSItalic(A_ThisLabel)
return
::7-91::
MakeOSItalic(A_ThisLabel)
return
::7-92::
MakeOSItalic(A_ThisLabel)
return
::7-93::
MakeOSItalic(A_ThisLabel)
return
::7-95::
MakeOSItalic(A_ThisLabel)
return
::7-96::
MakeOSItalic(A_ThisLabel)
return
::7-97::
MakeOSItalic(A_ThisLabel)
return
::7-98::
MakeOSItalic(A_ThisLabel)
return
::7-99::
MakeOSItalic(A_ThisLabel)
return
::7-101::
MakeOSItalic(A_ThisLabel)
return
::7-103::
MakeOSItalic(A_ThisLabel)
return
::7-104::
MakeOSItalic(A_ThisLabel)
return
::7-105::
MakeOSItalic(A_ThisLabel)
return
::7-106::
MakeOSItalic(A_ThisLabel)
return
::7-107::
MakeOSItalic(A_ThisLabel)
return
::7-108::
MakeOSItalic(A_ThisLabel)
return
::7-109::
MakeOSItalic(A_ThisLabel)
return
::7-110::
MakeOSItalic(A_ThisLabel)
return
::7-111::
MakeOSItalic(A_ThisLabel)
return
::7-111A::
MakeOSItalic(A_ThisLabel)
return
::7-111B::
MakeOSItalic(A_ThisLabel)
return
::7-111C::
MakeOSItalic(A_ThisLabel)
return
::7-111D::
MakeOSItalic(A_ThisLabel)
return
::7-111E::
MakeOSItalic(A_ThisLabel)
return
::7-111F::
MakeOSItalic(A_ThisLabel)
return
::7-111G::
MakeOSItalic(A_ThisLabel)
return
::7-111H::
MakeOSItalic(A_ThisLabel)
return
::7-111I::
MakeOSItalic(A_ThisLabel)
return
::8-1::
MakeOSItalic(A_ThisLabel)
return
::8-3::
MakeOSItalic(A_ThisLabel)
return
::8-7::
MakeOSItalic(A_ThisLabel)
return
::8-9::
MakeOSItalic(A_ThisLabel)
return
::8-10::
MakeOSItalic(A_ThisLabel)
return
::8-18::
MakeOSItalic(A_ThisLabel)
return
::8-21::
MakeOSItalic(A_ThisLabel)
return
::8-22::
MakeOSItalic(A_ThisLabel)
return
::8-23::
MakeOSItalic(A_ThisLabel)
return
::8-24::
MakeOSItalic(A_ThisLabel)
return
::8-27::
MakeOSItalic(A_ThisLabel)
return
::8-28::
MakeOSItalic(A_ThisLabel)
return
::8-30::
MakeOSItalic(A_ThisLabel)
return
::8-33::
MakeOSItalic(A_ThisLabel)
return
::8-34::
MakeOSItalic(A_ThisLabel)
return
::9-0::
MakeOSItalic(A_ThisLabel)
return
::9-1::
MakeOSItalic(A_ThisLabel)
return
::9-16::
MakeOSItalic(A_ThisLabel)
return
::9-18::
MakeOSItalic(A_ThisLabel)
return
::9-19::
MakeOSItalic(A_ThisLabel)
return
::10-0::
MakeOSItalic(A_ThisLabel)
return
::10-1::
MakeOSItalic(A_ThisLabel)
return
::10-3::
MakeOSItalic(A_ThisLabel)
return
::10-4::
MakeOSItalic(A_ThisLabel)
return
::10-5::
MakeOSItalic(A_ThisLabel)
return
::10-6::
MakeOSItalic(A_ThisLabel)
return
::10-7::
MakeOSItalic(A_ThisLabel)
return
::10-8::
MakeOSItalic(A_ThisLabel)
return
::12-2::
MakeOSItalic(A_ThisLabel)
return
::12-3::
MakeOSItalic(A_ThisLabel)
return
::12-6::
MakeOSItalic(A_ThisLabel)
return
::12-43::
MakeOSItalic(A_ThisLabel)
return
::12-53::
MakeOSItalic(A_ThisLabel)
return
::13-1::
MakeOSItalic(A_ThisLabel)
return
::13-2::
MakeOSItalic(A_ThisLabel)
return
::13-3::
MakeOSItalic(A_ThisLabel)
return
::13-6::
MakeOSItalic(A_ThisLabel)
return
::13-7::
MakeOSItalic(A_ThisLabel)
return
::13-8::
MakeOSItalic(A_ThisLabel)
return
::13-10::
MakeOSItalic(A_ThisLabel)
return
::13-17::
MakeOSItalic(A_ThisLabel)
return
::13-18::
MakeOSItalic(A_ThisLabel)
return
::13-24::
MakeOSItalic(A_ThisLabel)
return
::13-26::
MakeOSItalic(A_ThisLabel)
return
::13-27::
MakeOSItalic(A_ThisLabel)
return
::13-28::
MakeOSItalic(A_ThisLabel)
return
::17-0::
MakeOSItalic(A_ThisLabel)
return
::17-2::
MakeOSItalic(A_ThisLabel)
return
::17-4::
MakeOSItalic(A_ThisLabel)
return
::17-11::
MakeOSItalic(A_ThisLabel)
return
::17-12::
MakeOSItalic(A_ThisLabel)
return
::17-16::
MakeOSItalic(A_ThisLabel)
return
#Hotstring
*/
;---------------------------------------------------------------------------
;                      Original - OS Abbreviations
;---------------------------------------------------------------------------
/* ; original MakeOSItalic("")
:*:1-1f::
MakeOSItalic("1-1, Firesafe Building Construction and Materials")
return
:*:1-2f::
MakeOSItalic("1-2, Earthquakes")
return
:*:1-3f::
MakeOSItalic("1-3, High-Rise Buildings")
return
:*:1-4f::
MakeOSItalic("1-4, Fire Tests")
return
:*:1-6f::
MakeOSItalic("1-6, Cooling Towers")
return
:*:1-8f::
MakeOSItalic("1-8, Antenna Towers and Signs")
return
:*:1-9f::
MakeOSItalic("1-9, Roof Anchorage for Older, Wood-Roofed Buildings")
return
:*:1-10f::
MakeOSItalic("1-10, Smoke and Heat Venting in Sprinklered Buildings")
return
:*:1-11f::
MakeOSItalic("1-11, Fire Following Earthquakes")
return
:*:1-12f::
MakeOSItalic("1-12, Ceilings and Concealed Spaces")
return
:*:1-13f::
MakeOSItalic("1-13, Chimneys")
return
:*:1-15f::
MakeOSItalic("1-15, Roof Mounted Solar Photovoltaic Panels")
return
:*:1-17f::
MakeOSItalic("1-17, Reflective Ceiling Insulation")
return
:*:1-20f::
MakeOSItalic("1-20, Protection Against Exterior Fire Exposure")
return
:*:1-21f::
MakeOSItalic("1-21, Fire Resistance of Building Assemblies")
return
:*:1-22f::
MakeOSItalic("1-22, Maximum Foreseeable Loss")
return
:*:1-24f::
MakeOSItalic("1-24, Protection Against Liquid Damage")
return
:*:1-26f::
MakeOSItalic("1-26, Steep-Slope Roof Systems")
return
:*:1-27f::
MakeOSItalic("1-27, Windstorm  Retrofit and Loss Expectancy (LE) Guidelines")
return
:*:1-28f::
MakeOSItalic("1-28, Wind Design")
return
:*:1-29f::
MakeOSItalic("1-29, Roof Deck Securement and Above-Deck Roofing  Components")
return
:*:1-30f::
MakeOSItalic("1-30, Repair of Wind Damaged Roof Systems")
return
:*:1-31f::
MakeOSItalic("1-31, Panel Roof Systems")
return
:*:1-32f::
MakeOSItalic("1-32, Inspection and Maintenance of Roof Assemblies")
return
:*:1-33f::
MakeOSItalic("1-33, Safeguarding Torch - Applied Roof Installations")
return
:*:1-34f::
MakeOSItalic("1-34, Hail Damage")
return
:*:1-35f::
MakeOSItalic("1-35, Vegetative Roof Systems Vegetative Roof Systems, Occupied Roof Areas & Decks ")
return
:*:1-36f::
MakeOSItalic("1-36, Mass Engineered Timber")
return
:*:1-37f::
MakeOSItalic("1-37, Hospitals ")
return
:*:1-40f::
MakeOSItalic("1-40, Flood")
return
:*:1-41f::
MakeOSItalic("1-41, Dam Evaluations")
return
:*:1-42f::
MakeOSItalic("1-42, MFL Limiting Factors ")
return
:*:1-44f::
MakeOSItalic("1-44, Damage-Limiting Construction")
return
:*:1-45f::
MakeOSItalic("1-45, Air Conditioning and Ventilating Systems")
return
:*:1-49f::
MakeOSItalic("1-49, Perimeter Flashing")
return
:*:1-52f::
MakeOSItalic("1-52, Field  Verification of Roof Wind Uplift Resistance")
return
:*:1-53f::
MakeOSItalic("1-53, Anechoic Chambers")
return
:*:1-54f::
MakeOSItalic("1-54, Roof Loads and Drainage")
return
:*:1-55f::
MakeOSItalic("1-55, Weak Construction and Design")
return
:*:1-56f::
MakeOSItalic("1-56, Cleanrooms")
return
:*:1-57f::
MakeOSItalic("1-57, Plastics in Construction")
return
:*:1-59f::
MakeOSItalic("1-59, Fabric and Membrane Covered Structures")
return
:*:1-60f::
MakeOSItalic("1-60, Asphalt-Coated/Protected Metal Buildings")
return
:*:1-61f::
MakeOSItalic("1-61, Impregnated Fire-Retardant Lumber")
return
:*:1-62f::
MakeOSItalic("1-62, Cranes")
return
:*:1-63f::
MakeOSItalic("1-63, Exterior Insulation and Finish Systems")
return
:*:1-64f::
MakeOSItalic("1-64, Exterior Walls and Facades")
return
:*:2-0f::
MakeOSItalic("2-0, Installation Guidelines for Automatic Sprinklers")
return
:*:2-1f::
MakeOSItalic("2-1, Corrosion in Automatic Sprinkler Systems")
return
:*:2-8f::
MakeOSItalic("2-8, Earthquake Protection for Water-Based Fire Protection Systems")
return
:*:2-81f::
MakeOSItalic("2-81, Fire Safety Inspections and Sprinkler System Maintenance")
return
:*:2-89f::
MakeOSItalic("2-89, Pipe Friction Loss Tables")
return
:*:3-0f::
MakeOSItalic("3-0, Hydraulics of Fire Protection Systems")
return
:*:3-1f::
MakeOSItalic("3-1, Tanks and Reservoirs for Interconnected Fire Service and Public Mains")
return
:*:3-2f::
MakeOSItalic("3-2, Water Tanks for Fire Protection")
return
:*:3-3f::
MakeOSItalic("3-3, Cross Connections")
return
:*:3-4f::
MakeOSItalic("3-4, Embankment-Supported Fabric Tanks")
return
:*:3-6f::
MakeOSItalic("3-6, Lined Earth Reservoirs for Fire Protection")
return
:*:3-7f::
MakeOSItalic("3-7, Fire Protection Pump")
return
:*:3-10f::
MakeOSItalic("3-10, Installation/Maintenance of  Fire Service Mains")
return
:*:3-11f::
MakeOSItalic("3-11, Flow and Pressure Regulating Devices for Fire Protection Service")
return
:*:3-26f::
MakeOSItalic("3-26, Fire Protection Water Demand for Nonstorage Sprinklered Properties")
return
:*:3-29f::
MakeOSItalic("3-29, Reliability of Fire Protection Water Supplies")
return
:*:4-0f::
MakeOSItalic("4-0, Special Protection Systems")
return
:*:4-1Nf::
MakeOSItalic("4-1N, Fixed Water Spray Systems for Fire Protection")
return
:*:4-2f::
MakeOSItalic("4-2, Water Mist Systems")
return
:*:4-3Nf::
MakeOSItalic("4-3N, Medium and High Expansion Foam Systems")
return
:*:4-4Nf::
MakeOSItalic("4-4N, Standpipe and Hose Systems")
return
:*:4-5f::
MakeOSItalic("4-5, Portable Extinguishers")
return
:*:4-6f::
MakeOSItalic("4-6, Hybrid Fire Extinguishing Systems")
return
:*:4-8Nf::
MakeOSItalic("4-8N, Halon 1301 Extinguishing Systems")
return
:*:4-9f::
MakeOSItalic("4-9, Halocarbon and Inert Gas (Clean Agent) Fire Extinguishing Systems")
return
:*:4-10f::
MakeOSItalic("4-10, Dry Chemical Systems")
return
:*:4-11Nf::
MakeOSItalic("4-11N, Carbon Dioxide Extinguishing Systems (NFPA)")
return
:*:4-12f::
MakeOSItalic("4-12, Foam Water Extinguishing  Systems")
return
:*:4-13f::
MakeOSItalic("4-13, Oxygen Reduction Systems")
return
:*:5-1f::
MakeOSItalic("5-1, Electrical Equipment in Hazardous (Classified) Locations")
return
:*:5-3f::
MakeOSItalic("5-3, Hydroelectric Power Plants")
return
:*:5-4f::
MakeOSItalic("5-4, Transformers")
return
:*:5-8f::
MakeOSItalic("5-8, Static Electricity")
return
:*:5-11f::
MakeOSItalic("5-11, Lightning and Surge Protection for Electrical Systems")
return
:*:5-12f::
MakeOSItalic("5-12, Electric AC Generators")
return
:*:5-14f::
MakeOSItalic("5-14, Telecommunications")
return
:*:5-17f::
MakeOSItalic("5-17, Motors & Adjustable Speed Drives")
return
:*:5-18f::
MakeOSItalic("5-18, Protection of Electrical Equipment")
return
:*:5-19f::
;RegExMatch(A_ThisHotkey, "([0-9]{1,2}-[0-9]*)f",match)
;IniRead, OSTitle, OSTitle.ini,OS,% match
MsgBox % A_ThisHotkey
return
;:*:5-19f::
;MakeOSItalic("5-19, Switchgear and Circuit Breakers")
;return
:*:5-20f::
MakeOSItalic("5-20, Electrical Testing")
return
:*:5-21f::
MakeOSItalic("5-21, Metal Halide High-Intensity Discharge Lighting")
return
:*:5-23f::
MakeOSItalic("5-23, Design and Fire Protection for Emergency and Standby Power Systems")
return
:*:5-24f::
MakeOSItalic("5-24, Miscellaneous Electrical Equipment")
return
:*:5-25f::
MakeOSItalic("5-25, High Voltage Direct Current Converter Stations")
return
:*:5-28f::
MakeOSItalic("5-28, DC Battery Systems")
return
:*:5-30f::
MakeOSItalic("5-30, Power Factor Correction and Static Reactive Compensator Systems")
return
:*:5-31f::
MakeOSItalic("5-31, Cables and Bus Bars")
return
:*:5-32f::
MakeOSItalic("5-32, Data Centers and Related Facilities")
return
:*:5-33f::
MakeOSItalic("5-33, Electrical Energy Storage Systems")
return
:*:5-40f::
MakeOSItalic("5-40, Fire Alarm Systems")
return
:*:5-48f::
MakeOSItalic("5-48, Automatic Fire Detection")
return
:*:5-49f::
MakeOSItalic("5-49, Gas and Vapor Detectors and Analysis Systems")
return
:*:6-0f::
MakeOSItalic("6-0, Elements of Industrial Heating Equipment")
return
:*:6-2f::
MakeOSItalic("6-2, Pulverized Coal Fired  Boilers")
return
:*:6-3f::
MakeOSItalic("6-3, Induction and Dielectric Heating Equipment")
return
:*:6-4f::
MakeOSItalic("6-4, Oil- and Gas-Fired Single-Burner Boilers")
return
:*:6-5f::
MakeOSItalic("6-5, Oil- or Gas-Fired Multiple Burner Boilers")
return
:*:6-6f::
MakeOSItalic("6-6, Boiler-Furnaces Implosions")
return
:*:6-7f::
MakeOSItalic("6-7, Fluidized Bed Combustors")
return
:*:6-8f::
MakeOSItalic("6-8, Combustion Air Heaters")
return
:*:6-9f::
MakeOSItalic("6-9, Industrial Ovens and Dryers")
return
:*:6-10f::
MakeOSItalic("6-10, Process Furnaces")
return
:*:6-11f::
MakeOSItalic("6-11, Thermal and Regenerative Catalytic Oxidizers")
return
:*:6-12f::
MakeOSItalic("6-12, Low-Water Protection")
return
:*:6-13f::
MakeOSItalic("6-13, Waste Fuel Fired Facilities")
return
:*:6-14f::
MakeOSItalic("6-14, Waste Heat Boilers")
return
:*:6-17f::
MakeOSItalic("6-17, Rotary Kilns and Dryers")
return
:*:6-21f::
MakeOSItalic("6-21, Chemical Recovery Boilers")
return
:*:6-22f::
MakeOSItalic("6-22, Firetube Boilers")
return
:*:6-23f::
MakeOSItalic("6-23, Watertube Boilers")
return
:*:7-0f::
MakeOSItalic("7-0, Causes and Effects of Fires and Explosions")
return
:*:7-1f::
MakeOSItalic("7-1, Fire Protection for Textile Mills")
return
:*:7-2f::
MakeOSItalic("7-2, Waste Solvent Recovery")
return
:*:7-3f::
MakeOSItalic("7-3, Flight Simulator System Protection")
return
:*:7-4f::
MakeOSItalic("7-4, Paper Machines and Pulp Dryers")
return
:*:7-6f::
MakeOSItalic("7-6, Heated Plastic and Plastic-Lined Tanks")
return
:*:7-7f::
MakeOSItalic("7-7, Semiconductor Fabrication Facilities")
return
:*:7-9f::
MakeOSItalic("7-9, Dip Tanks, Flow Coaters and Roll Coaters")
return
:*:7-10f::
MakeOSItalic("7-10, Wood Processing and Woodworking Facilities")
return
:*:7-11f::
MakeOSItalic("7-11, Conveyors")
return
:*:7-12f::
MakeOSItalic("7-12, Mining and Mineral Processing")
return
:*:7-13f::
MakeOSItalic("7-13, Mechanical Refrigeration")
return
:*:7-14f::
MakeOSItalic("7-14, Fire Protection for Chemical Plants")
return
:*:7-15f::
MakeOSItalic("7-15, Garages")
return
:*:7-17f::
MakeOSItalic("7-17, Explosion Suppression Systems")
return
:*:7-19Nf::
MakeOSItalic("7-19N, Fire Hazard Properties of Flammable Liquids, Gases, and Volatile Solids")
return
:*:7-20f::
MakeOSItalic("7-20, Oil Cookers")
return
:*:7-21f::
MakeOSItalic("7-21, Rolling Mills")
return
:*:7-22f::
MakeOSItalic("7-22, Hydrazine and its Derivatives")
return
:*:7-23f::
MakeOSItalic("7-23, Data on General Class of Chemicals")
return
:*:7-23Nf::
MakeOSItalic("7-23N, Hazardous Chemicals Data")
return
:*:7-24f::
MakeOSItalic("7-24, Blowing Agents")
return
:*:7-25f::
MakeOSItalic("7-25, Molten Steel Production")
return
:*:7-26f::
MakeOSItalic("7-26, Glass Manufacturing")
return
:*:7-27f::
MakeOSItalic("7-27, Spray Application of Ignitable and Combustible Materials")
return
:*:7-28f::
MakeOSItalic("7-28, Energetic Materials")
return
:*:7-29f::
MakeOSItalic("7-29, Ignitable Liquid Storage in Portable Containers")
return
:*:7-31f::
MakeOSItalic("7-31, Storage of Aerosol Products")
return
:*:7-32f::
MakeOSItalic("7-32, Ignitable Liquid Operations")
return
:*:7-33f::
MakeOSItalic("7-33, High-Temperature Molten Materials")
return
:*:7-35f::
MakeOSItalic("7-35, Air Separation Processes")
return
:*:7-36f::
MakeOSItalic("7-36, Pharmaceutical Operations")
return
:*:7-37f::
MakeOSItalic("7-37, Cutting Fluids")
return
:*:7-39f::
MakeOSItalic("7-39, Industrial Trucks")
return
:*:7-40f::
MakeOSItalic("7-40, Heavy Duty Mobile Equipment")
return
:*:7-41f::
MakeOSItalic("7-41, Heat Treating of Materials Using Oil Quenching and Molten Salt Baths")
return
:*:7-42f::
MakeOSItalic("7-42, Vapor Cloud Explosions")
return
:*:7-43f::
MakeOSItalic("7-43, Process Safety")
return
:*:7-45f::
MakeOSItalic("7-45, Instrumentation and Control in Safety Applications")
return
:*:7-46f::
MakeOSItalic("7-46, Chemical Reactors and Reactions")
return
:*:7-49f::
MakeOSItalic("7-49, Emergency Venting of Vessels")
return
:*:7-50f::
MakeOSItalic("7-50, Compressed Gases in Cylinders")
return
:*:7-51f::
MakeOSItalic("7-51, Acetylene")
return
:*:7-53f::
MakeOSItalic("7-53, Liquefied Natural Gas (LNG)")
return
:*:7-54f::
MakeOSItalic("7-54, Natural Gas and Gas Piping")
return
:*:7-55f::
MakeOSItalic("7-55, Liquefied Petroleum Gas")
return
:*:7-58f::
MakeOSItalic("7-58, Chlorine Dioxide")
return
:*:7-59f::
MakeOSItalic("7-59, Inerting and Purging of Vessels and Equipment")
return
:*:7-61f::
MakeOSItalic("7-61, Facilities Processing Radioactive Materials")
return
:*:7-64f::
MakeOSItalic("7-64, Aluminum Industries")
return
:*:7-72f::
MakeOSItalic("7-72, Reformer and Cracking Furnace")
return
:*:7-73f::
MakeOSItalic("7-73, Dust Collectors and Collection Systems")
return
:*:7-74f::
MakeOSItalic("7-74, Distilleries")
return
:*:7-75f::
MakeOSItalic("7-75, Grain Storage and Milling")
return
:*:7-76f::
MakeOSItalic("7-76, Prevention and Mitigation of Combustible Dust Explosions and Fires")
return
:*:7-77f::
MakeOSItalic("7-77, Testing Internal Combustion Engines and Accessories")
return
:*:7-78f::
MakeOSItalic("7-78, Industrial Exhaust Systems")
return
:*:7-79f::
MakeOSItalic("7-79, Fire Protection for Gas Turbine and Electric Generators")
return
:*:7-80f::
MakeOSItalic("7-80, Organic Peroxides")
return
:*:7-83f::
MakeOSItalic("7-83, Drainage Systems for Ignitable Liquids")
return
:*:7-85f::
MakeOSItalic("7-85, Combustible and Reactive Metals")
return
:*:7-86f::
MakeOSItalic("7-86, Cellulose Nitrate")
return
:*:7-88f::
MakeOSItalic("7-88, Outdoor Ignitable Storage Tanks")
return
:*:7-89f::
MakeOSItalic("7-89, Ammonium Nitrate and Mixed Fertilizers Containing Ammonium Nitrate")
return
:*:7-91f::
MakeOSItalic("7-91, Hydrogen")
return
:*:7-92f::
MakeOSItalic("7-92, Ethylene Oxide")
return
:*:7-93f::
MakeOSItalic("7-93, Aircraft Hangars, Aircraft Manufacturing / Assembly Facilities and Protection of Aircraft Interior During Assembly")
return
:*:7-95f::
MakeOSItalic("7-95, Compressors")
return
:*:7-96f::
MakeOSItalic("7-96, Printing Plants")
return
:*:7-97f::
MakeOSItalic("7-97, Metal Cleaning")
return
:*:7-98f::
MakeOSItalic("7-98, Hydraulic Fluids")
return
:*:7-99f::
MakeOSItalic("7-99, Heat Transfer Fluid Systems")
return
:*:7-101f::
MakeOSItalic("7-101, Fire Protection for Steam Turbines and Electric Generators")
return
:*:7-103f::
MakeOSItalic("7-103, Turpentine Recovery in Pulp and Paper Mills")
return
:*:7-104f::
MakeOSItalic("7-104, Metal Treatment Processes for Steel Mills")
return
:*:7-105f::
MakeOSItalic("7-105, Concentrating Solar Power")
return
:*:7-106f::
MakeOSItalic("7-106, Ground Mounted Photovoltaic Solar Power")
return
:*:7-107f::
MakeOSItalic("7-107, Natural Gas Transmission and Storage")
return
:*:7-108f::
MakeOSItalic("7-108, Silane")
return
:*:7-109f::
MakeOSItalic("7-109, Fuel Fired Thermal Electric Power Generation Facilities")
return
:*:7-110f::
MakeOSItalic("7-110, Industrial Control Systems ")
return
:*:7-111f::
MakeOSItalic("7-111, Chemical Process Industries ")
return
:*:7-111Af::
MakeOSItalic("7-111A, Fuel-Grade Ethanol ")
return
:*:7-111Bf::
MakeOSItalic("7-111B, Carbon Black ")
return
:*:7-111Cf::
MakeOSItalic("7-111C, Titanium Dioxide")
return
:*:7-111Df::
MakeOSItalic("7-111D, Oilseed Processing ")
return
:*:7-111Ef::
MakeOSItalic("7-111E, Chloro-Alkali ")
return
:*:7-111Ff::
MakeOSItalic("7-111F, Sulfuric Acid ")
return
:*:7-111Gf::
MakeOSItalic("7-111G, Ammonia and Ammonia Derivatives ")
return
:*:7-111Hf::
MakeOSItalic("7-111H, Olefins")
return
:*:7-111If::
MakeOSItalic("7-111I, Ink, Paint and Coating Formulations")
return
:*:8-1f::
MakeOSItalic("8-1, Commodity Classification")
return
:*:8-3f::
MakeOSItalic("8-3, Rubber Tire Storage")
return
:*:8-7f::
MakeOSItalic("8-7, Baled Fiber Storage")
return
:*:8-9f::
MakeOSItalic("8-9, Storage of Class 1, 2, 3, 4 and Plastic Commodities")
return
:*:8-10f::
MakeOSItalic("8-10, Coal and Charcoal Storage")
return
:*:8-18f::
MakeOSItalic("8-18, Storage of Hanging Garments")
return
:*:8-21f::
MakeOSItalic("8-21, Roll Paper Storage")
return
:*:8-22f::
MakeOSItalic("8-22, Storage of Baled Waste Paper")
return
:*:8-23f::
MakeOSItalic("8-23, Rolled Nonwoven Fabric Storage")
return
:*:8-24f::
MakeOSItalic("8-24, Idle Pallet Storage")
return
:*:8-27f::
MakeOSItalic("8-27, Storage of Wood Chips")
return
:*:8-28f::
MakeOSItalic("8-28, Pulpwood and Outdoor Log Storage")
return
:*:8-30f::
MakeOSItalic("8-30, Storage of Carpets")
return
:*:8-33f::
MakeOSItalic("8-33, Carousel Storage and Retrieval Systems")
return
:*:8-34f::
MakeOSItalic("8-34, Protection for Automatic Storage and Retrieval Systems")
return
:*:9-0f::
MakeOSItalic("9-0, Asset Integrity")
return
:*:9-1f::
MakeOSItalic("9-1, Supervision of Property")
return
:*:9-16f::
MakeOSItalic("9-16, Burglary and Theft")
return
:*:9-18f::
MakeOSItalic("9-18, Prevention of Freeze-ups")
return
:*:9-19f::
MakeOSItalic("9-19, Wildland Fire")
return
:*:10-0f::
MakeOSItalic("10-0, The Human Factor of Property Conservation")
return
:*:10-1f::
MakeOSItalic("10-1, Pre-Incident and Emergency Response Planning")
return
:*:10-3f::
MakeOSItalic("10-3, Hot Work Management")
return
:*:10-4f::
MakeOSItalic("10-4, Contractor Management")
return
:*:10-5f::
MakeOSItalic("10-5, Disaster Recovery and Contingency Plan")
return
:*:10-6f::
MakeOSItalic("10-6, Protection Against Arson and Other Incendiary Fires")
return
:*:10-7f::
MakeOSItalic("10-7, Fire Protection Impairment Management")
return
:*:10-8f::
MakeOSItalic("10-8, Operators")
return
:*:12-2f::
MakeOSItalic("12-2, Vessels & Piping")
return
:*:12-3f::
MakeOSItalic("12-3, Continuous Digesters & Related Vessels")
return
:*:12-6f::
MakeOSItalic("12-6, Batch Digesters & Related Vessels")
return
:*:12-43f::
MakeOSItalic("12-43, Pressure Relief Devices")
return
:*:12-53f::
MakeOSItalic("12-53, Absorption Refrigeration Systems")
return
:*:13-1f::
MakeOSItalic("13-1, Cold Mechanical Repairs")
return
:*:13-2f::
MakeOSItalic("13-2, Hydroelectric Power Plants")
return
:*:13-3f::
MakeOSItalic("13-3, Steam Turbines")
return
:*:13-6f::
MakeOSItalic("13-6, Flywheels and Pulleys")
return
:*:13-7f::
MakeOSItalic("13-7, Gears")
return
:*:13-8f::
MakeOSItalic("13-8, Power Presses")
return
:*:13-10f::
MakeOSItalic("13-10, Wind Turbines and Farms")
return
:*:13-17f::
MakeOSItalic("13-17, Gas Turbines")
return
:*:13-18f::
MakeOSItalic("13-18, Industrial Clutches and Clutch Couplings")
return
:*:13-24f::
MakeOSItalic("13-24, Fans and Blowers")
return
:*:13-26f::
MakeOSItalic("13-26, Internal Combustion Engines")
return
:*:13-27f::
MakeOSItalic("13-27, Heavy Duty Mobile Equipment")
return
:*:13-28f::
MakeOSItalic("13-28, Aluminum Industries")
return
:*:17-0f::
MakeOSItalic("17-0, Asset Integrity")
return
:*:17-2f::
MakeOSItalic("17-2, Process Safety")
return
:*:17-4f::
MakeOSItalic("17-4, Monitoring and Diagnosis of Vibration in Rotating Machinery")
return
:*:17-11f::
MakeOSItalic("17-11, Chemical Reactors and Reactions")
return
:*:17-12f::
MakeOSItalic("17-12, Semiconductor Fabrication Facilities")
return
:*:17-16f::
MakeOSItalic("17-16, Cranes")
return


::nfpa 13::
MakeOSItalic("NFPA 13, Installation of Sprinkler Systems")
return

::nfpa 25::
MakeOSItalic("NFPA 25, Standard for the Inspection, Testing and Maintenance of Water-Based Fire Protection Systems")
return
*/
;---------------------------------------------------------------------------
