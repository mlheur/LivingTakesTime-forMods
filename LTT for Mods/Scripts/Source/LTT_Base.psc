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
// Variable Declarations
/;

;///////////////////////////////////////////////////////////////////////////////
// Moving much of the lookup tables for attached mods to other source files.
/;
LTT_DataHandler Property LDH Auto
FISSInterface fiss

bool LTT_debug		= true ; when set, LTT in beta testing
bool LTT_verbose	= true ; when set, LTT in alpha testing
int LTT_verMajor	= 0
int LTT_verMinor	= 0
int LTT_version		= -1
string LTT_SaveFile	= "LTTForMods\\LTTForMods.xml"

bool _readyForMods	= false

int mcmCellBaseActive	= 0
int mcmCellPersonMsgs	= 2
int mcmCellMsgThreshold	= 4
int mcmCellPause	= 1
int mcmCellPauseKey	= 3
int mcmCellUserDebug	= 5
int mcmCellLoad		= 10
int mcmCellSave		= 11

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

;///////////////////////////////////////////////////////////////////////////////
// External Functions
/;

bool function isReadyForMods()
	return _readyForMods
endfunction

function Log( string sMsg )
	Debug.Trace( "[LTT] :: "+sMsg )
endfunction

function DebugLog( string sMsg, bool Verbose = false )
	bool LoggedToFile = false
	if LDH && LDH._InitComplete
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
	return LTT_version
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
	int ID = LDH.getStationKeyword( Station )
	if ID < 0
		LDH.setStringState( LDH.state_CraftingStation, LDH.getStation(ID) )
	else
		LDH.setStringState( LDH.state_CraftingStation, LDH.getStation(LDH.station_Other) )
	endif
endfunction

; Called from Player.OngGtUp
function stopStation(ObjectReference akFurniture)
	LDH.setStringState( LDH.state_CraftingStation, LDH.getStation(LDH.station_None) )
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Internal functions
/;

bool function CheckIncompatibleMods()
	bool Incompatible = false
	Log( "Checking MOD Compatibility - ignore errors" )
	if Game.GetFormFromFile( 0xD62, "ReadingTakesTime.esp" )
		Debug.MessageBox( "$E_RTT_LOADED_INCOMPATIBLE" )
		Incompatible = true
	endif
	Log( "Finished checking MOD compatibility - stop ignoring errors" )
	
	return Incompatible
endfunction

int function GetMsgFormat()
	if LDH.getBoolProp( LDH.prop_FirstPersonMsgs )
		return 0
	endif
	return 1
endfunction

bool function AdvanceTime(float duration)
	if !LDH.getBoolProp( LDH.prop_BaseActive ) || LDH.getBoolProp( LDH.prop_Paused ) || duration < 0.0
		return true
	endif
	
	if duration <= 0.0
		return true
	endif
	
	bool ShowMsg = true
	if ( LDH.getIntProp( LDH.prop_ShowMsgThreshold ) < LDH.convertHrsToMins( duration ) )
		ShowMsg = false
	endif
	
	DebugLog("AdvanceTime: duration="+duration)
	float CurTime = GameHour.GetValue()
	; mlheur - not 100% sure why we need to take away the rounded portion
	; of current time, this was taken from the original RTT code, keeping it
	int Std = Math.Floor(CurTime)
	CurTime -= Std 
	CurTime += (duration)
	CurTime += Std
	int Hrs = Math.Floor(duration)
	int Mins =  Math.Floor(LDH.convertHrsToMins(duration - Hrs))
	
	DebugLog("Advancing Hours = " + Hrs + "; Minutes = " + Mins )
	If ShowMsg
		(LTT_FL_msgTimePassed.GetAt(GetMsgFormat()) as Message).Show(Hrs,Mins)
	EndIf
	
	GameHour.SetValue(CurTime)
	return true
endfunction

function CloseInCombat()
	if LDH.getBoolProp( LDH.prop_Paused )
		return
	endif
	if ( LDH.getIntProp( LDH.prop_ShowMsgThreshold ) > 0 )
		(LTT_FL_msgInCombat.GetAt(GetMsgFormat()) as Message).Show()
	endif
	while (Utility.IsInMenuMode())
		Input.TapKey(15)
		Utility.WaitMenuMode(0.15)
	endwhile
endfunction

function SkillIncrease(String Skill, Float Increase)
	ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(Skill)
	aVI.AddSkillExperience(Increase)
endfunction

float function ExpertiseMultiplier(String Skill)
	if !LDH.getBoolProp( LDH.prop_ExpertiseReducesTime )
		return 1
	endif
	Float SkillPoints = Game.GetPlayer().GetActorValue(Skill)
	if (SkillPoints<0)
		SkillPoints = 0
	elseif (SkillPoints>150)
		SkillPoints = 150
	endif
	return (100-(SkillPoints/2))/100
endfunction

;///////////////////////////////////////////////////////////////////////////////
// For performance reasons, use any excuse to exit this large function early as
// early as possible.
/;
function ItemAdded (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akContainer)
	float TimePassed = 0.0
	int Type = akBaseItem.GetType()
	int Prefix = LDH.getFormPrefix(akBaseItem)
	int modID = LDH.getLastMod()

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || UI.IsMenuOpen("Console") || akBaseItem == none )
		return
	endif
	if (!LDH.getBoolProp(LDH.state_IsLooting) && !LDH.getBoolProp(LDH.state_IsCrafting)) || akContainer 
		return
	endif

	if LDH.removeFreeItem( akBaseItem )
		return
	endif
	
	; iterate through mods and call their instance
	while modID
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if LDH.getModPrefix(modID) >= 0 && LDH.getModEnabled(modID)
				TimePassed = mod.ItemAdded( akBaseItem, aiItemCount, akItemReference, akContainer, Type, Prefix )
				if TimePassed >= 0.0
					AdvanceTime( TimePassed )
					return
				endif
			endif
		endif
		modID-=1
	endwhile
EndFunction

function ItemRemoved (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akContainer )
	float TimePassed = 0.0
	int Type = akBaseItem.GetType()
	int Prefix = LDH.getFormPrefix(akBaseItem)
	string ItemName = akBaseItem.GetName()
	int modID = LDH.getLastMod()

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || UI.IsMenuOpen("Console") || akBaseItem == none )
		return
	endif

; Probably not appropriate, but also maybe not harmful
;	if LDH.removeFreeItem( akBaseItem )
;		return
;	endif
	
	; iterate through mods and call their instance
	while modID
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if LDH.getModPrefix(modID) >= 0 && LDH.getModEnabled(modID)
				TimePassed = mod.ItemRemoved( akBaseItem, aiItemCount, akItemReference, akContainer, Type, Prefix )
				if TimePassed >= 0.0
					AdvanceTime( TimePassed )
					return
				endif
			endif
		endif
		modID-=1
	endwhile
endfunction

event OnMenuOpen(String MenuName)
	float TimePassed = 0.0
	int modID = LDH.getLastMod()
	int menuID = LDH.getMenuID( MenuName )

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || LDH.getBoolProp( LDH.prop_Paused ) || UI.IsMenuOpen("Console") )
		return
	endif
	
	; iterate through mods and call their instance
	while modID
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if LDH.getModPrefix(modID) >= 0 && LDH.getModEnabled(modID)
				TimePassed = mod.MenuOpened( menuID )
				if TimePassed >= 0.0
					AdvanceTime( TimePassed )
					return
				endif
			endif
		endif
		modID-=1
	endwhile
endevent

event OnMenuClose(String MenuName)
	float TimePassed = 0.0
	int modID = LDH.getLastMod()
	int menuID = LDH.getMenuID( MenuName )

	if ( !LDH.getBoolProp( LDH.prop_BaseActive ) || LDH.getBoolProp( LDH.prop_Paused ) || UI.IsMenuOpen("Console") )
		return
	endif
	
	; iterate through mods and call their instance
	while modID
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if LDH.getModPrefix(modID) >= 0 && LDH.getModEnabled(modID)
				TimePassed = mod.MenuOpened( menuID )
				if TimePassed >= 0.0
					AdvanceTime( TimePassed )
					return
				endif
			endif
		endif
		modID-=1
	endwhile
endevent

;///////////////////////////////////////////////////////////////////////////////
// MCM Functions
/;
LTT_Menu property mcm Auto
bool _inMutex = false

function mcmOnConfigInit( LTT_Menu menu )

	if ! _inMutex
		_inMutex = true
	else
		return
	endif

	DebugLog( "++mcmOnConfigInit" )
	mcm = menu
	if ! LDH._InitComplete
		LDH._Init()
	endif
	_readyForMods = true
	mcmOnVersionUpdate( mcm, -1 )
	DebugLog( "--mcmOnConfigInit" )
	
	_inMutex = false
	
	return
endfunction

function mcmOnVersionUpdate( LTT_Menu menu, int Version )
	DebugLog( "++mcmOnVersionUpdate" )
	mcm = menu
	
	if ! LDH._InitComplete
		LDH._Init()
	endif
	
	UnregisterForAllMenus()
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	; TODO Iterate through all menus, and register for those requested by any mod
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	
	mcmOnGameReload( menu )
	DebugLog( "--mcmOnVersionUpdate" )
	return
endfunction

function mcmOnGameReload( LTT_Menu menu )
	DebugLog( "++mcmOnGameReload" )
	int i
	mcm = menu
	LTT_version = ((LTT_verMajor*100)+LTT_verMinor)
	; Ensure previous RTT mod is not loaded.
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
	
	; iterate through mods and call their instance
	i = LDH.getLastMod()
	while i
		LTT_ModBase mod = LDH.getMod(i)
		if mod
			if LDH.getModPrefix(i) > 0
				mod.OnGameReload()
			endif
		endif
		i-=i
	endwhile
	
	reloadMCMPages()
		
	; Reassign Hot Keys
	DebugLog( "--mcmOnGameReload" )
endfunction

int[]	mcmOID_Index
int[]	mcmOID_Prop
int	mcmOID_Count
int	mcmOID_Save	= -1
int	mcmOID_Load	= -1
function mcmOnPageReset( string Page )
	DebugLog( "++mcmOnPageReset() Page=["+Page+"]" )
	
	if Page == " "
		; This isn't really a page that's being used, so don't redraw anything.
		; ... now, how to force MCM to think it's on the last page it drew?
		return
	endif

	if (page == "")
		mcm.LoadCustomContent("LivingTakesTime/LTThome.dds",26,23)
		return
	else
		mcm.UnloadCustomContent()
	endIf
	
	mcmOID_Index = new int[128] ; max MCM cell ID's
	mcmOID_Index = new int[128]
	mcmOID_Count = 0
	int i
	
	i = LDH.getLastProp()
	while i >= 0
		if Page == LDH.getPropPage(i)
			int mcmCell = LDH.getPropMCMCell(i)
			string Label = LDH.getPropTitle(i)
			int Type = LDH.getPropType(i)
			DebugLog( "mcmOnPageReset Adding Option: Label="+Label+"; Type="+Type+"; mcmCell="+mcmCell, true )
			mcm.SetCursorPosition( mcmCell )
			int OID = -1
			if Type < 0
				; error
			elseif Type == LDH.propType_NONE
				; also error?
			elseif Type == LDH.propType_TOGGLE
				OID = mcm.AddToggleOption( Label, LDH.getBoolProp(i) )
			elseif Type == LDH.propType_INT
				OID = mcm.AddSliderOption( Label, LDH.getIntProp(i), "{0} "+LDH.getPropUnits(i) )
			elseif Type == LDH.propType_FLOAT
				OID = mcm.AddSliderOption( Label, LDH.getFloatProp(i), "{1} "+LDH.getPropUnits(i) )
			elseif Type == LDH.propType_TEXT
				OID = mcm.AddTextOption( Label, LDH.getStringProp(i) )
			elseif Type == LDH.propType_KEY
				OID = mcm.AddKeyMapOption( Label, LDH.getIntProp(i) )
			elseif Type == LDH.propType_LABEL
				OID = mcm.AddHeaderOption( Label )
			else
				DebugLog( "Adding a property of unknown type" )
				OID = 127
			endif
			DebugLog( "Setting mcmOID_Index["+OID+"] to "+i )
			mcmOID_Index[mcmOID_Count] = OID
			mcmOID_Prop[mcmOID_Count] = i
			mcmOID_Count += 1
		endif
		i-=1
	endwhile
	
	;; I might have to hard-code the save & load buttons, and
	;; handle them as special cases.
	if Page == mcm.ModName
		mcm.SetCursorPosition( mcmCellSave )
		mcmOID_Save = mcm.AddToggleOption( "$LTT_Save", false )
		mcm.SetCursorPosition( mcmCellLoad )
		mcmOID_Load = mcm.AddToggleOption( "$LTT_Load", false )
	else
		mcmOID_Save = -1
		mcmOID_Load = -1
	endif
	
	if LTT_verbose
		i = 0
		while i < 128
			DebugLog( "mcmOID_Index["+i+"]="+mcmOID_Index[i] )
			i+=1
		endwhile
		LDH.DumpTables()
	endif
	
	DebugLog( "--mcmOnPageReset() Page="+Page )
endfunction

int function getOID_Prop( int OID )
	int i = 0
	while ( i < mcmOID_Count )
		if mcmOID_Index[i] == OID
			return mcmOID_Prop[i]
		endif
	endwhile
	Log( self+" MCM Handler: Unable to find Property for OID "+OID )
	return -1
endfunction

; prop type doesn't matter, just treat all as strings.
function mcmOnOptionDefault( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionDefault() OID="+OID )
	int ID = mcmOID_Index[OID]
	LDH.setPropToDefault( ID )
	mcm.ForcePageReset()
	DebugLog( "--mcmOnOptionDefault() OID="+OID )
endfunction

; prop type doesn't matter, just show its help text.
function mcmOnOptionHighlight( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionHighlight() OID="+OID )
	
	if OID == mcmOID_Save || OID == mcmOID_Load
		mcm.SetInfoText( "$HLP_SaveLoad" )
		DebugLog( "--mcmOnOptionSelect() OID="+OID )
		return
	endif
	
	int ID = mcmOID_Index[OID]
	mcm.SetInfoText( LDH.getPropHelper( ID ) )
	DebugLog( "--mcmOnOptionHighlight() OID="+OID )
endfunction

; Toggles and Text
function mcmOnOptionSelect( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionSelect() OID="+OID )
	
	if OID == mcmOID_Save
		; Do Save
		DebugLog( "--mcmOnOptionSelect() OID="+OID )
		return
	elseif OID == mcmOID_Load
		; Do Load
		DebugLog( "--mcmOnOptionSelect() OID="+OID )
		return
	endif
	
	int ID = mcmOID_Index[OID]
	
	DebugLog( "--mcmOnOptionSelect() OID="+OID )
endfunction

; Int's and Floats
function mcmOnOptionSliderOpen( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionSliderOpen() OID="+OID )
	int ID = mcmOID_Index[OID]
	DebugLog( "--mcmOnOptionSliderOpen() OID="+OID )
endfunction

; Int's and Floats
function mcmOnOptionSliderAccept( SKI_ConfigBase mcm, int OID, float Value )
	DebugLog( "++mcmOnOptionSliderAccept() OID="+OID )
	int ID = mcmOID_Index[OID]
	DebugLog( "--mcmOnOptionSliderAccept() OID="+OID )
endfunction

function mcmOnOptionKeyMapChange( SKI_ConfigBase mcm, int OID, int Key, string ConflictOwner, string ConflictName )
	DebugLog( "++mcmOnOptionKeyMapChange() OID="+OID )
	int ID = mcmOID_Index[OID]
	DebugLog( "--mcmOnOptionKeyMapChange() OID="+OID )
endfunction

function mcmOnKeyUp( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnKeyUp() OID="+OID )
	int ID = mcmOID_Index[OID]
	DebugLog( "--mcmOnKeyUp() OID="+OID )
endfunction

function reloadMCMPages()
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
			if LDH.getModPrefix(i) > 0
				mcm.Pages[p] = LDH.getModName(i)
				DebugLog( "Adding mod page: p="+p+"; i="+i+"; mod="+mcm.Pages[p] )
				p+=1
			endif
		endif
		i-=1
	endwhile
endfunction
