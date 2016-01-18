scriptname LTT_Campfire extends LTT_ModBase 

string	property LTT_Name	= "Campfire" AutoReadOnly
string	property LTT_ESP	= "Campfire.esm" AutoReadonly
int	fID_DummyItem		= 0x0468D3

;;;;;;;;;;;;;;;;;;;;
; Campfire
; Camping
float	CF_CraftStickHrs	= LTT_CraftStaffHrs
float	CF_CraftTorchMins	= FF_CraftTorchMins
float	CF_CraftPotHrs		= FF_CraftPotHrs
float	CF_CraftPackHrs		= FF_CraftPackHrs
float	CF_CraftBeddingHrs	= 3.0
float	CF_CraftSmTentHrs	= FF_CraftSmTentHrs
float	CF_CraftLgTentHrs	= FF_CraftLgTentHrs
float	CF_CraftHatchetHrs	= LTT_CraftOneHanded
float	CF_CraftAmmHrs		= LTT_CraftAmmoHrs
; Materials
float	CF_CraftCloakHrs	= FF_CraftCloakHrs
float	CF_CraftPeltHrs		= LTT_CraftBodyHrs * 0.2
float	CF_CraftLaceMins	= FF_CraftLaceMins
; Craft Stations
float	CF_CraftTanRackMins	= FF_CraftTanRackMins
float	CF_CraftMortarHrs	= FF_CraftMortarHrs
float	CF_CraftEnchantHrs	= FF_CraftEnchantHrs
; Firecraft
bool	CF_FirePerkImproves	= true
float	CF_FireMakeTinderMins	= 15.0
float	CF_FireMakeKindlingMins	= 5.0
float	CF_FireAddTinderMins	= 15.0
float	CF_FireAddKindlingMin	= 10.0
float	CF_FireLightFireTime	= 25.0
float	CF_FireAddFuelTime	= 5.0

;;;;;;;;;;;;;;;;;;;;
; Campfire
Form	CF_FormBlankItem
Form[]	CF_FormCloaks
Form	CF_FormStick
Form	CF_FormTorch
Form	CF_FormTorchDeconstruct
Form	CF_FormCookpot
Form[]	CF_FormBackpacks
Form	CF_FormRoughBedding
Form[]	CF_FormSmallTents_1BR
Form[]	CF_FormLargeTents_1BR
Form[]	CF_FormSmallTents_MoreBR
Form[]	CF_FormLargeTents_MoreBR
Form	CF_FormHatchet
; Materials
Form	CF_FormLinen
Form	CF_FormFurPlate
Form	CF_FormLace
Form	CF_FormTanRack
Form	CF_FormMortar
Form	CF_FormEnch
; Firecraft
Form	CF_GlobFirecraftRank	; _Camp_PerkRank_Firecraft [GLOB:240473E5]
Form[]	CF_FormTinder		; Paper, WOod Shavings
Form	CF_FormKindling		; Kindling

function ItemAdded( Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akContainer )
endfunction

function ItemRemoved( form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akContainer )
endfunction

Function Init_CF_Items()
	DebugMode( "Initializing Campfire Items" );
	CF_Fire_Firecraft = None
	CF_Prefix = 0
	_is_CF_Active = true

	; Try to get a mod object
	CF_Fire_Firecraft = Game.GetFormFromFile(0x0473E5, "Campfire.esm") as GlobalVariable ; _Camp_PerkRank_Firecraft
	if !CF_Fire_Firecraft
		_is_CF_Active = false
		return
	endif

	; Try to get the base Mod ID
	CF_Prefix = GetFormPrefix(CF_Fire_Firecraft)
	DebugMode("CF prefix: " + CF_Prefix)
	if CF_Prefix <= 0
		_is_CF_Active = false
		return
	endif

	; Camping Items
	CF_BlankItem 			= Game.GetFormFromFile(0x0468D3, "Campfilre.esm") ; _Camp_BlankItem [MISC:240468D3]

	CF_Items_Cloaks = new Form[4]
	CF_Items_Cloaks[0]		= Game.GetFormFromFile(0x03FA9C, "Campfire.esm") ; "Travel Cloak, Burlap" [ARMO:0203FA9C]
	CF_Items_Cloaks[1]		= Game.GetFormFromFile(0x03FA9E, "Campfire.esm") ; "Travel Cloak, Fur" [ARMO:0203FA9E]
	CF_Items_Cloaks[2]		= Game.GetFormFromFile(0x03FA9F, "Campfire.esm") ; "Travel Cloak, Hide" [ARMO:0203FA9F]
	CF_Items_Cloaks[3]		= Game.GetFormFromFile(0x03FA9D, "Campfire.esm") ; "Travel Cloak, Linen" [ARMO:0203FA9D]

	CF_Items_Stick			= Game.GetFormFromFile(0x0250CA, "Campfire.esm") ; "Walking Stick" [ARMO:240250CA]
	CF_Items_Torch			= Game.GetFormFromFile(0x05C373, "Campfire.esm") ; "Kindling, Linen Wrap" [MISC:2405C373]
	CF_Items_TorchDeconstruct	= Game.GetFormFromFile(0x019DAF, "Campfire.esm") ; "Torch" [MISC:02019DAF]
	CF_Items_Cookpot		= Game.GetFormFromFile(0x019849, "Campfire.esm") ; " Cooking Pot" [MISC:02019849]

	CF_Items_Backpacks = new Form[3]
	CF_Items_Backpacks[0]		= Game.GetFormFromFile(0x02C260, "Campfire.esm") ; "Backpack, Brown Fur" [ARMO:0202C260]
	CF_Items_Backpacks[1]		= Game.GetFormFromFile(0x02C261, "Campfire.esm") ; "Backpack, Black Fur" [ARMO:0202C261]
	CF_Items_Backpacks[2]		= Game.GetFormFromFile(0x02C262, "Campfire.esm") ; "Backpack, White Fur" [ARMO:0202C262]

	CF_Items_RoughBedding		= Game.GetFormFromFile(0x0536E4, "Campfire.esm") ; " Rough Bedding" [MISC:240536E4]

	CF_Items_SmallTents_1BR = new Form[2]
	CF_Items_SmallTents_1BR[0]	= Game.GetFormFromFile(0x036B4E, "Campfire.esm") ; " Small Fur Tent, Bed Roll" [MISC:02036B4E]
	CF_Items_SmallTents_1BR[1]	= Game.GetFormFromFile(0x01A314, "Campfire.esm") ; " Small Leather Tent, Bed Roll" [MISC:0201A314]

	CF_Items_SmallTents_MoreBR = new Form[2]
	CF_Items_SmallTents_MoreBR[0]	= Game.GetFormFromFile(0x0624FB, "Campfire.esm") ; " Small Fur Tent, 2x Bed Roll" [MISC:020624FB]
	CF_Items_SmallTents_MoreBR[1]	= Game.GetFormFromFile(0x036B70, "Campfire.esm") ; " Small Leather Tent, 2x Bed Roll" [MISC:02036B70]

	CF_Items_LargeTents_1BR = new Form[2]
	CF_Items_LargeTents_1BR[0]	= Game.GetFormFromFile(0x01A348, "Campfire.esm") ; " Large Fur Tent, Bed Roll" [MISC:0201A348]
	CF_Items_LargeTents_1BR[1]	= Game.GetFormFromFile(0x038CBC, "Campfire.esm") ; " Large Leather Tent, Bed Roll" [MISC:02038CBC]

	CF_Items_LargeTents_MoreBR = new Form[5]
	CF_Items_LargeTents_MoreBR[0]	= Game.GetFormFromFile(0x01A347, "Campfire.esm") ; " Large Fur Tent, 2x Bed Roll" [MISC:0201A347]
	CF_Items_LargeTents_MoreBR[1]	= Game.GetFormFromFile(0x01A33E, "Campfire.esm") ; " Large Fur Tent, 3x Bed Roll" [MISC:0201A33E]
	CF_Items_LargeTents_MoreBR[2]	= Game.GetFormFromFile(0x01A33D, "Campfire.esm") ; " Large Fur Tent, 4x Bed Roll" [MISC:0201A33D]
	CF_Items_LargeTents_MoreBR[3]	= Game.GetFormFromFile(0x038CBD, "Campfire.esm") ; " Large Leather Tent, 2x Bed Roll" [MISC:02038CBD]
	CF_Items_LargeTents_MoreBR[4]	= Game.GetFormFromFile(0x038CBE, "Campfire.esm") ; " Large Leather Tent, 3x Bed Roll" [MISC:02038CBE]

	CF_Items_Hatchet		= Game.GetFormFromFile(0x04103D, "Campfire.esm") ; "Stone Hatchet" [WEAP:0204103D]

	; Materials
	CF_Items_Linen			= Game.GetForm(0x00034CD6) ; "Linen Wrap" [MISC:00034CD6]
	CF_Items_FurPlate		= Game.GetFormFromFile(0x1da0bf1, "Campfire.esm") ; "Fur Plate" [MISC:01DA0BF1]
	CF_Items_Lace			= Game.GetFormFromFile(0x1CC0606, "Campfire.esm") ; "Hide Lace" [MISC:01CC0606]
	CF_Items_TanRack		= Game.GetFormFromFile(0x036B4F, "Campfire.esm") ; "Tanning Rack" [MISC:02036B4F]
	CF_Items_Mortar			= Game.GetFormFromFile(0x038689, "Campfire.esm") ; "Mortar and Pestle" [MISC:02038689]
	CF_Items_Ench			= Game.GetFormFromFile(0x038680, "Campfire.esm") ; "Enchanting Supplies" [MISC:02038680]

	; Firecraft
	CF_Fire_Tinder = new Form[2]
	CF_Fire_Tinder[0]		= Game.GetFormFromFile(0x02EC4A, "Campfire.esm") ; _Camp_Tinder "Tinder" [MISC:2402EC4A]
	CF_Fire_Tinder[1]		= Game.GetFormFromFile(0x05A836, "Campfire.esm") ; "Wood Shavings" [MISC:2405A836]
	CF_Fire_Kindling		= Game.GetFormFromFile(0x02E68F, "Campfire.esm") ; _Camp_Kindling "Kindling" [MISC:2402E68F]
EndFunction

Float Function FirecraftModifier( Float TV )
	Float NewTV = TV
	if cfFirecraftImproves
		NewTV = TV - ( TV * ( CF_Fire_Firecraft.GetValueInt() * 0.2 ) )
	endif
	return NewTV
endFunction

bool Function HandleFirepit( Form akBaseItem )
	; Get the base editor ID of the object, rather than have a list of all ~150 'books'
	; This really only works if the items are sequential.
	int majorId = akBaseItem.GetFormID()
	int mask = Math.LeftShift(CF_Prefix, 24)
	int minorId = majorId - mask

	; Act Values:
	;   -1 = Unhandled
	;    0 = Lighting with spells/torches
	;    1 = Lighting the hard way
	;    2 = Add Tinder
	;    3 = Add Fuel/Kindling
	;    4 = Stoke the fire
	int Act = -1

	If minorId >= 0x032E28 && minorId <= 0x032E2A
		Act = 3
	ElseIf minorId >= 0x03338D && minorId <= 0x033393
		Act = 4
	ElseIf minorId >= 0x0468C1 && minorId <= 0x05A84A
		Act = 2
	Elseif minorId == 0x05A851 || minorId == 0x05A852
		Act = 0
	Elseif minorId == 0x05A853
		Act = 1
	ElseIf minorId >= 0x05B318 && minorId <= 0x05B321
		Act = 2
	ElseIf minorId >= 0x05BE06 && minorId <= 0x05BE0F
		Act = 4
	EndIf

	if Act == 0
		return TimeCalc( ToMinutes( cfLightFireTime * 0.25 ) )
	ElseIf Act == 1
		return( TimeCalc( ToMinutes( FirecraftModifier( cfLightFireTime ) ) ) )
	ElseIf Act == 2
		return( TimeCalc( ToMinutes( FirecraftModifier( cfAddTinderTime ) ) ) )
	ElseIf Act == 3
		return( TimeCalc( ToMinutes( FirecraftModifier( cfAddKindlingTime ) ) ) )
	ElseIf Act == 4
		return( TimeCalc( ToMinutes( FirecraftModifier( cfAddFuelTime ) ) ) )
	EndIf

	return False
endFunction

Bool Function HandleCampfireMod(Form akBaseItem, int aiType, int aiItemCount)
	DebugMode("Handle Campfire Mods")
	if !( prefix == CF_Prefix || akBaseItem == CF_Items_Linen || akBaseItem == CF_Items_Lace )
		return false
	endif

	Float t
	Float totalBaseTime

	if akBaseItem == CF_BlankItem
		return true
	endif

	; Camping Items

	If CF_Items_Cloaks.Find(akBaseItem) > -1
		DebugMode("Cloak. Base time = " + cfCloakTime)
		return TimeCalc(cfCloakTime)

	ElseIf akBaseItem == CF_Items_Stick
		t = ToMinutes(cfStickTime)
		DebugMode("Walking stick. Base time = " + t)
		return TimeCalc(t)

	ElseIf akBaseItem == CF_Items_Torch
		t = ToMinutes(cfTorchTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Torch. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		return TimeCalc(totalBaseTime)

	ElseIf akBaseItem == CF_Items_TorchDeconstruct
		t = ToMinutes(cfTorchTime)
		totalBaseTime = t * aiItemCount * 0.5
		CF_Splitting_Torch = true
		CF_Splitting_Linen = true
		DebugMode("Splitting Torch")
		return TimeCalc(totalBaseTime)

	ElseIf akBaseItem == CF_Items_Cookpot
		DebugMode("Cookpot. Base time = " + cfCookpotTime)
		return TimeCalc(cfCookpotTime)

	ElseIf CF_Items_Backpacks.Find(akBaseItem) > -1
		If CF_Splitting_Pack
			DebugMode("Backpack, but ignored due to splitter.")
			CF_Splitting_Pack = False
			return true
		EndIf
		DebugMode("Backpack. Base time = " + cfBackpackTime)
		return TimeCalc(cfBackpackTime)

	ElseIf aiType == 26
		; Get the base editor ID of the object, rather than have a list of all ~50 backpacks
		; This really only works if the items are sequential.
		int majorId = akBaseItem.GetFormID()
		int mask = Math.LeftShift(CF_Prefix, 24)
		int minorId = majorId - mask
		If minorId >= 0x04AD67 && minorId <= 0x04AD84
			DebugMode("Splitter. Ignoring next backpack and next jewelry.")
			CF_Splitting_Pack = True
			CF_Splitting_Amulet = True
			return True
		EndIf

	Elseif akBaseItem == CF_Items_RoughBedding
		totalBaseTime = cfBeddingTime * aiItemCount * 0.5
		DebugMode("Rough bedding. Base time = " + cfBeddingTime + "; x" + aiItemCount + " x 0.5 = " + totalBaseTime)
		return TimeCalc(totalBaseTime)

	ElseIf CF_Items_SmallTents_1BR.Find(akBaseItem) > -1
		if CF_Splitting_Bedroll
			DebugMode("This is the free tent")
			return true
		endif
		DebugMode("Small tent. Base time = " + cfSmallTentTime)
		return TimeCalc(cfSmallTentTime)

	ElseIf CF_Items_LargeTents_1BR.Find(akBaseItem) > -1
		if CF_Splitting_Bedroll
			DebugMode("This is the free tent")
			return true
		endif
		DebugMode("Large tent. Base time = " + cfLargeTentTime)
		return TimeCalc(cfLargeTentTime)

	ElseIf ( CF_Items_SmallTents_MoreBR.Find(akBaseItem) > -1 || CF_Items_LargeTents_MoreBR.Find(akBaseItem) > -1 )
		if CF_Splitting_Bedroll
			DebugMode("This is the free tent")
			return true
		endif
		DebugMode("Adding a bedroll to a tent. Base time = " + cfBeddingTime)
		return TimeCalc(cfBeddingTime)

	ElseIf akBaseItem == CF_Items_Hatchet
		t = ToMinutes(cfHatchetTime)
		DebugMode("Stone hatchet. Base time = " + t)
		return TimeCalc(t)

	ElseIf aiType == 42
		DebugMode("Arrows. Base time = " + cfArrowsTime) ; cfArrowsTime is the time for one whole *batch* (of 24)
		return TimeCalc(cfArrowsTime)

	; Materials

	ElseIf akBaseItem == CF_Items_Linen
		if CF_Splitting_Linen
			DebugMode("Free Linen from deconstructed torch")
			CF_Splitting_Linen = false
			return true
		endif
		t = ToMinutes(cfLinenTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Linen wrap. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		return TimeCalc(totalBaseTime)

	ElseIf akBaseItem == CF_Items_FurPlate
		totalBaseTime = cfFurTime * aiItemCount
		DebugMode("Fur plate. Base time = " + cfFurTime + "; x" + aiItemCount + " = " + totalBaseTime)
		return TimeCalc(totalBaseTime)

	ElseIf akBaseItem == CF_Items_Lace
		t = ToMinutes(cfLaceTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Hide lace. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		return TimeCalc(totalBaseTime)

	ElseIf akBaseItem == CF_Items_TanRack
		t = ToMinutes(cfTanRackTime)
		DebugMode("Tanning rack. Base time = " + t)
		return TimeCalc(t)

	ElseIf akBaseItem == CF_Items_Mortar
		DebugMode("Mortar and pestle. Base time = " + cfMortarTime)
		return TimeCalc(cfMortarTime)

	ElseIf akBaseItem == CF_Items_Ench
		DebugMode("Enchanting supplies. They're so enchanting! Base time = " + cfEnchTime)
		return TimeCalc(cfEnchTime)

	; Firecraft
	ElseIf CF_Fire_Tinder.find(akBaseItem) > -1 ; Making tinder
		t = ToMinutes(cfMakeTinderTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Tinder. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		return TimeCalc(FirecraftModifier(totalBaseTime))

	ElseIf akBaseItem == CF_Fire_Kindling ; Making kindling
		if CF_Splitting_Torch
			DebugMode("Free kindling from deconstructed torch")
			CF_Splitting_Torch = false
			return true
		endif
		t = ToMinutes(cfMakeKindlingTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Kindling. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		return TimeCalc(FirecraftModifier(totalBaseTime))

	EndIf

	DebugMode("No match found in CF, leaving this for another handler")

	Return false

EndFunction

