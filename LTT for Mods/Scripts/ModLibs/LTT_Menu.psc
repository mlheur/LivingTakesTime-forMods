scriptname LTT_Menu extends SKI_ConfigBase

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Most of the MCM handlers will be called from LTT.mcm_* functions because it
; has access to all the mod handlers, properties, etc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variable Declarations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Properties passed from ESP
Quest Property LTT Auto

int function GetVersion()
	return LTT.getVersion()
endFunction

event OnConfigInit()
	Pages = LTT.mcmOnConfigInit( 0 )
endevent

event OnPageReset(string page)
	if (page == "")
		LoadCustomContent("LivingTakesTime/LTThome.dds",26,23)
		return
	else
		UnloadCustomContent()
	endIf
	
	bool isCFActive = Game.GetFormFromFile(0x0468D3, "Campfire.esm") ; _Camp_BlankItem
	bool isFFActive = Game.GetFormFromFile(0x01D430, "Frostfall.esp") ; _Frost_WaterPotion
	bool isRNActive = Game.GetFormFromFile(0x005968, "RealisticNeedsandDiseases.esp") ; Water
	bool isHBActive = Game.GetFormFromFile(0x006953, "Hunterborn.esp") ; Bits of Bone
	bool isWLActive = Game.GetFormFromFile(0x0012C9, "Chesko_WearableLantern.esp") ; Travel Lantern
	bool isLCActive = Game.GetFormFromFile(0x0012DC, "lanterns.esp") ; Candle
	DebugMode ( "Active Mods: CF["+isCFActive+"] FF["+isFFActive+"] RN["+isRNActive+"] HB["+isHBActive+"] WL ["+isWLActive+"] LC["+isLCActive+"]" );
	
	if (page == "$General")
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Options")
		isModActiveID = AddToggleOption("$Activate Mod?", isModActive)
		showMessageID = AddToggleOption("$Show message notifications?", ReadingTakesTime.showMessage)
		;dontShowMessageID = AddToggleOption("$No notifications if no time has passed?", ReadingTakesTime.dontShowMessage)
		showMessageThresholdID = AddSliderOption("$Notification threshold", ReadingTakesTime.showMessageThreshold)
		expertiseReducesTimeID = AddToggleOption("$Expertise reduces time?", ReadingTakesTime.expertiseReducesTime)
		hotkeySuspendID = AddKeyMapOption("Suspend hotkey", ReadingTakesTime.hotkeySuspend)
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
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Containers, Dead Bodies and Pickpocket")
		isContainerActiveID = AddToggleOption("$Looting Takes Time?", isContainerActive)
		lootMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.lootMult,"$x{2}")
		cantLootID = AddToggleOption("$Block looting while in combat?", ReadingTakesTime.cantLoot)
		pickpocketMultID = AddSliderOption("$Pickpocket Time Multiplier", ReadingTakesTime.pickpocketMult,"$x{2}")
		; New options, by dragonsong
		LightAmorID = AddSliderOption("Time to loot light armor", ReadingTakesTime.lightArmorTime, "${0} Minute(s)")
		HeavyArmorID = AddSliderOption("Time to loot heavy armor", ReadingTakesTime.heavyArmorTime, "${0} Minute(s)")
		SetCursorPosition(1)
		AddHeaderOption("$Lockpicking")
		isLockpickActiveID = AddToggleOption("$Lockpicking Takes Time?", isLockpickActive)
		pickMultID = AddSliderOption("$Time Multiplier", ReadingTakesTime.pickMult,"$x{2}")
		cantPickID = AddToggleOption("$Block lockpicking while in combat?", ReadingTakesTime.cantPick)		
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
		
	ElseIf page == "Campfire, Frostfall"
		SetCursorFillMode(TOP_TO_BOTTOM)
		If !isCFActive
			AddTextOption("", "Campfire is not active.")
			Return
		EndIf
		AddHeaderOption("Camping Gear")
		CFCloakID = AddSliderOption("Cloaks", ReadingTakesTime.cfCloakTime, "${1} hour(s)")
		CFStickID = AddSliderOption("Walking stick", ReadingTakesTime.cfStickTime, "${0} Minute(s)")
		CFTorchID = AddSliderOption("Torch", ReadingTakesTime.cfTorchTime, "${0} Minute(s)")
		CFCookpotID = AddSliderOption("Cooking Pot", ReadingTakesTime.cfCookpotTime, "${1} hour(s)")
		CFBackpackID = AddSliderOption("Backpacks", ReadingTakesTime.cfBackpackTime, "${1} hour(s)")
		CFBeddingID = AddSliderOption("Bedding", ReadingTakesTime.cfBeddingTime, "${1} hour(s)")
		CFSmallTentID = AddSliderOption("Small tents", ReadingTakesTime.cfSmallTentTime, "${1} hour(s)")
		CFLargeTentID = AddSliderOption("Large tents", ReadingTakesTime.cfLargeTentTime, "${1} hour(s)")
		CFHatchetID = AddSliderOption("Tools", ReadingTakesTime.cfHatchetTime, "${0} Minute(s)")
		CFArrowsID = AddSliderOption("Arrows", ReadingTakesTime.cfArrowsTime, "${1} hour(s)")
		; Ends in cell 20
		
		SetCursorPosition(19)
		AddHeaderOption("Materials")
		CFLinenID = AddSliderOption("Linen wrap", ReadingTakesTime.cfLinenTime, "${0} Minute(s)")
		CFFurID = AddSliderOption("Fur plate", ReadingTakesTime.cfFurTime, "${1} hour(s)")
		CFLaceID = AddSliderOption("Hide lace", ReadingTakesTime.cfLaceTime, "${0} Minute(s)")
		CFTanRackID = AddSliderOption("Tanning rack", ReadingTakesTime.cfTanRackTime, "${0} Minute(s)")
		CFMortarID = AddSliderOption("Mortar and pestle", ReadingTakesTime.cfMortarTime, "${1} hour(s)")
		CFEnchID = AddSliderOption("Enchanting supplies", ReadingTakesTime.cfEnchTime, "${1} hour(s)")
		; Ends in cell 31

		SetCursorPosition(1)
		AddHeaderOption("Firecraft")
		CFFirecraftImprovesID = AddToggleOption( "Perk Improves", ReadingTakesTime.cfFirecraftImproves )
		CFMakeTinderID = AddSliderOption("Make Tinder", ReadingTakesTime.cfMakeTinderTime, "${0} Minute(s)")
		CFMakeKindlingID = AddSliderOption("Make Kindling", ReadingTakesTime.cfMakeKindlingTime, "${0} Minute(s)")
		CFAddTinderID = AddSliderOption("Add Tinder", ReadingTakesTime.cfAddTinderTime, "${0} Minute(s)")
		CFAddKindlingID = AddSliderOption("Add Kindling", ReadingTakesTime.cfAddKindlingTime, "${0} Minute(s)")
		CFLightFireID = AddSliderOption("Sparking the Fire", ReadingTakesTime.cfLightFireTime, "${0} Minute(s)")
		CFAddFuelID = AddSliderOption("Stoking the Fire", ReadingTakesTime.cfAddFuelTime, "${0} Minute(s)")
		; ensd in cell 15
		
		SetCursorPosition(24)
		If isFFActive
			AddHeaderOption( "Frostfall" )
			FFSnowberryID = AddSliderOption( "Snowberry Extract", ReadingTakesTime.ffSnowberryTime, "${0} Minute(s)")
		else
			AddHeaderOption( "Frostfall not active" )
		endif
		; ends on 24 or 26 depending on if FF is active or not.
		
	ElseIf page == "RND"
		SetCursorFillMode(TOP_TO_BOTTOM)
		If !isRNActive
			AddTextOption("", "Realistic Needs and Diseases is not active.")
			Return
		EndIf
		AddHeaderOption("Crafted")
		RNWaterskinID = AddSliderOption("Waterskin", ReadingTakesTime.rnWaterskinTime, "${1} hour(s)")
		RNCookpotID = AddSliderOption("Cookpot", ReadingTakesTime.rnCookpotTime, "${1} hour(s)")
		RNTinderboxID = AddSliderOption("Tinderbox", ReadingTakesTime.rnTinderboxTime, "${1} hour(s)")
		RNBedrollID = AddSliderOption("Bedroll", ReadingTakesTime.rnBedrollTime, "${1} hour(s)")
		RNTentID = AddSliderOption("Tent", ReadingTakesTime.rnTentTime, "${1} hour(s)")
		RNMilkBucketID = AddSliderOption("Milk bucket", ReadingTakesTime.rnMilkBucketTime, "${0} Minute(s)")
		SetCursorPosition(1)
		AddHeaderOption("Cooked")
		RNFoodSnackID = AddSliderOption("Eat snack", ReadingTakesTime.rnEatSnackTime, "${0} Minute(s)")
		RNFoodMediumID = AddSliderOption("Eat medium meal", ReadingTakesTime.rnEatMediumTime, "${0} Minute(s)")
		RNFoodFillingID = AddSliderOption("Eat filling meal", ReadingTakesTime.rnEatFillingTime, "${0} Minute(s)")
		RNWaterDrinkID = AddSliderOption("Drink water", ReadingTakesTime.rnDrinkTime, "${0} Minute(s)")
		RNCookSnackID = AddSliderOption("Cook snack", ReadingTakesTime.rnCookSnackTime, "${0} Minute(s)")
		RNCookMediumID = AddSliderOption("Cook medium meal", ReadingTakesTime.rnCookMediumTime, "${0} Minute(s)")
		RNCookFillingID = AddSliderOption("Cook filling meal", ReadingTakesTime.rnCookFillingTime, "${0} Minute(s)")
		RNBrewDrinkID = AddSliderOption("Brew drink", ReadingTakesTime.rnBrewTime, "${0} Minute(s)")
		RNWaterPrepID = AddSliderOption("Prep water", ReadingTakesTime.rnWaterPrepTime, "${0} Minute(s)")
		RNSaltID = AddSliderOption("Create salt", ReadingTakesTime.rnSaltTime, "${1} hour(s)")
	
	ElseIf page == "Hunterborn"
		SetCursorFillMode(TOP_TO_BOTTOM)
		If !isHBActive
			AddTextOption("", "Hunterborn is not active.")
			Return
		EndIf
		AddHeaderOption("Scrimshaw")
		HBScrimBitsID = AddSliderOption("Bone bits", ReadingTakesTime.hbScrimBitsTime, "${0} Minute(s)")
		HBScrimIdolID = AddSliderOption("Idols", ReadingTakesTime.hbScrimIdolTime, "${1} hour(s)")
		HBScrimToolID = AddSliderOption("Tools", ReadingTakesTime.hbScrimToolTime, "${1} hour(s)")
		AddEmptyOption()
		AddHeaderOption("Leather")
		HBLeatherID = AddSliderOption("Leather (all sources)", ReadingTakesTime.hbLeatherTime, "${1} hour(s)")
		HBStripID = AddSliderOption("Leather strips (all sources)", ReadingTakesTime.hbStripTime, "${0} Minute(s)")
		SetCursorPosition(1)
		AddHeaderOption("Weapons and Armor")
		HBWeapArmorTipID = AddTextOption("", "Note on expertise")
		HBArrowsID = AddSliderOption("Arrows", ReadingTakesTime.hbArrowsTime, "${1} hour(s)")
		AddEmptyOption()
		AddHeaderOption("Misc")
		HBBedrollID = AddSliderOption("Hunter's bedroll", ReadingTakesTime.hbBedrollTime, "${1} hour(s)")
		HBIngrID = AddSliderOption("Ingredients", ReadingTakesTime.hbIngrTime, "${0} Minute(s)")
		HBBrewID = AddSliderOption("Brews", ReadingTakesTime.hbBrewTime, "${0} Minute(s)")
		HBTallowID = AddSliderOption("Tallow", ReadingTakesTime.hbTallowTime, "${0} Minute(s)")
	
	ElseIf page == "Lanterns, Candles"
		SetCursorFillMode(TOP_TO_BOTTOM)
		If !isWLActive
			AddTextOption("", "Wearable Lantern is not active.")
		Else
			AddHeaderOption("Wearable Lantern")
			WLLanternID = AddSliderOption("Travel lantern", ReadingTakesTime.wlWearableTime, "${0} Minute(s)")
			WLChassisID = AddSliderOption("Chassis", ReadingTakesTime.wlChassisTime, "${1} hour(s)")
			WLOilID = AddSliderOption("Lantern oil", ReadingTakesTime.wlOilTime, "${0} Minute(s)")
		EndIf
		SetCursorPosition(1)
		If !isLCActive
			AddTextOption("", "Lanterns and Candles is not active.")
		Else
			AddHeaderOption("Lanterns and Candles")
			LCBasicID = AddSliderOption("Basic", ReadingTakesTime.lcBasicTime, "${0} Minute(s)")
			LCForgeID = AddSliderOption("Forged", ReadingTakesTime.lcForgeTime, "${1} hour(s)")
			LCArcaneID = AddSliderOption("Arcane", ReadingTakesTime.lcArcaneTime, "${1} hour(s)")
			LCBrewID = AddSliderOption("Brew candle", ReadingTakesTime.lcBrewTime, "${0} Minute(s)")
		EndIf

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
	elseif ( option == CFFirecraftImprovesID )
		ReadingTakesTime.cfFirecraftImproves = !ReadingTakesTime.cfFirecraftImproves
		SetToggleOptionValue(CFFirecraftImprovesID, ReadingTakesTime.cfFirecraftImproves)
	endIf
endEvent

event OnOptionSliderOpen(int option)
	if (option == readMultID )
		SetSliderDialogStartValue(ReadingTakesTime.readMult)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.00, 4.00)
		SetSliderDialogInterval(0.05)
	
	elseif (option == showMessageThresholdID )
		SetSliderDialogStartValue(ReadingTakesTime.showMessageThreshold)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 59.0)
		SetSliderDialogInterval(1.0)
		
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
		
	ElseIf option == LightAmorID
		SetSliderDialogStartValue(ReadingTakesTime.lightArmorTime)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	
	ElseIf option == HeavyArmorID
		SetSliderDialogStartValue(ReadingTakesTime.heavyArmorTime)
		SetSliderDialogDefaultValue(45)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	
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
	
	; Campfire Camping Items
	ElseIf option == CFCloakID
		SetSliderDialogStartValue(ReadingTakesTime.cfCloakTime)
		SetSliderDialogDefaultValue(DEF_cfCloakTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFStickID
		SetSliderDialogStartValue(ReadingTakesTime.cfStickTime)
		SetSliderDialogDefaultValue(DEF_cfStickTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFTorchID
		SetSliderDialogStartValue(ReadingTakesTime.cfTorchTime)
		SetSliderDialogDefaultValue(DEF_cfTorchTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFCookpotID
		SetSliderDialogStartValue(ReadingTakesTime.cfCookpotTime)
		SetSliderDialogDefaultValue(DEF_cfCookpotTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFBackpackID
		SetSliderDialogStartValue(ReadingTakesTime.cfBackpackTime)
		SetSliderDialogDefaultValue(DEF_cfBackpackTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFBeddingID
		SetSliderDialogStartValue(ReadingTakesTime.cfBeddingTime)
		SetSliderDialogDefaultValue(DEF_cfBeddingTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFSmallTentID
		SetSliderDialogStartValue(ReadingTakesTime.cfSmallTentTime)
		SetSliderDialogDefaultValue(DEF_cfSmallTentTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFLargeTentID
		SetSliderDialogStartValue(ReadingTakesTime.cfLargeTentTime)
		SetSliderDialogDefaultValue(DEF_cfLargeTentTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFHatchetID
		SetSliderDialogStartValue(ReadingTakesTime.cfHatchetTime)
		SetSliderDialogDefaultValue(DEF_cfHatchetTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFArrowsID
		SetSliderDialogStartValue(ReadingTakesTime.cfArrowsTime)
		SetSliderDialogDefaultValue(DEF_cfArrowsTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)

	; Campfire Materials
	ElseIf option == CFLinenID
		SetSliderDialogStartValue(ReadingTakesTime.cfLinenTime)
		SetSliderDialogDefaultValue(DEF_cfLinenTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFFurID
		SetSliderDialogStartValue(ReadingTakesTime.cfFurTime)
		SetSliderDialogDefaultValue(DEF_cfFurTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFLaceID
		SetSliderDialogStartValue(ReadingTakesTime.cfLaceTime)
		SetSliderDialogDefaultValue(DEF_cfLaceTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFTanRackID
		SetSliderDialogStartValue(ReadingTakesTime.cfTanRackTime)
		SetSliderDialogDefaultValue(DEF_cfTanRackTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFMortarID
		SetSliderDialogStartValue(ReadingTakesTime.cfMortarTime)
		SetSliderDialogDefaultValue(DEF_cfMortarTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == CFEnchID
		SetSliderDialogStartValue(ReadingTakesTime.cfEnchTime)
		SetSliderDialogDefaultValue(DEF_cfEnchTime)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)

	; Campfire Firecraft
	ElseIf option == CFMakeTinderID
		SetSliderDialogStartValue(ReadingTakesTime.cfMakeTinderTime)
		SetSliderDialogDefaultValue(DEF_cfMakeTinderTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFMakeKindlingID
		SetSliderDialogStartValue(ReadingTakesTime.cfMakeKindlingTime)
		SetSliderDialogDefaultValue(DEF_cfMakeKindlingTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFAddTinderID
		SetSliderDialogStartValue(ReadingTakesTime.cfAddTinderTime)
		SetSliderDialogDefaultValue(DEF_cfAddTinderTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFAddKindlingID
		SetSliderDialogStartValue(ReadingTakesTime.cfAddKindlingTime)
		SetSliderDialogDefaultValue(DEF_cfAddKindlingTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFLightFireID
		SetSliderDialogStartValue(ReadingTakesTime.cfLightFireTime)
		SetSliderDialogDefaultValue(DEF_cfLightFireTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == CFAddFuelID
		SetSliderDialogStartValue(ReadingTakesTime.cfAddFuelTime)
		SetSliderDialogDefaultValue(DEF_cfAddFuelTime)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	
	ElseIf option == FFSnowberryID
		SetSliderDialogStartValue(ReadingTakesTime.ffSnowberryTime)
		SetSliderDialogDefaultValue(DEF_Extract)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	
	ElseIf option == RNWaterskinID
		SetSliderDialogStartValue(ReadingTakesTime.rnWaterskinTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == RNCookpotID
		SetSliderDialogStartValue(ReadingTakesTime.rnCookpotTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == RNTinderboxID
		SetSliderDialogStartValue(ReadingTakesTime.rnTinderboxTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == RNBedrollID
		SetSliderDialogStartValue(ReadingTakesTime.rnBedrollTime)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == RNTentID
		SetSliderDialogStartValue(ReadingTakesTime.rnTentTime)
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == RNMilkBucketID
		SetSliderDialogStartValue(ReadingTakesTime.rnMilkBucketTime)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNFoodSnackID
		SetSliderDialogStartValue(ReadingTakesTime.rnEatSnackTime)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNFoodMediumID
		SetSliderDialogStartValue(ReadingTakesTime.rnEatMediumTime)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNFoodFillingID
		SetSliderDialogStartValue(ReadingTakesTime.rnEatFillingTime)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNWaterDrinkID
		SetSliderDialogStartValue(ReadingTakesTime.rnDrinkTime)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNCookSnackID
		SetSliderDialogStartValue(ReadingTakesTime.rnCookSnackTime)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNCookMediumID
		SetSliderDialogStartValue(ReadingTakesTime.rnCookMediumTime)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNCookFillingID
		SetSliderDialogStartValue(ReadingTakesTime.rnCookFillingTime)
		SetSliderDialogDefaultValue(45)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNBrewDrinkID
		SetSliderDialogStartValue(ReadingTakesTime.rnBrewTime)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNWaterPrepID
		SetSliderDialogStartValue(ReadingTakesTime.rnWaterPrepTime)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == RNSaltID
		SetSliderDialogStartValue(ReadingTakesTime.rnSaltTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)

	ElseIf option == HBScrimBitsID
		SetSliderDialogStartValue(ReadingTakesTime.hbScrimBitsTime)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == HBScrimIdolID
		SetSliderDialogStartValue(ReadingTakesTime.hbScrimIdolTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == HBScrimToolID
		SetSliderDialogStartValue(ReadingTakesTime.hbScrimToolTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == HBLeatherID
		SetSliderDialogStartValue(ReadingTakesTime.hbLeatherTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == HBStripID
		SetSliderDialogStartValue(ReadingTakesTime.hbStripTime)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == HBBedrollID
		SetSliderDialogStartValue(ReadingTakesTime.hbBedrollTime)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == HBIngrID
		SetSliderDialogStartValue(ReadingTakesTime.hbIngrTime)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == HBBrewID
		SetSliderDialogStartValue(ReadingTakesTime.hbBrewTime)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == HBTallowID
		SetSliderDialogStartValue(ReadingTakesTime.hbTallowTime)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == HBArrowsID
		SetSliderDialogStartValue(ReadingTakesTime.hbArrowsTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
		
	ElseIf option == WLLanternID
		SetSliderDialogStartValue(ReadingTakesTime.wlWearableTime)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == WLChassisID
		SetSliderDialogStartValue(ReadingTakesTime.wlChassisTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == WLOilID
		SetSliderDialogStartValue(ReadingTakesTime.wlOilTime)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
		
	ElseIf option == LCBasicID
		SetSliderDialogStartValue(ReadingTakesTime.lcBasicTime)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	ElseIf option == LCForgeID
		SetSliderDialogStartValue(ReadingTakesTime.lcForgeTime)
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == LCArcaneID
		SetSliderDialogStartValue(ReadingTakesTime.lcArcaneTime)
		SetSliderDialogDefaultValue(6.0)
		SetSliderDialogRange(0.0, 24.0)
		SetSliderDialogInterval(0.1)
	ElseIf option == LCBrewID
		SetSliderDialogStartValue(ReadingTakesTime.lcBrewTime)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 60)
		SetSliderDialogInterval(1)
	
	endIf
endEvent


event OnOptionSliderAccept(int option, float value)
    if (option == readMultID )
        ReadingTakesTime.readMult = value
        SetSliderOptionValue(readMultID, ReadingTakesTime.readMult, "$x{2}")

    elseIf (option == showMessageThresholdID )
        ReadingTakesTime.showMessageThreshold = value as Int
        SetSliderOptionValue(showMessageThresholdID , ReadingTakesTime.showMessageThreshold)

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
		
	ElseIf option == LightAmorID
        ReadingTakesTime.lightArmorTime = value
        SetSliderOptionValue(LightAmorID, ReadingTakesTime.lightArmorTime, "${0} Minute(s)")

	ElseIf option == HeavyArmorID
        ReadingTakesTime.heavyArmorTime = value
        SetSliderOptionValue(HeavyArmorID, ReadingTakesTime.heavyArmorTime, "${0} Minute(s)")

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
	
	; Campfire Camping Items
	ElseIf option == CFCloakID
		ReadingTakesTime.cfCloakTime = value
		SetSliderOptionValue(CFCloakID, ReadingTakesTime.cfCloakTime, "${1} hour(s)")
	ElseIf option == CFStickID
		ReadingTakesTime.cfStickTime = value
		SetSliderOptionValue(CFStickID, ReadingTakesTime.cfStickTime, "${0} Minute(s)")
	ElseIf option == CFTorchID
		ReadingTakesTime.cfTorchTime = value
		SetSliderOptionValue(CFTorchID, ReadingTakesTime.cfTorchTime, "${0} Minute(s)")
	ElseIf option == CFCookpotID
		ReadingTakesTime.cfCookpotTime = value
		SetSliderOptionValue(CFCookpotID, ReadingTakesTime.cfCookpotTime, "${1} hour(s)")
	ElseIf option == CFBackpackID
		ReadingTakesTime.cfBackpackTime = value
		SetSliderOptionValue(CFBackpackID, ReadingTakesTime.cfBackpackTime, "${1} hour(s)")
	ElseIf option == CFBeddingID
		ReadingTakesTime.cfBeddingTime = value
		SetSliderOptionValue(CFBeddingID, ReadingTakesTime.cfBeddingTime, "${1} hour(s)")
	ElseIf option == CFSmallTentID
		ReadingTakesTime.cfSmallTentTime = value
		SetSliderOptionValue(CFSmallTentID, ReadingTakesTime.cfSmallTentTime, "${1} hour(s)")
	ElseIf option == CFLargeTentID
		ReadingTakesTime.cfLargeTentTime = value
		SetSliderOptionValue(CFLargeTentID, ReadingTakesTime.cfLargeTentTime, "${1} hour(s)")
	ElseIf option == CFHatchetID
		ReadingTakesTime.cfHatchetTime = value
		SetSliderOptionValue(CFHatchetID, ReadingTakesTime.cfHatchetTime, "${0} Minute(s)")
	ElseIf option == CFArrowsID
		ReadingTakesTime.cfArrowsTime = value
		SetSliderOptionValue(CFArrowsID, ReadingTakesTime.cfArrowsTime, "${1} hour(s)")
		
	; Campfire Materials
	ElseIf option == CFLinenID
		ReadingTakesTime.cfLinenTime = value
		SetSliderOptionValue(CFLinenID, ReadingTakesTime.cfLinenTime, "${0} Minute(s)")
	ElseIf option == CFFurID
		ReadingTakesTime.cfFurTime = value
		SetSliderOptionValue(CFFurID, ReadingTakesTime.cfFurTime, "${1} hour(s)")
	ElseIf option == CFLaceID
		ReadingTakesTime.cfLaceTime = value
		SetSliderOptionValue(CFLaceID, ReadingTakesTime.cfLaceTime, "${0} Minute(s)")
	ElseIf option == CFTanRackID
		ReadingTakesTime.cfTanRackTime = value
		SetSliderOptionValue(CFTanRackID, ReadingTakesTime.cfTanRackTime, "${0} Minute(s)")
	ElseIf option == CFMortarID
		ReadingTakesTime.cfMortarTime = value
		SetSliderOptionValue(CFMortarID, ReadingTakesTime.cfMortarTime, "${1} hour(s)")
	ElseIf option == CFEnchID
		ReadingTakesTime.cfEnchTime = value
		SetSliderOptionValue(CFEnchID, ReadingTakesTime.cfEnchTime, "${1} hour(s)")

	; Campfire Firecraft
	ElseIf option == CFMakeTinderID
		ReadingTakesTime.cfMakeTinderTime = value
		SetSliderOptionValue(CFMakeTinderID, ReadingTakesTime.cfMakeTinderTime, "${0} Minute(s)")
	ElseIf option == CFMakeKindlingID
		ReadingTakesTime.cfMakeKindlingTime = value
		SetSliderOptionValue(CFMakeKindlingID, ReadingTakesTime.cfMakeKindlingTime, "${0} Minute(s)")
	ElseIf option == CFAddTinderID
		ReadingTakesTime.cfAddTinderTime = value
		SetSliderOptionValue(CFAddTinderID, ReadingTakesTime.cfAddTinderTime, "${0} Minute(s)")
	ElseIf option == CFAddKindlingID
		ReadingTakesTime.cfAddKindlingTime = value
		SetSliderOptionValue(CFAddKindlingID, ReadingTakesTime.cfAddKindlingTime, "${0} Minute(s)")
	ElseIf option == CFLightFireID
		ReadingTakesTime.cfLightFireTime = value
		SetSliderOptionValue(CFLightFireID, ReadingTakesTime.cfLightFireTime, "${0} Minute(s)")
	ElseIf option == CFAddFuelID
		ReadingTakesTime.cfAddFuelTime = value
		SetSliderOptionValue(CFAddFuelID, ReadingTakesTime.cfAddFuelTime, "${0} Minute(s)")

	ElseIf option == FFSnowberryID
		ReadingTakesTime.ffSnowberryTime = value
		SetSliderOptionValue(FFSnowBerryID, ReadingTakesTime.ffSnowberryTime, "${0} Minute(s)")

	ElseIf option == RNWaterskinID
		ReadingTakesTime.rnWaterskinTime = value
        SetSliderOptionValue(RNWaterskinID, ReadingTakesTime.rnWaterskinTime, "${1} hour(s)")
	ElseIf option == RNCookpotID
		ReadingTakesTime.rnCookpotTime = value
        SetSliderOptionValue(RNCookpotID, ReadingTakesTime.rnCookpotTime, "${1} hour(s)")
	ElseIf option == RNTinderboxID
		ReadingTakesTime.rnTinderboxTime = value
        SetSliderOptionValue(RNTinderboxID, ReadingTakesTime.rnTinderboxTime, "${1} hour(s)")
	ElseIf option == RNBedrollID
		ReadingTakesTime.rnBedrollTime = value
        SetSliderOptionValue(RNBedrollID, ReadingTakesTime.rnBedrollTime, "${1} hour(s)")
	ElseIf option == RNTentID
		ReadingTakesTime.rnTentTime = value
        SetSliderOptionValue(RNTentID, ReadingTakesTime.rnTentTime, "${1} hour(s)")
	ElseIf option == RNMilkBucketID
		ReadingTakesTime.rnMilkBucketTime = value
        SetSliderOptionValue(RNMilkBucketID, ReadingTakesTime.rnMilkBucketTime, "${0} Minute(s)")
	ElseIf option == RNFoodSnackID
		ReadingTakesTime.rnEatSnackTime = value
        SetSliderOptionValue(RNFoodSnackID, ReadingTakesTime.rnEatSnackTime, "${0} Minute(s)")
	ElseIf option == RNFoodMediumID
		ReadingTakesTime.rnEatMediumTime = value
        SetSliderOptionValue(RNFoodMediumID, ReadingTakesTime.rnEatMediumTime, "${0} Minute(s)")
	ElseIf option == RNFoodFillingID
		ReadingTakesTime.rnEatFillingTime = value
        SetSliderOptionValue(RNFoodFillingID, ReadingTakesTime.rnEatFillingTime, "${0} Minute(s)")
	ElseIf option == RNWaterDrinkID
		ReadingTakesTime.rnDrinkTime = value
        SetSliderOptionValue(RNWaterDrinkID, ReadingTakesTime.rnDrinkTime, "${0} Minute(s)")
	ElseIf option == RNCookSnackID
		ReadingTakesTime.rnCookSnackTime = value
        SetSliderOptionValue(RNCookSnackID, ReadingTakesTime.rnCookSnackTime, "${0} Minute(s)")
	ElseIf option == RNCookMediumID
		ReadingTakesTime.rnCookMediumTime = value
        SetSliderOptionValue(RNCookMediumID, ReadingTakesTime.rnCookMediumTime, "${0} Minute(s)")
	ElseIf option == RNCookFillingID
		ReadingTakesTime.rnCookFillingTime = value
        SetSliderOptionValue(RNCookFillingID, ReadingTakesTime.rnCookFillingTime, "${0} Minute(s)")
	ElseIf option == RNBrewDrinkID
		ReadingTakesTime.rnBrewTime = value
        SetSliderOptionValue(RNBrewDrinkID, ReadingTakesTime.rnBrewTime, "${0} Minute(s)")
	ElseIf option == RNWaterPrepID
		ReadingTakesTime.rnWaterPrepTime = value
        SetSliderOptionValue(RNWaterPrepID, ReadingTakesTime.rnWaterPrepTime, "${0} Minute(s)")
	ElseIf option == RNSaltID
		ReadingTakesTime.rnSaltTime = value
        SetSliderOptionValue(RNSaltID, ReadingTakesTime.rnSaltTime, "${1} hour(s)")
	
	ElseIf option == HBScrimBitsID
		ReadingTakesTime.hbScrimBitsTime = value
        SetSliderOptionValue(HBScrimBitsID, ReadingTakesTime.hbScrimBitsTime, "${0} Minute(s)")
	ElseIf option == HBScrimIdolID
		ReadingTakesTime.hbScrimIdolTime = value
        SetSliderOptionValue(HBScrimIdolID, ReadingTakesTime.hbScrimIdolTime, "${1} hour(s)")
	ElseIf option == HBScrimToolID
		ReadingTakesTime.hbScrimToolTime = value
        SetSliderOptionValue(HBScrimToolID, ReadingTakesTime.hbScrimToolTime, "${1} hour(s)")
	ElseIf option == HBLeatherID
		ReadingTakesTime.hbLeatherTime = value
        SetSliderOptionValue(HBLeatherID, ReadingTakesTime.hbLeatherTime, "${1} hour(s)")
	ElseIf option == HBStripID
		ReadingTakesTime.hbStripTime = value
        SetSliderOptionValue(HBStripID, ReadingTakesTime.hbStripTime, "${0} Minute(s)")
	ElseIf option == HBBedrollID
		ReadingTakesTime.hbBedrollTime = value
        SetSliderOptionValue(HBBedrollID, ReadingTakesTime.hbBedrollTime, "${1} hour(s)")
	ElseIf option == HBIngrID
		ReadingTakesTime.hbIngrTime = value
        SetSliderOptionValue(HBIngrID, ReadingTakesTime.hbIngrTime, "${0} Minute(s)")
	ElseIf option == HBBrewID
		ReadingTakesTime.hbBrewTime = value
        SetSliderOptionValue(HBBrewID, ReadingTakesTime.hbBrewTime, "${0} Minute(s)")
	ElseIf option == HBTallowID
		ReadingTakesTime.hbTallowTime = value
        SetSliderOptionValue(HBTallowID, ReadingTakesTime.hbTallowTime, "${0} Minute(s)")
	ElseIf option == HBArrowsID
		ReadingTakesTime.hbArrowsTime = value
        SetSliderOptionValue(HBArrowsID, ReadingTakesTime.hbArrowsTime, "${1} hour(s)")
		
	ElseIf option == WLLanternID
		ReadingTakesTime.wlWearableTime = value
        SetSliderOptionValue(WLLanternID, ReadingTakesTime.wlWearableTime, "${0} Minute(s)")
	ElseIf option == WLChassisID
		ReadingTakesTime.wlChassisTime = value
        SetSliderOptionValue(WLChassisID, ReadingTakesTime.wlChassisTime, "${1} hour(s)")
	ElseIf option == WLOilID
		ReadingTakesTime.wlOilTime = value
        SetSliderOptionValue(WLOilID, ReadingTakesTime.wlOilTime, "${0} Minute(s)")

	ElseIf option == LCBasicID
		ReadingTakesTime.lcBasicTime = value
        SetSliderOptionValue(LCBasicID, ReadingTakesTime.lcBasicTime, "${0} Minute(s)")
	ElseIf option == LCForgeID
		ReadingTakesTime.lcForgeTime = value
        SetSliderOptionValue(LCForgeID, ReadingTakesTime.lcForgeTime, "${1} hour(s)")
	ElseIf option == LCArcaneID
		ReadingTakesTime.lcArcaneTime = value
        SetSliderOptionValue(LCArcaneID, ReadingTakesTime.lcArcaneTime, "${1} hour(s)")
	ElseIf option == LCBrewID
		ReadingTakesTime.lcBrewTime = value
        SetSliderOptionValue(LCBrewID, ReadingTakesTime.lcBrewTime, "${0} Minute(s)")

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

event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
	
	DebugMode("OnOptionKeyMapChange a_option = " + a_option + " ; a_keyCode = " + a_keyCode + " ; a_conflictControl = " + a_conflictControl + " ; a_conflictName = " + a_conflictName)
	
	If (a_conflictControl != "")
		If (a_conflictName != "")
			ShowMessage("This key is already mapped to " + a_conflictControl + " in " + a_conflictName + ". Please choose a different key.")
		Else
			ShowMessage("This key is already mapped to " + a_conflictControl + " in Skyrim. Please choose a different key.")
		EndIf
		Return
	EndIf
	
	If (a_option == hotkeySuspendID)
		DebugMode("Registered to HotkeySuspend.")
		ReadingTakesTime.hotkeySuspend = a_keyCode
	Else
		DebugMode("No matching registration.")
		Return
	EndIf

	RegisterForKey(a_keyCode)
	ForcePageReset()
	
endEvent

event OnOptionHighlight(int option)
	if (option == isModActiveID )
		SetInfoText("$Activate or deactivate the mod.")
	elseif (option == isReadingActiveID || option == isCraftingActiveID || option == isContainerActiveID || option == isLockpickActiveID || option == isTrainingActiveID|| option == isLevelUpActiveID|| option == isInventoryActiveID|| option == isMagicActiveID|| option == isJournalActiveID|| option == isMapActiveID|| option == isBarterActiveID|| option == isGiftActiveID)
		SetInfoText("$Activate or deactivate this module.")
	ElseIf option == showMessageThresholdID
		SetInfoText("Notification of time passed only displayed if at least this many minutes have passed.")
	elseif (option == readMultID|| option == lootMultID|| option == pickMultID|| option == pickpocketMultID|| option == trainingMultID|| option == levelUpMultID|| option == inventoryMultID|| option == magicMultID|| option == journalMultID|| option == mapMultID|| option == barterMultID|| option == giftMultID)
		SetInfoText("$Multiplier used to calculate the time spent in this menu.")
	elseif (option == spellLearnTimeID|| option == headCraftTimeID|| option == armorCraftTimeID|| option == handsCraftTimeID|| option == feetCraftTimeID|| option == shieldCraftTimeID|| option == jewelryCraftTimeID|| option == battleAxeCraftTimeID|| option == bowCraftTimeID|| option == daggerCraftTimeID|| option == greatswordCraftTimeID|| option == maceCraftTimeID|| option == staffCraftTimeID|| option == swordCraftTimeID|| option == warhammerCraftTimeID|| option == warAxeCraftTimeID|| option == weaponCraftTimeID|| option == miscCraftTimeID|| option == armorImproveTimeID|| option == weaponImproveTimeID|| option == potionCraftTimeID|| option == enchantingTimeID|| option == trainingTimeID|| option == levelUpTimeID|| option == eatTimeID)
		SetInfoText("$Time spent when performing this action.")
	ElseIf option == hotkeySuspendID
		SetInfoText("Set a hotkey to suspend / resume the mod.")
	ElseIf option == LightAmorID
		SetInfoText("Additional time spent when stripping a corpse of a light armor cuirass.")
	ElseIf option == HeavyArmorID
		SetInfoText("Additional time spent when stripping a corpse of a heavy armor cuirass.")
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
		
	; Campfire Camping
	ElseIf option == CFCloakID
		SetInfoText("Time spent to craft any of the Frostfall cloaks.")
	ElseIf option == CFStickID
		SetInfoText("Time spent to craft a walking stick.")
	ElseIf option == CFTorchID
		SetInfoText("Time spent to create one torch.")
	ElseIf option == CFCookpotID
		SetInfoText("Time spent at the forge to craft a steel cookpot.")
	ElseIf option == CFBackpackID
		SetInfoText("Time spent to craft any of the Frostfall backpacks. Modifying backpacks costs no time.")
	ElseIf option == CFBeddingID
		SetInfoText("Time spent on bedrolls for tents, rough bedding takes half this time.")
	ElseIf option == CFSmallTentID
		SetInfoText("Time spent to create any small tent.")
	ElseIf option == CFLargeTentID
		SetInfoText("Time spent to create any large tent.")
	ElseIf option == CFHatchetID
		SetInfoText("Time spent to craft a stone hatchet.")
	ElseIf option == CFArrowsID
		SetInfoText("Time spent to craft a batch (24) of stone arrows.")
	
	; Campfire Materials
	ElseIf option == CFLinenID
		SetInfoText("Time spent to make one linen wrap. Multiplied when crafting several.")
	ElseIf option == CFFurID
		SetInfoText("Time spent to create any single fur plate. Multiplied when crafting several.")
	ElseIf option == CFLaceID
		SetInfoText("Time spent to produce a string of hide lace. Multiplied when crafting several.")
	ElseIf option == CFTanRackID
		SetInfoText("Time spent to assemble a tanning rack.")
	ElseIf option == CFMortarID
		SetInfoText("Time spent to craft a mortar and pestle, including Hunterborn's Scrimshaw recipe.")
	ElseIf option == CFEnchID
		SetInfoText("Time spent to craft a set of enchanting supplies.")
	
	; Campfire Firecraft
	ElseIf option == CFFirecraftImprovesID
		SetInfoText("Should the Firecraft perk of Campfire speed up the firecraft times at 20% off for each rank.\nDoes not help lighting with a torch or spell.")
	ElseIf option == CFMakeTinderID
		SetInfoText("Time spent making tinder from everyday objects.")
	ElseIf option == CFMakeKindlingID
		SetInfoText("Time spent making kindling from everyday objects.")
	ElseIf option == CFAddTinderID
		SetInfoText("Time spent prepping tinder on the campfire.")
	ElseIf option == CFAddKindlingID
		SetInfoText("Time spent arranging kindling on the campfire.")
	ElseIf option == CFLightFireID
		SetInfoText("Time spent trying to spark the fire.\nSpells and torches take one quarter this time.")
	ElseIf option == CFAddFuelID
		SetInfoText("Time spent tending to the fire, to replenish fuel or make it bigger.")

	ElseIf option == FFSnowberryID
		SetInfoText("Time spent making snowberry extract.")

	ElseIf option == RNWaterskinID
		SetInfoText("Time spent to craft a waterskin, including Hunterborn's recipe.")
	ElseIf option == RNCookpotID
		SetInfoText("Time spent to craft a cast iron pot at the forge.")
	ElseIf option == RNTinderboxID
		SetInfoText("Time spent to forge and assemble a tinderbox.")
	ElseIf option == RNBedrollID
		SetInfoText("Time spent to craft a traveller's bedroll.")
	ElseIf option == RNTentID
		SetInfoText("Time spent to craft a traveller's tent.")
	ElseIf option == RNMilkBucketID
		SetInfoText("Time spent preparing a common bucket for use as a milk bucket, at the tanning rack.")
	ElseIf option == RNFoodSnackID
		SetInfoText("Time spent eating a snack, or candy or fruit. Compatible with any food patched to have RND effects.")
	ElseIf option == RNFoodMediumID
		SetInfoText("Time spent eating a medium size meal. Compatible with any food patched to have RND effects.")
	ElseIf option == RNFoodFillingID
		SetInfoText("Time spent eating a filling meal. Compatible with any food patched to have RND effects.")
	ElseIf option == RNWaterDrinkID
		SetInfoText("Time spent consuming one drink. Compatible with any beverage patched to have RND effects.")
	ElseIf option == RNCookSnackID
		SetInfoText("Time spent to cook a snack. Compatible with any food patched to have RND effects. Batches take no extra time.")
	ElseIf option == RNCookMediumID
		SetInfoText("Time spent to cook a medium size meal. Compatible with any food patched to have RND effects. Batches take no extra time.")
	ElseIf option == RNCookFillingID
		SetInfoText("Time spent to cook a filling meal. Compatible with any food patched to have RND effects. Batches take no extra time.")
	ElseIf option == RNBrewDrinkID
		SetInfoText("Time spent to brew any drink, besides plain water. Compatible with any beverage patched to have RND effects. Batches take no extra time.")
	ElseIf option == RNWaterPrepID
		SetInfoText("Time spent at the cookpot to prepare water from any source. This includes boiling water, or changing from a waterskin to water for cooking.")
	ElseIf option == RNSaltID
		SetInfoText("Time spent boiling down sea water into a salt pile.")
	
	ElseIf option == HBScrimBitsID
		SetInfoText("Time spent to scrimshaw one set of bone bits. Multiplied when crafting several. Harvesting level reduces time taken.")
	ElseIf option == HBScrimIdolID
		SetInfoText("Time spent to scrimshaw various idol-like artifacts. Harvesting level reduces time taken.")
	ElseIf option == HBScrimToolID
		SetInfoText("Time spent to scrimshaw various tools. Harvesting level reduces time taken.")
	ElseIf option == HBLeatherID
		SetInfoText("Time spent to craft 1 piece of leather. Applies to tanning rack AND all other sources, such as armor breakdown. Harvesting level reduces time taken.")
	ElseIf option == HBStripID
		SetInfoText("Time spent to craft 3 leather strips. Applies to ANY source of leather strips. Harvesting level reduces time taken.")
	ElseIf option == HBWeapArmorTipID
		SetInfoText("Scrimshaw's weapons and armors use the times set in Crafting, but use Harvesting level to reduce time taken, not Smithing.")
	ElseIf option == HBBedrollID
		SetInfoText("Time spent to craft a hunter's bedroll, at the tanning rack. Harvesting level reduces time taken.")
	ElseIf option == HBIngrID
		SetInfoText("Time spent to rework certain ingredients, such as polished eyes. Harvesting level reduces time taken.")
	ElseIf option == HBBrewID
		SetInfoText("Time spent when brewing any of Hunterborn's custom potions at the cookpot.")
	ElseIf option == HBTallowID
		SetInfoText("Time spent to craft each piece of tallow. Used only in the Hunterborn + Lanterns and Candles patch.")
	ElseIf option == HBArrowsID
		SetInfoText("Time spent to craft a batch of arrows with Scrimshaw. Same time for either 24 with firewood, or 12 with animal bones.")
		
	ElseIf option == WLLanternID
		SetInfoText("Make a lantern wearable by attaching a leather strip. Done at the forge, but not considered smithing.")
	ElseIf option == WLChassisID
		SetInfoText("Craft a lantern chassis at a forge. It can then be converted into a wearable lantern.")
	ElseIf option == WLOilID
		SetInfoText("Crafting lantern oil is possible with other mods, such as Hunterborn.")

	ElseIf option == LCBasicID
		SetInfoText("Simple assembly, like a candle in a wine bottle. Done at the forge, but not considered smithing.")
	ElseIf option == LCForgeID
		SetInfoText("Wrought iron work done at a forge, such as lanterns and shrines.")
	ElseIf option == LCArcaneID
		SetInfoText("Sophisticated works requiring skill as an arcane blacksmith, such as a wizard's lamp.")
	ElseIf option == LCBrewID
		SetInfoText("Time spent to sculpt one candle at the cookpot. Multiplied when crafting several.")
		
	endIf
endEvent


Event OnKeyUp(int keyCode, float holdTime)

	;DebugMode("OnKeyUp = " + keyCode)
	
	If !isModActive
		UnregisterForAllKeys()
		Return
	EndIf
	
	If (UI.IsMenuOpen("Console") || Utility.IsInMenuMode() || Game.GetPlayer().GetSitState() != 0)
		; Ignore keystrokes in the console or at furniture (like naming an enchanted object)
		
	ElseIf (keyCode == ReadingTakesTime.hotkeySuspend)
		ReadingTakesTime.Suspended = !ReadingTakesTime.Suspended
		If ReadingTakesTime.Suspended
			Debug.Notification("Living Takes Time suspended.")
		Else
			Debug.Notification("Living Takes Time resumed.")
		EndIf
		
	Else
		UnregisterForKey(keyCode)
	
	EndIf

EndEvent

string Function GetCustomControl(int keyCode)

	;DebugMode("GetCustomControl = " + keyCode)
	
	If (keyCode == ReadingTakesTime.hotkeySuspend)
		Return "Suspend/Resume"
	Else
		Return ""
	EndIf
	
EndFunction

Function ReassignHotKeys()

	ReassignHotkey(ReadingTakesTime.hotkeySuspend, "HotkeySuspend")

EndFunction

Function ReassignHotkey(int aiKeyCode, string akName)
	If aiKeyCode
		RegisterForKey(aiKeyCode)
		;DebugMode("Hotkey " + aiKeyCode + " registrationg refresh for " + akName + ".")
	EndIf
EndFunction

; Default time values for extra mods, FF / HB / WL / LaC
Function SetModDefaults()

	ReadingTakesTime.cfCloakTime = DEF_cfCloakTime
	ReadingTakesTime.cfStickTime = DEF_cfStickTime
	ReadingTakesTime.cfTorchTime = DEF_cfTorchTime
	ReadingTakesTime.cfCookpotTime = DEF_cfCookpotTime
	ReadingTakesTime.cfBackpackTime = DEF_cfBackpackTime
	ReadingTakesTime.cfBeddingTime = DEF_cfBeddingTime
	ReadingTakesTime.cfSmallTentTime = DEF_cfSmallTentTime
	ReadingTakesTime.cfLargeTentTime = DEF_cfLargeTentTime
	ReadingTakesTime.cfHatchetTime = DEF_cfHatchetTime
	ReadingTakesTime.cfArrowsTime = DEF_cfArrowsTime

	ReadingTakesTime.cfLinenTime = DEF_cfLinenTime
	ReadingTakesTime.cfFurTime = DEF_cfFurTime
	ReadingTakesTime.cfLaceTime = DEF_cfLaceTime
	ReadingTakesTime.cfTanRackTime = DEF_cfTanRackTime
	ReadingTakesTime.cfMortarTime = DEF_cfMortarTime
	ReadingTakesTime.cfEnchTime = DEF_cfEnchTime

	ReadingTakesTime.cfFirecraftImproves = DEF_cfFirecraftImproves
	ReadingTakesTime.cfMakeTinderTime = DEF_cfMakeTinderTime
	ReadingTakesTime.cfMakeKindlingTime = DEF_cfMakeKindlingTime
	ReadingTakesTime.cfAddTinderTime = DEF_cfAddTinderTime
	ReadingTakesTime.cfAddKindlingTime = DEF_cfAddKindlingTime
	ReadingTakesTime.cfLightFireTime = DEF_cfLightFireTime
	ReadingTakesTime.cfAddFuelTime = DEF_cfAddFuelTime

	ReadingTakesTime.ffSnowberryTime = DEF_Extract

	ReadingTakesTime.rnWaterskinTime = 2
	ReadingTakesTime.rnCookpotTime = 1
	ReadingTakesTime.rnTinderboxTime = 2
	ReadingTakesTime.rnBedrollTime = 3
	ReadingTakesTime.rnTentTime = 4
	ReadingTakesTime.rnMilkBucketTime = 5
	ReadingTakesTime.rnEatSnackTime = 2
	ReadingTakesTime.rnEatMediumTime = 10
	ReadingTakesTime.rnEatFillingTime = 30
	ReadingTakesTime.rnDrinkTime = 2
	ReadingTakesTime.rnCookSnackTime = 10
	ReadingTakesTime.rnCookMediumTime = 20
	ReadingTakesTime.rnCookFillingTime = 45
	ReadingTakesTime.rnBrewTime = 15
	ReadingTakesTime.rnWaterPrepTime = 5
	ReadingTakesTime.rnSaltTime = 2
	
	ReadingTakesTime.hbLeatherTime = 1
	ReadingTakesTime.hbStripTime = 30
	ReadingTakesTime.hbScrimBitsTime = 5
	ReadingTakesTime.hbTallowTime = 10
	ReadingTakesTime.hbIngrTime = 30
	ReadingTakesTime.hbBrewTime = 30
	ReadingTakesTime.hbScrimIdolTime = 2
	ReadingTakesTime.hbScrimToolTime = 1
	ReadingTakesTime.hbBedrollTime = 3
	ReadingTakesTime.hbArrowsTime = 1
	
	ReadingTakesTime.wlWearableTime = 30
	ReadingTakesTime.wlChassisTime = 2
	ReadingTakesTime.wlOilTime = 30
	
	ReadingTakesTime.lcBasicTime = 10
	ReadingTakesTime.lcForgeTime = 3
	ReadingTakesTime.lcArcaneTime = 6
	ReadingTakesTime.lcBrewTime = 15

EndFunction

Function DebugMode(string sMsg)
	Debug.Trace("[RTT_Menu] " + sMsg)
EndFunction
