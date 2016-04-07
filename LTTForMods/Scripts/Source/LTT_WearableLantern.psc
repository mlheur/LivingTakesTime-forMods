scriptname LTT_WearableLantern extends LTT_ModBase 

;///////////////////////////////////////////////////////////////////////////////
// Prop Trackers
/;
int prop_WearableMins	= -1
int prop_ChasisHrs	= -1
int prop_OilMins	= -1

;///////////////////////////////////////////////////////////////////////////////
// Forms of objects crafted 
/;
form	Wearable
form	Chassis
form	Oil

event OnInit()
	ESP = "Chesko_WearableLantern.esp"
	TestForm = 0x12C9 ; lantern belt (wearable)
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
	
	prop_WearableMins = LTT.LDH.addIntProp( modID, "WL_WearableMins", 30, "$WL_WearableMins", "$HLP_WL_WearableMins", 2, 0, LTT.LDH.maxMins, "minutes" )
	prop_ChasisHrs = LTT.LDH.addFloatProp( modID, "WL_ChasisHrs", 2.0, "$WL_ChasisHrs", "$HLP_WL_ChasisHrs", 4, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_OilMins = LTT.LDH.addIntProp( modID, "WL_OilMins", 30, "$WL_OilMins", "$HLP_WL_OilMins", 6, 0, LTT.LDH.maxMins, "minutes" )
	
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success" )
endevent

bool function Load()
	DebugLog( "++Load()" )
	Wearable = Game.GetFormFromFile(0x12C9, ESP)
	Chassis = Game.GetForm(0x318EC) ; Vanilla Lantern01
	Oil = Game.GetFormFromFile(0x002300, ESP)
	if !Oil || !Chassis || !Wearable
		DebugLog( "--Load(); failed" )
		return false
	endif
	DebugLog( "--Load(); success" )
	return true
EndFunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()" )
	float t = -1.0
	if Prefix != LTT.LDH.getModPrefix( modID ) && BaseItem != Chassis
		DebugLog( "--ItemAdded() t="+t+"; not our item" )
		return t
	endif
	LTT.SkillUsed = LTT.LDH.skill_Alchemy
	if BaseItem == Wearable
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_WearableMins ) )
	elseif BaseItem == Chassis
		t = LTT.LDH.getIntProp( prop_ChasisHrs )
	elseif BaseItem == Oil
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_OilMins ) )
	else
		t = 0.0
	endif
	DebugLog( "--ItemAdded() t="+t )
	return t
endfunction

