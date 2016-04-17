scriptname LTT_DataHandler extends MiscObject

;///////////////////////////////////////////////////////////////////////////////
// TODO
/;
; Put loop counter limiters on WaitMenuMode() calls.

;///////////////////////////////////////////////////////////////////////////////
// Object References, set in ESP
/;
LTT_Base Property LTT Auto

;///////////////////////////////////////////////////////////////////////////////
// Constants
/;
float	property LockWaitTime		= 0.01 AutoReadOnly
int	property _spinlockTries		= 1000 AutoReadOnly

; Used for MCM properties to know what type of data is being stored
int property propType_NONE	= 0x00 AutoReadonly
int property propType_TOGGLE	= 0x01 AutoReadonly
int property propType_INT	= 0x02 AutoReadonly
int property propType_FLOAT	= 0x04 AutoReadonly
int property propType_TEXT	= 0x08 AutoReadonly
int property propType_KEY	= 0x10 AutoReadonly
int property propType_LABEL	= 0x20 AutoReadonly

;///////////////////////////////////////////////////////////////////////////////
// Variable Declarations
/;
bool property isInit = false Auto

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
	int PFX = -1
	DebugLog( "++getFormPrefix()"\
	  +": form="+f\
	, 4)
	if f == none
		DebugLog( "--getFormPrefix(); failed", 4 )
		return -1
	endif
	PFX = Math.RightShift(f.GetFormID(), 24)
	DebugLog( "--getFormPrefix(); PFX="+PFX, 4 )
	return PFX
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
bool _spinlockAddStat = false
int function addStat( string Name )
	int lockTries = 0
	while _spinlockAddStat
		Utility.WaitMenuMode( LockWaitTime )
		lockTries += 1
		if lockTries >= _spinlockTries
			return -1
		endif
	endwhile
	_spinlockAddStat = true
	DebugLog( "++addStat()" \
	  +": Name="+Name \
	, 4)
	int ID = _statIndex( Name )
	if ID < 0
		ID = _statCount
		_statCount += 1
	endif
	if ID >= _maxStats
		DebugLog( "Development Error: Ran out of DataHandler tablespace, update _maxStats in LTT_DataHandler.psc", -1, true )
		DebugLog( "--addStat(); failed", -1 )
		_spinlockAddStat = false
		return -1
	endif
	_statName[ID] = Name
	DebugLog( "--addStat(); success ID="+ID, 4 )
	_spinlockAddStat = false
	return ID
endfunction

int function startStat( int ID )
	DebugLog( "++startStat( ID"+ID+" )", 4 )
	if ID < 0
		DebugLog( "--startStat() failed", 0 )
		return -1
	endif
	DebugLog( "querying game stat: "+_statName[ID] )
	_statStart[ID] = Game.QueryStat( _statName[ID] )
	DebugLog( "game stat is: "+_statStart[ID] )
	DebugLog( "--startStat() success", 4 )
endfunction

int function endStat( int ID, bool update = true )
	DebugLog( "++endStat( ID="+ID+", update="+update+" )", 4 )
	if ID < 0
		DebugLog( "--endStat() failed", 0 )
		return -1
	endif
	DebugLog( "querying game endStat: "+_statName[ID] )
	DebugLog( "starting value: "+_statStart[ID] )
	int End = Game.QueryStat( _statName[ID] )
	DebugLog( "current value: "+End )
	int Diff = End - _statStart[ID]
	if update
		DebugLog( "Updating" )
		_statStart[ID] = END
	endif
	DebugLog( "--endStat() success="+Diff, 4 )
	return( Diff )
endfunction
int function peekStat( int ID )
	return endStat( ID, false )
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
bool _spinlockAddStringProp = false
int function addStringProp( int modID, string Name, string Default, string Title, string Helper, int MCMCell, float MinValue = 0.0, float MaxValue = 0.0, string Units = "", int PropType = -1 )
	int lockTries = 0
	while _spinlockAddStringProp
		Utility.WaitMenuMode( LockWaitTime )
		lockTries += 1
		if lockTries >= _spinlockTries
			return -1
		endif
	endwhile
	_spinlockAddStringProp = true
	DebugLog( "++addStringProp()" \
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
	, 4)
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
		DebugLog( "--addStringProp(); failed", -1 )
		_spinlockAddStringProp = false
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
	DebugLog( "--addStringProp(); success ID="+ID, 4 )
	_spinlockAddStringProp = false
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
	;DebugLog( "++getBoolProp() ID="+ID, 4 ) ; Can't do this because Debug calls getBoolProp...
	;Debug.Trace( "[LTT] ++getBoolProp() ID="+ID )
	;
	; Damn papyrus. Take a false bool, cast it to a string and back to a
	; bool and it comes back true because bool->string = "False" and any
	; any "*"->bool is true.  Casting a false bool to string should have
	; the string as "", and the bool.tostring should be "False"
	; 
	bool V = true
	string S = getStringProp( ID )
	if S == "False"
		V = false
	endif
	;DebugLog( "--getBoolProp() V="+V, 4 ) ; Can't do this because Debug calls getBoolProp...
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
bool _spinlockAddMod = false
int function addMod( LTT_ModBase Mod, string Name, string ESP, int TestForm, int ACT = 0, int Menus = 0 )
	int lockTries = 0
	while _spinlockAddMod
		Utility.WaitMenuMode( LockWaitTime )
		lockTries += 1
		if lockTries >= _spinlockTries
			return -1
		endif
	endwhile
	_spinlockAddMod = true
	int ID = -1
	DebugLog( "++addMod()" \
	  +": Mod="+Mod \
	  +": Name="+Name \
	  +": ESP="+ESP \
	  +": TestForm="+TestForm \
	  +": ACT="+ACT \
	  +": Menus="+Menus \
	, 4)
	
	; Check if this is already in the table
	DebugLog( "before index search" \
	  +": ID="+ID \
	  +": Name="+Name \
	, 4)
	ID = _modIndex( Name )
	DebugLog( "after index search" \
	  +": ID="+ID \
	  +": Name="+Name \
	, 4)
	
	; or else generate a new one
	if ID < 0
		; Index 0 is reserved for LTT_Skyrim, so if we've been given 0
		; but we're not == LTT.Skyrim them bump.
		if mod == LTT.Skyrim
			if _modCount == 0
				ID = _modCount
				_modCount += 1
			else
				ID = 0
				; and don't change _modCount
			endif
		else
			if _modCount == 0
				ID = 1
				_modCount = 2
			else
				ID = _modCount
				_modCount += 1
			endif
		endif
	endif
	DebugLog( "after adding new index" \
	  +": ID="+ID \
	  +": Name="+Name \
	, 4)
	
	
	if ID >= _maxMods
		LTT.Log( "Development Error: Ran out of mod tablespace, update _maxMods in LTT_DataHandler.psc" )
		DebugLog( "--addMod(); failed", -1 )
		_spinlockAddMod = false
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
	DebugLog( "--addMod(); success ID="+ID, 4 )
	_spinlockAddMod = false
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

bool function registerModActions( int ID, int ACT = 0 )
	if ID < 0
		return false
	endif
	_modActions[ID] = ACT
	return true
endfunction

bool function wantsAction( int ID, int ACT )
	return Math.LogicalAnd( _modActions[ID], ACT ) as bool
endfunction

int function getModPrefix( int ID )
	DebugLog( "++getModPrefix() ID="+ID, 4 )
	if ID < 0
		DebugLog( "--getModPrefix(); failed", 0 )
		return -1
	endif
	DebugLog( "--getModPrefix(); PFX="+_modPrefix[ID], 4 )
	return _modPrefix[ID]
endfunction

bool function setModPrefix( int ID, int PFX )
	if ID < 0
		return false
	endif
	_modPrefix[ID] = PFX
	return true
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
	_freeItems[_freeItemCount] = BaseItem
	_freeItemCount += 1
endfunction
bool function removeFreeItem( form BaseItem )
	DebugLog( "++removeFreeItem()" \
	  +": BaseItem="+BaseItem\
	, 4)
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
	DebugLog( "--removeFreeItem() removed="+removed, 4 )
	return removed
endfunction


;///////////////////////////////////////////////////////////////////////////////
// State trackers (is looting, is crafting, craft station, etc)
/;

; returns the index of the state in the table, -1 on error
bool _spinlockAddStringState = false
int function addStringState( string Name, string Value = "$E_STATE_NOT_SET", form f = none );
	int lockTries = 0
	while _spinlockAddStringState
		Utility.WaitMenuMode( LockWaitTime )
		lockTries += 1
		if lockTries >= _spinlockTries
			return -1
		endif
	endwhile
	_spinlockAddStringState = true
	DebugLog( "++addStringState():"\
	  +" Name="+Name\
	  +" Value="+Value\
	  +" Form="+f\
	, 4)
	int ID = _stateIndex( Name )
	if ID < 0
		ID = _stateCount
		_stateCount += 1
	endif
	if ID >= _maxStates
		LTT.Log( "Development Error: Ran out of State tablespace, update _maxStates in LTT_DataHandler.psc" )
		DebugLog( "--addStringState(); failed", -1 )
		_spinlockAddStringState = false
		return -1
	endif
	_stateName[ID] = Name
	_stateValue[ID] = Value
	_stateForm[ID] = f
	DebugLog( "--addStringState(); success", 4 )
	_spinlockAddStringState = false
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
	DebugLog( "++setStringState(): ID="+ID+"; Value="+Value, 4 )
	if ID < 0
		DebugLog( "--setStringState()=false", 4 )
		return false
	endif
	_stateValue[ID] = Value
	DebugLog( "--setStringState()=true", 4 )
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
	DebugLog( "++getStringState() ID="+ID, 4 )
	if ID < 0
		DebugLog( "--getStringState()="+"$ERROR", 4 )
		return "$ERROR"
	endif
		DebugLog( "--getStringState()="+_stateValue[ID], 4 )
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
bool _spinlockAddStation = false
int function addStation( string KW ) ;, string Name )
	int lockTries = 0
	while _spinlockAddStation
		Utility.WaitMenuMode( LockWaitTime )
		lockTries += 1
		if lockTries >= _spinlockTries
			return -1
		endif
	endwhile
	_spinlockAddStation = true
	DebugLog( "++addStation()" \
	  +": KW="+KW \
	, 4)
	int ID = _stationIndex( KW )
	if ID < 0
		ID = _stationCount
		_stationCount += 1
	endif
	if ID >= _maxStations
		LTT.Log( "Development Error: Ran out of Crafting Station tablespace, update _maxStationss in LTT_DataHandler.psc" )
		DebugLog( "--addStation(); failed", -1 )
		_spinlockAddStation = false
		return -1
	endif
	_stationKeyword[ID] = KW
	DebugLog( "--addStation(); success ID="+ID, 4 )
	_spinlockAddStation = false
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
	DebugLog( "++getStation() ID="+ID, 4 )
	if ID < 0
		DebugLog( "--getStation()="+_stationKeyword[LTT.station_Other], 4 )
		return _stationKeyword[LTT.station_Other]
	endif
	DebugLog( "--getStation()="+_stationKeyword[ID], 0 )
	return _stationKeyword[ID]
endfunction

int function getStationKeyword( ObjectReference Station )
	DebugLog( "++getStationKeyword() Station="+Station, 4 )
	int i = 0
	while i < _stationCount
		if Station.HasKeywordString( _stationKeyword[i] )
			DebugLog( "--getStationKeyword()="+i, 4 )
			return i
		endif
		i+=1
	endwhile
	DebugLog( "--getStationKeyword()="+LTT.station_Other, 4 )
	return LTT.station_Other
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
	DebugLog( "++getMenuIndex() Menu="+Menu, 5 )
	while ( i < 32 )
		DebugLog( "  getMenuIndex: i="+i+"; Divisor="+Divisor, 5 )
		if Divisor == 1 || Divisor == -1
			DebugLog( "--getMenuIndex(); "+(i+1), 5 )
			return i+1
		endif
		i+=1
		Divisor/=2
	endwhile
	DebugLog( "--getMenuIndex(); "+-1, 5 )
	return -1
endfunction

int function getMenuID( string Name )
	return _index( Name, _menuName, _menuCount, _maxMenus )
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Private Functions
/;

function _Init( int Version )
	DebugLog( "++LDH::_Init()", 4 )
	
	if isInit ; should also check for version changes
		DebugLog( "--LDH::_Init(); already configured", 4 )
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
	_stationKeyword[LTT.station_None]	= ""
	_stationKeyword[LTT.station_Other]	= "other"
	
	_freeItems	= new form[4]		; _maxFreeItems
	
	isInit = true

	DebugLog( "--LDH::_Init(); success", 4 )
endfunction

; Not doing this in _Init because I want to set the prop_DebugLevel before this.
function _InitMenus()
	_menuName	= new string[33]	; _maxMenus (always 32+1 because of the bitfields)
	_menuName[0]						= ""
	_menuName[getMenuIndex(LTT.menu_Barter)]			= "BarterMenu"
	_menuName[getMenuIndex(LTT.menu_Book)]			= "Book Menu"
	_menuName[getMenuIndex(LTT.menu_Console)]			= "Console"
	_menuName[getMenuIndex(LTT.menu_ConsoleNative)]		= "Console Native UI Menu"
	_menuName[getMenuIndex(LTT.menu_Container)]			= "ContainerMenu"
	_menuName[getMenuIndex(LTT.menu_Crafting)]			= "Crafting Menu"
	_menuName[getMenuIndex(LTT.menu_Credits)]			= "Credits Menu"
	_menuName[getMenuIndex(LTT.menu_Cursor)]			= "Cursor Menu"
	_menuName[getMenuIndex(LTT.menu_DebugText)]			= "Debug Text Menu"
	_menuName[getMenuIndex(LTT.menu_Dialogue)]			= "Dialogue Menu"
	_menuName[getMenuIndex(LTT.menu_Fader)]			= "Fader Menu"
	_menuName[getMenuIndex(LTT.menu_Favorites)]			= "FavoritesMenu"
	_menuName[getMenuIndex(LTT.menu_Gift)]			= "GiftMenu"
	_menuName[getMenuIndex(LTT.menu_HUDMenu)]			= "HUD Menu"
	_menuName[getMenuIndex(LTT.menu_Inventory)]			= "InventoryMenu"
	_menuName[getMenuIndex(LTT.menu_Journal)]			= "Journal Menu"
	;_menuName[getMenuIndex(LTT.menu_Kinect)]			= "Kinect Menu"
	_menuName[getMenuIndex(LTT.menu_LevelUp)]			= "LevelUp Menu"
	_menuName[getMenuIndex(LTT.menu_Loading)]			= "Loading Menu"
	_menuName[getMenuIndex(LTT.menu_Lockpicking)]		= "Lockpicking Menu"
	_menuName[getMenuIndex(LTT.menu_Magic)]			= "MagicMenu"
	;_menuName[getMenuIndex(LTT.menu_MainMenu)]			= "Main Menu"
	_menuName[getMenuIndex(LTT.menu_Map)]			= "MapMenu"
	_menuName[getMenuIndex(LTT.menu_MessageBox)]		= "MessageBoxMenu"
	_menuName[getMenuIndex(LTT.menu_Mist)]			= "Mist Menu"
	_menuName[getMenuIndex(LTT.menu_OverlayInteraction)]	= "Overlay Interaction Menu"
	_menuName[getMenuIndex(LTT.menu_Overlay)]			= "Overlay Menu"
	_menuName[getMenuIndex(LTT.menu_Quantity)]			= "Quantity Menu"
	_menuName[getMenuIndex(LTT.menu_RaceSex)]			= "RaceSex Menu"
	_menuName[getMenuIndex(LTT.menu_SleepWait)]			= "Sleep/Wait Menu"
	_menuName[getMenuIndex(LTT.menu_Stats)]			= "StatsMenu"
	_menuName[getMenuIndex(LTT.menu_TitleSequence)]		= "TitleSequence Menu"
	;_menuName[getMenuIndex(LTT.menu_TopMenu)]			= "Top Menu"
	_menuName[getMenuIndex(LTT.menu_Training)]			= "Training Menu"
	;_menuName[getMenuIndex(LTT.menu_Tutorial)]			= "Tutorial Menu"
	_menuName[getMenuIndex(LTT.menu_Tween)]			= "TweenMenu"
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
	DebugLog( "++savePropTable() filename="+filename, 4 )
	fiss.beginSave( filename, LTT.mcm.ModName )
	
	int ID = getLastProp()
	while ID >= 0
		DebugLog( "Saving" \
		  +"ID="+ID \
		  +"Name="+_propName[ID] \
		  +"Value="+_propValue[ID] \
		, 2)
		fiss.saveString( _propName[ID], _propValue[ID] )
		id -= 1
	endwhile
	
	string result = fiss.endSave()
	if result
		LTT.Log( "Save results: "+result )
		Debug.MessageBox( "Save failed\n"+result )
	else
		DebugLog( "Save results: "+result, 2 )
		Debug.MessageBox( "Saved successfully" )
	endif
	DebugLog( "--savePropTable(); success", 4 )
endfunction

function loadPropTable( FISSInterface fiss, string filename )
	DebugLog( "++loadPropTable() filename="+filename, 4 )
	fiss.beginLoad( filename )
	
	int ID = getLastProp()
	while ID >= 0
		_propValue[ID] = fiss.loadString( _propName[ID] )
		DebugLog( "Loaded" \
		  +": ID="+ID \
		  +"; Name="+_propName[ID] \
		  +"; Value="+_propValue[ID] \
		, 2)
		if _propType[ID] == propType_TOGGLE
			; Let the owning mod do any work associated with changing
			; this flag, like no longer wanting a menu.
			LTT_ModBase mod = getMod( getPropModID( ID ) )
			if mod
				mod.handlePropToggle( ID, getBoolProp(ID) )		
			endif
		elseif _propType[ID] == propType_Key
			LTT.mcm.RegisterForKey( _propValue[ID] as int )
		endif
		id -= 1
	endwhile
	
	string result = fiss.endLoad()
	if result
		LTT.Log( "Load results: "+result )
		Debug.MessageBox( "Load failed\n"+result )
		Debug.MessageBox( "$E_FISS_DONT_SAVE" )
	else
		DebugLog( "Load results: "+result, 2 )
		Debug.MessageBox( "Loaded successfully" )
	endif
	
	DebugLog( "--loadPropTable(); success, unless it failed", 4 )
endfunction

function DumpProps( string Msg = "", int Level = 3 )
	if !LTT.LTT_verbose
		return
	endif
	int i=0
	while( i < _propCount )
		DebugLog( "Dumping Props i="+i\
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
		, Level )
		i+=1
	endwhile
endfunction

function DumpMods( string Msg = "", int Level = 3 )
	if !LTT.LTT_verbose
		return
	endif
	int i=0
	while( i < _modCount )
		DebugLog( "Dumping Mods i="+i\
		  +"; _modName=["+_modName[i]+"]"\
		  +"; _modESP=["+_modESP[i]+"]"\
		  +"; _modPrefix=["+_modPrefix[i]+"]"\
		  +"; _modActions=["+_modActions[i]+"]"\
		  +"; _modMenus=["+_modMenus[i]+"]"\
		, Level )
		i+=1
	endwhile
endfunction

function DumpStats( string Msg = "", int Level = 3 )
	if !LTT.LTT_verbose
		return
	endif
	int i=0
	while( i < _statCount )
		DebugLog( "Dumping Tracked Stats i="+i\
		  +"; _statName=["+_statName[i]+"]"\
		  +"; _statStart=["+_statStart[i]+"]"\
		, Level )
		i+=1
	endwhile
endfunction

function DumpStates( string Msg = "", int Level = 3 )
	if !LTT.LTT_verbose
		return
	endif
	int i=0
	while( i < _stateCount )
		DebugLog( "Dumping States i="+i\
		  +"; _stateName=["+_stateName[i]+"]"\
		  +"; _stateValue=["+_stateValue[i]+"]"\
		  +"; _stateForm=["+_stateForm[i]+"]"\
		, Level )
		i+=1
	endwhile
endfunction

function DumpTables( string Msg = "", int Level = 3 )
	int i=0
	if !LTT.LTT_verbose
		return
	endif
	if Msg
		DebugLog( "DumpTables: "+Msg, Level )
	endif
	DumpProps( Msg, Level )
	DumpMods( Msg, Level )
	DumpStats( Msg, Level )
	DumpStates( Msg, Level )
endfunction

function DebugLog( string msg, int Level = 3, bool verbose = false )
	msg = "[LDH] "+msg
	LTT.DebugLog( msg, Level, verbose )
endfunction