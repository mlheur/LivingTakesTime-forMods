scriptName RTT_Menu extends SKI_ConfigBase

;-- Properties --------------------------------------
Float property DEF_Extract
	Float function get()

		return 15.0000
	endFunction
endproperty
Float property DEF_cfMakeKindlingTime
	Float function get()

		return 5.00000
	endFunction
endproperty
Float property DEF_cfAddFuelTime
	Float function get()

		return 5.00000
	endFunction
endproperty
rtt property ReadingTakesTime auto
Bool property DEF_cfFirecraftImproves
	Bool function get()

		return true
	endFunction
endproperty
Float property DEF_cfMortarTime
	Float function get()

		return 2.00000
	endFunction
endproperty
Float property DEF_cfBackpackTime
	Float function get()

		return 2.00000
	endFunction
endproperty
Float property DEF_cfAddKindlingTime
	Float function get()

		return 10.0000
	endFunction
endproperty
Float property DEF_cfTanRackTime
	Float function get()

		return 45.0000
	endFunction
endproperty
Float property DEF_cfFurTime
	Float function get()

		return 1.00000
	endFunction
endproperty
Float property DEF_cfEnchTime
	Float function get()

		return 1.00000
	endFunction
endproperty
Float property DEF_cfLinenTime
	Float function get()

		return 15.0000
	endFunction
endproperty
Float property DEF_cfLightFireTime
	Float function get()

		return 25.0000
	endFunction
endproperty
Float property DEF_cfHatchetTime
	Float function get()

		return 45.0000
	endFunction
endproperty
Float property DEF_cfAddTinderTime
	Float function get()

		return 15.0000
	endFunction
endproperty
Float property DEF_cfLaceTime
	Float function get()

		return 30.0000
	endFunction
endproperty
Float property DEF_cfStickTime
	Float function get()

		return 45.0000
	endFunction
endproperty
Float property DEF_cfCloakTime
	Float function get()

		return 1.00000
	endFunction
endproperty
Float property DEF_cfMakeTinderTime
	Float function get()

		return 15.0000
	endFunction
endproperty
Float property DEF_cfArrowsTime
	Float function get()

		return 1.00000
	endFunction
endproperty
Float property DEF_cfTorchTime
	Float function get()

		return 15.0000
	endFunction
endproperty
Float property DEF_cfBeddingTime
	Float function get()

		return 3.00000
	endFunction
endproperty
Float property DEF_cfLargeTentTime
	Float function get()

		return 6.00000
	endFunction
endproperty
Float property DEF_cfSmallTentTime
	Float function get()

		return 4.00000
	endFunction
endproperty
Float property DEF_cfCookpotTime
	Float function get()

		return 2.00000
	endFunction
endproperty

;-- Variables ---------------------------------------
Int CFSmallTentID
Int WLLanternID
Int CFAddKindlingID
Bool isInventoryActive = true
Int HBBrewID
Int greatswordCraftTimeID
Bool isContainerActive = true
Int RNWaterskinID
Int isGiftActiveID
Int battleAxeCraftTimeID
Int isModActiveID
Int RNFoodFillingID
Int loadID
Int isJournalActiveID
Int readingIncreasesSpeechID
Bool isJournalActive = true
Int CFMakeKindlingID
Int potionCraftTimeID
Int CFCloakID
Int showMessageThresholdID
Int CFBeddingID
Int headCraftTimeID
Int isLevelUpActiveID
Int isBarterActiveID
Int warAxeCraftTimeID
Int mapMultID
Int RNBedrollID
Int trainingTimeID
Int lootMultID
Int weaponCraftTimeID
Int daggerCraftTimeID
Int CFBackpackID
Int CFStickID
Int RNFoodSnackID
Int CFFurID
Int bowCraftTimeID
Int HBScrimToolID
Int isMagicActiveID
Bool isTrainingActive = true
Int RNTinderboxID
Int RNWaterPrepID
Int isTrainingActiveID
Int CFFirecraftImprovesID
Int RNSaltID
Int cantInventoryID
Int levelUpMultID
Bool isLevelUpActive = true
Int isInventoryActiveID
Int RNMilkBucketID
Bool isMapActive = true
Int WLChassisID
Int CFEnchID
Int staffCraftTimeID
Int isReadingActiveID
Int levelUpTimeID
Bool isCraftingActive = true
Int HeavyArmorID
Int HBTallowID
Int magicMultID
Int inventoryMultID
Int swordCraftTimeID
Int RNFoodMediumID
Int cantJournalID
Int weaponImproveTimeID
Int cantLootID
Int cantLevelUpID
Int HBScrimBitsID
Int expertiseReducesTimeID
Int CFCookpotID
Int CFArrowsID
Int RNTentID
Int HBIngrID
Int pickMultID
Int RNBrewDrinkID
Int HBWeapArmorTipID
Int LightAmorID
Int CFTanRackID
Int isCraftingActiveID
Int LCBasicID
Int HBStripID
Int FFSnowberryID
Bool isLockpickActive = true
Int HBScrimIdolID
Int RNCookSnackID
Int maceCraftTimeID
Bool isModActive = false
Int HBArrowsID
Int trainingMultID
Int cantPickID
Int HBBedrollID
Int LCBrewID
Int miscCraftTimeID
Int shieldCraftTimeID
Int LCForgeID
Bool isBarterActive = true
Int LCArcaneID
Bool isMagicActive = true
Int RNCookMediumID
Int jewelryCraftTimeID
Int HBLeatherID
Int isContainerActiveID
Int WLOilID
Bool isGiftActive = true
Int CFLinenID
Int CFLaceID
Bool isReadingActive = true
Int saveID
Int dontShowMessageID
Int readMultID
Int spellLearnTimeID
Int isLockpickActiveID
Int armorImproveTimeID
Int enchantingTimeID
Int feetCraftTimeID
Int cantReadID
Int readingIncreaseMultID
Int CFAddTinderID
Int handsCraftTimeID
Int RNCookFillingID
Int showMessageID
Int cantMagicID
Int RNWaterDrinkID
Int warhammerCraftTimeID
Int eatTimeID
Int cantMapID
Int journalMultID
Int pickpocketMultID
Int barterMultID
Int CFHatchetID
Int CFMortarID
Int CFTorchID
Int CFAddFuelID
Int isMapActiveID
Int armorCraftTimeID
Int CFMakeTinderID
Int hotkeySuspendID
Int giftMultID
Int RNCookpotID
Int CFLargeTentID
Int CFLightFireID

;-- Functions ---------------------------------------

function OnVersionUpdate(Int version)

	if version > 2
		ReadingTakesTime.isInventoryActive = isInventoryActive
		ReadingTakesTime.headCraftTime = 3 as Float
		ReadingTakesTime.armorCraftTime = 6 as Float
		ReadingTakesTime.handsCraftTime = 3 as Float
		ReadingTakesTime.feetCraftTime = 3 as Float
		ReadingTakesTime.shieldCraftTime = 4 as Float
		ReadingTakesTime.jewelryCraftTime = 2 as Float
		ReadingTakesTime.battleAxeCraftTime = 4 as Float
		ReadingTakesTime.bowCraftTime = 4 as Float
		ReadingTakesTime.daggerCraftTime = 3 as Float
		ReadingTakesTime.greatswordCraftTime = 4 as Float
		ReadingTakesTime.maceCraftTime = 4 as Float
		ReadingTakesTime.staffCraftTime = 2 as Float
		ReadingTakesTime.swordCraftTime = 4 as Float
		ReadingTakesTime.warhammerCraftTime = 4 as Float
		ReadingTakesTime.warAxeCraftTime = 4 as Float
		ReadingTakesTime.weaponCraftTime = 2 as Float
		ReadingTakesTime.miscCraftTime = 2 as Float
		ReadingTakesTime.chopTime = 5 as Float
	endIf
	if version > 3
		ReadingTakesTime.expertiseReducesTime = true
		ReadingTakesTime.readingIncreasesSpeech = true
		ReadingTakesTime.readingIncreaseMult = 1 as Float
	endIf
	if version > 4
		ReadingTakesTime.pickpocketMult = 1 as Float
	endIf
	if version > 5
		Pages[0] = "$General"
		Pages[1] = "$Reading"
		Pages[2] = "$Crafting"
		Pages[3] = "$Looting"
		Pages[4] = "$Training"
		Pages[5] = "$Preparing"
		Pages[6] = "$Trading"
		ReadingTakesTime.spellLearnTime = 2 as Float
	endIf
	if version > 6
		self.DebugMode("Version >>" + version as String + "<< [mlheur's custom brew from dragonsong, with campfire and frostfall3] is starting or updating...")
		Pages = new String[11]
		Pages[0] = "$General"
		Pages[1] = "$Reading"
		Pages[2] = "$Crafting"
		Pages[3] = "$Looting"
		Pages[4] = "$Training"
		Pages[5] = "$Preparing"
		Pages[6] = "$Trading"
		Pages[7] = "Campfire, Frostfall"
		Pages[8] = "RND"
		Pages[9] = "Hunterborn"
		Pages[10] = "Lanterns, Candles"
		ReadingTakesTime.hotkeySuspend = 0
		ReadingTakesTime.Suspended = false
		ReadingTakesTime.lightArmorTime = 15 as Float
		ReadingTakesTime.heavyArmorTime = 45 as Float
		ReadingTakesTime.showMessageThreshold = 10
		self.SetModDefaults()
		self.InitMod()
	endIf
endFunction

function DebugMode(String sMsg)

	debug.Trace("[RTT_Menu] " + sMsg, 0)
endFunction

function SaveSettings()

	fissinterface fiss = fissfactory.getFISS()
	if !fiss
		debug.MessageBox("$FISS not installed. Saving disabled")
		return 
	endIf
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
	String saveResult = fiss.endSave()
	if saveResult != ""
		self.DebugMode(saveResult)
	endIf
endFunction

function OnOptionSliderAccept(Int option, Float value)

	if option == readMultID
		ReadingTakesTime.readMult = value
		self.SetSliderOptionValue(readMultID, ReadingTakesTime.readMult, "$x{2}", false)
	elseIf option == showMessageThresholdID
		ReadingTakesTime.showMessageThreshold = value as Int
		self.SetSliderOptionValue(showMessageThresholdID, ReadingTakesTime.showMessageThreshold as Float, "{0}", false)
	elseIf option == readingIncreaseMultID
		ReadingTakesTime.readingIncreaseMult = value
		self.SetSliderOptionValue(readingIncreaseMultID, ReadingTakesTime.readingIncreaseMult, "$x{2}", false)
	elseIf option == spellLearnTimeID
		ReadingTakesTime.spellLearnTime = value
		self.SetSliderOptionValue(spellLearnTimeID, ReadingTakesTime.spellLearnTime, "${1} hour(s)", false)
	elseIf option == headCraftTimeID
		ReadingTakesTime.headCraftTime = value
		self.SetSliderOptionValue(headCraftTimeID, ReadingTakesTime.headCraftTime, "${1} hour(s)", false)
	elseIf option == armorCraftTimeID
		ReadingTakesTime.armorCraftTime = value
		self.SetSliderOptionValue(armorCraftTimeID, ReadingTakesTime.armorCraftTime, "${1} hour(s)", false)
	elseIf option == handsCraftTimeID
		ReadingTakesTime.handsCraftTime = value
		self.SetSliderOptionValue(handsCraftTimeID, ReadingTakesTime.handsCraftTime, "${1} hour(s)", false)
	elseIf option == feetCraftTimeID
		ReadingTakesTime.feetCraftTime = value
		self.SetSliderOptionValue(feetCraftTimeID, ReadingTakesTime.feetCraftTime, "${1} hour(s)", false)
	elseIf option == shieldCraftTimeID
		ReadingTakesTime.shieldCraftTime = value
		self.SetSliderOptionValue(shieldCraftTimeID, ReadingTakesTime.shieldCraftTime, "${1} hour(s)", false)
	elseIf option == jewelryCraftTimeID
		ReadingTakesTime.jewelryCraftTime = value
		self.SetSliderOptionValue(jewelryCraftTimeID, ReadingTakesTime.jewelryCraftTime, "${1} hour(s)", false)
	elseIf option == battleAxeCraftTimeID
		ReadingTakesTime.battleAxeCraftTime = value
		self.SetSliderOptionValue(battleAxeCraftTimeID, ReadingTakesTime.battleAxeCraftTime, "${1} hour(s)", false)
	elseIf option == bowCraftTimeID
		ReadingTakesTime.bowCraftTime = value
		self.SetSliderOptionValue(bowCraftTimeID, ReadingTakesTime.bowCraftTime, "${1} hour(s)", false)
	elseIf option == daggerCraftTimeID
		ReadingTakesTime.daggerCraftTime = value
		self.SetSliderOptionValue(daggerCraftTimeID, ReadingTakesTime.daggerCraftTime, "${1} hour(s)", false)
	elseIf option == greatswordCraftTimeID
		ReadingTakesTime.greatswordCraftTime = value
		self.SetSliderOptionValue(greatswordCraftTimeID, ReadingTakesTime.greatswordCraftTime, "${1} hour(s)", false)
	elseIf option == maceCraftTimeID
		ReadingTakesTime.maceCraftTime = value
		self.SetSliderOptionValue(maceCraftTimeID, ReadingTakesTime.maceCraftTime, "${1} hour(s)", false)
	elseIf option == staffCraftTimeID
		ReadingTakesTime.staffCraftTime = value
		self.SetSliderOptionValue(staffCraftTimeID, ReadingTakesTime.staffCraftTime, "${1} hour(s)", false)
	elseIf option == swordCraftTimeID
		ReadingTakesTime.swordCraftTime = value
		self.SetSliderOptionValue(swordCraftTimeID, ReadingTakesTime.swordCraftTime, "${1} hour(s)", false)
	elseIf option == warhammerCraftTimeID
		ReadingTakesTime.warhammerCraftTime = value
		self.SetSliderOptionValue(warhammerCraftTimeID, ReadingTakesTime.warhammerCraftTime, "${1} hour(s)", false)
	elseIf option == warAxeCraftTimeID
		ReadingTakesTime.warAxeCraftTime = value
		self.SetSliderOptionValue(warAxeCraftTimeID, ReadingTakesTime.warAxeCraftTime, "${1} hour(s)", false)
	elseIf option == weaponCraftTimeID
		ReadingTakesTime.weaponCraftTime = value
		self.SetSliderOptionValue(weaponCraftTimeID, ReadingTakesTime.weaponCraftTime, "${1} hour(s)", false)
	elseIf option == miscCraftTimeID
		ReadingTakesTime.miscCraftTime = value
		self.SetSliderOptionValue(miscCraftTimeID, ReadingTakesTime.miscCraftTime, "${1} hour(s)", false)
	elseIf option == armorImproveTimeID
		ReadingTakesTime.armorImproveTime = value
		self.SetSliderOptionValue(armorImproveTimeID, ReadingTakesTime.armorImproveTime, "${1} hour(s)", false)
	elseIf option == weaponImproveTimeID
		ReadingTakesTime.weaponImproveTime = value
		self.SetSliderOptionValue(weaponImproveTimeID, ReadingTakesTime.weaponImproveTime, "${1} hour(s)", false)
	elseIf option == enchantingTimeID
		ReadingTakesTime.enchantingTime = value
		self.SetSliderOptionValue(enchantingTimeID, ReadingTakesTime.enchantingTime, "${1} hour(s)", false)
	elseIf option == potionCraftTimeID
		ReadingTakesTime.potionCraftTime = value
		self.SetSliderOptionValue(potionCraftTimeID, ReadingTakesTime.potionCraftTime, "${1} hour(s)", false)
	elseIf option == lootMultID
		ReadingTakesTime.lootMult = value
		self.SetSliderOptionValue(lootMultID, ReadingTakesTime.lootMult, "$x{2}", false)
	elseIf option == pickMultID
		ReadingTakesTime.pickMult = value
		self.SetSliderOptionValue(pickMultID, ReadingTakesTime.pickMult, "$x{2}", false)
	elseIf option == pickpocketMultID
		ReadingTakesTime.pickpocketMult = value
		self.SetSliderOptionValue(pickpocketMultID, ReadingTakesTime.pickpocketMult, "$x{2}", false)
	elseIf option == LightAmorID
		ReadingTakesTime.lightArmorTime = value
		self.SetSliderOptionValue(LightAmorID, ReadingTakesTime.lightArmorTime, "${0} Minute(s)", false)
	elseIf option == HeavyArmorID
		ReadingTakesTime.heavyArmorTime = value
		self.SetSliderOptionValue(HeavyArmorID, ReadingTakesTime.heavyArmorTime, "${0} Minute(s)", false)
	elseIf option == trainingMultID
		ReadingTakesTime.trainingMult = value
		self.SetSliderOptionValue(trainingMultID, ReadingTakesTime.trainingMult, "$x{2}", false)
	elseIf option == trainingTimeID
		ReadingTakesTime.trainingTime = value
		self.SetSliderOptionValue(trainingTimeID, ReadingTakesTime.trainingTime, "${1} hour(s)", false)
	elseIf option == levelUpMultID
		ReadingTakesTime.levelUpMult = value
		self.SetSliderOptionValue(levelUpMultID, ReadingTakesTime.levelUpMult, "$x{2}", false)
	elseIf option == levelUpTimeID
		ReadingTakesTime.levelUpTime = value
		self.SetSliderOptionValue(levelUpTimeID, ReadingTakesTime.levelUpTime, "${1} hour(s)", false)
	elseIf option == inventoryMultID
		ReadingTakesTime.inventoryMult = value
		self.SetSliderOptionValue(inventoryMultID, ReadingTakesTime.inventoryMult, "$x{2}", false)
	elseIf option == eatTimeID
		ReadingTakesTime.eatTime = value
		self.SetSliderOptionValue(eatTimeID, ReadingTakesTime.eatTime, "${0} Minute(s)", false)
	elseIf option == magicMultID
		ReadingTakesTime.magicMult = value
		self.SetSliderOptionValue(magicMultID, ReadingTakesTime.magicMult, "$x{2}", false)
	elseIf option == journalMultID
		ReadingTakesTime.journalMult = value
		self.SetSliderOptionValue(journalMultID, ReadingTakesTime.journalMult, "$x{2}", false)
	elseIf option == mapMultID
		ReadingTakesTime.mapMult = value
		self.SetSliderOptionValue(mapMultID, ReadingTakesTime.mapMult, "$x{2}", false)
	elseIf option == barterMultID
		ReadingTakesTime.barterMult = value
		self.SetSliderOptionValue(barterMultID, ReadingTakesTime.barterMult, "$x{2}", false)
	elseIf option == giftMultID
		ReadingTakesTime.giftMult = value
		self.SetSliderOptionValue(giftMultID, ReadingTakesTime.giftMult, "$x{2}", false)
	elseIf option == CFCloakID
		ReadingTakesTime.cfCloakTime = value
		self.SetSliderOptionValue(CFCloakID, ReadingTakesTime.cfCloakTime, "${1} hour(s)", false)
	elseIf option == CFStickID
		ReadingTakesTime.cfStickTime = value
		self.SetSliderOptionValue(CFStickID, ReadingTakesTime.cfStickTime, "${0} Minute(s)", false)
	elseIf option == CFTorchID
		ReadingTakesTime.cfTorchTime = value
		self.SetSliderOptionValue(CFTorchID, ReadingTakesTime.cfTorchTime, "${0} Minute(s)", false)
	elseIf option == CFCookpotID
		ReadingTakesTime.cfCookpotTime = value
		self.SetSliderOptionValue(CFCookpotID, ReadingTakesTime.cfCookpotTime, "${1} hour(s)", false)
	elseIf option == CFBackpackID
		ReadingTakesTime.cfBackpackTime = value
		self.SetSliderOptionValue(CFBackpackID, ReadingTakesTime.cfBackpackTime, "${1} hour(s)", false)
	elseIf option == CFBeddingID
		ReadingTakesTime.cfBeddingTime = value
		self.SetSliderOptionValue(CFBeddingID, ReadingTakesTime.cfBeddingTime, "${1} hour(s)", false)
	elseIf option == CFSmallTentID
		ReadingTakesTime.cfSmallTentTime = value
		self.SetSliderOptionValue(CFSmallTentID, ReadingTakesTime.cfSmallTentTime, "${1} hour(s)", false)
	elseIf option == CFLargeTentID
		ReadingTakesTime.cfLargeTentTime = value
		self.SetSliderOptionValue(CFLargeTentID, ReadingTakesTime.cfLargeTentTime, "${1} hour(s)", false)
	elseIf option == CFHatchetID
		ReadingTakesTime.cfHatchetTime = value
		self.SetSliderOptionValue(CFHatchetID, ReadingTakesTime.cfHatchetTime, "${0} Minute(s)", false)
	elseIf option == CFArrowsID
		ReadingTakesTime.cfArrowsTime = value
		self.SetSliderOptionValue(CFArrowsID, ReadingTakesTime.cfArrowsTime, "${1} hour(s)", false)
	elseIf option == CFLinenID
		ReadingTakesTime.cfLinenTime = value
		self.SetSliderOptionValue(CFLinenID, ReadingTakesTime.cfLinenTime, "${0} Minute(s)", false)
	elseIf option == CFFurID
		ReadingTakesTime.cfFurTime = value
		self.SetSliderOptionValue(CFFurID, ReadingTakesTime.cfFurTime, "${1} hour(s)", false)
	elseIf option == CFLaceID
		ReadingTakesTime.cfLaceTime = value
		self.SetSliderOptionValue(CFLaceID, ReadingTakesTime.cfLaceTime, "${0} Minute(s)", false)
	elseIf option == CFTanRackID
		ReadingTakesTime.cfTanRackTime = value
		self.SetSliderOptionValue(CFTanRackID, ReadingTakesTime.cfTanRackTime, "${0} Minute(s)", false)
	elseIf option == CFMortarID
		ReadingTakesTime.cfMortarTime = value
		self.SetSliderOptionValue(CFMortarID, ReadingTakesTime.cfMortarTime, "${1} hour(s)", false)
	elseIf option == CFEnchID
		ReadingTakesTime.cfEnchTime = value
		self.SetSliderOptionValue(CFEnchID, ReadingTakesTime.cfEnchTime, "${1} hour(s)", false)
	elseIf option == CFMakeTinderID
		ReadingTakesTime.cfMakeTinderTime = value
		self.SetSliderOptionValue(CFMakeTinderID, ReadingTakesTime.cfMakeTinderTime, "${0} Minute(s)", false)
	elseIf option == CFMakeKindlingID
		ReadingTakesTime.cfMakeKindlingTime = value
		self.SetSliderOptionValue(CFMakeKindlingID, ReadingTakesTime.cfMakeKindlingTime, "${0} Minute(s)", false)
	elseIf option == CFAddTinderID
		ReadingTakesTime.cfAddTinderTime = value
		self.SetSliderOptionValue(CFAddTinderID, ReadingTakesTime.cfAddTinderTime, "${0} Minute(s)", false)
	elseIf option == CFAddKindlingID
		ReadingTakesTime.cfAddKindlingTime = value
		self.SetSliderOptionValue(CFAddKindlingID, ReadingTakesTime.cfAddKindlingTime, "${0} Minute(s)", false)
	elseIf option == CFLightFireID
		ReadingTakesTime.cfLightFireTime = value
		self.SetSliderOptionValue(CFLightFireID, ReadingTakesTime.cfLightFireTime, "${0} Minute(s)", false)
	elseIf option == CFAddFuelID
		ReadingTakesTime.cfAddFuelTime = value
		self.SetSliderOptionValue(CFAddFuelID, ReadingTakesTime.cfAddFuelTime, "${0} Minute(s)", false)
	elseIf option == FFSnowberryID
		ReadingTakesTime.ffSnowberryTime = value
		self.SetSliderOptionValue(FFSnowberryID, ReadingTakesTime.ffSnowberryTime, "${0} Minute(s)", false)
	elseIf option == RNWaterskinID
		ReadingTakesTime.rnWaterskinTime = value
		self.SetSliderOptionValue(RNWaterskinID, ReadingTakesTime.rnWaterskinTime, "${1} hour(s)", false)
	elseIf option == RNCookpotID
		ReadingTakesTime.rnCookpotTime = value
		self.SetSliderOptionValue(RNCookpotID, ReadingTakesTime.rnCookpotTime, "${1} hour(s)", false)
	elseIf option == RNTinderboxID
		ReadingTakesTime.rnTinderboxTime = value
		self.SetSliderOptionValue(RNTinderboxID, ReadingTakesTime.rnTinderboxTime, "${1} hour(s)", false)
	elseIf option == RNBedrollID
		ReadingTakesTime.rnBedrollTime = value
		self.SetSliderOptionValue(RNBedrollID, ReadingTakesTime.rnBedrollTime, "${1} hour(s)", false)
	elseIf option == RNTentID
		ReadingTakesTime.rnTentTime = value
		self.SetSliderOptionValue(RNTentID, ReadingTakesTime.rnTentTime, "${1} hour(s)", false)
	elseIf option == RNMilkBucketID
		ReadingTakesTime.rnMilkBucketTime = value
		self.SetSliderOptionValue(RNMilkBucketID, ReadingTakesTime.rnMilkBucketTime, "${0} Minute(s)", false)
	elseIf option == RNFoodSnackID
		ReadingTakesTime.rnEatSnackTime = value
		self.SetSliderOptionValue(RNFoodSnackID, ReadingTakesTime.rnEatSnackTime, "${0} Minute(s)", false)
	elseIf option == RNFoodMediumID
		ReadingTakesTime.rnEatMediumTime = value
		self.SetSliderOptionValue(RNFoodMediumID, ReadingTakesTime.rnEatMediumTime, "${0} Minute(s)", false)
	elseIf option == RNFoodFillingID
		ReadingTakesTime.rnEatFillingTime = value
		self.SetSliderOptionValue(RNFoodFillingID, ReadingTakesTime.rnEatFillingTime, "${0} Minute(s)", false)
	elseIf option == RNWaterDrinkID
		ReadingTakesTime.rnDrinkTime = value
		self.SetSliderOptionValue(RNWaterDrinkID, ReadingTakesTime.rnDrinkTime, "${0} Minute(s)", false)
	elseIf option == RNCookSnackID
		ReadingTakesTime.rnCookSnackTime = value
		self.SetSliderOptionValue(RNCookSnackID, ReadingTakesTime.rnCookSnackTime, "${0} Minute(s)", false)
	elseIf option == RNCookMediumID
		ReadingTakesTime.rnCookMediumTime = value
		self.SetSliderOptionValue(RNCookMediumID, ReadingTakesTime.rnCookMediumTime, "${0} Minute(s)", false)
	elseIf option == RNCookFillingID
		ReadingTakesTime.rnCookFillingTime = value
		self.SetSliderOptionValue(RNCookFillingID, ReadingTakesTime.rnCookFillingTime, "${0} Minute(s)", false)
	elseIf option == RNBrewDrinkID
		ReadingTakesTime.rnBrewTime = value
		self.SetSliderOptionValue(RNBrewDrinkID, ReadingTakesTime.rnBrewTime, "${0} Minute(s)", false)
	elseIf option == RNWaterPrepID
		ReadingTakesTime.rnWaterPrepTime = value
		self.SetSliderOptionValue(RNWaterPrepID, ReadingTakesTime.rnWaterPrepTime, "${0} Minute(s)", false)
	elseIf option == RNSaltID
		ReadingTakesTime.rnSaltTime = value
		self.SetSliderOptionValue(RNSaltID, ReadingTakesTime.rnSaltTime, "${1} hour(s)", false)
	elseIf option == HBScrimBitsID
		ReadingTakesTime.hbScrimBitsTime = value
		self.SetSliderOptionValue(HBScrimBitsID, ReadingTakesTime.hbScrimBitsTime, "${0} Minute(s)", false)
	elseIf option == HBScrimIdolID
		ReadingTakesTime.hbScrimIdolTime = value
		self.SetSliderOptionValue(HBScrimIdolID, ReadingTakesTime.hbScrimIdolTime, "${1} hour(s)", false)
	elseIf option == HBScrimToolID
		ReadingTakesTime.hbScrimToolTime = value
		self.SetSliderOptionValue(HBScrimToolID, ReadingTakesTime.hbScrimToolTime, "${1} hour(s)", false)
	elseIf option == HBLeatherID
		ReadingTakesTime.hbLeatherTime = value
		self.SetSliderOptionValue(HBLeatherID, ReadingTakesTime.hbLeatherTime, "${1} hour(s)", false)
	elseIf option == HBStripID
		ReadingTakesTime.hbStripTime = value
		self.SetSliderOptionValue(HBStripID, ReadingTakesTime.hbStripTime, "${0} Minute(s)", false)
	elseIf option == HBBedrollID
		ReadingTakesTime.hbBedrollTime = value
		self.SetSliderOptionValue(HBBedrollID, ReadingTakesTime.hbBedrollTime, "${1} hour(s)", false)
	elseIf option == HBIngrID
		ReadingTakesTime.hbIngrTime = value
		self.SetSliderOptionValue(HBIngrID, ReadingTakesTime.hbIngrTime, "${0} Minute(s)", false)
	elseIf option == HBBrewID
		ReadingTakesTime.hbBrewTime = value
		self.SetSliderOptionValue(HBBrewID, ReadingTakesTime.hbBrewTime, "${0} Minute(s)", false)
	elseIf option == HBTallowID
		ReadingTakesTime.hbTallowTime = value
		self.SetSliderOptionValue(HBTallowID, ReadingTakesTime.hbTallowTime, "${0} Minute(s)", false)
	elseIf option == HBArrowsID
		ReadingTakesTime.hbArrowsTime = value
		self.SetSliderOptionValue(HBArrowsID, ReadingTakesTime.hbArrowsTime, "${1} hour(s)", false)
	elseIf option == WLLanternID
		ReadingTakesTime.wlWearableTime = value
		self.SetSliderOptionValue(WLLanternID, ReadingTakesTime.wlWearableTime, "${0} Minute(s)", false)
	elseIf option == WLChassisID
		ReadingTakesTime.wlChassisTime = value
		self.SetSliderOptionValue(WLChassisID, ReadingTakesTime.wlChassisTime, "${1} hour(s)", false)
	elseIf option == WLOilID
		ReadingTakesTime.wlOilTime = value
		self.SetSliderOptionValue(WLOilID, ReadingTakesTime.wlOilTime, "${0} Minute(s)", false)
	elseIf option == LCBasicID
		ReadingTakesTime.lcBasicTime = value
		self.SetSliderOptionValue(LCBasicID, ReadingTakesTime.lcBasicTime, "${0} Minute(s)", false)
	elseIf option == LCForgeID
		ReadingTakesTime.lcForgeTime = value
		self.SetSliderOptionValue(LCForgeID, ReadingTakesTime.lcForgeTime, "${1} hour(s)", false)
	elseIf option == LCArcaneID
		ReadingTakesTime.lcArcaneTime = value
		self.SetSliderOptionValue(LCArcaneID, ReadingTakesTime.lcArcaneTime, "${1} hour(s)", false)
	elseIf option == LCBrewID
		ReadingTakesTime.lcBrewTime = value
		self.SetSliderOptionValue(LCBrewID, ReadingTakesTime.lcBrewTime, "${0} Minute(s)", false)
	endIf
endFunction

String function GetCustomControl(Int keyCode)

	if keyCode == ReadingTakesTime.hotkeySuspend
		return "Suspend/Resume"
	else
		return ""
	endIf
endFunction

function OnKeyUp(Int keyCode, Float holdTime)

	if !isModActive
		self.UnregisterForAllKeys()
		return 
	endIf
	if ui.IsMenuOpen("Console") || utility.IsInMenuMode() || game.GetPlayer().GetSitState() != 0
		
	elseIf keyCode == ReadingTakesTime.hotkeySuspend
		ReadingTakesTime.Suspended = !ReadingTakesTime.Suspended
		if ReadingTakesTime.Suspended
			debug.Notification("Living Takes Time suspended.")
		else
			debug.Notification("Living Takes Time resumed.")
		endIf
	else
		self.UnregisterForKey(keyCode)
	endIf
endFunction

function OnPageReset(String page)

	if page == ""
		self.LoadCustomContent("LivingTakesTime/LTThome.dds", 26 as Float, 23 as Float)
		return 
	else
		self.UnloadCustomContent()
	endIf
	Bool isCFActive = game.GetFormFromFile(288979, "Campfire.esm") as Bool
	Bool isFFActive = game.GetFormFromFile(119856, "Frostfall.esp") as Bool
	Bool isRNActive = game.GetFormFromFile(22888, "RealisticNeedsandDiseases.esp") as Bool
	Bool isHBActive = game.GetFormFromFile(26963, "Hunterborn.esp") as Bool
	Bool isWLActive = game.GetFormFromFile(4809, "Chesko_WearableLantern.esp") as Bool
	Bool isLCActive = game.GetFormFromFile(4828, "lanterns.esp") as Bool
	self.DebugMode("Active Mods: CF[" + isCFActive as String + "] FF[" + isFFActive as String + "] RN[" + isRNActive as String + "] HB[" + isHBActive as String + "] WL [" + isWLActive as String + "] LC[" + isLCActive as String + "]")
	if page == "$General"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$Options", 0)
		isModActiveID = self.AddToggleOption("$Activate Mod?", isModActive, 0)
		showMessageID = self.AddToggleOption("$Show message notifications?", ReadingTakesTime.showMessage, 0)
		showMessageThresholdID = self.AddSliderOption("$Notification threshold", ReadingTakesTime.showMessageThreshold as Float, "{0}", 0)
		expertiseReducesTimeID = self.AddToggleOption("$Expertise reduces time?", ReadingTakesTime.expertiseReducesTime, 0)
		hotkeySuspendID = self.AddKeyMapOption("Suspend hotkey", ReadingTakesTime.hotkeySuspend, 0)
		self.SetCursorPosition(1)
		self.AddHeaderOption("$Save & Load", 0)
		fissinterface fiss = fissfactory.getFISS()
		Int SaveFlag = self.OPTION_FLAG_NONE
		Int LoadFlag = self.OPTION_FLAG_NONE
		if !fiss
			SaveFlag = self.OPTION_FLAG_DISABLED
			LoadFlag = self.OPTION_FLAG_DISABLED
		else
			fiss.beginLoad("LTT\\LTTSettings.xml")
			if fiss.endLoad() != ""
				LoadFlag = self.OPTION_FLAG_DISABLED
			endIf
		endIf
		saveID = self.AddTextOption("$Save settings", "", SaveFlag)
		loadID = self.AddTextOption("$Load settings", "", LoadFlag)
	elseIf page == "$Reading"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$Options", 0)
		isReadingActiveID = self.AddToggleOption("$Reading Takes Time?", isReadingActive, 0)
		readMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.readMult, "$x{2}", 0)
		cantReadID = self.AddToggleOption("$Block read while in combat?", ReadingTakesTime.cantRead, 0)
		readingIncreasesSpeechID = self.AddToggleOption("$Reading increases speech?", ReadingTakesTime.readingIncreasesSpeech, 0)
		readingIncreaseMultID = self.AddSliderOption("$Reading increase Multiplier", ReadingTakesTime.readingIncreaseMult, "$x{2}", 0)
		spellLearnTimeID = self.AddSliderOption("$Learning Spell Time", ReadingTakesTime.spellLearnTime, "${1} hour(s)", 0)
	elseIf page == "$Crafting"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$Options", 0)
		isCraftingActiveID = self.AddToggleOption("$Crafting Takes Time?", isCraftingActive, 0)
		self.AddHeaderOption("$Armors, Shields and Jewels", 0)
		armorImproveTimeID = self.AddSliderOption("$Improving Time", ReadingTakesTime.armorImproveTime, "${1} hour(s)", 0)
		headCraftTimeID = self.AddSliderOption("$Helmet & Circlet Crafting Time", ReadingTakesTime.headCraftTime, "${1} hour(s)", 0)
		armorCraftTimeID = self.AddSliderOption("$Cuirass & Clothes Crafting Time", ReadingTakesTime.armorCraftTime, "${1} hour(s)", 0)
		handsCraftTimeID = self.AddSliderOption("$Bracers & Gloves Crafting Time", ReadingTakesTime.handsCraftTime, "${1} hour(s)", 0)
		feetCraftTimeID = self.AddSliderOption("$Boots & Shoes Crafting Time", ReadingTakesTime.feetCraftTime, "${1} hour(s)", 0)
		shieldCraftTimeID = self.AddSliderOption("$Shield Crafting Time", ReadingTakesTime.shieldCraftTime, "${1} hour(s)", 0)
		jewelryCraftTimeID = self.AddSliderOption("$Jewelry Crafting Time", ReadingTakesTime.jewelryCraftTime, "${1} hour(s)", 0)
		self.AddHeaderOption("$Tanning, Smelting and Misc", 0)
		miscCraftTimeID = self.AddSliderOption("$Crafting Time", ReadingTakesTime.miscCraftTime, "${1} hour(s)", 0)
		self.AddHeaderOption("$Enchanting", 0)
		enchantingTimeID = self.AddSliderOption("$Crafting Time", ReadingTakesTime.enchantingTime, "${1} hour(s)", 0)
		self.AddHeaderOption("$Potions, Poisons and Food", 0)
		potionCraftTimeID = self.AddSliderOption("$Crafting Time", ReadingTakesTime.potionCraftTime, "${1} hour(s)", 0)
		self.SetCursorPosition(5)
		self.AddHeaderOption("$Weapons", 0)
		weaponImproveTimeID = self.AddSliderOption("$Improving Time", ReadingTakesTime.weaponImproveTime, "${1} hour(s)", 0)
		battleAxeCraftTimeID = self.AddSliderOption("$Battle Axe Crafting Time", ReadingTakesTime.battleAxeCraftTime, "${1} hour(s)", 0)
		bowCraftTimeID = self.AddSliderOption("$Bow Crafting Time", ReadingTakesTime.bowCraftTime, "${1} hour(s)", 0)
		daggerCraftTimeID = self.AddSliderOption("$Dagger Crafting Time", ReadingTakesTime.daggerCraftTime, "${1} hour(s)", 0)
		greatswordCraftTimeID = self.AddSliderOption("$Greatsword Crafting Time", ReadingTakesTime.greatswordCraftTime, "${1} hour(s)", 0)
		maceCraftTimeID = self.AddSliderOption("$Mace Crafting Time", ReadingTakesTime.maceCraftTime, "${1} hour(s)", 0)
		staffCraftTimeID = self.AddSliderOption("$Staff Crafting Time", ReadingTakesTime.staffCraftTime, "${1} hour(s)", 0)
		swordCraftTimeID = self.AddSliderOption("$Sword Crafting Time", ReadingTakesTime.swordCraftTime, "${1} hour(s)", 0)
		warhammerCraftTimeID = self.AddSliderOption("$Warhammer Crafting Time", ReadingTakesTime.warhammerCraftTime, "${1} hour(s)", 0)
		warAxeCraftTimeID = self.AddSliderOption("$War Axe Crafting Time", ReadingTakesTime.warAxeCraftTime, "${1} hour(s)", 0)
		weaponCraftTimeID = self.AddSliderOption("$Ammo Crafting Time", ReadingTakesTime.weaponCraftTime, "${1} hour(s)", 0)
	elseIf page == "$Looting"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("$Containers, Dead Bodies and Pickpocket", 0)
		isContainerActiveID = self.AddToggleOption("$Looting Takes Time?", isContainerActive, 0)
		lootMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.lootMult, "$x{2}", 0)
		cantLootID = self.AddToggleOption("$Block looting while in combat?", ReadingTakesTime.cantLoot, 0)
		pickpocketMultID = self.AddSliderOption("$Pickpocket Time Multiplier", ReadingTakesTime.pickpocketMult, "$x{2}", 0)
		LightAmorID = self.AddSliderOption("Time to loot light armor", ReadingTakesTime.lightArmorTime, "${0} Minute(s)", 0)
		HeavyArmorID = self.AddSliderOption("Time to loot heavy armor", ReadingTakesTime.heavyArmorTime, "${0} Minute(s)", 0)
		self.SetCursorPosition(1)
		self.AddHeaderOption("$Lockpicking", 0)
		isLockpickActiveID = self.AddToggleOption("$Lockpicking Takes Time?", isLockpickActive, 0)
		pickMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.pickMult, "$x{2}", 0)
		cantPickID = self.AddToggleOption("$Block lockpicking while in combat?", ReadingTakesTime.cantPick, 0)
	elseIf page == "$Training"
		self.SetCursorFillMode(self.LEFT_TO_RIGHT)
		self.AddHeaderOption("$Training", 0)
		self.AddHeaderOption("$Level Up", 0)
		isTrainingActiveID = self.AddToggleOption("$Training Takes Time?", isTrainingActive, 0)
		isLevelUpActiveID = self.AddToggleOption("$Leveling Up Takes Time?", isLevelUpActive, 0)
		trainingMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.trainingMult, "$x{2}", 0)
		levelUpMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.levelUpMult, "$x{2}", 0)
		trainingTimeID = self.AddSliderOption("$Training Time", ReadingTakesTime.trainingTime, "${1} hour(s)", 0)
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		levelUpTimeID = self.AddSliderOption("$Level Up Time", ReadingTakesTime.levelUpTime, "${1} hour(s)", 0)
		cantLevelUpID = self.AddToggleOption("$Block leveling while in combat?", ReadingTakesTime.cantLevelUp, 0)
	elseIf page == "$Preparing"
		self.SetCursorFillMode(self.LEFT_TO_RIGHT)
		self.AddHeaderOption("$Inventory", 0)
		self.AddHeaderOption("$Magic", 0)
		isInventoryActiveID = self.AddToggleOption("$Inventory Takes Time?", isInventoryActive, 0)
		isMagicActiveID = self.AddToggleOption("$Magic Menu Takes Time?", isMagicActive, 0)
		inventoryMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.inventoryMult, "$x{2}", 0)
		magicMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.magicMult, "$x{2}", 0)
		cantInventoryID = self.AddToggleOption("$Block inventory while in combat?", ReadingTakesTime.cantInventory, 0)
		cantMagicID = self.AddToggleOption("$Block magic menu while in combat?", ReadingTakesTime.cantMagic, 0)
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		eatTimeID = self.AddSliderOption("$Eating Time", ReadingTakesTime.eatTime, "${0} Minute(s)", 0)
		self.SetCursorFillMode(self.LEFT_TO_RIGHT)
		self.AddHeaderOption("$Journal", 0)
		self.AddHeaderOption("$Map", 0)
		isJournalActiveID = self.AddToggleOption("$Journal Takes Time?", isJournalActive, 0)
		isMapActiveID = self.AddToggleOption("$Map Takes Time?", isMapActive, 0)
		journalMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.journalMult, "$x{2}", 0)
		mapMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.mapMult, "$x{2}", 0)
		cantJournalID = self.AddToggleOption("$Block journal while in combat?", ReadingTakesTime.cantJournal, 0)
		cantMapID = self.AddToggleOption("$Block map menu while in combat?", ReadingTakesTime.cantMap, 0)
	elseIf page == "$Trading"
		self.SetCursorFillMode(self.LEFT_TO_RIGHT)
		self.AddHeaderOption("$Barter", 0)
		self.AddHeaderOption("$Gift", 0)
		isBarterActiveID = self.AddToggleOption("$Barter Takes Time?", isBarterActive, 0)
		isGiftActiveID = self.AddToggleOption("$Gifting Takes Time?", isGiftActive, 0)
		barterMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.barterMult, "$x{2}", 0)
		giftMultID = self.AddSliderOption("$Time Multiplier", ReadingTakesTime.giftMult, "$x{2}", 0)
	elseIf page == "Campfire, Frostfall"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		if !isCFActive
			self.AddTextOption("", "Campfire is not active.", 0)
			return 
		endIf
		self.AddHeaderOption("Camping Gear", 0)
		CFCloakID = self.AddSliderOption("Cloaks", ReadingTakesTime.cfCloakTime, "${1} hour(s)", 0)
		CFStickID = self.AddSliderOption("Walking stick", ReadingTakesTime.cfStickTime, "${0} Minute(s)", 0)
		CFTorchID = self.AddSliderOption("Torch", ReadingTakesTime.cfTorchTime, "${0} Minute(s)", 0)
		CFCookpotID = self.AddSliderOption("Cooking Pot", ReadingTakesTime.cfCookpotTime, "${1} hour(s)", 0)
		CFBackpackID = self.AddSliderOption("Backpacks", ReadingTakesTime.cfBackpackTime, "${1} hour(s)", 0)
		CFBeddingID = self.AddSliderOption("Bedding", ReadingTakesTime.cfBeddingTime, "${1} hour(s)", 0)
		CFSmallTentID = self.AddSliderOption("Small tents", ReadingTakesTime.cfSmallTentTime, "${1} hour(s)", 0)
		CFLargeTentID = self.AddSliderOption("Large tents", ReadingTakesTime.cfLargeTentTime, "${1} hour(s)", 0)
		CFHatchetID = self.AddSliderOption("Tools", ReadingTakesTime.cfHatchetTime, "${0} Minute(s)", 0)
		CFArrowsID = self.AddSliderOption("Arrows", ReadingTakesTime.cfArrowsTime, "${1} hour(s)", 0)
		self.SetCursorPosition(19)
		self.AddHeaderOption("Materials", 0)
		CFLinenID = self.AddSliderOption("Linen wrap", ReadingTakesTime.cfLinenTime, "${0} Minute(s)", 0)
		CFFurID = self.AddSliderOption("Fur plate", ReadingTakesTime.cfFurTime, "${1} hour(s)", 0)
		CFLaceID = self.AddSliderOption("Hide lace", ReadingTakesTime.cfLaceTime, "${0} Minute(s)", 0)
		CFTanRackID = self.AddSliderOption("Tanning rack", ReadingTakesTime.cfTanRackTime, "${0} Minute(s)", 0)
		CFMortarID = self.AddSliderOption("Mortar and pestle", ReadingTakesTime.cfMortarTime, "${1} hour(s)", 0)
		CFEnchID = self.AddSliderOption("Enchanting supplies", ReadingTakesTime.cfEnchTime, "${1} hour(s)", 0)
		self.SetCursorPosition(1)
		self.AddHeaderOption("Firecraft", 0)
		CFFirecraftImprovesID = self.AddToggleOption("Perk Improves", ReadingTakesTime.cfFirecraftImproves, 0)
		CFMakeTinderID = self.AddSliderOption("Make Tinder", ReadingTakesTime.cfMakeTinderTime, "${0} Minute(s)", 0)
		CFMakeKindlingID = self.AddSliderOption("Make Kindling", ReadingTakesTime.cfMakeKindlingTime, "${0} Minute(s)", 0)
		CFAddTinderID = self.AddSliderOption("Add Tinder", ReadingTakesTime.cfAddTinderTime, "${0} Minute(s)", 0)
		CFAddKindlingID = self.AddSliderOption("Add Kindling", ReadingTakesTime.cfAddKindlingTime, "${0} Minute(s)", 0)
		CFLightFireID = self.AddSliderOption("Sparking the Fire", ReadingTakesTime.cfLightFireTime, "${0} Minute(s)", 0)
		CFAddFuelID = self.AddSliderOption("Stoking the Fire", ReadingTakesTime.cfAddFuelTime, "${0} Minute(s)", 0)
		self.SetCursorPosition(24)
		if isFFActive
			self.AddHeaderOption("Frostfall", 0)
			FFSnowberryID = self.AddSliderOption("Snowberry Extract", ReadingTakesTime.ffSnowberryTime, "${0} Minute(s)", 0)
		else
			self.AddHeaderOption("Frostfall not active", 0)
		endIf
	elseIf page == "RND"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		if !isRNActive
			self.AddTextOption("", "Realistic Needs and Diseases is not active.", 0)
			return 
		endIf
		self.AddHeaderOption("Crafted", 0)
		RNWaterskinID = self.AddSliderOption("Waterskin", ReadingTakesTime.rnWaterskinTime, "${1} hour(s)", 0)
		RNCookpotID = self.AddSliderOption("Cookpot", ReadingTakesTime.rnCookpotTime, "${1} hour(s)", 0)
		RNTinderboxID = self.AddSliderOption("Tinderbox", ReadingTakesTime.rnTinderboxTime, "${1} hour(s)", 0)
		RNBedrollID = self.AddSliderOption("Bedroll", ReadingTakesTime.rnBedrollTime, "${1} hour(s)", 0)
		RNTentID = self.AddSliderOption("Tent", ReadingTakesTime.rnTentTime, "${1} hour(s)", 0)
		RNMilkBucketID = self.AddSliderOption("Milk bucket", ReadingTakesTime.rnMilkBucketTime, "${0} Minute(s)", 0)
		self.SetCursorPosition(1)
		self.AddHeaderOption("Cooked", 0)
		RNFoodSnackID = self.AddSliderOption("Eat snack", ReadingTakesTime.rnEatSnackTime, "${0} Minute(s)", 0)
		RNFoodMediumID = self.AddSliderOption("Eat medium meal", ReadingTakesTime.rnEatMediumTime, "${0} Minute(s)", 0)
		RNFoodFillingID = self.AddSliderOption("Eat filling meal", ReadingTakesTime.rnEatFillingTime, "${0} Minute(s)", 0)
		RNWaterDrinkID = self.AddSliderOption("Drink water", ReadingTakesTime.rnDrinkTime, "${0} Minute(s)", 0)
		RNCookSnackID = self.AddSliderOption("Cook snack", ReadingTakesTime.rnCookSnackTime, "${0} Minute(s)", 0)
		RNCookMediumID = self.AddSliderOption("Cook medium meal", ReadingTakesTime.rnCookMediumTime, "${0} Minute(s)", 0)
		RNCookFillingID = self.AddSliderOption("Cook filling meal", ReadingTakesTime.rnCookFillingTime, "${0} Minute(s)", 0)
		RNBrewDrinkID = self.AddSliderOption("Brew drink", ReadingTakesTime.rnBrewTime, "${0} Minute(s)", 0)
		RNWaterPrepID = self.AddSliderOption("Prep water", ReadingTakesTime.rnWaterPrepTime, "${0} Minute(s)", 0)
		RNSaltID = self.AddSliderOption("Create salt", ReadingTakesTime.rnSaltTime, "${1} hour(s)", 0)
	elseIf page == "Hunterborn"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		if !isHBActive
			self.AddTextOption("", "Hunterborn is not active.", 0)
			return 
		endIf
		self.AddHeaderOption("Scrimshaw", 0)
		HBScrimBitsID = self.AddSliderOption("Bone bits", ReadingTakesTime.hbScrimBitsTime, "${0} Minute(s)", 0)
		HBScrimIdolID = self.AddSliderOption("Idols", ReadingTakesTime.hbScrimIdolTime, "${1} hour(s)", 0)
		HBScrimToolID = self.AddSliderOption("Tools", ReadingTakesTime.hbScrimToolTime, "${1} hour(s)", 0)
		self.AddEmptyOption()
		self.AddHeaderOption("Leather", 0)
		HBLeatherID = self.AddSliderOption("Leather (all sources)", ReadingTakesTime.hbLeatherTime, "${1} hour(s)", 0)
		HBStripID = self.AddSliderOption("Leather strips (all sources)", ReadingTakesTime.hbStripTime, "${0} Minute(s)", 0)
		self.SetCursorPosition(1)
		self.AddHeaderOption("Weapons and Armor", 0)
		HBWeapArmorTipID = self.AddTextOption("", "Note on expertise", 0)
		HBArrowsID = self.AddSliderOption("Arrows", ReadingTakesTime.hbArrowsTime, "${1} hour(s)", 0)
		self.AddEmptyOption()
		self.AddHeaderOption("Misc", 0)
		HBBedrollID = self.AddSliderOption("Hunter's bedroll", ReadingTakesTime.hbBedrollTime, "${1} hour(s)", 0)
		HBIngrID = self.AddSliderOption("Ingredients", ReadingTakesTime.hbIngrTime, "${0} Minute(s)", 0)
		HBBrewID = self.AddSliderOption("Brews", ReadingTakesTime.hbBrewTime, "${0} Minute(s)", 0)
		HBTallowID = self.AddSliderOption("Tallow", ReadingTakesTime.hbTallowTime, "${0} Minute(s)", 0)
	elseIf page == "Lanterns, Candles"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		if !isWLActive
			self.AddTextOption("", "Wearable Lantern is not active.", 0)
		else
			self.AddHeaderOption("Wearable Lantern", 0)
			WLLanternID = self.AddSliderOption("Travel lantern", ReadingTakesTime.wlWearableTime, "${0} Minute(s)", 0)
			WLChassisID = self.AddSliderOption("Chassis", ReadingTakesTime.wlChassisTime, "${1} hour(s)", 0)
			WLOilID = self.AddSliderOption("Lantern oil", ReadingTakesTime.wlOilTime, "${0} Minute(s)", 0)
		endIf
		self.SetCursorPosition(1)
		if !isLCActive
			self.AddTextOption("", "Lanterns and Candles is not active.", 0)
		else
			self.AddHeaderOption("Lanterns and Candles", 0)
			LCBasicID = self.AddSliderOption("Basic", ReadingTakesTime.lcBasicTime, "${0} Minute(s)", 0)
			LCForgeID = self.AddSliderOption("Forged", ReadingTakesTime.lcForgeTime, "${1} hour(s)", 0)
			LCArcaneID = self.AddSliderOption("Arcane", ReadingTakesTime.lcArcaneTime, "${1} hour(s)", 0)
			LCBrewID = self.AddSliderOption("Brew candle", ReadingTakesTime.lcBrewTime, "${0} Minute(s)", 0)
		endIf
	endIf
endFunction

function OnOptionKeyMapChange(Int a_option, Int a_keyCode, String a_conflictControl, String a_conflictName)

	self.DebugMode("OnOptionKeyMapChange a_option = " + a_option as String + " ; a_keyCode = " + a_keyCode as String + " ; a_conflictControl = " + a_conflictControl + " ; a_conflictName = " + a_conflictName)
	if a_conflictControl != ""
		if a_conflictName != ""
			self.showMessage("This key is already mapped to " + a_conflictControl + " in " + a_conflictName + ". Please choose a different key.", true, "$Accept", "$Cancel")
		else
			self.showMessage("This key is already mapped to " + a_conflictControl + " in Skyrim. Please choose a different key.", true, "$Accept", "$Cancel")
		endIf
		return 
	endIf
	if a_option == hotkeySuspendID
		self.DebugMode("Registered to HotkeySuspend.")
		ReadingTakesTime.hotkeySuspend = a_keyCode
	else
		self.DebugMode("No matching registration.")
		return 
	endIf
	self.RegisterForKey(a_keyCode)
	self.ForcePageReset()
endFunction

function OnOptionHighlight(Int option)

	if option == isModActiveID
		self.SetInfoText("$Activate or deactivate the mod.")
	elseIf option == isReadingActiveID || option == isCraftingActiveID || option == isContainerActiveID || option == isLockpickActiveID || option == isTrainingActiveID || option == isLevelUpActiveID || option == isInventoryActiveID || option == isMagicActiveID || option == isJournalActiveID || option == isMapActiveID || option == isBarterActiveID || option == isGiftActiveID
		self.SetInfoText("$Activate or deactivate this module.")
	elseIf option == showMessageThresholdID
		self.SetInfoText("Notification of time passed only displayed if at least this many minutes have passed.")
	elseIf option == readMultID || option == lootMultID || option == pickMultID || option == pickpocketMultID || option == trainingMultID || option == levelUpMultID || option == inventoryMultID || option == magicMultID || option == journalMultID || option == mapMultID || option == barterMultID || option == giftMultID
		self.SetInfoText("$Multiplier used to calculate the time spent in this menu.")
	elseIf option == spellLearnTimeID || option == headCraftTimeID || option == armorCraftTimeID || option == handsCraftTimeID || option == feetCraftTimeID || option == shieldCraftTimeID || option == jewelryCraftTimeID || option == battleAxeCraftTimeID || option == bowCraftTimeID || option == daggerCraftTimeID || option == greatswordCraftTimeID || option == maceCraftTimeID || option == staffCraftTimeID || option == swordCraftTimeID || option == warhammerCraftTimeID || option == warAxeCraftTimeID || option == weaponCraftTimeID || option == miscCraftTimeID || option == armorImproveTimeID || option == weaponImproveTimeID || option == potionCraftTimeID || option == enchantingTimeID || option == trainingTimeID || option == levelUpTimeID || option == eatTimeID
		self.SetInfoText("$Time spent when performing this action.")
	elseIf option == hotkeySuspendID
		self.SetInfoText("Set a hotkey to suspend / resume the mod.")
	elseIf option == LightAmorID
		self.SetInfoText("Additional time spent when stripping a corpse of a light armor cuirass.")
	elseIf option == HeavyArmorID
		self.SetInfoText("Additional time spent when stripping a corpse of a heavy armor cuirass.")
	elseIf option == cantReadID || option == cantLootID || option == cantPickID || option == cantLevelUpID || option == cantInventoryID || option == cantMagicID || option == cantJournalID || option == cantMapID
		self.SetInfoText("$Block this action while in combat.")
	elseIf option == readingIncreasesSpeechID
		self.SetInfoText("$Reading increases speech.")
	elseIf option == readingIncreaseMultID
		self.SetInfoText("$Reading increase multiplier.")
	elseIf option == showMessageID
		self.SetInfoText("$Show notification messages with the time spent.")
	elseIf option == dontShowMessageID
		self.SetInfoText("$RTT_DONTSHOWMESSAGE_HIGHLIGHT")
	elseIf option == expertiseReducesTimeID
		self.SetInfoText("$RTT_EXPERTIESEREDUCESTIME_HIGHLIGHT")
	elseIf option == CFCloakID
		self.SetInfoText("Time spent to craft any of the Frostfall cloaks.")
	elseIf option == CFStickID
		self.SetInfoText("Time spent to craft a walking stick.")
	elseIf option == CFTorchID
		self.SetInfoText("Time spent to create one torch.")
	elseIf option == CFCookpotID
		self.SetInfoText("Time spent at the forge to craft a steel cookpot.")
	elseIf option == CFBackpackID
		self.SetInfoText("Time spent to craft any of the Frostfall backpacks. Modifying backpacks costs no time.")
	elseIf option == CFBeddingID
		self.SetInfoText("Time spent on bedrolls for tents, rough bedding takes half this time.")
	elseIf option == CFSmallTentID
		self.SetInfoText("Time spent to create any small tent.")
	elseIf option == CFLargeTentID
		self.SetInfoText("Time spent to create any large tent.")
	elseIf option == CFHatchetID
		self.SetInfoText("Time spent to craft a stone hatchet.")
	elseIf option == CFArrowsID
		self.SetInfoText("Time spent to craft a batch (24) of stone arrows.")
	elseIf option == CFLinenID
		self.SetInfoText("Time spent to make one linen wrap. Multiplied when crafting several.")
	elseIf option == CFFurID
		self.SetInfoText("Time spent to create any single fur plate. Multiplied when crafting several.")
	elseIf option == CFLaceID
		self.SetInfoText("Time spent to produce a string of hide lace. Multiplied when crafting several.")
	elseIf option == CFTanRackID
		self.SetInfoText("Time spent to assemble a tanning rack.")
	elseIf option == CFMortarID
		self.SetInfoText("Time spent to craft a mortar and pestle, including Hunterborn's Scrimshaw recipe.")
	elseIf option == CFEnchID
		self.SetInfoText("Time spent to craft a set of enchanting supplies.")
	elseIf option == CFFirecraftImprovesID
		self.SetInfoText("Should the Firecraft perk of Campfire speed up the firecraft times at 20% off for each rank.\nDoes not help lighting with a torch or spell.")
	elseIf option == CFMakeTinderID
		self.SetInfoText("Time spent making tinder from everyday objects.")
	elseIf option == CFMakeKindlingID
		self.SetInfoText("Time spent making kindling from everyday objects.")
	elseIf option == CFAddTinderID
		self.SetInfoText("Time spent prepping tinder on the campfire.")
	elseIf option == CFAddKindlingID
		self.SetInfoText("Time spent arranging kindling on the campfire.")
	elseIf option == CFLightFireID
		self.SetInfoText("Time spent trying to spark the fire.\nSpells and torches take one quarter this time.")
	elseIf option == CFAddFuelID
		self.SetInfoText("Time spent tending to the fire, to replenish fuel or make it bigger.")
	elseIf option == FFSnowberryID
		self.SetInfoText("Time spent making snowberry extract.")
	elseIf option == RNWaterskinID
		self.SetInfoText("Time spent to craft a waterskin, including Hunterborn's recipe.")
	elseIf option == RNCookpotID
		self.SetInfoText("Time spent to craft a cast iron pot at the forge.")
	elseIf option == RNTinderboxID
		self.SetInfoText("Time spent to forge and assemble a tinderbox.")
	elseIf option == RNBedrollID
		self.SetInfoText("Time spent to craft a traveller's bedroll.")
	elseIf option == RNTentID
		self.SetInfoText("Time spent to craft a traveller's tent.")
	elseIf option == RNMilkBucketID
		self.SetInfoText("Time spent preparing a common bucket for use as a milk bucket, at the tanning rack.")
	elseIf option == RNFoodSnackID
		self.SetInfoText("Time spent eating a snack, or candy or fruit. Compatible with any food patched to have RND effects.")
	elseIf option == RNFoodMediumID
		self.SetInfoText("Time spent eating a medium size meal. Compatible with any food patched to have RND effects.")
	elseIf option == RNFoodFillingID
		self.SetInfoText("Time spent eating a filling meal. Compatible with any food patched to have RND effects.")
	elseIf option == RNWaterDrinkID
		self.SetInfoText("Time spent consuming one drink. Compatible with any beverage patched to have RND effects.")
	elseIf option == RNCookSnackID
		self.SetInfoText("Time spent to cook a snack. Compatible with any food patched to have RND effects. Batches take no extra time.")
	elseIf option == RNCookMediumID
		self.SetInfoText("Time spent to cook a medium size meal. Compatible with any food patched to have RND effects. Batches take no extra time.")
	elseIf option == RNCookFillingID
		self.SetInfoText("Time spent to cook a filling meal. Compatible with any food patched to have RND effects. Batches take no extra time.")
	elseIf option == RNBrewDrinkID
		self.SetInfoText("Time spent to brew any drink, besides plain water. Compatible with any beverage patched to have RND effects. Batches take no extra time.")
	elseIf option == RNWaterPrepID
		self.SetInfoText("Time spent at the cookpot to prepare water from any source. This includes boiling water, or changing from a waterskin to water for cooking.")
	elseIf option == RNSaltID
		self.SetInfoText("Time spent boiling down sea water into a salt pile.")
	elseIf option == HBScrimBitsID
		self.SetInfoText("Time spent to scrimshaw one set of bone bits. Multiplied when crafting several. Harvesting level reduces time taken.")
	elseIf option == HBScrimIdolID
		self.SetInfoText("Time spent to scrimshaw various idol-like artifacts. Harvesting level reduces time taken.")
	elseIf option == HBScrimToolID
		self.SetInfoText("Time spent to scrimshaw various tools. Harvesting level reduces time taken.")
	elseIf option == HBLeatherID
		self.SetInfoText("Time spent to craft 1 piece of leather. Applies to tanning rack AND all other sources, such as armor breakdown. Harvesting level reduces time taken.")
	elseIf option == HBStripID
		self.SetInfoText("Time spent to craft 3 leather strips. Applies to ANY source of leather strips. Harvesting level reduces time taken.")
	elseIf option == HBWeapArmorTipID
		self.SetInfoText("Scrimshaw's weapons and armors use the times set in Crafting, but use Harvesting level to reduce time taken, not Smithing.")
	elseIf option == HBBedrollID
		self.SetInfoText("Time spent to craft a hunter's bedroll, at the tanning rack. Harvesting level reduces time taken.")
	elseIf option == HBIngrID
		self.SetInfoText("Time spent to rework certain ingredients, such as polished eyes. Harvesting level reduces time taken.")
	elseIf option == HBBrewID
		self.SetInfoText("Time spent when brewing any of Hunterborn's custom potions at the cookpot.")
	elseIf option == HBTallowID
		self.SetInfoText("Time spent to craft each piece of tallow. Used only in the Hunterborn + Lanterns and Candles patch.")
	elseIf option == HBArrowsID
		self.SetInfoText("Time spent to craft a batch of arrows with Scrimshaw. Same time for either 24 with firewood, or 12 with animal bones.")
	elseIf option == WLLanternID
		self.SetInfoText("Make a lantern wearable by attaching a leather strip. Done at the forge, but not considered smithing.")
	elseIf option == WLChassisID
		self.SetInfoText("Craft a lantern chassis at a forge. It can then be converted into a wearable lantern.")
	elseIf option == WLOilID
		self.SetInfoText("Crafting lantern oil is possible with other mods, such as Hunterborn.")
	elseIf option == LCBasicID
		self.SetInfoText("Simple assembly, like a candle in a wine bottle. Done at the forge, but not considered smithing.")
	elseIf option == LCForgeID
		self.SetInfoText("Wrought iron work done at a forge, such as lanterns and shrines.")
	elseIf option == LCArcaneID
		self.SetInfoText("Sophisticated works requiring skill as an arcane blacksmith, such as a wizard's lamp.")
	elseIf option == LCBrewID
		self.SetInfoText("Time spent to sculpt one candle at the cookpot. Multiplied when crafting several.")
	endIf
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function OnOptionSliderOpen(Int option)

	if option == readMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.readMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == showMessageThresholdID
		self.SetSliderDialogStartValue(ReadingTakesTime.showMessageThreshold as Float)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(1.00000, 59.0000)
		self.SetSliderDialogInterval(1.00000)
	elseIf option == readingIncreaseMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.readingIncreaseMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 10.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == spellLearnTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.spellLearnTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == headCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.headCraftTime)
		self.SetSliderDialogDefaultValue(3.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == armorCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.armorCraftTime)
		self.SetSliderDialogDefaultValue(6.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == handsCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.handsCraftTime)
		self.SetSliderDialogDefaultValue(3.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == feetCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.feetCraftTime)
		self.SetSliderDialogDefaultValue(3.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == shieldCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.shieldCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == jewelryCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.jewelryCraftTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == battleAxeCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.battleAxeCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == bowCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.bowCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == daggerCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.daggerCraftTime)
		self.SetSliderDialogDefaultValue(3.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == greatswordCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.greatswordCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == maceCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.maceCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == staffCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.staffCraftTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == swordCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.swordCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == warhammerCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.warhammerCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == warAxeCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.warAxeCraftTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == weaponCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.weaponCraftTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == miscCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.miscCraftTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == armorImproveTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.armorImproveTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == weaponImproveTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.weaponImproveTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == enchantingTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.enchantingTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == potionCraftTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.potionCraftTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == lootMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.lootMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == pickMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.pickMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == pickpocketMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.pickpocketMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == LightAmorID
		self.SetSliderDialogStartValue(ReadingTakesTime.lightArmorTime)
		self.SetSliderDialogDefaultValue(15 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == HeavyArmorID
		self.SetSliderDialogStartValue(ReadingTakesTime.heavyArmorTime)
		self.SetSliderDialogDefaultValue(45 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == trainingMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.trainingMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == trainingTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.trainingTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == levelUpMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.levelUpMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == levelUpTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.levelUpTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == inventoryMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.inventoryMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == eatTimeID
		self.SetSliderDialogStartValue(ReadingTakesTime.eatTime)
		self.SetSliderDialogDefaultValue(5 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == magicMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.magicMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == journalMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.journalMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == mapMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.mapMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == barterMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.barterMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == giftMultID
		self.SetSliderDialogStartValue(ReadingTakesTime.giftMult)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 4.00000)
		self.SetSliderDialogInterval(0.0500000)
	elseIf option == CFCloakID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfCloakTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfCloakTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFStickID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfStickTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfStickTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFTorchID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfTorchTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfTorchTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFCookpotID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfCookpotTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfCookpotTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFBackpackID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfBackpackTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfBackpackTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFBeddingID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfBeddingTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfBeddingTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFSmallTentID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfSmallTentTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfSmallTentTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFLargeTentID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfLargeTentTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfLargeTentTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFHatchetID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfHatchetTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfHatchetTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFArrowsID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfArrowsTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfArrowsTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFLinenID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfLinenTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfLinenTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFFurID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfFurTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfFurTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFLaceID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfLaceTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfLaceTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFTanRackID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfTanRackTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfTanRackTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFMortarID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfMortarTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfMortarTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFEnchID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfEnchTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfEnchTime)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == CFMakeTinderID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfMakeTinderTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfMakeTinderTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFMakeKindlingID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfMakeKindlingTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfMakeKindlingTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFAddTinderID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfAddTinderTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfAddTinderTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFAddKindlingID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfAddKindlingTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfAddKindlingTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFLightFireID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfLightFireTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfLightFireTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == CFAddFuelID
		self.SetSliderDialogStartValue(ReadingTakesTime.cfAddFuelTime)
		self.SetSliderDialogDefaultValue(self.DEF_cfAddFuelTime)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == FFSnowberryID
		self.SetSliderDialogStartValue(ReadingTakesTime.ffSnowberryTime)
		self.SetSliderDialogDefaultValue(self.DEF_Extract)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNWaterskinID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnWaterskinTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == RNCookpotID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnCookpotTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == RNTinderboxID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnTinderboxTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == RNBedrollID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnBedrollTime)
		self.SetSliderDialogDefaultValue(3.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == RNTentID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnTentTime)
		self.SetSliderDialogDefaultValue(4.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == RNMilkBucketID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnMilkBucketTime)
		self.SetSliderDialogDefaultValue(5 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNFoodSnackID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnEatSnackTime)
		self.SetSliderDialogDefaultValue(2 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNFoodMediumID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnEatMediumTime)
		self.SetSliderDialogDefaultValue(10 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNFoodFillingID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnEatFillingTime)
		self.SetSliderDialogDefaultValue(30 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNWaterDrinkID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnDrinkTime)
		self.SetSliderDialogDefaultValue(2 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNCookSnackID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnCookSnackTime)
		self.SetSliderDialogDefaultValue(10 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNCookMediumID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnCookMediumTime)
		self.SetSliderDialogDefaultValue(20 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNCookFillingID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnCookFillingTime)
		self.SetSliderDialogDefaultValue(45 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNBrewDrinkID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnBrewTime)
		self.SetSliderDialogDefaultValue(15 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNWaterPrepID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnWaterPrepTime)
		self.SetSliderDialogDefaultValue(5 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == RNSaltID
		self.SetSliderDialogStartValue(ReadingTakesTime.rnSaltTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == HBScrimBitsID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbScrimBitsTime)
		self.SetSliderDialogDefaultValue(5 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == HBScrimIdolID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbScrimIdolTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == HBScrimToolID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbScrimToolTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == HBLeatherID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbLeatherTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == HBStripID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbStripTime)
		self.SetSliderDialogDefaultValue(30 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == HBBedrollID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbBedrollTime)
		self.SetSliderDialogDefaultValue(3.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == HBIngrID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbIngrTime)
		self.SetSliderDialogDefaultValue(30 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == HBBrewID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbBrewTime)
		self.SetSliderDialogDefaultValue(30 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == HBTallowID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbTallowTime)
		self.SetSliderDialogDefaultValue(10 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == HBArrowsID
		self.SetSliderDialogStartValue(ReadingTakesTime.hbArrowsTime)
		self.SetSliderDialogDefaultValue(1.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == WLLanternID
		self.SetSliderDialogStartValue(ReadingTakesTime.wlWearableTime)
		self.SetSliderDialogDefaultValue(30 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == WLChassisID
		self.SetSliderDialogStartValue(ReadingTakesTime.wlChassisTime)
		self.SetSliderDialogDefaultValue(2.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == WLOilID
		self.SetSliderDialogStartValue(ReadingTakesTime.wlOilTime)
		self.SetSliderDialogDefaultValue(30 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == LCBasicID
		self.SetSliderDialogStartValue(ReadingTakesTime.lcBasicTime)
		self.SetSliderDialogDefaultValue(10 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	elseIf option == LCForgeID
		self.SetSliderDialogStartValue(ReadingTakesTime.lcForgeTime)
		self.SetSliderDialogDefaultValue(3.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == LCArcaneID
		self.SetSliderDialogStartValue(ReadingTakesTime.lcArcaneTime)
		self.SetSliderDialogDefaultValue(6.00000)
		self.SetSliderDialogRange(0.000000, 24.0000)
		self.SetSliderDialogInterval(0.100000)
	elseIf option == LCBrewID
		self.SetSliderDialogStartValue(ReadingTakesTime.lcBrewTime)
		self.SetSliderDialogDefaultValue(15 as Float)
		self.SetSliderDialogRange(0 as Float, 60 as Float)
		self.SetSliderDialogInterval(1 as Float)
	endIf
endFunction

function InitMod()

	if isModActive
		self.DebugMode("Initializing...")
		ReadingTakesTime.StartReading = utility.GetCurrentRealTime()
		ReadingTakesTime.StopReading = utility.GetCurrentRealTime()
		if isReadingActive
			self.RegisterForMenu("Book Menu")
		else
			self.UnregisterForMenu("Book Menu")
		endIf
		if isCraftingActive
			self.RegisterForMenu("Crafting Menu")
		else
			self.UnregisterForMenu("Crafting Menu")
		endIf
		if isContainerActive
			self.RegisterForMenu("ContainerMenu")
		else
			self.UnregisterForMenu("ContainerMenu")
		endIf
		if isLockpickActive
			self.RegisterForMenu("Lockpicking Menu")
		else
			self.UnregisterForMenu("Lockpicking Menu")
		endIf
		if isTrainingActive
			self.RegisterForMenu("Training Menu")
		else
			self.UnregisterForMenu("Training Menu")
		endIf
		if isLevelUpActive
			self.RegisterForMenu("StatsMenu")
		else
			self.UnregisterForMenu("StatsMenu")
		endIf
		if isInventoryActive
			self.RegisterForMenu("InventoryMenu")
		else
			self.UnregisterForMenu("InventoryMenu")
		endIf
		if isMagicActive
			self.RegisterForMenu("MagicMenu")
		else
			self.UnregisterForMenu("MagicMenu")
		endIf
		if isJournalActive
			self.RegisterForMenu("Journal Menu")
			ReadingTakesTime.StartReading = utility.GetCurrentRealTime()
			ReadingTakesTime.StopReading = utility.GetCurrentRealTime()
		else
			self.UnregisterForMenu("Journal Menu")
		endIf
		if isMapActive
			self.RegisterForMenu("MapMenu")
		else
			self.UnregisterForMenu("MapMenu")
		endIf
		if isBarterActive
			self.RegisterForMenu("BarterMenu")
		else
			self.UnregisterForMenu("BarterMenu")
		endIf
		if isGiftActive
			self.RegisterForMenu("GiftMenu")
		else
			self.UnregisterForMenu("GiftMenu")
		endIf
		self.DebugMode("Checking mod dependencies, ignore errors below about missing files...")
		ReadingTakesTime.Init_HF_Exclusions()
		ReadingTakesTime.CheckModStatus()
		self.DebugMode("Done initializing!")
	else
		self.UnregisterForAllMenus()
		self.UnregisterForCrosshairRef()
	endIf
	ReadingTakesTime.InitStats(isModActive)
endFunction

function OnConfigInit()

	ModName = "Living Takes Time"
	Pages = new String[11]
	Pages[0] = "$General"
	Pages[1] = "$Reading"
	Pages[2] = "$Crafting"
	Pages[3] = "$Looting"
	Pages[4] = "$Training"
	Pages[5] = "$Preparing"
	Pages[6] = "$Trading"
	Pages[7] = "Campfire"
	Pages[8] = "RND"
	Pages[9] = "Hunterborn"
	Pages[10] = "Lanterns, Candles"
	ReadingTakesTime.StartReading = utility.GetCurrentRealTime()
	ReadingTakesTime.StopReading = utility.GetCurrentRealTime()
	self.UnregisterForAllMenus()
	self.RegisterForMenu("Book Menu")
	self.RegisterForMenu("Crafting Menu")
	self.RegisterForMenu("ContainerMenu")
	self.RegisterForMenu("Lockpicking Menu")
	self.RegisterForMenu("Training Menu")
	self.RegisterForMenu("StatsMenu")
	self.RegisterForMenu("InventoryMenu")
	self.RegisterForMenu("MagicMenu")
	self.RegisterForMenu("Journal Menu")
	self.RegisterForMenu("MapMenu")
	self.RegisterForMenu("BarterMenu")
	self.RegisterForMenu("GiftMenu")
	ReadingTakesTime.showMessage = true
	ReadingTakesTime.dontShowMessage = true
	ReadingTakesTime.showMessageThreshold = 10
	ReadingTakesTime.cantRead = true
	ReadingTakesTime.readMult = 1 as Float
	ReadingTakesTime.armorCraftTime = 4 as Float
	ReadingTakesTime.weaponCraftTime = 4 as Float
	ReadingTakesTime.armorImproveTime = 1 as Float
	ReadingTakesTime.weaponImproveTime = 1 as Float
	ReadingTakesTime.enchantingTime = 1 as Float
	ReadingTakesTime.potionCraftTime = 0.200000
	ReadingTakesTime.cantLoot = true
	ReadingTakesTime.lootMult = 1 as Float
	ReadingTakesTime.cantPick = true
	ReadingTakesTime.pickMult = 1 as Float
	ReadingTakesTime.trainingMult = 1 as Float
	ReadingTakesTime.trainingTime = 2 as Float
	ReadingTakesTime.cantLevelUp = true
	ReadingTakesTime.levelUpMult = 1 as Float
	ReadingTakesTime.levelUpTime = 1 as Float
	ReadingTakesTime.cantInventory = true
	ReadingTakesTime.inventoryMult = 1 as Float
	ReadingTakesTime.eatTime = 5 as Float
	ReadingTakesTime.cantMagic = true
	ReadingTakesTime.magicMult = 1 as Float
	ReadingTakesTime.cantJournal = true
	ReadingTakesTime.journalMult = 1 as Float
	ReadingTakesTime.cantMap = true
	ReadingTakesTime.mapMult = 1 as Float
	ReadingTakesTime.barterMult = 1 as Float
	ReadingTakesTime.giftMult = 1 as Float
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
endFunction

function OnOptionSelect(Int option)

	if option == saveID
		Bool Choice = self.showMessage("$Save Settings?", true, "$Save", "$Cancel")
		if Choice
			self.SaveSettings()
			self.ForcePageReset()
		endIf
	endIf
	if option == loadID
		Bool choice = self.showMessage("$Load Settings?", true, "$Load", "$Cancel")
		if choice
			self.LoadSettings()
			self.ForcePageReset()
		endIf
	endIf
	if option == isModActiveID
		isModActive = !isModActive
		self.SetToggleOptionValue(isModActiveID, isModActive, false)
		self.InitMod()
	elseIf option == isReadingActiveID
		isReadingActive = !isReadingActive
		self.SetToggleOptionValue(isReadingActiveID, isReadingActive, false)
		if isReadingActive
			self.RegisterForMenu("Book Menu")
		else
			self.UnregisterForMenu("Book Menu")
		endIf
	elseIf option == isCraftingActiveID
		isCraftingActive = !isCraftingActive
		self.SetToggleOptionValue(isCraftingActiveID, isCraftingActive, false)
		if isCraftingActive
			self.RegisterForMenu("Crafting Menu")
		else
			self.UnregisterForMenu("Crafting Menu")
		endIf
	elseIf option == isContainerActiveID
		isContainerActive = !isContainerActive
		self.SetToggleOptionValue(isContainerActiveID, isContainerActive, false)
		if isContainerActive
			self.RegisterForMenu("ContainerMenu")
		else
			self.UnregisterForMenu("ContainerMenu")
		endIf
	elseIf option == isLockpickActiveID
		isLockpickActive = !isLockpickActive
		self.SetToggleOptionValue(isLockpickActiveID, isLockpickActive, false)
		if isLockpickActive
			self.RegisterForMenu("Lockpicking Menu")
		else
			self.UnregisterForMenu("Lockpicking Menu")
		endIf
	elseIf option == isTrainingActiveID
		isTrainingActive = !isTrainingActive
		self.SetToggleOptionValue(isTrainingActiveID, isTrainingActive, false)
		if isTrainingActive
			self.RegisterForMenu("Training Menu")
		else
			self.UnregisterForMenu("Training Menu")
		endIf
	elseIf option == isLevelUpActiveID
		isLevelUpActive = !isLevelUpActive
		self.SetToggleOptionValue(isLevelUpActiveID, isLevelUpActive, false)
		if isLevelUpActive
			self.RegisterForMenu("StatsMenu")
		else
			self.UnregisterForMenu("StatsMenu")
		endIf
	elseIf option == isInventoryActiveID
		isInventoryActive = !isInventoryActive
		ReadingTakesTime.isInventoryActive = isInventoryActive
		self.SetToggleOptionValue(isInventoryActiveID, isInventoryActive, false)
		if isInventoryActive
			self.RegisterForMenu("InventoryMenu")
		else
			self.UnregisterForMenu("InventoryMenu")
		endIf
	elseIf option == isMagicActiveID
		isMagicActive = !isMagicActive
		self.SetToggleOptionValue(isMagicActiveID, isMagicActive, false)
		if isMagicActive
			self.RegisterForMenu("MagicMenu")
		else
			self.UnregisterForMenu("MagicMenu")
		endIf
	elseIf option == isJournalActiveID
		isJournalActive = !isJournalActive
		self.SetToggleOptionValue(isJournalActiveID, isJournalActive, false)
		if isJournalActive
			self.RegisterForMenu("Journal Menu")
			ReadingTakesTime.StartReading = utility.GetCurrentRealTime()
			ReadingTakesTime.StopReading = utility.GetCurrentRealTime()
		else
			self.UnregisterForMenu("Journal Menu")
		endIf
	elseIf option == isMapActiveID
		isMapActive = !isMapActive
		self.SetToggleOptionValue(isMapActiveID, isMapActive, false)
		if isMapActive
			self.RegisterForMenu("MapMenu")
		else
			self.UnregisterForMenu("MapMenu")
		endIf
	elseIf option == isBarterActiveID
		isBarterActive = !isBarterActive
		self.SetToggleOptionValue(isBarterActiveID, isBarterActive, false)
		if isBarterActive
			self.RegisterForMenu("BarterMenu")
		else
			self.UnregisterForMenu("BarterMenu")
		endIf
	elseIf option == isGiftActiveID
		isGiftActive = !isGiftActive
		self.SetToggleOptionValue(isGiftActiveID, isGiftActive, false)
		if isGiftActive
			self.RegisterForMenu("GiftMenu")
		else
			self.UnregisterForMenu("GiftMenu")
		endIf
	elseIf option == cantLootID
		ReadingTakesTime.cantLoot = !ReadingTakesTime.cantLoot
		self.SetToggleOptionValue(cantLootID, ReadingTakesTime.cantLoot, false)
	elseIf option == cantPickID
		ReadingTakesTime.cantPick = !ReadingTakesTime.cantPick
		self.SetToggleOptionValue(cantPickID, ReadingTakesTime.cantPick, false)
	elseIf option == showMessageID
		ReadingTakesTime.showMessage = !ReadingTakesTime.showMessage
		self.SetToggleOptionValue(showMessageID, ReadingTakesTime.showMessage, false)
	elseIf option == dontShowMessageID
		ReadingTakesTime.dontShowMessage = !ReadingTakesTime.dontShowMessage
		self.SetToggleOptionValue(dontShowMessageID, ReadingTakesTime.dontShowMessage, false)
	elseIf option == expertiseReducesTimeID
		ReadingTakesTime.expertiseReducesTime = !ReadingTakesTime.expertiseReducesTime
		self.SetToggleOptionValue(expertiseReducesTimeID, ReadingTakesTime.expertiseReducesTime, false)
	elseIf option == cantReadID
		ReadingTakesTime.cantRead = !ReadingTakesTime.cantRead
		self.SetToggleOptionValue(cantReadID, ReadingTakesTime.cantRead, false)
	elseIf option == readingIncreasesSpeechID
		ReadingTakesTime.readingIncreasesSpeech = !ReadingTakesTime.readingIncreasesSpeech
		self.SetToggleOptionValue(readingIncreasesSpeechID, ReadingTakesTime.readingIncreasesSpeech, false)
	elseIf option == cantLevelUpID
		ReadingTakesTime.cantLevelUp = !ReadingTakesTime.cantLevelUp
		self.SetToggleOptionValue(cantLevelUpID, ReadingTakesTime.cantLevelUp, false)
	elseIf option == cantInventoryID
		ReadingTakesTime.cantInventory = !ReadingTakesTime.cantInventory
		self.SetToggleOptionValue(cantInventoryID, ReadingTakesTime.cantInventory, false)
	elseIf option == cantMagicID
		ReadingTakesTime.cantMagic = !ReadingTakesTime.cantMagic
		self.SetToggleOptionValue(cantMagicID, ReadingTakesTime.cantMagic, false)
	elseIf option == cantJournalID
		ReadingTakesTime.cantJournal = !ReadingTakesTime.cantJournal
		self.SetToggleOptionValue(cantJournalID, ReadingTakesTime.cantJournal, false)
	elseIf option == cantMapID
		ReadingTakesTime.cantMap = !ReadingTakesTime.cantMap
		self.SetToggleOptionValue(cantMapID, ReadingTakesTime.cantMap, false)
	elseIf option == CFFirecraftImprovesID
		ReadingTakesTime.cfFirecraftImproves = !ReadingTakesTime.cfFirecraftImproves
		self.SetToggleOptionValue(CFFirecraftImprovesID, ReadingTakesTime.cfFirecraftImproves, false)
	endIf
endFunction

function OnOptionDefault(Int option)

	if option == isModActiveID
		isModActive = true
		self.SetToggleOptionValue(isModActiveID, isModActive, false)
	elseIf option == isReadingActiveID
		isReadingActive = true
		self.SetToggleOptionValue(isReadingActiveID, isReadingActive, false)
	elseIf option == isCraftingActiveID
		isCraftingActive = true
		self.SetToggleOptionValue(isCraftingActiveID, isCraftingActive, false)
	elseIf option == showMessageID
		ReadingTakesTime.showMessage = true
		self.SetToggleOptionValue(showMessageID, ReadingTakesTime.showMessage, false)
	elseIf option == dontShowMessageID
		ReadingTakesTime.dontShowMessage = true
		self.SetToggleOptionValue(dontShowMessageID, ReadingTakesTime.dontShowMessage, false)
	elseIf option == expertiseReducesTimeID
		ReadingTakesTime.expertiseReducesTime = true
		self.SetToggleOptionValue(expertiseReducesTimeID, ReadingTakesTime.expertiseReducesTime, false)
	elseIf option == cantReadID
		ReadingTakesTime.cantRead = true
		self.SetToggleOptionValue(cantReadID, ReadingTakesTime.cantRead, false)
	elseIf option == readingIncreasesSpeechID
		ReadingTakesTime.readingIncreasesSpeech = true
		self.SetToggleOptionValue(readingIncreasesSpeechID, ReadingTakesTime.readingIncreasesSpeech, false)
	elseIf option == cantLootID
		ReadingTakesTime.cantLoot = true
		self.SetToggleOptionValue(cantLootID, ReadingTakesTime.cantLoot, false)
	elseIf option == cantPickID
		ReadingTakesTime.cantPick = true
		self.SetToggleOptionValue(cantPickID, ReadingTakesTime.cantPick, false)
	elseIf option == cantLevelUpID
		ReadingTakesTime.cantLevelUp = true
		self.SetToggleOptionValue(cantLevelUpID, ReadingTakesTime.cantLevelUp, false)
	elseIf option == cantInventoryID
		ReadingTakesTime.cantInventory = true
		self.SetToggleOptionValue(cantInventoryID, ReadingTakesTime.cantInventory, false)
	elseIf option == cantMagicID
		ReadingTakesTime.cantMagic = true
		self.SetToggleOptionValue(cantMagicID, ReadingTakesTime.cantMagic, false)
	elseIf option == cantJournalID
		ReadingTakesTime.cantJournal = true
		self.SetToggleOptionValue(cantJournalID, ReadingTakesTime.cantJournal, false)
	elseIf option == cantMapID
		ReadingTakesTime.cantMap = true
		self.SetToggleOptionValue(cantMapID, ReadingTakesTime.cantMap, false)
	endIf
endFunction

Int function GetVersion()

	return 13
endFunction

function SetModDefaults()

	ReadingTakesTime.cfCloakTime = self.DEF_cfCloakTime
	ReadingTakesTime.cfStickTime = self.DEF_cfStickTime
	ReadingTakesTime.cfTorchTime = self.DEF_cfTorchTime
	ReadingTakesTime.cfCookpotTime = self.DEF_cfCookpotTime
	ReadingTakesTime.cfBackpackTime = self.DEF_cfBackpackTime
	ReadingTakesTime.cfBeddingTime = self.DEF_cfBeddingTime
	ReadingTakesTime.cfSmallTentTime = self.DEF_cfSmallTentTime
	ReadingTakesTime.cfLargeTentTime = self.DEF_cfLargeTentTime
	ReadingTakesTime.cfHatchetTime = self.DEF_cfHatchetTime
	ReadingTakesTime.cfArrowsTime = self.DEF_cfArrowsTime
	ReadingTakesTime.cfLinenTime = self.DEF_cfLinenTime
	ReadingTakesTime.cfFurTime = self.DEF_cfFurTime
	ReadingTakesTime.cfLaceTime = self.DEF_cfLaceTime
	ReadingTakesTime.cfTanRackTime = self.DEF_cfTanRackTime
	ReadingTakesTime.cfMortarTime = self.DEF_cfMortarTime
	ReadingTakesTime.cfEnchTime = self.DEF_cfEnchTime
	ReadingTakesTime.cfFirecraftImproves = self.DEF_cfFirecraftImproves
	ReadingTakesTime.cfMakeTinderTime = self.DEF_cfMakeTinderTime
	ReadingTakesTime.cfMakeKindlingTime = self.DEF_cfMakeKindlingTime
	ReadingTakesTime.cfAddTinderTime = self.DEF_cfAddTinderTime
	ReadingTakesTime.cfAddKindlingTime = self.DEF_cfAddKindlingTime
	ReadingTakesTime.cfLightFireTime = self.DEF_cfLightFireTime
	ReadingTakesTime.cfAddFuelTime = self.DEF_cfAddFuelTime
	ReadingTakesTime.ffSnowberryTime = self.DEF_Extract
	ReadingTakesTime.rnWaterskinTime = 2 as Float
	ReadingTakesTime.rnCookpotTime = 1 as Float
	ReadingTakesTime.rnTinderboxTime = 2 as Float
	ReadingTakesTime.rnBedrollTime = 3 as Float
	ReadingTakesTime.rnTentTime = 4 as Float
	ReadingTakesTime.rnMilkBucketTime = 5 as Float
	ReadingTakesTime.rnEatSnackTime = 2 as Float
	ReadingTakesTime.rnEatMediumTime = 10 as Float
	ReadingTakesTime.rnEatFillingTime = 30 as Float
	ReadingTakesTime.rnDrinkTime = 2 as Float
	ReadingTakesTime.rnCookSnackTime = 10 as Float
	ReadingTakesTime.rnCookMediumTime = 20 as Float
	ReadingTakesTime.rnCookFillingTime = 45 as Float
	ReadingTakesTime.rnBrewTime = 15 as Float
	ReadingTakesTime.rnWaterPrepTime = 5 as Float
	ReadingTakesTime.rnSaltTime = 2 as Float
	ReadingTakesTime.hbLeatherTime = 1 as Float
	ReadingTakesTime.hbStripTime = 30 as Float
	ReadingTakesTime.hbScrimBitsTime = 5 as Float
	ReadingTakesTime.hbTallowTime = 10 as Float
	ReadingTakesTime.hbIngrTime = 30 as Float
	ReadingTakesTime.hbBrewTime = 30 as Float
	ReadingTakesTime.hbScrimIdolTime = 2 as Float
	ReadingTakesTime.hbScrimToolTime = 1 as Float
	ReadingTakesTime.hbBedrollTime = 3 as Float
	ReadingTakesTime.hbArrowsTime = 1 as Float
	ReadingTakesTime.wlWearableTime = 30 as Float
	ReadingTakesTime.wlChassisTime = 2 as Float
	ReadingTakesTime.wlOilTime = 30 as Float
	ReadingTakesTime.lcBasicTime = 10 as Float
	ReadingTakesTime.lcForgeTime = 3 as Float
	ReadingTakesTime.lcArcaneTime = 6 as Float
	ReadingTakesTime.lcBrewTime = 15 as Float
endFunction

function ReassignHotKeys()

	self.ReassignHotkey(ReadingTakesTime.hotkeySuspend, "hotkeySuspend")
endFunction

function ReassignHotkey(Int aiKeyCode, String akName)

	if aiKeyCode
		self.RegisterForKey(aiKeyCode)
	endIf
endFunction

function LoadSettings()

	fissinterface fiss = fissfactory.getFISS()
	if !fiss
		debug.MessageBox("FISS not installed. Loading disabled")
		return 
	endIf
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
	String loadResult = fiss.endLoad()
	if loadResult != ""
		self.DebugMode(loadResult)
	endIf
	self.InitMod()
endFunction

function OnGameReload()

	parent.OnGameReload()
	ReadingTakesTime.Suspended = false
	self.InitMod()
	self.ReassignHotKeys()
endFunction
