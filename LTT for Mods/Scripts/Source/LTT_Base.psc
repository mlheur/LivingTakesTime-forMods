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
function StartFurniture(ObjectReference akFurniture)
	int ID = LDH.getLastStation()
	while ( 1 ) ; will exit when ID gets to -1
		if akFurniture.HasKeywordString(LDH.getStation(ID))
			LDH.setStringState( LDH.state_CraftingStation, LDH.getStationName(ID) )
			return
		endif
		ID -= 1
	endwhile
endfunction

; Called from Player.OngGtUp
function StopFurniture(ObjectReference akFurniture)
	LDH.setStringState( LDH.state_CraftingStation, "" )
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

string[] function mcmOnConfigInit()
	DebugLog( "++mcmOnConfigInit" )
	if ! LDH._InitComplete
		LDH._Init()
	endif
	return mcmOnVersionUpdate( -1 )
	DebugLog( "--mcmOnConfigInit" )
endfunction

string[] function mcmOnVersionUpdate( int Version )
	DebugLog( "++mcmOnVersionUpdate" )
	
	if ! LDH._InitComplete
		LDH._Init()
	endif
	
	; papyrus should support variables for new array subscripts.
	string[] Pages = new string[32]		; _maxMods
	
	int ModNum = LDH.getLastMod()
	while ( ModNum >= 0 )
		Pages[ModNum] = LDH.getModName( ModNum )
		ModNum += 1
	endwhile
	
	UnregisterForAllMenus()
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	; TODO Iterate through all menus, and register for those requested by any mod
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	;;;;;;;;;;;;;
	
	DebugLog( "--mcmOnVersionUpdate" )
	return( Pages )
endfunction

function mcmOnGameReload()
	DebugLog( "++mcmOnGameReload" )
	LTT_version = ((LTT_verMajor*100)+LTT_verMinor)
	; Ensure previous RTT mod is not loaded.
	if CheckIncompatibleMods()
		return
	endif
	
	fiss = FISSFactory.getFISS() ; it's just a pointer so get it once, rather than each time we call save/load
	
	; Init states
;	LDH.state_LTTdebug = LDH.addBoolState( "LTT_vebug", LTT_debug )
;	LDH.state_LTTverbose = LDH.addBoolState( "LTT_verbose", LTT_verbose )
;	LDH.state_LTTverMajor = LDH.addIntState( "LTT_verMajor", LTT_verMajor )
;	LDH.state_LTTverMinor = LDH.addIntState( "LTT_verMinor", LTT_verMinor )
;	LDH.state_LTTversion = LDH.addIntState( "LTT_version", LTT_version )
	LDH.state_Menu = LDH.addStringState( "MenuName" )
	LDH.state_IsLooting = LDH.addBoolState( "Looting" )
	LDH.state_IsCrafting = LDH.addBoolState( "Crafting" )
	LDH.state_CraftingStation = LDH.addStringState( "Crafting Station" )
	LDH.state_IsPickpocketing = LDH.addBoolState( "Pickpocketing" )
	
	; Properties pertaining to the base mod, but not time passers for
	; vanilla skyrim
	LDH.prop_BaseActive = LDH.addBoolProp( -1, "LTT_BaseActive", false, "$LTT_BaseActive", "$HLP_BaseActive", 0 )
	LDH.prop_FirstPersonMsgs = LDH.addBoolProp( -1, "LTT_FirstPersonMsgs", false, "$LTT_FirstPersonMsgs", "$HLP_FirstPersonMsgs", 2 )
	LDH.prop_ShowMsgThreshold = LDH.addIntProp( -1, "LTT_ShowMsgThreshold", 10, "$LTT_ShowMsgTheshold", "$HLP_ShowMsgThreshold", 4, 0, LDH.maxMins, "minutes" )
	LDH.prop_Paused = LDH.addBoolProp( -1, "LTT_Paused", false, "$LTT_Paused", "$HLP_Paused", 1 )
	LDH.prop_PauseKey = LDH.addKeyProp( -1, "LTT_PauseKey", -1, "$LTT_PauseKey", "$HLP_PauseKey", 3 )
	LDH.prop_UserDebug = LDH.addBoolProp( -1, "LTT_UserDebug", false, "$LTT_UserDebug", "$HLP_UserDebug", 5 )
	
	; iterate through mods and call their instance
	int i = LDH.getLastMod()
	while i
		LTT_ModBase mod = LDH.getMod(i)
		if mod
			if LDH.getModPrefix(i) > 0
				mod.OnGameReload()
			endif
		endif
		i-=i
	endwhile
	
	
	; Reassign Hot Keys
	DebugLog( "--mcmOnGameReload" )
endfunction

function mcmOnPageReset( SKI_ConfigBase mcm, string Page )
	DebugLog( "++mcmOnPageReset() Page="+Page )
	DebugLog( "mcmOnGameReload Added bool prop LDH.prop_BaseActive="+LDH.prop_BaseActive+"; Value="+LDH.getBoolProp(LDH.prop_BaseActive), true )
	LDH.DumpTables()
	int i = LDH.getLastProp()
	while i >= 0
		if Page == LDH.getPropPage(i)
			int mcmCell = LDH.getPropMCMCell(i)
			string Label = LDH.getPropTitle(i)
			int Type = LDH.getPropType(i)
			DebugLog( "mcmOnPageReset Adding Option: Label="+Label+"; Type="+Type+"; mcmCell="+mcmCell, true )
			mcm.SetCursorPosition( mcmCell )
			if Type < 0
				; error
			elseif Type == LDH.propType_NONE
				;
			elseif Type == LDH.propType_TOGGLE
				mcm.AddToggleOption( Label, LDH.getBoolProp(i) )
			elseif Type == LDH.propType_INT
				mcm.AddSliderOption( Label, LDH.getIntProp(i), "{0} "+LDH.getPropUnits(i) )
			elseif Type == LDH.propType_FLOAT
				mcm.AddSliderOption( Label, LDH.getFloatProp(i), "{1} "+LDH.getPropUnits(i) )
			elseif Type == LDH.propType_TEXT
				mcm.AddTextOption( Label, LDH.getStringProp(i) )
			elseif Type == LDH.propType_KEY
				mcm.AddKeyMapOption( Label, LDH.getIntProp(i) )
			elseif Type == LDH.propType_LABEL
				mcm.AddHeaderOption( Label )
			endif
		endif
		i-=1
	endwhile
	DebugLog( "--mcmOnPageReset() Page="+Page )
endfunction