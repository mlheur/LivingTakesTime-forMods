scriptname LTT_LanternsCandles extends LTT_ModBase 

int prop_LCBasicMins = -1
int prop_LCForgeHrs = -1
int prop_LCArcaneHrs = -1
int prop_LCBrewMins = -1

; Lanterns and Candles
form	LC_Candle
form[]	LC_Basic
form[]	LC_Arcane

event OnInit()
	ESP = "lanterns.esp"
	TestForm = 0x000D72 ; aaaMRlightMisc "Lantern" [MISC:01000D72]
	parent.OnInit()
endEvent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase()
	DebugLog( "++OnGameReload()", 4 )
	isLoaded = false
	RegisterActs = LTT.act_ITEMADDED
	RegisterMenus = LTT.menu_None
	modID = LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()", 0 )
		return
	endif
	prop_LCBrewMins = LDH.addIntProp( modID, "LC_BrewMins", LTT.craftIngredientMins, "$LC_BrewMins", "$HLP_LC_BrewMins", 2, 0, LTT.maxMins, "minutes" )	
	prop_LCBasicMins = LDH.addIntProp( modID, "LC_BasicMins", 10, "$LC_BasicMins", "$HLP_LC_BasicMins", 4, 0, LTT.maxMins, "minutes" )
	prop_LCForgeHrs = LDH.addFloatProp( modID, "LC_ForgeHrs", 2.0, "$LC_ForgeHrs", "$HLP_LC_ForgeHrs", 3, 0, LTT.maxHrs, "hours" )
	prop_LCArcaneHrs = LDH.addFloatProp( modID, "LC_ArcaneHrs", 4.0, "$LC_ArcaneHrs", "$HLP_LC_ArcaneHrs", 5, 0, LTT.maxHrs, "hours" )
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success", 4 )
endEvent

bool function Load()
	DebugLog( "++Load()", 4 )
	int Err = 0
	int i = 0
	LC_Candle	= Game.GetFormFromFile(0x00234E, ESP)
	LC_Basic = new Form[7]
	LC_Basic[0]	= Game.GetFormFromFile(0x0028CC, ESP) ; Wine Bottles...
	LC_Basic[1]	= Game.GetFormFromFile(0x0028C7, ESP)
	LC_Basic[2]	= Game.GetFormFromFile(0x0028C2, ESP)
	LC_Basic[3]	= Game.GetFormFromFile(0x0028B8, ESP)
	LC_Basic[4]	= Game.GetFormFromFile(0x001863, ESP) ; "Glazed Candle" [MISC:01001863]
	LC_Basic[5]	= Game.GetFormFromFile(0x001868, ESP) ; "Glazed Candle" [MISC:01001868]
	LC_Basic[6]	= Game.GetFormFromFile(0x000D72, ESP) ; "Lantern" [MISC:01000D72]
	LC_Arcane = new Form[2]
	LC_Arcane[0]	= Game.GetFormFromFile(0x0043C4, ESP) ; Bottle Wizard's Lamps
	LC_Arcane[1]	= Game.GetFormFromFile(0x0038F7, ESP)

	if !LC_Candle
		Err += 1
	endif
	
	i = 0
	while ( i < 7 )
		if ! LC_Basic[i]
			Err += (Math.pow( 2.0, (i+1) as float )) as int
		endif
		i += 1
	endWhile
	while ( i < 2 )
		if ! LC_Arcane[i]
			Err += (Math.pow( 2.0, (i+8) as float )) as int
		endif
		i += 1
	endWhile
	
	if Err > 0
		DebugLog( "--Load(); failed to load items: "+Err, 0 )
		return false
	endif
	
	DebugLog( "--Load(); success", 4 )
	return true
endFunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()", 4 )
	float t = -1.0
	if Prefix != LDH.getModPrefix( modID )
		DebugLog( "--ItemAdded() t="+t+"; not our item", 4 )
		return t
	endif
	
	if BaseItem == LC_Candle
		; boil down fat to a candle
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_LCBrewMins ) ) * Qty
	elseif LC_Basic.find( BaseItem ) > -1
		; turn a basic object into a candle holder
		t = LDH.convertMinsToHrs( LDH.getIntProp( prop_LCBasicMins ) ) * Qty
	elseif LC_Arcane.find( BaseItem ) > -1
		; forge a new candlestick
		t = LDH.getFloatProp( prop_LCArcaneHrs ) * Qty
		LTT.SkillUsed = "smithing"
	else ; forged a candlestick
		; forge an arcane candlestick
		t = LDH.getFloatProp( prop_LCForgeHrs ) * Qty
		LTT.SkillUsed = "smithing" 
	endif
	
	; If not at a crafting station, then just picking up a candle
	if LDH.getStringState( LTT.state_CraftingStation ) == ""
		t = 0.0
	endif

	DebugLog( "--ItemAdded() t="+t, 4 )
	return t
endFunction

