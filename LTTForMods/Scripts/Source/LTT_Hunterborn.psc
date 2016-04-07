scriptname LTT_Hunterborn extends LTT_ModBase 

int prop_HBScrimBitsMins = -1
int prop_HBScrimIdolHrs = -1
int prop_HBScrimToolHrs = -1
int prop_HBCraftTallowMins = -1
int prop_HBCraftIngrMins = -1

Form[]	HB_Vanilla
Form	HB_Leather
Form	HB_Strips
Form	HB_Flute
Form	HB_ScrimBits
Form[]	HB_ScrimIdols
Form	HB_CacheMarker
Form[]	HB_ScrimTools
Form	HB_Bedroll
Form	HB_Candles
FormList	HB_PetLures
GlobalVariable	HB_Skinning
GlobalVariable	HB_Harvesting

string Scrimshaw = "_DS_KW_CraftingScrimshaw"

event OnInit()
	ESP = "Hunterborn.esp"
	TestForm = 0x6953
	parent.OnInit()
endevent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()" )
	isLoaded = false
	RegisterActs = LTT.LDH.act_ITEMADDED
	RegisterMenus = LTT.LDH.menu_None
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()" )
		return
	endif
	prop_HBScrimBitsMins = LTT.LDH.addFloatProp( modID, "HB_ScrimBitsMins", LTT.craftIngredientMins / 3, "$HB_ScrimBitsMins", "$HLP_HB_ScrimBitsMins", 2, 0, LTT.LDH.maxMins, "minutes" )
	prop_HBScrimIdolHrs = LTT.LDH.addFloatProp( modID, "HB_ScrimIdolHrs", LTT.craftStaffHrs, "$HB_ScrimIdolHrs", "$HLP_HB_ScrimIdolHrs", 4, 0.0, LTT.LDH.maxHrs, "hours" )	
	prop_HBScrimToolHrs = LTT.LDH.addFloatProp( modID, "HB_ScimToolHrs", LTT.craftDaggerHrs, "$HB_ScimToolHrs", "$HLP_HB_ScimToolHrs", 6, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_HBCraftIngrMins = LTT.LDH.addIntProp( modID, "HB_CraftIngrMins", LTT.craftIngredientMins, "$HB_CraftIngrMins", "$HLP_HB_CraftIngrMins", 8, 0, LTT.LDH.maxMins, "minutes" )	
	prop_HBCraftTallowMins = LTT.LDH.addIntProp( modID, "HB_CraftTallowMins", LTT.craftIngredientMins, "$HB_CraftTallowMins", "$HLP_HB_CraftTallowMins", 10, 0, LTT.LDH.maxMins, "minutes" )	
	LTT.LDH.addStation( Scrimshaw )
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success" )
endevent

bool function Load()
	DebugLog( "++Load()" )
	int Err = 0
	int i = 0

	HB_Leather		= Game.GetForm(0xDB5D2)
	HB_Strips		= Game.GetForm(0x800E4)
	HB_Flute		= Game.GetForm(0xDABA7)
	HB_Vanilla = new Form[3]
	HB_Vanilla[0]		= HB_Leather
	HB_Vanilla[1]		= HB_Strips ; Failed?
	HB_Vanilla[2]		= HB_Flute
	i = 0
	while i < 3
		if !HB_Vanilla[i]
			Err += (Math.pow( 2.0, (i) as float )) as int
		endif
		i += 1
	endwhile

	HB_ScrimIdols = new Form[7]
	; Engraved Bones
	HB_ScrimIdols[0]	= Game.GetFormFromFile(0x2617B, ESP) ; Hircine
	HB_ScrimIdols[1]	= Game.GetFormFromFile(0x25C11, ESP) ; Julianos
	HB_ScrimIdols[2]	= Game.GetFormFromFile(0x2617C, ESP) ; Kynareth
	; Ritual Bones
	HB_ScrimIdols[3]	= Game.GetFormFromFile(0x3E7B8, ESP) ; Elm
	HB_ScrimIdols[4]	= Game.GetFormFromFile(0x3E7B9, ESP) ; Oak
	HB_ScrimIdols[5]	= Game.GetFormFromFile(0x3D219, ESP) ; Yew
	; Bone and Blood
	HB_ScrimIdols[6]	= Game.GetFormFromFile(0x1344E6, ESP)
	i = 0
	while i < 7
		if !HB_ScrimIdols[i]
			Err += (Math.pow( 2.0, (i+4) as float )) as int
		endif
		i += 1
	endwhile

	HB_ScrimTools = new Form[2]
	HB_ScrimTools[0]	= HB_Flute
	HB_ScrimTools[1]	= Game.GetFormFromFile(0x9C5E8, ESP) ; Knucklebones
	i = 0
	while i < 2
		if !HB_ScrimTools[i]
			Err += (Math.pow( 2.0, (i+11) as float )) as int
		endif
		i += 1
	endwhile

	HB_ScrimBits = Game.GetFormFromFile(0x6953, ESP)
	if !HB_ScrimBits
		Err += Math.pow( 2.0, 12.0 ) as int
	endif
	
	HB_CacheMarker = Game.GetFormFromFile(0x3A6C0, ESP)
	if !HB_CacheMarker
		Err += Math.pow( 2.0, 13.0 ) as int
	endif
	
	HB_Bedroll = Game.GetFormFromFile(0x22B89, ESP)
	if !HB_Bedroll
		Err += Math.pow( 2.0, 14.0 ) as int
	endif
	
	HB_Candles = Game.GetFormFromFile(0xAB90D, ESP)
	if !HB_Candles
		Err += Math.pow( 2.0, 15.0 ) as int
	endif
	
	HB_PetLures = Game.GetFormFromFile(0x9C5CC, ESP) as FormList; _DS_FL_Pet_Lures [FLST:0409C5CC]
	if !HB_PetLures
		Err += Math.pow( 2.0, 16.0 ) as int
	endif
	
	HB_Skinning = Game.GetFormFromFile(0x7422, ESP) as GlobalVariable
	if !HB_Skinning
		Err += Math.pow( 2.0, 17.0 ) as int
	endif
	
	HB_Harvesting = Game.GetFormFromFile(0x89BB, ESP) as GlobalVariable
	if !HB_Harvesting
		Err += Math.pow( 2.0, 18.0 ) as int
	endif
	
	if Err > 0
		DebugLog( "--Load(); failed to load items: Err="+Err )
		return false
	endif
	
	DebugLog( "--Load(); success" )
	return true
endfunction

float function SkinBonus()
	Return HB_Bonus(HB_Skinning.GetValueInt())
endFunction

float function HarvestBonus()
	Return HB_Bonus(HB_Harvesting.GetValueInt())
endFunction

float function HB_Bonus(int Bonus)
	return 1.0 - (0.5 * (Bonus / 10))
endFunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()" )
	float t = -1.0
	if ( Prefix != LTT.LDH.getModPrefix( modID ) ) && ( HB_Vanilla.Find(BaseItem) < 0 )
		DebugLog( "--ItemAdded() t="+t+"; not our item" )
		return t
	endif
	
	if BaseItem == HB_Leather && LTT.LDH.getStringState( LTT.LDH.state_CraftingStation ) == Scrimshaw
		t = LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftLeatherHrs ) * Qty * SkinBonus()
	elseif BaseItem == HB_Strips && LTT.LDH.getStringState( LTT.LDH.state_CraftingStation ) == Scrimshaw
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftStripMins ) ) * Qty * SkinBonus() / 4
	elseif BaseItem == HB_ScrimBits
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_HBCraftTallowMins ) ) * Qty * HarvestBonus()
	elseif HB_ScrimIdols.Find(BaseItem) > -1
		t = LTT.LDH.getFloatProp( prop_HBScrimIdolHrs ) * Qty * HarvestBonus()
	elseif BaseItem == HB_Candles
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_HBScrimBitsMins ) ) * Qty
	elseif HB_ScrimTools.Find( BaseItem ) > -1
		t = LTT.LDH.getFloatProp( prop_HBScrimToolHrs ) * Qty * HarvestBonus()
	elseif BaseItem == HB_Bedroll
		t = LTT.LDH.getFloatProp( LTT.Skyrim.prop_CraftBeddingHrs ) * Qty * SkinBonus()
	elseif Type == LTT.LDH.kIngredient
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_HBCraftIngrMins ) ) * Qty * HarvestBonus()
	elseif Type == LTT.LDH.kPotion
		Potion p = BaseItem as Potion
		if !p.IsFood() || HB_PetLures.HasForm(BaseItem)
			t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftDrinkMins ) ) * Qty
		endif
	elseif BaseItem == HB_CacheMarker
		t = 0.0 ; free
;Skyrim	elseif Type == LTT.LDH.kArmor
;Skyrim	elseif Type == LTT.LDH.kWeapon
	endif
	
	DebugLog( "--ItemAdded() t="+t )
	return t
endfunction