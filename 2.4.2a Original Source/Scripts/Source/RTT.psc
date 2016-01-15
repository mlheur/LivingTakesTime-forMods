Scriptname RTT extends Quest

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
;looting
Bool Property cantLoot Auto
Float Property lootMult Auto
Float Property pickpocketMult Auto
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
Bool Property expertiseReducesTime Auto
GlobalVariable Property GameHour Auto
GlobalVariable Property TimeScale Auto
Bool CloseBook = False
Float Property StartReading  Auto
Float Property StopReading  Auto
Actor LastTarget = None
Bool _isModActive = False

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
	Float Time = GameHour.GetValue()
	Int Std = Math.Floor(Time)
	Time = Time - Std
	Time = Time + (PassedTime)
	Time = Time + Std
	Int Hours = Math.Floor(PassedTime)
	Int Minutes =  Math.Floor((PassedTime - Hours)*100*3/5)
	if (dontShowMessage == false || Hours !=0 || Minutes != 0)
		if(showMessage)
			RTT_Message.Show(Hours,Minutes)
		
			;Debug.Notification("$RTT_TIME_PASSED")
		endif
	endif
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
	int type = akBaseItem.GetType()
	if akSourceContainer ;if items come from a container they're not crafted and we should skip, this fixes problems with jaggarfeld and such
		return
	endif
	if crafting
		if ( type == 26)
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
				TimeCalc(jewelryCraftTime*ExpertiseMultiplier("Smithing"))
			else
				;whatever is left
				TimeCalc(armorCraftTime*ExpertiseMultiplier("Smithing"))
			endif
		elseif ( type == 41)
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
				;ammo and whatever is left
				TimeCalc(weaponCraftTime*ExpertiseMultiplier("Smithing"))
			endif
		elseif ( type == 32 || type == 52 ) ;misc and soul gems
			;filter for added and removed workbenches
			Form[] Exclusions = new Form[26]
			Exclusions[0]	= Game.GetFormFromFile(0x000030DF, "HearthFires.esm");House - Workbench
			Exclusions[1]	= Game.GetFormFromFile(0x00003121, "HearthFires.esm");House - Remove Workbench
			Exclusions[2]	= Game.GetFormFromFile(0x000030E7, "HearthFires.esm");Main Hall - Workbenches
			Exclusions[3]	= Game.GetFormFromFile(0x00003122, "HearthFires.esm");Main Hall - Remove Workbenches
			Exclusions[4]	= Game.GetFormFromFile(0x0000312B, "HearthFires.esm");Entryway - Workbench
			Exclusions[5]	= Game.GetFormFromFile(0x0000312C, "HearthFires.esm");Entryway - Remove Workbench
			Exclusions[6]	= Game.GetFormFromFile(0x00003ADA, "HearthFires.esm");Bedrooms - Workbench
			Exclusions[7]	= Game.GetFormFromFile(0x00003ADB, "HearthFires.esm");Bedrooms - Remove Workbench
			Exclusions[8]	= Game.GetFormFromFile(0x00003ADC, "HearthFires.esm");Greenhouse - Workbench
			Exclusions[9]	= Game.GetFormFromFile(0x00003ADD, "HearthFires.esm");Greenhouse - Remove Workbench
			Exclusions[10]	= Game.GetFormFromFile(0x00003ADE, "HearthFires.esm");Enchanter's Tower - Workbench
			Exclusions[11]	= Game.GetFormFromFile(0x00003ADF, "HearthFires.esm");Enchanter's Tower - Remove Workbench
			Exclusions[12]	= Game.GetFormFromFile(0x00003AE0, "HearthFires.esm");Storage Room - Workbench
			Exclusions[13]	= Game.GetFormFromFile(0x00003AE1, "HearthFires.esm");Storage Room - Remove Workbench
			Exclusions[14]	= Game.GetFormFromFile(0x00003AE2, "HearthFires.esm");Trophy Room - Workbench
			Exclusions[15]	= Game.GetFormFromFile(0x00003AE3, "HearthFires.esm");Trophy Room - Remove Workbench
			Exclusions[16]	= Game.GetFormFromFile(0x00003AE4, "HearthFires.esm");Alchemy Laboratory - Workbench
			Exclusions[17]	= Game.GetFormFromFile(0x00003AE5, "HearthFires.esm");Alchemy Laboratory - Remove Workbench
			Exclusions[18]	= Game.GetFormFromFile(0x00003AE6, "HearthFires.esm");Armory - Workbench
			Exclusions[19]	= Game.GetFormFromFile(0x00003AE7, "HearthFires.esm");Armory - Remove Workbench
			Exclusions[20]	= Game.GetFormFromFile(0x00003AE8, "HearthFires.esm");Kitchen - Workbench
			Exclusions[21]	= Game.GetFormFromFile(0x00003AE9, "HearthFires.esm");Kitchen - Remove Workbench
			Exclusions[22]	= Game.GetFormFromFile(0x00003AEA, "HearthFires.esm");Library - Workbench
			Exclusions[23]	= Game.GetFormFromFile(0x00003AEB, "HearthFires.esm");Library - Remove Workbench
			Exclusions[24]	= Game.GetFormFromFile(0x00003AEC, "HearthFires.esm");Cellar - Workbench
			Exclusions[25]	= Game.GetFormFromFile(0x00003AED, "HearthFires.esm");Cellar - Remove Workbench
			int i = Exclusions.length
			while i
				i -=1
				if akBaseItem == Exclusions[i]
					return
				endif
			endwhile
			if akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryBuilding")
				Debug.Notification("building "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
				Game.GetPlayer().AddItem(akBaseItem)
			elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryContainers")
				Debug.Notification("container "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
			elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryFurniture")
				Debug.Notification("furniture "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
			elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryWeaponRacks")
				Debug.Notification("weaponrack "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
			elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryShelf")
				Debug.Notification("shelf "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
			elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryExterior")
				Debug.Notification("exterior "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
			elseif miscCraftTime > 0
				Debug.Notification("misc "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
				TimeCalc(miscCraftTime*ExpertiseMultiplier("Smithing"))
			endif
		endif
	endif
EndFunction

Function ItemRemoved (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if _isModActive
		if akBaseItem.GetType() == 46 && eatTime > 0
			Potion p = akBaseItem as Potion
			Form[] Exclusions = new Form[3]
			Exclusions[0]	= Game.GetFormFromFile(0x05B864, "Chesko_Frostfall.esp");Soothe
			Exclusions[1]	= Game.GetFormFromFile(0x05B867, "Chesko_Frostfall.esp");Bask
			Exclusions[2]	= Game.GetFormFromFile(0x05B869, "Chesko_Frostfall.esp");Revel
			int i = Exclusions.length
			while i
				i -=1
				if akBaseItem == Exclusions[i]
					return
				endif
			endwhile
			if p.isFood() && openEat < Game.QueryStat("Food Eaten")
				openEat = Game.QueryStat("Food Eaten")
				Float PassedTime =  aiItemCount*(eatTime/100/3*5)
				TimeCalc(PassedTime)
			endif
		endif
		if akBaseItem.GetType() == 27 && spellLearnTime > 0
			Book b = akBaseItem as Book
			if b.GetSpell() && openSpell < Game.QueryStat("Spells Learned")
				openSpell = Game.QueryStat("Spells Learned")
				TimeCalc(spellLearnTime*ExpertiseMultiplier("Speechcraft"))
			endif
		endif
	endif
EndFunction

Event OnMenuOpen(String MenuName)
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
		ElseIf MenuName == "Lockpicking Menu"
			StopReading  = Utility.GetCurrentRealTime()
			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*pickMult
			TimeCalc(PassedTime*ExpertiseMultiplier("Lockpicking"))
		ElseIf MenuName == "Crafting Menu"
			;UnregisterForTrackedStatsEvent()
			closeArmorsImproved = Game.QueryStat("Armor Improved")
			if (closeArmorsImproved - openArmorsImproved) > 0
				TimeCalc(armorImproveTime*ExpertiseMultiplier("Smithing"))
			endif
			closeWeaponsImproved = Game.QueryStat("Weapons Improved")
			if (closeWeaponsImproved - openWeaponsImproved) > 0
				TimeCalc(weaponImproveTime*ExpertiseMultiplier("Smithing"))
			endif
			closeEnchantings = Game.QueryStat("Magic Items Made")
			if (closeEnchantings - openEnchantings) > 0
				TimeCalc(enchantingTime*ExpertiseMultiplier("Enchanting"))
			endif
			closePotions = Game.QueryStat("Potions Mixed")
			if (closePotions - openPotions) > 0
				TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))
			endif
			closePoisons = Game.QueryStat("Poisons Mixed")
			if (closePoisons - openPoisons) > 0
				TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))
			endif
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