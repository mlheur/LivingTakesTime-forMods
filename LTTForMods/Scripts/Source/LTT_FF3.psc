scriptname LTT_FF3 extends LTT_ModBase

int	ID_Snowberry		= 0x01D430 ; _Frost_WaterPotion "Snowberry Extract" [ALCH:0301D430]
int	ID_DummyItem		= 0x06B1D8 ; _Frost_DummyItem [MISC:0306B1D8]
int	prop_SnowberryMins	= -1
form	SnowberryExtract
form 	DummyItem

event OnInit()
	ESP = "Frostfall.esp"
	TestForm = ID_DummyItem
	parent.OnInit()
endevent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()", 4 )
	isLoaded = false
	RegisterActs = Math.LogicalOr(LTT.act_ITEMADDED,LTT.act_ITEMREMOVED)
	RegisterMenus = LTT.menu_None
	modID = LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()", 0 )
		return
	endif
	prop_SnowberryMins = LDH.addIntProp( modID, "FF3_SnoberryMins", 15, "$FF3_SnowberryMins", "$HLP_FF3_SnowberryMins", 2, 0, LTT.maxMins, "minutes" )
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success", 4 )
endevent

bool function Load()
	DebugLog( "++Load()", 4 )
	SnowberryExtract = Game.GetFormFromFile( ID_Snowberry, ESP )
	DummyItem = Game.GetFormFromFile( ID_DummyItem, ESP )
	if !SnowberryExtract || !DummyItem
		DebugLog( "--Load(); failed to load items", 0 )
		return false
	endif
	DebugLog( "--Load(); success", 4 )
	return true
endfunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()", 4 )
	float t = -1.0
	if Prefix != LDH.getModPrefix( modID )
		DebugLog( "--ItemAdded() t="+t+"; not our item", 0 )
		return t
	endif
	If BaseItem == SnowberryExtract
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_SnowberryMins ) ) * Qty
		DebugLog( "--ItemAdded() = "+t+"; Made snowberry extract", 4 )
		LTT.SkillUsed = LTT.skill_Alchemy
		return t
	EndIf
	; Frostfall "gives" objects when its changing exposure status, handle & ignore those.
	if BaseItem == DummyItem
		DebugLog( "--ItemAdded() = 0.0; Received MISC Dummy item on exposure change", 4 )
		return 0.0
	endif
	DebugLog( "--ItemAdded() t="+t+"; not our item", 4 )
	return t
endfunction

float function ItemRemoved( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog("++ItemRemoved()", 4)
	float t=-1.0
	if BaseItem == DummyItem
		t=0.0
	endif
	DebugLog("--ItemRemoved(): t="+t )
	return t
endfunction