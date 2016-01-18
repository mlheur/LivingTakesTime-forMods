scriptname LTT_Skyrim extends LTT_ModBase 

LTT_Base Property LTT Auto
string	LTT_Name		= "Living TakeS Time" AutoReadOnly
string	LTT_ESP			= "Skyrim.esm" AutoReadonly

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables

;;;;;;;;;;
; While Crafting
bool	LTT_WhileCrafting	= true

;;;;;
; Wearables
float	LTT_CraftHeadHrs	= 2.0
float	LTT_CraftBodyHrs	= 6.0
float	LTT_CraftHandHrs	= 3.0
float	LTT_CraftFeetHrs	= 3.0
float	LTT_CraftShieldHrs	= 4.0
float	LTT_CraftJewlryHrs	= 1.0

;;;;;
; One handed weapon values
float	LTT_CraftOneHanded	= 4.0
float	LTT_CraftSwordHrs	= CraftOneHanded
float	LTT_CrattWAxeHrs	= CraftOneHanded
float	LTT_CraftMaceHrs	= CraftOneHanded
float	LTT_CraftDaggerHrs	= CraftOneHanded * 0.5

;;;;;
; Two handed weapon values
float	LTT_CraftTwoHanded	= 5.0
float	LTT_CraftGSwordHrs	= CraftTwoHanded
float	LTT_CraftBAxeHrs	= CraftTwoHanded
float	LTT_CraftWHamrHrs	= CraftTwoHanded
float	LTT_CraftStaffHrs	= CraftTwoHanded * 0.4

;;;;;
; Ranged weapon values
float	LTT_CraftBowHrs		= CraftOneHanded
float	LTT_CraftAmmoHrs	= CraftOneHanded * 0.5

;;;;;
; Misc item values
float	LTT_CraftMiscHrs	= 1.0

;;;;;
; While Improving Craftables
float	LTT_ImproveWeaponHrs	= 1.0
float	LTT_ImproveArmorHrs	= 1.0
float	LTT_EnchantItemHrs	= 1.0
float	LTT_BrewPotionHrs	= 1.0

;;;;;;;;;;
; While Looting
bool	LTT_WhileLooting	= true
bool	LTT_LootInCombat	= false
float	LTT_LootMult		= 1.0
float	LTT_LootLighArmMins	= 15.0
float	LTT_LootHeavyArmMins	= 45.0
bool	LTT_PickPockInCombat	= false
float	LTT_PickPockMult	= 1.0
bool	LTT_LockPickInCombat	= false
float	LTT_LockPickMult	= 1.0

;;;;;;;;;;
; While Training or Leveling
bool	LTT_WhileTraining	= true
bool	LTT_WhileLeveling	= true
bool	LTT_LevelInCombat	= false
float	LTT_TrainingMult	= 1.0
float	LTT_TrainingHrs		= 2.0
float	LTT_LevelingMul		= 1.0
float	LTT_LevelingHrs		= 1.0

;;;;;;;;;;
; While Preparing (UI Menus)
bool	LTT_WhilePreparing	= true ; disabling this disable all the below
bool	LTT_WhileInvMenyu	= true
bool	LTT_WhileMagicMenu	= true
bool	LTT_WhileJournalMenu	= true
bool	LTT_WhileMapMenu	= true
bool	LTT_WhileEating		= true
bool	LTT_InvInCombat		= false
bool	LTT_MagicInCombat	= false
bool	LTT_JournalInCombat	= false
bool	LTT_MapInCombat		= false
bool	LTT_EatInCombat		= false
float	LTT_InvMult		= 1.0
float	LTT_MagicMult		= 1.0
float	LTT_JournalMult		= 1.0
float	LTT_MapMult		= 1.0
float	LTT_EatMins		= 5.0
float	LTT_BarterMult		= 1.0
float	LTT_GiftMult		= 1.0

;;;;;;;;;;
; While Reading
int	prop_WhileReading		= -1
int	prop_ReadInCombat		= -1
int	prop_ReadTimeMult		= -1
int	prop_ReadIncreasesSpeech	= -1
int	prop_SpeechIncreaseMult		= -1
int	prop_SpellLearnHrs		= -1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions

event OnGameRelaod()
	LTT = LTT_getBase() ; from LTT_Factory
	LDH = LTT.getLDH()
	modID = LDH.addMod( self, LTT_Name, LTT_ESP, 0xf )
	if modID < 0 ; We couldn't be added to the Mod table.
		return
	endif
	
	; init Reading properties
	prop_WhileReading = LDH.addBoolProp( "LTT_WhileReading", true, "$LTT_WhileReading", "$HLP_WhileReading", 0 )
	prop_ReadInCombat = LDH.addBoolProp( "LTT_ReadInCombat", ReadInCombat, "$LTT_ReadInCombat", "$HLP_ReadInCombat", 2 )
	prop_ReadTimeMult = LDH.addFloatProp( "LTT_ReadTimeMult", 1.0, "$LTT_ReadTimeMult", "$HLP_ReadTimeMult", 4, 0.0, 10.0 )
	prop_ReadIncreasesSpeech = LDH.addBoolProp( "LTT_ReadIncreaseSpeech", false, "$LTT_ReadIncreaseSpeech", "$HLP_ReadIncreasesSpeech", 4 )
	prop_SpeechIncreaseMult = LDH.addFloatProp( "LTT_SpeechIncreasMult", 1.0, "$LTT_SpeechIncreaseMult", "$HLP_SpeechIncreaseMult", 6, 0.0, 10.0 )
	prop_SpellLearnHrs = LDH.addFloatProp( "LTT_SpellLearnHrs", 2.0, "$LTT_SpellLearnHrs", "$HLP_SpellLearnHrs", 8, 0.0, 24.0 )
endevent

;///////////////////////////////////////////////////////////////////////////////
// called when an item is added to player's inventory - normally looted or
// crafted. Returns... If this is not handled and should be passed on to the
// next mod, return a negative value ; otherwise, return the number of hours
// passed, even 0.0 if the task was free.
/;
float function ItemAdded( form Item, int Prefix, int Type, int Count, form Source )
	; Ignore tiny objects. Like Fork of Damnation. *HUGE SIGH*
	; ... Except ammo, which is weightless for most people without patches. :p
	if Item.GetWeight() < 0.01 && Type != 42
		DebugMode("--ItemAdded: Ignoring tiny objects")
		return 0.0
	EndIf

	If looting
		DebugMode("Player is looting, is it armor?")
		Actor c = akSourceContainer as Actor
		If c && c.IsDead() && ItemType==26
			Armor a = akBaseItem as Armor
			If !a
				; should never get here since we check ItemType, but still safe
			ElseIf a.IsLightArmor() && a.IsCuirass() && lightArmorTime > 0
				t = ToMinutes(lightArmorTime)
				DebugMode("--ItemAdded: Light Armor; Base time="+t)
				return
			ElseIf a.IsHeavyArmor() && a.IsCuirass() && heavyArmorTime > 0
				t = ToMinutes(heavyArmorTime)
				DebugMode("--ItemAdded: Heavy Armor; Base time="+t)
				TimeCalc(t)
				return
			EndIf
		EndIf
		; instant loot
		DebugMode("--ItemAdded: Not Armor")
		Return
	EndIf

	if crafting_furniture == "smelt"
		DebugMode("Smelting, using value from Crafting - Misc")
		TimeCalc( miscCraftTime * ExpertiseMultiplier("Smithing") )

	; Potions, poisons, food, drink [new system]
	ElseIf type == 46
		DebugMode("POTION crafted.")
		PassedTime = potionCraftTime * ExpertiseMultiplier("Alchemy") ; Default
		Potion p = akBaseItem as Potion
		If p.IsFood()
			MagicEffect FoodEffect = Check_RN_FoodEffect(p)
			If RN_MgefDrinks.Find(FoodEffect) > -1
				PassedTime = ToMinutes(rnBrewTime)
			ElseIf FoodEffect == RN_MgefFood_Snack || FoodEffect == RN_MgefFood_Candy || FoodEffect == RN_MgefFood_Fruit
				PassedTime = ToMinutes(rnCookSnackTime)
			ElseIf FoodEffect == RN_MgefFood_Medium
				PassedTime = ToMinutes(rnCookMediumTime)
			ElseIf FoodEffect == RN_MgefFood_Filling
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
			TimeCalc(jewelryCraftTime*ExpertiseMultiplier("Smithing"))
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
	
	return -1.0
endfunction

;///////////////////////////////////////////////////////////////////////////////
// called when an item is removed from player's inventory - normally eaten or drunk
// Returns the same as ItemAdded
/;
float function ItemRemoved( form Item, int Prefix, int Type, int Count, form Destination )
	; Ignore tiny objects. Like Fork of Damnation. *HUGE SIGH*
	If akBaseItem.GetWeight() < 0.01
		DebugMode(akBaseItem.GetName()+" weight: "+akBaseItem.GetWeight())
		Return
	EndIf

	; Prevent re-entry. Not sure why this happens.
	If _critSection
		DebugMode("critsection: " + akBaseItem.GetName())
		Return
	Else
		_critSection = True
	EndIf

	int type = akBaseItem.GetType()
	int prefix = GetFormPrefix(akBaseItem)

	;DebugMode("ItemRemoved. akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )
	DebugMode("ItemRemoved. akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; akDestContainer = " + akDestContainer + \
		"; type = " + type + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() + "; crafting_furniture = " + crafting_furniture)

	; Catch this early because neither eating nor learning a spell qualifies if player is looting
	; mlheur: actually, the above statement is false.  I exploited the free eating many times because of SkyUI's ability
	; to directly 'use' an object from a different container...  need to think about this.
	If looting == True
		DebugMode("Ignored, player is looting.")

	ElseIf (CF_Items_SmallTents_MoreBR.Find(akBaseItem) > -1 ) || (CF_Items_LargeTents_MoreBR.Find(akBaseItem) > -1 )
		DebugMode( "Lost a multi-bed tent, must be downgrading, this act is free and so is the next tent" )
		CF_Splitting_Bedroll = true

	ElseIf akBaseItem.GetType() == 46
		Potion p = akBaseItem as Potion
		if !p || !p.isFood() || openEat == Game.QueryStat("Food Eaten")
			_critSection = False
			Return
		ElseIf (_is_FF_Active && prefix == FF_Prefix)
			_critSection = False
			Return
		EndIf
		ElseIf (_is_CF_Active && prefix == CF_Prefix)
			_critSection = False
			Return
		EndIf
		openEat = Game.QueryStat("Food Eaten")
		DebugMode("ItemRemoved - food, openEat = " + openEat + "; akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )
		Float PassedTime
		MagicEffect FoodEffect = Check_RN_FoodEffect(p)
		If RN_MgefDrinks.Find(FoodEffect) > -1
			PassedTime = rnDrinkTime
		ElseIf FoodEffect == RN_MgefFood_Snack || FoodEffect == RN_MgefFood_Candy || FoodEffect == RN_MgefFood_Fruit
			PassedTime = rnEatSnackTime
		ElseIf FoodEffect == RN_MgefFood_Medium
			PassedTime = rnEatMediumTime
		ElseIf FoodEffect == RN_MgefFood_Filling
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
	return -1.0
endfunction

;///////////////////////////////////////////////////////////////////////////////
// called when any screen other than the 3D renedered world is displayed
// Returns the same as ItemAdded
/;
float function MenuOpened( int Menu )
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
	return -1.0
endfunction

;///////////////////////////////////////////////////////////////////////////////
// called when any screen other than the 3D renedered world is closed
// Returns the same as ItemAdded
/;
float function MenuClosed( int Menu )
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
	return -1.0
endfunction

