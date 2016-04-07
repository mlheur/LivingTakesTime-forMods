scriptname LTT_Hearthfire extends LTT_ModBase 

int	fID_HouseWorkbench	= 0x000030DF

Form[]	HF_Exclusions

event OnInit()
	ESP = "Hearthfire.esm"
	TestForm = fID_HouseWorkbench
	parent.OnInit()
endevent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase()
	DebugLog( "++OnGameReload()" )
	
	isLoaded = false
	RegisterActs = LTT.LDH.act_ITEMADDED
	RegisterMenus = LTT.LDH.menu_None
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()" )
		return
	endif
	
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success" )
endevent

bool function Load()
	HF_Exclusions = new Form[26]
	HF_Exclusions[0]	= Game.GetFormFromFile(0x000030DF, ESP);House - Workbench
	HF_Exclusions[1]	= Game.GetFormFromFile(0x00003121, ESP);House - Remove Workbench
	HF_Exclusions[2]	= Game.GetFormFromFile(0x000030E7, ESP);Main Hall - Workbenches
	HF_Exclusions[3]	= Game.GetFormFromFile(0x00003122, ESP);Main Hall - Remove Workbenches
	HF_Exclusions[4]	= Game.GetFormFromFile(0x0000312B, ESP);Entryway - Workbench
	HF_Exclusions[5]	= Game.GetFormFromFile(0x0000312C, ESP);Entryway - Remove Workbench
	HF_Exclusions[6]	= Game.GetFormFromFile(0x00003ADA, ESP);Bedrooms - Workbench
	HF_Exclusions[7]	= Game.GetFormFromFile(0x00003ADB, ESP);Bedrooms - Remove Workbench
	HF_Exclusions[8]	= Game.GetFormFromFile(0x00003ADC, ESP);Greenhouse - Workbench
	HF_Exclusions[9]	= Game.GetFormFromFile(0x00003ADD, ESP);Greenhouse - Remove Workbench
	HF_Exclusions[10]	= Game.GetFormFromFile(0x00003ADE, ESP);Enchanter's Tower - Workbench
	HF_Exclusions[11]	= Game.GetFormFromFile(0x00003ADF, ESP);Enchanter's Tower - Remove Workbench
	HF_Exclusions[12]	= Game.GetFormFromFile(0x00003AE0, ESP);Storage Room - Workbench
	HF_Exclusions[13]	= Game.GetFormFromFile(0x00003AE1, ESP);Storage Room - Remove Workbench
	HF_Exclusions[14]	= Game.GetFormFromFile(0x00003AE2, ESP);Trophy Room - Workbench
	HF_Exclusions[15]	= Game.GetFormFromFile(0x00003AE3, ESP);Trophy Room - Remove Workbench
	HF_Exclusions[16]	= Game.GetFormFromFile(0x00003AE4, ESP);Alchemy Laboratory - Workbench
	HF_Exclusions[17]	= Game.GetFormFromFile(0x00003AE5, ESP);Alchemy Laboratory - Remove Workbench
	HF_Exclusions[18]	= Game.GetFormFromFile(0x00003AE6, ESP);Armory - Workbench
	HF_Exclusions[19]	= Game.GetFormFromFile(0x00003AE7, ESP);Armory - Remove Workbench
	HF_Exclusions[20]	= Game.GetFormFromFile(0x00003AE8, ESP);Kitchen - Workbench
	HF_Exclusions[21]	= Game.GetFormFromFile(0x00003AE9, ESP);Kitchen - Remove Workbench
	HF_Exclusions[22]	= Game.GetFormFromFile(0x00003AEA, ESP);Library - Workbench
	HF_Exclusions[23]	= Game.GetFormFromFile(0x00003AEB, ESP);Library - Remove Workbench
	HF_Exclusions[24]	= Game.GetFormFromFile(0x00003AEC, ESP);Cellar - Workbench
	HF_Exclusions[25]	= Game.GetFormFromFile(0x00003AED, ESP);Cellar - Remove Workbench
	int i = 25
	while i >= 0
		if !HF_Exclusions[i]
			return false
		endif
		i-=1
	endwhile
	return true
endfunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()" )
	float t = -1.0
	if HF_Exclusions.find( BaseItem )
		t = 0.0
	endif
	DebugLog( "--ItemAdded() t="+t )
	return t
endfunction
