scriptname LTT_ModBase extends Quest
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	Base class to extend for mods using LivingTakesTime for Mods
///////////////////////////////////////////////////////////////////////////////;

LTT_Base property LTT Auto
string property ModName Auto

;///////////////////////////////////////////////////////////////////////////////
// Mandatory variables to be set by the mod
/;
int	property modID		= -1 Auto ; self's Mod index in lookup table
string	property ESP		= "$E_SET_ESP_FILE" Auto
int	property TestForm	= -1 Auto
int	property RegisterActs	= 0 Auto
int	property RegisterMenus	= 0 Auto

bool	property isInit		= false Auto
int		 prop_Enabled	= -1

float	LoadWaitTime			= 0.25
int	LoadTries			= 100
float	LockWaitTime			= 0.01
int	_spinlockTries			= 1000

bool property isLoaded
	bool function get()
		DebugLog( "++isLoaded::get()" )
		if !isInit || !LTT
			DebugLog( "--isLoaded::get() = false; !isInit or !LTT" )
			return false
		elseif LTT.LDH.getModPrefix( modID ) >= 0
			DebugLog( "--isLoaded::get() = true" )
			return true
		endif
		DebugLog( "--isLoaded::get() = false; catchall" )
		return false
	endfunction
	function set( bool V )
		if !V
			LTT.LDH.setModPrefix( modID, -1 )
		endif
	endfunction
endproperty

;///////////////////////////////////////////////////////////////////////////////
// Event Handlers
//	Defaults are provided and are not required to be overridden, but
//	OnGameReload should be otherwise notifications won't be sent for any
//	acts.
/;

;;;bool _spinlockOnInit = false
event OnInit()
	; Wait her just in case LTT's OnGameReload is called, because
	; these OnInits always run first and we really want LTT to be ready first
	Utility.Wait( 1.0 )
	LTT = LTT_Factory.LTT_getBase()
	IsInit = false
	DebugLog( "++OnInit()" )
	; Wait until LTT has finished its Init
	int tries=0
	while !LTT.isInit
		Utility.WaitMenuMode( LoadWaitTime )
		tries += 1
		if tries > LoadTries
			DebugLog( "--OnInit(); failed too many tries" )
			LTT = none
			return
		endif
	endwhile
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	DebugLog( "Registering for OnUpdate" )
	LTT.RegisterForSingleUpdate( 0.5 )
	DebugLog( "Registered... for OnUpdate" )
	DebugLog( "--OnInit(); success" )
endevent

function ReInit()
	DebugLog( "++ReInit()" )
	LTT = LTT_Factory.LTT_getBase()
	IsInit = false
	if !testESP()
		DebugLog( "--ReInit(); ESP load failed" )
		return
	endif
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	prop_Enabled = LTT.LDH.addBoolProp( modID, ModName+"_Enabled", false, "$LTT_ModEnabled", "$HLP_ModEnabled", 0 )
	DebugLog( "--ReInit(); success" )
	IsInit = true
endfunction

bool function isRunnable()
	LTT.DebugLog( self+"isRunnable()" \
	  +": isInit="+isInit \
	  +"; isLoaded="+isLoaded \
	  +"; enabled="+LTT.LDH.getBoolProp( prop_Enabled ) \
	  +"; prefix="+LTT.LDH.getModPrefix( modID ) \
	)
	return( isInit && isLoaded && LTT.LDH.getBoolProp( prop_Enabled ) )
endfunction

bool function testESP()
	DebugLog( "++testESP()" )
	; Check if the mod's ESP exists
	LTT.Log( ">>>>>>>>>>>>>>> Checking "+self+" MOD Compatibility <<<<<<<<<<<<<<<" )
	LTT.Log( ">>>>>>>>>>>>>>> Ignore any errors about files not existing <<<<<<<<<<<<<<<" )
	DebugLog( "Testing for ESP: TestForm="+TestForm+"; ESP="+ESP )
	if TestForm < 0
		DebugLog( "--testESP(); TestForm not provided" )
		LTT.Log( ">>>>>>>>>>>>>>> Finished Checking MOD Compatibility <<<<<<<<<<<<<<<" )
		return false
	else
		if !Game.GetFormFromFile( TestForm, ESP )
			DebugLog( "--testESP(); ESP not loaded" )
			LTT.Log( ">>>>>>>>>>>>>>> Finished Checking MOD Compatibility <<<<<<<<<<<<<<<" )
			return false
		endif
	endif
	LTT.Log( ">>>>>>>>>>>>>>> Finished Checking MOD Compatibility <<<<<<<<<<<<<<<" )
	DebugLog( "--testESP(); success" )
	return true
endfunction

event OnGameReload()
	Guard() ; must be overridden by child.
endevent

event OnKeyUp( int KeyID, float Duration )
endevent

function handlePropToggle( int PropID, bool NewValue )
	; The prop table has already been updated, but if the prop belongs
	; to something that enables/disables menu events, then register/unregister
	; on the menu table.  This is needed because addBoolProp doesn't know
	; if the prop relates to a menu or something else.
	
;;;	; If overridden, call parent.handlePropToggle() or reimplement this functionality
;;;	if PropID == prop_Enabled
;;;		LTT.LDH.setBoolProp( prop_Enabled, NewValue )
;;;	endif
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Methods that must be overridden for any functionality to be provided
/;

;///////////////////////////////////////////////////////////////////////////////
// Called after we know the mod exists, to load any forms from ESP
// Returns whether or not the load completed.  If false then no further events
// will be sent to the mod's handlers.
/;
bool function Load()
	IsLoaded = false
	return false
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Called when stopping LTT to make a clean save.
/;
function Unload()
	isLoaded = false
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Time Passing Event Handlers
// Not using the On* nomenclature so that it won't interfere with the game's
// built in event notificaiton system
/;

;///////////////////////////////////////////////////////////////////////////////
// called when an item is added to player's inventory - normally looted or
// crafted. Returns... If this is not handled and should be passed on to the
// next mod, return a negative value ; otherwise, return the number of hours
// passed, even 0.0 if the task was free.
/;
float function ItemAdded( form Item, int Count, form ItemRef, form Container, int Type, int Prefix )
	return -1.0
endfunction

;///////////////////////////////////////////////////////////////////////////////
// called when an item is removed from player's inventory - normally eaten or drunk
// Returns the same as ItemAdded
/;
float function ItemRemoved( form Item, int Count, form ItemRef, form Container, int Type, int Prefix )
	return -1.0
endfunction

;///////////////////////////////////////////////////////////////////////////////
// called when any screen other than the 3D renedered world is displayed
// Returns the same as ItemAdded
/;
float function MenuOpened( int Menu )
	return -1.0
endfunction

;///////////////////////////////////////////////////////////////////////////////
// called when any screen other than the 3D renedered world is closed
// Returns the same as ItemAdded
/;
float function MenuClosed( int Menu )
	return -1.0
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Internal functions
/;
function Guard()
	Debug.MessageBox(self+" this function must be overridden by Mod's LTT handlers")
endfunction

function DebugLog( string Msg, bool verbose = false )
	LTT.DebugLog( self+" :: "+Msg, verbose )
endfunction