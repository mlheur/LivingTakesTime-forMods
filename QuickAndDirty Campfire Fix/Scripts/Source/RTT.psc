scriptName RTT extends Quest

;-- Properties --------------------------------------
Float property swordCraftTime auto
Float property levelUpMult auto
Float property greatswordCraftTime auto
Bool property cfFirecraftImproves auto
Bool property cantPick auto
globalvariable property GameHour auto
Float property magicMult auto
Float property daggerCraftTime auto
Float property cfLargeTentTime auto
Float property enchantingTime auto
Float property lcArcaneTime auto
Int property showMessageThreshold auto
Float property cfSmallTentTime auto
Bool property cantInventory auto
Float property rnMilkBucketTime auto
Float property weaponCraftTime auto
message property RTT_CantRead auto
Float property StartReading auto
Float property rnBrewTime auto
Float property hbIngrTime auto
Bool property cantMap auto
Float property lcBasicTime auto
Float property cfEnchTime auto
Float property pickMult auto
Float property handsCraftTime auto
Float property cfArrowsTime auto
globalvariable property TimeScale auto
Float property jewelryCraftTime auto
Float property hbScrimToolTime auto
Float property trainingMult auto
Bool property isInventoryActive auto
Float property lootMult auto
Float property hbBedrollTime auto
Bool property cantMagic auto
Bool property dontShowMessage auto
Float property rnCookpotTime auto
Float property wlWearableTime auto
Float property hbArrowsTime auto
Float property cfTorchTime auto
Bool property readingIncreasesSpeech auto
Float property wlOilTime auto
Float property hbScrimIdolTime auto
Float property hbBrewTime auto
Float property hbStripTime auto
Float property wlChassisTime auto
Float property rnEatFillingTime auto
Float property cfLaceTime auto
Bool property cantLoot auto
Float property hbScrimBitsTime auto
Float property hbTallowTime auto
Bool property showMessage auto
Float property hbLeatherTime auto
Float property rnEatSnackTime auto
Float property rnWaterPrepTime auto
Float property cfCookpotTime auto
Float property miscCraftTime auto
Float property ffSnowberryTime auto
Float property lcForgeTime auto
Float property cfFurTime auto
Float property rnDrinkTime auto
Float property readingIncreaseMult auto
Bool property cantJournal auto
Float property mineTime auto
Float property rnCookMediumTime auto
Float property rnCookSnackTime auto
Float property shieldCraftTime auto
Float property rnEatMediumTime auto
Float property rnSaltTime auto
Float property cfAddTinderTime auto
Float property rnCookFillingTime auto
Float property warhammerCraftTime auto
Bool property cantLevelUp auto
Float property rnTinderboxTime auto
Float property harvestTime auto
Float property cfLinenTime auto
Float property armorCraftTime auto
Int property hotkeySuspend auto
Float property weaponImproveTime auto
Float property potionCraftTime auto
Float property eatTime auto
Float property battleAxeCraftTime auto
Bool property Suspended auto
Float property spellLearnTime auto
Float property cfLightFireTime auto
Float property cfAddKindlingTime auto
Float property rnTentTime auto
Float property warAxeCraftTime auto
Float property trainingTime auto
Float property cfMakeKindlingTime auto
Float property headCraftTime auto
Float property lcBrewTime auto
Float property inventoryMult auto
Float property readMult auto
Float property cfStickTime auto
Float property barterMult auto
Float property rnWaterskinTime auto
Float property heavyArmorTime auto
Float property cfBeddingTime auto
Bool property expertiseReducesTime auto
Float property cfCloakTime auto
Float property pickpocketMult auto
Float property cfMortarTime auto
Float property feetCraftTime auto
Float property StopReading auto
Float property mapMult auto
Float property chopTime auto
Float property rnBedrollTime auto
Float property cfMakeTinderTime auto
Float property staffCraftTime auto
Float property maceCraftTime auto
Bool property cantRead auto
Float property cfBackpackTime auto
message property RTT_Message auto
Float property giftMult auto
Float property cfTanRackTime auto
Float property lightArmorTime auto
Float property levelUpTime auto
Float property journalMult auto
Float property cfHatchetTime auto
Float property bowCraftTime auto
Float property cfAddFuelTime auto
Float property armorImproveTime auto

;-- Variables ---------------------------------------
Bool _is_RN_Active = false
Bool looting = false
MagicEffect RN_Mgef_Food_Candy
Form RN_Items_Bedroll
Int RN_Prefix = 0
Form HB_Items_CacheMarker
Form[] CF_Items_SmallTents_MoreBR
Int CF_Prefix = 0
Int closePotions = 0
Form CF_Items_Lace
Form CF_Items_Stick
Form CF_Items_RoughBedding
Bool _is_FF_Active = false
Form CF_Items_Torch
Int FF_Prefix
Int openLevel = 0
MagicEffect RN_Mgef_Food_Medium
Bool CF_Splitting_Torch = false
Form[] CF_Fire_Tinder
Form[] LC_Items_Basic
Form CF_Items_TorchDeconstruct
Bool _critSection = false
Form WL_Items_Oil
Form CF_Items_Cookpot
Int closeTraining = 0
Int LC_Prefix = 0
Actor LastTarget
Form WL_Items_Wearable
Form[] CF_Items_Cloaks
Int WL_Prefix = 0
globalvariable HB_Harvest_Level
Bool CF_Splitting_Linen = false
globalvariable HB_Skin_Level
Bool _is_WL_Active = false
Form CF_Items_Hatchet
Form[] HB_Items_Lures
Form RN_Items_Cookpot
Form[] CF_Items_LargeTents_MoreBR
Form HB_Items_Tallow
Form HB_Items_Bedroll
Form[] HB_Items_ScrimTools
Bool isRegisteredForEvents = false
Bool _is_LC_Active = false
Form FF_SnowberryExtract
Form[] HF_Exclusions
Form[] HB_Items_Vanilla
Int closeArmorsImproved = 0
Form RN_Items_Tent
Bool CF_Splitting_Amulet = false
Form CF_Items_FurPlate
Form CF_Fire_Kindling
Int openEat = 0
Int openEnchantings = 0
MagicEffect RN_Mgef_Food_Filling
MagicEffect RN_Mgef_Food_Snack
globalvariable CF_Fire_Firecraft
MagicEffect[] RN_Mgef_Drinks
Form[] CF_Items_Backpacks
Int openSpell = 0
Form[] RN_Items_Salt
Form[] RN_Items_Water
Int openWeaponsImproved = 0
String crafting_furniture = ""
Form RN_Items_MilkBucket
Form RN_Items_Tinderbox
Int openTraining = 0
Int HB_Prefix = 0
Bool CF_Splitting_Bedroll = false
Int closeWeaponsImproved = 0
Bool CF_Splitting_Pack = false
Bool CloseBook = false
Form HB_Items_ScrimBits
Int openArmorsImproved = 0
Form HB_Items_Leather
Form RN_Items_Waterskin
MagicEffect[] RN_Mgef_Foods
Form LC_Items_Candle
Bool _isModActive = false
Form CF_Items_Ench
Form CF_Items_Mortar
Form[] CF_Items_LargeTents_1BR
Form CF_Items_TanRack
Int closePoisons = 0
Int openPoisons = 0
Form WL_Items_Chassis
Form CF_Items_Linen
Int openPotions = 0
Form[] HB_Items_ScrimIdols
Bool crafting = false
Bool _is_CF_Active = false
Form[] LC_Items_Arcane
Form CF_BlankItem
Form[] CF_Items_SmallTents_1BR
Form HB_Items_LeatherStrips
Bool _is_HB_Active = false
Form FF_Dummy
Int closeLevel = 0
Int closeEat = 0
Bool _debugMode = true
MagicEffect RN_Mgef_Food_Fruit
Int closeEnchantings = 0

;-- Functions ---------------------------------------

Bool function Check_WL_Craft(Form akBaseItem, Int aiItemCount)

	Float t
	self.DebugMode("Check_WL_Craft...")
	if akBaseItem == WL_Items_Wearable
		t = self.ToMinutes(wlWearableTime)
		self.DebugMode("Travel Lantern. Base time = " + t as String)
		self.TimeCalc(t)
	elseIf akBaseItem == WL_Items_Chassis
		self.DebugMode("Lantern chassis. Base time = " + wlChassisTime as String + "; Smithing = " + game.GetPlayer().GetActorValue("Smithing") as String + "; Mult = " + self.ExpertiseMultiplier("Smithing") as String)
		self.TimeCalc(wlChassisTime * self.ExpertiseMultiplier("Smithing"))
	elseIf akBaseItem == WL_Items_Oil
		t = self.ToMinutes(wlOilTime)
		Float totalBaseTime = t * aiItemCount as Float
		self.DebugMode("Lantern oil. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
		self.TimeCalc(totalBaseTime)
	else
		self.DebugMode("No match found. This one's free!")
	endIf
	return true
endFunction

function Init_LC_Items()

	LC_Items_Candle = game.GetFormFromFile(9038, "lanterns.esp")
	LC_Prefix = self.GetFormPrefix(LC_Items_Candle)
	_is_LC_Active = LC_Prefix > 0
	self.DebugMode("LC prefix: " + LC_Prefix as String)
	if !_is_LC_Active
		return 
	endIf
	LC_Items_Basic = new Form[7]
	LC_Items_Basic[0] = game.GetFormFromFile(10444, "lanterns.esp")
	LC_Items_Basic[1] = game.GetFormFromFile(10439, "lanterns.esp")
	LC_Items_Basic[2] = game.GetFormFromFile(10434, "lanterns.esp")
	LC_Items_Basic[3] = game.GetFormFromFile(10424, "lanterns.esp")
	LC_Items_Basic[4] = game.GetFormFromFile(6243, "lanterns.esp")
	LC_Items_Basic[5] = game.GetFormFromFile(6248, "lanterns.esp")
	LC_Items_Basic[6] = game.GetFormFromFile(3442, "lanterns.esp")
	LC_Items_Arcane = new Form[2]
	LC_Items_Arcane[0] = game.GetFormFromFile(17348, "lanterns.esp")
	LC_Items_Arcane[1] = game.GetFormFromFile(14583, "lanterns.esp")
endFunction

Float function FirecraftModifier(Float TV)

	Float NewTV = TV
	if cfFirecraftImproves
		NewTV = TV - TV * CF_Fire_Firecraft.GetValueInt() as Float * 0.200000
	endIf
	return NewTV
endFunction

Bool function isPlayerPickpocketing()

	Bool isPickpocketing = false
	LastTarget = game.GetCurrentCrosshairRef() as Actor
	if LastTarget as Bool && !LastTarget.isDead() && game.GetPlayer().isSneaking()
		isPickpocketing = true
	endIf
	return isPickpocketing
endFunction

Float function HB_ExpMult_Skin()

	return self.Base10Bonus(HB_Skin_Level.GetValueInt())
endFunction

function Init_RN_Items()

	RN_Items_Bedroll = game.GetFormFromFile(96205, "RealisticNeedsandDiseases.esp")
	RN_Prefix = self.GetFormPrefix(RN_Items_Bedroll)
	_is_RN_Active = RN_Prefix > 0
	self.DebugMode("RND prefix: " + RN_Prefix as String)
	if !_is_RN_Active
		return 
	endIf
	RN_Items_Waterskin = game.GetFormFromFile(287895, "RealisticNeedsandDiseases.esp")
	RN_Items_Cookpot = game.GetForm(203003)
	RN_Items_Tinderbox = game.GetFormFromFile(198268, "RealisticNeedsandDiseases.esp")
	RN_Items_Tent = game.GetFormFromFile(201028, "RealisticNeedsandDiseases.esp")
	RN_Items_MilkBucket = game.GetFormFromFile(728297, "RealisticNeedsandDiseases.esp")
	RN_Items_Water = new Form[11]
	RN_Items_Water[0] = game.GetFormFromFile(22888, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[1] = game.GetFormFromFile(21484, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[2] = game.GetFormFromFile(21486, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[3] = game.GetFormFromFile(21488, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[4] = game.GetFormFromFile(64416, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[5] = game.GetFormFromFile(64409, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[6] = game.GetFormFromFile(64411, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[7] = game.GetFormFromFile(294804, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[8] = game.GetFormFromFile(294806, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[9] = game.GetFormFromFile(294810, "RealisticNeedsandDiseases.esp")
	RN_Items_Water[10] = game.GetFormFromFile(294808, "RealisticNeedsandDiseases.esp")
	RN_Items_Salt = new Form[4]
	RN_Items_Salt[0] = game.GetFormFromFile(428594, "RealisticNeedsandDiseases.esp")
	RN_Items_Salt[1] = game.GetFormFromFile(428595, "RealisticNeedsandDiseases.esp")
	RN_Items_Salt[2] = game.GetFormFromFile(428596, "RealisticNeedsandDiseases.esp")
	RN_Items_Salt[3] = game.GetFormFromFile(434113, "RealisticNeedsandDiseases.esp")
	RN_Mgef_Drinks = new MagicEffect[6]
	RN_Mgef_Drinks[0] = game.GetFormFromFile(25655, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Drinks[1] = game.GetFormFromFile(69967, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Drinks[2] = game.GetFormFromFile(69968, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Drinks[3] = game.GetFormFromFile(64415, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Drinks[4] = game.GetFormFromFile(410666, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Drinks[5] = game.GetFormFromFile(114134, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Food_Snack = game.GetFormFromFile(13173, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Food_Medium = game.GetFormFromFile(18713, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Food_Filling = game.GetFormFromFile(18712, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Food_Candy = game.GetFormFromFile(15949, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Food_Fruit = game.GetFormFromFile(69965, "RealisticNeedsandDiseases.esp") as MagicEffect
	RN_Mgef_Foods = new MagicEffect[5]
	RN_Mgef_Foods[0] = RN_Mgef_Food_Snack
	RN_Mgef_Foods[1] = RN_Mgef_Food_Medium
	RN_Mgef_Foods[2] = RN_Mgef_Food_Filling
	RN_Mgef_Foods[3] = RN_Mgef_Food_Candy
	RN_Mgef_Foods[4] = RN_Mgef_Food_Fruit
endFunction

Bool function HandleFirepit(Form akBaseItem)

	Int majorId = akBaseItem.GetFormID()
	Int mask = math.LeftShift(CF_Prefix, 24)
	Int minorId = majorId - mask
	Int Act = -1
	if minorId >= 208424 && minorId <= 208426
		Act = 3
	elseIf minorId >= 209805 && minorId <= 209811
		Act = 4
	elseIf minorId >= 288961 && minorId <= 370762
		Act = 2
	elseIf minorId == 370769 || minorId == 370770
		Act = 0
	elseIf minorId == 370771
		Act = 1
	elseIf minorId >= 373528 && minorId <= 373537
		Act = 2
	elseIf minorId >= 376326 && minorId <= 376335
		Act = 4
	endIf
	if Act == 0
		return self.TimeCalc(self.ToMinutes(cfLightFireTime * 0.250000))
	elseIf Act == 1
		return self.TimeCalc(self.ToMinutes(self.FirecraftModifier(cfLightFireTime)))
	elseIf Act == 2
		return self.TimeCalc(self.ToMinutes(self.FirecraftModifier(cfAddTinderTime)))
	elseIf Act == 3
		return self.TimeCalc(self.ToMinutes(self.FirecraftModifier(cfAddKindlingTime)))
	elseIf Act == 4
		return self.TimeCalc(self.ToMinutes(self.FirecraftModifier(cfAddFuelTime)))
	endIf
	return false
endFunction

Float function Base10Bonus(Int aiBase)

	Float bonus = aiBase as Float
	return 1.00000 - 0.500000 * bonus / 10 as Float
endFunction

Bool function HandleFrostfallMod(Form akBaseItem, Int aiType, Int aiItemCount)

	Float t = 0.000000
	if akBaseItem == FF_SnowberryExtract
		t = self.ToMinutes(ffSnowberryTime)
		self.DebugMode("Snowberry Extract. Base time = " + t as String)
		return self.TimeCalc(t)
	endIf
	if aiType == 32 && akBaseItem == FF_Dummy
		return true
	endIf
	return false
endFunction

function Init_WL_Items()

	WL_Items_Wearable = game.GetFormFromFile(4809, "Chesko_WearableLantern.esp")
	WL_Prefix = self.GetFormPrefix(WL_Items_Wearable)
	_is_WL_Active = WL_Prefix > 0
	self.DebugMode("WL prefix: " + WL_Prefix as String)
	if !_is_WL_Active
		return 
	endIf
	WL_Items_Chassis = game.GetForm(202988)
	WL_Items_Oil = game.GetFormFromFile(8960, "Chesko_WearableLantern.esp")
endFunction

Float function ToMinutes(Float afTime)

	return afTime / 100 as Float / 3 as Float * 5 as Float
endFunction

function ItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)

	if !_isModActive || ui.IsMenuOpen("Console")
		return 
	endIf
	if akBaseItem.GetWeight() < 0.0100000
		self.DebugMode(akBaseItem.GetName() + " weight: " + akBaseItem.GetWeight() as String)
		return 
	endIf
	if _critSection
		self.DebugMode("critsection: " + akBaseItem.GetName())
		return 
	else
		_critSection = true
	endIf
	Int type = akBaseItem.GetType()
	Int prefix = self.GetFormPrefix(akBaseItem)
	self.DebugMode("ItemRemoved. akBaseItem = " + akBaseItem as String + "; aiItemCount = " + aiItemCount as String + "; akDestContainer = " + akDestContainer as String + "; type = " + type as String + "; prefix = " + prefix as String + "; name = " + akBaseItem.GetName() + "; crafting_furniture = " + crafting_furniture)
	if looting == true
		self.DebugMode("Ignored, player is looting.")
	elseIf CF_Items_SmallTents_MoreBR.find(akBaseItem, 0) > -1 || CF_Items_LargeTents_MoreBR.find(akBaseItem, 0) > -1
		self.DebugMode("Lost a multi-bed tent, must be downgrading, this act is free and so is the next tent")
		CF_Splitting_Bedroll = true
	elseIf akBaseItem.GetType() == 46
		Float PassedTime
		potion p = akBaseItem as potion
		if _is_CF_Active as Bool && prefix == CF_Prefix || !p || !p.IsFood() || openEat == game.QueryStat("Food Eaten")
			_critSection = false
			return 
		endIf
		openEat = game.QueryStat("Food Eaten")
		self.DebugMode("ItemRemoved - food, openEat = " + openEat as String + "; akBaseItem = " + akBaseItem as String + "; aiItemCount = " + aiItemCount as String + "; prefix = " + prefix as String + "; name = " + akBaseItem.GetName())
		MagicEffect FoodEffect = self.Check_RN_FoodEffect(p)
		if RN_Mgef_Drinks.find(FoodEffect, 0) > -1
			PassedTime = rnDrinkTime
		elseIf FoodEffect == RN_Mgef_Food_Snack || FoodEffect == RN_Mgef_Food_Candy || FoodEffect == RN_Mgef_Food_Fruit
			PassedTime = rnEatSnackTime
		elseIf FoodEffect == RN_Mgef_Food_Medium
			PassedTime = rnEatMediumTime
		elseIf FoodEffect == RN_Mgef_Food_Filling
			PassedTime = rnEatFillingTime
		elseIf eatTime > 0 as Float
			PassedTime = eatTime
		endIf
		if PassedTime > 0 as Float
			PassedTime = aiItemCount as Float * self.ToMinutes(PassedTime)
			self.TimeCalc(PassedTime)
		endIf
	elseIf akBaseItem.GetType() == 27 && spellLearnTime > 0 as Float
		book b = akBaseItem as book
		if b as Bool && b.GetSpell() as Bool && openSpell < game.QueryStat("Spells Learned")
			openSpell = game.QueryStat("Spells Learned")
			self.DebugMode("Spell learned.")
			self.TimeCalc(spellLearnTime * self.ExpertiseMultiplier("Speechcraft"))
		endIf
	endIf
	_critSection = false
endFunction

function OnInit()

	; Empty function
endFunction

function StopFurniture(ObjectReference akFurniture)

	crafting_furniture = ""
endFunction

; Skipped compiler generated GetState

function OnMenuClose(String MenuName)

	self.DebugMode("OnMenuClose " + MenuName)
	if !CloseBook
		if MenuName == "Book Menu"
			StopReading = utility.GetCurrentRealTime()
			Float PassedTime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * readMult
			self.TimeCalc(PassedTime * self.ExpertiseMultiplier("Speechcraft"))
			if readingIncreasesSpeech
				self.SkillIncrease("Speechcraft", (StopReading - StartReading) * readingIncreaseMult)
			endIf
			if ui.IsMenuOpen("InventoryMenu") && isInventoryActive as Bool
				StartReading = utility.GetCurrentRealTime()
			endIf
		elseIf MenuName == "ContainerMenu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * lootMult
			if self.isPlayerPickpocketing()
				passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * pickpocketMult * self.ExpertiseMultiplier("Pickpocket")
			endIf
			self.TimeCalc(passedtime)
			looting = false
		elseIf MenuName == "Lockpicking Menu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * pickMult
			self.TimeCalc(passedtime * self.ExpertiseMultiplier("Lockpicking"))
		elseIf MenuName == "Crafting Menu"
			closeArmorsImproved = game.QueryStat("Armor Improved")
			if closeArmorsImproved - openArmorsImproved > 0
				self.DebugMode("Armor Improved. Before: " + openArmorsImproved as String + ". After: " + closeArmorsImproved as String)
				self.TimeCalc(armorImproveTime * self.ExpertiseMultiplier("Smithing"))
			endIf
			closeWeaponsImproved = game.QueryStat("Weapons Improved")
			if closeWeaponsImproved - openWeaponsImproved > 0
				self.DebugMode("Weapons Improved. Before: " + openWeaponsImproved as String + ". After: " + closeWeaponsImproved as String)
				self.TimeCalc(weaponImproveTime * self.ExpertiseMultiplier("Smithing"))
			endIf
			closeEnchantings = game.QueryStat("Magic Items Made")
			if closeEnchantings - openEnchantings > 0
				self.DebugMode("Magic Items Made. Before: " + openEnchantings as String + ". After: " + closeEnchantings as String)
				self.TimeCalc(enchantingTime * self.ExpertiseMultiplier("Enchanting"))
			endIf
			crafting = false
		elseIf MenuName == "Training Menu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * trainingMult
			closeTraining = game.QueryStat("Training Sessions")
			passedtime += (closeTraining - openTraining) as Float * trainingTime
			self.TimeCalc(passedtime)
		elseIf MenuName == "StatsMenu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * levelUpMult
			closeLevel = game.GetPlayer().getLevel()
			passedtime += (closeLevel - openLevel) as Float * levelUpTime
			self.TimeCalc(passedtime)
		elseIf MenuName == "InventoryMenu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * inventoryMult
			self.TimeCalc(passedtime)
		elseIf MenuName == "MagicMenu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * magicMult
			self.TimeCalc(passedtime)
		elseIf MenuName == "Journal Menu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * journalMult
			self.TimeCalc(passedtime)
		elseIf MenuName == "MapMenu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * mapMult
			self.TimeCalc(passedtime)
		elseIf MenuName == "BarterMenu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * barterMult
			self.TimeCalc(passedtime)
		elseIf MenuName == "GiftMenu"
			StopReading = utility.GetCurrentRealTime()
			Float passedtime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * giftMult
			self.TimeCalc(passedtime)
		endIf
	else
		CloseBook = false
	endIf
endFunction

Bool function TimeCalc(Float PassedTime)

	if Suspended as Bool || PassedTime <= 0 as Float
		return true
	endIf
	self.DebugMode("TimeCalc PassedTime = " + PassedTime as String)
	Float Time = GameHour.GetValue()
	Int Std = math.Floor(Time)
	Time -= Std as Float
	Time += PassedTime
	Time += Std as Float
	Int Hours = math.Floor(PassedTime)
	Int Minutes = math.Floor((PassedTime - Hours as Float) * 100 as Float * 3 as Float / 5 as Float)
	if showMessage as Bool && (Hours > 0 || Minutes >= showMessageThreshold)
		RTT_Message.Show(Hours as Float, Minutes as Float, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	endIf
	GameHour.SetValue(Time)
	return true
endFunction

function Init_CF_Items()

	self.DebugMode("Initializing Campfire Items")
	CF_Fire_Firecraft = none
	CF_Prefix = 0
	_is_CF_Active = true
	CF_Fire_Firecraft = game.GetFormFromFile(291813, "Campfire.esm") as globalvariable
	if !CF_Fire_Firecraft
		_is_CF_Active = false
		return 
	endIf
	CF_Prefix = self.GetFormPrefix(CF_Fire_Firecraft as Form)
	self.DebugMode("CF prefix: " + CF_Prefix as String)
	if CF_Prefix <= 0
		_is_CF_Active = false
		return 
	endIf
	CF_BlankItem = game.GetFormFromFile(288979, "Campfilre.esm")
	CF_Items_Cloaks = new Form[4]
	CF_Items_Cloaks[0] = game.GetFormFromFile(260764, "Campfire.esm")
	CF_Items_Cloaks[1] = game.GetFormFromFile(260766, "Campfire.esm")
	CF_Items_Cloaks[2] = game.GetFormFromFile(260767, "Campfire.esm")
	CF_Items_Cloaks[3] = game.GetFormFromFile(260765, "Campfire.esm")
	CF_Items_Stick = game.GetFormFromFile(151754, "Campfire.esm")
	CF_Items_Torch = game.GetFormFromFile(377715, "Campfire.esm")
	CF_Items_TorchDeconstruct = game.GetFormFromFile(105903, "Campfire.esm")
	CF_Items_Cookpot = game.GetFormFromFile(104521, "Campfire.esm")
	CF_Items_Backpacks = new Form[3]
	CF_Items_Backpacks[0] = game.GetFormFromFile(180832, "Campfire.esm")
	CF_Items_Backpacks[1] = game.GetFormFromFile(180833, "Campfire.esm")
	CF_Items_Backpacks[2] = game.GetFormFromFile(180834, "Campfire.esm")
	CF_Items_RoughBedding = game.GetFormFromFile(341732, "Campfire.esm")
	CF_Items_SmallTents_1BR = new Form[2]
	CF_Items_SmallTents_1BR[0] = game.GetFormFromFile(224078, "Campfire.esm")
	CF_Items_SmallTents_1BR[1] = game.GetFormFromFile(107284, "Campfire.esm")
	CF_Items_SmallTents_MoreBR = new Form[2]
	CF_Items_SmallTents_MoreBR[0] = game.GetFormFromFile(402683, "Campfire.esm")
	CF_Items_SmallTents_MoreBR[1] = game.GetFormFromFile(224112, "Campfire.esm")
	CF_Items_LargeTents_1BR = new Form[2]
	CF_Items_LargeTents_1BR[0] = game.GetFormFromFile(107336, "Campfire.esm")
	CF_Items_LargeTents_1BR[1] = game.GetFormFromFile(232636, "Campfire.esm")
	CF_Items_LargeTents_MoreBR = new Form[5]
	CF_Items_LargeTents_MoreBR[0] = game.GetFormFromFile(107335, "Campfire.esm")
	CF_Items_LargeTents_MoreBR[1] = game.GetFormFromFile(107326, "Campfire.esm")
	CF_Items_LargeTents_MoreBR[2] = game.GetFormFromFile(107325, "Campfire.esm")
	CF_Items_LargeTents_MoreBR[3] = game.GetFormFromFile(232637, "Campfire.esm")
	CF_Items_LargeTents_MoreBR[4] = game.GetFormFromFile(232638, "Campfire.esm")
	CF_Items_Hatchet = game.GetFormFromFile(266301, "Campfire.esm")
	CF_Items_Linen = game.GetForm(216278)
	CF_Items_FurPlate = game.GetFormFromFile(31067121, "Campfire.esm")
	CF_Items_Lace = game.GetFormFromFile(30148102, "Campfire.esm")
	CF_Items_TanRack = game.GetFormFromFile(224079, "Campfire.esm")
	CF_Items_Mortar = game.GetFormFromFile(231049, "Campfire.esm")
	CF_Items_Ench = game.GetFormFromFile(231040, "Campfire.esm")
	CF_Fire_Tinder = new Form[2]
	CF_Fire_Tinder[0] = game.GetFormFromFile(191562, "Campfire.esm")
	CF_Fire_Tinder[1] = game.GetFormFromFile(370742, "Campfire.esm")
	CF_Fire_Kindling = game.GetFormFromFile(190095, "Campfire.esm")
endFunction

function Init_FF_Items()

	FF_Dummy = none
	FF_Prefix = 0
	_is_FF_Active = true
	FF_Dummy = game.GetFormFromFile(438744, "Frostfall.esp")
	if !FF_Dummy
		_is_FF_Active = false
		return 
	endIf
	FF_Prefix = self.GetFormPrefix(FF_Dummy)
	self.DebugMode("FF prefix: " + FF_Prefix as String)
	if FF_Prefix <= 0
		_is_FF_Active = false
		return 
	endIf
	FF_SnowberryExtract = game.GetFormFromFile(119856, "Frostfall.esp")
endFunction

Bool function Check_LC_Craft(Form akBaseItem, Int aiItemCount)

	Float t
	self.DebugMode("Check_LC_Craft...")
	if akBaseItem == LC_Items_Candle
		t = self.ToMinutes(lcBrewTime)
		Float totalBaseTime = t * aiItemCount as Float
		self.DebugMode("Candle. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
		self.TimeCalc(totalBaseTime)
	elseIf LC_Items_Basic.find(akBaseItem, 0) > -1
		t = self.ToMinutes(lcBasicTime)
		self.DebugMode("Basic. Base time = " + t as String)
		self.TimeCalc(t)
	elseIf LC_Items_Arcane.find(akBaseItem, 0) > -1
		self.DebugMode("Arcane. Base time = " + lcArcaneTime as String + "; Smithing = " + game.GetPlayer().GetActorValue("Smithing") as String + "; Mult = " + self.ExpertiseMultiplier("Smithing") as String)
		self.TimeCalc(lcArcaneTime * self.ExpertiseMultiplier("Smithing"))
	else
		self.DebugMode("Forged. Base time = " + lcForgeTime as String + "; Smithing = " + game.GetPlayer().GetActorValue("Smithing") as String + "; Mult = " + self.ExpertiseMultiplier("Smithing") as String)
		self.TimeCalc(lcForgeTime * self.ExpertiseMultiplier("Smithing"))
	endIf
	return true
endFunction

MagicEffect function Check_RN_FoodEffect(potion akFood)

	Int n = akFood.GetNumEffects()
	MagicEffect result = none
	while n
		n -= 1
		MagicEffect eff = akFood.GetNthEffectMagicEffect(n)
		if RN_Mgef_Foods.find(eff, 0) > -1 || result == none && RN_Mgef_Drinks.find(eff, 0) > -1
			result = eff
		endIf
	endWhile
	if result
		self.DebugMode("Check_RN_FoodEffect found " + result as String)
	endIf
	return result
endFunction

Int function GetFormPrefix(Form akForm)

	return math.RightShift(akForm.GetFormID(), 24)
endFunction

Float function HB_ExpMult_Harvest()

	return self.Base10Bonus(HB_Harvest_Level.GetValueInt())
endFunction

Bool function Check_HB_Craft(Form akBaseItem, Int aiType, Int aiItemCount)

	Float totalBaseTime
	self.DebugMode("Check_HB_Craft...")
	if akBaseItem == HB_Items_Leather
		totalBaseTime = hbLeatherTime * aiItemCount as Float
		self.DebugMode("Leather. Base time = " + hbLeatherTime as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String + "; Skin level = " + HB_Skin_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Skin() as String)
		self.TimeCalc(totalBaseTime * self.HB_ExpMult_Skin())
	else
		Float t
		if akBaseItem == HB_Items_LeatherStrips
			t = self.ToMinutes(hbStripTime)
			totalBaseTime = t / 4 as Float * aiItemCount as Float
			self.DebugMode("Leather Strips. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String + "; Skin level = " + HB_Skin_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Skin() as String)
			self.TimeCalc(totalBaseTime * self.HB_ExpMult_Skin())
		elseIf akBaseItem == HB_Items_ScrimBits
			t = self.ToMinutes(hbScrimBitsTime)
			totalBaseTime = t * aiItemCount as Float
			self.DebugMode("Scrimshaw Bits. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
			self.TimeCalc(totalBaseTime * self.HB_ExpMult_Harvest())
		elseIf akBaseItem == HB_Items_Tallow
			t = self.ToMinutes(hbTallowTime)
			totalBaseTime = t * aiItemCount as Float
			self.DebugMode("Tallow. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
			self.TimeCalc(totalBaseTime)
		elseIf aiType == 26
			self.DebugMode("Armor. Base time = " + jewelryCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
			self.TimeCalc(jewelryCraftTime * self.HB_ExpMult_Harvest())
		elseIf aiType == 41
			weapon w = akBaseItem as weapon
			if w.isBattleAxe()
				self.DebugMode("Weapon - Battle Axe. Base time = " + battleAxeCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(battleAxeCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isBow()
				self.DebugMode("Weapon - Bow. Base time = " + bowCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(bowCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isDagger()
				self.DebugMode("Weapon - Dagger. Base time = " + daggerCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(daggerCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isGreatSword()
				self.DebugMode("Weapon - Greatsword. Base time = " + greatswordCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(greatswordCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isMace()
				self.DebugMode("Weapon - Mace. Base time = " + maceCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(maceCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isStaff()
				self.DebugMode("Weapon - Staff. Base time = " + staffCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(staffCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isSword()
				self.DebugMode("Weapon - Sword. Base time = " + swordCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(swordCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isWarhammer()
				self.DebugMode("Weapon - Warhammer. Base time = " + warhammerCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(warhammerCraftTime * self.HB_ExpMult_Harvest())
			elseIf w.isWarAxe()
				self.DebugMode("Weapon - War Axe. Base time = " + warAxeCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(warAxeCraftTime * self.HB_ExpMult_Harvest())
			else
				self.DebugMode("Weapon - Other? Base time = " + weaponCraftTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
				self.TimeCalc(weaponCraftTime * self.HB_ExpMult_Harvest())
			endIf
		elseIf aiType == 42
			totalBaseTime = hbArrowsTime
			if aiItemCount > 24
				totalBaseTime *= 5 as Float
			endIf
			self.DebugMode("Ammo. Base time = " + hbArrowsTime as String + "; Total time = " + totalBaseTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
			self.TimeCalc(totalBaseTime * self.HB_ExpMult_Harvest())
		elseIf aiType == 30
			t = self.ToMinutes(hbIngrTime)
			self.DebugMode("Ingredient. Base time = " + t as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
			self.TimeCalc(t * self.HB_ExpMult_Harvest())
		elseIf aiType == 46
			potion p = akBaseItem as potion
			if !p.IsFood() || HB_Items_Lures.find(akBaseItem, 0) > -1
				t = self.ToMinutes(hbBrewTime)
				self.DebugMode("Brew. Base time = " + t as String)
				self.TimeCalc(t)
			else
				return false
			endIf
		elseIf HB_Items_ScrimIdols.find(akBaseItem, 0) > -1
			self.DebugMode("Scrimshaw Idol. Base time = " + hbScrimIdolTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
			self.TimeCalc(hbScrimIdolTime * self.HB_ExpMult_Harvest())
		elseIf akBaseItem == HB_Items_CacheMarker
			
		elseIf HB_Items_ScrimTools.find(akBaseItem, 0) > -1
			self.DebugMode("Scrimshaw Tool. Base time = " + hbScrimToolTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
			self.TimeCalc(hbScrimToolTime * self.HB_ExpMult_Harvest())
		elseIf akBaseItem == HB_Items_Bedroll
			self.DebugMode("Bedroll. Base time = " + hbBedrollTime as String + "; Harvest level = " + HB_Harvest_Level.GetValueInt() as String + "; Mult = " + self.HB_ExpMult_Harvest() as String)
			self.TimeCalc(hbBedrollTime * self.HB_ExpMult_Harvest())
		else
			return false
		endIf
	endIf
	return true
endFunction

Bool function Check_RN_Craft(Form akBaseItem, Int aiType, Int aiItemCount)

	Float t
	self.DebugMode("Check_RN_Craft...")
	if RN_Items_Water.find(akBaseItem, 0) > -1
		t = self.ToMinutes(rnWaterPrepTime)
		self.DebugMode("Water. Base time = " + t as String)
		self.TimeCalc(t)
	elseIf RN_Items_Salt.find(akBaseItem, 0) > -1
		Float totalBaseTime = rnSaltTime * aiItemCount as Float
		self.DebugMode("Salt. Base time = " + rnSaltTime as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
		self.TimeCalc(totalBaseTime)
	elseIf akBaseItem == RN_Items_Tinderbox
		self.DebugMode("Tinderbox. Base time = " + rnTinderboxTime as String)
		self.TimeCalc(rnTinderboxTime)
	elseIf akBaseItem == RN_Items_Waterskin
		if crafting_furniture != "cook"
			self.DebugMode("Waterskin. Base time = " + rnWaterskinTime as String)
			self.TimeCalc(rnWaterskinTime)
		else
			self.DebugMode("Waterskin. Ignored, at cookpot.")
		endIf
	elseIf akBaseItem == RN_Items_Cookpot
		self.DebugMode("Cookpot. Base time = " + rnCookpotTime as String)
		self.TimeCalc(rnCookpotTime)
	elseIf akBaseItem == RN_Items_Bedroll
		self.DebugMode("Bedroll. Base time = " + rnBedrollTime as String)
		self.TimeCalc(rnBedrollTime)
	elseIf akBaseItem == RN_Items_Tent
		self.DebugMode("Tent. Base time = " + rnTentTime as String)
		self.TimeCalc(rnTentTime)
	elseIf akBaseItem == RN_Items_MilkBucket
		t = self.ToMinutes(rnMilkBucketTime)
		self.DebugMode("Milk bucket. Base time = " + t as String)
		self.TimeCalc(t)
	elseIf aiType == 32
		self.DebugMode("No match found. This one's free!")
	else
		return false
	endIf
	return true
endFunction

Bool function HandleCampfireMod(Form akBaseItem, Int aiType, Int aiItemCount)

	self.DebugMode("Handle Campfire Mods")
	if akBaseItem == CF_BlankItem
		return true
	endIf
	if CF_Items_Cloaks.find(akBaseItem, 0) > -1
		self.DebugMode("Cloak. Base time = " + cfCloakTime as String)
		return self.TimeCalc(cfCloakTime)
	else
		Float t
		if akBaseItem == CF_Items_Stick
			t = self.ToMinutes(cfStickTime)
			self.DebugMode("Walking stick. Base time = " + t as String)
			return self.TimeCalc(t)
		else
			Float totalBaseTime
			if akBaseItem == CF_Items_Torch
				t = self.ToMinutes(cfTorchTime)
				totalBaseTime = t * aiItemCount as Float
				self.DebugMode("Torch. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
				return self.TimeCalc(totalBaseTime)
			elseIf akBaseItem == CF_Items_TorchDeconstruct
				t = self.ToMinutes(cfTorchTime)
				totalBaseTime = t * aiItemCount as Float * 0.500000
				CF_Splitting_Torch = true
				CF_Splitting_Linen = true
				self.DebugMode("Splitting Torch")
				return self.TimeCalc(totalBaseTime)
			elseIf akBaseItem == CF_Items_Cookpot
				self.DebugMode("Cookpot. Base time = " + cfCookpotTime as String)
				return self.TimeCalc(cfCookpotTime)
			elseIf CF_Items_Backpacks.find(akBaseItem, 0) > -1
				if CF_Splitting_Pack
					self.DebugMode("Backpack, but ignored due to splitter.")
					CF_Splitting_Pack = false
					return true
				endIf
				self.DebugMode("Backpack. Base time = " + cfBackpackTime as String)
				return self.TimeCalc(cfBackpackTime)
			elseIf aiType == 26
				Int majorId = akBaseItem.GetFormID()
				Int mask = math.LeftShift(CF_Prefix, 24)
				Int minorId = majorId - mask
				if minorId >= 306535 && minorId <= 306564
					self.DebugMode("Splitter. Ignoring next backpack and next jewelry.")
					CF_Splitting_Pack = true
					CF_Splitting_Amulet = true
					return true
				endIf
			elseIf akBaseItem == CF_Items_RoughBedding
				totalBaseTime = cfBeddingTime * aiItemCount as Float * 0.500000
				self.DebugMode("Rough bedding. Base time = " + cfBeddingTime as String + "; x" + aiItemCount as String + " x 0.5 = " + totalBaseTime as String)
				return self.TimeCalc(totalBaseTime)
			elseIf CF_Items_SmallTents_1BR.find(akBaseItem, 0) > -1
				if CF_Splitting_Bedroll
					self.DebugMode("This is the free tent")
					return true
				endIf
				self.DebugMode("Small tent. Base time = " + cfSmallTentTime as String)
				return self.TimeCalc(cfSmallTentTime)
			elseIf CF_Items_LargeTents_1BR.find(akBaseItem, 0) > -1
				if CF_Splitting_Bedroll
					self.DebugMode("This is the free tent")
					return true
				endIf
				self.DebugMode("Large tent. Base time = " + cfLargeTentTime as String)
				return self.TimeCalc(cfLargeTentTime)
			elseIf CF_Items_SmallTents_MoreBR.find(akBaseItem, 0) > -1 || CF_Items_LargeTents_MoreBR.find(akBaseItem, 0) > -1
				if CF_Splitting_Bedroll
					self.DebugMode("This is the free tent")
					return true
				endIf
				self.DebugMode("Adding a bedroll to a tent. Base time = " + cfBeddingTime as String)
				return self.TimeCalc(cfBeddingTime)
			elseIf akBaseItem == CF_Items_Hatchet
				t = self.ToMinutes(cfHatchetTime)
				self.DebugMode("Stone hatchet. Base time = " + t as String)
				return self.TimeCalc(t)
			elseIf aiType == 42
				self.DebugMode("Arrows. Base time = " + cfArrowsTime as String)
				return self.TimeCalc(cfArrowsTime)
			elseIf akBaseItem == CF_Items_Linen
				if CF_Splitting_Linen
					self.DebugMode("Free Linen from deconstructed torch")
					CF_Splitting_Linen = false
					return true
				endIf
				t = self.ToMinutes(cfLinenTime)
				totalBaseTime = t * aiItemCount as Float
				self.DebugMode("Linen wrap. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
				return self.TimeCalc(totalBaseTime)
			elseIf akBaseItem == CF_Items_FurPlate
				totalBaseTime = cfFurTime * aiItemCount as Float
				self.DebugMode("Fur plate. Base time = " + cfFurTime as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
				return self.TimeCalc(totalBaseTime)
			elseIf akBaseItem == CF_Items_Lace
				t = self.ToMinutes(cfLaceTime)
				totalBaseTime = t * aiItemCount as Float
				self.DebugMode("Hide lace. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
				return self.TimeCalc(totalBaseTime)
			elseIf akBaseItem == CF_Items_TanRack
				t = self.ToMinutes(cfTanRackTime)
				self.DebugMode("Tanning rack. Base time = " + t as String)
				return self.TimeCalc(t)
			elseIf akBaseItem == CF_Items_Mortar
				self.DebugMode("Mortar and pestle. Base time = " + cfMortarTime as String)
				return self.TimeCalc(cfMortarTime)
			elseIf akBaseItem == CF_Items_Ench
				self.DebugMode("Enchanting supplies. They're so enchanting! Base time = " + cfEnchTime as String)
				return self.TimeCalc(cfEnchTime)
			elseIf CF_Fire_Tinder.find(akBaseItem, 0) > -1
				t = self.ToMinutes(cfMakeTinderTime)
				totalBaseTime = t * aiItemCount as Float
				self.DebugMode("Tinder. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
				return self.TimeCalc(self.FirecraftModifier(totalBaseTime))
			elseIf akBaseItem == CF_Fire_Kindling
				if CF_Splitting_Torch
					self.DebugMode("Free kindling from deconstructed torch")
					CF_Splitting_Torch = false
					return true
				endIf
				t = self.ToMinutes(cfMakeKindlingTime)
				totalBaseTime = t * aiItemCount as Float
				self.DebugMode("Kindling. Base time = " + t as String + "; x" + aiItemCount as String + " = " + totalBaseTime as String)
				return self.TimeCalc(self.FirecraftModifier(totalBaseTime))
			endIf
		endIf
	endIf
	self.DebugMode("No match found in CF, leaving this for another handler")
	return false
endFunction

function OnMenuOpen(String MenuName)

	self.DebugMode("OnMenuOpen " + MenuName)
	if MenuName == "Book Menu"
		if game.GetPlayer().IsInCombat() && cantRead as Bool
			self.CloseInCombat()
		else
			if ui.IsMenuOpen("InventoryMenu") && isInventoryActive as Bool
				StopReading = utility.GetCurrentRealTime()
				Float PassedTime = (StopReading - StartReading) * TimeScale.GetValue() / 60 as Float / 100 as Float / 3 as Float * 5 as Float * inventoryMult
				self.TimeCalc(PassedTime)
			endIf
			StartReading = utility.GetCurrentRealTime()
		endIf
	elseIf MenuName == "ContainerMenu"
		if game.GetPlayer().IsInCombat() && cantLoot as Bool
			self.CloseInCombat()
		else
			StartReading = utility.GetCurrentRealTime()
			looting = true
		endIf
	elseIf MenuName == "Lockpicking Menu"
		if game.GetPlayer().IsInCombat() && cantPick as Bool
			self.CloseInCombat()
		else
			StartReading = utility.GetCurrentRealTime()
		endIf
	elseIf MenuName == "Crafting Menu"
		openArmorsImproved = game.QueryStat("Armor Improved")
		openWeaponsImproved = game.QueryStat("Weapons Improved")
		openEnchantings = game.QueryStat("Magic Items Made")
		openPotions = game.QueryStat("Potions Mixed")
		openPoisons = game.QueryStat("Poisons Mixed")
		crafting = true
	elseIf MenuName == "Training Menu"
		StartReading = utility.GetCurrentRealTime()
		openTraining = game.QueryStat("Training Sessions")
	elseIf MenuName == "StatsMenu"
		if game.GetPlayer().IsInCombat() && cantLevelUp as Bool
			self.CloseInCombat()
		else
			StartReading = utility.GetCurrentRealTime()
			openLevel = game.GetPlayer().getLevel()
		endIf
	elseIf MenuName == "InventoryMenu"
		if game.GetPlayer().IsInCombat() && cantInventory as Bool
			self.CloseInCombat()
		else
			StartReading = utility.GetCurrentRealTime()
			openEat = game.QueryStat("Food Eaten")
			openSpell = game.QueryStat("Spells Learned")
		endIf
	elseIf MenuName == "MagicMenu"
		if game.GetPlayer().IsInCombat() && cantMagic as Bool
			self.CloseInCombat()
		else
			StartReading = utility.GetCurrentRealTime()
		endIf
	elseIf MenuName == "Journal Menu"
		if game.GetPlayer().IsInCombat() && cantJournal as Bool
			self.CloseInCombat()
		else
			StartReading = utility.GetCurrentRealTime()
		endIf
	elseIf MenuName == "MapMenu"
		if game.GetPlayer().IsInCombat() && cantMap as Bool
			self.CloseInCombat()
		else
			StartReading = utility.GetCurrentRealTime()
		endIf
	elseIf MenuName == "BarterMenu"
		StartReading = utility.GetCurrentRealTime()
	elseIf MenuName == "GiftMenu"
		StartReading = utility.GetCurrentRealTime()
	endIf
endFunction

function CloseInCombat()

	if Suspended
		return 
	endIf
	CloseBook = true
	if showMessage
		debug.Notification("$I can't do that while in combat!")
	endIf
	while utility.IsInMenuMode()
		input.TapKey(15)
		utility.WaitMenuMode(0.150000)
	endWhile
endFunction

; Skipped compiler generated GotoState

function DebugMode(String sMsg)

	if _debugMode
		debug.Trace("Living Takes Time :: " + sMsg, 0)
	endIf
endFunction

function Init_HB_Items()

	HB_Items_ScrimBits = game.GetFormFromFile(26963, "Hunterborn.esp")
	HB_Prefix = self.GetFormPrefix(HB_Items_ScrimBits)
	_is_HB_Active = HB_Prefix > 0
	self.DebugMode("HB prefix: " + HB_Prefix as String)
	if !_is_HB_Active
		return 
	endIf
	HB_Items_Leather = game.GetForm(898514)
	HB_Items_LeatherStrips = game.GetForm(524516)
	Form flute = game.GetForm(895911)
	HB_Items_Vanilla = new Form[3]
	HB_Items_Vanilla[0] = HB_Items_Leather
	HB_Items_Vanilla[1] = HB_Items_LeatherStrips
	HB_Items_Vanilla[2] = flute
	HB_Items_ScrimIdols = new Form[7]
	HB_Items_ScrimIdols[0] = game.GetFormFromFile(156027, "Hunterborn.esp")
	HB_Items_ScrimIdols[1] = game.GetFormFromFile(154641, "Hunterborn.esp")
	HB_Items_ScrimIdols[2] = game.GetFormFromFile(156028, "Hunterborn.esp")
	HB_Items_ScrimIdols[3] = game.GetFormFromFile(255928, "Hunterborn.esp")
	HB_Items_ScrimIdols[4] = game.GetFormFromFile(255929, "Hunterborn.esp")
	HB_Items_ScrimIdols[5] = game.GetFormFromFile(250393, "Hunterborn.esp")
	HB_Items_ScrimIdols[6] = game.GetFormFromFile(1262822, "Hunterborn.esp")
	HB_Items_CacheMarker = game.GetFormFromFile(239296, "Hunterborn.esp")
	HB_Items_ScrimTools = new Form[2]
	HB_Items_ScrimTools[0] = flute
	HB_Items_ScrimTools[1] = game.GetFormFromFile(640488, "Hunterborn.esp")
	HB_Items_Bedroll = game.GetFormFromFile(142217, "Hunterborn.esp")
	HB_Items_Tallow = game.GetFormFromFile(702733, "Hunterborn.esp")
	HB_Items_Lures = new Form[3]
	HB_Items_Lures[0] = game.GetFormFromFile(640457, "Hunterborn.esp")
	HB_Items_Lures[1] = game.GetFormFromFile(640463, "Hunterborn.esp")
	HB_Items_Lures[2] = game.GetFormFromFile(640471, "Hunterborn.esp")
	HB_Skin_Level = game.GetFormFromFile(29730, "Hunterborn.esp") as globalvariable
	HB_Harvest_Level = game.GetFormFromFile(35259, "Hunterborn.esp") as globalvariable
endFunction

function CheckModStatus()

	self.Init_CF_Items()
	self.Init_FF_Items()
	self.Init_RN_Items()
	self.Init_HB_Items()
	self.Init_WL_Items()
	self.Init_LC_Items()
	_critSection = false
endFunction

function SkillIncrease(String Skill, Float Increase)

	actorvalueinfo aVI = actorvalueinfo.GetActorValueInfobyName(Skill)
	aVI.AddSkillExperience(Increase)
endFunction

function Init_HF_Exclusions()

	HF_Exclusions = new Form[26]
	HF_Exclusions[0] = game.GetFormFromFile(12511, "HearthFires.esm")
	HF_Exclusions[1] = game.GetFormFromFile(12577, "HearthFires.esm")
	HF_Exclusions[2] = game.GetFormFromFile(12519, "HearthFires.esm")
	HF_Exclusions[3] = game.GetFormFromFile(12578, "HearthFires.esm")
	HF_Exclusions[4] = game.GetFormFromFile(12587, "HearthFires.esm")
	HF_Exclusions[5] = game.GetFormFromFile(12588, "HearthFires.esm")
	HF_Exclusions[6] = game.GetFormFromFile(15066, "HearthFires.esm")
	HF_Exclusions[7] = game.GetFormFromFile(15067, "HearthFires.esm")
	HF_Exclusions[8] = game.GetFormFromFile(15068, "HearthFires.esm")
	HF_Exclusions[9] = game.GetFormFromFile(15069, "HearthFires.esm")
	HF_Exclusions[10] = game.GetFormFromFile(15070, "HearthFires.esm")
	HF_Exclusions[11] = game.GetFormFromFile(15071, "HearthFires.esm")
	HF_Exclusions[12] = game.GetFormFromFile(15072, "HearthFires.esm")
	HF_Exclusions[13] = game.GetFormFromFile(15073, "HearthFires.esm")
	HF_Exclusions[14] = game.GetFormFromFile(15074, "HearthFires.esm")
	HF_Exclusions[15] = game.GetFormFromFile(15075, "HearthFires.esm")
	HF_Exclusions[16] = game.GetFormFromFile(15076, "HearthFires.esm")
	HF_Exclusions[17] = game.GetFormFromFile(15077, "HearthFires.esm")
	HF_Exclusions[18] = game.GetFormFromFile(15078, "HearthFires.esm")
	HF_Exclusions[19] = game.GetFormFromFile(15079, "HearthFires.esm")
	HF_Exclusions[20] = game.GetFormFromFile(15080, "HearthFires.esm")
	HF_Exclusions[21] = game.GetFormFromFile(15081, "HearthFires.esm")
	HF_Exclusions[22] = game.GetFormFromFile(15082, "HearthFires.esm")
	HF_Exclusions[23] = game.GetFormFromFile(15083, "HearthFires.esm")
	HF_Exclusions[24] = game.GetFormFromFile(15084, "HearthFires.esm")
	HF_Exclusions[25] = game.GetFormFromFile(15085, "HearthFires.esm")
endFunction

function OnTrackedStatsEvent(String asStatFilter, Int aiStatValue)

	; Empty function
endFunction

function StartFurniture(ObjectReference akFurniture)

	if akFurniture.HasKeywordString("CraftingCookpot")
		crafting_furniture = "cook"
	elseIf akFurniture.HasKeywordString("CraftingTanningRack")
		crafting_furniture = "tanrack"
	elseIf akFurniture.HasKeywordString("CraftingSmithingForge")
		crafting_furniture = "forge"
	elseIf akFurniture.HasKeywordString("CraftingSmithingArmorTable")
		crafting_furniture = "temper"
	elseIf akFurniture.HasKeywordString("CraftingSmithingSharpeningWheel")
		crafting_furniture = "sharpen"
	elseIf akFurniture.HasKeywordString("CraftingSmithingSkyforge")
		crafting_furniture = "skyforge"
	elseIf akFurniture.HasKeywordString("CraftingSmelter")
		crafting_furniture = "smelt"
	elseIf akFurniture.HasKeywordString("isAlchemy")
		crafting_furniture = "Alchemy"
	elseIf akFurniture.HasKeywordString("isEnchanting")
		crafting_furniture = "enchant"
	elseIf akFurniture.HasKeywordString("_Camp_CraftingCampfire")
		crafting_furniture = "cf_campfire"
	elseIf akFurniture.HasKeywordString("_Camp_CraftingSurvival")
		crafting_furniture = "cf_survival"
	elseIf akFurniture.HasKeywordString("_DS_KW_CraftingScrimshaw")
		crafting_furniture = "hb_scrimshaw"
	elseIf akFurniture.HasKeywordString("_DS_KW_CraftingPrimitiveCooking")
		crafting_furniture = "hb_primitivecook"
	else
		crafting_furniture = "other"
	endIf
	self.DebugMode("Furniture mode: " + crafting_furniture)
endFunction

function OnCrosshairRefChange(ObjectReference ref)

	LastTarget = ref as Actor
endFunction

function ItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	self.DebugMode("++ItemAdded: akBaseItem = " + akBaseItem as String + "; aiItemCount = " + aiItemCount as String + "; akSourceContainer = " + akSourceContainer as String + "; name = " + akBaseItem.GetName() + "; crafting_furniture = " + crafting_furniture)
	self.DebugMode("Flags" + "; _isModActive=" + _isModActive as String + "; _is_CF_Active=" + _is_CF_Active as String + "; _is_FF_Active=" + _is_FF_Active as String + "; _is_RN_Active=" + _is_RN_Active as String + "; _is_HB_Active=" + _is_HB_Active as String + "; _is_WL_Active=" + _is_WL_Active as String + "; _is_LC_Active=" + _is_LC_Active as String)
	if !_isModActive || ui.IsMenuOpen("Console")
		return 
	endIf
	Int type = akBaseItem.GetType()
	Int prefix = self.GetFormPrefix(akBaseItem)
	if crafting_furniture == "cf_campfire" && type == 27 && prefix == CF_Prefix
		self.DebugMode("I think we're lighting a fire")
		if self.HandleFirepit(akBaseItem)
			return 
		endIf
	endIf
	if akBaseItem.GetWeight() < 0.0100000 && type != 42
		self.DebugMode("Whatever it was, seemed not big enough to take time.")
		return 
	endIf
	if looting
		self.DebugMode("ItemAdded - looting,  akBaseItem = " + akBaseItem as String + "; aiItemCount = " + aiItemCount as String + "; akSourceContainer = " + akSourceContainer as String + "; type = " + type as String + "; prefix = " + prefix as String + "; name = " + akBaseItem.GetName())
		Actor c = akSourceContainer as Actor
		if c as Bool && c.isDead()
			armor a = akBaseItem as armor
			if !a
				
			else
				Float t
				if a.IsLightArmor() && a.IsCuirass() && lightArmorTime > 0 as Float
					t = self.ToMinutes(lightArmorTime)
					self.DebugMode("Looting light armour. Base time = " + t as String)
					self.TimeCalc(t)
					return 
				elseIf a.IsHeavyArmor() && a.IsCuirass() && heavyArmorTime > 0 as Float
					t = self.ToMinutes(heavyArmorTime)
					self.DebugMode("Looting heavy armour. Base time = " + t as String)
					self.TimeCalc(t)
					return 
				endIf
			endIf
		endIf
		self.DebugMode("Looting free stuff.")
		return 
	endIf
	if !crafting || akSourceContainer as Bool
		self.DebugMode("leaving ItemAdded because we're not crafting or the source container isn't defined")
		return 
	endIf
	Float PassedTime = 0 as Float
	self.DebugMode("ItemAdded - crafting, akBaseItem = " + akBaseItem as String + "; aiItemCount = " + aiItemCount as String + "; akSourceContainer = " + akSourceContainer as String + "; type = " + type as String + "; prefix = " + prefix as String + "; name = " + akBaseItem.GetName() + "; crafting_furniture = " + crafting_furniture)
	Bool Handled = false
	if !Handled && _is_CF_Active as Bool && (prefix == CF_Prefix || akBaseItem == CF_Items_Linen || akBaseItem == CF_Items_Lace)
		Handled = self.HandleCampfireMod(akBaseItem, type, aiItemCount)
	endIf
	if !Handled && _is_FF_Active as Bool && prefix == FF_Prefix
		Handled = self.HandleFrostfallMod(akBaseItem, type, aiItemCount)
	endIf
	if Handled
		return 
	endIf
	if (prefix == RN_Prefix || akBaseItem == RN_Items_Cookpot) && self.Check_RN_Craft(akBaseItem, type, aiItemCount)
		
	elseIf (prefix == HB_Prefix || HB_Items_Vanilla.find(akBaseItem, 0) > -1) && self.Check_HB_Craft(akBaseItem, type, aiItemCount)
		
	elseIf (prefix == WL_Prefix || akBaseItem == WL_Items_Chassis) && self.Check_WL_Craft(akBaseItem, aiItemCount)
		
	elseIf prefix == LC_Prefix && self.Check_LC_Craft(akBaseItem, aiItemCount)
		
	elseIf crafting_furniture == "smelt"
		self.DebugMode("Smelting, using value from Crafting - Misc")
		self.TimeCalc(miscCraftTime * self.ExpertiseMultiplier("Smithing"))
	elseIf type == 46
		self.DebugMode("POTION crafted.")
		PassedTime = potionCraftTime * self.ExpertiseMultiplier("Alchemy")
		potion p = akBaseItem as potion
		if p.IsFood()
			MagicEffect FoodEffect = self.Check_RN_FoodEffect(p)
			if RN_Mgef_Drinks.find(FoodEffect, 0) > -1
				PassedTime = self.ToMinutes(rnBrewTime)
			elseIf FoodEffect == RN_Mgef_Food_Snack || FoodEffect == RN_Mgef_Food_Candy || FoodEffect == RN_Mgef_Food_Fruit
				PassedTime = self.ToMinutes(rnCookSnackTime)
			elseIf FoodEffect == RN_Mgef_Food_Medium
				PassedTime = self.ToMinutes(rnCookMediumTime)
			elseIf FoodEffect == RN_Mgef_Food_Filling
				PassedTime = self.ToMinutes(rnCookFillingTime)
			endIf
		endIf
		self.TimeCalc(PassedTime)
	elseIf type == 26
		self.DebugMode("ARMOR crafted.")
		armor a = akBaseItem as armor
		if a.isHelmet() || a.isClothingHead()
			self.TimeCalc(headCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf a.IsCuirass() || a.isClothingBody()
			self.TimeCalc(armorCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf a.isGauntlets() || a.isClothingHands()
			self.TimeCalc(handsCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf a.isBoots() || a.isClothingFeet()
			self.TimeCalc(feetCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf a.isShield()
			self.TimeCalc(shieldCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf a.isJewelry() || a.isClothingRing()
			if CF_Splitting_Pack
				self.DebugMode("Amulet, but ignored due to splitter.")
				CF_Splitting_Pack = false
			else
				self.TimeCalc(jewelryCraftTime * self.ExpertiseMultiplier("Smithing"))
			endIf
		else
			self.TimeCalc(armorCraftTime * self.ExpertiseMultiplier("Smithing"))
		endIf
	elseIf type == 41
		self.DebugMode("WEAPON crafted.")
		weapon w = akBaseItem as weapon
		if w.isBattleAxe()
			self.TimeCalc(battleAxeCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isBow()
			self.TimeCalc(bowCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isDagger()
			self.TimeCalc(daggerCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isGreatSword()
			self.TimeCalc(greatswordCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isMace()
			self.TimeCalc(maceCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isStaff()
			self.TimeCalc(staffCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isSword()
			self.TimeCalc(swordCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isWarhammer()
			self.TimeCalc(warhammerCraftTime * self.ExpertiseMultiplier("Smithing"))
		elseIf w.isWarAxe()
			self.TimeCalc(warAxeCraftTime * self.ExpertiseMultiplier("Smithing"))
		else
			self.TimeCalc(weaponCraftTime * self.ExpertiseMultiplier("Smithing"))
		endIf
	elseIf type == 42
		self.DebugMode("AMMO crafted.")
		self.TimeCalc(weaponCraftTime * self.ExpertiseMultiplier("Smithing"))
	elseIf type == 32 || type == 52
		if HF_Exclusions.find(akBaseItem, 0) > -1
			return 
		endIf
		if akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryBuilding")
			game.GetPlayer().AddItem(akBaseItem, 1, false)
		elseIf akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryContainers")
			
		elseIf akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryFurniture")
			
		elseIf akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryWeaponRacks")
			
		elseIf akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryShelf")
			
		elseIf akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryExterior")
			
		elseIf miscCraftTime > 0 as Float
			self.DebugMode("MISC item, using value from Crafting - Misc")
			self.TimeCalc(miscCraftTime * self.ExpertiseMultiplier("Smithing"))
		endIf
	endIf
endFunction

Float function ExpertiseMultiplier(String Skill)

	if !expertiseReducesTime
		return 1 as Float
	endIf
	Float SkillPoints = game.GetPlayer().GetActorValue(Skill)
	if SkillPoints < 0 as Float
		SkillPoints = 0 as Float
	elseIf SkillPoints > 150 as Float
		SkillPoints = 150 as Float
	endIf
	return (100 as Float - SkillPoints / 2 as Float) / 100 as Float
endFunction

function InitStats(Bool Active)

	_isModActive = Active
	openEat = game.QueryStat("Food Eaten")
	openSpell = game.QueryStat("Spells Learned")
	openArmorsImproved = game.QueryStat("Armor Improved")
	openWeaponsImproved = game.QueryStat("Weapons Improved")
	openEnchantings = game.QueryStat("Magic Items Made")
	openPotions = game.QueryStat("Potions Mixed")
	openPoisons = game.QueryStat("Poisons Mixed")
	self.UnregisterForTrackedStatsEvent()
endFunction
