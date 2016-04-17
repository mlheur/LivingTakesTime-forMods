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
	DebugLog( "++OnGameReload()", 4 )
	isLoaded = false
	RegisterActs = LTT.act_ITEMADDED
	RegisterMenus = LTT.menu_None
	modID = LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()", 0 )
		return
	endif
	
	prop_WearableMins = LDH.addIntProp( modID, "WL_WearableMins", 30, "$WL_WearableMins", "$HLP_WL_WearableMins", 2, 0, LTT.maxMins, "minutes" )
	prop_ChasisHrs = LDH.addFloatProp( modID, "WL_ChasisHrs", 2.0, "$WL_ChasisHrs", "$HLP_WL_ChasisHrs", 4, 0.0, LTT.maxHrs, "hours" )
	prop_OilMins = LDH.addIntProp( modID, "WL_OilMins", 30, "$WL_OilMins", "$HLP_WL_OilMins", 6, 0, LTT.maxMins, "minutes" )
	
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success", 4 )
endevent

bool function Load()
	DebugLog( "++Load()", 4 )
	Wearable = Game.GetFormFromFile(0x12C9, ESP)
	Chassis = Game.GetForm(0x318EC) ; Vanilla Lantern01
	Oil = Game.GetFormFromFile(0x002300, ESP)
	if !Oil || !Chassis || !Wearable
		DebugLog( "--Load(); failed", 0 )
		return false
	endif
	DebugLog( "--Load(); success", 4 )
	return true
EndFunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()", 4 )
	float t = -1.0
	if Prefix != LDH.getModPrefix( modID ) && BaseItem != Chassis
		DebugLog( "--ItemAdded() t="+t+"; not our item", 4 )
		return t
	endif
	LTT.SkillUsed = LTT.skill_Alchemy
	if BaseItem == Wearable
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_WearableMins ) )
	elseif BaseItem == Chassis
		t = LDH.getIntProp( prop_ChasisHrs )
	elseif BaseItem == Oil
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_OilMins ) )
	else
		t = 0.0
	endif
	DebugLog( "--ItemAdded() t="+t, 4 )
	return t
endfunction

