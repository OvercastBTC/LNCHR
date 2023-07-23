﻿;============================== Start Auto-Execution Section ==============================
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


;---------------------------------------------------------------------------
;                              CHANGELOG
;---------------------------------------------------------------------------

; Version 3 - 7 Mar 2023
; OS Titles now input in italics except for Horizon.

; Version 2.0 - Released 3/6/2023
; Added the Shift+Ctrl+WIN+O hot key for fast launch of a specific OS.;


; Version 1.0 - Released 2/24/2023
; Modified to correct a few standard titles and add the "densityf" hotstring with input for the varibles.
; Also modified to break this script out into a sub-script to make maintenance easier for users, so they
; are not forced to update the starter script with all the personal information, which likely won't change
; as much as the sub-scripts.


;---------------------------------------------------------------------------
;                      OS Abbreviations
;---------------------------------------------------------------------------
/*
:*:cbr::
str_in:=""
L1:="Manually exercise, inspect, service, lubricate, and test all critical/main low-voltage circuit breakers every three to five years in accordance with the manufactures guidelines' and/or industry standards as applicable. If there are no manufacturer guidelines or industry standards, use Tables 1a and 1b of FM Global Property Loss Prevention Data Sheet "
Clipboard := % L1
ClipWait,1
Send, ^v
Sleep, 300
str_in:="5-19, Switchgear and Circuit Breakers"
MakeOSItalic(str_in)
str_in:=""
L2:=", Section 2.1.4 "
Clipboard := % L2
ClipWait,1
Send, ^v
Sleep, 300
str_in:=""
str_in:= "Switchgear and Circuit Breakers Testing and Maintenance."
MakeOSItalic(str_in)
L3:="`nTesting should focus on:`n - First circuit breaker downstream of the utility transformer`n - Circuit breakers rated >1000-A`n - Circuit breakers considered critical to production"
Clipboard := % L3
ClipWait,1
Send, ^v
return
*/

:*:1-0f::
MakeOSItalic("1-0, Safeguards During Construction, Alteration and Demolition")
return
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
MakeOSItalic("5-19, Switchgear and Circuit Breakers")
return
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
MakeOSItalic("7-11, Belt Conveyors")
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
MakeOSItalic("10-1, Pre-Incident Planning with the Public Fire Service")
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

;---------------------------------------------------------------------------
;                          General Abbreviations
;---------------------------------------------------------------------------

:*:agf::Approval Guide
:*:FMDSf::FM Global Property Loss Prevention Data Sheet
::sgsv::seismic gas shutoff valve
:*:erpf::emergency response plan
:*:ferpf::flood emergency response plan
::wst::water supply tool
::efc::eFC
::wdt::water delivery time
:*:wpivf::wall post-indicator valve
:*:pivf::post-indicator valve
:*:ulf::Underwriters Laboratories
:*:uupf::uncartoned unexpanded plastic
:*:uepf::uncartoned expanded plastic
:*:cupf::cartoned unexpanded plastic
:*:cepf::cartoned expanded plastic
:*:sopf::standard operating procedure (SOP)
:*:eopf::emergency operating procedure (EOP)
::ooo::out of office
::OSY::OS&Y
::sq.ft.::sq. ft.
:*:oemf::original equipment manufacturer (OEM)
:*:ndef::nondestructive examination (NDE)
:*:ndtf::nondestructive testing (NDT)
:*:ndetf::nondestructive examination/testing (NDE/T)
:*:mehpf::minimum end head pressure
:*:mawpf::maximum allowable working pressure (MAWP)
:*:mipf::metal insulating panels
::lwco::low water cutout (LWCO)
::lwfco::low-water fuel cutoff
::lfpil::low flash point ignitable liquid
::hfpil::high flash point ignitable liquid
:*:lmgtfy::https://letmegooglethat.com/?q=
:*:itmf::inspection, testing, and maintenance (ITM)
:*:irasf::in-rack automatic sprinklers
::il::ignitable liquid
:*:hrlf::higher RelativeLikelihood
:*:htff::heat transfer fluid
::gp::generally protected
:*:FMRTPS::FM Global Red Tag Permit System
:*:FMHWPS::FM Global Hot Work Permit System
:*:FMDSl::Data Sheet
:*:FMA::FM Approved
:*:FMILSC::FM Approved Ignitable Liquid Storage Cabinet
:*:FRPf::fiber-reinforced plastic panels
:*:epof::emergency power off
:*:blrbf::black liquor recovery boiler
::efile::eFile
#IfWinActive ahk_exe AutoHotkeyU32.exe
	:*:ds ::Data Sheet
#IfWinActive
:*:icsf::industrial control systems (ICS)
:*:icsfl::industrial control systems (ICS), or the information/operational technology (IT/OT) networks
:*:otf::operational technology network (OT)
:*:itf::information technology network (IT)
::mfaf::multi factor authentication (MFA)
:*:bmf::boiler and machinery (B&M)
:*:fnhf::fire and natural hazards (F&NH)
::2oo3::two out of three-voting logic
::ostt::overspeed trip test
::o/s::overspeed
::the majority of::most of
::in the near future::soon
::as a result of::because of
::recs::recommendations
:*:cbtf::computer-based training
:*:densityf::								; input density and area in statement
InputBox, density, Sprinkler System Density,Density in gpm/sq. ft.,,300,125
InputBox, area, Demand Area, Area in sq. ft.,,300,125
Send %density% gpm/sq. ft. over %area% sq. ft.
return

;---------------------------------------------------------------------------
;                    Brand Assurance Spellings/Language
;---------------------------------------------------------------------------
::<FM>::FM Diamond
::FM diamond::FM Diamond
::FMG::FM Global
::not FM approved::non-FM Approved
::not FM Approved::non-FM Approved
::non-storage sprinkler::nonstorage sprinkler
::bd.ft.::bd. ft.
::kva::kVA
::KVA::kVA
::hz::Hz
::HZ::Hz
::KV::kV
::kv::kV
::KW::kW
::kw::kW
::anti-virus::antivirus
::anti-siphon::antisiphon
::anti-freeze::antifreeze
::auto-ignite::autoignite
::built up roof::built-up roof
::C clamp::C-clamp
::cross main::crossmain
::feed main::feedmain
::branchline::branch line
::crawlspace::crawl space
::cyberattack::cyber attack
::cyber-attack::cyber attack
::cybersecurity::cyber security
::cybercrime::cyber crime
::cyberhygiene::cyber hygiene
::cyber space::cyberspace
::cyberwarfare::cyber warfare
::cyberrisk::cyber risk
::cyberevent::cyber event
::decision maker::decision-maker
::double row racks::double-row racks
::single row racks::single-row racks
::multi row racks::multi-row racks
::double stacked::double-stacked
::dry type system::dry-type system
::dry pipe valve::dry-pipe valve
::firewatch::fire watch
::four way brace::four-way brace
::guard house::guardhouse
::half life::half-life
::half full::half-full
::head end::headend
::K factor::K-factor
::liquid level indicator::liquid-level indicator
::low liquid level::low-liquid level
::multi-rack::multirack
::main frame::mainframe
::multi-story::multistory
::molded case circuit breaker::molded-case circuit breaker (MCCB)
::waste paper::wastepaper
::waste water::wastewater
::wild fire::wildfire
::wild land fire::wildland fire
::water tube::watertube
::fire tube::firetube
::i.e.::e.g., 


;---------------------------------------------------------------------------
;                           Inclusive Language
;---------------------------------------------------------------------------
::manned::attended
::man door::personnel door
::crewman::crew member
::chairman::chairperson
::fireman::firefighter
::foreman::supervisor
::manpower::workforce
::manhole::maintenance hole
::policeman::police officer
::spokesman::spokesperson
::undermanned::understaffed
::watchman::security guard
::whitelisting::allowlisting
::blacklisting::blocklisting
::whitelist::allowlist
::blacklist::blocklist

;--------------------------------------------------------------------------
;          Shift+Ctrl+WIN+O to Open OS
;--------------------------------------------------------------------------
^+#o::
InputBox, inputos,Jump to Operating Standard,Enter Desired OS (e.g.`, 8-9),,300,125
outputos1 = C:\Users\
outputos1a = \FM Global\Operating Standards - Documents\opstds\
outputos2 = fm.pdf
Run, AcroRd32.exe %outputos1%%A_UserName%%outputos1a%%inputos%%outputos2% ; use ctrl+Shift+WIN+o
return