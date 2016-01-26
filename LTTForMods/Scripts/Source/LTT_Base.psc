scriptname LTT_Base extends Quest
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	Base quest providing a framework over which other mods/ESPs can use
//	to receive event notifications and calculate the amount of time passed
//	for those events.
//	It also provides an interface between the mod's LTT settings and MCM
// Credits
//	- Akezhar for proviiding the original Living Takes Time (RTT) mod
//	- dragonsong/unuroboros for providing the first iteration of
//	  compatibility between RTT and Hunterborn, Frostfall & others, and the
//	  starting point for this mod
//	- Chesko for all his awesome mods and continuing dedication to skyrim
//	- SkyUI team for MCM and just being great modders
//	- SKSE team everything they've allowed modders to do.
// Changes
//	mlheur | v0.0-alpha | Initial release based on Hunterborn's misc addon.
///////////////////////////////////////////////////////////////////////////////;

;///////////////////////////////////////////////////////////////////////////////
// TODO
/;
; Make sure we're not just picking something up or dropping something
; during ItemAdded and ItemRemoved

;///////////////////////////////////////////////////////////////////////////////
// Constants used by any mod
/;
float property craftHeadHrs		= 2.0 AutoReadOnly
float property craftBodyHrs		= 6.0 AutoReadOnly
float property craftLimbHrs		= 3.0 AutoReadOnly
float property craftShieldHrs		= 4.0 AutoReadOnly
float property craftJewelryHrs		= 1.0 AutoReadOnly
float property craftOneHandedHrs	= 3.0 AutoReadOnly
float property craftDaggerHrs		= 1.5 AutoReadOnly
float property craftTwoHandedHrs	= 5.0 AutoReadOnly
float property craftStaffHrs		= 2.0 AutoReadOnly
float property craftBowHrs		= 3.0 AutoReadOnly
float property craftAmmoHrs		= 1.0 AutoReadOnly
float property craftMiscHrs		= 1.0 AutoReadOnly
float property craftImproveHrs		= 1.0 AutoReadOnly
float property craftBeddingHrs		= 0.25 AutoReadOnly
int   property craftTorchMins		= 15 AutoReadOnly

;///////////////////////////////////////////////////////////////////////////////
// Variable Declarations
/;

;///////////////////////////////////////////////////////////////////////////////
// Moving much of the lookup tables for attached mods to other source files.
/;
LTT_DataHandler Property LDH Auto
FISSInterface fiss

bool property isInit	= false Auto

bool LTT_debug		= true ; when set, LTT in beta testing
bool LTT_verbose	= true ; when set, LTT in alpha testing
int LTT_verMajor	= 0
int LTT_verMinor	= 0
string LTT_SaveFile	= "LTTForMods.xml"

string property SkillUsed = "" Auto

int mcmCellBaseActive	= 0
int mcmCellPersonMsgs	= 2
int mcmCellMsgThreshold	= 4
int mcmCellPause	= 1
int mcmCellPauseKey	= 3
int mcmCellUserDebug	= 5
int mcmCellExpertise	= 6
int mcmCellLoad		= 10
int mcmCellSave		= 11
int mcmCellVersion	= 22

;///////////////////////////////////////////////////////////////////////////////
// Properties passed from ESP
/;
; Form list for 1st/3rd person messages when time passes
FormList Property LTT_FL_msgTimePassed Auto
; Form list for 1st/3rd person messages when a task is blocked due to combat
FormList Property LTT_FL_msgInCombat Auto
; the game's timescale, because timers are given in realtime
GlobalVariable Property TimeScale Auto
; the game's current time
GlobalVariable Property GameHour Auto

;///////////////////////////////////////////////////////////////////////////////
// Event Handlers
/;

event OnUpdate()
	DebugLog( "++OnUpdate()" )
	; Mods should call LTT.RegisterForSingleUpdate() so that we can check
	; them in after we've loaded.
	LDH.DumpTables( "start of on update" )
	reloadMods()
	LDH.DumpTables( "end of on update" )
	DebugLog( "--OnUpdate(); success" )
endevent

;///////////////////////////////////////////////////////////////////////////////
// External Functions
/;

function Log( string sMsg )
	Debug.Trace( "[LTT] :: "+sMsg )
endfunction

function DebugLog( string sMsg, bool Verbose = false )
	bool LoggedToFile = false
	if LDH && LDH.isInit && isInit
		if LDH.getBoolProp( LDH.prop_UserDebug )
			LoggedToFile = true
			Log( sMsg )
		endif
	endif
	if Verbose && LTT_verbose
		Debug.Notification( "[LTT] "+sMsg )
	endif
	if LTT_debug && !LoggedToFile
		LoggedToFile = true
		Log( sMsg )
	endif
endfunction

int function getVersion()
	return 0
endfunction

string function verString()
	string ver = ""
	ver += LTT_verMajor+"."+LTT_verMinor
	if LTT_verbose
		ver += "-alpha"
	elseif LTT_debug
		ver += "-beta"
	endif
	return ver
endfunction

; Called from Player.OnSit()
function startStation(ObjectReference Station)
	DebugLog( "++startStation()" )
	int ID = LDH.getStationKeyword( Station )
	if ID < 0
		LDH.setStringState( LDH.state_CraftingStation, LDH.getStation(ID) )
	else
		LDH.setStringState( LDH.state_CraftingStation, LDH.getStation(LDH.station_Other) )
	endif
	DebugLog( "--startStation(); success" )
endfunction

; Called from Player.OngGtUp
function stopStation(ObjectReference akFurniture)
	DebugLog( "++stopStation()" )
	LDH.setStringState( LDH.state_CraftingStation, LDH.getStation(LDH.station_None) )
	DebugLog( "--stopStation(); success" )
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Internal functions
/;

bool function CheckIncompatibleMods()
	bool Incompatible = false
	Log( ">>>>>>>>>>>>>>> Checking MOD Compatibility <<<<<<<<<<<<<<<" )
	Log( ">>>>>>>>>>>>>>> Ignore any errors about files not existing <<<<<<<<<<<<<<<" )
	if Game.GetFormFromFile( 0xD62, "ReadingTakesTime.esp" )
		Debug.MessageBox( "$E_RTT_LOADED_INCOMPATIBLE" )
		Incompatible = true
	endif
	Log( ">>>>>>>>>>>>>>> Finished Checking MOD Compatibility <<<<<<<<<<<<<<<" )
	return Incompatible
endfunction

; Message formats are in a form list, return the index into the form list
; 0 - 1st person messages
; 1 - 3rd person messages
int function getMsgFormat()
	DebugLog( "++getMsgFormat()" )
	if LDH.getBoolProp( LDH.prop_FirstPersonMsgs )
		DebugLog( "--getMsgFormat() = 0; 1st person" )
		return 0
	endif
	DebugLog( "--getMsgFormat() = 1; 3rd person" )
	return 1
endfunction

bool function advanceTime(float hrsPassed)
	DebugLog( "++advanceTime()" )
	if !LDH.getBoolProp( LDH.prop_BaseActive ) || LDH.getBoolProp( LDH.prop_Paused ) || hrsPassed <= 0.0
		DebugLog( "--advanceTime(); skipping because we're !active, paused or no time passed" )
		return true
	endif
	
	hrsPassed *= ExpertiseMultiplier()
	
	bool ShowMsg = true
	float threshold = LDH.getIntProp( LDH.prop_ShowMsgThreshold ) as float
	float minsPassed = LDH.convertHrsToMins( hrsPassed )
	DebugLog( "Checking message threshold"\
	  +": threshold="+threshold \
	  +"; minsPassed="+minsPassed \
	)
	if ( minsPassed < threshold ) || threshold == 0
		ShowMsg = false
	endif
	
	float CurTime = GameHour.GetValue()
	
	; mlheur - not 100% sure why we need to take away the rounded portion
	; of current time, this was taken from the original RTT code, keeping it
	int Std = Math.Floor(CurTime)
	CurTime -= Std 
	CurTime += (hrsPassed)
	CurTime += Std
	
	int Hrs = Math.Floor(hrsPassed)
	int Mins =  Math.Floor(LDH.convertHrsToMins(hrsPassed - Hrs))
	
	DebugLog("Advancing Time" \
	  +": Hours="+Hrs \
	  +"; Minutes="+Mins \
	  +"; ShowMsg="+ShowMsg \
	)
	If ShowMsg
		(LTT_FL_msgTimePassed.GetAt(GetMsgFormat()) as Message).Show(Hrs,Mins)
	EndIf
	
	GameHour.SetValue(CurTime)
	DebugLog( "--advanceTime(); success" )
	return true
endfunction

function closeInCombat()
	DebugLog( "++closeInCombat()" )
	if LDH.getBoolProp( LDH.prop_Paused )
		DebugLog( "--closeInCombat(); skipping because we're paused" )
		return
	endif
	if ( LDH.getIntProp( LDH.prop_ShowMsgThreshold ) > 0 )
		(LTT_FL_msgInCombat.GetAt(GetMsgFormat()) as Message).Show()
	endif
	while (Utility.IsInMenuMode())
		Input.TapKey(15)
		Utility.WaitMenuMode(0.15)
	endwhile
	DebugLog( "--closeInCombat(); success" )
endfunction

function increaseSkill(string Skill, float Amt)
	DebugLog( "++increaseSkill()" )
	ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(Skill)
	aVI.AddSkillExperience(Amt)
	DebugLog( "--increaseSkill(); success" )
endfunction

float function ExpertiseMultiplier()
	DebugLog( "++ExpertiseMultiplier()" )
	if !LDH.getBoolProp( LDH.prop_ExpertiseReducesTime ) || SkillUsed == ""
		DebugLog( "--ExpertiseMultiplier(); skipped" )
		return 1
	endif
	float SkillPoints = Game.GetPlayer().GetActorValue(SkillUsed)
	if (SkillPoints<0)
		SkillPoints = 0
	elseif (SkillPoints>150)
		SkillPoints = 150
	endif
	SkillUsed = ""
	DebugLog( "--ExpertiseMultiplier(); success" )
	return (100-(SkillPoints/2))/100
endfunction

;///////////////////////////////////////////////////////////////////////////////
// For performance reasons, use any excuse to exit this large function early as
// early as possible.
/;
bool _spinlockItems = false
function ItemAdded (form BaseItem, int Qty, ObjectReference ItemRef, ObjectReference Source)
	int lockTries = 0
	while _spinlockItems
		DebugLog( "ItemAdded() locked; tries="+lockTries )
		Utility.WaitMenuMode( LDH.LockWaitTime )
		lockTries += 1
		if lockTries >= LDH.LockTries
			DebugLog( "ItemAdded() skipped because it could not be handled after "+lockTries+" tries" )
			return
		endif
	endwhile
	DebugLog( "ItemAdded() got lock" )
	_spinlockItems = true
	DebugLog( "++ItemAdded()" \
	  +": BaseItem="+BaseItem \
	  +": Name="+BaseItem.GetName() \
	  +"; Qty="+Qty \
	  +"; ItemRef="+ItemRef \
	  +"; Source="+Source \
	)
	float TimePassed = 0.0
	int Type = BaseItem.GetType()
	int Prefix = LDH.getFormPrefix(BaseItem)
	int modID = -1

	DebugLog( "Item"\
	  +": Type="+Type\
	  +"; Prefix="+Prefix\
	)

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || UI.IsMenuOpen("Console") || BaseItem == none )
		DebugLog( "--ItemAdded(); !BaseActive, console is open, or not an item", true )
		DebugLog( "ItemAdded() releasing lock" )
		_spinlockItems = false
		return
	endif
	if (!LDH.getBoolProp(LDH.state_IsLooting) && !LDH.getBoolProp(LDH.state_IsCrafting)) || Source 
		DebugLog( "--ItemAdded(); not looting or crafting and came from a container, must be taking from a chest/box", true )
		DebugLog( "ItemAdded() releasing lock" )
		_spinlockItems = false
		return
	endif

	if LDH.removeFreeItem( BaseItem )
		DebugLog( "--ItemAdded(); Had a free instance of this item in the queue", true )
		DebugLog( "ItemAdded() releasing lock" )
		_spinlockItems = false
		return
	endif
	
	DebugLog( "adding item..." )
	SkillUsed = ""
	
	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	DebugLog( "starting modID="+modID )
	while modID >= 0
		DebugLog( "checking modID="+modID )
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			DebugLog( "mod="+mod \
			  +"; prefix="+LDH.getModPrefix(modID) \
			)
			if mod.isRunnable() && LDH.wantsAction( modID, LDH.act_ITEMADDED )
				TimePassed = mod.ItemAdded( BaseItem, Qty, ItemRef, Source, Type, Prefix )
				if TimePassed >= 0
					advanceTime( TimePassed )
					DebugLog( "--ItemAdded(); Handled by a mod: modID="+modID )
					DebugLog( "ItemAdded() releasing lock" )
					_spinlockItems = false
					return
				endif
			endif
		endif
		modID -= 1
	endwhile
	DebugLog( "--ItemAdded(); not handled by anything, what to do?", true )
	DebugLog( "ItemAdded() releasing lock" )
	_spinlockItems = false
endfunction

function ItemRemoved(form BaseItem, int Qty, ObjectReference ItemRef, ObjectReference Destination )
	int lockTries = 0
	while _spinlockItems
		DebugLog( "ItemRemoved() locked; tries="+lockTries )
		Utility.WaitMenuMode( LDH.LockWaitTime )
		lockTries += 1
		if lockTries >= LDH.LockTries
			DebugLog( "ItemAdded() skipped because it could not be handled after "+lockTries+" tries" )
			return
		endif
	endwhile
	DebugLog( "ItemRemoved() got lock" )
	_spinlockItems = true
	DebugLog( "++ItemRemoved()" \
	  +": BaseItem="+BaseItem \
	  +": Name="+BaseItem.GetName() \
	  +"; Qty="+Qty \
	  +"; ItemRef="+ItemRef \
	  +"; Destination="+Destination \
	)
	float TimePassed = 0.0
	int Type = BaseItem.GetType()
	int Prefix = LDH.getFormPrefix(BaseItem)
	string ItemName = BaseItem.GetName()
	int modID = -1

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || UI.IsMenuOpen("Console") || BaseItem == none )
		DebugLog( "--ItemRemoved(); !BaseActive, console is open, or not an item" )
		DebugLog( "ItemRemoved() releasing lock" )
		_spinlockItems = false
		return
	endif

	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	while modID >= 0
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if mod.isRunnable() && LDH.wantsAction( modID, LDH.act_ITEMREMOVED )
				TimePassed = mod.ItemRemoved( BaseItem, Qty, ItemRef, Destination, Type, Prefix )
				if TimePassed >= 0
					advanceTime( TimePassed )
					DebugLog( "--ItemRemoved(); Handled by a mod: modID="+modID )
					DebugLog( "ItemRemoved() releasing lock" )
					_spinlockItems = false
					return
				endif
			endif
		endif
		modID-=1
	endwhile
	DebugLog( "--ItemRemoved(); not handled by anything, what to do?" )
	DebugLog( "ItemRemoved() releasing lock" )
	_spinlockItems = false
endfunction

event OnMenuOpen(string MenuName)
	DebugLog( "++OnMenuOpen()" \
	  +": MenuName="+MenuName \
	)
	float TimePassed = 0.0
	int modID = -1
	int menuID = LDH.getMenuID( MenuName )

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || LDH.getBoolProp( LDH.prop_Paused ) || UI.IsMenuOpen("Console") )
		DebugLog( "--OnMenuOpen(); !BaseActive, BasePaused, or console is open" )
		return
	endif
	
	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	while modID >= 0
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if mod.isRunnable() && LDH.wantsAction( modID, LDH.act_MENUOPENED )
				TimePassed = mod.MenuOpened( menuID )
				if TimePassed >= 0.0
					advanceTime( TimePassed )
					DebugLog( "--OnMenuOpen(); Handled by a mod: modID="+modID )
					return
				endif
			endif
		endif
		modID -= 1
	endwhile
	DebugLog( "--OnMenuOpen(); Not handled by any mod, what to do?" )
endevent

event OnMenuClose(String MenuName)
	DebugLog( "++OnMenuClose()" \
	  +": MenuName="+MenuName \
	)
	float TimePassed = 0.0
	int modID = -1
	int menuID = LDH.getMenuID( MenuName )

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || LDH.getBoolProp( LDH.prop_Paused ) || UI.IsMenuOpen("Console") )
		DebugLog( "--OnMenuClose(); !BaseActive, BasePaused, or console is open" )
		return
	endif
	
	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	while modID >= 0
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if mod.isRunnable() && LDH.wantsAction( modID, LDH.act_MENUCLOSED )
				TimePassed = mod.MenuOpened( menuID )
				if TimePassed >= 0.0
					advanceTime( TimePassed )
					DebugLog( "--OnMenuClose(); Handled by a mod: modID="+modID )
					return
				endif
			endif
		endif
		modID -= 1
	endwhile
	DebugLog( "--OnMenuClose(); Not handled by any mod, what to do?" )
endevent

;///////////////////////////////////////////////////////////////////////////////
// MCM Functions
//	These are all called from LTT_Menu.  They were put in here for easy
//	access to LDH and all the internal variables used in LTT_Base.
/;
LTT_Menu property mcm Auto
int[]	mcmOID_Index
int[]	mcmOID_Prop
int	mcmOID_Count	= -1
int	mcmOID_Save	= -1
int	mcmOID_Load	= -1

function mcmOnConfigInit( LTT_Menu menu )
	DebugLog( "++mcmOnConfigInit()" )
	mcmOnVersionUpdate( mcm, getVersion() )
	DebugLog( "--mcmOnConfigInit(); success" )
	return
endfunction

function mcmOnVersionUpdate( LTT_Menu menu, int Version )
	DebugLog( "++mcmOnVersionUpdate()" )
	mcm = menu
	if ! LDH.isInit
		LDH._Init( Version )
	endif
	reRegisterMenus()	
	DebugLog( "--mcmOnVersionUpdate(); success" )
	return
endfunction

function mcmOnGameReload( LTT_Menu menu )
	DebugLog( "++mcmOnGameReload()" )
	LDH.DumpTables( "start of on game reload" )
	LDH._Init( getVersion() )
	mcm = menu
	
	if CheckIncompatibleMods()
		return
	endif
	
	fiss = FISSFactory.getFISS() ; it's just a pointer so get it once, rather than each time we call save/load
	
	; Init states
	LDH.state_Menu = LDH.addStringState( "MenuName", LDH.getMenu( LDH.menu_None ) )
	LDH.state_IsLooting = LDH.addBoolState( "Looting" )
	LDH.state_IsCrafting = LDH.addBoolState( "Crafting" )
	LDH.state_CraftingStation = LDH.addStringState( "Crafting Station", LDH.getStation( LDH.station_None ) )
	LDH.state_IsPickpocketing = LDH.addBoolState( "Pickpocketing" )
	
	; Properties pertaining to the base mod, but not time passers for
	; vanilla skyrim
	LDH.prop_BaseActive = LDH.addBoolProp( -1, "LTT_BaseActive", false, "$LTT_BaseActive", "$HLP_BaseActive", mcmCellBaseActive )
	LDH.prop_FirstPersonMsgs = LDH.addBoolProp( -1, "LTT_FirstPersonMsgs", false, "$LTT_FirstPersonMsgs", "$HLP_FirstPersonMsgs", mcmCellPersonMsgs )
	LDH.prop_ShowMsgThreshold = LDH.addIntProp( -1, "LTT_ShowMsgThreshold", 10, "$LTT_ShowMsgTheshold", "$HLP_ShowMsgThreshold", mcmCellMsgThreshold, 0, LDH.maxMins, "minutes" )
	LDH.prop_Paused = LDH.addBoolProp( -1, "LTT_Paused", false, "$LTT_Paused", "$HLP_Paused", mcmCellPause )
	LDH.prop_PauseKey = LDH.addKeyProp( -1, "LTT_PauseKey", -1, "$LTT_PauseKey", "$HLP_PauseKey", mcmCellPauseKey )
	LDH.prop_UserDebug = LDH.addBoolProp( -1, "LTT_UserDebug", false, "$LTT_UserDebug", "$HLP_UserDebug", mcmCellUserDebug )
	LDH.prop_ExpertiseReducesTime = LDH.addBoolProp( -1, "LTT_ExpertiseReducesTime", false, "$LTT_ExpertiseReducesTime", "$HLP_ExpertiseReducesTime", mcmCellExpertise )
	
	reloadMods( true )
	
	LDH.DumpTables( "after on game reload" )
	
	isInit = true
	DebugLog( "--mcmOnGameReload(); success" )
endfunction

function reloadMods( bool forceReload = false )
	DebugLog( "++reloadMods()" )
	; iterate through mods and call their instance
	int i = LDH.getLastMod()
	while i >= 0
		DebugLog( "checking mod i="+i )
		LTT_ModBase mod = LDH.getMod(i)
		if mod
			DebugLog( "mod="+mod \
			  +"; mod.isInit="+mod.isInit \
			  +"; mod.isLoaded="+mod.isLoaded \
			  +"; forceReload="+forceReload \
			)
			if mod.isInit && ( !mod.isLoaded || forceReload )
				mod.isLoaded = false
				DebugLog( "calling mod.OnGameReload()" )
				mod.OnGameReload()
			endif
		endif
		i -= 1
	endwhile
	
	reloadMCMPages()
		
	; Reassign Hot Keys
	DebugLog( "--reloadMods(); success" )
endfunction

function mcmOnPageReset( string Page )
	DebugLog( "++mcmOnPageReset() Page=\""+Page+"\"" )
	
	if Page == " "
		; This isn't really a page that's being used, so don't redraw anything.
		; ... now, how to force MCM to think it's on the last page it drew?
		return
	endif

	if (page == "")
		mcm.LoadCustomContent("LivingTakesTime/LTThome.dds",26,23)
		DebugLog( "--mcmOnPageReset(); success" )
		return
	else
		mcm.UnloadCustomContent()
	endIf
	
	mcmOID_Index = new int[128] ; max MCM cell ID's
	mcmOID_Prop = new int[128]
	mcmOID_Count = 0	
	int ID = LDH.getLastProp()
	while ID >= 0
		if Page == LDH.getPropPage(ID)
			int mcmCell = LDH.getPropMCMCell(ID)
			string Label = LDH.getPropTitle(ID)
			int Type = LDH.getPropType(ID)
			DebugLog( "mcmOnPageReset Adding Option: Label="+Label+"; Type="+Type+"; mcmCell="+mcmCell, false )
			mcm.SetCursorPosition( mcmCell )
			int OID = -1
			if Type < 0
				; error
			elseif Type == LDH.propType_NONE
				; also error?
			elseif Type == LDH.propType_TOGGLE
				OID = mcm.AddToggleOption( Label, LDH.getBoolProp(ID) )
			elseif Type == LDH.propType_INT
				OID = mcm.AddSliderOption( Label, LDH.getIntProp(ID), "{0} "+LDH.getPropUnits(ID) )
			elseif Type == LDH.propType_FLOAT
				OID = mcm.AddSliderOption( Label, LDH.getFloatProp(ID), "{1} "+LDH.getPropUnits(ID) )
			elseif Type == LDH.propType_TEXT
				OID = mcm.AddTextOption( Label, LDH.getStringProp(ID) )
			elseif Type == LDH.propType_KEY
				OID = mcm.AddKeyMapOption( Label, LDH.getIntProp(ID) )
			elseif Type == LDH.propType_LABEL
				OID = mcm.AddHeaderOption( Label )
			else
				Log( "Adding a property of unknown type, should never get here" )
			endif
			DebugLog( "Setting mcmOID sub["+mcmOID_Count+"] : Index to "+OID+"; Prop to "+ID )
			mcmOID_Index[mcmOID_Count] = OID
			mcmOID_Prop[mcmOID_Count] = ID
			mcmOID_Count += 1
		endif
		ID-=1
	endwhile
	
	;; I might have to hard-code the save & load buttons, and
	;; handle them as special cases.
	if Page == mcm.ModName
		mcm.SetCursorPosition( mcmCellSave )
		mcmOID_Save = mcm.AddToggleOption( "$LTT_Save", false )
		mcm.SetCursorPosition( mcmCellLoad )
		mcmOID_Load = mcm.AddToggleOption( "$LTT_Load", false )
		mcm.SetCursorPosition( mcmCellVersion )
		mcm.AddHeaderOption(  mcm.ModName+": Version "+verString() )
	else
		mcmOID_Save = -1
		mcmOID_Load = -1
	endif
	
;;	if LTT_verbose
;;		int i = 0
;;		while i < 128
;;			DebugLog( "mcmOID_Index["+i+"]="+mcmOID_Index[i] )
;;			i+=1
;;		endwhile
;;	endif
	LDH.DumpTables( "after on page reset" )
	
	DebugLog( "--mcmOnPageReset(); success" )
endfunction

int function getOID_Prop( int OID )
	int i = 0
	while ( i < mcmOID_Count )
		if mcmOID_Index[i] == OID
			return mcmOID_Prop[i]
		endif
		i+=1
	endwhile
	Log( self+" MCM Handler: Unable to find Property for OID "+OID )
	return -1
endfunction

; prop type doesn't matter, just treat all as strings.
function mcmOnOptionDefault( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionDefault() OID="+OID )
	int ID = getOID_Prop( OID )
	LDH.setPropToDefault( ID )
	int Type = LDH.getPropType( ID )
	if Type == LDH.propType_TOGGLE
		; Let the owning mod do any work associated with changing
		; this flag, like no longer wanting a menu.
		LTT_ModBase mod = LDH.getMod( LDH.getPropModID( ID ) )
		if mod
			mod.handlePropToggle( ID, LDH.getBoolProp( ID ) )		
		endif
		reRegisterMenus()
	endif
	mcm.ForcePageReset() ; this might be a little heavy-handed, is lazy.
	DebugLog( "--mcmOnOptionDefault(); success" )
endfunction

; prop type doesn't matter, just show its help text.
function mcmOnOptionHighlight( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionHighlight() OID="+OID )
	
	; Sepcial case for save/load "buttons"
	if mcm.CurrentPage == mcm.ModName && ( OID == mcmOID_Save || OID == mcmOID_Load )
		mcm.SetInfoText( "$HLP_SaveLoad" )
		DebugLog( "--mcmOnOptionSelect(); success Save/Load" )
		return
	endif
	
	; Generic handler for all other props.
	int ID = getOID_Prop( OID )
	mcm.SetInfoText( LDH.getPropHelper( ID ) )
	DebugLog( "--mcmOnOptionHighlight(); success" )
endfunction

; Toggles and Text
function mcmOnOptionSelect( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionSelect() OID="+OID )
	
	; Sepcial cases for save/load "buttons"
	if mcm.CurrentPage == mcm.ModName
		if OID == mcmOID_Save
			; Do Save
			LDH.savePropTable( fiss, LTT_saveFile )
			mcm.ForcePageReset()
			DebugLog( "--mcmOnOptionSelect(); success Save" )
			return
		elseif OID == mcmOID_Load
			; Do Load
			LDH.loadPropTable( fiss, LTT_saveFile )
			reRegisterMenus()
			mcm.ForcePageReset()
			DebugLog( "--mcmOnOptionSelect(); success Load" )
			return
		endif
	endif
	
	; Generic handler for all other props
	int ID = getOID_Prop( OID )
	int Type = LDH.getPropType( ID )
	if Type == LDH.propType_TOGGLE
		bool V = LDH.getBoolProp( ID )
		V = !V
		LDH.setBoolProp( ID, V )
		mcm.SetToggleOptionValue( OID, V )		
		; Let the owning mod do any work associated with changing
		; this flag, like no longer wanting a menu.
		LTT_ModBase mod = LDH.getMod( LDH.getPropModID( ID ) )
		if mod
			mod.handlePropToggle( ID, V )		
		endif
		reRegisterMenus()
	else ; propType_TEXT doesn't need any handlers, I don't think.
		Log( "mcm Option selected of unknown type, should never get here" )
	endif
	
	DebugLog( "--mcmOnOptionSelect(); success" )
endfunction

; Int's and Floats
function mcmOnOptionSliderOpen( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionSliderOpen() OID="+OID )
	int ID = getOID_Prop( OID )
	int Type = LDH.getPropType( ID )
	float min = -1.0
	float max = -1.0
	float def = -1.0
	float step = -1.0
	float val = -1.0
	if Type == LDH.propType_INT
		val = LDH.getIntProp(ID) as float
		min = LDH.getIntPropMin(ID) as float
		max = LDH.getIntPropMax(ID) as float
		def = LDH.getIntPropDefault(ID) as float
		step = 1.0
	elseif Type == LDH.propType_FLOAT
		val = LDH.getFloatProp(ID)
		min = LDH.getFloatPropMin(ID)
		max = LDH.getFloatPropMax(ID)
		def = LDH.getFloatPropDefault(ID)
		step = 0.05
	else
		Log( "mcm Option slider of unknown type, should never get here" )
	endif
	
	mcm.SetSliderDialogStartValue( val )
	mcm.SetSliderDialogDefaultValue( def )
	mcm.SetSliderDialogRange( min, max )
	mcm.SetSliderDialogInterval( step )
	
	DebugLog( "--mcmOnOptionSliderOpen(); success" )
endfunction

; Int's and Floats
function mcmOnOptionSliderAccept( SKI_ConfigBase mcm, int OID, float val )
	DebugLog( "++mcmOnOptionSliderAccept() OID="+OID )
	int ID = getOID_Prop( OID )
	int Type = LDH.getPropType( ID )
	if Type == LDH.propType_INT
		LDH.setIntProp( ID, val as int )
	elseif Type == LDH.propType_FLOAT
		LDH.setFloatProp( ID, val )
	else
		Log( "mcm Option slider of unknown type, should never get here" )
	endif
	mcm.SetSliderOptionValue( OID, val )
	DebugLog( "--mcmOnOptionSliderAccept(); success" )
endfunction

function mcmOnOptionKeyMapChange( SKI_ConfigBase mcm, int OID, int KeyID, string Conflict, string ConflictOwner )
	DebugLog( "++mcmOnOptionKeyMapChange()"\
	  +": OID="+OID\
	  +": KeyID="+KeyID\
	  +": Conflict="+Conflict\
	  +": ConflictOwner="+ConflictOwner\
	)
	bool ReuseKey = true
	int ID = getOID_Prop( OID )
	
	if Conflict
		if ! ConflictOwner
			ConflictOwner = "Skyrim"
		endif
		ReuseKey = mcm.ShowMessage( "$E_REUSE_KEY"+" "+ConflictOwner+"::"+Conflict, true )
	endif
	
	if !ReuseKey
		DebugLog( "--mcmOnOptionKeyMapChange(); not reusing key" )
		return
	endif
	
	LDH.setIntProp( ID, KeyID )
	
	mcm.RegisterForKey( KeyID ) ; I could feed all key events through mcm, or register the mod for its own key events...
	mcm.ForcePageReset()
	DebugLog( "--mcmOnOptionKeyMapChange(); success" )
endfunction

function mcmOnKeyUp( int KeyID, float Duration ) ; might not belong to base, check it out...
	DebugLog( "++mcmOnKeyUp() KeyID="+KeyID )
	if ( UI.IsMenuOpen( "Console" ) || Utility.IsInMenuMode() || Game.GetPlayer().GetSitState() != 0 )
		DebugLog( "--mcmOnKeyUp(); Ignoring key during menu and crafting" )
		return
	endif
	
	; All I know is the key pressed, I need to look up
	; which mod wants to know when that key was pressed and pass
	; them the event.
	; Do I run through all props looking those that have the key where propType == KEY
	int modID = -1
	int _ID = LDH.getLastProp()
	int ID = -1
	while _ID >= 0
		if LDH.getPropType(_ID) == LDH.propType_KEY
			if LDH.getIntProp(_ID) == KeyID
				modID = LDH.getPropModID(_ID)
				ID = _ID
			endif
		endif
		_ID-=1
	endwhile
	; ID is set to the mod's prop ID for the thing watching the key.
	
	if modID >= 0
		; Pass the event on to the mod.
		LTT_ModBase mod = LDH.getMod( modID )
		mod.OnKeyUp( KeyID, Duration )
	else
		; LTT_Base is the mod, probably the pause key was pressed.
		if ID == LDH.prop_PauseKey
			; toggle pause state.
			DebugLog( "Changing pause status" )
			LDH.setBoolProp( LDH.prop_Paused, !LDH.getBoolProp( LDH.prop_Paused ) )
		endif
	endif
	
	DebugLog( "--mcmOnKeyUp(); success" )
endfunction

function reloadMCMPages()
	DebugLog( "++reloadMCMPages()" )
	int i
	int p
	
	; Stupid hack because papyrus doesn't let me create a variable number
	; of pages based on how many mods are loaded, and these will all show
	; up OnPageReset as "", so I'm using " " as a 'false' page.
	mcm.Pages = new string[33]		; _maxMods + 1
	i = LDH.getMaxMods()+1
	while i >= 1
		i-=1
		mcm.Pages[i] = " "
	endwhile
	mcm.Pages[0] = mcm.ModName
	
	; iterate through mods and call their instance
	i = LDH.getLastMod()
	p = 1
	DebugLog( "Iterating through mods adding pages to MCM" )
	while i >= 0
		LTT_ModBase mod = LDH.getMod(i)
		if mod
			if mod.isLoaded
				mcm.Pages[p] = LDH.getModName(i)
				DebugLog( "Adding mod page: p="+p+"; i="+i+"; mod="+mcm.Pages[p] )
				p+=1
			endif
		endif
		i-=1
	endwhile
	DebugLog( "--reloadMCMPages(); success" )
endfunction

function reRegisterMenus()
	DebugLog( "++reRegisterMenus()" )
	UnregisterForAllMenus()
	int MenusWanted = 0
	; Iterate through all mods collecting which ones want menus
	int ID = LDH.getLastMod()
	while ID >= 0
		MenusWanted = Math.LogicalOr( MenusWanted, LDH.getModMenus( ID ) )
		ID-=1
	endwhile
	
	; Register whichever menus were called for
	ID = LDH.getLastMenu()
	while ID >= 1
		if Math.LogicalAnd( MenusWanted, Math.LeftShift( 1, (ID - 1) ) )
			DebugLog( "Want menu ID="+ID )
			RegisterForMenu( LDH.getMenu( ID ) )
		endif
		ID -= 1
	endwhile
	DebugLog( "--reRegisterMenus(); success" )
endfunction
