scriptname LTT_CheskoFrostfall exends LTT_ModBase

string	LTT_Name		= "Chesko Frostfall" AutoReadOnly
string	LTT_ESP			= "Chesko_Frostfall.esp" AutoReadonly
int	fID_Pelt		= 0x041045
 
;;;;;;;;;;;;;;;;;;;;
; Chesko_Frostfall [ version < 3 ]
; Camping
float	FF_CraftStickHrs	= LTT_CraftStaffHrs
float	FF_CraftTorchMins	= 15.0
float	FF_CraftPotHrs		= 1.0
float	FF_CraftPackHrs		= 2.0
float	FF_CraftSmTentHrs	= 4.0
float	FF_CraftLgTentHrs	= 6.0
float	FF_CraftHatchetHrs	= LTT_CraftOneHanded
float	FF_CraftAmmoHrs		= LTT_CraftAmmoHrs
; Materials
float	FF_CraftCloakHrs	= 2.0
float	FF_CraftPeltHrs		= LTT_CraftBodyHrs * 0.2
float	FF_CraftLaceMins	= 30.0
; Craft Crafting Stations
float	FF_CraftTanRackMins	= 45.0
float	FF_CraftMortarHrs	= 2.0
float	FF_CraftEnchantHrs	= 1.0

;;;;;;;;;;;;;;;;;;;;
; Chesko_Frostfall < 3
Form[]	FF_FormCloaks
Form	FF_FormStick
Form	FF_FormTorch
Form	FF_FormCookpot
Form[]	FF_FormBackpacks
Form[]	FF_FormSmallTents
Form[]	FF_FormLargeTents
Form	FF_FormHatchet
Form	FF_FormLinen
Form	FF_FormPelt
Form	FF_FormLace
Form	FF_FormTanRack
Form	FF_FormMortar
Form	FF_FormEnchanter

;;;;;;;;;;;
;;;;;;;;;;;
;;;;;;;;;;;
;;;;;;;;;;;
;;;;;;;;;;;

Function Init_FF_Items()

	FF_Items_Pelt = Game.GetFormFromFile(0x041045, "Chesko_Frostfall.esp")
	FF_Prefix = GetFormPrefix(FF_Items_Pelt)
	_is_FF_Active = FF_Prefix > 0
	DebugMode("FF prefix: " + FF_Prefix)

	If !_is_FF_Active
		Return
	EndIf
	
	FF_Items_Cloaks = new Form[4]
	FF_Items_Cloaks[0]			= Game.GetFormFromFile(0x03FA9C, "Chesko_Frostfall.esp") ; "Travel Cloak, Burlap" [ARMO:0203FA9C]
	FF_Items_Cloaks[1]			= Game.GetFormFromFile(0x03FA9E, "Chesko_Frostfall.esp") ; "Travel Cloak, Fur" [ARMO:0203FA9E]
	FF_Items_Cloaks[2]			= Game.GetFormFromFile(0x03FA9F, "Chesko_Frostfall.esp") ; "Travel Cloak, Hide" [ARMO:0203FA9F]
	FF_Items_Cloaks[3]			= Game.GetFormFromFile(0x03FA9D, "Chesko_Frostfall.esp") ; "Travel Cloak, Linen" [ARMO:0203FA9D]

	FF_Items_Stick				= Game.GetFormFromFile(0x03C96B, "Chesko_Frostfall.esp") ; "Walking Stick" [WEAP:0203C96B]
	FF_Items_Torch				= Game.GetFormFromFile(0x019DAF, "Chesko_Frostfall.esp") ; "Torch" [MISC:02019DAF]
	FF_Items_Cookpot			= Game.GetFormFromFile(0x019849, "Chesko_Frostfall.esp") ; " Cooking Pot" [MISC:02019849]

	FF_Items_Backpacks = new Form[3]
	FF_Items_Backpacks[0]		= Game.GetFormFromFile(0x02C261, "Chesko_Frostfall.esp") ; "Backpack, Black Fur" [ARMO:0202C261]
	FF_Items_Backpacks[1]		= Game.GetFormFromFile(0x02C260, "Chesko_Frostfall.esp") ; "Backpack, Brown Fur" [ARMO:0202C260]
	FF_Items_Backpacks[2]		= Game.GetFormFromFile(0x02C262, "Chesko_Frostfall.esp") ; "Backpack, White Fur" [ARMO:0202C262]

	FF_Items_SmallTents = new Form[4]
	FF_Items_SmallTents[0]		= Game.GetFormFromFile(0x036B4E, "Chesko_Frostfall.esp") ; " Small Fur Tent, Bed Roll" [MISC:02036B4E]
	FF_Items_SmallTents[1]		= Game.GetFormFromFile(0x0624FB, "Chesko_Frostfall.esp") ; " Small Fur Tent, 2x Bed Roll" [MISC:020624FB]
	FF_Items_SmallTents[2]		= Game.GetFormFromFile(0x01A314, "Chesko_Frostfall.esp") ; " Small Leather Tent, Bed Roll" [MISC:0201A314]
	FF_Items_SmallTents[3]		= Game.GetFormFromFile(0x036B70, "Chesko_Frostfall.esp") ; " Small Leather Tent, 2x Bed Roll" [MISC:02036B70]

	FF_Items_LargeTents = new Form[7]
	FF_Items_LargeTents[0]		= Game.GetFormFromFile(0x01A348, "Chesko_Frostfall.esp") ; " Large Fur Tent, Bed Roll" [MISC:0201A348]
	FF_Items_LargeTents[1]		= Game.GetFormFromFile(0x01A347, "Chesko_Frostfall.esp") ; " Large Fur Tent, 2x Bed Roll" [MISC:0201A347]
	FF_Items_LargeTents[2]		= Game.GetFormFromFile(0x01A33E, "Chesko_Frostfall.esp") ; " Large Fur Tent, 3x Bed Roll" [MISC:0201A33E]
	FF_Items_LargeTents[3]		= Game.GetFormFromFile(0x01A33D, "Chesko_Frostfall.esp") ; " Large Fur Tent, 4x Bed Roll" [MISC:0201A33D]
	FF_Items_LargeTents[4]		= Game.GetFormFromFile(0x038CBC, "Chesko_Frostfall.esp") ; " Large Leather Tent, Bed Roll" [MISC:02038CBC]
	FF_Items_LargeTents[5]		= Game.GetFormFromFile(0x038CBD, "Chesko_Frostfall.esp") ; " Large Leather Tent, 2x Bed Roll" [MISC:02038CBD]
	FF_Items_LargeTents[6]		= Game.GetFormFromFile(0x038CBE, "Chesko_Frostfall.esp") ; " Large Leather Tent, 3x Bed Roll" [MISC:02038CBE]

	FF_Items_Hatchet			= Game.GetFormFromFile(0x04103D, "Chesko_Frostfall.esp") ; "Stone Hatchet" [WEAP:0204103D]
	FF_Items_Linen				= Game.GetForm(0x00034CD6) ; "Linen Wrap" [MISC:00034CD6]
	FF_Items_Lace				= Game.GetFormFromFile(0x041044, "Chesko_Frostfall.esp") ; "Hide Lace" [MISC:02041044]
	FF_Items_TanRack			= Game.GetFormFromFile(0x036B4F, "Chesko_Frostfall.esp") ; "Tanning Rack" [MISC:02036B4F]
	FF_Items_Mortar				= Game.GetFormFromFile(0x038689, "Chesko_Frostfall.esp") ; "Mortar and Pestle" [MISC:02038689]
	FF_Items_Ench				= Game.GetFormFromFile(0x038680, "Chesko_Frostfall.esp") ; "Enchanting Supplies" [MISC:02038680]

EndFunction

Bool Function Check_FF_Craft(Form akBaseItem, int aiType, int aiItemCount)
	DebugMode("Check_FF_Craft...")

	Float t
	Float totalBaseTime

	If akBaseItem == FF_Items_Pelt
		totalBaseTime = ffPeltTime * aiItemCount
		DebugMode("Cleaned pelt. Base time = " + ffPeltTime + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)

	ElseIf akBaseItem == FF_Items_Lace
		t = ToMinutes(ffLaceTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Hide lace. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)

	ElseIf akBaseItem == FF_Items_Linen
		t = ToMinutes(ffLinenTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Linen wrap. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)

	ElseIf akBaseItem == FF_Items_Torch
		t = ToMinutes(ffTorchTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Torch. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)

	ElseIf akBaseItem == FF_Items_Stick
		t = ToMinutes(ffStickTime)
		DebugMode("Walking stick. Base time = " + t)
		TimeCalc(t)

	ElseIf akBaseItem == FF_Items_Cookpot
		DebugMode("Cookpot. Base time = " + ffCookpotTime)
		TimeCalc(ffCookpotTime)

	ElseIf akBaseItem == FF_Items_TanRack
		t = ToMinutes(ffTanRackTime)
		DebugMode("Tanning rack. Base time = " + t)
		TimeCalc(t)

	ElseIf akBaseItem == FF_Items_Mortar
		DebugMode("Mortar and pestle. Base time = " + ffMortarTime)
		TimeCalc(ffMortarTime)

	ElseIf akBaseItem == FF_Items_Ench
		DebugMode("Enchanting supplies. They're so enchanting! Base time = " + ffEnchTime)
		TimeCalc(ffEnchTime)

	ElseIf FF_Items_Cloaks.Find(akBaseItem) > -1
		DebugMode("Cloak. Base time = " + ffCloakTime)
		TimeCalc(ffCloakTime)

	ElseIf FF_Items_Backpacks.Find(akBaseItem) > -1
		If FF_Split_Pack
			DebugMode("Backpack, but ignored due to splitter.")
			FF_Split_Pack = False
		Else
			DebugMode("Backpack. Base time = " + ffBackpackTime)
			TimeCalc(ffBackpackTime)
		EndIf

	ElseIf FF_Items_SmallTents.Find(akBaseItem) > -1
		DebugMode("Small tent. Base time = " + ffSmallTentTime)
		TimeCalc(ffSmallTentTime)

	ElseIf FF_Items_LargeTents.Find(akBaseItem) > -1
		DebugMode("Large tent. Base time = " + ffLargeTentTime)
		TimeCalc(ffLargeTentTime)

	ElseIf akBaseItem == FF_Items_Hatchet
		t = ToMinutes(ffHatchetTime)
		DebugMode("Stone hatchet. Base time = " + t)
		TimeCalc(t)

	ElseIf aiType == 26
		int majorId = akBaseItem.GetFormID()
		int mask = Math.LeftShift(FF_Prefix, 24)
		int minorId = majorId - mask
		If minorId >= 0x04AD67 && minorId <= 0x04AD84
			DebugMode("Splitter. Ignoring next backpack and next jewelry.")
			FF_Split_Pack = True
			FF_Split_Amulet = True
		EndIf

	ElseIf aiType == 42
		DebugMode("Arrows. Base time = " + ffArrowsTime) ; ffArrowsTime is the time for one whole *batch* (of 24)
		TimeCalc(ffArrowsTime)

	Else
		DebugMode("No match found. This one's free!")
	EndIf

	Return True

EndFunction
