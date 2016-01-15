Scriptname RTT extends Quest

;
;			!! PLEASE READ !!
;
; This version of RTT.psc is an EDIT of the source from Living Takes Time ver 2.4.1, by Akezhar.
; The edit is by unuroboros / dragonsong.
; It is a quick and dirty update to add support for: Frostfall, Hunterborn, Wearable Lantern, Lanterns and Candles.
; Specifically, crafted items from these mods will have their own time values rather than falling into the generic, misc 2 hour category.
;
;

Message Property RTT_Message  Auto 
Message Property RTT_CantRead  Auto 

Bool Property isInventoryActive  Auto

;reading
Bool Property cantRead Auto
Float Property readMult Auto
Bool Property readingIncreasesSpeech Auto
Float Property readingIncreaseMult Auto
Float Property spellLearnTime Auto
;crafting
Float Property headCraftTime Auto
Float Property armorCraftTime Auto
Float Property handsCraftTime Auto
Float Property feetCraftTime Auto
Float Property shieldCraftTime Auto
Float Property jewelryCraftTime Auto

Float Property battleAxeCraftTime Auto 
Float Property bowCraftTime Auto 
Float Property daggerCraftTime Auto 
Float Property greatswordCraftTime Auto 
Float Property maceCraftTime Auto 
Float Property staffCraftTime Auto 
Float Property swordCraftTime Auto 
Float Property warhammerCraftTime Auto 
Float Property warAxeCraftTime Auto 
Float Property weaponCraftTime Auto 

Float Property miscCraftTime Auto

Float Property weaponImproveTime Auto
Float Property armorImproveTime Auto
Float Property enchantingTime Auto
Float Property potionCraftTime Auto

int openArmorsImproved = 0
int openWeaponsImproved = 0
int openEnchantings = 0
int openPotions = 0
int openPoisons = 0
int closeArmorsImproved = 0
int closeWeaponsImproved = 0
int closeEnchantings = 0
int closePotions = 0
int closePoisons = 0

Bool crafting = False
Bool looting = False
String crafting_furniture = ""

Bool _critSection = False

;looting
Bool Property cantLoot Auto
Float Property lootMult Auto
Float Property pickpocketMult Auto
Float Property lightArmorTime Auto
Float Property heavyArmorTime Auto
Bool Property cantPick Auto
Float Property pickMult Auto
Float Property chopTime Auto
Float Property mineTime Auto
Float Property harvestTime Auto
Bool isRegisteredForEvents = False
;training
Float Property trainingMult Auto
Float Property trainingTime Auto
int openTraining = 0
int closeTraining = 0
Bool Property cantLevelUp Auto
Float Property levelUpMult Auto
Float Property levelUpTime Auto
int openLevel = 0
int closeLevel = 0
;preparing
Bool Property cantInventory Auto
Float Property inventoryMult Auto
Float Property eatTime Auto
int openEat = 0
int closeEat = 0
int openSpell = 0
Bool Property cantMagic Auto
Float Property magicMult Auto
Bool Property cantJournal Auto
Float Property journalMult Auto
Bool Property cantMap Auto
Float Property mapMult Auto
;trading
Float Property barterMult Auto
Float Property giftMult Auto
;general
Bool Property showMessage Auto
Bool Property dontShowMessage Auto
Int Property showMessageThreshold Auto
Bool Property expertiseReducesTime Auto
int Property hotkeySuspend Auto
GlobalVariable Property GameHour Auto
GlobalVariable Property TimeScale Auto
Bool CloseBook = False
Float Property StartReading  Auto
Float Property StopReading  Auto
Actor LastTarget = None
Bool _isModActive = False

Bool Property Suspended Auto

Bool _debugMode = True

Form[] HF_Exclusions

Bool _is_FF_Active = False ; Frostfall, by Chesko
Bool _is_RN_Active = False; Realistic Needs and Diseases, by perseid9
Bool _is_HB_Active = False ; Hunterborn, by dragonsong
Bool _is_WL_Active = False ; Wearable Lantern, by Chesko
Bool _is_LC_Active = False ; Lanterns and Candles, by mentilreq

; -- FROSTFALL
Int FF_Prefix = 0
;Form[] FF_Exclusions
Float Property ffCloakTime Auto
Float Property ffStickTime Auto
Float Property ffTorchTime Auto
Float Property ffCookpotTime Auto
Float Property ffBackpackTime Auto
Float Property ffSmallTentTime Auto
Float Property ffLargeTentTime Auto
Float Property ffHatchetTime Auto
Float Property ffArrowsTime Auto
Float Property ffLinenTime Auto
Float Property ffPeltTime Auto
Float Property ffLaceTime Auto
Float Property ffTanRackTime Auto
Float Property ffMortarTime Auto
Float Property ffEnchTime Auto
Form[] FF_Items_Cloaks
Form FF_Items_Stick
Form FF_Items_Torch
Form FF_Items_Cookpot
Form[] FF_Items_Backpacks
Form[] FF_Items_SmallTents
Form[] FF_Items_LargeTents
Form FF_Items_Hatchet
Form FF_Items_Linen
Form FF_Items_Pelt
Form FF_Items_Lace
Form FF_Items_TanRack
Form FF_Items_Mortar
Form FF_Items_Ench
Bool FF_Split_Pack = False
Bool FF_Split_Amulet = False

; -- RND
Int RN_Prefix = 0
Float Property rnWaterskinTime Auto
Float Property rnCookpotTime Auto
Float Property rnTinderboxTime Auto
Float Property rnBedrollTime Auto
Float Property rnTentTime Auto
Float Property rnMilkBucketTime Auto
Float Property rnEatSnackTime Auto
Float Property rnEatMediumTime Auto
Float Property rnEatFillingTime Auto
Float Property rnDrinkTime Auto
Float Property rnCookSnackTime Auto
Float Property rnCookMediumTime Auto
Float Property rnCookFillingTime Auto
Float Property rnBrewTime Auto
Float Property rnWaterPrepTime Auto
Float Property rnSaltTime Auto
Form RN_Items_Waterskin
Form RN_Items_Cookpot
Form RN_Items_Tinderbox
Form RN_Items_Bedroll
Form RN_Items_Tent
Form RN_Items_MilkBucket
Form[] RN_Items_Water
Form[] RN_Items_Salt
MagicEffect[] RN_Mgef_Drinks
MagicEffect RN_Mgef_Food_Snack
MagicEffect RN_Mgef_Food_Medium
MagicEffect RN_Mgef_Food_Filling
MagicEffect RN_Mgef_Food_Candy
MagicEffect RN_Mgef_Food_Fruit
MagicEffect[] RN_Mgef_Foods

; -- HUNTERBORN
Int HB_Prefix = 0
Float Property hbLeatherTime Auto
Float Property hbStripTime Auto
Float Property hbScrimBitsTime Auto
Float Property hbBedrollTime Auto
Float Property hbTallowTime Auto
Float Property hbIngrTime Auto
Float Property hbBrewTime Auto
Float Property hbScrimIdolTime Auto
Float Property hbScrimToolTime Auto
Float Property hbArrowsTime Auto
Form[] HB_Items_Vanilla
Form HB_Items_Leather
Form HB_Items_LeatherStrips
Form HB_Items_ScrimBits
Form[] HB_Items_ScrimIdols
Form HB_Items_CacheMarker
Form[] HB_Items_ScrimTools
Form HB_Items_Bedroll
Form HB_Items_Tallow
Form[] HB_Items_Lures
GlobalVariable HB_Skin_Level
GlobalVariable HB_Harvest_Level

; -- WEARABLE LANTERN
Int WL_Prefix = 0
Float Property wlWearableTime Auto
Float Property wlChassisTime Auto
Float Property wlOilTime Auto
Form WL_Items_Wearable
Form WL_Items_Chassis
Form WL_Items_Oil

; -- LANTERNS AND CANDLES
Int LC_Prefix = 0
Float Property lcBasicTime Auto
Float Property lcForgeTime Auto
Float Property lcArcaneTime Auto
Float Property lcBrewTime Auto
Form[] LC_Items_Basic
Form[] LC_Items_Arcane
Form LC_Items_Candle


Event OnInit()

EndEvent

Function InitStats(Bool Active)
	_isModActive = Active
	openEat = Game.QueryStat("Food Eaten")
	openSpell = Game.QueryStat("Spells Learned")
	openArmorsImproved = Game.QueryStat("Armor Improved")
	openWeaponsImproved = Game.QueryStat("Weapons Improved")
	openEnchantings = Game.QueryStat("Magic Items Made")
	openPotions = Game.QueryStat("Potions Mixed")
	openPoisons = Game.QueryStat("Poisons Mixed")
	UnregisterForTrackedStatsEvent()
EndFunction
 
Function TimeCalc(Float PassedTime)

	If Suspended || PassedTime <= 0
		Return
	EndIf

	DebugMode("TimeCalc PassedTime = " + PassedTime)
	Float Time = GameHour.GetValue()
	Int Std = Math.Floor(Time)
	Time = Time - Std
	Time = Time + (PassedTime)
	Time = Time + Std
	Int Hours = Math.Floor(PassedTime)
	Int Minutes =  Math.Floor((PassedTime - Hours)*100*3/5)
	DebugMode("hours = " + Hours + " ; minutes = " + minutes + " ; showMessageThreshold = " + showMessageThreshold + " ; showMessage = " + showMessage)
	If showMessage && (Hours > 0 || Minutes >= showMessageThreshold)
		RTT_Message.Show(Hours,Minutes)
	EndIf
	GameHour.SetValue(Time)
	
EndFunction

Float Function ExpertiseMultiplier(String Skill)
	if (!expertiseReducesTime)
		return 1
	endif
	Float SkillPoints = Game.GetPlayer().GetActorValue(Skill)
	if (SkillPoints<0)
		SkillPoints = 0
	elseif (SkillPoints>150)
		SkillPoints = 150
	endif
	return (100-(SkillPoints/2))/100
EndFunction

Function SkillIncrease(String Skill, Float Increase)
	ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(Skill)
	aVI.AddSkillExperience(Increase)
EndFunction

Function CloseInCombat()
	If Suspended
		Return
	EndIf
	CloseBook = True
	if(showMessage)
		;RTT_CantRead.Show()
		Debug.Notification("$I can't do that while in combat!")
	endif
	while (Utility.IsInMenuMode())
		Input.TapKey(15)
		Utility.WaitMenuMode(0.15)
	endwhile
EndFunction

;deprecated since SKSE 1.7.1
Event OnCrosshairRefChange (ObjectReference ref)
	LastTarget = ref as Actor
EndEvent

Bool Function isPlayerPickpocketing()
	Bool isPickpocketing = False
	LastTarget = Game.GetCurrentCrosshairRef() as Actor
	if (LastTarget && !LastTarget.isDead() && Game.GetPlayer().isSneaking())
		isPickpocketing = True
	endif
	return isPickpocketing
EndFunction

Function ItemAdded (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	If !_isModActive || UI.IsMenuOpen("Console")
		Return
	EndIf
	
	int type = akBaseItem.GetType()
	
	; Ignore tiny objects. Like Fork of Damnation. *HUGE SIGH*
	; ... Except ammo, which is weightless for most people without patches. :p
	If akBaseItem.GetWeight() < 0.01 && type != 42
		Return
	EndIf

	If looting
;		DebugMode("ItemAdded - looting,  akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; akSourceContainer = " + akSourceContainer + \
;			"; type = " + type + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )
		Actor c = akSourceContainer as Actor
		If c && c.IsDead()
			Float t
			Armor a = akBaseItem as Armor
			If !a
				;
			ElseIf a.IsLightArmor() && a.IsCuirass() && lightArmorTime > 0
				t = ToMinutes(lightArmorTime)
				TimeCalc(t)
			ElseIf a.IsHeavyArmor() && a.IsCuirass() && heavyArmorTime > 0
				t = ToMinutes(heavyArmorTime)
				TimeCalc(t)
			EndIf
		EndIf
		Return
	EndIf
	
	If !crafting || akSourceContainer ;if items come from a container they're not crafted and we should skip, this fixes problems with jaggarfeld and such
		Return
	EndIf
	
	Float PassedTime = 0
	
	int prefix = GetFormPrefix(akBaseItem)
	DebugMode("ItemAdded - crafting, akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; akSourceContainer = " + akSourceContainer + \
		"; type = " + type + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )

	If ( (prefix == FF_Prefix || akBaseItem == FF_Items_Linen) && Check_FF_Craft(akBaseItem, type, aiItemCount) )
		;
	ElseIf ( (prefix == RN_Prefix || akBaseItem == RN_Items_Cookpot) && Check_RN_Craft(akBaseItem, type, aiItemCount) )
		;
	ElseIf ( (prefix == HB_Prefix || HB_Items_Vanilla.Find(akBaseItem) > -1) && Check_HB_Craft(akBaseItem, type, aiItemCount) )
		;
	ElseIf ( (prefix == WL_Prefix || akBaseItem == WL_Items_Chassis) && Check_WL_Craft(akBaseItem, aiItemCount) )
		;
	ElseIf ( prefix == LC_Prefix && Check_LC_Craft(akBaseItem, aiItemCount) )
		;

	ElseIf crafting_furniture == "smelt"
		DebugMode("Smelting, using value from Crafting - Misc")
		TimeCalc( miscCraftTime * ExpertiseMultiplier("Smithing") )
		
	; Potions, poisons, food, drink [new system]
	ElseIf type == 46
		DebugMode("POTION crafted.")
		PassedTime = potionCraftTime * ExpertiseMultiplier("Alchemy") ; Default
		Potion p = akBaseItem as Potion
		If p.IsFood()
			MagicEffect FoodEffect = Check_RN_FoodEffect(p)
			If RN_Mgef_Drinks.Find(FoodEffect) > -1
				PassedTime = ToMinutes(rnBrewTime)
			ElseIf FoodEffect == RN_Mgef_Food_Snack || FoodEffect == RN_Mgef_Food_Candy || FoodEffect == RN_Mgef_Food_Fruit
				PassedTime = ToMinutes(rnCookSnackTime)
			ElseIf FoodEffect == RN_Mgef_Food_Medium
				PassedTime = ToMinutes(rnCookMediumTime)
			ElseIf FoodEffect == RN_Mgef_Food_Filling
				PassedTime = ToMinutes(rnCookFillingTime)
			EndIf
		EndIf
		TimeCalc(PassedTime)
		
	ElseIf type == 26
		DebugMode("ARMOR crafted.")
		Armor a = akBaseItem as Armor
		if a.isHelmet() || a.isClothingHead()
			TimeCalc(headCraftTime*ExpertiseMultiplier("Smithing"))
		elseif a.isCuirass() || a.isClothingBody()
			TimeCalc(armorCraftTime*ExpertiseMultiplier("Smithing"))
		elseif a.isGauntlets() || a.isClothingHands()
			TimeCalc(handsCraftTime*ExpertiseMultiplier("Smithing"))
		elseif a.isBoots() || a.isClothingFeet()
			TimeCalc(feetCraftTime*ExpertiseMultiplier("Smithing"))
		elseif a.isShield()
			TimeCalc(shieldCraftTime*ExpertiseMultiplier("Smithing"))
		elseif a.isJewelry() || a.isClothingRing()
			If FF_Split_Amulet
				DebugMode("Amulet, but ignored due to splitter.")
				FF_Split_Amulet = False
			Else
				TimeCalc(jewelryCraftTime*ExpertiseMultiplier("Smithing"))
			EndIf
		else
			;whatever is left
			TimeCalc(armorCraftTime*ExpertiseMultiplier("Smithing"))
		endif
		
	elseif type == 41
		DebugMode("WEAPON crafted.")
		Weapon w = akBaseItem as Weapon
		if w.isBattleAxe()
			TimeCalc(battleAxeCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isBow()
			TimeCalc(bowCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isDagger()
			TimeCalc(daggerCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isGreatSword()
			TimeCalc(greatswordCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isMace()
			TimeCalc(maceCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isStaff()
			TimeCalc(staffCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isSword()
			TimeCalc(swordCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isWarhammer()
			TimeCalc(warhammerCraftTime*ExpertiseMultiplier("Smithing"))
		elseif w.isWarAxe()
			TimeCalc(warAxeCraftTime*ExpertiseMultiplier("Smithing"))
		else
			;whatever is left
			TimeCalc(weaponCraftTime*ExpertiseMultiplier("Smithing"))
		endif
		
	ElseIf type == 42
		DebugMode("AMMO crafted.")
		TimeCalc( weaponCraftTime * ExpertiseMultiplier("Smithing") )
		
	elseif ( type == 32 || type == 52 ) ;misc and soul gems
		;filter for added and removed workbenches
		If HF_Exclusions.Find(akBaseItem) > -1
			Return
		EndIf
		if akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryBuilding")
			;Debug.Notification("building "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
			Game.GetPlayer().AddItem(akBaseItem)
		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryContainers")
			;Debug.Notification("container "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryFurniture")
			;Debug.Notification("furniture "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryWeaponRacks")
			;Debug.Notification("weaponrack "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryShelf")
			;Debug.Notification("shelf "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryExterior")
			;Debug.Notification("exterior "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
		elseif miscCraftTime > 0
			DebugMode("MISC item, using value from Crafting - Misc")
			;Debug.Notification("misc "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
			TimeCalc(miscCraftTime*ExpertiseMultiplier("Smithing"))
		endif
		
	endif
		
EndFunction

Function ItemRemoved (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)

	If !_isModActive || UI.IsMenuOpen("Console")
		Return
	EndIf
	
	; Ignore tiny objects. Like Fork of Damnation. *HUGE SIGH*
	If akBaseItem.GetWeight() < 0.01
		;DebugMode(akBaseItem.GetName() + " weight: " + akBaseItem.GetWeight())
		Return
	EndIf

	; Prevent re-entry. Not sure why this happens.
	If _critSection
		;DebugMode("critsection: " + akBaseItem.GetName())
		Return
	Else
		_critSection = True
	EndIf

	int prefix = GetFormPrefix(akBaseItem)
	
	DebugMode("ItemRemoved. akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )
	
	; Catch this early because neither eating nor learning a spell qualifies if player is looting
	If looting == True
		DebugMode("Ignored, player is looting.")
	
	ElseIf akBaseItem.GetType() == 46
		Potion p = akBaseItem as Potion
		If (_is_FF_Active && prefix == FF_Prefix) || !p || !p.isFood() || openEat == Game.QueryStat("Food Eaten")
			_critSection = False
			Return
		EndIf
		openEat = Game.QueryStat("Food Eaten")
		DebugMode("ItemRemoved - food, openEat = " + openEat + "; akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )
		Float PassedTime
		MagicEffect FoodEffect = Check_RN_FoodEffect(p)
		If RN_Mgef_Drinks.Find(FoodEffect) > -1
			PassedTime = rnDrinkTime
		ElseIf FoodEffect == RN_Mgef_Food_Snack || FoodEffect == RN_Mgef_Food_Candy || FoodEffect == RN_Mgef_Food_Fruit
			PassedTime = rnEatSnackTime
		ElseIf FoodEffect == RN_Mgef_Food_Medium
			PassedTime = rnEatMediumTime
		ElseIf FoodEffect == RN_Mgef_Food_Filling
			PassedTime = rnEatFillingTime
		ElseIf eatTime > 0
			PassedTime =  eatTime
		EndIf
		If PassedTime > 0
			PassedTime = aiItemCount * ToMinutes(PassedTime)
			TimeCalc(PassedTime)
		EndIf
	
	ElseIf akBaseItem.GetType() == 27 && spellLearnTime > 0
		Book b = akBaseItem as Book
		if b && b.GetSpell() && openSpell < Game.QueryStat("Spells Learned")
			openSpell = Game.QueryStat("Spells Learned")
			DebugMode("Spell learned.")
			TimeCalc(spellLearnTime*ExpertiseMultiplier("Speechcraft"))
		endif
		
	EndIf
	
	_critSection = False

EndFunction

Event OnMenuOpen(String MenuName)
	DebugMode("OnMenuOpen " + MenuName)
	If MenuName == "Book Menu"
		if Game.GetPlayer().IsInCombat() && cantRead
			CloseInCombat()
		else
			if UI.IsMenuOpen("InventoryMenu") && isInventoryActive
				StopReading = Utility.GetCurrentRealTime()
				Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*inventoryMult
				TimeCalc(PassedTime)
			endif
			StartReading  = Utility.GetCurrentRealTime()
		endif
	ElseIf MenuName == "ContainerMenu"
		if Game.GetPlayer().IsInCombat() && cantLoot
			CloseInCombat()
		else
			StartReading  = Utility.GetCurrentRealTime()
			looting = True
		endif
	ElseIf MenuName == "Lockpicking Menu"
		if Game.GetPlayer().IsInCombat() && cantPick
			CloseInCombat()
		else
			StartReading  = Utility.GetCurrentRealTime()
		endif
	ElseIf MenuName == "Crafting Menu"
		;RegisterForTrackedStatsEvent()
		openArmorsImproved = Game.QueryStat("Armor Improved")
		openWeaponsImproved = Game.QueryStat("Weapons Improved")
		openEnchantings = Game.QueryStat("Magic Items Made")
		openPotions = Game.QueryStat("Potions Mixed")
		openPoisons = Game.QueryStat("Poisons Mixed")
		crafting = True
	ElseIf MenuName == "Training Menu"
		StartReading  = Utility.GetCurrentRealTime()
		openTraining = Game.QueryStat("Training Sessions")
	ElseIf MenuName == "StatsMenu"
		if Game.GetPlayer().IsInCombat() && cantLevelUp
			CloseInCombat()
		else
			StartReading  = Utility.GetCurrentRealTime()
			openLevel = Game.GetPlayer().getLevel()
		endif
	ElseIf MenuName == "InventoryMenu"
		if Game.GetPlayer().IsInCombat() && cantInventory
			CloseInCombat()
		else
			StartReading  = Utility.GetCurrentRealTime()
			openEat = Game.QueryStat("Food Eaten")
			openSpell = Game.QueryStat("Spells Learned")
		endif
	ElseIf MenuName == "MagicMenu"
		if Game.GetPlayer().IsInCombat() && cantMagic
			CloseInCombat()
		else
			StartReading  = Utility.GetCurrentRealTime()
		endif
	ElseIf MenuName == "Journal Menu"
		if Game.GetPlayer().IsInCombat() && cantJournal
			CloseInCombat()
		else
			StartReading  = Utility.GetCurrentRealTime()
		endif
	ElseIf MenuName == "MapMenu"
		if Game.GetPlayer().IsInCombat() && cantMap
			CloseInCombat()
		else
			StartReading  = Utility.GetCurrentRealTime()
		endif
	ElseIf MenuName == "BarterMenu"
		StartReading  = Utility.GetCurrentRealTime()
	ElseIf MenuName == "GiftMenu"
		StartReading  = Utility.GetCurrentRealTime()
	EndIf
EndEvent 

Event OnMenuClose(String MenuName)
	DebugMode("OnMenuClose " + MenuName)
	If !CloseBook 
		If MenuName == "Book Menu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*readMult
			TimeCalc(PassedTime*ExpertiseMultiplier("Speechcraft"))
			if (readingIncreasesSpeech)
				SkillIncrease("Speechcraft", (StopReading-StartReading)*readingIncreaseMult)
			endif
			if UI.IsMenuOpen("InventoryMenu") && isInventoryActive
				StartReading = Utility.GetCurrentRealTime()
			endif
		ElseIf MenuName == "ContainerMenu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*lootMult
			if isPlayerPickpocketing()
				PassedTime = (((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*pickpocketMult)*ExpertiseMultiplier("Pickpocket")
			endif
			TimeCalc(PassedTime)
			looting = False
		ElseIf MenuName == "Lockpicking Menu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*pickMult
			TimeCalc(PassedTime*ExpertiseMultiplier("Lockpicking"))
		ElseIf MenuName == "Crafting Menu"
			;UnregisterForTrackedStatsEvent()
			closeArmorsImproved = Game.QueryStat("Armor Improved")
			if (closeArmorsImproved - openArmorsImproved) > 0
				DebugMode("Armor Improved. Before: " + openArmorsImproved + ". After: " + closeArmorsImproved)
				TimeCalc(armorImproveTime*ExpertiseMultiplier("Smithing"))
			endif
			closeWeaponsImproved = Game.QueryStat("Weapons Improved")
			if (closeWeaponsImproved - openWeaponsImproved) > 0
				DebugMode("Weapons Improved. Before: " + openWeaponsImproved + ". After: " + closeWeaponsImproved)
				TimeCalc(weaponImproveTime*ExpertiseMultiplier("Smithing"))
			endif
			closeEnchantings = Game.QueryStat("Magic Items Made")
			if (closeEnchantings - openEnchantings) > 0
				DebugMode("Magic Items Made. Before: " + openEnchantings + ". After: " + closeEnchantings)
				TimeCalc(enchantingTime*ExpertiseMultiplier("Enchanting"))
			endif
;			closePotions = Game.QueryStat("Potions Mixed")
;			if (closePotions - openPotions) > 0
;				DebugMode("Potions Mixed. Before: " + openPotions + ". After: " + closePotions)
;				TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))
;			endif
;			closePoisons = Game.QueryStat("Poisons Mixed")
;			if (closePoisons - openPoisons) > 0
;				DebugMode("Poisons Mixed. Before: " + openPoisons + ". After: " + closePoisons)
;				TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))
;			endif
			crafting = False
		ElseIf MenuName == "Training Menu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*trainingMult
			closeTraining = Game.QueryStat("Training Sessions")
			PassedTime = PassedTime + ((closeTraining - openTraining )*trainingTime)
			TimeCalc(PassedTime)
		ElseIf MenuName == "StatsMenu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*levelUpMult
			closeLevel = Game.GetPlayer().getLevel()
			PassedTime = PassedTime + ((closeLevel - openLevel)*levelUpTime)
			TimeCalc(PassedTime)
		ElseIf MenuName == "InventoryMenu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*inventoryMult
			TimeCalc(PassedTime)
		ElseIf MenuName == "MagicMenu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*magicMult
			TimeCalc(PassedTime)
		ElseIf MenuName == "Journal Menu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*journalMult
			TimeCalc(PassedTime)
		ElseIf MenuName == "MapMenu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*mapMult
			TimeCalc(PassedTime)
		ElseIf MenuName == "BarterMenu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*barterMult
			TimeCalc(PassedTime)
		ElseIf MenuName == "GiftMenu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*giftMult
			TimeCalc(PassedTime)
		EndIf
	Else
		CloseBook = False
	EndIf
EndEvent

Event OnTrackedStatsEvent(string asStatFilter, int aiStatValue)
	;if (asStatFilter == "Armor Improved")
	;	TimeCalc(armorImproveTime*ExpertiseMultiplier("Smithing"))
	;elseif (asStatFilter == "Weapons Improved")
	;	TimeCalc(weaponImproveTime*ExpertiseMultiplier("Smithing"))
	;elseif (asStatFilter == "Magic Items Made")
	;	TimeCalc(enchantingTime*ExpertiseMultiplier("Enchanting"))
	;elseif (asStatFilter == "Potions Mixed")
	;	TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))
	;elseif (asStatFilter == "Poisons Mixed")
	;	TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))		
	;endif
EndEvent

Function StartFurniture(ObjectReference akFurniture)
	If akFurniture.HasKeywordString("CraftingCookpot")
		crafting_furniture = "cook"
	ElseIf akFurniture.HasKeywordString("CraftingTanningRack")
		crafting_furniture = "tanrack"
	ElseIf akFurniture.HasKeywordString("CraftingSmithingForge")
		crafting_furniture = "forge"
	ElseIf akFurniture.HasKeywordString("CraftingSmithingArmorTable")
		crafting_furniture = "temper"
	ElseIf akFurniture.HasKeywordString("CraftingSmithingSharpeningWheel")
		crafting_furniture = "sharpen"
	ElseIf akFurniture.HasKeywordString("CraftingSmithingSkyforge")
		crafting_furniture = "skyforge"
	ElseIf akFurniture.HasKeywordString("CraftingSmelter")
		crafting_furniture = "smelt"
	ElseIf akFurniture.HasKeywordString("isAlchemy")
		crafting_furniture = "alchemy"
	ElseIf akFurniture.HasKeywordString("isEnchanting")
		crafting_furniture = "enchant"
	ElseIf akFurniture.HasKeywordString("_DE_CraftingSurvival")
		crafting_furniture = "ff_survival"
	ElseIf akFurniture.HasKeywordString("_DS_KW_CraftingScrimshaw")
		crafting_furniture = "hb_scrimshaw"
	ElseIf akFurniture.HasKeywordString("_DS_KW_CraftingPrimitiveCooking")
		crafting_furniture = "hb_primitivecook"
	Else
		crafting_furniture = "other"
	EndIf
	DebugMode("Furniture mode: " + crafting_furniture)
EndFunction

Function StopFurniture(ObjectReference akFurniture)
	crafting_furniture = ""
EndFunction

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

Function CheckModStatus()
	Init_FF_Items()
	Init_RN_Items()
	Init_HB_Items()
	Init_WL_Items()
	Init_LC_Items()
	_critSection = False
EndFunction

Function Init_FF_Items()

	FF_Items_Pelt = Game.GetFormFromFile(0x041045, "Chesko_Frostfall.esp")
	FF_Prefix = GetFormPrefix(FF_Items_Pelt)
	_is_FF_Active = FF_Prefix > 0
	DebugMode("FF prefix: " + FF_Prefix)
	
	If !_is_FF_Active
		Return
	EndIf

	; Deprecated. There are more effects than these now, and it's easier to just check prefix.
;	FF_Exclusions = new Form[3]
;	FF_Exclusions[0]			= Game.GetFormFromFile(0x05B864, "Chesko_Frostfall.esp");Soothe
;	FF_Exclusions[1]			= Game.GetFormFromFile(0x05B867, "Chesko_Frostfall.esp");Bask
;	FF_Exclusions[2]			= Game.GetFormFromFile(0x05B869, "Chesko_Frostfall.esp");Revel
	
	FF_Items_Cloaks = new Form[4]
	FF_Items_Cloaks[0]			= Game.GetFormFromFile(0x03FA9C, "Chesko_Frostfall.esp") ; "Travel Cloak, Burlap" [ARMO:0203FA9C]
	FF_Items_Cloaks[1]			= Game.GetFormFromFile(0x03FA9E, "Chesko_Frostfall.esp") ; "Travel Cloak, Fur" [ARMO:0203FA9E]
	FF_Items_Cloaks[2]			= Game.GetFormFromFile(0x03FA9F, "Chesko_Frostfall.esp") ; "Travel Cloak, Hide" [ARMO:0203FA9F]
	FF_Items_Cloaks[3]			= Game.GetFormFromFile(0x03FA9D, "Chesko_Frostfall.esp") ; "Travel Cloak, Linen" [ARMO:0203FA9D]
	
	FF_Items_Stick				= Game.GetFormFromFile(0x03C96B, "Chesko_Frostfall.esp") ; "Walking Stick" [WEAP:0203C96B]
	FF_Items_Torch				= Game.GetFormFromFile(0x019DAF, "Chesko_Frostfall.esp") ; "Torch" [MISC:02019DAF]
	FF_Items_Cookpot			= Game.GetFormFromFile(0x019849, "Chesko_Frostfall.esp") ; " Cooking Pot" [MISC:02019849]

	FF_Items_Backpacks = new Form[3]
	FF_Items_Backpacks[0]		= Game.GetFormFromFile(0x02C261, "Chesko_Frostfall.esp") ; "Backpack, Black Fur" [ARMO:0202C261]
	FF_Items_Backpacks[1]		= Game.GetFormFromFile(0x02C260, "Chesko_Frostfall.esp") ; "Backpack, Brown Fur" [ARMO:0202C260]
	FF_Items_Backpacks[2]		= Game.GetFormFromFile(0x02C262, "Chesko_Frostfall.esp") ; "Backpack, White Fur" [ARMO:0202C262]
	
	FF_Items_SmallTents = new Form[4]
	FF_Items_SmallTents[0]		= Game.GetFormFromFile(0x036B4E, "Chesko_Frostfall.esp") ; " Small Fur Tent, Bed Roll" [MISC:02036B4E]
	FF_Items_SmallTents[1]		= Game.GetFormFromFile(0x0624FB, "Chesko_Frostfall.esp") ; " Small Fur Tent, 2x Bed Roll" [MISC:020624FB]
	FF_Items_SmallTents[2]		= Game.GetFormFromFile(0x01A314, "Chesko_Frostfall.esp") ; " Small Leather Tent, Bed Roll" [MISC:0201A314]
	FF_Items_SmallTents[3]		= Game.GetFormFromFile(0x036B70, "Chesko_Frostfall.esp") ; " Small Leather Tent, 2x Bed Roll" [MISC:02036B70]
	
	FF_Items_LargeTents = new Form[7]
	FF_Items_LargeTents[0]		= Game.GetFormFromFile(0x01A348, "Chesko_Frostfall.esp") ; " Large Fur Tent, Bed Roll" [MISC:0201A348]
	FF_Items_LargeTents[1]		= Game.GetFormFromFile(0x01A347, "Chesko_Frostfall.esp") ; " Large Fur Tent, 2x Bed Roll" [MISC:0201A347]
	FF_Items_LargeTents[2]		= Game.GetFormFromFile(0x01A33E, "Chesko_Frostfall.esp") ; " Large Fur Tent, 3x Bed Roll" [MISC:0201A33E]
	FF_Items_LargeTents[3]		= Game.GetFormFromFile(0x01A33D, "Chesko_Frostfall.esp") ; " Large Fur Tent, 4x Bed Roll" [MISC:0201A33D]
	FF_Items_LargeTents[4]		= Game.GetFormFromFile(0x038CBC, "Chesko_Frostfall.esp") ; " Large Leather Tent, Bed Roll" [MISC:02038CBC]
	FF_Items_LargeTents[5]		= Game.GetFormFromFile(0x038CBD, "Chesko_Frostfall.esp") ; " Large Leather Tent, 2x Bed Roll" [MISC:02038CBD]
	FF_Items_LargeTents[6]		= Game.GetFormFromFile(0x038CBE, "Chesko_Frostfall.esp") ; " Large Leather Tent, 3x Bed Roll" [MISC:02038CBE]
	
	FF_Items_Hatchet			= Game.GetFormFromFile(0x04103D, "Chesko_Frostfall.esp") ; "Stone Hatchet" [WEAP:0204103D]
	FF_Items_Linen				= Game.GetForm(0x00034CD6) ; "Linen Wrap" [MISC:00034CD6]
	FF_Items_Lace				= Game.GetFormFromFile(0x041044, "Chesko_Frostfall.esp") ; "Hide Lace" [MISC:02041044]
	FF_Items_TanRack			= Game.GetFormFromFile(0x036B4F, "Chesko_Frostfall.esp") ; "Tanning Rack" [MISC:02036B4F]
	FF_Items_Mortar				= Game.GetFormFromFile(0x038689, "Chesko_Frostfall.esp") ; "Mortar and Pestle" [MISC:02038689]
	FF_Items_Ench				= Game.GetFormFromFile(0x038680, "Chesko_Frostfall.esp") ; "Enchanting Supplies" [MISC:02038680]
	
EndFunction

Function Init_RN_Items()

	RN_Items_Bedroll = Game.GetFormFromFile(0x0177CD, "RealisticNeedsandDiseases.esp")
	RN_Prefix = GetFormPrefix(RN_Items_Bedroll)
	_is_RN_Active = RN_Prefix > 0
	DebugMode("RND prefix: " + RN_Prefix)
	
	If !_is_RN_Active
		Return
	EndIf

	RN_Items_Waterskin			= Game.GetFormFromFile(0x046497, "RealisticNeedsandDiseases.esp") ; "Waterskin" [ALCH:03046497]
	RN_Items_Cookpot			= Game.GetForm(0x000318FB) ; "Cast Iron Pot" [MISC:000318FB]
	RN_Items_Tinderbox			= Game.GetFormFromFile(0x03067C, "RealisticNeedsandDiseases.esp") ; "Tinderbox" [MISC:0303067C]
	RN_Items_Tent				= Game.GetFormFromFile(0x031144, "RealisticNeedsandDiseases.esp") ; "Traveller's Tent" [MISC:03031144]
	RN_Items_MilkBucket			= Game.GetFormFromFile(0x0B1CE9, "RealisticNeedsandDiseases.esp") ; "Milk Bucket" [MISC:030B1CE9]
	
	RN_Items_Water = new Form[11]
	RN_Items_Water[0]			= Game.GetFormFromFile(0x005968, "RealisticNeedsandDiseases.esp") ; "Water" [ALCH:03005968]
	RN_Items_Water[1]			= Game.GetFormFromFile(0x0053EC, "RealisticNeedsandDiseases.esp") ; "Boiled Water" [ALCH:030053EC]
	RN_Items_Water[2]			= Game.GetFormFromFile(0x0053EE, "RealisticNeedsandDiseases.esp") ; "Boiled Water" [ALCH:030053EE]
	RN_Items_Water[3]			= Game.GetFormFromFile(0x0053F0, "RealisticNeedsandDiseases.esp") ; "Boiled Water" [ALCH:030053F0]
	RN_Items_Water[4]			= Game.GetFormFromFile(0x00FBA0, "RealisticNeedsandDiseases.esp") ; "Boiled Water" [ALCH:0300FBA0]
	RN_Items_Water[5]			= Game.GetFormFromFile(0x00FB99, "RealisticNeedsandDiseases.esp") ; "Boiled Water" [ALCH:0300FB99]
	RN_Items_Water[6]			= Game.GetFormFromFile(0x00FB9B, "RealisticNeedsandDiseases.esp") ; "Boiled Water" [ALCH:0300FB9B]
	RN_Items_Water[7]			= Game.GetFormFromFile(0x047F94, "RealisticNeedsandDiseases.esp") ; "Waterskin(Boiled Water): Full" [ALCH:03047F94]
	RN_Items_Water[8]			= Game.GetFormFromFile(0x047F96, "RealisticNeedsandDiseases.esp") ; "Waterskin(Boiled Water): 3/4" [ALCH:03047F96]
	RN_Items_Water[9]			= Game.GetFormFromFile(0x047F9A, "RealisticNeedsandDiseases.esp") ; "Waterskin(Boiled Water): 2/4" [ALCH:03047F9A]
	RN_Items_Water[10]			= Game.GetFormFromFile(0x047F98, "RealisticNeedsandDiseases.esp") ; "Waterskin(Boiled Water): 1/4" [ALCH:03047F98]
	
	RN_Items_Salt = new Form[4]
	RN_Items_Salt[0]			= Game.GetFormFromFile(0x068A32, "RealisticNeedsandDiseases.esp") ; "Salt Pile" [MISC:03068A32]
	RN_Items_Salt[1]			= Game.GetFormFromFile(0x068A33, "RealisticNeedsandDiseases.esp") ; "Salt Pile" [MISC:03068A33]
	RN_Items_Salt[2]			= Game.GetFormFromFile(0x068A34, "RealisticNeedsandDiseases.esp") ; "Salt Pile" [MISC:03068A34]
	RN_Items_Salt[3]			= Game.GetFormFromFile(0x069FC1, "RealisticNeedsandDiseases.esp") ; "Salt Pile" [MISC:03069FC1]
	
	RN_Mgef_Drinks = new MagicEffect[6]
	RN_Mgef_Drinks[0]			= Game.GetFormFromFile(0x006437, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Small Bottle" [MGEF:02006437]
	RN_Mgef_Drinks[1]			= Game.GetFormFromFile(0x01114F, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Medium Bottle" [MGEF:0201114F]
	RN_Mgef_Drinks[2]			= Game.GetFormFromFile(0x011150, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Large Bottle" [MGEF:02011150]
	RN_Mgef_Drinks[3]			= Game.GetFormFromFile(0x00FB9F, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Decrease Thirst" [MGEF:0200FB9F]
	RN_Mgef_Drinks[4]			= Game.GetFormFromFile(0x06442A, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Seawater" [MGEF:0206442A]
	RN_Mgef_Drinks[5]			= Game.GetFormFromFile(0x01BDD6, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Skooma" [MGEF:0201BDD6]

	RN_Mgef_Food_Snack			= Game.GetFormFromFile(0x003375, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Snack" [MGEF:02003375]
	RN_Mgef_Food_Medium			= Game.GetFormFromFile(0x004919, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Medium Meal" [MGEF:02004919]
	RN_Mgef_Food_Filling		= Game.GetFormFromFile(0x004918, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Filling Meal" [MGEF:02004918]
	RN_Mgef_Food_Candy			= Game.GetFormFromFile(0x003E4D, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Sweet Candy" [MGEF:02003E4D]
	RN_Mgef_Food_Fruit			= Game.GetFormFromFile(0x01114D, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Fresh Fruit" [MGEF:0201114D]
	
	RN_Mgef_Foods = new MagicEffect[5]
	RN_Mgef_Foods[0]			= RN_Mgef_Food_Snack
	RN_Mgef_Foods[1]			= RN_Mgef_Food_Medium
	RN_Mgef_Foods[2]			= RN_Mgef_Food_Filling
	RN_Mgef_Foods[3]			= RN_Mgef_Food_Candy
	RN_Mgef_Foods[4]			= RN_Mgef_Food_Fruit

EndFunction

Function Init_HB_Items()

	HB_Items_ScrimBits = Game.GetFormFromFile(0x006953, "Hunterborn.esp")
	HB_Prefix = GetFormPrefix(HB_Items_ScrimBits)
	_is_HB_Active = HB_Prefix > 0
	DebugMode("HB prefix: " + HB_Prefix)
	
	If !_is_HB_Active
		Return
	EndIf
	
	HB_Items_Leather			= Game.GetForm(0x000DB5D2)
	HB_Items_LeatherStrips		= Game.GetForm(0x000800E4)
	Form flute					= Game.GetForm(0x000DABA7)
	
	HB_Items_Vanilla = new Form[3]
	HB_Items_Vanilla[0]			= HB_Items_Leather
	HB_Items_Vanilla[1]			= HB_Items_LeatherStrips
	HB_Items_Vanilla[2]			= flute
	
	HB_Items_ScrimIdols = new Form[7]
	; Engraved Bones
	HB_Items_ScrimIdols[0]		= Game.GetFormFromFile(0x02617B, "Hunterborn.esp") ; Hircine
	HB_Items_ScrimIdols[1]		= Game.GetFormFromFile(0x025C11, "Hunterborn.esp") ; Julianos
	HB_Items_ScrimIdols[2]		= Game.GetFormFromFile(0x02617C, "Hunterborn.esp") ; Kynareth
	; Ritual Bones
	HB_Items_ScrimIdols[3]		= Game.GetFormFromFile(0x03E7B8, "Hunterborn.esp") ; Elm
	HB_Items_ScrimIdols[4]		= Game.GetFormFromFile(0x03E7B9, "Hunterborn.esp") ; Oak
	HB_Items_ScrimIdols[5]		= Game.GetFormFromFile(0x03D219, "Hunterborn.esp") ; Yew
	; Bone and Blood
	HB_Items_ScrimIdols[6]		= Game.GetFormFromFile(0x1344E6, "Hunterborn.esp")
	
	HB_Items_CacheMarker		= Game.GetFormFromFile(0x03A6C0, "Hunterborn.esp")
	
	HB_Items_ScrimTools = new Form[2]
	HB_Items_ScrimTools[0]		= flute
	HB_Items_ScrimTools[1]		= Game.GetFormFromFile(0x09C5E8, "Hunterborn.esp") ; Knucklebones
	
	HB_Items_Bedroll			= Game.GetFormFromFile(0x022B89, "Hunterborn.esp")
	
	HB_Items_Tallow				= Game.GetFormFromFile(0x0AB90D, "Hunterborn.esp")
	
	HB_Items_Lures = new Form[3]
	HB_Items_Lures[0]			= Game.GetFormFromFile(0x09C5C9, "Hunterborn.esp") ; "Tasty Carrot" [ALCH:0509C5C9]
	HB_Items_Lures[1]			= Game.GetFormFromFile(0x09C5CF, "Hunterborn.esp") ; "Tasty Chicken" [ALCH:0509C5CF]
	HB_Items_Lures[2]			= Game.GetFormFromFile(0x09C5D7, "Hunterborn.esp") ; "Smelly Meat" [ALCH:0509C5D7]
		
	HB_Skin_Level				= Game.GetFormFromFile(0x007422, "Hunterborn.esp") as GlobalVariable
	HB_Harvest_Level			= Game.GetFormFromFile(0x0089BB, "Hunterborn.esp") as GlobalVariable

EndFunction

Function Init_WL_Items()

	WL_Items_Wearable = Game.GetFormFromFile(0x0012C9, "Chesko_WearableLantern.esp")
	WL_Prefix = GetFormPrefix(WL_Items_Wearable)
	_is_WL_Active = WL_Prefix > 0
	DebugMode("WL prefix: " + WL_Prefix)
	
	If !_is_WL_Active
		Return
	EndIf
	
	WL_Items_Chassis = Game.GetForm(0x000318EC)
	WL_Items_Oil = Game.GetFormFromFile(0x002300, "Chesko_WearableLantern.esp")
	
EndFunction

Function Init_LC_Items()

	LC_Items_Candle = Game.GetFormFromFile(0x00234E, "lanterns.esp")
	LC_Prefix = GetFormPrefix(LC_Items_Candle)
	_is_LC_Active = LC_Prefix > 0
	DebugMode("LC prefix: " + LC_Prefix)
	
	If !_is_LC_Active
		Return
	EndIf
	
	LC_Items_Basic = new Form[7]
	LC_Items_Basic[0]			= Game.GetFormFromFile(0x0028CC, "lanterns.esp") ; Wine Bottles...
	LC_Items_Basic[1]			= Game.GetFormFromFile(0x0028C7, "lanterns.esp")
	LC_Items_Basic[2]			= Game.GetFormFromFile(0x0028C2, "lanterns.esp")
	LC_Items_Basic[3]			= Game.GetFormFromFile(0x0028B8, "lanterns.esp")
	LC_Items_Basic[4]			= Game.GetFormFromFile(0x001863, "lanterns.esp") ; "Glazed Candle" [MISC:01001863]
	LC_Items_Basic[5]			= Game.GetFormFromFile(0x001868, "lanterns.esp") ; "Glazed Candle" [MISC:01001868]
	LC_Items_Basic[6]			= Game.GetFormFromFile(0x000D72, "lanterns.esp") ; "Lantern" [MISC:01000D72]

	LC_Items_Arcane = new Form[2]
	LC_Items_Arcane[0]			= Game.GetFormFromFile(0x0043C4, "lanterns.esp") ; Bottle Wizard's Lamps
	LC_Items_Arcane[1]			= Game.GetFormFromFile(0x0038F7, "lanterns.esp")
	
EndFunction

Int Function GetFormPrefix(Form akForm)
	Return Math.RightShift(akForm.GetFormID(), 24)
EndFunction

Bool Function Check_FF_Craft(Form akBaseItem, int aiType, int aiItemCount)
	DebugMode("Check_FF_Craft...")
	
	Float t
	Float totalBaseTime

	If akBaseItem == FF_Items_Pelt
		totalBaseTime = ffPeltTime * aiItemCount
		DebugMode("Cleaned pelt. Base time = " + ffPeltTime + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)
		
	ElseIf akBaseItem == FF_Items_Lace
		t = ToMinutes(ffLaceTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Hide lace. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)
	
	ElseIf akBaseItem == FF_Items_Linen
		t = ToMinutes(ffLinenTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Linen wrap. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)
	
	ElseIf akBaseItem == FF_Items_Torch
		t = ToMinutes(ffTorchTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Torch. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)
	
	ElseIf akBaseItem == FF_Items_Stick
		t = ToMinutes(ffStickTime)
		DebugMode("Walking stick. Base time = " + t)
		TimeCalc(t)
	
	ElseIf akBaseItem == FF_Items_Cookpot
		DebugMode("Cookpot. Base time = " + ffCookpotTime)
		TimeCalc(ffCookpotTime)
	
	ElseIf akBaseItem == FF_Items_TanRack
		t = ToMinutes(ffTanRackTime)
		DebugMode("Tanning rack. Base time = " + t)
		TimeCalc(t)
	
	ElseIf akBaseItem == FF_Items_Mortar
		DebugMode("Mortar and pestle. Base time = " + ffMortarTime)
		TimeCalc(ffMortarTime)
	
	ElseIf akBaseItem == FF_Items_Ench
		DebugMode("Enchanting supplies. They're so enchanting! Base time = " + ffEnchTime)
		TimeCalc(ffEnchTime)
		
	ElseIf FF_Items_Cloaks.Find(akBaseItem) > -1
		DebugMode("Cloak. Base time = " + ffCloakTime)
		TimeCalc(ffCloakTime)
	
	ElseIf FF_Items_Backpacks.Find(akBaseItem) > -1
		If FF_Split_Pack
			DebugMode("Backpack, but ignored due to splitter.")
			FF_Split_Pack = False
		Else
			DebugMode("Backpack. Base time = " + ffBackpackTime)
			TimeCalc(ffBackpackTime)
		EndIf
	
	ElseIf FF_Items_SmallTents.Find(akBaseItem) > -1
		DebugMode("Small tent. Base time = " + ffSmallTentTime)
		TimeCalc(ffSmallTentTime)
	
	ElseIf FF_Items_LargeTents.Find(akBaseItem) > -1
		DebugMode("Large tent. Base time = " + ffLargeTentTime)
		TimeCalc(ffLargeTentTime)
		
	ElseIf akBaseItem == FF_Items_Hatchet
		t = ToMinutes(ffHatchetTime)
		DebugMode("Stone hatchet. Base time = " + t)
		TimeCalc(t)
		
	ElseIf aiType == 26
		int majorId = akBaseItem.GetFormID()
		int mask = Math.LeftShift(FF_Prefix, 24)
		int minorId = majorId - mask
		If minorId >= 0x04AD67 && minorId <= 0x04AD84
			DebugMode("Splitter. Ignoring next backpack and next jewelry.")
			FF_Split_Pack = True
			FF_Split_Amulet = True
		EndIf
		
	ElseIf aiType == 42
		DebugMode("Arrows. Base time = " + ffArrowsTime) ; ffArrowsTime is the time for one whole *batch* (of 24)
		TimeCalc(ffArrowsTime)
	
	Else
		DebugMode("No match found. This one's free!")
	EndIf
	
	Return True
	
EndFunction

Bool Function Check_RN_Craft(Form akBaseItem, int aiType, int aiItemCount)
	DebugMode("Check_RN_Craft...")

	Float t
	Float totalBaseTime
	
	If RN_Items_Water.Find(akBaseItem) > -1
		t = ToMinutes(rnWaterPrepTime)
		DebugMode("Water. Base time = " + t)
		TimeCalc(t)
		
	ElseIf RN_Items_Salt.Find(akBaseItem) > -1
		totalBaseTime = rnSaltTime * aiItemCount
		DebugMode("Salt. Base time = " + rnSaltTime + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)
		
	ElseIf akBaseItem == RN_Items_Tinderbox
		DebugMode("Tinderbox. Base time = " + rnTinderboxTime)
		TimeCalc(rnTinderboxTime)

	ElseIf akBaseItem == RN_Items_Waterskin
		If crafting_furniture != "cook"
			DebugMode("Waterskin. Base time = " + rnWaterskinTime)
			TimeCalc(rnWaterskinTime)
		Else
			DebugMode("Waterskin. Ignored, at cookpot.")
		EndIf

	ElseIf akBaseItem == RN_Items_Cookpot
		DebugMode("Cookpot. Base time = " + rnCookpotTime)
		TimeCalc(rnCookpotTime)

	ElseIf akBaseItem == RN_Items_Bedroll
		DebugMode("Bedroll. Base time = " + rnBedrollTime)
		TimeCalc(rnBedrollTime)

	ElseIf akBaseItem == RN_Items_Tent
		DebugMode("Tent. Base time = " + rnTentTime)
		TimeCalc(rnTentTime)

	ElseIf akBaseItem == RN_Items_MilkBucket
		t = ToMinutes(rnMilkBucketTime)
		DebugMode("Milk bucket. Base time = " + t)
		TimeCalc(t)

	; ignore other Misc (tokens)
	ElseIf aiType == 32
		DebugMode("No match found. This one's free!")
	
	Else
		; Cooked foods, etc.
		Return False
	EndIf
	
	Return True

EndFunction

MagicEffect Function Check_RN_FoodEffect(Potion akFood)

	Int n = akFood.GetNumEffects()
	MagicEffect eff
	MagicEffect result = None
	
	While n	
		n -= 1		
		eff = akFood.GetNthEffectMagicEffect(n)
		; Food effects need to take precedence, for soups.
		If RN_Mgef_Foods.Find(eff) > -1 || (result == none && RN_Mgef_Drinks.Find(eff) > -1)
			result = eff
		EndIf
	EndWhile

	If result
		DebugMode("Check_RN_FoodEffect found " + result)
	EndIf
	
	Return result

EndFunction

Bool Function Check_HB_Craft(Form akBaseItem, int aiType, int aiItemCount)
	DebugMode("Check_HB_Craft...")
	
	Float t
	Float totalBaseTime
	
	If akBaseItem == HB_Items_Leather
		totalBaseTime = hbLeatherTime * aiItemCount
		DebugMode("Leather. Base time = " + hbLeatherTime + "; x" + aiItemCount + " = " + totalBaseTime + "; Skin level = " + HB_Skin_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Skin())
		TimeCalc( totalBaseTime * HB_ExpMult_Skin() )
	
	ElseIf akBaseItem == HB_Items_LeatherStrips
		t = ToMinutes(hbStripTime)
		totalBaseTime = (t / 4) * aiItemCount
		DebugMode("Leather Strips. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime + "; Skin level = " + HB_Skin_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Skin())
		TimeCalc( totalBaseTime * HB_ExpMult_Skin() )
	
	ElseIf akBaseItem == HB_Items_ScrimBits
		t = ToMinutes(hbScrimBitsTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Scrimshaw Bits. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
		TimeCalc( totalBaseTime * HB_ExpMult_Harvest() )
		
	ElseIf akBaseItem == HB_Items_Tallow
		t = ToMinutes(hbTallowTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Tallow. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)
		
	; Armor
	ElseIf aiType == 26
		DebugMode("Armor. Base time = " + jewelryCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
		TimeCalc( jewelryCraftTime * HB_ExpMult_Harvest() )
	
	; Weapons
	ElseIf aiType == 41
		Weapon w = akBaseItem as Weapon
		if w.isBattleAxe()
			DebugMode("Weapon - Battle Axe. Base time = " + battleAxeCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( battleAxeCraftTime * HB_ExpMult_Harvest() )
		elseif w.isBow()
			DebugMode("Weapon - Bow. Base time = " + bowCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( bowCraftTime * HB_ExpMult_Harvest() )
		elseif w.isDagger()
			DebugMode("Weapon - Dagger. Base time = " + daggerCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( daggerCraftTime * HB_ExpMult_Harvest() )
		elseif w.isGreatSword()
			DebugMode("Weapon - Greatsword. Base time = " + greatswordCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( greatswordCraftTime * HB_ExpMult_Harvest() )
		elseif w.isMace()
			DebugMode("Weapon - Mace. Base time = " + maceCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( maceCraftTime * HB_ExpMult_Harvest() )
		elseif w.isStaff()
			DebugMode("Weapon - Staff. Base time = " + staffCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( staffCraftTime * HB_ExpMult_Harvest() )
		elseif w.isSword()
			DebugMode("Weapon - Sword. Base time = " + swordCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( swordCraftTime * HB_ExpMult_Harvest() )
		elseif w.isWarhammer()
			DebugMode("Weapon - Warhammer. Base time = " + warhammerCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( warhammerCraftTime * HB_ExpMult_Harvest() )
		elseif w.isWarAxe()
			DebugMode("Weapon - War Axe. Base time = " + warAxeCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( warAxeCraftTime * HB_ExpMult_Harvest() )
		else
			DebugMode("Weapon - Other? Base time = " + weaponCraftTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
			TimeCalc( weaponCraftTime * HB_ExpMult_Harvest() )
		endif
	
	; Ammo
	ElseIf aiType == 42
		; hbArrowsTime is for one batch. Either a batch of 24 with firewood, or a batch of 12 with large animal bones.
		; Also, there are recipes for x5 batches (120 or 60), so the time should be x5 for those.
		totalBaseTime = hbArrowsTime
		If aiItemCount > 24
			totalBaseTime *= 5
		EndIf
		DebugMode("Ammo. Base time = " + hbArrowsTime + "; Total time = " + totalBaseTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
		TimeCalc( totalBaseTime * HB_ExpMult_Harvest() )
	
	; Ingredient
	ElseIf aiType == 30
		t = ToMinutes(hbIngrTime)
		DebugMode("Ingredient. Base time = " + t + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
		TimeCalc( t * HB_ExpMult_Harvest() )
	
	; Brews
	ElseIf aiType == 46
		Potion p = akBaseItem as Potion
		If !p.IsFood() || HB_Items_Lures.Find(akBaseItem) > -1
			t = ToMinutes(hbBrewTime)
			DebugMode("Brew. Base time = " + t)
			TimeCalc(t)
		Else
			Return False ; Cooking is handled in parent
		EndIf
		
	ElseIf HB_Items_ScrimIdols.Find(akBaseItem) > -1
		DebugMode("Scrimshaw Idol. Base time = " + hbScrimIdolTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
		TimeCalc( hbScrimIdolTime * HB_ExpMult_Harvest() )
		
	ElseIf akBaseItem == HB_Items_CacheMarker
		; Now free
		
	ElseIf HB_Items_ScrimTools.Find(akBaseItem) > -1
		DebugMode("Scrimshaw Tool. Base time = " + hbScrimToolTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
		TimeCalc( hbScrimToolTime * HB_ExpMult_Harvest() )
		
	ElseIf akBaseItem == HB_Items_Bedroll
		DebugMode("Bedroll. Base time = " + hbBedrollTime + "; Harvest level = " + HB_Harvest_Level.GetValueInt() + "; Mult = " + HB_ExpMult_Harvest())
		TimeCalc( hbBedrollTime * HB_ExpMult_Harvest() )
		
	Else
		Return False
	EndIf
	
	Return True
	
EndFunction

Float Function HB_ExpMult_Skin()
	Return Base10Bonus(HB_Skin_Level.GetValueInt())
EndFunction

Float Function HB_ExpMult_Harvest()
	Return Base10Bonus(HB_Harvest_Level.GetValueInt())
EndFunction

; Skill  0 =   0% = 1.0 (no less time than MCM setting)
; Skill 10 = 100% = 0.5 (half the time of MCM setting)
Float Function Base10Bonus(int aiBase)
	Float bonus = aiBase
	Return 1.0 - (0.5 * (bonus / 10))
EndFunction

Bool Function Check_WL_Craft(Form akBaseItem, int aiItemCount)
	DebugMode("Check_WL_Craft...")
	
	Float t
	Float totalBaseTime

	If akBaseItem == WL_Items_Wearable
		t = ToMinutes(wlWearableTime)
		DebugMode("Travel Lantern. Base time = " + t)
		TimeCalc(t)
		
	ElseIf akBaseItem == WL_Items_Chassis
		DebugMode("Lantern chassis. Base time = " + wlChassisTime + "; Smithing = " + Game.GetPlayer().GetActorValue("Smithing") + "; Mult = " + ExpertiseMultiplier("Smithing"))
		TimeCalc( wlChassisTime * ExpertiseMultiplier("Smithing") )
		
	; http://imgur.com/gallery/g2CGG
	ElseIf akBaseItem == WL_Items_Oil
		t = ToMinutes(wlOilTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Lantern oil. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)

	Else
		DebugMode("No match found. This one's free!")
	EndIf
	
	Return True
	
EndFunction

Bool Function Check_LC_Craft(Form akBaseItem, int aiItemCount)
	DebugMode("Check_LC_Craft...")
	
	Float t
	Float totalBaseTime
	
	If akBaseItem == LC_Items_Candle
		t = ToMinutes(lcBrewTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Candle. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)
		
	ElseIf LC_Items_Basic.Find(akBaseItem) > -1
		t = ToMinutes(lcBasicTime)
		DebugMode("Basic. Base time = " + t)
		TimeCalc(t)
	
	ElseIf LC_Items_Arcane.Find(akBaseItem) > -1
		DebugMode("Arcane. Base time = " + lcArcaneTime + "; Smithing = " + Game.GetPlayer().GetActorValue("Smithing") + "; Mult = " + ExpertiseMultiplier("Smithing"))
		TimeCalc( lcArcaneTime * ExpertiseMultiplier("Smithing") )
	
	Else ; Assume a forged good
		DebugMode("Forged. Base time = " + lcForgeTime + "; Smithing = " + Game.GetPlayer().GetActorValue("Smithing") + "; Mult = " + ExpertiseMultiplier("Smithing"))
		TimeCalc( lcForgeTime * ExpertiseMultiplier("Smithing") )
	
	EndIf
	
	Return True

EndFunction

Float Function ToMinutes(Float afTime)
	Return afTime / 100 / 3 * 5
EndFunction

Function DebugMode(string sMsg)
	If _debugMode
		Debug.Trace("Living Takes Time :: " + sMsg)
	EndIf
EndFunction
