scriptname LTT_<modname> extends LTT_ModBase
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Template to show how to build handlers to add new mods to LTT
;
; LTT.psc will have to be updated in a few places so that it knows this mod
; exists.
; - mID_modname
; - OnInit and/or OnVersionUpdate
; - ItemAdded
; - ItemRemoved
; - <MCM Pages>
;
; Nothing in here should be global because variable and function names WILL be
; re-used. This means that inside LTT.psc you'll have to use the fully-qualified
; version (e.g. LTT_template.Name)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

import LTT_Common

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variable Declarations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; These values must be overridden from LTT_ModBase
string	property Name	= "<human mod name>" AutoReadOnly
string	property ESP	= "esp filename" AutoReadonly
int	property FormID	= 0x0123xyz AutoReadonly ; Some item from the ESP we can use to test its existence
bool	bLoaded		= false
int	mID		= -1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Confiugartion Items
; List any properties you want to have configured in MCM, initialised with
; default values.
float ActionHours = 1.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mod local variables - add your own

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Overloaded functions from LTT_ModBase

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Load any forms and init any variables needed when the mod is first added to
; LTT unless true is returned, the mod will be considered not usable and none of
; the handlers will be called
bool function Load()
	bLoaded = true
	return bLoaded
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Free up anything required if the player tries to uninstall LTT
bool function Unload()
	bLoaded = false
	return true
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Called when an item is added to the player
; Returns... If this is not handled and should be passed on to the next mod,
; return a negative value ; otherwise, return the number of hours passed, even 
; 0.0 if the task was free
float function ItemAdded( form Item, int Prefix, int Type, int Count, form Source )
	return -1.0
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Called when an item is removed the player
; Returns the same as ItemAdded
float function ItemRemoved( form Item, int Prefix, int Type, int Count, form Destination )
	return -1.0
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Called by LTT's MCM handler
bool function ShowPage()
	return false
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Private interfaces - add your own internal functions here.
