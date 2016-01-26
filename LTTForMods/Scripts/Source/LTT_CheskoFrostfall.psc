scriptname LTT_CheskoFrostfall extends LTT_ModBase

;///////////////////////////////////////////////////////////////////////////////
// Prop Trackers
/;
int prop_StickMins	= -1
int prop_TorchMins	= -1
int prop_CookpotHrs	= -1
int prop_BackpackHrs	= -1
int prop_BeddingHrs	= -1
int prop_SmallTentHrs	= -1
int prop_LargeTentHrs	= -1
int prop_HatchetHrs	= -1
int prop_ArrowsHrs	= -1
int prop_CloakHrs	= -1
int prop_FurHrs		= -1
int prop_LaceMins	= -1
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

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()" )
	isLoaded = false
	ESP = ESP
	TestForm = 0x041045
	RegisterActs = Math.LogicalOr( LTT.LDH.act_ITEMADDED, LTT.LDH.act_ITEMREMOVED )
	RegisterMenus = LTT.LDH.menu_None
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()" )
		return
	endif

	prop_CloakHrs = LTT.LDH.addFloatProp( modID, "FF2_CloakHrs", LTT.craftBodyHrs/2, "$FF2_CloakHrs", "$HLP_FF2_CloakHrs", 2, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_StickMins = LTT.LDH.addIntProp( modID, "FF2_StickMins", LTT.LDH.convertHrsToMins( LTT.craftStaffHrs ) as int, "$FF2_StickMins", "$HLP_FF2_StickMins", 3, 0, LTT.LDH.maxMins, "minutes" )
	prop_TorchMins = LTT.LDH.addIntProp( modID, "FF2_TorchMins", LTT.craftTorchMins, "$FF2_TorchMins", "$HLP_FF2_TorchMins", 9, 0, LTT.LDH.maxMins, "minutes" )
	prop_CookpotHrs = LTT.LDH.addFloatProp( modID, "FF2_CookpotHrs", LTT.craftMiscHrs, "$FF2_CookpotHrs", "$HLP_FF2_CookpotHrs", 11, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_BackpackHrs = LTT.LDH.addFloatProp( modID, "FF2_BackpackHrs", LTT.craftShieldHrs, "$FF2_BackpackHrs", "$HLP_FF2_BackpackHrs", 4, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_BeddingHrs = LTT.LDH.addFloatProp( modID, "FF2_BeddingHrs", LTT.craftBeddingHrs, "$FF2_BeddingHrs", "$HLP_FF2_BeddingHrs", 6, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_SmallTentHrs = LTT.LDH.addFloatProp( modID, "FF2_SmallTentHrs", 4.0, "$FF2_SmallTentHrs", "$HLP_FF2_SmallTentHrs", 8, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LargeTentHrs = LTT.LDH.addFloatProp( modID, "FF2_LargeTentHrs", 6.0, "$FF2_LargeTentHrs", "$HLP_FF2_LargeTentHrs", 10, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_HatchetHrs = LTT.LDH.addFloatProp( modID, "FF2_HatchetHrs", LTT.craftOneHandedHrs, "$FF2_HatchetHrs", "$HLP_FF2_HatchetHrs", 7, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_ArrowsHrs = LTT.LDH.addFloatProp( modID, "FF2_ArrowsHrs", LTT.craftAmmoHrs, "$FF2_ArrowsHrs", "$HLP_FF2_ArrowsHrs", 5, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LinenMins = LTT.LDH.addIntProp( modID, "FF2_LinenMins", 15, "$FF2_LinenMins", "$HLP_FF2_LinenMins", 15, 0, LTT.LDH.maxMins, "minutes" )
	prop_FurHrs = LTT.LDH.addFloatProp( modID, "FF2_FurHrs", LTT.craftMiscHrs, "$FF2_FurHrs", "$HLP_FF2_FurHrs", 12, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_LaceMins = LTT.LDH.addIntProp( modID, "FF2_LaceMins", 15, "$FF2_LaceMins", "$HLP_FF2_LaceMins", 14, 0, LTT.LDH.maxMins, "minutes" )
	prop_TanRackMins = LTT.LDH.addFloatProp( modID, "FF2_TanRackMins", LTT.LDH.convertHrsToMins(LTT.craftMiscHrs) as int, "$FF2_TanRackMins", "$HLP_FF2_TanRackMins", 13, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_MortarHrs = LTT.LDH.addFloatProp( modID, "FF2_MortarHrs", LTT.craftMiscHrs, "$FF2_MortarHrs", "$HLP_FF2_MortarHrs", 16, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_EnchanterHrs = LTT.LDH.addFloatProp( modID, "FF2_EnchanterHrs", LTT.craftMiscHrs, "$FF2_EnchanterHrs", "$HLP_FF2_EnchanterHrs", 17, 0.0, LTT.LDH.maxHrs, "hours" )

	isLoaded = Load()
	DebugLog( "--OnGameReload(); success" )
endevent

bool function Load()
	DebugLog( "++Load()" )

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
		DebugLog( "--Load(); failed" )
		return false
	endif
	DebugLog( "--Load(); success" )
	return true
endfunction

float function ItemRemoved( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemRemoved()" )
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
	int i = -1
	int minorId = BaseItem.GetFormID() - Math.LeftShift( Prefix, 24 )
	if Prefix != LTT.LDH.getModPrefix( modID )
		DebugLog( "--ItemAdded() t="+t+"; item not usable" )
		return t
	endif
	
	; Camping Items

	if Cloaks.Find(BaseItem) >= 0
		t = LTT.LDH.getFloatProp( prop_CloakHrs )
		DebugLog("Cloak. Base time = " + t)

	elseif BaseItem == Stick
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_StickMins ) )
		DebugLog("Walking stick. Base time = " + t)

	elseif BaseItem == Torch
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_TorchMins ) )
		DebugLog("Torch. Base time = " + t)

	elseif BaseItem == Cookpot
		t = LTT.LDH.getFloatProp( prop_CookpotHrs )
		LTT.SkillUsed = LTT.LDH.skill_Smithing
		DebugLog("Cookpot. Base time = " + t)

	elseif BaseItem.HasKeyword( Backpack as Keyword )
		if minorID >= 0x2D81D && minorID <= 0x2F8Ea
			t = 0.0
			DebugLog("Amulet & Backpack. Base time = " + t)
		else
			t = LTT.LDH.getFloatProp( prop_BackpackHrs )
			DebugLog("Backpack. Base time = " + t)
		endif

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
		t = LTT.LDH.getFloatProp( prop_BeddingHrs )
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
			t = LTT.LDH.getFloatProp( prop_BeddingHrs )
			DebugLog("Adding a bedroll to a tent. Base time = " + t)
		endif

	elseif BaseItem == Hatchet
		t = LTT.LDH.getFloatProp( prop_HatchetHrs )
		LTT.SkillUsed = LTT.LDH.skill_Smithing
		DebugLog("Stone hatchet. Base time = " + t)

	elseif Type == LTT.LDH.kAmmo
		t = LTT.LDH.getFloatProp( prop_ArrowsHrs ) / 24
		LTT.SkillUsed = LTT.LDH.skill_Smithing
		DebugLog("Arrows. Base time = " + t) ; cfArrowsTime is the time for one whole *batch* (of 24)

	; Materials

	elseif BaseItem == Linen
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_LinenMins ) )
		DebugLog("Linen wrap. Base time = " + t)

	elseif BaseItem == Pelt
		t = LTT.LDH.getFloatProp( prop_FurHrs )
		DebugLog("Fur plate. Base time = " + t)

	elseif BaseItem == Lace
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_LaceMins ) )
		DebugLog("Hide lace. Base time = " + t)

	elseif BaseItem == TanRack
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_TanRackMins ) )
		DebugLog("Tanning rack. Base time = " + t)

	elseif BaseItem == Mortar
		t = LTT.LDH.getFloatProp( prop_MortarHrs )
		LTT.SkillUsed = LTT.LDH.skill_Alchemy
		DebugLog("Mortar and pestle. Base time = " + t)

	elseif BaseItem == Enchanter
		t = LTT.LDH.getFloatProp( prop_EnchanterHrs )
		LTT.SkillUsed = LTT.LDH.skill_Enchanting
		DebugLog("Enchanting supplies. They're so enchanting! Base time = " + t)
	
	endif
	
	if t > 0
		t *= Qty
	endif
	
	DebugLog( "--ItemAdded(); t="+t )
	return t
endfunction

;;;DISABLED;;;Bool Function Check_FF_Craft(Form akBaseItem, int aiType, int aiItemCount)
;;;DISABLED;;;	DebugMode("Check_FF_Craft...")
;;;DISABLED;;;
;;;DISABLED;;;	Float t
;;;DISABLED;;;	Float totalBaseTime
;;;DISABLED;;;
;;;DISABLED;;;	If akBaseItem == FF_Items_Pelt
;;;DISABLED;;;		totalBaseTime = ffPeltTime * aiItemCount
;;;DISABLED;;;		DebugMode("Cleaned pelt. Base time = " + ffPeltTime + "; x" + aiItemCount + " = " + totalBaseTime)
;;;DISABLED;;;		TimeCalc(totalBaseTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Lace
;;;DISABLED;;;		t = ToMinutes(ffLaceTime)
;;;DISABLED;;;		totalBaseTime = t * aiItemCount
;;;DISABLED;;;		DebugMode("Hide lace. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
;;;DISABLED;;;		TimeCalc(totalBaseTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Linen
;;;DISABLED;;;		t = ToMinutes(ffLinenTime)
;;;DISABLED;;;		totalBaseTime = t * aiItemCount
;;;DISABLED;;;		DebugMode("Linen wrap. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
;;;DISABLED;;;		TimeCalc(totalBaseTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Torch
;;;DISABLED;;;		t = ToMinutes(ffTorchTime)
;;;DISABLED;;;		totalBaseTime = t * aiItemCount
;;;DISABLED;;;		DebugMode("Torch. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
;;;DISABLED;;;		TimeCalc(totalBaseTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Stick
;;;DISABLED;;;		t = ToMinutes(ffStickTime)
;;;DISABLED;;;		DebugMode("Walking stick. Base time = " + t)
;;;DISABLED;;;		TimeCalc(t)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Cookpot
;;;DISABLED;;;		DebugMode("Cookpot. Base time = " + ffCookpotTime)
;;;DISABLED;;;		TimeCalc(ffCookpotTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_TanRack
;;;DISABLED;;;		t = ToMinutes(ffTanRackTime)
;;;DISABLED;;;		DebugMode("Tanning rack. Base time = " + t)
;;;DISABLED;;;		TimeCalc(t)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Mortar
;;;DISABLED;;;		DebugMode("Mortar and pestle. Base time = " + ffMortarTime)
;;;DISABLED;;;		TimeCalc(ffMortarTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Ench
;;;DISABLED;;;		DebugMode("Enchanting supplies. They're so enchanting! Base time = " + ffEnchTime)
;;;DISABLED;;;		TimeCalc(ffEnchTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf FF_Items_Cloaks.Find(akBaseItem) > -1
;;;DISABLED;;;		DebugMode("Cloak. Base time = " + ffCloakTime)
;;;DISABLED;;;		TimeCalc(ffCloakTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf FF_Items_Backpacks.Find(akBaseItem) > -1
;;;DISABLED;;;		If FF_Split_Pack
;;;DISABLED;;;			DebugMode("Backpack, but ignored due to splitter.")
;;;DISABLED;;;			FF_Split_Pack = False
;;;DISABLED;;;		Else
;;;DISABLED;;;			DebugMode("Backpack. Base time = " + ffBackpackTime)
;;;DISABLED;;;			TimeCalc(ffBackpackTime)
;;;DISABLED;;;		EndIf
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf FF_Items_SmallTents.Find(akBaseItem) > -1
;;;DISABLED;;;		DebugMode("Small tent. Base time = " + ffSmallTentTime)
;;;DISABLED;;;		TimeCalc(ffSmallTentTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf FF_Items_LargeTents.Find(akBaseItem) > -1
;;;DISABLED;;;		DebugMode("Large tent. Base time = " + ffLargeTentTime)
;;;DISABLED;;;		TimeCalc(ffLargeTentTime)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf akBaseItem == FF_Items_Hatchet
;;;DISABLED;;;		t = ToMinutes(ffHatchetTime)
;;;DISABLED;;;		DebugMode("Stone hatchet. Base time = " + t)
;;;DISABLED;;;		TimeCalc(t)
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf aiType == 26
;;;DISABLED;;;		int majorId = akBaseItem.GetFormID()
;;;DISABLED;;;		int mask = Math.LeftShift(FF_Prefix, 24)
;;;DISABLED;;;		int minorId = majorId - mask
;;;DISABLED;;;		If minorId >= 0x04AD67 && minorId <= 0x04AD84
;;;DISABLED;;;			DebugMode("Splitter. Ignoring next backpack and next jewelry.")
;;;DISABLED;;;			FF_Split_Pack = True
;;;DISABLED;;;			FF_Split_Amulet = True
;;;DISABLED;;;		EndIf
;;;DISABLED;;;
;;;DISABLED;;;	ElseIf aiType == 42
;;;DISABLED;;;		DebugMode("Arrows. Base time = " + ffArrowsTime) ; ffArrowsTime is the time for one whole *batch* (of 24)
;;;DISABLED;;;		TimeCalc(ffArrowsTime)
;;;DISABLED;;;
;;;DISABLED;;;	Else
;;;DISABLED;;;		DebugMode("No match found. This one's free!")
;;;DISABLED;;;	EndIf
;;;DISABLED;;;
;;;DISABLED;;;	Return True
;;;DISABLED;;;
;;;DISABLED;;;EndFunction
;;;DISABLED;;;