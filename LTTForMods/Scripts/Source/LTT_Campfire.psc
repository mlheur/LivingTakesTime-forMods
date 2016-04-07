scriptname LTT_Campfire extends LTT_ModBase

;///////////////////////////////////////////////////////////////////////////////
// Prop Trackers
/;
int	prop_CloakHrs		= -1
int	prop_TorchMins		= -1
int	prop_CookpotHrs		= -1
int	prop_BackpackHrs	= -1
int	prop_SmallTentHrs	= -1
int	prop_LargeTentHrs	= -1
int	prop_LinenMins		= -1
int	prop_TanRackMins	= -1
int	prop_MortarHrs		= -1
int	prop_EnchanterHrs	= -1
int	prop_PerkImproves	= -1
int	prop_MakeTinderMins	= -1
int	prop_MakeKindlingMins	= -1
int	prop_AddKindlingMins	= -1
int	prop_AddTinderMins	= -1
int	prop_LightFireMins	= -1
int	prop_AddFuelMins	= -1

;///////////////////////////////////////////////////////////////////////////////
// Constants.  Should I make these into MCM configurable sliders?
/;
float FirecraftPercent = 0.2
float TrailblazerPercent = 0.25

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
form[]	Tinder ; Paper, WOod Shavings
form	Kindling ; Kindling
form	Backpack
form	BackpackReclaim
form[]	CampfireWeather

GlobalVariable FirecraftRank ; _Camp_PerkRank_Firecraft [GLOB:240473E5]
GlobalVariable TrailblazerRank

string station_Campfire = "_Camp_CraftingCampfire"

;///////////////////////////////////////////////////////////////////////////////
// Internal tracking variables 
/;
float	TentRemovedTime = 0.0
float	TentRemovedThreshold = 1.0
int	TentRemovedSize = -1

event OnInit()
	ESP = "Campfire.esm"
	TestForm = 0x468D3 ; misc blank item
	parent.OnInit()
endevent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()" )
	isLoaded = false
	RegisterActs = Math.LogicalOr( LTT.LDH.act_ITEMADDED, LTT.LDH.act_ITEMREMOVED )
	RegisterMenus = LTT.LDH.menu_None
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()" )
		return
	endif

	prop_CloakHrs = LTT.LDH.addFloatProp( modID, "CF_CloakHrs", LTT.craftBodyHrs/2, "$CF_CloakHrs", "$HLP_CF_CloakHrs", 2, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_BackpackHrs = LTT.LDH.addFloatProp( modID, "CF_BackpackHrs", LTT.craftShieldHrs, "$CF_BackpackHrs", "$HLP_CF_BackpackHrs", 4, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LargeTentHrs = LTT.LDH.addFloatProp( modID, "CF_LargeTentHrs", 6.0, "$CF_LargeTentHrs", "$HLP_CF_LargeTentHrs", 6, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_SmallTentHrs = LTT.LDH.addFloatProp( modID, "CF_SmallTentHrs", 4.0, "$CF_SmallTentHrs", "$HLP_CF_SmallTentHrs", 8, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_MortarHrs = LTT.LDH.addFloatProp( modID, "CF_MortarHrs", LTT.craftMiscHrs, "$CF_MortarHrs", "$HLP_CF_MortarHrs", 10, 0.0, LTT.LDH.maxHrs, "hours" )

	prop_TorchMins = LTT.LDH.addIntProp( modID, "CF_TorchMins", LTT.craftTorchMins, "$CF_TorchMins", "$HLP_CF_TorchMins", 3, 0, LTT.LDH.maxMins, "minutes" )
	prop_CookpotHrs = LTT.LDH.addFloatProp( modID, "CF_CookpotHrs", LTT.craftMiscHrs, "$CF_CookpotHrs", "$HLP_CF_CookpotHrs", 5, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_TanRackMins = LTT.LDH.addFloatProp( modID, "CF_TanRackMins", LTT.LDH.convertHrsToMins(LTT.craftMiscHrs) as int, "$CF_TanRackMins", "$HLP_CF_TanRackMins", 7, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LinenMins = LTT.LDH.addIntProp( modID, "CF_LinenMins", 15, "$CF_LinenMins", "$HLP_CF_LinenMins", 9, 0, LTT.LDH.maxMins, "minutes" )
	prop_EnchanterHrs = LTT.LDH.addFloatProp( modID, "CF_EnchanterHrs", LTT.craftMiscHrs, "$CF_EnchanterHrs", "$HLP_CF_EnchanterHrs", 11, 0.0, LTT.LDH.maxHrs, "hours" )

	prop_PerkImproves = LTT.LDH.addBoolProp( modID, "CF_PerkImproves", false, "$CF_PerkImproves", "$HLP_CF_PerkImproves", 14 )
	prop_MakeTinderMins = LTT.LDH.addIntProp( modID, "CF_MakeTinderMins", 15, "$CF_MakeTinderMins", "$HLP_CF_MakeTinderMins", 16, 0, LTT.LDH.maxMins, "minutes" )
	prop_MakeKindlingMins = LTT.LDH.addIntProp( modID, "CF_MakeKindlingMins", 5, "$CF_MakeKindlingMins", "$HLP_CF_MakeKindlingMins", 18, 0, LTT.LDH.maxMins, "minutes" )
	prop_LightFireMins = LTT.LDH.addIntProp( modID, "CF_LightFireMins", 25, "$CF_LightFireMins", "$HLP_CF_LightFireMins", 20, 0, LTT.LDH.maxMins, "minutes" )

	prop_AddTinderMins = LTT.LDH.addIntProp( modID, "CF_AddTinderMins", 15, "$CF_AddTinderMins", "$HLP_CF_AddTinderMins", 17, 0, LTT.LDH.maxMins, "minutes" )
	prop_AddKindlingMins = LTT.LDH.addIntProp( modID, "CF_AddKindlingMins", 10, "$CF_AddKindlingMins", "$HLP_CF_AddKindlingMins", 19, 0, LTT.LDH.maxMins, "minutes" )
	prop_AddFuelMins = LTT.LDH.addIntProp( modID, "CF_AddFuelMins", 5, "$CF_AddFuelMins", "$HLP_CF_AddFuelMins", 21, 0, LTT.LDH.maxMins, "minutes" )

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
	Linen			= Game.GetForm(0x00034CD6) ; Vanila "Linen Wrap" [MISC:00034CD6]
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
	
	TrailblazerRank		= Game.GetFormFromFile(0x43817, ESP) as GlobalVariable ; _Camp_PerkRank_Trailblazer [GLOB:02043817]
	
	DebugLog( "FurPlate="+FurPlate )
	
	if !FirecraftRank || !BlankItem || !FurPlate || !Lace || !Linen
		DebugLog( "--Load(); failed" )
		return false
	endif
	DebugLog( "--Load(); success" )
	return true
endfunction

float function ItemRemoved( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemRemoved()" )
	float t = -1.0
	if Prefix != LTT.LDH.getModPrefix( modID )
		DebugLog( "--ItemRemoved(); Not our item: t="+t )
		return t
	endif

	int i = -1
	int minorId = BaseItem.GetFormID() - Math.LeftShift( Prefix, 24 )
	
	; If a 4, 3 or 2 BR tent is removed, maybe it is going down to a 3,2,1 BR tent
	; this removal is free regardless, but just in case, let's track this
	; so when the next tent is added, we can do it freely, if necessary.
	TentRemovedSize = 0
	i = LargeTents_MoreBR.Find( BaseItem )
	if i >= 0
		t = 0.0
		if i == 0 || i == 3
			TentRemovedSize = 2
		elseif i == 1 || i == 4
			TentRemovedSize = 3
		elseif i == 2
			TentRemovedSize = 4
		else
			DebugLog( "Should never get here: i="+i )
		endif
	elseif SmallTents_MoreBR.Find( BaseItem ) >= 0
		t = 0.0
		TentRemovedSize = 2
	elseif LargeTents_1BR.Find( BaseItem ) >= 0 || SmallTents_1BR.Find( BaseItem ) >= 0
		t = 0.0
		TentRemovedSize = 1
		
	; If a backpack & amulet is removed then we are probably deconstructing
	elseif BaseItem.HasKeyword( Backpack as Keyword ) && minorID >= 0x2D81D && minorID <= 0x2F8Ea
		t = 0.0
		LTT.LDH.addFreeItem( Backpack ) ; For the backpack
		LTT.LDH.addFreeItem( BackpackReclaim ) ; For the amulet
		DebugLog("Reclaim Backpack")
		DebugLog("Amulet & Backpack. Base time = " + t)
	
	endif
	
	if TentRemovedSize
		TentRemovedTime = Utility.GetCurrentRealTime()
	endif
	
	DebugLog( "--ItemRemoved(); t="+t )
	return t
endfunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()" )
	float t = -1.0
	if Prefix != LTT.LDH.getModPrefix( modID ) && BaseItem != FurPlate && BaseItem != Lace
		DebugLog( "--ItemAdded() t="+t+"; item not usable" )
		return t
	endif
	
	if Type == LTT.LDH.kBook
		t = handleFirepit( BaseItem, Prefix )
	endif
	if t >= 0.0
		DebugLog( "--ItemAdded() t="+t+"; was in a firepit" )
		return t
	elseif LTT.LDH.getStringState( LTT.LDH.state_craftingStation ) == station_Campfire
		t = handleCampfireCrafting( BaseItem, Type, Prefix, Qty ) * Qty
		if t > 0
			t *= Qty
		endif
	endif
	
	DebugLog( "--ItemAdded(); t="+t )
	return t
endfunction

float function handleCampfireCrafting(form BaseItem, int Type, int Prefix, int Qty )
	DebugLog( "++handleCampfireCrafting()" )
	float t = -1.0
	int i = -1
	int minorId = BaseItem.GetFormID() - Math.LeftShift( Prefix, 24 )

	if BaseItem == BlankItem
		DebugLog( "--handleCampfireCrafting(); blank item" )
		return 0.0
	endif

	; Camping Items

	if Cloaks.Find(BaseItem) >= 0
		t = LTT.LDH.getFloatProp( prop_CloakHrs )
		DebugLog("Cloak. Base time = " + t)

	elseif BaseItem == Stick
		t = PerkModifier( LTT.LDH.getFloatProp( LTT.Skyrim.prop_CraftStaffHrs ), TrailblazerRank, TrailblazerPercent )
		DebugLog("Walking stick. Base time = " + t)

	elseif BaseItem == Torch
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_TorchMins ) )
		DebugLog("Torch. Base time = " + t)

	elseif BaseItem == TorchDeconstruct
		t = 0.0
		while ( i > 0 )
			LTT.LDH.addFreeItem( Kindling )
			LTT.LDH.addFreeItem( Linen )
			i -= 1
		endwhile
		DebugLog("Splitting Torch")

	elseif BaseItem == Cookpot
		t = LTT.LDH.getFloatProp( prop_CookpotHrs )
		LTT.SkillUsed = LTT.LDH.skill_Smithing
		DebugLog("Cookpot. Base time = " + t)

	elseif BaseItem.HasKeyword( Backpack as Keyword )
		if minorID >= 0x2D81D && minorID <= 0x2F8Ea
			t = 0.0
			DebugLog("Amulet & Backpack. Base time = " + t)
		else
			t = PerkModifier( LTT.LDH.getFloatProp( prop_BackpackHrs ), TrailblazerRank, TrailblazerPercent )
			DebugLog("Backpack. Base time = " + t)
		endif

	elseif BaseItem == RoughBedding
		t = LTT.LDH.getFloatProp( LTT.Skyrim.prop_CraftBeddingHrs ) / (3/2)
		DebugLog("Rough bedding. Base time = " + t)

	elseif SmallTents_1BR.Find(BaseItem) >= 0
		; Find out if this was decrease from 2BR to 1BR
		if TentRemovedSize == 2 && Utility.GetCurrentRealTime() - TentRemovedTime <= TentRemovedThreshold
			t = 0.0
			DebugLog("Reduced small tent to 1BR. Base time = " + t)
		else
			t = LTT.LDH.getFloatProp( prop_SmallTentHrs )
			DebugLog("Small tent. Base time = " + t)
		endif

	elseif LargeTents_1BR.Find(BaseItem) >= 0
		; Find out if this was decrease from 2BR to 1BR
		if TentRemovedSize == 2 && Utility.GetCurrentRealTime() - TentRemovedTime <= TentRemovedThreshold
			t = 0.0
			DebugLog("Reduced large tent to 1BR. Base time = " + t)
		else
			t = LTT.LDH.getFloatProp( prop_LargeTentHrs )
			DebugLog("Large tent. Base time = " + t)
		endif

	elseif SmallTents_MoreBR.Find(BaseItem) >= 0 
		t = LTT.LDH.getFloatProp( LTT.Skyrim.prop_CraftBeddingHrs )
		DebugLog("Adding a bedroll to a small tent. Base time = " + t)
		
	elseif LargeTents_MoreBR.Find(BaseItem) >= 0
		; Find out if this was decrease from 4BR to 3BR or 3BR to 2BR
		i = LargeTents_MoreBR.Find( BaseItem )
		bool Downsize = false
		if i >= 0 && Utility.GetCurrentRealTime() - TentRemovedTime <= TentRemovedThreshold
			if ( i == 0 || i == 3 ) && TentRemovedSize == 3; from 3 to 2
				Downsize = true
			elseif ( i == 1 || i == 4 ) && TentRemovedSize == 4; from 4 to 3
				Downsize = true
			else
				DebugLog( "Should never get here: i="+i )
			endif
		endif
		if Downsize
			t = 0.0
			DebugLog("Reduced large tent. Base time = " + t)
		else
			t = LTT.LDH.getFloatProp( LTT.Skyrim.prop_CraftBeddingHrs )
			DebugLog("Adding a bedroll to a tent. Base time = " + t)
		endif

	elseif BaseItem == Hatchet
		t = LTT.LDH.getFloatProp( LTT.Skyrim.prop_Craft1AxeHrs )
		LTT.SkillUsed = LTT.LDH.skill_Smithing
		DebugLog("Stone hatchet. Base time = " + t)

	; Materials

	elseif BaseItem == Linen
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_LinenMins ) )
		DebugLog("Linen wrap. Base time = " + t)

	elseif BaseItem == FurPlate
		t = LTT.LDH.getFloatProp( LTT.Skyrim.prop_CraftLeatherHrs ) / 2
		DebugLog("Fur plate. Base time = " + t)

	elseif BaseItem == Lace
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftStripMins ) )
		DebugLog("Hide lace. Base time = " + t)

	elseif BaseItem == TanRack
		t = PerkModifier( LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_TanRackMins ) ), TrailblazerRank, TrailblazerPercent )
		DebugLog("Tanning rack. Base time = " + t)

	elseif BaseItem == Mortar
		t = LTT.LDH.getFloatProp( prop_MortarHrs )
		LTT.SkillUsed = LTT.LDH.skill_Alchemy
		DebugLog("Mortar and pestle. Base time = " + t)

	elseif BaseItem == Enchanter
		t = LTT.LDH.getFloatProp( prop_EnchanterHrs )
		LTT.SkillUsed = LTT.LDH.skill_Enchanting
		DebugLog("Enchanting supplies. They're so enchanting! Base time = " + t)

	; Firecraft
	
	elseif Tinder.Find(BaseItem) >= 0 ; Making tinder
		t = LTT.LDH.convertMinsToHrs( PerkModifier( LTT.LDH.getIntProp( prop_MakeTinderMins ), FirecraftRank, FirecraftPercent ) )
		DebugLog("Tinder. Base time = " + t)

	elseif BaseItem == Kindling ; Making kindling
		t = LTT.LDH.convertMinsToHrs( PerkModifier( LTT.LDH.getIntProp( prop_MakeKindlingMins ), FirecraftRank, FirecraftPercent ) )
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
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_LightFireMins ) * FirecraftPercent )
	elseif Act == 1
		t = LTT.LDH.convertMinsToHrs( PerkModifier( LTT.LDH.getIntProp( prop_LightFireMins ), FirecraftRank, FirecraftPercent ) )
	elseif Act == 2
		t = LTT.LDH.convertMinsToHrs( PerkModifier( LTT.LDH.getIntProp( prop_AddTinderMins ), FirecraftRank, FirecraftPercent ) )
	elseif Act == 3
		t = LTT.LDH.convertMinsToHrs( PerkModifier( LTT.LDH.getIntProp( prop_AddKindlingMins ), FirecraftRank, FirecraftPercent ) )
	elseif Act == 4
		t = LTT.LDH.convertMinsToHrs( PerkModifier( LTT.LDH.getIntProp( prop_AddFuelMins ), FirecraftRank, FirecraftPercent ) )
	endif

	DebugLog( "--handleFirepit(): t="+t )
	return t
endFunction

float function PerkModifier( float TV, GlobalVariable gPerk, float Percent )
	DebugLog( "++PerkModifier()" )
	float NewTV = TV
	if LTT.LDH.getBoolProp( prop_PerkImproves )
		float modifier = gPerk.GetValue() * Percent
		if modifier > 0.9
			modifier = 0.9
		endif
		NewTV = TV - ( TV * modifier )
	endif
	DebugLog( "--PerkModifier(); NewTV="+NewTV )
	return NewTV
endfunction
