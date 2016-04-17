scriptname LTT_CheskoFrostfall extends LTT_ModBase

;///////////////////////////////////////////////////////////////////////////////
// Prop Trackers
/;
int prop_TorchMins	= -1
int prop_CookpotHrs	= -1
int prop_BackpackHrs	= -1
int prop_SmallTentHrs	= -1
int prop_LargeTentHrs	= -1
int prop_CloakHrs	= -1
int prop_TanRackMins	= -1
int prop_MortarHrs	= -1
int prop_EnchanterHrs	= -1
int prop_LinenMins	= -1

;///////////////////////////////////////////////////////////////////////////////
// Forms of objects crafted 
/;
form[]	Cloaks
form	Stick
form	Torch
form	Cookpot
form[]	SmallTents_1BR
form[]	LargeTents_1BR
form[]	SmallTents_MoreBR
form[]	LargeTents_MoreBR
form	Hatchet
form	Linen
form	Pelt
form	Lace
form	TanRack
form	Mortar
form	Enchanter
form	Backpack
form	BackpackReclaim

;///////////////////////////////////////////////////////////////////////////////
// Internal tracking variables 
/;
float	TentRemovedTime = 0.0
float	TentRemovedThreshold = 1.0
int	TentRemovedSize = -1

event OnInit()
	ESP = "Chesko_Frostfall.esp"
	TestForm = 0x041045
	parent.OnInit()
endevent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()", 4 )
	isLoaded = false
	RegisterActs = Math.LogicalOr( LTT.act_ITEMADDED, LTT.act_ITEMREMOVED )
	RegisterMenus = LTT.menu_None
	modID = LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()", 0 )
		return
	endif

	prop_CloakHrs = LDH.addFloatProp( modID, "FF2_CloakHrs", LTT.craftBodyHrs/2, "$FF2_CloakHrs", "$HLP_FF2_CloakHrs", 2, 0.0, LTT.maxHrs, "hours" )
	prop_BackpackHrs = LDH.addFloatProp( modID, "FF2_BackpackHrs", LTT.craftShieldHrs, "$FF2_BackpackHrs", "$HLP_FF2_BackpackHrs", 4, 0.0, LTT.maxHrs, "hours" )
	prop_SmallTentHrs = LDH.addFloatProp( modID, "FF2_SmallTentHrs", 4.0, "$FF2_SmallTentHrs", "$HLP_FF2_SmallTentHrs", 6, 0.0, LTT.maxHrs, "hours" )
	prop_LargeTentHrs = LDH.addFloatProp( modID, "FF2_LargeTentHrs", 6.0, "$FF2_LargeTentHrs", "$HLP_FF2_LargeTentHrs", 8, 0.0, LTT.maxHrs, "hours" )

	prop_TorchMins = LDH.addIntProp( modID, "FF2_TorchMins", LTT.craftTorchMins, "$FF2_TorchMins", "$HLP_FF2_TorchMins", 3, 0, LTT.maxMins, "minutes" )
	prop_CookpotHrs = LDH.addFloatProp( modID, "FF2_CookpotHrs", LTT.craftMiscHrs, "$FF2_CookpotHrs", "$HLP_FF2_CookpotHrs", 5, 0.0, LTT.maxHrs, "hours" )
	prop_TanRackMins = LDH.addIntProp( modID, "FF2_TanRackMins", LDH.convertHrsToMins(LTT.craftMiscHrs) as int, "$FF2_TanRackMins", "$HLP_FF2_TanRackMins", 7, 0, LTT.maxMins, "minutes" )
	prop_LinenMins = LDH.addIntProp( modID, "FF2_LinenMins", 15, "$FF2_LinenMins", "$HLP_FF2_LinenMins", 9, 0, LTT.maxMins, "minutes" )
	prop_EnchanterHrs = LDH.addFloatProp( modID, "FF2_EnchanterHrs", LTT.craftMiscHrs, "$FF2_EnchanterHrs", "$HLP_FF2_EnchanterHrs", 11, 0.0, LTT.maxHrs, "hours" )
	prop_MortarHrs = LDH.addFloatProp( modID, "FF2_MortarHrs", LTT.craftMiscHrs, "$FF2_MortarHrs", "$HLP_FF2_MortarHrs", 13, 0.0, LTT.maxHrs, "hours" )

	isLoaded = Load()
	DebugLog( "--OnGameReload(); success", 4 )
endevent

bool function Load()
	DebugLog( "++Load()", 4 )

	Linen			= Game.GetForm(0x34CD6) ; Vanila "Linen Wrap" [MISC:00034CD6]
	
	Cloaks = new Form[4]
	Cloaks[0]		= Game.GetFormFromFile(0x3FA9C, ESP) ; "Travel Cloak, Burlap" [ARMO:0203FA9C]
	Cloaks[1]		= Game.GetFormFromFile(0x3FA9E, ESP) ; "Travel Cloak, Fur" [ARMO:0203FA9E]
	Cloaks[2]		= Game.GetFormFromFile(0x3FA9F, ESP) ; "Travel Cloak, Hide" [ARMO:0203FA9F]
	Cloaks[3]		= Game.GetFormFromFile(0x3FA9D, ESP) ; "Travel Cloak, Linen" [ARMO:0203FA9D]

	Stick			= Game.GetFormFromFile(0x3C96B, ESP) ; "Walking Stick" [WEAP:0203C96B]
	Torch			= Game.GetFormFromFile(0x19DAF, ESP) ; "Torch" [MISC:02019DAF]
	Cookpot			= Game.GetFormFromFile(0x19849, ESP) ; " Cooking Pot" [MISC:02019849]

	Backpack		= Game.GetFormFromFile(0x50A1D, ESP) ; FrostfallBackpack [KYWD:02050A1D]
	BackpackReclaim		= Game.GetFormFromFile(0x00802, "LTT_Chesko.esp") ; This is a compatibility keyword, not a Campfire one.

	SmallTents_1BR = new Form[2]
	SmallTents_1BR[0]	= Game.GetFormFromFile(0x36B4E, ESP) ; " Small Fur Tent, Bed Roll" [MISC:02036B4E]
	SmallTents_1BR[1]	= Game.GetFormFromFile(0x1A314, ESP) ; " Small Leather Tent, Bed Roll" [MISC:0201A314]
	
	SmallTents_MoreBR = new Form[2]
	SmallTents_MoreBR[0]	= Game.GetFormFromFile(0x624FB, ESP) ; " Small Fur Tent, 2x Bed Roll" [MISC:020624FB]
	SmallTents_MoreBR[1]	= Game.GetFormFromFile(0x36B70, ESP) ; " Small Leather Tent, 2x Bed Roll" [MISC:02036B70]

	LargeTents_1BR = new Form[2]
	LargeTents_1BR[0]	= Game.GetFormFromFile(0x1A348, ESP) ; " Large Fur Tent, Bed Roll" [MISC:0201A348]
	LargeTents_1BR[1]	= Game.GetFormFromFile(0x38CBC, ESP) ; " Large Leather Tent, Bed Roll" [MISC:02038CBC]
	
	LargeTents_MoreBR = new Form[5]
	LargeTents_MoreBR[0]	= Game.GetFormFromFile(0x1A347, ESP) ; " Large Fur Tent, 2x Bed Roll" [MISC:0201A347]
	LargeTents_MoreBR[1]	= Game.GetFormFromFile(0x1A33E, ESP) ; " Large Fur Tent, 3x Bed Roll" [MISC:0201A33E]
	LargeTents_MoreBR[2]	= Game.GetFormFromFile(0x1A33D, ESP) ; " Large Fur Tent, 4x Bed Roll" [MISC:0201A33D]
	LargeTents_MoreBR[3]	= Game.GetFormFromFile(0x38CBD, ESP) ; " Large Leather Tent, 2x Bed Roll" [MISC:02038CBD]
	LargeTents_MoreBR[4]	= Game.GetFormFromFile(0x38CBE, ESP) ; " Large Leather Tent, 3x Bed Roll" [MISC:02038CBE]

	Hatchet			= Game.GetFormFromFile(0x4103D, ESP) ; "Stone Hatchet" [WEAP:0204103D]
	Pelt			= Game.GetFormFromFile(0x41045, ESP) ; _DE_CraftingPelt "Cleaned Pelt" [MISC:02041045]
	Lace			= Game.GetFormFromFile(0x41044, ESP) ; "Hide Lace" [MISC:02041044]
	TanRack			= Game.GetFormFromFile(0x36B4F, ESP) ; "Tanning Rack" [MISC:02036B4F]
	Mortar			= Game.GetFormFromFile(0x38689, ESP) ; "Mortar and Pestle" [MISC:02038689]
	Enchanter		= Game.GetFormFromFile(0x38680, ESP) ; "Enchanting Supplies" [MISC:02038680]

	if !Hatchet || !Stick || !Linen || !Backpack ; make sure a few were successful, I'm too lazy to check all, but I should...
		DebugLog( "--Load(); failed", 0 )
		return false
	endif
	DebugLog( "--Load(); success", 4 )
	return true
endfunction

float function ItemRemoved( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemRemoved()", 4 )
	float t = -1.0
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
		LDH.addFreeItem( Backpack ) ; For the backpack
		LDH.addFreeItem( BackpackReclaim ) ; For the amulet
		DebugLog("Reclaim Backpack")
		DebugLog("Amulet & Backpack. Base time = " + t)
	
	endif
	
	if TentRemovedSize
		TentRemovedTime = Utility.GetCurrentRealTime()
	endif
	
	DebugLog( "--ItemRemoved(); t="+t, 4 )
	return t
endfunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()", 4 )
	float t = -1.0
	int i = -1
	int minorId = BaseItem.GetFormID() - Math.LeftShift( Prefix, 24 )
	if Prefix != LDH.getModPrefix( modID )
		DebugLog( "--ItemAdded() t="+t+"; item not ours", 4 )
		return t
	endif
	
	; Camping Items

	if Cloaks.Find(BaseItem) >= 0
		t = LDH.getFloatProp( prop_CloakHrs ) * Qty
		DebugLog("Cloak. Base time = " + t)

	elseif BaseItem == Stick
		t = LDH.getFloatProp( LTT.Skyrim.prop_CraftStaffHrs ) * Qty
		DebugLog("Walking stick. Base time = " + t)

	elseif BaseItem == Torch
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_TorchMins ) ) * Qty
		DebugLog("Torch. Base time = " + t)

	elseif BaseItem == Cookpot
		t = LDH.getFloatProp( prop_CookpotHrs ) * Qty
		LTT.SkillUsed = LTT.skill_Smithing
		DebugLog("Cookpot. Base time = " + t)

	elseif BaseItem.HasKeyword( Backpack as Keyword )
		if minorID >= 0x2D81D && minorID <= 0x2F8Ea
			t = 0.0
			DebugLog("Amulet & Backpack. Base time = " + t)
		else
			t = LDH.getFloatProp( prop_BackpackHrs ) * Qty
			DebugLog("Backpack. Base time = " + t)
		endif

	elseif SmallTents_1BR.Find(BaseItem) >= 0
		; Find out if this was decrease from 2BR to 1BR
		if TentRemovedSize == 2 && Utility.GetCurrentRealTime() - TentRemovedTime <= TentRemovedThreshold
			t = 0.0
			DebugLog("Reduced small tent to 1BR. Base time = " + t)
		else
			t = LDH.getFloatProp( prop_SmallTentHrs ) * Qty
			DebugLog("Small tent. Base time = " + t)
		endif

	elseif LargeTents_1BR.Find(BaseItem) >= 0
		; Find out if this was decrease from 2BR to 1BR
		if TentRemovedSize == 2 && Utility.GetCurrentRealTime() - TentRemovedTime <= TentRemovedThreshold
			t = 0.0
			DebugLog("Reduced large tent to 1BR. Base time = " + t)
		else
			t = LDH.getFloatProp( prop_LargeTentHrs ) * Qty
			DebugLog("Large tent. Base time = " + t)
		endif

	elseif SmallTents_MoreBR.Find(BaseItem) >= 0 
		t = LDH.getFloatProp( LTT.Skyrim.prop_CraftBeddingHrs ) * Qty
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
			t = LDH.getFloatProp( LTT.Skyrim.prop_CraftBeddingHrs ) * Qty
			DebugLog("Adding a bedroll to a tent. Base time = " + t)
		endif

	elseif BaseItem == Hatchet
		t = LDH.getFloatProp( LTT.Skyrim.prop_Craft1AxeHrs )
		LTT.SkillUsed = LTT.skill_Smithing
		DebugLog("Stone hatchet. Base time = " + t)

	; Materials

	elseif BaseItem == Linen
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_LinenMins ) ) * Qty
		DebugLog("Linen wrap. Base time = " + t)

	elseif BaseItem == Pelt
		t = LDH.getFloatProp( LTT.Skyrim.prop_CraftLeatherHrs ) / 3 * Qty
		DebugLog("Fur plate. Base time = " + t)

	elseif BaseItem == Lace
		t = LDH.convertMinsToHrs( LDH.getIntProp( LTT.Skyrim.prop_CraftStripMins ) ) * Qty
		DebugLog("Hide lace. Base time = " + t)

	elseif BaseItem == TanRack
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_TanRackMins ) ) * Qty
		DebugLog("Tanning rack. Base time = " + t)

	elseif BaseItem == Mortar
		t = LDH.getFloatProp( prop_MortarHrs ) * Qty
		LTT.SkillUsed = LTT.skill_Alchemy
		DebugLog("Mortar and pestle. Base time = " + t)

	elseif BaseItem == Enchanter
		t = LDH.getFloatProp( prop_EnchanterHrs ) * Qty
		LTT.SkillUsed = LTT.skill_Enchanting
		DebugLog("Enchanting supplies. They're so enchanting! Base time = " + t)
	
	endif
	
	if t > 0
		t *= Qty
	endif
	
	DebugLog( "--ItemAdded(); t="+t, 4 )
	return t
endfunction