scriptname LTT_FF3 extends LTT_ModBase 

string	property LTT_Name	= "Frostfall 3+" AutoReadOnly
string	property LTT_ESP	= "Frostfall.esp" AutoReadonly
int	fID_Snowberry		= 0x01D430

float	SnowberryMins		= 15.0
Form	kSnowberryExtract

event OnGameRelaod()
	LTT_ID = LTT_addMod( LTT_Name, LTT_ESP, fID_Snowberry, LTT_ACT_ITEMADDED )
	if LTT_ID < 0 ; We couldn't be added to the Mod table.
		return
	endif
	kSnowberryExtract = Game.GetFormFromFile( fID_Snowberry, ESP )
endevent

float function ItemAdded( form Item, int Prefix, int Type, int Count, form Source )
	if prefix != LTT_getModPrefix( LTT_ID )
		return -1.0
	endif
	Float t = 0.0
	If akBaseItem == FF_SnowberryExtract
		t = LTT_MinsToHrs( FF3_SnowberryMins )
		DebugMode("Snowberry Extract. Base time = " + t)
		return t

	EndIf
	; Frostfall "gives" objects when its changing exposure status, handle & ignore those.
	if aiType == 32 && akBaseItem == FF_Dummy ; Chesko made it too heavy to be ignored :)
		return 0.0
	endif
	return -1.0
EndFunction