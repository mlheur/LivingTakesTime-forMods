scriptname LTT_ModBase extends Quest
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	Base class to extend for mods using LivingTakesTime for Mods
///////////////////////////////////////////////////////////////////////////////;

import LTT_Factory

;///////////////////////////////////////////////////////////////////////////////
// Mandatory variables to be set by the mod
/;
LTT_Base Property LTT Auto
int	property modID		= -1 Auto ; self's Mod index in lookup table
string	property LTT_modName	= "$E_SET_MODNAME" Auto
string	property ESP		= "$E_SET_ESP_FILE" Auto
int	property TestForm	= 0xf Auto
int	property RegisterActs	= 0 Auto
int	property RegisterMenus	= 0 Auto

;///////////////////////////////////////////////////////////////////////////////
// Event Handlers
//	Defaults are provided and are not required to be overridden, but
//	OnGameReload should be otherwise notifications won't be sent for any
//	acts.
/;

;;;;event OnInit()
;;;;	OnGameReload()
;;;;endevent

event OnGameReload()
;	LTT = LTT_getBase() ; from LTT_Factory
;	modID = LTT.LDH.addMod( self, LTT_modName, ESP, TestForm, RegisterActs, RegisterMenus )
;	if modID < 0 ; We couldn't be added to the Mod table.
;		return
;	endif
endevent

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
	;
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
	Debug.MessageBox("LTT_ModBase: Don't recompile this script")
endfunction