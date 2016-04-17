scriptname LTT_Skyrim extends LTT_ModBase

; Conventions:
; 1 - one handed
; 2 - two handed
; b - thing takes time
; Mult - multiplification factor for real time to game time conversion
; IC - allowed in combat

int property prop_CraftHeadHrs		= -1 Auto
int property prop_CraftBodyHrs		= -1 Auto
int property prop_CraftHandHrs		= -1 Auto
int property prop_CraftFootHrs		= -1 Auto
int property prop_CraftShieldHrs	= -1 Auto
int property prop_CraftJewelryHrs	= -1 Auto
int property prop_CraftMiscHrs		= -1 Auto
int property prop_EnchantHrs		= -1 Auto
int property prop_BrewHrsHrs		= -1 Auto
int property prop_ImproveArmorHrs	= -1 Auto
int property prop_ImrpoveWeaponHrs	= -1 Auto
int property prop_CraftDaggerHrs	= -1 Auto
int property prop_Craft1SwordHrs	= -1 Auto
int property prop_Craft1AxeHrs		= -1 Auto
int property prop_Craft1MaceHrs		= -1 Auto
int property prop_Craft2SwordHrs	= -1 Auto
int property prop_Craft2AxeHrs		= -1 Auto
int property prop_Craft2MaceHrs		= -1 Auto
int property prop_CraftStaffHrs		= -1 Auto
int property prop_CraftBowsHrs		= -1 Auto
int property prop_CraftAmmoHrs		= -1 Auto
int property prop_LootMult		= -1 Auto
int property prop_LootIC		= -1 Auto
int property prop_LootLightArmMins	= -1 Auto
int property prop_LootHeavyArmMins	= -1 Auto
int property prop_PickPocketMult	= -1 Auto
int property prop_PickPocketIC		= -1 Auto
int property prop_LockpickMult		= -1 Auto
int property prop_LockpickIC		= -1 Auto
int property prop_LevelMult		= -1 Auto
int property prop_LevelHrs		= -1 Auto
int property prop_LevelIC		= -1 Auto
int property prop_TrainMult		= -1 Auto
int property prop_TrainHrs		= -1 Auto
int property prop_InvMult		= -1 Auto
int property prop_InvIC			= -1 Auto
int property prop_MagMult		= -1 Auto
int property prop_MagIC			= -1 Auto
int property prop_JournalMult		= -1 Auto
int property prop_JournalIC		= -1 Auto
int property prop_MapMult		= -1 Auto
int property prop_MapIC			= -1 Auto
int property prop_EatMins		= -1 Auto
int property prop_EatIC			= -1 Auto
int property prop_BarterMult		= -1 Auto
int property prop_GiftMult		= -1 Auto
int property prop_ReadMult		= -1 Auto
int property prop_ReadIC		= -1 Auto
int property prop_SpellHrs		= -1 Auto
int property prop_ReadSpeechMult	= -1 Auto
; Not used in Vanila but used in multiple mods
int property prop_CraftDrinkMins	= -1 Auto
int property prop_CraftLeatherHrs	= -1 Auto
int property prop_CraftStripMins	= -1 Auto
int property prop_CraftBeddingHrs	= -1 Auto

event OnInit()
	ESP = "Skyrim.esm"
	TestForm = 0xf
	parent.OnInit()
endevent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()", 4 )
	isLoaded = false
	RegisterActs = Math.LogicalOr( LTT.act_ITEMADDED, LTT.act_ITEMREMOVED )
	RegisterMenus = LTT.menu_Inventory
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Magic )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Journal )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Map )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Barter )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Barter )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Gift )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_LevelUp )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Lockpicking )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Container )
	RegisterMenus = Math.LogicalOr( RegisterMenus, LTT.menu_Crafting )
	modID = LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()", 0 )
		return
	endif
	
	prop_CraftHeadHrs = LDH.addFloatProp( modID, "SK_CraftHeadHrs", LTT.craftHeadHrs, "$SK_CraftHeadHrs", "$HLP_SK_CraftHeadHrs", 1, 0.0, LTT.maxHrs, "hours" )
	prop_CraftBodyHrs = LDH.addFloatProp( modID, "SK_CraftBodyHrs", LTT.craftBodyHrs, "$SK_CraftBodyHrs", "$HLP_SK_CraftBodyHrs", 3, 0.0, LTT.maxHrs, "hours" )
	prop_CraftHandHrs = LDH.addFloatProp( modID, "SK_CraftHandHrs", LTT.craftLimbHrs, "$SK_CraftHandHrs", "$HLP_SK_CraftHandHrs", 5, 0.0, LTT.maxHrs, "hours" )
	prop_CraftFootHrs = LDH.addFloatProp( modID, "SK_CraftFootHrs", LTT.craftLimbHrs, "$SK_CraftFootHrs", "$HLP_SK_CraftFootHrs", 7, 0.0, LTT.maxHrs, "hours" )
	prop_CraftShieldHrs = LDH.addFloatProp( modID, "SK_CraftShieldHrs", LTT.craftShieldHrs, "$SK_CraftShieldHrs", "$HLP_SK_CraftShieldHrs", 9, 0.0, LTT.maxHrs, "hours" )
	prop_CraftJewelryHrs = LDH.addFloatProp( modID, "SK_CraftJewelryHrs", LTT.craftJewelryHrs, "$SK_CraftJewelryHrs", "$HLP_SK_CraftJewelryHrs", 11, 0.0, LTT.maxHrs, "hours" )
	prop_CraftMiscHrs = LDH.addFloatProp( modID, "SK_CraftMiscHrs", LTT.craftMiscHrs, "$SK_CraftMiscHrs", "$HLP_SK_CraftMiscHrs", 13, 0.0, LTT.maxHrs, "hours" )
	prop_ImproveArmorHrs = LDH.addFloatProp( modID, "SK_ImproveArmorHrs", LTT.craftMiscHrs, "$SK_ImproveArmorHrs", "$HLP_SK_ImproveArmorHrs", 15, 0.0, LTT.maxHrs, "hours" )
	prop_ImrpoveWeaponHrs = LDH.addFloatProp( modID, "SK_ImrpoveWeaponHrs", LTT.craftMiscHrs, "$SK_ImrpoveWeaponHrs", "$HLP_SK_ImrpoveWeaponHrs", 17, 0.0, LTT.maxHrs, "hours" )
	prop_EnchantHrs = LDH.addFloatProp( modID, "SK_EnchantHrs", LTT.craftMiscHrs, "$SK_EnchantHrs", "$HLP_SK_EnchantHrs", 19, 0.0, LTT.maxHrs, "hours" )
	prop_BrewHrsHrs = LDH.addFloatProp( modID, "SK_BrewHrsHrs", LTT.craftMiscHrs, "$SK_BrewHrsHrs", "$HLP_SK_BrewHrsHrs", 21, 0.0, LTT.maxHrs, "hours" )
	prop_CraftDrinkMins = LDH.addIntProp( modID, "SK_CraftDrinkMins", 5, "$SK_CraftDrinkMins", "$HLP_SK_CraftDrinkMins", 23, 0, LTT.maxMins, "minutes" )
	prop_CraftBeddingHrs = LDH.addFloatProp( modID, "SK_CraftBeddingHrs", LTT.craftMiscHrs, "$SK_CraftBeddingHrs", "$HLP_SK_CraftBeddingHrs", 25, 0.0, LTT.maxHrs, "hours" )

	prop_CraftDaggerHrs = LDH.addFloatProp( modID, "SK_CraftDaggerHrs", LTT.craftDaggerHrs, "$SK_CraftDaggerHrs", "$HLP_SK_CraftDaggerHrs", 2, 0.0, LTT.maxHrs, "hours" )
	prop_Craft1SwordHrs = LDH.addFloatProp( modID, "SK_Craft1SwordHrs", LTT.craftOneHandedHrs, "$SK_Craft1SwordHrs", "$HLP_SK_Craft1SwordHrs", 4, 0.0, LTT.maxHrs, "hours" )
	prop_Craft1AxeHrs = LDH.addFloatProp( modID, "SK_Craf1AxeHrs", LTT.craftOneHandedHrs, "$SK_Craf1AxeHrs", "$HLP_SK_Craf1AxeHrs", 6, 0.0, LTT.maxHrs, "hours" )
	prop_Craft1MaceHrs = LDH.addFloatProp( modID, "SK_Craft1MaceHrs", LTT.craftOneHandedHrs, "$SK_Craft1MaceHrs", "$HLP_SK_Craft1MaceHrs", 8, 0.0, LTT.maxHrs, "hours" )
	prop_Craft2SwordHrs = LDH.addFloatProp( modID, "SK_Craft2SwordHrs", LTT.craftTwoHandedHrs, "$SK_Craft2SwordHrs", "$HLP_SK_Craft2SwordHrs", 10, 0.0, LTT.maxHrs, "hours" )
	prop_Craft2AxeHrs = LDH.addFloatProp( modID, "SK_Craft2AxeHrs", LTT.craftTwoHandedHrs, "$SK_Craft2AxeHrs", "$HLP_SK_Craft2AxeHrs", 12, 0.0, LTT.maxHrs, "hours" )
	prop_Craft2MaceHrs = LDH.addFloatProp( modID, "SK_Craft2MaceHrs", LTT.craftTwoHandedHrs, "$SK_Craft2MaceHrs", "$HLP_SK_Craft2MaceHrs", 14, 0.0, LTT.maxHrs, "hours" )
	prop_CraftStaffHrs = LDH.addFloatProp( modID, "SK_CraftStaffHrs", LTT.craftTwoHandedHrs, "$SK_CraftStaffHrs", "$HLP_SK_CraftStaffHrs", 16, 0.0, LTT.maxHrs, "hours" )
	prop_CraftBowsHrs = LDH.addFloatProp( modID, "SK_CraftBowsHrs", LTT.craftOneHandedHrs, "$SK_CraftBowsHrs", "$HLP_SK_CraftBowsHrs", 18, 0.0, LTT.maxHrs, "hours" )
	prop_CraftAmmoHrs = LDH.addFloatProp( modID, "SK_CraftAmmoHrs", LTT.craftAmmoHrs, "$SK_CraftAmmoHrs", "$HLP_SK_CraftAmmoHrs", 20, 0.0, LTT.maxHrs, "hours" )
	prop_CraftLeatherHrs = LDH.addFloatProp( modID, "SK_CraftLeatherHrs", LTT.craftMiscHrs, "$SK_CraftLeatherHrs", "$HLP_SK_CraftLeatherHrs", 22, 0.0, LTT.maxHrs, "hours" )
	prop_CraftStripMins = LDH.addIntProp( modID, "SK_CraftStripMins", 5, "$SK_CraftStripMins", "$HLP_SK_CraftStripMins", 24, 0, LTT.maxMins, "minutes" )

	prop_LootMult = LDH.addFloatProp( modID, "SK_LootMult", 1.0, "$SK_LootMult", "$HLP_SK_LootMult", 28, 0.0, LTT.maxMult, "multiplier" )
	prop_LootIC = LDH.addBoolProp( modID, "SK_LootIC", false, "$SK_LootIC", "$HLP_SK_LootIC", 30 )
	prop_LootLightArmMins = LDH.addIntProp( modID, "SK_LootLightArmMins", 15, "$SK_LootLightArmMins", "$HLP_SK_LootLightArmMins", 32, 0, LTT.maxMins, "minutes" )
	prop_LootHeavyArmMins = LDH.addIntProp( modID, "SK_LootHeavyArmMins", 45, "$SK_LootHeavyArmMins", "$HLP_SK_LootHeavyArmMins", 34, 0, LTT.maxMins, "minutes" )

	prop_PickPocketMult = LDH.addFloatProp( modID, "SK_PickPocketMult", 1.0, "$SK_PickPocketMult", "$HLP_SK_PickPocketMult", 29, 0.0, LTT.maxMult, "multiplier" )
	prop_PickPocketIC = LDH.addBoolProp( modID, "SK_PickPocketIC", false, "$SK_PickPocketIC", "$HLP_SK_PickPocketIC", 31 )
	prop_LockpickMult = LDH.addFloatProp( modID, "SK_LockpickMult", 1.0, "$SK_LockpickMult", "$HLP_SK_LockpickMult", 33, 0.0, LTT.maxMult, "multiplier" )
	prop_LockpickIC = LDH.addBoolProp( modID, "SK_LockpickIC", false, "$SK_LockpickIC", "$HLP_SK_LockpickIC", 35 )

	prop_LevelMult = LDH.addFloatProp( modID, "SK_LevelMult", 1.0, "$SK_LevelMult", "$HLP_SK_LevelMult", 38, 0.0, LTT.maxMult, "multiplier" )
	prop_LevelHrs = LDH.addFloatProp( modID, "SK_LevelHrs", 8.0, "$SK_LevelHrs", "$HLP_SK_LevelHrs", 40, 0.0, LTT.maxHrs, "hours" )
	prop_LevelIC = LDH.addBoolProp( modID, "SK_LevelIC", false, "$SK_LevelIC", "$HLP_SK_LevelIC", 42 )

	prop_TrainMult = LDH.addFloatProp( modID, "SK_TrainMult", 1.0, "$SK_TrainMult", "$HLP_SK_TrainMult", 39, 0.0, LTT.maxMult, "multiplier" )
	prop_TrainHrs = LDH.addFloatProp( modID, "SK_TrainHrs", 4.0, "$SK_TrainHrs", "$HLP_SK_TrainHrs", 41, 0.0, LTT.maxHrs, "hours" )

	prop_InvMult = LDH.addFloatProp( modID, "SK_InvMult", 1.0, "$SK_InvMult", "$HLP_SK_InvMult", 46, 0.0, LTT.maxMult, "multiplier" )
	prop_MagMult = LDH.addFloatProp( modID, "SK_MagMult", 1.0, "$SK_MagMult", "$HLP_SK_MagMult", 48, 0.0, LTT.maxMult, "multiplier" )
	prop_JournalMult = LDH.addFloatProp( modID, "SK_JournalMult", 1.0, "$SK_JournalMult", "$HLP_SK_JournalMult", 50, 0.0, LTT.maxMult, "multiplier" )
	prop_MapMult = LDH.addFloatProp( modID, "SK_MapMult", 1.0, "$SK_MapMult", "$HLP_SK_MapMult", 52, 0.0, LTT.maxMult, "multiplier" )
	prop_EatMins = LDH.addIntProp( modID, "SK_EatMins", 30, "$SK_EatMins", "$HLP_SK_EatMins", 54, 0, LTT.maxMins, "minutes" )
	prop_BarterMult = LDH.addFloatProp( modID, "SK_BarterMult", 1.0, "$SK_BarterMult", "$HLP_SK_BarterMult", 56, 0.0, LTT.maxMult, "multiplier" )
	prop_GiftMult = LDH.addFloatProp( modID, "SK_GiftMult", 1.0, "$SK_GiftMult", "$HLP_SK_GiftMult", 58, 0.0, LTT.maxMult, "multiplier" )

	prop_InvIC = LDH.addBoolProp( modID, "SK_InvIC", false, "$SK_InvIC", "$HLP_SK_InvIC", 47 )
	prop_MagIC = LDH.addBoolProp( modID, "SK_MagIC", false, "$SK_MagIC", "$HLP_SK_MagIC", 49 )
	prop_JournalIC = LDH.addBoolProp( modID, "SK_JournalIC", false, "$SK_JournalIC", "$HLP_SK_JournalIC", 51 )
	prop_MapIC = LDH.addBoolProp( modID, "SK_MapIC", false, "$SK_MapIC", "$HLP_SK_MapIC", 53 )
	prop_EatIC = LDH.addBoolProp( modID, "SK_EatIC", false, "$SK_EatIC", "$HLP_SK_EatIC", 55 )

	prop_ReadMult = LDH.addFloatProp( modID, "SK_ReadMult", 1.0, "$SK_ReadMult", "$HLP_SK_ReadMult", 62, 0.0, LTT.maxMult, "multiplier" )
	prop_SpellHrs = LDH.addFloatProp( modID, "SK_SpellHrs", 4.0, "$SK_SpellHrs", "$HLP_SK_SpellHrs", 64, 0.0, LTT.maxHrs, "hours" )

	prop_ReadIC = LDH.addBoolProp( modID, "SK_ReadIC", false, "$SK_ReadIC", "$HLP_SK_ReadIC", 63 )
	prop_ReadSpeechMult = LDH.addFloatProp( modID, "SK_ReadSpeechMult", 1.0, "$SK_ReadSpeechMult", "$HLP_SK_ReadSpeechMult", 65, 0.0, LTT.maxMult, "multiplier" )
	
	isLoaded = Load()
	DebugLog( "--OnGameReload(); success", 4 )
endevent

bool function Load()
	DebugLog( "++Load()", 4 )
	DebugLog( "--Load(); success", 4 )
	return true
endfunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()", 4 )
	float t = -1.0
	DebugLog( "--ItemAdded() t="+t+"; not our item", 4 )
	return t
endfunction

float function ItemRemoved( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemRemoved()", 4 )
	float t = -1.0
	DebugLog( "--ItemRemoved(); t="+t, 4 )
	return t
endfunction

float function MenuOpened( int MenuID )
	DebugLog( "++MenuOpened()", 4 )
	float t = -1.0
	DebugLog( "--MenuOpened()=-1.0", 4 )
	return t
endfunction

float function MenuClosed( int MenuID )
	DebugLog( "++MenuClosed()", 4 )
	float t = -1.0
	DebugLog( "--MenuClosed()=-1.0", 4 )
	return t
endfunction

;;;TODO;;;
;;;TODO;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;TODO;;;; Functions
;;;TODO;;;
;;;TODO;;;event OnGameRelaod()
;;;TODO;;;	LTT = LTT_getBase() ; from LTT_Factory
;;;TODO;;;	LDH = LTT.getLDH()
;;;TODO;;;	modID = LDH.addMod( self, LTT_Name, LTT_ESP, 0xf )
;;;TODO;;;	if modID < 0 ; We couldn't be added to the Mod table.
;;;TODO;;;		return
;;;TODO;;;	endif
;;;TODO;;;	
;;;TODO;;;	; init Reading properties
;;;TODO;;;	prop_WhileReading = LDH.addBoolProp( "LTT_WhileReading", true, "$LTT_WhileReading", "$HLP_WhileReading", 0 )
;;;TODO;;;	prop_ReadInCombat = LDH.addBoolProp( "LTT_ReadInCombat", ReadInCombat, "$LTT_ReadInCombat", "$HLP_ReadInCombat", 2 )
;;;TODO;;;	prop_ReadTimeMult = LDH.addFloatProp( "LTT_ReadTimeMult", 1.0, "$LTT_ReadTimeMult", "$HLP_ReadTimeMult", 4, 0.0, 10.0 )
;;;TODO;;;	prop_ReadIncreasesSpeech = LDH.addBoolProp( "LTT_ReadIncreaseSpeech", false, "$LTT_ReadIncreaseSpeech", "$HLP_ReadIncreasesSpeech", 4 )
;;;TODO;;;	prop_SpeechIncreaseMult = LDH.addFloatProp( "LTT_SpeechIncreasMult", 1.0, "$LTT_SpeechIncreaseMult", "$HLP_SpeechIncreaseMult", 6, 0.0, 10.0 )
;;;TODO;;;	prop_SpellLearnHrs = LDH.addFloatProp( "LTT_SpellLearnHrs", 2.0, "$LTT_SpellLearnHrs", "$HLP_SpellLearnHrs", 8, 0.0, 24.0 )
;;;TODO;;;endevent
;;;TODO;;;
;;;TODO;;;;///////////////////////////////////////////////////////////////////////////////
;;;TODO;;;// called when an item is added to player's inventory - normally looted or
;;;TODO;;;// crafted. Returns... If this is not handled and should be passed on to the
;;;TODO;;;// next mod, return a negative value ; otherwise, return the number of hours
;;;TODO;;;// passed, even 0.0 if the task was free.
;;;TODO;;;/;
;;;TODO;;;float function ItemAdded( form Item, int Prefix, int Type, int Count, form Source )
;;;TODO;;;	; Ignore tiny objects. Like Fork of Damnation. *HUGE SIGH*
;;;TODO;;;	; ... Except ammo, which is weightless for most people without patches. :p
;;;TODO;;;	if Item.GetWeight() < 0.01 && Type != 42
;;;TODO;;;		DebugMode("--ItemAdded: Ignoring tiny objects")
;;;TODO;;;		return 0.0
;;;TODO;;;	EndIf
;;;TODO;;;
;;;TODO;;;	If looting
;;;TODO;;;		DebugMode("Player is looting, is it armor?")
;;;TODO;;;		Actor c = akSourceContainer as Actor
;;;TODO;;;		If c && c.IsDead() && ItemType==26
;;;TODO;;;			Armor a = akBaseItem as Armor
;;;TODO;;;			If !a
;;;TODO;;;				; should never get here since we check ItemType, but still safe
;;;TODO;;;			ElseIf a.IsLightArmor() && a.IsCuirass() && lightArmorTime > 0
;;;TODO;;;				t = ToMinutes(lightArmorTime)
;;;TODO;;;				DebugMode("--ItemAdded: Light Armor; Base time="+t)
;;;TODO;;;				return
;;;TODO;;;			ElseIf a.IsHeavyArmor() && a.IsCuirass() && heavyArmorTime > 0
;;;TODO;;;				t = ToMinutes(heavyArmorTime)
;;;TODO;;;				DebugMode("--ItemAdded: Heavy Armor; Base time="+t)
;;;TODO;;;				TimeCalc(t)
;;;TODO;;;				return
;;;TODO;;;			EndIf
;;;TODO;;;		EndIf
;;;TODO;;;		; instant loot
;;;TODO;;;		DebugMode("--ItemAdded: Not Armor")
;;;TODO;;;		Return
;;;TODO;;;	EndIf
;;;TODO;;;
;;;TODO;;;	if crafting_furniture == "smelt"
;;;TODO;;;		DebugMode("Smelting, using value from Crafting - Misc")
;;;TODO;;;		TimeCalc( miscCraftTime * ExpertiseMultiplier("Smithing") )
;;;TODO;;;
;;;TODO;;;	; Potions, poisons, food, drink [new system]
;;;TODO;;;	ElseIf type == 46
;;;TODO;;;		DebugMode("POTION crafted.")
;;;TODO;;;		PassedTime = potionCraftTime * ExpertiseMultiplier("Alchemy") ; Default
;;;TODO;;;		Potion p = akBaseItem as Potion
;;;TODO;;;		If p.IsFood()
;;;TODO;;;			MagicEffect FoodEffect = Check_RN_FoodEffect(p)
;;;TODO;;;			If RN_MgefDrinks.Find(FoodEffect) > -1
;;;TODO;;;				PassedTime = ToMinutes(rnBrewTime)
;;;TODO;;;			ElseIf FoodEffect == RN_MgefFood_Snack || FoodEffect == RN_MgefFood_Candy || FoodEffect == RN_MgefFood_Fruit
;;;TODO;;;				PassedTime = ToMinutes(rnCookSnackTime)
;;;TODO;;;			ElseIf FoodEffect == RN_MgefFood_Medium
;;;TODO;;;				PassedTime = ToMinutes(rnCookMediumTime)
;;;TODO;;;			ElseIf FoodEffect == RN_MgefFood_Filling
;;;TODO;;;				PassedTime = ToMinutes(rnCookFillingTime)
;;;TODO;;;			EndIf
;;;TODO;;;		EndIf
;;;TODO;;;		TimeCalc(PassedTime)
;;;TODO;;;
;;;TODO;;;	ElseIf type == 26
;;;TODO;;;		DebugMode("ARMOR crafted.")
;;;TODO;;;		Armor a = akBaseItem as Armor
;;;TODO;;;		if a.isHelmet() || a.isClothingHead()
;;;TODO;;;			TimeCalc(headCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif a.isCuirass() || a.isClothingBody()
;;;TODO;;;			TimeCalc(armorCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif a.isGauntlets() || a.isClothingHands()
;;;TODO;;;			TimeCalc(handsCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif a.isBoots() || a.isClothingFeet()
;;;TODO;;;			TimeCalc(feetCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif a.isShield()
;;;TODO;;;			TimeCalc(shieldCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif a.isJewelry() || a.isClothingRing()
;;;TODO;;;			TimeCalc(jewelryCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		else
;;;TODO;;;			;whatever is left
;;;TODO;;;			TimeCalc(armorCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		endif
;;;TODO;;;
;;;TODO;;;	elseif type == 41
;;;TODO;;;		DebugMode("WEAPON crafted.")
;;;TODO;;;		Weapon w = akBaseItem as Weapon
;;;TODO;;;		if w.isBattleAxe()
;;;TODO;;;			TimeCalc(battleAxeCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isBow()
;;;TODO;;;			TimeCalc(bowCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isDagger()
;;;TODO;;;			TimeCalc(daggerCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isGreatSword()
;;;TODO;;;			TimeCalc(greatswordCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isMace()
;;;TODO;;;			TimeCalc(maceCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isStaff()
;;;TODO;;;			TimeCalc(staffCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isSword()
;;;TODO;;;			TimeCalc(swordCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isWarhammer()
;;;TODO;;;			TimeCalc(warhammerCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		elseif w.isWarAxe()
;;;TODO;;;			TimeCalc(warAxeCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		else
;;;TODO;;;			;whatever is left
;;;TODO;;;			TimeCalc(weaponCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		endif
;;;TODO;;;
;;;TODO;;;	ElseIf type == 42
;;;TODO;;;		DebugMode("AMMO crafted.")
;;;TODO;;;		TimeCalc( weaponCraftTime * ExpertiseMultiplier("Smithing") )
;;;TODO;;;
;;;TODO;;;	elseif ( type == 32 || type == 52 ) ;misc and soul gems
;;;TODO;;;		;filter for added and removed workbenches
;;;TODO;;;		If HF_Exclusions.Find(akBaseItem) > -1
;;;TODO;;;			Return
;;;TODO;;;		EndIf
;;;TODO;;;		if akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryBuilding")
;;;TODO;;;			;Debug.Notification("building "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
;;;TODO;;;			Game.GetPlayer().AddItem(akBaseItem)
;;;TODO;;;		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryContainers")
;;;TODO;;;			;Debug.Notification("container "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
;;;TODO;;;		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryFurniture")
;;;TODO;;;			;Debug.Notification("furniture "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
;;;TODO;;;		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryWeaponRacks")
;;;TODO;;;			;Debug.Notification("weaponrack "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
;;;TODO;;;		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryShelf")
;;;TODO;;;			;Debug.Notification("shelf "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
;;;TODO;;;		elseif akBaseItem.HasKeywordString("BYOHHouseCraftingCategoryExterior")
;;;TODO;;;			;Debug.Notification("exterior "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
;;;TODO;;;		elseif miscCraftTime > 0
;;;TODO;;;			DebugMode("MISC item, using value from Crafting - Misc")
;;;TODO;;;			;Debug.Notification("misc "+akBaseItem.GetFormID()+" "+akBaseItem.getname())
;;;TODO;;;			TimeCalc(miscCraftTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;		endif
;;;TODO;;;
;;;TODO;;;	endif
;;;TODO;;;	
;;;TODO;;;	return -1.0
;;;TODO;;;endfunction
;;;TODO;;;
;;;TODO;;;;///////////////////////////////////////////////////////////////////////////////
;;;TODO;;;// called when an item is removed from player's inventory - normally eaten or drunk
;;;TODO;;;// Returns the same as ItemAdded
;;;TODO;;;/;
;;;TODO;;;float function ItemRemoved( form Item, int Prefix, int Type, int Count, form Destination )
;;;TODO;;;	; Ignore tiny objects. Like Fork of Damnation. *HUGE SIGH*
;;;TODO;;;	If akBaseItem.GetWeight() < 0.01
;;;TODO;;;		DebugMode(akBaseItem.GetName()+" weight: "+akBaseItem.GetWeight())
;;;TODO;;;		Return
;;;TODO;;;	EndIf
;;;TODO;;;
;;;TODO;;;	; Prevent re-entry. Not sure why this happens.
;;;TODO;;;	If _critSection
;;;TODO;;;		DebugMode("critsection: " + akBaseItem.GetName())
;;;TODO;;;		Return
;;;TODO;;;	Else
;;;TODO;;;		_critSection = True
;;;TODO;;;	EndIf
;;;TODO;;;
;;;TODO;;;	int type = akBaseItem.GetType()
;;;TODO;;;	int prefix = GetFormPrefix(akBaseItem)
;;;TODO;;;
;;;TODO;;;	;DebugMode("ItemRemoved. akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )
;;;TODO;;;	DebugMode("ItemRemoved. akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; akDestContainer = " + akDestContainer + \
;;;TODO;;;		"; type = " + type + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() + "; crafting_furniture = " + crafting_furniture)
;;;TODO;;;
;;;TODO;;;	; Catch this early because neither eating nor learning a spell qualifies if player is looting
;;;TODO;;;	; mlheur: actually, the above statement is false.  I exploited the free eating many times because of SkyUI's ability
;;;TODO;;;	; to directly 'use' an object from a different container...  need to think about this.
;;;TODO;;;	If looting == True
;;;TODO;;;		DebugMode("Ignored, player is looting.")
;;;TODO;;;
;;;TODO;;;	ElseIf (CF_Items_SmallTents_MoreBR.Find(akBaseItem) > -1 ) || (CF_Items_LargeTents_MoreBR.Find(akBaseItem) > -1 )
;;;TODO;;;		DebugMode( "Lost a multi-bed tent, must be downgrading, this act is free and so is the next tent" )
;;;TODO;;;		CF_Splitting_Bedroll = true
;;;TODO;;;
;;;TODO;;;	ElseIf akBaseItem.GetType() == 46
;;;TODO;;;		Potion p = akBaseItem as Potion
;;;TODO;;;		if !p || !p.isFood() || openEat == Game.QueryStat("Food Eaten")
;;;TODO;;;			_critSection = False
;;;TODO;;;			Return
;;;TODO;;;		ElseIf (_is_FF_Active && prefix == FF_Prefix)
;;;TODO;;;			_critSection = False
;;;TODO;;;			Return
;;;TODO;;;		EndIf
;;;TODO;;;		ElseIf (_is_CF_Active && prefix == CF_Prefix)
;;;TODO;;;			_critSection = False
;;;TODO;;;			Return
;;;TODO;;;		EndIf
;;;TODO;;;		openEat = Game.QueryStat("Food Eaten")
;;;TODO;;;		DebugMode("ItemRemoved - food, openEat = " + openEat + "; akBaseItem = " + akBaseItem + "; aiItemCount = " + aiItemCount + "; prefix = " + prefix + "; name = " + akBaseItem.GetName() )
;;;TODO;;;		Float PassedTime
;;;TODO;;;		MagicEffect FoodEffect = Check_RN_FoodEffect(p)
;;;TODO;;;		If RN_MgefDrinks.Find(FoodEffect) > -1
;;;TODO;;;			PassedTime = rnDrinkTime
;;;TODO;;;		ElseIf FoodEffect == RN_MgefFood_Snack || FoodEffect == RN_MgefFood_Candy || FoodEffect == RN_MgefFood_Fruit
;;;TODO;;;			PassedTime = rnEatSnackTime
;;;TODO;;;		ElseIf FoodEffect == RN_MgefFood_Medium
;;;TODO;;;			PassedTime = rnEatMediumTime
;;;TODO;;;		ElseIf FoodEffect == RN_MgefFood_Filling
;;;TODO;;;			PassedTime = rnEatFillingTime
;;;TODO;;;		ElseIf eatTime > 0
;;;TODO;;;			PassedTime =  eatTime
;;;TODO;;;		EndIf
;;;TODO;;;		If PassedTime > 0
;;;TODO;;;			PassedTime = aiItemCount * ToMinutes(PassedTime)
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		EndIf
;;;TODO;;;
;;;TODO;;;	ElseIf akBaseItem.GetType() == 27 && spellLearnTime > 0
;;;TODO;;;		Book b = akBaseItem as Book
;;;TODO;;;		if b && b.GetSpell() && openSpell < Game.QueryStat("Spells Learned")
;;;TODO;;;			openSpell = Game.QueryStat("Spells Learned")
;;;TODO;;;			DebugMode("Spell learned.")
;;;TODO;;;			TimeCalc(spellLearnTime*ExpertiseMultiplier("Speechcraft"))
;;;TODO;;;		endif
;;;TODO;;;
;;;TODO;;;	EndIf
;;;TODO;;;
;;;TODO;;;	_critSection = False
;;;TODO;;;	return -1.0
;;;TODO;;;endfunction
;;;TODO;;;
;;;TODO;;;;///////////////////////////////////////////////////////////////////////////////
;;;TODO;;;// called when any screen other than the 3D renedered world is displayed
;;;TODO;;;// Returns the same as ItemAdded
;;;TODO;;;/;
;;;TODO;;;float function MenuOpened( int Menu )
;;;TODO;;;	DebugMode("OnMenuOpen " + MenuName)
;;;TODO;;;	If MenuName == "Book Menu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantRead
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			if UI.IsMenuOpen("InventoryMenu") && isInventoryActive
;;;TODO;;;				StopReading = Utility.GetCurrentRealTime()
;;;TODO;;;				Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*inventoryMult
;;;TODO;;;				TimeCalc(PassedTime)
;;;TODO;;;			endif
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "ContainerMenu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantLoot
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			looting = True
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "Lockpicking Menu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantPick
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "Crafting Menu"
;;;TODO;;;		;RegisterForTrackedStatsEvent()
;;;TODO;;;		openArmorsImproved = Game.QueryStat("Armor Improved")
;;;TODO;;;		openWeaponsImproved = Game.QueryStat("Weapons Improved")
;;;TODO;;;		openEnchantings = Game.QueryStat("Magic Items Made")
;;;TODO;;;		openPotions = Game.QueryStat("Potions Mixed")
;;;TODO;;;		openPoisons = Game.QueryStat("Poisons Mixed")
;;;TODO;;;		crafting = True
;;;TODO;;;	ElseIf MenuName == "Training Menu"
;;;TODO;;;		StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;		openTraining = Game.QueryStat("Training Sessions")
;;;TODO;;;	ElseIf MenuName == "StatsMenu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantLevelUp
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			openLevel = Game.GetPlayer().getLevel()
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "InventoryMenu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantInventory
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			openEat = Game.QueryStat("Food Eaten")
;;;TODO;;;			openSpell = Game.QueryStat("Spells Learned")
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "MagicMenu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantMagic
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "Journal Menu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantJournal
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "MapMenu"
;;;TODO;;;		if Game.GetPlayer().IsInCombat() && cantMap
;;;TODO;;;			CloseInCombat()
;;;TODO;;;		else
;;;TODO;;;			StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;		endif
;;;TODO;;;	ElseIf MenuName == "BarterMenu"
;;;TODO;;;		StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;	ElseIf MenuName == "GiftMenu"
;;;TODO;;;		StartReading  = Utility.GetCurrentRealTime()
;;;TODO;;;	EndIf
;;;TODO;;;	return -1.0
;;;TODO;;;endfunction
;;;TODO;;;
;;;TODO;;;;///////////////////////////////////////////////////////////////////////////////
;;;TODO;;;// called when any screen other than the 3D renedered world is closed
;;;TODO;;;// Returns the same as ItemAdded
;;;TODO;;;/;
;;;TODO;;;float function MenuClosed( int Menu )
;;;TODO;;;	DebugMode("OnMenuClose " + MenuName)
;;;TODO;;;	If !CloseBook
;;;TODO;;;		If MenuName == "Book Menu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*readMult
;;;TODO;;;			TimeCalc(PassedTime*ExpertiseMultiplier("Speechcraft"))
;;;TODO;;;			if (readingIncreasesSpeech)
;;;TODO;;;				SkillIncrease("Speechcraft", (StopReading-StartReading)*readingIncreaseMult)
;;;TODO;;;			endif
;;;TODO;;;			if UI.IsMenuOpen("InventoryMenu") && isInventoryActive
;;;TODO;;;				StartReading = Utility.GetCurrentRealTime()
;;;TODO;;;			endif
;;;TODO;;;		ElseIf MenuName == "ContainerMenu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*lootMult
;;;TODO;;;			if isPlayerPickpocketing()
;;;TODO;;;				PassedTime = (((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*pickpocketMult)*ExpertiseMultiplier("Pickpocket")
;;;TODO;;;			endif
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;			looting = False
;;;TODO;;;		ElseIf MenuName == "Lockpicking Menu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*pickMult
;;;TODO;;;			TimeCalc(PassedTime*ExpertiseMultiplier("Lockpicking"))
;;;TODO;;;		ElseIf MenuName == "Crafting Menu"
;;;TODO;;;			;UnregisterForTrackedStatsEvent()
;;;TODO;;;			closeArmorsImproved = Game.QueryStat("Armor Improved")
;;;TODO;;;			if (closeArmorsImproved - openArmorsImproved) > 0
;;;TODO;;;				DebugMode("Armor Improved. Before: " + openArmorsImproved + ". After: " + closeArmorsImproved)
;;;TODO;;;				TimeCalc(armorImproveTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;			endif
;;;TODO;;;			closeWeaponsImproved = Game.QueryStat("Weapons Improved")
;;;TODO;;;			if (closeWeaponsImproved - openWeaponsImproved) > 0
;;;TODO;;;				DebugMode("Weapons Improved. Before: " + openWeaponsImproved + ". After: " + closeWeaponsImproved)
;;;TODO;;;				TimeCalc(weaponImproveTime*ExpertiseMultiplier("Smithing"))
;;;TODO;;;			endif
;;;TODO;;;			closeEnchantings = Game.QueryStat("Magic Items Made")
;;;TODO;;;			if (closeEnchantings - openEnchantings) > 0
;;;TODO;;;				DebugMode("Magic Items Made. Before: " + openEnchantings + ". After: " + closeEnchantings)
;;;TODO;;;				TimeCalc(enchantingTime*ExpertiseMultiplier("Enchanting"))
;;;TODO;;;			endif
;;;TODO;;;;			closePotions = Game.QueryStat("Potions Mixed")
;;;TODO;;;;			if (closePotions - openPotions) > 0
;;;TODO;;;;				DebugMode("Potions Mixed. Before: " + openPotions + ". After: " + closePotions)
;;;TODO;;;;				TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))
;;;TODO;;;;			endif
;;;TODO;;;;			closePoisons = Game.QueryStat("Poisons Mixed")
;;;TODO;;;;			if (closePoisons - openPoisons) > 0
;;;TODO;;;;				DebugMode("Poisons Mixed. Before: " + openPoisons + ". After: " + closePoisons)
;;;TODO;;;;				TimeCalc(potionCraftTime*ExpertiseMultiplier("Alchemy"))
;;;TODO;;;;			endif
;;;TODO;;;			crafting = False
;;;TODO;;;		ElseIf MenuName == "Training Menu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*trainingMult
;;;TODO;;;			closeTraining = Game.QueryStat("Training Sessions")
;;;TODO;;;			PassedTime = PassedTime + ((closeTraining - openTraining )*trainingTime)
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		ElseIf MenuName == "StatsMenu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*levelUpMult
;;;TODO;;;			closeLevel = Game.GetPlayer().getLevel()
;;;TODO;;;			PassedTime = PassedTime + ((closeLevel - openLevel)*levelUpTime)
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		ElseIf MenuName == "InventoryMenu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*inventoryMult
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		ElseIf MenuName == "MagicMenu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*magicMult
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		ElseIf MenuName == "Journal Menu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*journalMult
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		ElseIf MenuName == "MapMenu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*mapMult
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		ElseIf MenuName == "BarterMenu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*barterMult
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		ElseIf MenuName == "GiftMenu"
;;;TODO;;;			StopReading  = Utility.GetCurrentRealTime()
;;;TODO;;;			Float PassedTime = ((StopReading-StartReading)*TimeScale.GetValue()/60/100/3*5)*giftMult
;;;TODO;;;			TimeCalc(PassedTime)
;;;TODO;;;		EndIf
;;;TODO;;;	Else
;;;TODO;;;		CloseBook = False
;;;TODO;;;	EndIf
;;;TODO;;;	return -1.0
;;;TODO;;;endfunction
;;;TODO;;;
;;;TODO;;;