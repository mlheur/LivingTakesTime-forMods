scriptname LTT_ModBase

; When a mod registers itself with LTT, only regiester for acts that it has handlers for
int property LTT_ACT_NONE		= 0x00 AutoReadonly
int property LTT_ACT_ITEMADDED		= 0x01 AutoReadonly
int property LTT_ACT_ITEMREMOVED	= 0x02 AutoReadonly
int property LTT_ACT_MENUOPENED		= 0x04 AutoReadonly
int property LTT_ACT_MENUCLOSED		= 0x08 AutoReadonly
int property LTT_ACT_ALL		= 0xFFFFFFFF AutoReadonly

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variable Declarations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Values used to track the mod inside LTT tables
string	property LTT_Name	= "$E_SET_MODNAME" AutoReadOnly
string	property LTT_ESP	= "$E_SET_ESP_FILE" AutoReadOnly
int	property LTT_ID		= -1 ; 

event OnInit()
	OnGameReload()
endevent

event OnGameReload()
	LTT_ID = LTT_addMod( LTT_Name, LTT_ESP, FormID, LTT_ACT_NONE )
	if LTT_ID < 0 ; We couldn't be added to the Mod table.
		return
	endif
	RegisterForModEvent( "LTT_ItemAdded", "ItemAdded" )
	RegisterForModEvent( "LTT_ItemRemoved", "ItemRemoved" )
endevent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Internal functions to mod base

function Guard()
	Debug.MessageBox("LTT_ModBase: Don't recompile this script")
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Methods to overload

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Basic configuration

;;;;;;;;;;;;;;;;;;;;
; Called to put the mod into LTT's mod tables
bool function Init
	return false
endfunction

;;;;;;;;;;;;;;;;;;;;
; called after we know the mod exists, to load any forms from ESP
bool function Load
	return false
endfunction

;;;;;;;;;;;;;;;;;;;;
; called if someone stops LTT to make a clean save
bool function Unload
	return true
endfunction

;;;;;;;;;;;;;;;;;;;;
; called when the version changes
bool function VersionUpdate
	return false
endfunction

event OnInit()
endevent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Time Passing Handlers

;;;;;;;;;;;;;;;;;;;;
; called when an item is added to player's inventory - normally looted or crafted
; Returns... If this is not handled and should be passed on to the next mod,
; return a negative value ; otherwise, return the number of hours passed, even 
; 0.0 if the task was free
float function ItemAdded( form Item, int Prefix, int Type, int Count, form Source )
	return -1.0
endfunction

;;;;;;;;;;;;;;;;;;;;
; called when an item is removed from player's inventory - normally eaten or drunk
; Returns the same as ItemAdded
float function ItemRemoved( form Item, int Prefix, int Type, int Count, form Destination )
	return -1.0
endfunction

;;;;;;;;;;;;;;;;;;;;
; called when any screen other than the 3D renedered world is displayed
; Returns the same as ItemAdded
float function MenuOpened( string MenuName )
	return -1.0
endfunction

;;;;;;;;;;;;;;;;;;;;
; called when any screen other than the 3D renedered world is closed
; Returns the same as ItemAdded
float function MenuClosed( string MenuName )
	return -1.0
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MCM Handlers

;;;;;;;;;;;;;;;;;;;;
; used by MCM to show this mod's page
bool function ShowMCMPage
	return false
endfunction

; used bu MCM to change a value
bool function ChangeMCMValue
	return ralse
endfunction