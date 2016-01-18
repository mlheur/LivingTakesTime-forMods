scriptname LTT extends Quest

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Credits
;	- Akezhar for proviiding the original Living Takes Time (RTT) mod
;	- dragonsong/unuroboros for providing the first iteration of
;	  compatibility between RTT and Hunterborn, Frostfall & others, and the
;	  starting point for this mod
;	- Chesko for all his awesome mods and continuing dedication to skyrim
;	- SkyUI team for MCM and just being great modders
;	- SKSE team everything they've allowed modders to do.
; Disclaimer
;	Share, re-use, re-make or steal this mod. Just don't be dick about it.
; Changes
;	mlheur | v0.0-alpha | Initial release based on Hunterborn's misc addon.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Moving mod related code to external files to cut the size of this one
import LTT_Common

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variable Declarations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Properties passed from ESP
FormList Property LTT_FL_msgTimePassed Auto ; Form list for 1st/3rd person messages when time passes
FormList Property LTT_FL_msgInCombat Auto ; Form list for 1st/3rd person messages when a task is blocked due to combat
GlobalVariable Property TimeScale Auto ; the game's timescale
GlobalVariable Property GameHour Auto ; the game's current time

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LTT Related Properties
bool	LTT_Active		= false
bool	LTT_Paused		= false
int	LTT_PauseKey		= -1
bool	LTT_FirstPersonMsgs	= false
bool	LTT_UserDebug		= false

;;;;;;;;;;;;;;;;;;;;
; State tracker IDs
int property stateMenuName		= -1 Auto
int property stateIsLooting		= -1 Auto
int property stateIsCrafting		= -1 Auto
int property stateCraftingStation	= -1 Auto
int property stateItem			= -1 Auto
int property stateItemPrefix		= -1 Auto
int property stateItemType		= -1 Auto
int property stateItemCount		= -1 Auto
int property stateItemContainer		= -1 Auto
int property stateItemHandled		= -1 Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Property Getters
;;;;;;;;;;;;;;;;;;;;
int function GetVersion()
	return LTT_Version
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Event Handlers
;;;;;;;;;;;;;;;;;;;;
event OnInit()
	OnGameReload()
endevent
event OnGameReload()
	; Ensure previous RTT mod is not loaded.
	if CheckIncompatibleMods()
		return
	endif
	
	; Init version info
	LTT_Version = _addProp( "LTT_Version", GetVersion() as string, "$LTT_Version", "$HLP_Version" ) as int
	LTT_VerString = _addProp( "LTT_VerString", _verString(), "$LTT_VerString", "$HLP_VerString" ) as string

	; Init states
	stateMenu = LTT_addState( "MenuName" )
	stateLooting = LTT_addState( "Looting" )
	stateCrafting = LTT_addState( "Crafting" )
	stateCraftingStateion = LTT_addState( "Crafting Station" )
	statePickpocketing = LTT_addState( "Pickpocketing" )
	
	
	
endevent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Manage changes to crafting

;;;;;;;;;;;;;;;;;;;;
; start using a crafting furniture
function StartFurniture(ObjectReference akFurniture)
	int ID = LTT_getLastStation()
	while ( 1 ) ; will exit when ID gets to -1
		if akFurnitur.HasKeywordString(LTT_getStation(ID))
			LTT_setState( stateCraftingStation, LTT_getStationName(ID) )
			return
		endif
		ID -= 1
	endwhile
endfunction

;;;;;;;;;;;;;;;;;;;;
; stop using a crafting furniture
function StopFurniture(ObjectReference akFurniture)
	LTT_setState( stateCraftingStation, "" )
endfunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Internal functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; return true if an incompatible mod was loaded
bool function CheckIncompatibleMods()
	bool Incompatible = false
	if Game.GetFormFromFile( 0xD62, "ReadingTakesTime.esp" )
		Debug.MessageBox( "$E_RTT_LOADED_INCOMPATIBLE" )
		Incompatible = true
	endif
	
	return Incompatible
endfunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

Bool Function TimeCalc(Float PassedTime)
	If Suspended || PassedTime <= 0
		Return true
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
	return true
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

;;;
; For performance reasons, use any excuse to exit this large function early as early as possible.
;;;
Function ItemAdded (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	
	;;;;;;;;;;;
	;;;;;;;;;;;
	;;;;;;;;;;;
	;;;;;;;;;;;
	;;;;;;;;;;;

	If Suspended || !_isModActive || UI.IsMenuOpen("Console") || akBaseItem == none
		DebugMode("--ItemAdded: Mod inactive, added by console, or not an item")
		Return
	EndIf
	DebugMode("++ItemAdded"\
		+"( akBaseItem="+akBaseItem\
		+", aiItemCount="+aiItemCount\
		+", akItemReference="+akItemReference\
		+", akSourceContainer="+akSourceContainer\
		+")"\
	)

	If (!looting && !crafting) || akSourceContainer ;if items come from a container they're not crafted and we should skip, this fixes problems with jaggarfeld and such
		DebugMode( "--ItemAdded: item taken or not crafted and not looted" )
		Return
	EndIf

	; Declare local variables
	float t = 0
	float PassedTime = 0
	int ItemType = akBaseItem.GetType()
	int ItemPrefix = GetFormPrefix(akBaseItem)
	int ItemName = akBaseItem.GetName()
	DebugMode("Derived"\
		+": ItemType="+ItemType\
		+"; ItemPrefix="+ItemPrefix\
		+"; ItemName="+ItemName\
		+")"\
	)
	DebugMode( "Flags"\
		+": _is_FF_Active="+_is_FF_Active\
		+"; _is_CF_Active="+_is_CF_Active\
		+"; _is_FF3_Active="+_is_FF_Active\
		+"; _is_RN_Active="+_is_RN_Active\
		+"; _is_HB_Active="+_is_HB_Active\
		+"; _is_WL_Active="+_is_WL_Active\
		+"; _is_LC_Active="+_is_LC_Active\
	)

	; Do this before ignoring tiny objects,
	; becuase lighting a fire in Campfire is AddItem(book)
	; and the book weighs more than 0.01
	If !ItemHandled && crafting_furniture == "cf_campfire" && type == 27 && prefix == CF_Prefix
		DebugMode("I think we're lighting a fire")
		if CF_HandleFirepit( akBaseItem )
			DebugMode("--ItemAdded: Handled Campfire Firepit")
			return
		endif
	endif

	; Ignore tiny objects. Like Fork of Damnation. *HUGE SIGH*
	; ... Except ammo, which is weightless for most people without patches. :p
	If akBaseItem.GetWeight() < 0.01 && ItemType != 42
		DebugMode("--ItemAdded: Ignoring tiny objects")
		Return
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

	;
	; Begin handlers for external mods
	;
	if _is_CF_active && HandleCampfireMod(akBaseItem, type, aiItemCount)
		DebugMode("--ItemAdded: Handled by Campfire")
		return
	elseif _is_FF3_active && HandleFrostfall3Mod(akBaseItem, type, aiItemCount)
		DebugMode("--ItemAdded: Handled by Frostfall >= 3.x")
		return
	elseif _is_FF_active && Check_FF_Craft(akBaseItem, ItemTime, aiItemCount)
		DebugMode("--ItemAdded: Handled by Chesko_Frostfall verseion < 3.x")
		return
	endif

	;TODO - Everything below this line should be moved to the handlers for external mods
	If ( (prefix == RN_Prefix || akBaseItem == RN_Items_Cookpot) && Check_RN_Craft(akBaseItem, type, aiItemCount) )
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
			If FF_Split_Amulet || CF_Splitting_Amulet
				DebugMode("Amulet, but ignored due to splitter.")
				FF_Split_Amulet = CF_Splitting_Amulet = False
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MCM Handlers
function mcmInit
	if ( isModActive )
		DebugMode("Initializing...")
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
		
		DebugMode("Checking mod dependencies, ignore errors below about missing files...")
		ReadingTakesTime.Init_HF_Exclusions()
		ReadingTakesTime.CheckModStatus()
		
		DebugMode("Done initializing!")
	else
		UnregisterForAllMenus()
		UnregisterForCrosshairRef()
	endIf
	ReadingTakesTime.InitStats(isModActive)
endfunction

