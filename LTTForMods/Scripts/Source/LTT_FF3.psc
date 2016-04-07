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
	DebugLog( "++OnGameReload()" )
	isLoaded = false
	RegisterActs = LTT.LDH.act_ITEMADDED
	RegisterMenus = LTT.LDH.menu_None
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()" )
		return
	endif
	prop_SnowberryMins = LTT.LDH.addIntProp( modID, "FF3_SnoberryMins", 15, "$FF3_SnowberryMins", "$HLP_FF3_SnowberryMins", 2, 0, LTT.LDH.maxMins, "minutes" )
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success" )
endevent

bool function Load()
	DebugLog( "++Load()" )
	SnowberryExtract = Game.GetFormFromFile( ID_Snowberry, ESP )
	DummyItem = Game.GetFormFromFile( ID_DummyItem, ESP )
	if !SnowberryExtract || !DummyItem
		DebugLog( "--Load(); failed to load items" )
		return false
	endif
	DebugLog( "--Load(); success" )
	return true
endfunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()" )
	float t = -1.0
	if Prefix != LTT.LDH.getModPrefix( modID )
		DebugLog( "--ItemAdded() t="+t+"; not our item" )
		return t
	endif
	If BaseItem == SnowberryExtract
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_SnowberryMins ) ) * Qty
		DebugLog( "--ItemAdded() = "+t+"; Made snowberry extract" )
		LTT.SkillUsed = LTT.LDH.skill_Alchemy
		return t
	EndIf
	; Frostfall "gives" objects when its changing exposure status, handle & ignore those.
	if Type == LTT.LDH.kMisc && BaseItem == DummyItem
		DebugLog( "--ItemAdded() = 0.0; Received MISC Dummy item on exposure change" )
		return 0.0
	endif
	DebugLog( "--ItemAdded() t="+t+"; not our item" )
	return t
endfunction