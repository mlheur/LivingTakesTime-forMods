scriptname LTT_Campfire extends LTT_ModBase 

string	LTT_Name		= "Hearthfire" AutoReadOnly
string	LTT_ESP			= "Hearthfire.esm" AutoReadonly
int	fID_HouseWorkbench	= 0x000030DF

Form[]	HF_Exclusions

Function Init_HF_Exclusions()
	HF_Exclusions = new Form[26]
	HF_Exclusions[0]	= Game.GetFormFromFile(0x000030DF, "HearthFires.esm");House - Workbench
	HF_Exclusions[1]	= Game.GetFormFromFile(0x00003121, "HearthFires.esm");House - Remove Workbench
	HF_Exclusions[2]	= Game.GetFormFromFile(0x000030E7, "HearthFires.esm");Main Hall - Workbenches
	HF_Exclusions[3]	= Game.GetFormFromFile(0x00003122, "HearthFires.esm");Main Hall - Remove Workbenches
	HF_Exclusions[4]	= Game.GetFormFromFile(0x0000312B, "HearthFires.esm");Entryway - Workbench
	HF_Exclusions[5]	= Game.GetFormFromFile(0x0000312C, "HearthFires.esm");Entryway - Remove Workbench
	HF_Exclusions[6]	= Game.GetFormFromFile(0x00003ADA, "HearthFires.esm");Bedrooms - Workbench
	HF_Exclusions[7]	= Game.GetFormFromFile(0x00003ADB, "HearthFires.esm");Bedrooms - Remove Workbench
	HF_Exclusions[8]	= Game.GetFormFromFile(0x00003ADC, "HearthFires.esm");Greenhouse - Workbench
	HF_Exclusions[9]	= Game.GetFormFromFile(0x00003ADD, "HearthFires.esm");Greenhouse - Remove Workbench
	HF_Exclusions[10]	= Game.GetFormFromFile(0x00003ADE, "HearthFires.esm");Enchanter's Tower - Workbench
	HF_Exclusions[11]	= Game.GetFormFromFile(0x00003ADF, "HearthFires.esm");Enchanter's Tower - Remove Workbench
	HF_Exclusions[12]	= Game.GetFormFromFile(0x00003AE0, "HearthFires.esm");Storage Room - Workbench
	HF_Exclusions[13]	= Game.GetFormFromFile(0x00003AE1, "HearthFires.esm");Storage Room - Remove Workbench
	HF_Exclusions[14]	= Game.GetFormFromFile(0x00003AE2, "HearthFires.esm");Trophy Room - Workbench
	HF_Exclusions[15]	= Game.GetFormFromFile(0x00003AE3, "HearthFires.esm");Trophy Room - Remove Workbench
	HF_Exclusions[16]	= Game.GetFormFromFile(0x00003AE4, "HearthFires.esm");Alchemy Laboratory - Workbench
	HF_Exclusions[17]	= Game.GetFormFromFile(0x00003AE5, "HearthFires.esm");Alchemy Laboratory - Remove Workbench
	HF_Exclusions[18]	= Game.GetFormFromFile(0x00003AE6, "HearthFires.esm");Armory - Workbench
	HF_Exclusions[19]	= Game.GetFormFromFile(0x00003AE7, "HearthFires.esm");Armory - Remove Workbench
	HF_Exclusions[20]	= Game.GetFormFromFile(0x00003AE8, "HearthFires.esm");Kitchen - Workbench
	HF_Exclusions[21]	= Game.GetFormFromFile(0x00003AE9, "HearthFires.esm");Kitchen - Remove Workbench
	HF_Exclusions[22]	= Game.GetFormFromFile(0x00003AEA, "HearthFires.esm");Library - Workbench
	HF_Exclusions[23]	= Game.GetFormFromFile(0x00003AEB, "HearthFires.esm");Library - Remove Workbench
	HF_Exclusions[24]	= Game.GetFormFromFile(0x00003AEC, "HearthFires.esm");Cellar - Workbench
	HF_Exclusions[25]	= Game.GetFormFromFile(0x00003AED, "HearthFires.esm");Cellar - Remove Workbench
EndFunction
