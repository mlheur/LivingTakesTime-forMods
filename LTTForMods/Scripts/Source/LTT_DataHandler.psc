scriptname LTT_DataHandler extends MiscObject

;///////////////////////////////////////////////////////////////////////////////
// TODO
/;
; Put loop counter limiters on WaitMenuMode() calls.

;///////////////////////////////////////////////////////////////////////////////
// From ESP
/;
LTT_Base Property LTT Auto

;///////////////////////////////////////////////////////////////////////////////
// Constants
/;
int	property maxMins			= 1440 AutoReadOnly ; 24 hours
float	property maxHrs				= 24.0 AutoReadOnly
float	property LoadWaitTime			= 0.25 AutoReadOnly
int	property LoadTries			= 100 AutoReadonly
float	property LockWaitTime			= 0.01 AutoReadOnly
int	property LockTries			= 1000 AutoReadOnly

int property kANIO				= 83 AutoReadOnly
int property kARMA				= 102 AutoReadOnly
int property kAcousticSpace			= 16 AutoReadOnly
int property kAction				= 6 AutoReadOnly
int property kActivator				= 24 AutoReadOnly
int property kActorValueInfo			= 95 AutoReadOnly
int property kAddonNode				= 94 AutoReadOnly
int property kAmmo				= 42 AutoReadOnly
int property kApparatus				= 33 AutoReadOnly
int property kArmor				= 26 AutoReadOnly
int property kArrowProjectile			= 64 AutoReadOnly
int property kArt				= 125 AutoReadOnly
int property kAssociationType			= 123 AutoReadOnly
int property kBarrierProjectile			= 69 AutoReadOnly
int property kBeamProjectile			= 66 AutoReadOnly
int property kBodyPartData			= 93 AutoReadOnly
int property kBook				= 27 AutoReadOnly
int property kCameraPath			= 97 AutoReadOnly
int property kCameraShot			= 96 AutoReadOnly
int property kCell				= 60 AutoReadOnly
int property kCharacter				= 62 AutoReadOnly
int property kClass				= 10 AutoReadOnly
int property kClimate				= 55 AutoReadOnly
int property kCollisionLayer			= 132 AutoReadOnly
int property kColorForm				= 133 AutoReadOnly
int property kCombatStyle			= 80 AutoReadOnly
int property kConeProjectile			= 68 AutoReadOnly
int property kConstructibleObject		= 49 AutoReadOnly
int property kContainer				= 28 AutoReadOnly
int property kDLVW				= 117 AutoReadOnly
int property kDebris				= 88 AutoReadOnly
int property kDefaultObject			= 107 AutoReadOnly
int property kDialogueBranch			= 115 AutoReadOnly
int property kDoor				= 29 AutoReadOnly
int property kDualCastData			= 129 AutoReadOnly
int property kEffectSetting			= 18 AutoReadOnly
int property kEffectShader			= 85 AutoReadOnly
int property kEnchantment			= 21 AutoReadOnly
int property kEncounterZone			= 103 AutoReadOnly
int property kEquipSlot				= 120 AutoReadOnly
int property kExplosion				= 87 AutoReadOnly
int property kEyes				= 13 AutoReadOnly
int property kFaction				= 11 AutoReadOnly
int property kFlameProjectile			= 67 AutoReadOnly
int property kFlora				= 39 AutoReadOnly
int property kFootstep				= 110 AutoReadOnly
int property kFootstepSet			= 111 AutoReadOnly
int property kFurniture				= 40 AutoReadOnly
int property kGMST				= 3 AutoReadOnly
int property kGlobal				= 9 AutoReadOnly
int property kGrass				= 37 AutoReadOnly
int property kGrenadeProjectile			= 65 AutoReadOnly
int property kGroup				= 2 AutoReadOnly
int property kHazard				= 51 AutoReadOnly
int property kHeadPart				= 12 AutoReadOnly
int property kIdle				= 78 AutoReadOnly
int property kIdleMarker			= 47 AutoReadOnly
int property kImageSpace			= 89 AutoReadOnly
int property kImageSpaceModifier		= 90 AutoReadOnly
int property kImpactData			= 100 AutoReadOnly
int property kImpactDataSet			= 101 AutoReadOnly
int property kIngredient			= 30 AutoReadOnly
int property kKey				= 45 AutoReadOnly
int property kKeyword				= 4 AutoReadOnly
int property kLand				= 72 AutoReadOnly
int property kLandTexture			= 20 AutoReadOnly
int property kLeveledCharacter			= 44 AutoReadOnly
int property kLeveledItem			= 53 AutoReadOnly
int property kLeveledSpell			= 82 AutoReadOnly
int property kLight				= 31 AutoReadOnly
int property kLightingTemplate			= 108 AutoReadOnly
int property kList				= 91 AutoReadOnly
int property kLoadScreen			= 81 AutoReadOnly
int property kLocation				= 104 AutoReadOnly
int property kLocationRef			= 5 AutoReadOnly
int property kMaterial				= 126 AutoReadOnly
int property kMaterialType			= 99 AutoReadOnly
int property kMenuIcon				= 8 AutoReadOnly
int property kMessage				= 105 AutoReadOnly
int property kMisc				= 32 AutoReadOnly
int property kMissileProjectile			= 63 AutoReadOnly
int property kMovableStatic			= 36 AutoReadOnly
int property kMovementType			= 127 AutoReadOnly
int property kMusicTrack			= 116 AutoReadOnly
int property kMusicType				= 109 AutoReadOnly
int property kNAVI				= 59 AutoReadOnly
int property kNPC				= 43 AutoReadOnly
int property kNavMesh				= 73 AutoReadOnly
int property kNone				= 0 AutoReadOnly
int property kNote				= 48 AutoReadOnly
int property kOutfit				= 124 AutoReadOnly
int property kPHZD				= 70 AutoReadOnly
int property kPackage				= 79 AutoReadOnly
int property kPerk				= 92 AutoReadOnly
int property kPotion				= 46 AutoReadOnly
int property kProjectile			= 50 AutoReadOnly
int property kQuest				= 77 AutoReadOnly
int property kRace				= 14 AutoReadOnly
int property kRagdoll				= 106 AutoReadOnly
int property kReference				= 61 AutoReadOnly
int property kReferenceEffect			= 57 AutoReadOnly
int property kRegion				= 58 AutoReadOnly
int property kRelationship			= 121 AutoReadOnly
int property kReverbParam			= 134 AutoReadOnly
int property kScene				= 122 AutoReadOnly
int property kScript				= 19 AutoReadOnly
int property kScrollItem			= 23 AutoReadOnly
int property kShaderParticleGeometryData	= 56 AutoReadOnly
int property kShout				= 119 AutoReadOnly
int property kSkill				= 17 AutoReadOnly
int property kSoulGem				= 52 AutoReadOnly
int property kSound				= 15 AutoReadOnly
int property kSoundCategory			= 130 AutoReadOnly
int property kSoundDescriptor			= 128 AutoReadOnly
int property kSoundOutput			= 131 AutoReadOnly
int property kSpell				= 22 AutoReadOnly
int property kStatic				= 34 AutoReadOnly
int property kStaticCollection			= 35 AutoReadOnly
int property kStoryBranchNode			= 112 AutoReadOnly
int property kStoryEventNode			= 114 AutoReadOnly
int property kStoryQuestNode			= 113 AutoReadOnly
int property kTES4				= 1 AutoReadOnly
int property kTLOD				= 74 AutoReadOnly
int property kTOFT				= 86 AutoReadOnly
int property kTalkingActivator			= 25 AutoReadOnly
int property kTextureSet			= 7 AutoReadOnly
int property kTopic				= 75 AutoReadOnly
int property kTopicInfo				= 76 AutoReadOnly
int property kTree				= 38 AutoReadOnly
int property kVoiceType				= 98 AutoReadOnly
int property kWater				= 84 AutoReadOnly
int property kWeapon				= 41 AutoReadOnly
int property kWeather				= 54 AutoReadOnly
int property kWordOfPower			= 118 AutoReadOnly
int property kWorldSpace			= 71 AutoReadOnly

;///////////////////////////////////////////////////////////////////////////////
// Variable Declarations
/;
bool property isInit = false Auto

;///////////////////////////////////////////////////////////////////////////////
// LTT Base Related Properties
/;
int property prop_LTTSaveFile		= -1 Auto
int property prop_BaseActive		= -1 Auto
int property prop_Paused		= -1 Auto
int property prop_PauseKey		= -1 Auto
int property prop_FirstPersonMsgs	= -1 Auto
int property prop_ExpertiseReducesTime	= -1 Auto
int property prop_ShowMsgThreshold	= -1 Auto
int property prop_UserDebug		= -1 Auto

;///////////////////////////////////////////////////////////////////////////////
// State tracker IDs
/;
;int property state_LTTdebug		= -1 Auto
;int property state_LTTverbose		= -1 Auto
;int property state_LTTverMajor		= -1 Auto
;int property state_LTTverMinor		= -1 Auto
;int property state_LTTversion		= -1 Auto

int property state_Menu			= -1 Auto
int property state_IsLooting		= -1 Auto
int property state_IsCrafting		= -1 Auto
int property state_CraftingStation	= -1 Auto
int property state_IsPickpocketing	= -1 Auto

;///////////////////////////////////////////////////////////////////////////////
// The following tables are used to track variables with public interfaces
// without having to build get/set methods for each individual instance, or
// store default values, names and helper text for each. Having these in a few
// arrays makes FISS saving and loading really simple :)
// It's kind of like having an array of structures...
//
// If you ever change any of the _max* values, check all files for comments
// referencing this as the source.
/;

;///////////////////////////////////////////////////////////////////////////////
// Property Tables - these are the MCM settings
/;
int	 _maxProps	= 128
int	 _propCount	= 0
string[] _propName	; Unique name in the table
string[] _propPage	; The MCM page, based on the calling mod, on which to show the prop
string[] _propTitle	; To be shown in MCM as the setting text
string[] _propValue	; The current value set by MCM
string[] _propDefault	; The default value for MCM
string[] _propHelper	; The helper text for MCM
int[]	 _propMCMCell	; The position on the MCM page, so MODs can control their own layout without having to implement OnPageReset
int[]	 _propType	; What type of property to use in MCM, see list below.
float[]	 _propMinValue	; min & max settings for MCM
float[]	 _propMaxValue	; min & max settings for MCM
string[] _propUnits	; for MCM sliders
int[]	 _propModID	; for knowing which mod uses this prop.

int property propType_NONE	= 0x00 AutoReadonly
int property propType_TOGGLE	= 0x01 AutoReadonly
int property propType_INT	= 0x02 AutoReadonly
int property propType_FLOAT	= 0x04 AutoReadonly
int property propType_TEXT	= 0x08 AutoReadonly
int property propType_KEY	= 0x10 AutoReadonly
int property propType_LABEL	= 0x20 AutoReadonly

;///////////////////////////////////////////////////////////////////////////////
// Mod tables
/;
int	 _maxMods	= 32 ; Needs to also be set in LTT_Base.psc in mcmOnConfigInit Pages = new string[_maxMods]
int	 _modCount	= 0
string[] _modName	; Common name, printed in MCM
string[] _modESP	; filename of ESP to use on GetFormFromFile()
int[]	 _modPrefix	; 0xFF prefix for this mod, -1 if the we can't find the mod
int[]	 _modActions	; Which action handlers the mod registers
int[]	 _modMenus	; Which game menus does the mod want to track
LTT_ModBase[]	 _modObject	; Will be casted back to LTT_Base to call _modObect[ID]._function_()

int property act_NONE		= 0x00 AutoReadOnly
int property act_ITEMADDED	= 0x01 AutoReadOnly
int property act_ITEMREMOVED	= 0x02 AutoReadOnly
int property act_MENUOPENED	= 0x04 AutoReadOnly
int property act_MENUCLOSED	= 0x08 AutoReadOnly

;///////////////////////////////////////////////////////////////////////////////
// I want to use a bit-field to know which menus each mod cares about.
// The only thing is that there are more than 32 menus, so I need more than 32
// bits.  I can either eliminate some unlikely menus, or use two bit-fields and
// put each menu into one of two categories.
// I'm also not sure how I can map each each bitfield ID into an index for
// I think I'll have to eliminate some menus from the bitfield.
/;
int		_menuList		; the string list of all menus
int property	menu_None		= 0x00000000 AutoReadOnly
int property	menu_Barter		= 0x00000001 AutoReadOnly ; Part of trading
int property	menu_Book		= 0x00000002 AutoReadOnly ; while reading
int property	menu_Console		= 0x00000004 AutoReadOnly ; Probably not needed
int property	menu_ConsoleNative	= 0x00000008 AutoReadOnly ; Probably not needed
int property	menu_Container		= 0x00000010 AutoReadOnly ; while looting
int property	menu_Crafting		= 0x00000020 AutoReadOnly ; while crafting
int property	menu_Credits		= 0x00000040 AutoReadOnly ; probably not needed
int property	menu_Cursor		= 0x00000080 AutoReadOnly ; probably not needed
int property	menu_DebugText		= 0x00000100 AutoReadOnly ; probably not needed
int property	menu_Dialogue		= 0x00000200 AutoReadOnly ; in case to prevent during combat
int property	menu_Fader		= 0x00000400 AutoReadOnly ; probably not needed
int property	menu_Favorites		= 0x00000800 AutoReadOnly ; in case to prevent during combat
int property	menu_Gift		= 0x00001000 AutoReadOnly ; Part of trading
int property	menu_HUDMenu		= 0x00002000 AutoReadOnly ; probably not needed
int property	menu_Inventory		= 0x00004000 AutoReadOnly ; Part of preparing, and prevent during combat
int property	menu_Journal		= 0x00008000 AutoReadOnly ; Part of preparing, and prevent during combat
;int property	menu_Kinect		= 0x00010000 AutoReadOnly ; If this is the xbox kinect menu, then it's probably not needed
int property	menu_Training		= 0x00010000 AutoReadOnly
int property	menu_LevelUp		= 0x00020000 AutoReadOnly
int property	menu_Loading		= 0x00040000 AutoReadOnly ; probably don't want to pass time during a loading menu
int property	menu_Lockpicking	= 0x00080000 AutoReadOnly
int property	menu_Magic		= 0x00100000 AutoReadOnly ; Part of preparing, and prevent during combat
;int property	menu_MainMenu		= 0x00200000 AutoReadOnly ; not needed as there's no game being played at this menu
int property	menu_Tween		= 0x00200000 AutoReadOnly
int property	menu_Map		= 0x00400000 AutoReadOnly ; Part of preparing, and prevent during combat
int property	menu_MessageBox		= 0x00800000 AutoReadOnly ; Probably not needed, but an aggressive mod might want to consider this as preparation
int property	menu_Mist		= 0x01000000 AutoReadOnly ; Probably not needed, I think this is an overlay on loading and main meny screens
int property	menu_OverlayInteraction	= 0x02000000 AutoReadOnly ; Probably not needed
int property	menu_Overlay		= 0x04000000 AutoReadOnly ; Probably not needed
int property	menu_Quantity		= 0x08000000 AutoReadOnly ; Probably not needed
int property	menu_RaceSex		= 0x10000000 AutoReadOnly ; Probably not needed, but the face sculpter could take time
int property	menu_SleepWait		= 0x20000000 AutoReadOnly ; Probably not needed, already passes time
int property	menu_Stats		= 0x40000000 AutoReadOnly
int property	menu_TitleSequence	= 0x80000000 AutoReadOnly ; Probably not needed
; The rest are not possible as they would use bits 33 and above
;int property	menu_TopMenu		= 0x100000000 AutoReadOnly
; moved Training menu instead of kinect menu
;int property	menu_Tutorial		= 0x400000000 AutoReadOnly
; moved Tween menu instead of main menu

;///////////////////////////////////////////////////////////////////////////////
// Time Passing tracker tables based on in-game stats, not saved to FISS
/;
int	 _maxStats	= 32
int	 _statCount	= 0
string[] _statName	; Unique name for looking if the stat exists on addStat()
int[]	 _statStart	; starting value when calculating differences

;///////////////////////////////////////////////////////////////////////////////
// State trackers, should really use native Papyrus states, maybe in a future
// release.
/;
int	 _maxStates	= 16
int	 _stateCount	= 0
string[] _stateName	; Unique name in the table
string[] _stateValue	; starting value for the state
form[]	 _stateForm	; Some states are forms, not native variables and cant be casted.

;///////////////////////////////////////////////////////////////////////////////
// Stations used for crafting ( smithing, tanning, smelting, etc )
// Skyrim calls it a piece of furniture, I call it a station.
// This is a slightly different table than the rest because all we need to do
// is let LTT know to check for it's keyword.
/;
int	 _maxStations	 = 32
int	 _stationCount	 = 2
string[] _stationKeyword ; The keyword to reference from the ESP, unique name
;;;DISABLE;;;string	 _stationOther	 = "other"
;;;DISABLE;;;string[] _stationName	 ; common name used in scripts (needed?)

int property station_None	= 0 AutoReadOnly
int property station_Other	= 1 AutoReadOnly

;;;;;
;;;
;;; TODO
;;; The following should be moved to LTT_Skyrim
;;;
int property station_Smelting	= -1 Auto
int property station_Cooking	= -1 Auto
int property station_Tanning	= -1 Auto
int property station_Forging	= -1 Auto
int property station_Tempering	= -1 Auto
int property station_Sharpening	= -1 Auto
int property station_SkyForge	= -1 Auto
int property station_Mixing	= -1 Auto
int property station_Enchanting	= -1 Auto
;;;;;

;///////////////////////////////////////////////////////////////////////////////
// Menus are like stations, let mod register a menu to be checked against
// Because of the bitfields required, the menu indexes will be fairly hard-coded
/;
int	 _maxMenus	= 33 ; (always 32+1 because of the bitfields)
int	 _menuCount	= 33
string[] _menuName	; Official name within the game.

;///////////////////////////////////////////////////////////////////////////////
// Free items happen when splitting, like removing a bedroll from a tent, or
// splitting a backpack and amulet (chesko_frostfall or Campfire)
/;
int	 _maxFreeItems	= 4 ; 
int	 _freeItemCount	= 0 ;
Form[]	 _freeItems	; akBaseItem that is free

;///////////////////////////////////////////////////////////////////////////////
// Time-passed markers
/;
float	_startTime	= 0.0

;///////////////////////////////////////////////////////////////////////////////
// Misc trackers
/;
bool	_critSection	= False  ;; mlheur - I still don't know why dragonsong put this in here.

;///////////////////////////////////////////////////////////////////////////////
// Public Interfaces
/;

float function convertMinsToHrs( float Mins )
	return Mins/60
EndFunction

float function convertHrsToMins( float Hrs )
	return Hrs*60
EndFunction

int function getFormPrefix( form f )
	LTT.DebugLog( "++getFormPrefix()"\
	  +": form="+f\
	)
	if f == none
		LTT.DebugLog( "--getFormPrefix(); failed" )
		return -1
	endif
	LTT.DebugLog( "--getFormPrefix(); success" )
	return Math.RightShift(f.GetFormID(), 24)
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Start a timer and then return hours passed when endTimer is called
/;
float function startTimer()
	_startTime = Utility.GetCurrentRealTime()
	return _startTime
endfunction

float function endTimer()
	float End = Utility.GetCurrentRealTime()
	float Diff = End - _startTime
	_startTime = End
	return Diff
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Similar to timers, but track a certain player statistic changing
/;

int function addStat( string Name ) ; called only by LTT_Base
	LTT.DebugLog( "++addStat()" \
	  +": Name="+Name \
	)
	while ! isInit
		Utility.WaitMenuMode(LoadWaitTime)
	endwhile
	int ID = _statIndex( Name )
	if ID < 0
		ID = _statCount
		_statCount += 1
	endif
	if ID >= _maxStats
		LTT.Log( "Development Error: Ran out of Time Passer tablespace, update _maxStats in LTT_DataHandler.psc" )
		LTT.DebugLog( "--addStat(); failed" )
		return -1
	endif
	_statName[ID] = Name
	LTT.DebugLog( "--addStat(); success ID="+ID )
	return ID
endfunction

int function startStat( int ID )
	if ID < 0
		return -1
	endif
	_statStart[ID] = Game.QueryStat( _statName[ID] )
endfunction

int function endStat( int ID )
	if ID < 0
		return -1
	endif
	int End = Game.QueryStat( _statName[ID] )
	int Diff = End - _statStart[ID]
	_statStart[ID] = END
	return( Diff )
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Other trackers
/;

bool function isPickpocketing()
	bool Is = false
	Actor LastTarget = Game.GetCurrentCrosshairRef() as Actor
	if (LastTarget && !LastTarget.isDead() && Game.GetPlayer().isSneaking())
		Is = True
	endif
	return Is
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Property adders, getters & setters
/;

; returns the ID of the last station in the table, for iterators in LTT_Base
int function getLastProp()
	return _propCount - 1
endfunction

; returns the index of the property in the table, -1 on error
int function addStringProp( int modID, string Name, string Default, string Title, string Helper, int MCMCell, float MinValue = 0.0, float MaxValue = 0.0, string Units = "", int PropType = -1 )
	LTT.DebugLog( "++addStringProp()" \
	  +": modID="+modID \
	  +": Name="+Name \
	  +": Default="+Default \
	  +": Title="+Title \
	  +": Helper="+Helper \
	  +": MCMCell="+MCMCell \
	  +": MinValue="+MinValue \
	  +": MaxValue="+MaxValue \
	  +": Units="+Units \
	  +": PropType="+PropType \
	)
	bool isNew = false
	if PropType < 0
		PropType = propType_NONE
	endif
	; Check if this is already in the table
	int ID = _propIndex( Name )
	; or else generate a new one
	if ID < 0
		ID = _propCount
		_propCount += 1
		isNew = true
	endif
	if ID >= _maxProps
		LTT.Log( "Development Error: Ran out of Prop tablespace, update _maxProps in LTT_DataHandler.psc" )
		LTT.DebugLog( "--addStringProp(); failed" )
		return -1
	endif
	; Set mod details
	_propName[ID]		= Name
	if isNew
		_propValue[ID]		= Default
	endif
	_propTitle[ID]		= Title
	_propDefault[ID]	= Default
	_propHelper[ID]		= Helper
	_propMCMCell[ID]	= MCMCell
	_propType[ID]		= PropType
	_propMinValue[ID]	= MinValue
	_propMaxValue[ID]	= MaxValue
	_propUnits[ID]		= Units
	_propModID[ID]		= modID
	if modID < 0
		_propPage[ID]		= LTT.mcm.ModName
	else
		_propPage[ID]		= _modName[modID]
	endif
	LTT.DebugLog( "--addStringProp(); success ID="+ID )
	return ID
endfunction
int function addIntProp( int modID, string Name, int Default, string Title, string Helper, int MCMCell, int MinValue, int MaxValue, string Units, int PropType = -1 )
	if PropType < 0
		PropType = propType_INT
	endif
	return addStringProp( modID, Name, Default as String, Title, Helper, MCMCell, MinValue as float, MaxValue as float, Units, PropType )
endfunction
int function addKeyProp( int modID, string Name, int Default, string Title, string Helper, int MCMCell  )
	return addIntProp( modID, Name, Default, Title, Helper, MCMCell, 0, 0, "", propType_KEY )
endfunction
int function addFloatProp( int modID, string Name, float Default, string Title, string Helper, int MCMCell, float MinValue, float MaxValue, string Units )
	return addStringProp( modID, Name, Default as String, Title, Helper, MCMCell, MinValue, MaxValue, Units, propType_FLOAT )
endfunction
int function addBoolProp( int modID, string Name, bool Default, string Title, string Helper, int MCMCell  )
	return addStringProp( modID, Name, Default as string, Title, Helper, MCMCell, 0.0, 0.0, "", propType_TOGGLE )
endfunction

function setPropToDefault( int ID )
	if ID < 0
		return
	endif
	_propValue[ID] = _propDefault[ID]
endfunction

; Returns false if the property is not found
bool function setStringProp( int ID, string Value )
	if ID < 0
		LTT.Log( "$E_PROPVALUE_NOT_SET" )
		return false
	endif
	_propValue[ID] = Value
	return true
endfunction
bool function setIntProp( int ID, int Value )
	return setStringProp( ID, Value as string )
endfunction
bool function setFloatProp( int ID, string Value )
	return setStringProp( ID, Value as string )
endfunction
bool function setBoolProp( int ID, string Value )
	return setStringProp( ID, Value as string )
endfunction

string function getPropName( int ID )
	if ID < 0
		LTT.Log( "$E_NO_PROP_NAME" )
		return "$E_NO_PROP_NAME"
	endif
	return _propName[ID]
endfunction

string function getStringProp( int ID )
	;Debug.Trace( "[LTT] :: --getStringProp() ID="+ID ) ; can't use regular debug logging because it call getProp
	if ID < 0
		LTT.Log( "$E_NO_PROP_VALUE"+" ID="+ID )
		;Debug.Trace( "[LTT] :: --getStringProp() V="+"$E_NO_PROP_VALUE" ) ; can't use regular debug logging because it call getProp
		return "$E_NO_PROP_VALUE"
	endif
	;Debug.Trace( "[LTT] :: --getStringProp() V="+_propValue[ID] ) ; can't use regular debug logging because it call getProp
	return _propValue[ID]
endfunction
int function getIntProp( int ID )
	return( getStringProp( ID ) as int )
endfunction
float function getFloatProp( int ID )
	return( getStringProp( ID ) as float )
endfunction
bool function getBoolProp( int ID )
	;LTT.DebugLog( "++getBoolProp() ID="+ID ) ; Can't do this because Debug calls getBoolProp...
	;Debug.Trace( "[LTT] ++getBoolProp() ID="+ID )
	;
	; Damn papyrus. Take a false bool, cast it to a string and back to a
	; bool and it comes back true because bool > string = "False" and any
	; any "*" > bool is true.  Casting a false bool to string should have
	; the string as "", and the bool.tostring should be "False"
	; 
	bool V = true
	string S = getStringProp( ID )
	if S == "False"
		V = false
	endif
	;LTT.DebugLog( "--getBoolProp() V="+V ) ; Can't do this because Debug calls getBoolProp...
	;Debug.Trace( "[LTT] --getBoolProp() V="+V )
	return( V )
endfunction

string function getStringPropDefault( int ID )
	if ID < 0
		LTT.Log( "$E_NO_PROP_DEFAULT" )
		return "$E_NO_PROP_DEFAULT"
	endif
	return _propValue[ID]
endfunction
int function getIntPropDefault( int ID )
	return getStringPropDefault( ID ) as int
endfunction
float function getFloatPropDefault( int ID )
	return getStringPropDefault( ID ) as float
endfunction
bool function getBoolPropDefault( int ID )
	return getStringPropDefault( ID ) as bool
endfunction

string function getPropTitle( int ID )
	if ID < 0
		LTT.Log( "$E_NO_PROP_TITLE" )
		return "$E_NO_PROP_TITLE"
	endif
	return _propTitle[ID]
endfunction

string function getPropHelper( int ID )
	if ID < 0
		LTT.Log( "$E_NO_PROP_HELPER" )
		return "$E_NO_PROP_HELPER"
	endif
	return _propHelper[ID]
endfunction

int function getPropMCMCell( int ID )
	if ID < 0
		LTT.Log( "$E_NO_PROP_MCMCELL" )
		return -1
	endif
	return _propMCMCell[ID]
endfunction

int function getPropType( int ID )
	if ID < 0
		LTT.Log( "$E_NO_PROP_MCMCELL" )
		return -1
	endif
	return _propType[ID]
endfunction

int function getIntPropMin( int ID )
	if ID < 0
		LTT.Log( "$E_NO_INT_PROP_MINVALUE" )
		return -1
	endif
	return _propMinValue[ID] as int
endfunction

int function getIntPropMax( int ID )
	if ID < 0
		LTT.Log( "$E_NO_INT_PROP_MAXVALUE" )
		return -1
	endif
	return _propMaxValue[ID] as int
endfunction

float function getFloatPropMin( int ID )
	if ID < 0
		LTT.Log( "$E_NO_FLOAT_PROP_MINVALUE" )
		return -1
	endif
	return _propMinValue[ID]
endfunction

float function getFloatPropMax( int ID )
	if ID < 0
		LTT.Log( "$E_NO_FLOAT_PROP_MAXVALUE" )
		return -1
	endif
	return _propMaxValue[ID]
endfunction

string function getPropPage( int ID )
	if ID < 0
		return ""
	endif
	return _propPage[ID]
endfunction

string function getPropUnits( int ID )
	if ID < 0
		return ""
	endif
	return _propUnits[ID]
endfunction

int function getPropModID( int ID )
	if ID < 0
		return -1
	endif
	return _propModID[ID]
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Mod adders, getters & setters
/;
bool _lockAddMod = false
int function addMod( LTT_ModBase Mod, string Name, string ESP, int TestForm, int ACT = -1, int Menus = 0 )
	if _lockAddMod
		return -2
	endif
	_lockAddMod = true
	LTT.DebugLog( "++addMod()" \
	  +": Mod="+Mod \
	  +": Name="+Name \
	  +": ESP="+ESP \
	  +": TestForm="+TestForm \
	  +": ACT="+ACT \
	  +": Menus="+Menus \
	)
	if ACT < 0
		ACT = act_NONE
	endif
	; Check if this is already in the table
	int ID = _modIndex( Name )
	; or else generate a new one
	if ID < 0
		ID = _modCount
		_modCount += 1
	endif
	if ID >= _maxMods
		LTT.Log( "Development Error: Ran out of mod tablespace, update _maxMods in LTT_DataHandler.psc" )
		LTT.DebugLog( "--addMod(); failed" )
		return -1
	endif
	; Set mod details
	_modObject[ID]	= Mod
	_modName[ID]	= Name
	if ESP != "$E_SET_ESP_FILE"
		_modESP[ID]	= ESP
		_modPrefix[ID]	= getFormPrefix( Game.GetFormFromFile( TestForm, ESP ) )
		_modActions[ID] = ACT
		_modMenus[ID]	= Menus
	endif
	LTT.reloadMCMPages()
	LTT.DebugLog( "--addMod(); success ID="+ID )
	_lockAddMod = false
	return ID
endfunction

; returns the ID of the last station in the table, for iterators in LTT_Base
int function getLastMod()
	return _modCount - 1
endfunction

int function getMaxMods()
	return _maxMods
endfunction

LTT_ModBase function getMod( int ID )
	if ID < 0
		return none
	endif
	return _modObject[ID]
endfunction

string function getModName( int ID )
	if ID < 0
		return "$E_NO_MOD"+" ID="+ID
	endif
	return _modName[ID]
endfunction

bool function registerModActions( int ID, int ACT = -1 )
	if ACT < 0
		ACT = act_NONE
	endif
	if ID < 0
		return false
	endif
	_modActions[ID] = ACT
	return true
endfunction

int function getModPrefix( int ID )
	if ID < 0
		return -1
	endif
	return _modPrefix[ID]
endfunction

bool function isModRegisterdForMenu( int ID, int Menu )
	if ID < 0
		return false
	endif
	if Math.LogicalAnd( Menu, _modMenus[ID] )
		return true
	endif
	return false
endfunction

int function getModMenus( int ID )
	if ID < 0
		return 0
	endif
	return _modMenus[ID]
endfunction

function removeModMenuRegistration( int ID, int Menu )
	if ID < 0
		return
	endif
	_modMenus[ID] = Math.LogicalOr( _modMenus[ID], Menu )
endfunction

function addModMenuRegistration( int ID, int Menu )
	if ID < 0
		return
	endif
	int Complement = Math.LogicalAnd( Math.LogicalNot(Menu), 0xFFFFFFFF )
	_modMenus[ID] = Math.LogicalOr( _modMenus[ID], Complement )
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Splitters
// Probably not thread-safe and not very portable, but knowing the crafting
// stations and scripts where this is used, it should be OK.
/;
function addFreeItem( form BaseItem )
	while ! isInit
		Utility.WaitMenuMode(LoadWaitTime)
	endwhile
	_freeItems[_freeItemCount] = BaseItem
	_freeItemCount += 1
endfunction
bool function removeFreeItem( form BaseItem )
	LTT.DebugLog( "++removeFreeItem()" \
	  +": BaseItem="+BaseItem\
	)
	bool removed = false
	int i = 0
	while ( i <= _freeItemCount && i < _maxFreeItems )
		if BaseItem == _freeItems[i] || BaseItem.HasKeyword( _freeItems[i] as Keyword )
			_freeItems[i] = none
			_freeItemCount -= 1
			removed = true
		endif
		i+=1
	endwhile
	; TODO: our freeItemList can become fragmented.  I'd like to defragment
	; but don't want to take the performance hit...  make multi-threaded
	i = _maxFreeItems - 1
	int LastFreeI = 0
	while i >= LastFreeI && removed
		while _freeItems[i] == none && i >= 0
			i -= 1
		endwhile
		while _freeItems[LastFreeI] != none && LastFreeI < _maxFreeItems
			LastFreeI += 1
		endwhile
		if i > LastFreeI
			_freeItems[LastFreeI] = _freeItems[i]
		endif
	endwhile
	LTT.DebugLog( "--removeFreeItem() removed="+removed )
	return removed
endfunction


;///////////////////////////////////////////////////////////////////////////////
// State trackers (is looting, is crafting, craft station, etc)
/;

; returns the index of the state in the table, -1 on error
int function addStringState( string Name, string Value = "$E_STATE_NOT_SET", form f = none );
	LTT.DebugLog( "++addStringState():"\
	  +" Name="+Name\
	  +" Value="+Value\
	  +" Form="+f\
	)
	while ! isInit
		Utility.WaitMenuMode(LoadWaitTime)
	endwhile
	int ID = _stateIndex( Name )
	if ID < 0
		ID = _stateCount
		_stateCount += 1
	endif
	if ID >= _maxStates
		LTT.Log( "Development Error: Ran out of State tablespace, update _maxStates in LTT_DataHandler.psc" )
		LTT.DebugLog( "--addStringState(); failed" )
		return -1
	endif
	_stateName[ID] = Name
	_stateValue[ID] = Value
	_stateForm[ID] = f
	LTT.DebugLog( "--addStringState(); success" )
	return ID
endfunction
int function addFormState( string Name, form Value = none )
	return addStringState( Name, "", Value )
endfunction
int function addIntState( string Name, int Value = -1 )
	return addStringState( Name, Value as string )
endfunction
int function addFloatState( string Name, float Value = -1.0)
	return addStringState( Name, Value as string )
endfunction
int function addBoolState( string Name, bool Value = false)
	return addStringState( Name, Value as string )
endfunction

; returns whether or not the state was set properly
bool function setStringState( int ID, string Value )
	if ID < 0
		return false
	endif
	_stateValue[ID] = Value
	return true
endfunction
bool function setFormState( int ID, form Value )
	if ID < 0
		return false
	endif
	_stateForm[ID] = Value
	return true
endfunction
bool function setIntState( int ID, int Value )
	return setStringState( ID, Value as string )
endfunction
bool function setFloatState( int ID, float Value )
	return setStringState( ID, Value as string )
endfunction
bool function setBoolState( int ID, bool Value )
	return setStringState( ID, Value as string )
endfunction

; returns state value, "$ERROR" on error
string function getStringState( int ID )
	if ID < 0
		return "$ERROR"
	endif
	return _stateValue[ID]
endfunction
form function getFormState( int ID )
	if ID < 0
		return none
	endif
	return _stateForm[ID]
endfunction
int function getIntState( int ID )
	return getStringState( ID ) as int
endfunction
float function getFloatState( int ID )
	return getStringState( ID ) as float
endfunction
bool function getBoolState( int ID )
	return getStringState( ID ) as bool
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Crafting Stations
/;

; returns the index of the station in the table, -1 on error
int function addStation( string KW ) ;, string Name )
	LTT.DebugLog( "++addStation()" \
	  +": KW="+KW \
	)
	int ID = _stationIndex( KW )
	if ID < 0
		ID = _stationCount
		_stationCount += 1
	endif
	if ID >= _maxStations
		LTT.Log( "Development Error: Ran out of Crafting Station tablespace, update _maxStationss in LTT_DataHandler.psc" )
		LTT.DebugLog( "--addStation(); failed" )
		return -1
	endif
	_stationKeyword[ID] = KW
;;;DISABLE;;;	_stationName[ID] = Name
	LTT.DebugLog( "--addStation(); success ID="+ID )
	return ID
endfunction

; allow a mod to remove its station from the table for a period of time (like unregister event)
;;;DISABLE;;;function delStation( int ID )
;;;DISABLE;;;	if ID < 0
;;;DISABLE;;;		return
;;;DISABLE;;;	endif
;;;DISABLE;;;	_stationName[ID] = _stationNone
;;;DISABLE;;;endfunction

; returns the ESP keyword of the station in the table, "other" if not found
string function getStation( int ID )
	if ID < 0
		return _stationKeyword[station_Other]
	endif
	return _stationKeyword[ID]
endfunction

int function getStationKeyword( ObjectReference Station )
	int i = 0
	while i < _stationCount
		if Station.HasKeywordString( _stationKeyword[i] )
			return i
		endif
		i+=1
	endwhile
	return station_Other
endfunction

; returns the mod's common name of the station in the table, "other" if not found
;;;DISABLED;;;string function getStationName( int ID )
;;;DISABLED;;;	if ID < 0
;;;DISABLED;;;		return _stationNone
;;;DISABLED;;;	endif
;;;DISABLED;;;	return _stationName[ID]
;;;DISABLED;;;endfunction

; returns the ID of the last station in the table, for iterators in LTT_Base
int function getLastStation()
	return _stationCount - 1
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Game Menus
/;

; returns the menu name, used to iterate when you don't know what menu is needed
string function getMenu( int ID )
	if ID < 0
		return ""
	endif
	return _menuName[ID]
endfunction

; returns the ID of the last menu in the table, for iterators in LTT_Base
int function getLastMenu()
	return _menuCount - 1
endfunction

int function getMenuIndex( int Menu )
	int Divisor = Menu
	int i = 0
;;	LTT.DebugLog( "++getMenuIndex() Menu="+Menu, false )
	while ( i < 32 )
;;		LTT.DebugLog( "  getMenuIndex: i="+i+"; Divisor="+Divisor )
		if Divisor == 1 || Divisor == -1
;;			LTT.DebugLog( "--getMenuIndex(); "+(i+1), false )
			return i+1
		endif
		i+=1
		Divisor/=2
	endwhile
;;	LTT.DebugLog( "--getMenuIndex(); "+-1, false )
	return -1
endfunction

int function getMenuID( string Name )
	return _index( Name, _menuName, _menuCount, _maxMenus )
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Private Functions
/;

function _Init( int Version )
	LTT.DebugLog( "++LDH::_Init()" )
	
	if isInit ; should also check for version changes
		LTT.DebugLog( "--LDH::_Init(); already configured" )
		return
	endif
	
	; Allocate memory for the lookup tables.
	_propName	= new string[128]	; _maxProps
	_propValue	= new string[128]	; _maxProps
	_propTitle	= new string[128]	; _maxProps
	_propDefault	= new string[128]	; _maxProps
	_propHelper	= new string[128]	; _maxProps
	_propMCMCell	= new int[128]		; _maxProps
	_propType	= new int[128]		; _maxProps
	_propMinValue	= new float[128]	; _maxProps
	_propMaxValue	= new float[128]	; _maxProps
	_propPage	= new string[128]	; _maxProps
	_propUnits	= new string[128]	; _maxProps
	_propModID	= new int[128]		; _maxProps

	_modName	= new string[32]	; _maxMods
	_modESP		= new string[32]	; _maxMods
	_modPrefix	= new int[32]		; _maxMods
	_modActions	= new int[32]		; _maxMods
	_modMenus	= new int[32]		; _maxMods
	_modObject	= new LTT_ModBase[32]	; _maxMods
	
	_statName	= new string[32]	; _maxStats
	_statStart	= new int[32]		; _maxStats
	
	_stateName	= new string[16]	; _maxStates
	_stateValue	= new string[16]	; _maxStates
	_stateForm	= new form[16]		; _maxStates
	
	_stationKeyword = new string[32]	; _maxStations
;;;DISABLE;;;	_stationName	= new string[32]	; _maxStations
	_stationKeyword[station_None]	= ""
	_stationKeyword[station_Other]	= "other"
	
	
	_menuName	= new string[33]	; _maxMenus (always 32+1 because of the bitfields)
	
	_freeItems	= new form[4]		; _maxFreeItems
	
	_menuName[0]						= ""
	_menuName[getMenuIndex(menu_Barter)]			= "BarterMenu"
	_menuName[getMenuIndex(menu_Book)]			= "Book Menu"
	_menuName[getMenuIndex(menu_Console)]			= "Console"
	_menuName[getMenuIndex(menu_ConsoleNative)]		= "Console Native UI Menu"
	_menuName[getMenuIndex(menu_Container)]			= "ContainerMenu"
	_menuName[getMenuIndex(menu_Crafting)]			= "Crafting Menu"
	_menuName[getMenuIndex(menu_Credits)]			= "Credits Menu"
	_menuName[getMenuIndex(menu_Cursor)]			= "Cursor Menu"
	_menuName[getMenuIndex(menu_DebugText)]			= "Debug Text Menu"
	_menuName[getMenuIndex(menu_Dialogue)]			= "Dialogue Menu"
	_menuName[getMenuIndex(menu_Fader)]			= "Fader Menu"
	_menuName[getMenuIndex(menu_Favorites)]			= "FavoritesMenu"
	_menuName[getMenuIndex(menu_Gift)]			= "GiftMenu"
	_menuName[getMenuIndex(menu_HUDMenu)]			= "HUD Menu"
	_menuName[getMenuIndex(menu_Inventory)]			= "InventoryMenu"
	_menuName[getMenuIndex(menu_Journal)]			= "Journal Menu"
	;_menuName[getMenuIndex(menu_Kinect)]			= "Kinect Menu"
	_menuName[getMenuIndex(menu_LevelUp)]			= "LevelUp Menu"
	_menuName[getMenuIndex(menu_Loading)]			= "Loading Menu"
	_menuName[getMenuIndex(menu_Lockpicking)]		= "Lockpicking Menu"
	_menuName[getMenuIndex(menu_Magic)]			= "MagicMenu"
	;_menuName[getMenuIndex(menu_MainMenu)]			= "Main Menu"
	_menuName[getMenuIndex(menu_Map)]			= "MapMenu"
	_menuName[getMenuIndex(menu_MessageBox)]		= "MessageBoxMenu"
	_menuName[getMenuIndex(menu_Mist)]			= "Mist Menu"
	_menuName[getMenuIndex(menu_OverlayInteraction)]	= "Overlay Interaction Menu"
	_menuName[getMenuIndex(menu_Overlay)]			= "Overlay Menu"
	_menuName[getMenuIndex(menu_Quantity)]			= "Quantity Menu"
	_menuName[getMenuIndex(menu_RaceSex)]			= "RaceSex Menu"
	_menuName[getMenuIndex(menu_SleepWait)]			= "Sleep/Wait Menu"
	_menuName[getMenuIndex(menu_Stats)]			= "StatsMenu"
	_menuName[getMenuIndex(menu_TitleSequence)]		= "TitleSequence Menu"
	;_menuName[getMenuIndex(menu_TopMenu)]			= "Top Menu"
	_menuName[getMenuIndex(menu_Training)]			= "Training Menu"
	;_menuName[getMenuIndex(menu_Tutorial)]			= "Tutorial Menu"
	_menuName[getMenuIndex(menu_Tween)]			= "TweenMenu"
	
	isInit = true

	LTT.DebugLog( "--LDH::_Init(); success" )
endfunction

; Find indexes into tables based on names - these are private because they
; are not good performers and their use should be limited.
int function _index( string Name, string[] Table, int Count, int Max )
	int i = 0
	while ( i <= Count && i <= Max )
		if  Table[i] == Name
			return i
		endif
		i+=1
	endwhile
	return -1
endfunction

int function _propIndex( string Name )
	return _index( Name, _propName, _propCount, _maxProps )
endfunction

int function _modIndex( string Name )
	return _index( Name, _modName, _modCount, _maxMods )
endfunction

int function _statIndex( string Name )
	return _index( Name, _statName, _statCount, _maxStats )
endfunction

int function _stateIndex( string Name )
	return _index( Name, _stateName, _stateCount, _maxStates )
endfunction

int function _stationIndex( string Name )
	return _index( Name, _stationKeyword, _stationCount, _maxStations )
endfunction

function savePropTable( FISSInterface fiss, string filename )
	LTT.DebugLog( "++savePropTable() filename="+filename )
	fiss.beginSave( filename, LTT.mcm.ModName )
	
	int ID = getLastProp()
	while ID >= 0
		LTT.DebugLog( "Saving" \
		  +"ID="+ID \
		  +"Name="+_propName[ID] \
		  +"Value="+_propValue[ID] \
		)
		fiss.saveString( _propName[ID], _propValue[ID] )
		id -= 1
	endwhile
	
	string result = fiss.endSave()
	if result
		LTT.Log( "Save results: "+result )
		Debug.MessageBox( "Save failed\n"+result )
	else
		LTT.DebugLog( "Save results: "+result )
		Debug.MessageBox( "Saved successfully" )
	endif
	LTT.DebugLog( "--savePropTable(); success" )
endfunction

function loadPropTable( FISSInterface fiss, string filename )
	LTT.DebugLog( "++savePropTable() filename="+filename )
	fiss.beginLoad( filename )
	
	int ID = getLastProp()
	while ID >= 0
		_propValue[ID] = fiss.loadString( _propName[ID] )
		LTT.DebugLog( "Loaded" \
		  +": ID="+ID \
		  +"; Name="+_propName[ID] \
		  +"; Value="+_propValue[ID] \
		)
		if _propType[ID] == propType_TOGGLE
			; Let the owning mod do any work associated with changing
			; this flag, like no longer wanting a menu.
			LTT_ModBase mod = getMod( getPropModID( ID ) )
			if mod
				mod.handlePropToggle( ID, getBoolProp(ID) )		
			endif
		endif
		id -= 1
	endwhile
	
	string result = fiss.endLoad()
	if result
		LTT.Log( "Load results: "+result )
		Debug.MessageBox( "Load failed\n"+result )
	else
		LTT.DebugLog( "Load results: "+result )
		Debug.MessageBox( "Loaded successfully" )
	endif
	LTT.DebugLog( "--loadPropTable(); success" )
endfunction

function DumpTables( string Msg = "" )
	int i=0
	if Msg
		LTT.DebugLog( "DumpTables: "+Msg )
	endif
	while( i < _propCount )
		LTT.DebugLog( "Dumping Props i="+i\
		  +"; _propName=["+_propName[i]+"]"\
		  +"; _propPage=["+_propPage[i]+"]"\
		  +"; _propTitle=["+_propTitle[i]+"]"\
		  +"; _propValue=["+_propValue[i]+"]"\
		  +"; _propDefault=["+_propDefault[i]+"]"\
		  +"; _propHelper=["+_propHelper[i]+"]"\
		  +"; _propMCMCell=["+_propMCMCell[i]+"]"\
		  +"; _propType=["+_propType[i]+"]"\
		  +"; _propMinValue=["+_propMinValue[i]+"]"\
		  +"; _propMaxValue=["+_propMaxValue[i]+"]"\
		  +"; _propUnits=["+_propUnits[i]+"]"\
		)
		i+=1
	endwhile
	i=0
	while( i < _modCount )
		LTT.DebugLog( "Dumping Mods i="+i\
		  +"; _modName=["+_modName[i]+"]"\
		  +"; _modESP=["+_modESP[i]+"]"\
		  +"; _modPrefix=["+_modPrefix[i]+"]"\
		  +"; _modActions=["+_modActions[i]+"]"\
		  +"; _modMenus=["+_modMenus[i]+"]"\
		)
		i+=1
	endwhile
	i=0
	while( i < _stateCount )
		LTT.DebugLog( "Dumping States i="+i\
		  +"; _stateName=["+_stateName[i]+"]"\
		  +"; _stateValue=["+_stateValue[i]+"]"\
		  +"; _stateForm=["+_stateForm[i]+"]"\
		)
		i+=1
	endwhile
endfunction