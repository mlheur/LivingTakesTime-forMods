scriptname LTT_Common hidden

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Globals

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bool	Property LTT_debug	= true AtuoReadOnly ; when set, LTT in beta testing
bool	Property LTT_verbose	= true AtuoReadOnly ; when set, LTT in alpha testing
int	Property LTT_verMajor	= 0 AtuoReadOnly
int	Property LTT_verMinor	= 0 AtuoReadOnly
int	Property LTT_version	= ((LTT_verMajor*100)+LTT_verMinor) AtuoReadOnly

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Locals

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The following tables are used to track variables with public interfaces
; without having to build get/set methods for each, or store default values,
; names and helper text for each. Having these in a few arrays makes FISS saving
; and loading really simple :)
; It's kind of like having an array of structures...

;;;;;;;;;;;;;;;;;;;;
; Property Tables
int	 _maxProps	= 1024
int	 _propCount	= 0
string[] _propName	= new string[_maxProps]
string[] _propValue	= new string[_maxProps]
string[] _propDefault	= new string[_maxProps]
string[] _propHelper	= new string[_maxProps]
bool[]	 _propUseFISS	= new bool[_maxProps]
int[]	 _propType	= new int[_maxProps]
float[]	 _propMin	= new float[_maxProps]
float[]	 _propMax	= new float[_maxProps]

int property LTT_PROP_NONE	= 0x00 AutoReadonly
int property LTT_PROP_TOGGLE	= 0x01 AutoReadonly
int property LTT_PROP_INT	= 0x02 AutoReadonly
int property LTT_PROP_FLOAT	= 0x04 AutoReadonly
int property LTT_PROP_TEXT	= 0x08 AutoReadonly

;;;;;;;;;;;;;;;;;;;;
; Mod tables
int	 _maxMods	= 32
int	 _modCount	= 0
string[] _modName	= new string[_maxMods]	; Common name, printed in MCM
string[] _modESP	= new string[_maxMods]	; filename of ESP to use on GetFormFromFile()
int[]	 _modPrefix	= new string[_maxMods]	; 0xFF prefix for this mod, -1 if the we can't find the mod
bool[]	 _modLoaded	= new bool[_maxMods]	; Whether LTT has loaded all the items
bool[]	 _modEnabled	= new bool[_maxMods]	; Whether the mod's activities take time
int[]	 _modEvents	= new int[_maxMods]	; Which events is the mod registered for

;;;;;;;;;;;;;;;;;;;;
; Time Passing tracker tables based on in-game stats, not saved to FISS
int	 _maxStats	= 32
int	 _statCount	= 0
string[] _statName	= new string[_maxTimePassers]
int[]	 _statStart	= new int[_maxTimePassers]

;;;;;;;;;;;;;;;;;;;;
; Some "crafting" is actually splitting, when that happens we need to know that
; adding the two items split back into inventory was not in fact another 'build'
; let's put these pairs (should it be an abitrary #, and how would that be
; implemented anyways, does papyrus support n-dimensional arrays?) into a table
int	 _maxSplitters	= 16
int	 _splitterCount	= 0
string[] _splitterName	= new string[_maxSplitters]
bool[]	 _splitter1	= new bool[_maxSplitters]
bool[]	 _splitter2	= new bool[_maxSplitters]

;;;;;;;;;;;;;;;;;;;;
; State trackers, should really use native Papyrus states, maybe in a future release.
int	 _maxStates	= 16
int	 _stateCount	= 0
string[] _stateName	= new string[_maxStates]
string[] _stateValue	= new string[_maxStates]

;;;;;;;;;;;;;;;;;;;;
; Stations used for crafting ( smithing, tanning, smelting, etc )
; Skyrim calls it a piece of furniture, I call it a station.
; This is a slightly different table than the rest because all we need to do
; is let LTT know to check for it's keyword.
int	 _maxStations	 = 32
int	 _stationCount	 = 0
string[] _stationKeyword = new string[_maxStates]
string[] _stationName	 = new string[_maxStates]
string	 _statinNone	 = "other"

;;;;;;;;;;;;;;;;;;;;
; Menus are like stations, let mod register a menu to be checked against
int	 _maxMenus	= 32
int	 _menuCount	= 0
string[] _menuName	= new string[_maxMenus]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Time-passed markers
float	_startTime	= 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Misc trackers
bool	_critSection	= False  ;; mlheur - I still don't know why dragonsong put this in here.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Public Interfaces

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; General LTT functions used all over the place

;;;;;;;;;;;;;;;;;;;;
; Converts minutes to hours
float function LTT_MinsToHrs( float Mins ) global
	return Mins * 0.05 * 0.3334
EndFunction

int function LTT_getFormPrefix( form f ) global
	if f == none
		return -1
	endif
	return Math.RightShift(akForm.GetFormID(), 24)
endfunction

;;;;;;;;;;;;;;;;;;;;
; returns hour at start
float function LTT_startTimer() global
	_startTime = Utility.GetCurrentRealTime()
	return _startTime
endfunction

;;;;;;;;;;;;;;;;;;;;
; returns hour that have passed
float function LTT_endTimer() global
	float End = Utility.GetCurrentRealTime()
	float Diff = End - _startTime
	_startTime = End
	return Diff
endfunction

;;;;;;;;;;;;;;;;;;;;
; returns the starting value for the stat, -1 on error
int function LTT_startStat( int ID ) global
	if ID < 0
		return -1
	endif
	_statStart[i] = Game.QueryStat( Stat )
endfunction

;;;;;;;;;;;;;;;;;;;;
; returns the difference between the start and end values, -1 on error
; The -1 on error doesn't work if you want to track stats that can decrease
; such as current bounties, those will have to be managed by the caller
int function LTT_endStat( int ID ) as global
	if ID < 0
		return -1
	endif
	int End = Game.QueryStat( Stat )
	int Diff = End - _statStart[ID]
	_statStart[ID] = END
	return( Diff )
endfunction

;;;;;;;;;;;;;;;;;;;;
bool function LTT_isPickpocketing() global
	bool Is = false
	Actor LastTarget = Game.GetCurrentCrosshairRef() as Actor
	if (LastTarget && !LastTarget.isDead() && Game.GetPlayer().isSneaking())
		Is = True
	endif
	return Is
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Property adders, getters & setters

;;;;;;;;;;;;;;;;;;;;
; returns the index of the property in the table, -1 on error
int function LTT_addStringProp( string Name, string Default, string Title, string Helper ) global
	; Check if this is already in the table
	int ID = _propIndex( Name )
	; or else generate a new one
	if ID < 0
		ID = _propCount
		_propCoun += 1
	endif
	if ID >= _maxProps
		Log( "Development Error: Ran out of Prop tablespace, update _maxProps in LTT_Common.psc" )
		return -1
	endif
	; Set mod details
	_propName[ID]		= Name
	_propValue[ID]		= Default ; this is not a typo, the initial value is the default value
	_propDefault[ID]	= Default
	_propTitle[ID]		= Title
	_propHelper[ID]		= Helper
	return i
endfunction
;;;;;;;;;;;;;;;;;;;;
int function LTT_addIntProp( string Name, int Default, string Title, string Helper ) global
	return LTT_addStringProp( Name, Default as String, Title, Helper )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function LTT_addFloatProp( string Name, float Default, string Title, string Helper ) global
	return LTT_addStringProp( Name, Default as String, Title, Helper )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function LTT_addBoolProp( string Name, bool Default, string Title, string Helper ) global
	return LTT_addStringProp( Name, Default as String, Title, Helper )
endfunction

;;;;;;;;;;;;;;;;;;;;
bool function LTT_setStringProp( int ID, string Value ) global
	if ID < 0
		return false
	endif
	_propValue[ID] = Value
endfunction
;;;;;;;;;;;;;;;;;;;;
bool function LTT_setIntProp( int ID, int Value ) global
	return LTT_setStringProp( ID, Value as string )
endfunction
;;;;;;;;;;;;;;;;;;;;
bool function LTT_setFloatProp( int ID, string Value ) global
	return LTT_setStringProp( ID, Value as string )
endfunction
;;;;;;;;;;;;;;;;;;;;
bool function LTT_setBoolProp( int ID, string Value ) global
	return LTT_setStringProp( ID, Value as string )
endfunction

;;;;;;;;;;;;;;;;;;;;
string function LTT_getStringProp( int PropID ) global
	if PropID < 0
		return "ERROR"
	endif
	return _propValue[PropID]
endfunction
;;;;;;;;;;
int function LTT_getIntProp( int ID ) global
	return( LTT_getStringProp( ID ) as int )
endfunction
;;;;;;;;;;
float function LTT_getFloatProp( int ID ) global
	return( LTT_getStringProp( ID ) as float )
endfunction
;;;;;;;;;;
bool function LTT_getBoolProp( int ID ) global
	return( LTT_getStringProp( ID ) as bool )
endfunction

;;;;;;;;;;;;;;;;;;;;
; returns whether or not the property was actually set
; if it returns false, probably the property wasn't found in the table (is the table full?)
bool function LTT_setProp( int PropID, string Value ) global
	if _setProp( PropID, Value ) == -1
		return false
	endif
	return true
endfunction

;;;;;;;;;;;;;;;;;;;;
string function LTT_verString() global
	string version = ""
	version += LTT_verMajor+"."+LTT_verMinor
	if _verbose
		version += "-alpha"
	elseif _debug
		version += "-beta"
	endif
	return version
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mod adders, getters & setters

;;;;;;;;;;;;;;;;;;;;
int function LTT_addMod( string Name, string ESP, int TestForm, int Events ) global
	; Check if this is already in the table
	int ID = _modIndex( Name )
	; or else generate a new one
	if ID < 0
		ID = _modCount
		_modCoun += 1
	endif
	if ID >= _maxMods
		Log( "Development Error: Ran out of mod tablespace, update _maxMods in LTT_Common.psc" )
		return -1
	endif
	; Set mod details
	_modName[ID]	= Name
	_modESP[ID]	= ESP
	_modPrefix[ID]	= _getFormPrefix( Game.GetFormFromFile( TestForm, ESP ) )
	_modLoaded[ID]	= false
	_modEnabled[ID]	= false
	_modEvents[ID]	= Events
	return ID
endfunction

;;;;;;;;;;;;;;;;;;;;
bool function LTT_setModActive( int ID, bool Value = true ) global
	if ID < 0
		return false
	endif
	_modActive[ID] = Value
	if SetValue != Value
		return false
	endif
	return true
endfunction
;;;;;;;;;;;;;;;;;;;;
bool function LTT_getModActive( int ID ) global
	if ID < 0
		return false
	endif
	return _modActive[ID]
endfunction

;;;;;;;;;;;;;;;;;;;;
int function LTT_getModPrefix( int ID ) global
	if ID < 0
		return -1
	endif
	return _modPrefix[ID]
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Tracking how much a stat changed during an action (e.g. Training)

;;;;;;;;;;;;;;;;;;;;
int function LTT_addStat( string Stat ) global
	int TPID = _tpIndex( Stat )
	if TPID > -1 ; update existing TP
		_setTP( TPID, 0 )
		return i
	elseif _tpCount >= _maxTP
		Log( "Development Error: Ran out of Time Passer tablespace, update _maxTP in LTT_Common.psc" )
		return -1
	endif
	i = ( _tpCount += 1 ) - 1
	_tpName[i] = Stat
	_setTP( TPID, 0 )
	return TPID
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Splitters
;;;;;;;;;;;;;;;;;;;;
; returns the index of the splitter in the table, -1 on error
int function LTT_addSplitter( string Splitter ) global
	int i = _splittertIndex( Splitter )
	if i > -1 ; update existing splitter
		_splitter1[i] = false
		_splitter2[i] = false
		return i
	elseif _splitterCount >= _maxSplitters
		Log( "Development Error: Ran out of Splitter tablespace, update _maxSplitters in LTT_Common.psc" )
		return -1
	endif
	i = ( _splitterCount += 1 ) - 1
	_splitterName[i] = Splitter
	_splitter1[i] = false
	_splitter2[i] = false
	return i
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns whether or not the splitter exists
bool function LTT_beginSplit( string Splitter, bool NeedA = true, bool NeedB = true ) global
	int i = _splitertIndex( Splitter )
	if i < 0
		return false
	endif
	if NeedA
		_splitter1[i] = true
	endif
	if NeedB
		_splitter2[i] = true
	endif
	return true
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns whether or not the splitter exists
bool function LTT_endSplit( stirng Splitter, int Item ) global
	int i = _splitertIndex( Splitter )
	if i < 0
		return false
	endif
	if Item == 1
		_splitter1[i] = false
	elsif Item == 2
		_splitter2[i] = false
	else
		return false
	endif
	return true
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns whether or not item split has been handled
bool function LTT_isSplit( string Splitter, int Item ) global
	int i = _splitertIndex( Splitter )
	if i < 0
		return false
	endif
	if Item == 1
		return _splitter1[i]
	elsif Item == 2
		return _splitter2[i]
	else
		return false
	endif
	return false
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; State trackers (is looting, is crafting, craft station, etc)
;;;;;;;;;;;;;;;;;;;;
; returns the index of the state in the table, -1 on error
int function LTT_addState( string State, string Value = "$E_STATE_NOT_INIT" ) global
	int i = _stateIndex( State )
	if i > -1 ; update existing state
		_stateValue[i] = Value
		return i
	elseif _stateCount >= _maxStates
		Log( "Development Error: Ran out of State tablespace, update _maxStates in LTT_Common.psc" )
		return -1
	endif
	i = ( _stateCount += 1 ) - 1
	_stateName[i] = State
	_stateValue = Value
	return i
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns whether or not the state was set properly
bool function LTT_setState( strint State, string Value ) global
	int i = _stateIndex( State )
	if i < 0
		return false
	endif
	_stateValue[i] = Value
	return true
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns state value, "$ERROR" on error
string function LTT_getState( strint State ) global
	int i = _stateIndex( State )
	if i < 0
		return "$ERROR"
	endif
	return _stateValue[i]
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Crafting Stations

;;;;;;;;;;;;;;;;;;;;
; returns the index of the station in the table, -1 on error
int function LTT_addStation( string Keyword, string Name ) global
	int ID = _stationIndex( Keyword )
	if ID > -1 ; update existing
		_stationName[ID] = Name
		return ID
	elseif _stationCount >= _maxStations
		Log( "Development Error: Ran out of Crafting Station tablespace, update _maxStationss in LTT_Common.psc" )
		return -1
	endif
	ID = ( _stationCount += 1 ) - 1
	_stationKeyword[ID] = Keyword
	_stationName[ID] = Name
	return ID
endfunction
;;;;;;;;;;;;;;;;;;;;
; allow a mod to remove its station from the table for a period of time (like unregister event)
function LTT_delStation( int ID ) global
	if ID < 0
		return
	endif
	_stationName[ID] = _stationNone
endfunction
int functino LTT_delStation( int ID )
;;;;;;;;;;;;;;;;;;;;
; returns the ESP keyword of the station in the table, "other" if not found
string function LTT_getStation( int ID ) global
	if ID < 0
		return _stationNone
	endif
	return _stationKeyword[ID]
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns the mod's common name of the station in the table, "other" if not found
string function LTT_getStationName( int ID ) global
	if ID < 0
		return _stationNone
	endif
	return _stationName[ID]
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns the ID of the last station
int function LTT_getLastStation() global
	return _stationCount - 1
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Game Menus
int function LTT_addMenu( string Name ) global
	int ID = _stationIndex( Name )
	if ID > -1 ; update existing
		return ID
	elseif _stationCount >= _maxStations
		Log( "Development Error: Ran out of Crafting Station tablespace, update _maxStationss in LTT_Common.psc" )
		return -1
	endif
	ID = ( _menuCount += 1 ) - 1
	_menuName[ID] = Name
	return ID
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns the menu name, used to iterate when you don't know what menu is needed
string function LTT_getMenu( int ID ) global
	if ID < 0
		return ""
	endif
	return _menuName[ID]
endfunction
;;;;;;;;;;;;;;;;;;;;
; returns the ID of the last menu
int function LTT_getLastMenu() global
	return _menuCount - 1
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Debugging & Logging
;;;;;;;;;;;;;;;;;;;;
function LTT_log( string sMsg ) as global
	Debug.Trace( "[LTT] :: "+sMsg )
endfunction
;;;;;;;;;;;;;;;;;;;;
function LTT_debugLog(string sMsg) as global
	bool LoggedToFile = false
	if LTT_getBoolProp( "LTT_UserDebug" )
		LoggedToFile = true
		LTT_log( sMsg )
	else
	if LTT_verbose
		Debug.Notification( "[LTT] "+sMsg )
	endif
	if LTT_debug && !LoggedToFile
		LTT_log( sMsg )
	endif
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Private Functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Find indexes into tables based on names - these are private because they
; are not good performers and their use should be limited.
int function _index( string Name, string Table, int Count, int Max )
	int i = 0
	while ( i <= Count && i <= Max )
		if  Table[i] == Name
			return i
		endif
		i+=1
	endwhile
	return -1
endfunction
;;;;;;;;;;;;;;;;;;;;
int function _propIndex( string Name )
	return _index( Name, _propName, _propCount, _maxProps )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function _modIndex( string Name )
	return _index( Name, _modName, _modCount, _maxMods )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function _statIndex( string Stat )
	return _index( Name, _statName, _statCount, _maxStats )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function _splitterIndex( string Name )
	return _index( Name, _splitterpName, _splitterCount, _maxSplitters )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function _stateIndex( string Name )
	return _index( Name, _stateName, _stateCount, _maxStates )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function _stationIndex( string Name )
	return _index( Name, _stationName, _stationCount, _maxStations )
endfunction
;;;;;;;;;;;;;;;;;;;;
int function _menuIndex( string Name )
	return _index( Name, _menuName, _menuCount, _maxMenus )
endfunction
