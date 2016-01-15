Scriptname RTT_Menu extends SKI_ConfigBase

RTT Property ReadingTakesTime Auto  

bool isModActive = false
bool isReadingActive = true
bool isCraftingActive = true
bool isContainerActive = true
bool isLockpickActive = true
bool isTrainingActive = true
bool isLevelUpActive = true
bool isInventoryActive = true
bool isMagicActive = true
bool isJournalActive = true
bool isMapActive = true
bool isBarterActive = true
bool isGiftActive = true

int isModActiveID
int isReadingActiveID
int isCraftingActiveID
int isContainerActiveID
int isLockpickActiveID
int isTrainingActiveID
int isLevelUpActiveID
int isInventoryActiveID
int isMagicActiveID
int isJournalActiveID
int isMapActiveID
int isBarterActiveID
int isGiftActiveID

int showMessageID
int dontShowMessageID
int expertiseReducesTimeID
int cantReadID
int readMultID
int readingIncreasesSpeechID
int readingIncreaseMultID
int spellLearnTimeID
int cantLootID
int lootMultID
int pickpocketMultID
int cantPickID
int pickMultID
int headCraftTimeID
int armorCraftTimeID
int handsCraftTimeID
int feetCraftTimeID
int shieldCraftTimeID
int jewelryCraftTimeID
int battleAxeCraftTimeID
int bowCraftTimeID
int daggerCraftTimeID
int greatswordCraftTimeID
int maceCraftTimeID
int staffCraftTimeID
int swordCraftTimeID
int warhammerCraftTimeID
int warAxeCraftTimeID
int weaponCraftTimeID
int miscCraftTimeID
int armorImproveTimeID
int weaponImproveTimeID
int potionCraftTimeID
int enchantingTimeID
int trainingMultID
int trainingTimeID
int cantLevelUpID
int levelUpMultID
int levelUpTimeID
int inventoryMultID
int cantInventoryID
int eatTimeID
int magicMultID
int cantMagicID
int journalMultID
int cantJournalID
int mapMultID
int cantMapID
int barterMultID 
int giftMultID

int saveID
int loadID

import FISSFactory

Function InitMod()
	if ( isModActive )
		ReadingTakesTime.StartReading = Utility.GetCurrentRealTime()
		ReadingTakesTime.StopReading = Utility.GetCurrentRealTime()
		if ( isReadingActive )
			RegisterForMenu("Book Menu")
		else
			UnregisterForMenu("Book Menu")
		endIf
		if ( isCraftingActive )
			RegisterForMenu("Crafting Menu")
		else
			UnregisterForMenu("Crafting Menu")
		endIf
		if ( isContainerActive )
			RegisterForMenu("ContainerMenu")
			;RegisterForCrosshairRef()
		else
			UnregisterForMenu("ContainerMenu")
			;UnregisterForCrosshairRef()
		endIf
		if ( isLockpickActive )
			RegisterForMenu("Lockpicking Menu")
		else
			UnregisterForMenu("Lockpicking Menu")
		endIf
		if ( isTrainingActive )
			RegisterForMenu("Training Menu")
		else
			UnregisterForMenu("Training Menu")
		endIf
		if ( isLevelUpActive )
			RegisterForMenu("StatsMenu")
		else
			UnregisterForMenu("StatsMenu")
		endIf
		if ( isInventoryActive )
			RegisterForMenu("InventoryMenu")
		else
			UnregisterForMenu("InventoryMenu")
		endIf
		if ( isMagicActive )
			RegisterForMenu("MagicMenu")
		else
			UnregisterForMenu("MagicMenu")
		endIf
		if ( isJournalActive )
			RegisterForMenu("Journal Menu")
			ReadingTakesTime.StartReading = Utility.GetCurrentRealTime()
			ReadingTakesTime.StopReading = Utility.GetCurrentRealTime()
		else
			UnregisterForMenu("Journal Menu")
		endIf
		if ( isMapActive )
			RegisterForMenu("MapMenu")
		else
			UnregisterForMenu("MapMenu")
		endIf
		if ( isBarterActive )
			RegisterForMenu("BarterMenu")
		else
			UnregisterForMenu("BarterMenu")
		endIf
		if ( isGiftActive )
			RegisterForMenu("GiftMenu")
		else
			UnregisterForMenu("GiftMenu")
		endIf
	else
		UnregisterForAllMenus()
		UnregisterForCrosshairRef()
	endIf
	ReadingTakesTime.InitStats(isModActive)
EndFunction

Function SaveSettings()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		debug.MessageBox("$FISS not installed. Saving disabled")
		return
	endif
	fiss.beginSave("LTT\\LTTSettings.xml", "LivingTakesTime")
	
	fiss.saveBool("isModActive", isModActive)
	fiss.saveBool("isReadingActive", isReadingActive)
	fiss.saveBool("isCraftingActive", isCraftingActive)
	fiss.saveBool("isContainerActive", isContainerActive)
	fiss.saveBool("isLockpickActive", isLockpickActive)
	fiss.saveBool("isTrainingActive", isTrainingActive)
	fiss.saveBool("isLevelUpActive", isLevelUpActive)
	fiss.saveBool("isInventoryActive", isInventoryActive)
	fiss.saveBool("isMagicActive", isMagicActive)
	fiss.saveBool("isJournalActive", isJournalActive)
	fiss.saveBool("isMapActive", isMapActive)
	fiss.saveBool("isBarterActive", isBarterActive)
	fiss.saveBool("isGiftActive", isGiftActive)
	fiss.saveBool("cantLoot", ReadingTakesTime.cantLoot)
	fiss.saveBool("cantPick", ReadingTakesTime.cantPick)
	fiss.saveBool("showMessage", ReadingTakesTime.showMessage)
	fiss.saveBool("dontShowMessage", ReadingTakesTime.dontShowMessage)
	fiss.saveBool("expertiseReducesTime", ReadingTakesTime.expertiseReducesTime)
	fiss.saveBool("cantRead", ReadingTakesTime.cantRead)
	fiss.saveBool("readingIncreasesSpeech", ReadingTakesTime.readingIncreasesSpeech)
	fiss.saveBool("cantLevelUp", ReadingTakesTime.cantLevelUp)
	fiss.saveBool("cantInventory", ReadingTakesTime.cantInventory)
	fiss.saveBool("cantMagic", ReadingTakesTime.cantMagic)
	fiss.saveBool("cantJournal", ReadingTakesTime.cantJournal)
	fiss.saveBool("cantMap", ReadingTakesTime.cantMap)
	
	fiss.saveFloat("readMult", ReadingTakesTime.readMult)
	fiss.saveFloat("readingIncreaseMult", ReadingTakesTime.readingIncreaseMult)
	fiss.saveFloat("spellLearnTime", ReadingTakesTime.spellLearnTime)
	fiss.saveFloat("headCraftTime", ReadingTakesTime.headCraftTime)
	fiss.saveFloat("armorCraftTime", ReadingTakesTime.armorCraftTime)
	fiss.saveFloat("handsCraftTime", ReadingTakesTime.handsCraftTime)
	fiss.saveFloat("feetCraftTime", ReadingTakesTime.feetCraftTime)
	fiss.saveFloat("shieldCraftTime", ReadingTakesTime.shieldCraftTime)
	fiss.saveFloat("jewelryCraftTime", ReadingTakesTime.jewelryCraftTime)
	fiss.saveFloat("battleAxeCraftTime", ReadingTakesTime.battleAxeCraftTime)
	fiss.saveFloat("bowCraftTime", ReadingTakesTime.bowCraftTime)
	fiss.saveFloat("daggerCraftTime", ReadingTakesTime.daggerCraftTime)
	fiss.saveFloat("greatswordCraftTime", ReadingTakesTime.greatswordCraftTime)
	fiss.saveFloat("maceCraftTime", ReadingTakesTime.maceCraftTime)
	fiss.saveFloat("staffCraftTime", ReadingTakesTime.staffCraftTime)
	fiss.saveFloat("swordCraftTime", ReadingTakesTime.swordCraftTime)
	fiss.saveFloat("warhammerCraftTime", ReadingTakesTime.warhammerCraftTime)
	fiss.saveFloat("warAxeCraftTime", ReadingTakesTime.warAxeCraftTime)
	fiss.saveFloat("weaponCraftTime", ReadingTakesTime.weaponCraftTime)
	fiss.saveFloat("miscCraftTime", ReadingTakesTime.miscCraftTime)
	fiss.saveFloat("armorImproveTime", ReadingTakesTime.armorImproveTime)
	fiss.saveFloat("weaponImproveTime", ReadingTakesTime.weaponImproveTime)
	fiss.saveFloat("enchantingTime", ReadingTakesTime.enchantingTime)
	fiss.saveFloat("potionCraftTime", ReadingTakesTime.potionCraftTime)
	fiss.saveFloat("lootMult", ReadingTakesTime.lootMult)
	fiss.saveFloat("pickMult", ReadingTakesTime.pickMult)
	fiss.saveFloat("pickpocketMult", ReadingTakesTime.pickpocketMult)
	fiss.saveFloat("trainingMult", ReadingTakesTime.trainingMult)
	fiss.saveFloat("trainingTime", ReadingTakesTime.trainingTime)
	fiss.saveFloat("levelUpMult", ReadingTakesTime.levelUpMult)
	fiss.saveFloat("levelUpTime", ReadingTakesTime.levelUpTime)
	fiss.saveFloat("inventoryMult", ReadingTakesTime.inventoryMult)
	fiss.saveFloat("eatTime", ReadingTakesTime.eatTime)
	fiss.saveFloat("magicMult", ReadingTakesTime.magicMult)
	fiss.saveFloat("journalMult", ReadingTakesTime.journalMult)
	fiss.saveFloat("mapMult", ReadingTakesTime.mapMult)
	fiss.saveFloat("barterMult", ReadingTakesTime.barterMult)
	fiss.saveFloat("giftMult", ReadingTakesTime.giftMult)

	string saveResult = fiss.endSave()
	if saveResult != ""
		debug.Trace(saveResult)
	endif
EndFunction

Function LoadSettings()
	FISSInterface fiss = FISSFactory.getFISS()
	If !fiss
		debug.MessageBox("FISS not installed. Loading disabled")
		return
	endif
	fiss.beginLoad("LTT\\LTTSettings.xml")
	
	isModActive = fiss.loadBool("isModActive")
	isReadingActive = fiss.loadBool("isReadingActive")
	isCraftingActive = fiss.loadBool("isCraftingActive")
	isContainerActive = fiss.loadBool("isContainerActive")
	isLockpickActive = fiss.loadBool("isLockpickActive")
	isTrainingActive = fiss.loadBool("isTrainingActive")
	isLevelUpActive = fiss.loadBool("isLevelUpActive")
	isInventoryActive = fiss.loadBool("isInventoryActive")
	isMagicActive = fiss.loadBool("isMagicActive")
	isJournalActive = fiss.loadBool("isJournalActive")
	isMapActive = fiss.loadBool("isMapActive")
	isBarterActive = fiss.loadBool("isBarterActive")
	isGiftActive = fiss.loadBool("isGiftActive")
	ReadingTakesTime.cantLoot = fiss.loadBool("cantLoot")
	ReadingTakesTime.cantPick = fiss.loadBool("cantPick")
	ReadingTakesTime.showMessage = fiss.loadBool("showMessage")
	ReadingTakesTime.dontShowMessage = fiss.loadBool("dontShowMessage")
	ReadingTakesTime.expertiseReducesTime = fiss.loadBool("expertiseReducesTime")
	ReadingTakesTime.cantRead = fiss.loadBool("cantRead")
	ReadingTakesTime.readingIncreasesSpeech = fiss.loadBool("readingIncreasesSpeech")
	ReadingTakesTime.cantLevelUp = fiss.loadBool("cantLevelUp")
	ReadingTakesTime.cantInventory = fiss.loadBool("cantInventory")
	ReadingTakesTime.cantMagic = fiss.loadBool("cantMagic")
	ReadingTakesTime.cantJournal = fiss.loadBool("cantJournal")
	ReadingTakesTime.cantMap = fiss.loadBool("cantMap")
	
	ReadingTakesTime.readMult = fiss.loadFloat("readMult")
	ReadingTakesTime.readingIncreaseMult = fiss.loadFloat("readingIncreaseMult")
	ReadingTakesTime.spellLearnTime = fiss.loadFloat("spellLearnTime")
	ReadingTakesTime.headCraftTime = fiss.loadFloat("headCraftTime")
	ReadingTakesTime.armorCraftTime = fiss.loadFloat("armorCraftTime")
	ReadingTakesTime.handsCraftTime = fiss.loadFloat("handsCraftTime")
	ReadingTakesTime.feetCraftTime = fiss.loadFloat("feetCraftTime")
	ReadingTakesTime.shieldCraftTime = fiss.loadFloat("shieldCraftTime")
	ReadingTakesTime.jewelryCraftTime = fiss.loadFloat("jewelryCraftTime")
	ReadingTakesTime.battleAxeCraftTime = fiss.loadFloat("battleAxeCraftTime")
	ReadingTakesTime.bowCraftTime = fiss.loadFloat("bowCraftTime")
	ReadingTakesTime.daggerCraftTime = fiss.loadFloat("daggerCraftTime")
	ReadingTakesTime.greatswordCraftTime = fiss.loadFloat("greatswordCraftTime")
	ReadingTakesTime.maceCraftTime = fiss.loadFloat("maceCraftTime")
	ReadingTakesTime.staffCraftTime = fiss.loadFloat("staffCraftTime")
	ReadingTakesTime.swordCraftTime = fiss.loadFloat("swordCraftTime")
	ReadingTakesTime.warhammerCraftTime = fiss.loadFloat("warhammerCraftTime")
	ReadingTakesTime.warAxeCraftTime = fiss.loadFloat("warAxeCraftTime")
	ReadingTakesTime.weaponCraftTime = fiss.loadFloat("weaponCraftTime")
	ReadingTakesTime.miscCraftTime = fiss.loadFloat("miscCraftTime")
	ReadingTakesTime.armorImproveTime = fiss.loadFloat("armorImproveTime")
	ReadingTakesTime.weaponImproveTime = fiss.loadFloat("weaponImproveTime")
	ReadingTakesTime.enchantingTime = fiss.loadFloat("enchantingTime")
	ReadingTakesTime.potionCraftTime = fiss.loadFloat("potionCraftTime")
	ReadingTakesTime.lootMult = fiss.loadFloat("lootMult")
	ReadingTakesTime.pickMult = fiss.loadFloat("pickMult")
	ReadingTakesTime.pickpocketMult = fiss.loadFloat("pickpocketMult")
	ReadingTakesTime.trainingMult = fiss.loadFloat("trainingMult")
	ReadingTakesTime.trainingTime = fiss.loadFloat("trainingTime")
	ReadingTakesTime.levelUpMult = fiss.loadFloat("levelUpMult")
	ReadingTakesTime.levelUpTime = fiss.loadFloat("levelUpTime")
	ReadingTakesTime.inventoryMult = fiss.loadFloat("inventoryMult")
	ReadingTakesTime.eatTime = fiss.loadFloat("eatTime")
	ReadingTakesTime.magicMult = fiss.loadFloat("magicMult")
	ReadingTakesTime.journalMult = fiss.loadFloat("journalMult")
	ReadingTakesTime.mapMult = fiss.loadFloat("mapMult")
	ReadingTakesTime.barterMult = fiss.loadFloat("barterMult")
	ReadingTakesTime.giftMult = fiss.loadFloat("giftMult")
	
	string loadResult = fiss.endLoad()
	if loadResult != ""
		debug.Trace(loadResult)
	endif
	InitMod()
EndFunction

int function GetVersion()
	return 6
endFunction

event OnConfigInit()
	ModName = "Living Takes Time"
	
	Pages = new string[7]
	Pages[0] = "General"
	Pages[1] = "Reading"
	Pages[2] = "Crafting"
	Pages[3] = "Looting"
	Pages[4] = "Training"
	Pages[5] = "Preparing"
	Pages[6] = "Trading"
	
	ReadingTakesTime.StartReading = Utility.GetCurrentRealTime()
	ReadingTakesTime.StopReading = Utility.GetCurrentRealTime()
	
	UnregisterForAllMenus()
	;UnregisterForCrosshairRef()
	RegisterForMenu("Book Menu")
	RegisterForMenu("Crafting Menu")
	RegisterForMenu("ContainerMenu")
	;RegisterForCrosshairRef()
	RegisterForMenu("Lockpicking Menu")
	RegisterForMenu("Training Menu")
	RegisterForMenu("StatsMenu")
	RegisterForMenu("InventoryMenu")
	RegisterForMenu("MagicMenu")
	RegisterForMenu("Journal Menu")
	RegisterForMenu("MapMenu")
	RegisterForMenu("BarterMenu")
	RegisterForMenu("GiftMenu")
	
	ReadingTakesTime.showMessage = True
	ReadingTakesTime.dontShowMessage = True
	ReadingTakesTime.cantRead = True
	ReadingTakesTime.readMult = 1
	ReadingTakesTime.armorCraftTime = 4
	ReadingTakesTime.weaponCraftTime = 4
	ReadingTakesTime.armorImproveTime = 1
	ReadingTakesTime.weaponImproveTime = 1
	ReadingTakesTime.enchantingTime = 1
	ReadingTakesTime.potionCraftTime = 1
	ReadingTakesTime.cantLoot = True
	ReadingTakesTime.lootMult = 1
	ReadingTakesTime.cantPick = True
	ReadingTakesTime.pickMult = 1
	ReadingTakesTime.trainingMult = 1
	ReadingTakesTime.trainingTime = 2
	ReadingTakesTime.cantLevelUp = True
	ReadingTakesTime.levelUpMult = 1
	ReadingTakesTime.levelUpTime = 1
	ReadingTakesTime.cantInventory = True
	ReadingTakesTime.inventoryMult = 1
	ReadingTakesTime.eatTime = 5
	ReadingTakesTime.cantMagic = True
	ReadingTakesTime.magicMult = 1
	ReadingTakesTime.cantJournal = True
	ReadingTakesTime.journalMult = 1
	ReadingTakesTime.cantMap = True
	ReadingTakesTime.mapMult = 1
	ReadingTakesTime.barterMult = 1
	ReadingTakesTime.giftMult = 1
	
	isModActive = false
	isReadingActive = true
	isCraftingActive = true
	isContainerActive = true
	isLockpickActive = true
	isTrainingActive = true
	isLevelUpActive = true
	isInventoryActive = true
	isMagicActive = true
	isJournalActive = true
	isMapActive = true
	isBarterActive = true
	isGiftActive = true

endEvent

event OnVersionUpdate(int version)
    if (version > 2)
		ReadingTakesTime.isInventoryActive = isInventoryActive 
		ReadingTakesTime.headCraftTime = 3
		ReadingTakesTime.armorCraftTime = 6
		ReadingTakesTime.handsCraftTime = 3
		ReadingTakesTime.feetCraftTime = 3
		ReadingTakesTime.shieldCraftTime = 4
		ReadingTakesTime.jewelryCraftTime = 2
		ReadingTakesTime.battleAxeCraftTime = 4
		ReadingTakesTime.bowCraftTime = 4
		ReadingTakesTime.daggerCraftTime = 3
		ReadingTakesTime.greatswordCraftTime = 4
		ReadingTakesTime.maceCraftTime = 4
		ReadingTakesTime.staffCraftTime = 2
		ReadingTakesTime.swordCraftTime = 4
		ReadingTakesTime.warhammerCraftTime = 4
		ReadingTakesTime.warAxeCraftTime = 4
		ReadingTakesTime.weaponCraftTime = 2
		ReadingTakesTime.miscCraftTime = 2
		ReadingTakesTime.chopTime = 5
    endIf
	if (version > 3)
		ReadingTakesTime.expertiseReducesTime = True
		ReadingTakesTime.readingIncreasesSpeech = True
		ReadingTakesTime.readingIncreaseMult = 1
    endIf
	if (version > 4)
		ReadingTakesTime.pickpocketMult = 1
	endIf
	if (version > 5)
		Pages[0] = "$General"
		Pages[1] = "$Reading"
		Pages[2] = "$Crafting"
		Pages[3] = "$Looting"
		Pages[4] = "$Training"
		Pages[5] = "$Preparing"
		Pages[6] = "$Trading"
		ReadingTakesTime.spellLearnTime = 2
		InitMod()
    endIf
endEvent

event OnGameReload()
	parent.OnGameReload() ; Don't forget to call the parent!	
	InitMod()
endEvent

event OnPageReset(string page)
	if (page == "")
    		LoadCustomContent("LivingTakesTime/LTThome.dds",26,23)
        	return
    	else
        	UnloadCustomContent()
    	endIf
	if (page == "$General")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Options")
		isModActiveID = AddToggleOption("$Activate Mod?", isModActive)
		showMessageID = AddToggleOption("$Show message notifications?", ReadingTakesTime.showMessage)
		dontShowMessageID = AddToggleOption("$No notifications if no time has passed?", ReadingTakesTime.dontShowMessage)
		expertiseReducesTimeID = AddToggleOption("$Expertise reduces time?", ReadingTakesTime.expertiseReducesTime)
		SetCursorPosition(1)
		AddHeaderOption("$Save & Load")
		FISSInterface fiss = FISSFactory.getFISS()
		int SaveFlag = OPTION_FLAG_NONE
		int LoadFlag = OPTION_FLAG_NONE
		if !fiss
			SaveFlag = OPTION_FLAG_DISABLED
			LoadFlag = OPTION_FLAG_DISABLED
		else
			fiss.beginLoad("LTT\\LTTSettings.xml")
			if fiss.endLoad() != ""
				LoadFlag = OPTION_FLAG_DISABLED
			endIf
		endif
		saveID = AddTextOption("$Save settings", "", SaveFlag)
		loadID = AddTextOption("$Load settings", "", LoadFlag)
	elseif (page == "$Reading")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Options")
		isReadingActiveID = AddToggleOption("$Reading Takes Time?", isReadingActive)
		readMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.readMult,"$x{2}")
		cantReadID = AddToggleOption("$Block read while in combat?", ReadingTakesTime.cantRead)
		readingIncreasesSpeechID = AddToggleOption("$Reading increases speech?", ReadingTakesTime.readingIncreasesSpeech)
		readingIncreaseMultID = AddSliderOption("$Reading increase Multiplier", ReadingTakesTime.readingIncreaseMult,"$x{2}")
		spellLearnTimeID = AddSliderOption("$Learning Spell Time", ReadingTakesTime.spellLearnTime,"${1} hour(s)")
	elseIf (page == "$Crafting")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Options")
		isCraftingActiveID = AddToggleOption("$Crafting Takes Time?", isCraftingActive)
		AddHeaderOption("$Armors, Shields and Jewels")
		armorImproveTimeID = AddSliderOption("$Improving Time", ReadingTakesTime.armorImproveTime,"${1} hour(s)")
		headCraftTimeID = AddSliderOption("$Helmet & Circlet Crafting Time", ReadingTakesTime.headCraftTime,"${1} hour(s)")
		armorCraftTimeID = AddSliderOption("$Cuirass & Clothes Crafting Time", ReadingTakesTime.armorCraftTime,"${1} hour(s)")
		handsCraftTimeID = AddSliderOption("$Bracers & Gloves Crafting Time", ReadingTakesTime.handsCraftTime,"${1} hour(s)")
		feetCraftTimeID = AddSliderOption("$Boots & Shoes Crafting Time", ReadingTakesTime.feetCraftTime,"${1} hour(s)")
		shieldCraftTimeID = AddSliderOption("$Shield Crafting Time", ReadingTakesTime.shieldCraftTime,"${1} hour(s)")
		jewelryCraftTimeID = AddSliderOption("$Jewelry Crafting Time", ReadingTakesTime.jewelryCraftTime,"${1} hour(s)")
		AddHeaderOption("$Tanning, Smelting and Misc")
		miscCraftTimeID = AddSliderOption("$Crafting Time", ReadingTakesTime.miscCraftTime,"${1} hour(s)")
		AddHeaderOption("$Enchanting")
		enchantingTimeID = AddSliderOption("$Crafting Time", ReadingTakesTime.enchantingTime,"${1} hour(s)")
		AddHeaderOption("$Potions, Poisons and Food")
		potionCraftTimeID = AddSliderOption("$Crafting Time", ReadingTakesTime.potionCraftTime,"${1} hour(s)")
		SetCursorPosition(5)
		AddHeaderOption("$Weapons")
		weaponImproveTimeID = AddSliderOption("$Improving Time", ReadingTakesTime.weaponImproveTime,"${1} hour(s)")
		battleAxeCraftTimeID = AddSliderOption("$Battle Axe Crafting Time", ReadingTakesTime.battleAxeCraftTime,"${1} hour(s)")
		bowCraftTimeID = AddSliderOption("$Bow Crafting Time", ReadingTakesTime.bowCraftTime,"${1} hour(s)")
		daggerCraftTimeID = AddSliderOption("$Dagger Crafting Time", ReadingTakesTime.daggerCraftTime,"${1} hour(s)")
		greatswordCraftTimeID = AddSliderOption("$Greatsword Crafting Time", ReadingTakesTime.greatswordCraftTime,"${1} hour(s)")
		maceCraftTimeID = AddSliderOption("$Mace Crafting Time", ReadingTakesTime.maceCraftTime,"${1} hour(s)")
		staffCraftTimeID = AddSliderOption("$Staff Crafting Time", ReadingTakesTime.staffCraftTime,"${1} hour(s)")
		swordCraftTimeID = AddSliderOption("$Sword Crafting Time", ReadingTakesTime.swordCraftTime,"${1} hour(s)")
		warhammerCraftTimeID = AddSliderOption("$Warhammer Crafting Time", ReadingTakesTime.warhammerCraftTime,"${1} hour(s)")
		warAxeCraftTimeID = AddSliderOption("$War Axe Crafting Time", ReadingTakesTime.warAxeCraftTime,"${1} hour(s)")
		weaponCraftTimeID = AddSliderOption("$Ammo Crafting Time", ReadingTakesTime.weaponCraftTime,"${1} hour(s)")
	elseIf (page == "$Looting")
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$Containers, Dead Bodies and Pickpocket")
		AddHeaderOption("$Lockpicking")
		isContainerActiveID = AddToggleOption("$Looting Takes Time?", isContainerActive)
		isLockpickActiveID = AddToggleOption("$Lockpicking Takes Time?", isLockpickActive)
		lootMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.lootMult,"$x{2}")
		pickMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.pickMult,"$x{2}")
		cantLootID = AddToggleOption("$Block looting while in combat?", ReadingTakesTime.cantLoot)
		cantPickID = AddToggleOption("$Block lockpicking while in combat?", ReadingTakesTime.cantPick)
		pickpocketMultID = AddSliderOption("$Pickpocket Time Multiplier", ReadingTakesTime.pickpocketMult,"$x{2}")
	elseIf (page == "$Training")
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$Training")
		AddHeaderOption("$Level Up")
		isTrainingActiveID = AddToggleOption("$Training Takes Time?", isTrainingActive)
		isLevelUpActiveID = AddToggleOption("$Leveling Up Takes Time?", isLevelUpActive)
		trainingMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.trainingMult,"$x{2}")
		levelUpMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.levelUpMult,"$x{2}")
		trainingTimeID = AddSliderOption("$Training Time", ReadingTakesTime.trainingTime,"${1} hour(s)")
		SetCursorFillMode(TOP_TO_BOTTOM)
		levelUpTimeID = AddSliderOption("$Level Up Time", ReadingTakesTime.levelUpTime,"${1} hour(s)")
		cantLevelUpID = AddToggleOption("$Block leveling while in combat?", ReadingTakesTime.cantLevelUp)
	elseIf (page == "$Preparing")
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$Inventory")
		AddHeaderOption("$Magic")
		isInventoryActiveID = AddToggleOption("$Inventory Takes Time?", isInventoryActive)
		isMagicActiveID = AddToggleOption("$Magic Menu Takes Time?", isMagicActive)
		inventoryMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.inventoryMult,"$x{2}")
		magicMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.magicMult,"$x{2}")
		cantInventoryID = AddToggleOption("$Block inventory while in combat?", ReadingTakesTime.cantInventory)
		cantMagicID = AddToggleOption("$Block magic menu while in combat?", ReadingTakesTime.cantMagic)
		SetCursorFillMode(TOP_TO_BOTTOM)
		eatTimeID = AddSliderOption("$Eating Time", ReadingTakesTime.eatTime,"${0} Minute(s)")
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$Journal")
		AddHeaderOption("$Map")
		isJournalActiveID = AddToggleOption("$Journal Takes Time?", isJournalActive)
		isMapActiveID = AddToggleOption("$Map Takes Time?", isMapActive)
		journalMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.journalMult,"$x{2}")
		mapMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.mapMult,"$x{2}")
		cantJournalID = AddToggleOption("$Block journal while in combat?", ReadingTakesTime.cantJournal)
		cantMapID = AddToggleOption("$Block map menu while in combat?", ReadingTakesTime.cantMap)
	elseIf (page == "$Trading")
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$Barter")
		AddHeaderOption("$Gift")
		isBarterActiveID = AddToggleOption("$Barter Takes Time?", isBarterActive)
		isGiftActiveID = AddToggleOption("$Gifting Takes Time?", isGiftActive)
		barterMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.barterMult,"$x{2}")
		giftMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.giftMult,"$x{2}")

	endIf
endEvent

event OnOptionSelect(int option)
	if (option == saveID)
		Bool Choice = ShowMessage("$Save Settings?", True, "$Save", "$Cancel")
		if (Choice)
			SaveSettings()
			ForcePageReset()
		endif
	endif
	if (option == loadID)
		Bool Choice = ShowMessage("$Load Settings?", True, "$Load", "$Cancel")
		if (Choice)
			LoadSettings()
			ForcePageReset()
		endif
	endif
	if ( option == isModActiveID )
		isModActive= !isModActive
		SetToggleOptionValue(isModActiveID , isModActive)
		InitMod()
	elseif ( option == isReadingActiveID )
		isReadingActive = !isReadingActive
		SetToggleOptionValue(isReadingActiveID, isReadingActive)
		if ( isReadingActive )
			RegisterForMenu("Book Menu")
		else
			UnregisterForMenu("Book Menu")
		endIf
	elseif ( option == isCraftingActiveID )
		isCraftingActive = !isCraftingActive 
		SetToggleOptionValue(isCraftingActiveID, isCraftingActive )
		if ( isCraftingActive )
			RegisterForMenu("Crafting Menu")
		else
			UnregisterForMenu("Crafting Menu")
		endIf
	elseif ( option == isContainerActiveID )
		isContainerActive = !isContainerActive 
		SetToggleOptionValue(isContainerActiveID, isContainerActive )
		if ( isContainerActive )
			RegisterForMenu("ContainerMenu")
			;RegisterForCrosshairRef()
		else
			UnregisterForMenu("ContainerMenu")
			;UnregisterForCrosshairRef()
		endIf
	elseif ( option == isLockpickActiveID )
		isLockpickActive = !isLockpickActive 
		SetToggleOptionValue(isLockpickActiveID, isLockpickActive )
		if ( isLockpickActive )
			RegisterForMenu("Lockpicking Menu")
		else
			UnregisterForMenu("Lockpicking Menu")
		endIf
	elseif ( option == isTrainingActiveID )
		isTrainingActive = !isTrainingActive
		SetToggleOptionValue(isTrainingActiveID, isTrainingActive )
		if ( isTrainingActive)
			RegisterForMenu("Training Menu")
		else
			UnregisterForMenu("Training Menu")
		endIf
	elseif ( option == isLevelUpActiveID )
		isLevelUpActive = !isLevelUpActive
		SetToggleOptionValue(isLevelUpActiveID, isLevelUpActive )
		if ( isLevelUpActive )
			RegisterForMenu("StatsMenu")
		else
			UnregisterForMenu("StatsMenu")
		endIf
	elseif ( option == isInventoryActiveID)
		isInventoryActive = !isInventoryActive 
		ReadingTakesTime.isInventoryActive = isInventoryActive 
		SetToggleOptionValue(isInventoryActiveID, isInventoryActive )
		if ( isInventoryActive )
			RegisterForMenu("InventoryMenu")
		else
			UnregisterForMenu("InventoryMenu")
		endIf
	elseif ( option == isMagicActiveID)
		isMagicActive = !isMagicActive 
		SetToggleOptionValue(isMagicActiveID, isMagicActive )
		if ( isMagicActive )
			RegisterForMenu("MagicMenu")
		else
			UnregisterForMenu("MagicMenu")
		endIf
	elseif ( option == isJournalActiveID)
		isJournalActive = !isJournalActive
		SetToggleOptionValue(isJournalActiveID, isJournalActive )
		if ( isJournalActive )
			RegisterForMenu("Journal Menu")
			ReadingTakesTime.StartReading = Utility.GetCurrentRealTime()
			ReadingTakesTime.StopReading = Utility.GetCurrentRealTime()
		else
			UnregisterForMenu("Journal Menu")
		endIf
	elseif ( option == isMapActiveID )
		isMapActive = !isMapActive
		SetToggleOptionValue(isMapActiveID, isMapActive )
		if ( isMapActive )
			RegisterForMenu("MapMenu")
		else
			UnregisterForMenu("MapMenu")
		endIf
	elseif ( option == isBarterActiveID )
		isBarterActive = !isBarterActive 
		SetToggleOptionValue(isBarterActiveID, isBarterActive )
		if ( isBarterActive )
			RegisterForMenu("BarterMenu")
		else
			UnregisterForMenu("BarterMenu")
		endIf
	elseif ( option == isGiftActiveID )
		isGiftActive = !isGiftActive 
		SetToggleOptionValue(isGiftActiveID, isGiftActive )
		if ( isGiftActive )
			RegisterForMenu("GiftMenu")
		else
			UnregisterForMenu("GiftMenu")
		endIf
	elseif ( option == cantLootID )
		ReadingTakesTime.cantLoot = !ReadingTakesTime.cantLoot
		SetToggleOptionValue(cantLootID, ReadingTakesTime.cantLoot)
	elseif ( option == cantPickID )
		ReadingTakesTime.cantPick = !ReadingTakesTime.cantPick
		SetToggleOptionValue(cantPickID, ReadingTakesTime.cantPick)
	elseif ( option == showMessageID )
		ReadingTakesTime.showMessage = !ReadingTakesTime.showMessage
		SetToggleOptionValue(showMessageID , ReadingTakesTime.showMessage)
	elseif ( option == dontShowMessageID )
		ReadingTakesTime.dontShowMessage = !ReadingTakesTime.dontShowMessage 
		SetToggleOptionValue(dontShowMessageID, ReadingTakesTime.dontShowMessage )
	elseif ( option == expertiseReducesTimeID )
		ReadingTakesTime.expertiseReducesTime = !ReadingTakesTime.expertiseReducesTime 
		SetToggleOptionValue(expertiseReducesTimeID, ReadingTakesTime.expertiseReducesTime )
	elseif ( option == cantReadID)
		ReadingTakesTime.cantRead = !ReadingTakesTime.cantRead
		SetToggleOptionValue(cantReadID, ReadingTakesTime.cantRead)
	elseif ( option == readingIncreasesSpeechID)
		ReadingTakesTime.readingIncreasesSpeech = !ReadingTakesTime.readingIncreasesSpeech
		SetToggleOptionValue(readingIncreasesSpeechID, ReadingTakesTime.readingIncreasesSpeech)
	elseif ( option == cantLevelUpID)
		ReadingTakesTime.cantLevelUp = !ReadingTakesTime.cantLevelUp
		SetToggleOptionValue(cantLevelUpID, ReadingTakesTime.cantLevelUp)
	elseif ( option == cantInventoryID)
		ReadingTakesTime.cantInventory = !ReadingTakesTime.cantInventory
		SetToggleOptionValue(cantInventoryID, ReadingTakesTime.cantInventory)
	elseif ( option == cantMagicID)
		ReadingTakesTime.cantMagic = !ReadingTakesTime.cantMagic
		SetToggleOptionValue(cantMagicID, ReadingTakesTime.cantMagic)
	elseif ( option == cantJournalID)
		ReadingTakesTime.cantJournal = !ReadingTakesTime.cantJournal
		SetToggleOptionValue(cantJournalID, ReadingTakesTime.cantJournal)
	elseif ( option == cantMapID)
		ReadingTakesTime.cantMap = !ReadingTakesTime.cantMap
		SetToggleOptionValue(cantMapID, ReadingTakesTime.cantMap)
	endIf
endEvent

event OnOptionSliderOpen(int option)
	if (option == readMultID )
		SetSliderDialogStartValue(ReadingTakesTime.readMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseif (option == readingIncreaseMultID )
		SetSliderDialogStartValue(ReadingTakesTime.readingIncreaseMult)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(0.1)
		
	elseif (option == spellLearnTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.spellLearnTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseif (option == headCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.headCraftTime)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseif (option == armorCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.armorCraftTime)
		SetSliderDialogDefaultValue(6.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseif (option == handsCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.handsCraftTime)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseif (option == feetCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.feetCraftTime)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseif (option == shieldCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.shieldCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseif (option == jewelryCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.jewelryCraftTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == battleAxeCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.battleAxeCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == bowCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.bowCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == daggerCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.daggerCraftTime)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == greatswordCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.greatswordCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == maceCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.maceCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == staffCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.staffCraftTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == swordCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.swordCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == warhammerCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.warhammerCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == warAxeCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.warAxeCraftTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == weaponCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.weaponCraftTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == miscCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.miscCraftTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == armorImproveTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.armorImproveTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == weaponImproveTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.weaponImproveTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == enchantingTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.enchantingTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == potionCraftTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.potionCraftTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == lootMultID )
		SetSliderDialogStartValue(ReadingTakesTime.lootMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == pickMultID )
		SetSliderDialogStartValue(ReadingTakesTime.pickMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
		
	elseIf (option == pickpocketMultID )
		SetSliderDialogStartValue(ReadingTakesTime.pickpocketMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == trainingMultID )
		SetSliderDialogStartValue(ReadingTakesTime.trainingMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == trainingTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.trainingTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == levelUpMultID )
		SetSliderDialogStartValue(ReadingTakesTime.levelUpMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == levelUpTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.levelUpTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	
	elseIf (option == inventoryMultID )
		SetSliderDialogStartValue(ReadingTakesTime.inventoryMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == eatTimeID )
		SetSliderDialogStartValue(ReadingTakesTime.eatTime)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	
	elseIf (option == magicMultID )
		SetSliderDialogStartValue(ReadingTakesTime.magicMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == journalMultID )
		SetSliderDialogStartValue(ReadingTakesTime.journalMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == mapMultID )
		SetSliderDialogStartValue(ReadingTakesTime.mapMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == barterMultID )
		SetSliderDialogStartValue(ReadingTakesTime.barterMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseIf (option == giftMultID )
		SetSliderDialogStartValue(ReadingTakesTime.giftMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	endIf
endEvent


event OnOptionSliderAccept(int option, float value)
    if (option == readMultID )
        ReadingTakesTime.readMult = value
        SetSliderOptionValue(readMultID, ReadingTakesTime.readMult, "$x{2}")

    elseIf (option == readingIncreaseMultID )
        ReadingTakesTime.readingIncreaseMult = value
        SetSliderOptionValue(readingIncreaseMultID , ReadingTakesTime.readingIncreaseMult, "$x{2}")

    elseIf (option == spellLearnTimeID )
        ReadingTakesTime.spellLearnTime = value
        SetSliderOptionValue(spellLearnTimeID , ReadingTakesTime.spellLearnTime, "${1} hour(s)")

    elseIf (option == headCraftTimeID )
        ReadingTakesTime.headCraftTime = value
        SetSliderOptionValue(headCraftTimeID , ReadingTakesTime.headCraftTime, "${1} hour(s)")

    elseIf (option == armorCraftTimeID )
        ReadingTakesTime.armorCraftTime = value
        SetSliderOptionValue(armorCraftTimeID , ReadingTakesTime.armorCraftTime, "${1} hour(s)")

    elseIf (option == handsCraftTimeID )
        ReadingTakesTime.handsCraftTime = value
        SetSliderOptionValue(handsCraftTimeID , ReadingTakesTime.handsCraftTime, "${1} hour(s)")

    elseIf (option == feetCraftTimeID )
        ReadingTakesTime.feetCraftTime = value
        SetSliderOptionValue(feetCraftTimeID , ReadingTakesTime.feetCraftTime, "${1} hour(s)")

    elseIf (option == shieldCraftTimeID )
        ReadingTakesTime.shieldCraftTime = value
        SetSliderOptionValue(shieldCraftTimeID , ReadingTakesTime.shieldCraftTime, "${1} hour(s)")

    elseIf (option == jewelryCraftTimeID )
        ReadingTakesTime.jewelryCraftTime = value
        SetSliderOptionValue(jewelryCraftTimeID , ReadingTakesTime.jewelryCraftTime, "${1} hour(s)")

    elseIf (option == battleAxeCraftTimeID )
        ReadingTakesTime.battleAxeCraftTime = value
        SetSliderOptionValue(battleAxeCraftTimeID, ReadingTakesTime.battleAxeCraftTime, "${1} hour(s)")

    elseIf (option == bowCraftTimeID )
        ReadingTakesTime.bowCraftTime = value
        SetSliderOptionValue(bowCraftTimeID, ReadingTakesTime.bowCraftTime, "${1} hour(s)")

    elseIf (option == daggerCraftTimeID )
        ReadingTakesTime.daggerCraftTime = value
        SetSliderOptionValue(daggerCraftTimeID, ReadingTakesTime.daggerCraftTime, "${1} hour(s)")

    elseIf (option == greatswordCraftTimeID )
        ReadingTakesTime.greatswordCraftTime = value
        SetSliderOptionValue(greatswordCraftTimeID, ReadingTakesTime.greatswordCraftTime, "${1} hour(s)")

    elseIf (option == maceCraftTimeID )
        ReadingTakesTime.maceCraftTime = value
        SetSliderOptionValue(maceCraftTimeID, ReadingTakesTime.maceCraftTime, "${1} hour(s)")

    elseIf (option == staffCraftTimeID )
        ReadingTakesTime.staffCraftTime = value
        SetSliderOptionValue(staffCraftTimeID, ReadingTakesTime.staffCraftTime, "${1} hour(s)")

    elseIf (option == swordCraftTimeID )
        ReadingTakesTime.swordCraftTime = value
        SetSliderOptionValue(swordCraftTimeID, ReadingTakesTime.swordCraftTime, "${1} hour(s)")

    elseIf (option == warhammerCraftTimeID )
        ReadingTakesTime.warhammerCraftTime = value
        SetSliderOptionValue(warhammerCraftTimeID, ReadingTakesTime.warhammerCraftTime, "${1} hour(s)")

    elseIf (option == warAxeCraftTimeID )
        ReadingTakesTime.warAxeCraftTime = value
        SetSliderOptionValue(warAxeCraftTimeID, ReadingTakesTime.warAxeCraftTime, "${1} hour(s)")

    elseIf (option == weaponCraftTimeID )
        ReadingTakesTime.weaponCraftTime = value
        SetSliderOptionValue(weaponCraftTimeID, ReadingTakesTime.weaponCraftTime, "${1} hour(s)")

    elseIf (option == miscCraftTimeID )
        ReadingTakesTime.miscCraftTime = value
        SetSliderOptionValue(miscCraftTimeID, ReadingTakesTime.miscCraftTime, "${1} hour(s)")

    elseIf (option == armorImproveTimeID )
        ReadingTakesTime.armorImproveTime = value
        SetSliderOptionValue(armorImproveTimeID , ReadingTakesTime.armorImproveTime, "${1} hour(s)")

    elseIf (option == weaponImproveTimeID )
        ReadingTakesTime.weaponImproveTime = value
        SetSliderOptionValue(weaponImproveTimeID , ReadingTakesTime.weaponImproveTime, "${1} hour(s)")

    elseIf (option == enchantingTimeID )
        ReadingTakesTime.enchantingTime = value
        SetSliderOptionValue(enchantingTimeID, ReadingTakesTime.enchantingTime, "${1} hour(s)")

    elseIf (option == potionCraftTimeID )
        ReadingTakesTime.potionCraftTime = value
        SetSliderOptionValue(potionCraftTimeID, ReadingTakesTime.potionCraftTime, "${1} hour(s)")

    elseIf (option == lootMultID )
        ReadingTakesTime.lootMult = value
        SetSliderOptionValue(lootMultID, ReadingTakesTime.lootMult, "$x{2}")

    elseIf (option == pickMultID )
        ReadingTakesTime.pickMult = value
        SetSliderOptionValue(pickMultID, ReadingTakesTime.pickMult, "$x{2}")

    elseIf (option == pickpocketMultID )
        ReadingTakesTime.pickpocketMult = value
        SetSliderOptionValue(pickpocketMultID, ReadingTakesTime.pickpocketMult, "$x{2}")

    elseIf (option == trainingMultID )
        ReadingTakesTime.trainingMult = value
        SetSliderOptionValue(trainingMultID, ReadingTakesTime.trainingMult, "$x{2}")

    elseIf (option == trainingTimeID )
        ReadingTakesTime.trainingTime = value
        SetSliderOptionValue(trainingTimeID, ReadingTakesTime.trainingTime, "${1} hour(s)")

    elseIf (option == levelUpMultID )
        ReadingTakesTime.levelUpMult = value
        SetSliderOptionValue(levelUpMultID, ReadingTakesTime.levelUpMult, "$x{2}")

    elseIf (option == levelUpTimeID )
        ReadingTakesTime.levelUpTime = value
        SetSliderOptionValue(levelUpTimeID, ReadingTakesTime.levelUpTime, "${1} hour(s)")

    elseIf (option == inventoryMultID )
        ReadingTakesTime.inventoryMult = value
        SetSliderOptionValue(inventoryMultID, ReadingTakesTime.inventoryMult , "$x{2}")

    elseIf (option == eatTimeID )
        ReadingTakesTime.eatTime = value
        SetSliderOptionValue(eatTimeID, ReadingTakesTime.eatTime, "${0} Minute(s)")

    elseIf (option == magicMultID )
        ReadingTakesTime.magicMult = value
        SetSliderOptionValue(magicMultID, ReadingTakesTime.magicMult, "$x{2}")

    elseIf (option == journalMultID )
        ReadingTakesTime.journalMult = value
        SetSliderOptionValue(journalMultID, ReadingTakesTime.journalMult, "$x{2}")

    elseIf (option == mapMultID )
        ReadingTakesTime.mapMult = value
        SetSliderOptionValue(mapMultID, ReadingTakesTime.mapMult, "$x{2}")

    elseIf (option == barterMultID )
        ReadingTakesTime.barterMult = value
        SetSliderOptionValue(barterMultID, ReadingTakesTime.barterMult, "$x{2}")

    elseIf (option == giftMultID )
        ReadingTakesTime.giftMult = value
        SetSliderOptionValue(giftMultID, ReadingTakesTime.giftMult, "$x{2}")

    endIf
endEvent

event OnOptionDefault(int option)
	if (option == isModActiveID )
		isModActive = true ; default value
		SetToggleOptionValue(isModActiveID , isModActive)
	elseif (option == isReadingActiveID )
		isReadingActive = true ; default value
		SetToggleOptionValue(isReadingActiveID , isReadingActive)
	elseif (option == isCraftingActiveID )
		isCraftingActive = true ; default value
		SetToggleOptionValue(isCraftingActiveID , isCraftingActive)
	elseif (option == showMessageID )
		ReadingTakesTime.showMessage = true ; default value
		SetToggleOptionValue(showMessageID , ReadingTakesTime.showMessage)
	elseif (option == dontShowMessageID )
		ReadingTakesTime.dontShowMessage = true ; default value
		SetToggleOptionValue(dontShowMessageID, ReadingTakesTime.dontShowMessage )
	elseif (option == expertiseReducesTimeID )
		ReadingTakesTime.expertiseReducesTime = true ; default value
		SetToggleOptionValue(expertiseReducesTimeID, ReadingTakesTime.expertiseReducesTime )
	elseif (option == cantReadID)
		ReadingTakesTime.cantRead = true ; default value
		SetToggleOptionValue(cantReadID, ReadingTakesTime.cantRead)
	elseif (option == readingIncreasesSpeechID)
		ReadingTakesTime.readingIncreasesSpeech = true ; default value
		SetToggleOptionValue(readingIncreasesSpeechID, ReadingTakesTime.readingIncreasesSpeech)
	elseif (option == cantLootID)
		ReadingTakesTime.cantLoot= true ; default value
		SetToggleOptionValue(cantLootID, ReadingTakesTime.cantLoot)
	elseif (option == cantPickID)
		ReadingTakesTime.cantPick= true ; default value
		SetToggleOptionValue(cantPickID, ReadingTakesTime.cantPick)
	elseif (option == cantLevelUpID)
		ReadingTakesTime.cantLevelUp= true ; default value
		SetToggleOptionValue(cantLevelUpID, ReadingTakesTime.cantLevelUp)
	elseif (option == cantInventoryID)
		ReadingTakesTime.cantInventory= true ; default value
		SetToggleOptionValue(cantInventoryID, ReadingTakesTime.cantInventory)
	elseif (option == cantMagicID)
		ReadingTakesTime.cantMagic= true ; default value
		SetToggleOptionValue(cantMagicID, ReadingTakesTime.cantMagic)
	elseif (option == cantJournalID)
		ReadingTakesTime.cantJournal= true ; default value
		SetToggleOptionValue(cantJournalID, ReadingTakesTime.cantJournal)
	elseif (option == cantMapID)
		ReadingTakesTime.cantMap= true ; default value
		SetToggleOptionValue(cantMapID, ReadingTakesTime.cantMap)
	endIf
endEvent

event OnOptionHighlight(int option)
	if (option == isModActiveID )
		SetInfoText("$Activate or deactivate the mod.")
	elseif (option == isReadingActiveID || option == isCraftingActiveID || option == isContainerActiveID || option == isLockpickActiveID || option == isTrainingActiveID|| option == isLevelUpActiveID|| option == isInventoryActiveID|| option == isMagicActiveID|| option == isJournalActiveID|| option == isMapActiveID|| option == isBarterActiveID|| option == isGiftActiveID)
		SetInfoText("$Activate or deactivate this module.")
	elseif (option == readMultID|| option == lootMultID|| option == pickMultID|| option == pickpocketMultID|| option == trainingMultID|| option == levelUpMultID|| option == inventoryMultID|| option == magicMultID|| option == journalMultID|| option == mapMultID|| option == barterMultID|| option == giftMultID)
		SetInfoText("$Multiplier used to calculate the time spent in this menu.")
	elseif (option == spellLearnTimeID|| option == headCraftTimeID|| option == armorCraftTimeID|| option == handsCraftTimeID|| option == feetCraftTimeID|| option == shieldCraftTimeID|| option == jewelryCraftTimeID|| option == battleAxeCraftTimeID|| option == bowCraftTimeID|| option == daggerCraftTimeID|| option == greatswordCraftTimeID|| option == maceCraftTimeID|| option == staffCraftTimeID|| option == swordCraftTimeID|| option == warhammerCraftTimeID|| option == warAxeCraftTimeID|| option == weaponCraftTimeID|| option == miscCraftTimeID|| option == armorImproveTimeID|| option == weaponImproveTimeID|| option == potionCraftTimeID|| option == enchantingTimeID|| option == trainingTimeID|| option == levelUpTimeID|| option == eatTimeID)
		SetInfoText("$Time spent when performing this action.")
	elseif (option == cantReadID || option == cantLootID|| option == cantPickID|| option == cantLevelUpID|| option == cantInventoryID|| option == cantMagicID|| option == cantJournalID|| option == cantMapID)
		SetInfoText("$Block this action while in combat.")
	elseif (option == readingIncreasesSpeechID )
		SetInfoText("$Reading increases speech.")
	elseif (option == readingIncreaseMultID )
		SetInfoText("$Reading increase multiplier.")
	elseif (option == showMessageID )
		SetInfoText("$Show notification messages with the time spent.")
	elseif (option == dontShowMessageID )
		SetInfoText("$RTT_DONTSHOWMESSAGE_HIGHLIGHT")
	elseif (option == expertiseReducesTimeID )
		SetInfoText("$RTT_EXPERTIESEREDUCESTIME_HIGHLIGHT")
	endIf
endEvent