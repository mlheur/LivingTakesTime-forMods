scriptname LTT_FF3 extends LTT_ModBase 

import LTT_Factory

int	fID_Snowberry		= 0x01D430 ; _Frost_WaterPotion "Snowberry Extract" [ALCH:0301D430]
int	fID_DummyItem		= 0x06B1D8 ; _Frost_DummyItem [MISC:0306B1D8]
int	prop_SnowberryMins	= -1
form	kSnowberryExtract
form 	kDummyItem

event OnGameRelaod()
	LTT = LTT_getBase() ; from LTT_Factory
	LTT_modName = "Frostfall 3+"
	ESP = "Frostfall.esp"
	TestForm = fID_DummyItem
	RegisterActs = LTT.LDH.act_ITEMADDED
	RegisterMenus = LTT.LDH.menu_None

	modID = LTT.LDH.addMod( self, LTT_modName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		return
	endif

	kSnowberryExtract = Game.GetFormFromFile( fID_Snowberry, ESP )
	kDummyItem = Game.GetFormFromFile( fID_DummyItem, ESP )
	prop_SnowberryMins = LTT.LDH.addIntProp( modID, "FF3_SnoberryMins", 15, "$FF3_SnowberryMins", "$HLP_FF3_SnowberryMins", 0, 0, LTT.LDH.maxMins, "minutes" )
endevent

float function ItemAdded( form Item, int Count, form ItemRef, form Container, int Type, int Prefix )
	if Prefix != LTT.LDH.getModPrefix( modID )
		return -1.0
	endif
	Float t = 0.0
	If Item == kSnowberryExtract
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_SnowberryMins ) )
		LTT.DebugLog("[FF3] Snowberry Extract. Base time = " + t)
		return t

	EndIf
	; Frostfall "gives" objects when its changing exposure status, handle & ignore those.
	if Type == LTT.LDH.kMisc && Item == kDummyItem ; Chesko made it too heavy to be ignored :)
		return 0.0
	endif
	return -1.0
EndFunction