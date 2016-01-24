scriptname LTT_ModBase extends Quest
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	Base class to extend for mods using LivingTakesTime for Mods
///////////////////////////////////////////////////////////////////////////////;

import LTT_Factory
LTT_Base property LTT Auto
string property ModName Auto

;///////////////////////////////////////////////////////////////////////////////
// Mandatory variables to be set by the mod
/;
int	property modID		= -1 Auto ; self's Mod index in lookup table
string	property ESP		= "$E_SET_ESP_FILE" Auto
int	property TestForm	= 0xf Auto
int	property RegisterActs	= 0 Auto
int	property RegisterMenus	= 0 Auto

bool	property isLoaded	= false Auto
bool	property isInit		= false Auto
int		 prop_Enabled	= -1

;///////////////////////////////////////////////////////////////////////////////
// Event Handlers
//	Defaults are provided and are not required to be overridden, but
//	OnGameReload should be otherwise notifications won't be sent for any
//	acts.
/;

event OnInit()
	LTT = LTT_getBase()
	DebugLog( "++OnInit()" )
	; Wait until LTT has finished its Init
	int tries=0
	while !LTT.isInit
		Utility.WaitMenuMode( LTT.LDH.LoadWaitTime )
		tries += 1
		if tries > 100
			LTT = none
			DebugLog( self+"--OnInit(); failed too many tries" )
			return
		endif
	endwhile
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnInit(); unable to successfully addMod()" )
		return
	endif
	prop_Enabled = LTT.LDH.addBoolProp( modID, ModName+"_Enabled", false, "$LTT_ModEnabled", "$HLP_ModEnabled", 0 )
	isInit = true
	isLoaded = false
	LTT.RegisterForSingleUpdate( 0.0 )
	DebugLog( "--OnInit(); success" )
endevent

bool function isRunnable()
	LTT.DebugLog( self+"isRunnable()" \
	  +": isInit="+isInit \
	  +"; isLoaded="+isLoaded \
	  +"; enabled="+LTT.LDH.getBoolProp( prop_Enabled ) \
	  +"; prefix="+LTT.LDH.getModPrefix( modID ) \
	)
	return( isInit && isLoaded && LTT.LDH.getBoolProp( prop_Enabled ) && LTT.LDH.getModPrefix( modID ) >= 0 )
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