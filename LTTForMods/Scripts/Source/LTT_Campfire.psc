scriptname LTT_Campfire extends LTT_ModBase

;///////////////////////////////////////////////////////////////////////////////
// Prop Trackers
/;
int	prop_CloakHrs		= -1
int	prop_StickMins		= -1
int	prop_TorchMins		= -1
int	prop_CookpotHrs		= -1
int	prop_BackpackHrs	= -1
int	prop_BeddingHrs		= -1
int	prop_SmallTentHrs	= -1
int	prop_LargeTentHrs	= -1
int	prop_HatchetHrs		= -1
int	prop_ArrowsHrs		= -1
int	prop_LinenMins		= -1
int	prop_FurHrs		= -1
int	prop_LaceMins		= -1
int	prop_TanRackMins	= -1
int	prop_MortarHrs		= -1
int	prop_EnchanterHrs	= -1
int	prop_FirecraftImproves	= -1
int	prop_MakeTinderMins	= -1
int	prop_MakeKindlingMins	= -1
int	prop_AddKindlingMins	= -1
int	prop_AddTinderMins	= -1
int	prop_LightFireMins	= -1
int	prop_AddFuelMins	= -1

;///////////////////////////////////////////////////////////////////////////////
// Forms of objects crafted 
/;
form	BlankItem
form[]	Cloaks
form	Stick
form	Torch
form	TorchDeconstruct
form	Cookpot
form	RoughBedding
form[]	SmallTents_1BR
form[]	LargeTents_1BR
form[]	SmallTents_MoreBR
form[]	LargeTents_MoreBR
form	Hatchet
form	Linen
form	FurPlate
form	Lace
form	TanRack
form	Mortar
form	Enchanter
GlobalVariable	FirecraftRank	; _Camp_PerkRank_Firecraft [GLOB:240473E5]
form[]	Tinder		; Paper, WOod Shavings
form	Kindling	; Kindling
form	Backpack
form	BackpackReclaim
form	usCampfireTentItem
form[]	CampfireWeather

float	TentRemovedTime = 0.0
float	TentRemovalThreshold = 1.0
int	TentRemovedSize = -1

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()" )
	isLoaded = false
	ESP = "Campfire.esm"
	TestForm = 0x468D3 ; misc blank item
	RegisterActs = LTT.LDH.act_ITEMADDED
	RegisterMenus = LTT.LDH.menu_None
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()" )
		return
	endif

	prop_CloakHrs = LTT.LDH.addFloatProp( modID, "CF_CloakHrs", LTT.craftBodyHrs/2, "$CF_CloakHrs", "$HLP_CF_CloakHrs", 2, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_StickMins = LTT.LDH.addIntProp( modID, "CF_StickMins", LTT.LDH.convertHrsToMins( LTT.craftStaffHrs ) as int, "$CF_StickMins", "$HLP_CF_StickMins", 3, 0, LTT.LDH.maxMins, "minutes" )
	prop_TorchMins = LTT.LDH.addIntProp( modID, "CF_TorchMins", LTT.craftTorchMins, "$CF_TorchMins", "$HLP_CF_TorchMins", 9, 0, LTT.LDH.maxMins, "minutes" )
	prop_CookpotHrs = LTT.LDH.addFloatProp( modID, "CF_CookpotHrs", LTT.craftMiscHrs, "$CF_CookpotHrs", "$HLP_CF_CookpotHrs", 11, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_BackpackHrs = LTT.LDH.addFloatProp( modID, "CF_BackpackHrs", LTT.craftShieldHrs, "$CF_BackpackHrs", "$HLP_CF_BackpackHrs", 4, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_BeddingHrs = LTT.LDH.addFloatProp( modID, "CF_BeddingHrs", LTT.craftBeddingHrs, "$CF_BeddingHrs", "$HLP_CF_BeddingHrs", 6, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_SmallTentHrs = LTT.LDH.addFloatProp( modID, "CF_SmallTentHrs", 4.0, "$CF_SmallTentHrs", "$HLP_CF_SmallTentHrs", 8, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LargeTentHrs = LTT.LDH.addFloatProp( modID, "CF_LargeTentHrs", 6.0, "$CF_LargeTentHrs", "$HLP_CF_LargeTentHrs", 10, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_HatchetHrs = LTT.LDH.addFloatProp( modID, "CF_HatchetHrs", LTT.craftOneHandedHrs, "$CF_HatchetHrs", "$HLP_CF_HatchetHrs", 7, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_ArrowsHrs = LTT.LDH.addFloatProp( modID, "CF_ArrowsHrs", LTT.craftAmmoHrs, "$CF_ArrowsHrs", "$HLP_CF_ArrowsHrs", 5, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LinenMins = LTT.LDH.addIntProp( modID, "CF_LinenMins", 15, "$CF_LinenMins", "$HLP_CF_LinenMins", 15, 0, LTT.LDH.maxMins, "minutes" )
	prop_FurHrs = LTT.LDH.addFloatProp( modID, "CF_FurHrs", LTT.craftMiscHrs, "$CF_FurHrs", "$HLP_CF_FurHrs", 12, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LaceMins = LTT.LDH.addIntProp( modID, "CF_LaceMins", 15, "$CF_LaceMins", "$HLP_CF_LaceMins", 14, 0, LTT.LDH.maxMins, "minutes" )
	prop_TanRackMins = LTT.LDH.addFloatProp( modID, "CF_TanRackMins", LTT.LDH.convertHrsToMins(LTT.craftMiscHrs) as int, "$CF_TanRackMins", "$HLP_CF_TanRackMins", 13, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_MortarHrs = LTT.LDH.addFloatProp( modID, "CF_MortarHrs", LTT.craftMiscHrs, "$CF_MortarHrs", "$HLP_CF_MortarHrs", 16, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_EnchanterHrs = LTT.LDH.addFloatProp( modID, "CF_EnchanterHrs", LTT.craftMiscHrs, "$CF_EnchanterHrs", "$HLP_CF_EnchanterHrs", 17, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_FirecraftImproves = LTT.LDH.addBoolProp( modID, "CF_FirecraftImproves", false, "$CF_FirecraftImproves", "$HLP_CF_FirecraftImproves", 20 )
	prop_MakeTinderMins = LTT.LDH.addIntProp( modID, "CF_MakeTinderMins", 15, "$CF_MakeTinderMins", "$HLP_CF_MakeTinderMins", 22, 0, LTT.LDH.maxMins, "minutes" )
	prop_MakeKindlingMins = LTT.LDH.addIntProp( modID, "CF_MakeKindlingMins", 5, "$CF_MakeKindlingMins", "$HLP_CF_MakeKindlingMins", 24, 0, LTT.LDH.maxMins, "minutes" )
	prop_AddKindlingMins = LTT.LDH.addIntProp( modID, "CF_AddKindlingMins", 10, "$CF_AddKindlingMins", "$HLP_CF_AddKindlingMins", 25, 0, LTT.LDH.maxMins, "minutes" )
	prop_AddTinderMins = LTT.LDH.addIntProp( modID, "CF_AddTinderMins", 15, "$CF_AddTinderMins", "$HLP_CF_AddTinderMins", 23, 0, LTT.LDH.maxMins, "minutes" )
	prop_LightFireMins = LTT.LDH.addIntProp( modID, "CF_LightFireMins", 25, "$CF_LightFireMins", "$HLP_CF_LightFireMins", 26, 0, LTT.LDH.maxMins, "minutes" )
	prop_AddFuelMins = LTT.LDH.addIntProp( modID, "CF_AddFuelMins", 5, "$CF_AddFuelMins", "$HLP_CF_AddFuelMins", 27, 0, LTT.LDH.maxMins, "minutes" )

	isLoaded = Load()
	DebugLog( "--OnGameReload(); success" )
endevent

bool function Load()
	DebugLog( "++Load()" )
	BlankItem 		= Game.GetFormFromFile(0x468D3, ESP) ; _Camp_BlankItem [MISC:240468D3]

	Cloaks = new Form[4]
	Cloaks[0]		= Game.GetFormFromFile(0x3FA9C, ESP) ; "Travel Cloak, Burlap" [ARMO:0203FA9C]
	Cloaks[1]		= Game.GetFormFromFile(0x3FA9E, ESP) ; "Travel Cloak, Fur" [ARMO:0203FA9E]
	Cloaks[2]		= Game.GetFormFromFile(0x3FA9F, ESP) ; "Travel Cloak, Hide" [ARMO:0203FA9F]
	Cloaks[3]		= Game.GetFormFromFile(0x3FA9D, ESP) ; "Travel Cloak, Linen" [ARMO:0203FA9D]

	Stick			= Game.GetFormFromFile(0x250CA, ESP) ; "Walking Stick" [ARMO:240250CA]
	Torch			= Game.GetFormFromFile(0x5C373, ESP) ; "Kindling, Linen Wrap" [MISC:2405C373]
	TorchDeconstruct	= Game.GetFormFromFile(0x19DAF, ESP) ; "Torch" [MISC:02019DAF]
	Cookpot			= Game.GetFormFromFile(0x19849, ESP) ; " Cooking Pot" [MISC:02019849]

	Backpack		= Game.GetFormFromFile(0x50A1D, ESP) ; CampfireBackpack [KYWD:02050A1D]
	BackpackReclaim		= Game.GetFormFromFile(0x00802, "LTT_Chesko.esp") ; This is a compatibility keyword, not a Campfire one.

	RoughBedding		= Game.GetFormFromFile(0x536E4, ESP) ; "Rough Bedding" [MISC:240536E4]

	SmallTents_1BR = new Form[2]
	SmallTents_1BR[0]	= Game.GetFormFromFile(0x36B4E, ESP) ; "Small Fur Tent, Bed Roll" [MISC:02036B4E]
	SmallTents_1BR[1]	= Game.GetFormFromFile(0x1A314, ESP) ; "Small Leather Tent, Bed Roll" [MISC:0201A314]

	SmallTents_MoreBR = new Form[2]
	SmallTents_MoreBR[0]	= Game.GetFormFromFile(0x624FB, ESP) ; "Small Fur Tent, 2x Bed Roll" [MISC:020624FB]
	SmallTents_MoreBR[1]	= Game.GetFormFromFile(0x36B70, ESP) ; "Small Leather Tent, 2x Bed Roll" [MISC:02036B70]

	LargeTents_1BR = new Form[2]
	LargeTents_1BR[0]	= Game.GetFormFromFile(0x1A348, ESP) ; "Large Fur Tent, Bed Roll" [MISC:0201A348]
	LargeTents_1BR[1]	= Game.GetFormFromFile(0x38CBC, ESP) ; "Large Leather Tent, Bed Roll" [MISC:02038CBC]

	LargeTents_MoreBR = new Form[5]
	LargeTents_MoreBR[0]	= Game.GetFormFromFile(0x1A347, ESP) ; "Large Fur Tent, 2x Bed Roll" [MISC:0201A347]
	LargeTents_MoreBR[1]	= Game.GetFormFromFile(0x1A33E, ESP) ; "Large Fur Tent, 3x Bed Roll" [MISC:0201A33E]
	LargeTents_MoreBR[2]	= Game.GetFormFromFile(0x1A33D, ESP) ; "Large Fur Tent, 4x Bed Roll" [MISC:0201A33D]
	LargeTents_MoreBR[3]	= Game.GetFormFromFile(0x38CBD, ESP) ; "Large Leather Tent, 2x Bed Roll" [MISC:02038CBD]
	LargeTents_MoreBR[4]	= Game.GetFormFromFile(0x38CBE, ESP) ; "Large Leather Tent, 3x Bed Roll" [MISC:02038CBE]

	Hatchet			= Game.GetFormFromFile(0x4103D, ESP) ; "Stone Hatchet" [WEAP:0204103D]

	; Materials
	Linen			= Game.GetForm(0x00034CD6) ; "Linen Wrap" [MISC:00034CD6]
	FurPlate		= Game.GetForm(0x01DA0BF1) ; "Fur Plate" [MISC:01DA0BF1]
	Lace			= Game.GetForm(0x01CC0606) ; "Hide Lace" [MISC:01CC0606]
	TanRack			= Game.GetFormFromFile(0x36B4F, ESP) ; "Tanning Rack" [MISC:02036B4F]
	Mortar			= Game.GetFormFromFile(0x38689, ESP) ; "Mortar and Pestle" [MISC:02038689]
	Enchanter		= Game.GetFormFromFile(0x38680, ESP) ; "Enchanting Supplies" [MISC:02038680]

	; Firecraft
	FirecraftRank		= Game.GetFormFromFile(0x473E5, ESP) as GlobalVariable ; _Camp_PerkRank_Firecraft [GLOB:240473E5]
	
	Tinder = new Form[2]
	Tinder[0]		= Game.GetFormFromFile(0x2EC4A, ESP) ; _Camp_Tinder "Tinder" [MISC:2402EC4A]
	Tinder[1]		= Game.GetFormFromFile(0x5A836, ESP) ; "Wood Shavings" [MISC:2405A836]
	Kindling		= Game.GetFormFromFile(0x2E68F, ESP) ; _Camp_Kindling "Kindling" [MISC:2402E68F]
	
	CampfireWeather = new form[2]
	CampfireWeather[0]	= Game.GetFormFromFile(0x34EAB, ESP) ; _Camp_CampfireItem_GoodWeather "Clear Weather" [MISC:06034EAB]
	CampfireWeather[1]	= Game.GetFormFromFile(0x3232D, ESP) ; _Camp_ZZCampfireItem_WeatherFavorable "Favorable Weather" [MISC:0603232D]
	
	DebugLog( "FurPlate="+FurPlate )
	
	if !FirecraftRank || !BlankItem || !FurPlate || !Lace
		DebugLog( "--Load(); failed" )
		return false
	endif
	DebugLog( "--Load(); success" )
	return true
endfunction

float function ItemRemoved( form Item, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemRemoved()" )
	float t = -1.0
	
	; If a 4, 3 or 2 BR tent is removed, maybe it is going down to a 3,2,1 BR tent
	; this removal is free regardless, but just in case, let's track this
	; so when the next tent is added, we can do it freely, if necessary.
	
	DebugLog( "--ItemRemoved(); t="+t )
	return t
endfunction

float function ItemAdded( form Item, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()" )
	float t = -1.0
	if Prefix != LTT.LDH.getModPrefix( modID ) && Item != FurPlate && Item != Lace
		DebugLog( "--ItemAdded() t="+t+"; item not usable" )
		return t
	endif
	
	if Type == LTT.LDH.kBook
		t = handleFirepit( Item, Prefix )
	endif
	if t >= 0.0
		DebugLog( "--ItemAdded() t="+t+"; was in a firepit" )
		return t
	else
		t = handleCampfireCrafting( Item, Type, Qty )
	endif
	
	DebugLog( "--ItemAdded(); t="+t )
	return t
endfunction

float function handleCampfireCrafting(form BaseItem, int Type, int Qty)
	DebugLog( "++handleCampfireCrafting()" )
	float t = -1.0

	if BaseItem == BlankItem
		DebugLog( "--handleCampfireCrafting(); blank item" )
		return 0.0
	endif

	; Camping Items

	if Cloaks.Find(BaseItem) >= 0
		t = LTT.LDH.getFloatProp( prop_CloakHrs ) * Qty
		DebugLog("Cloak. Base time = " + t)

	elseif BaseItem == Stick
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getFloatProp( prop_StickMins ) * Qty )
		DebugLog("Walking stick. Base time = " + t)

	elseif BaseItem == Torch
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getFloatProp( prop_TorchMins ) * Qty )
		DebugLog("Torch. Base time = " + t)

	elseif BaseItem == TorchDeconstruct
		t = 0.0
		LTT.LDH.addFreeItem( Kindling )
		LTT.LDH.addFreeItem( Linen )
		DebugLog("Splitting Torch")

	elseif BaseItem == Cookpot
		t = LTT.LDH.getFloatProp( prop_CookpotHrs ) * Qty
		DebugLog("Cookpot. Base time = " + t)

	elseif BaseItem.HasKeyword( Backpack as Keyword )
		t = LTT.LDH.getFloatProp( prop_BackpackHrs ) * Qty
		DebugLog("Backpack. Base time = " + t)

	elseif BaseItem.HasKeyword( BackpackReclaim as Keyword )
		t = 0.0
		LTT.LDH.addFreeItem( Backpack ) ; For the backpack
		LTT.LDH.addFreeItem( BackpackReclaim ) ; For the amulet
		DebugLog("Reclaim Backpack")

;;;DISABLED;;;	elseif Type == LTT.LDH.kArmor
;;;DISABLED;;;		; Get the base editor ID of the object, rather than have a list of all ~50 backpacks
;;;DISABLED;;;		; This really only works if the items are sequential.
;;;DISABLED;;;		int majorId = BaseItem.GetFormID()
;;;DISABLED;;;		int mask = Math.LeftShift(CF_Prefix, 24)
;;;DISABLED;;;		int minorId = majorId - mask
;;;DISABLED;;;		if minorId >= 0x04AD67 && minorId <= 0x04AD84
;;;DISABLED;;;			DebugLog("Splitter. Ignoring next backpack and next jewelry.")
;;;DISABLED;;;			CF_Splitting_Pack = True
;;;DISABLED;;;			CF_Splitting_Amulet = True
;;;DISABLED;;;			t = True
;;;DISABLED;;;		endif

	elseif BaseItem == RoughBedding
		t = LTT.LDH.getFloatProp( prop_BeddingHrs ) * Qty
		DebugLog("Rough bedding. Base time = " + t)

	elseif SmallTents_1BR.Find(BaseItem) >= 0
		; Find out if this was decrease from 2BR to 1BR
		t = LTT.LDH.getFloatProp( prop_SmallTentHrs ) * Qty
		DebugLog("Small tent. Base time = " + t)

	elseif LargeTents_1BR.Find(BaseItem) >= 0
		; Find out if this was decrease from 2BR to 1BR
		t = LTT.LDH.getFloatProp( prop_LargeTentHrs ) * Qty
		DebugLog("Large tent. Base time = " + t)

	elseif ( SmallTents_MoreBR.Find(BaseItem) >= 0 || LargeTents_MoreBR.Find(BaseItem) >= 0 )
		t = LTT.LDH.getFloatProp( prop_BeddingHrs ) * Qty
		DebugLog("Adding a bedroll to a tent. Base time = " + t)

	elseif BaseItem == Hatchet
		t = LTT.LDH.getFloatProp( prop_HatchetHrs ) * Qty
		DebugLog("Stone hatchet. Base time = " + t)

	elseif Type == LTT.LDH.kAmmo
		t = LTT.LDH.getFloatProp( prop_ArrowsHrs ) * ( (Qty as float) / 24 )
		DebugLog("Arrows. Base time = " + t) ; cfArrowsTime is the time for one whole *batch* (of 24)

	; Materials

	elseif BaseItem == Linen
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getFloatProp( prop_LinenMins ) * Qty )
		DebugLog("Linen wrap. Base time = " + t)

	elseif BaseItem == FurPlate
		t = LTT.LDH.getFloatProp( prop_FurHrs ) * Qty
		DebugLog("Fur plate. Base time = " + t)

	elseif BaseItem == Lace
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getFloatProp( prop_LaceMins ) * Qty )
		DebugLog("Hide lace. Base time = " + t)

	elseif BaseItem == TanRack
		t = LTT.LDH.getFloatProp( prop_TanRackMins ) * Qty
		DebugLog("Tanning rack. Base time = " + t)

	elseif BaseItem == Mortar
		t = LTT.LDH.getFloatProp( prop_MortarHrs ) * Qty
		DebugLog("Mortar and pestle. Base time = " + t)

	elseif BaseItem == Enchanter
		t = LTT.LDH.getFloatProp( prop_EnchanterHrs ) * Qty
		DebugLog("Enchanting supplies. They're so enchanting! Base time = " + t)

	; Firecraft
	
	elseif Tinder.Find(BaseItem) >= 0 ; Making tinder
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getFloatProp( prop_MakeTinderMins ) * Qty )
		DebugLog("Tinder. Base time = " + t)

	elseif BaseItem == Kindling ; Making kindling
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getFloatProp( prop_MakeKindlingMins ) * Qty )
		DebugLog("Kindling. Base time = " + t)

	elseif CampfireWeather.Find(BaseItem) >= 0; Weather is added when sitting at a fire pit
		t = 0.0
		DebugLog("CampfireWeather. Base time = " + t)

	endif
	
	DebugLog( "--handleCampfireCrafting() t="+t )
	return t
endfunction

float function handleFirepit( form BaseItem, int Prefix )
	DebugLog( "++handleFirepit()" )
	; Get the base editor ID of the object, rather than have a list of all ~150 'books'
	; This really only works if the items are sequential.
	float t = -1.0
	int minorId = BaseItem.GetFormID() - Math.LeftShift( Prefix, 24 )
	DebugLog( "minorID="+minorID )

	; Act Values:
	;   -1 = Unhandled
	;    0 = Lighting with spells/torches
	;    1 = Lighting the hard way
	;    2 = Add Tinder
	;    3 = Add Kindling
	;    4 = Grow or Stoke the fire
	int Act = -1

	if minorId >= 0x032E28 && minorId <= 0x032E2A
		Act = 3
	elseif minorId >= 0x03338D && minorId <= 0x033393
		Act = 4
	elseif minorId >= 0x0468C1 && minorId <= 0x05A84A
		Act = 2
	elseif minorId == 0x05A851 || minorId == 0x05A852
		Act = 0
	elseif minorId == 0x05A853
		Act = 1
	elseif minorId >= 0x05B318 && minorId <= 0x05B321
		Act = 2
	elseif minorId >= 0x05BE06 && minorId <= 0x05BE0F
		Act = 4
	endif

	DebugLog( "Act="+Act )
	
	if Act == 0
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_LightFireMins ) * 0.25 )
	elseif Act == 1
		t = LTT.LDH.convertMinsToHrs( FirecraftModifier( LTT.LDH.getIntProp( prop_LightFireMins ) ) )
	elseif Act == 2
		t = LTT.LDH.convertMinsToHrs( FirecraftModifier( LTT.LDH.getIntProp( prop_AddTinderMins ) ) )
	elseif Act == 3
		t = LTT.LDH.convertMinsToHrs( FirecraftModifier( LTT.LDH.getIntProp( prop_AddKindlingMins ) ) )
	elseif Act == 4
		t = LTT.LDH.convertMinsToHrs( FirecraftModifier( LTT.LDH.getIntProp( prop_AddFuelMins ) ) )
	endif

	DebugLog( "--handleFirepit(): t="+t )
	return t
endFunction

float function FirecraftModifier( Float TV )
	DebugLog( "++FirecraftModifier()" )
	float NewTV = TV
	if LTT.LDH.getBoolProp( prop_FirecraftImproves )
		NewTV = TV - ( TV * ( FirecraftRank.GetValueInt() * 0.2 ) )
	endif
	DebugLog( "--FirecraftModifier(); NewTV="+NewTV )
	return NewTV
endfunction
