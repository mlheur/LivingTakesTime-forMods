scriptname LTT_Menu extends SKI_ConfigBase
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	LTT For Mods provides a sort of transparent interface to MCM.  With all
//	the variables a properties stored in LTT_DataHandler tables, it makes
//	more sense to implement MCM within LTT_Base.  This file provides a
//	sort of wrapper/interface that calls the LTT_Base version of MCM events.
///////////////////////////////////////////////////////////////////////////////;

import LTT_Factory
LTT_Base Property LTT Auto
bool _InitComplete = false

int function GetVersion()
	LTT.DebugLog( "++Menu::GetVersion()" )
	return LTT.getVersion()
	LTT.DebugLog( "--Menu::GetVersion()" )
endfunction

event OnGameReload() ; this is called before OnConfigInit() - why???
	LTT.DebugLog( "++Menu::OnGameReload()" )
	if ! _InitComplete
		OnConfigInit()
	endif
	LTT.mcmOnGameReload()
	parent.OnGameReload()
	LTT.DebugLog( "--Menu::OnGameReload()" )
endEvent

event OnConfigInit()
	LTT.DebugLog( "++Menu::OnConfigInit()" )
	if ! _InitComplete
		LTT = LTT_getBase()
		Pages = LTT.mcmOnConfigInit()
		_InitComplete = true
	endif
	LTT.DebugLog( "--Menu::OnConfigInit()" )
endEvent

event OnVersionUpdate( int Version )
	LTT.DebugLog( "++Menu::OnVersionUpdate()" )
	Pages = LTT.mcmOnVersionUpdate( Version )
	LTT.DebugLog( "--Menu::OnVersionUpdate()" )
endevent

event OnPageReset(string page)
	LTT.DebugLog( "++Menu::OnPageReset()" )
	LTT.mcmOnPageReset( self, Page )
	LTT.DebugLog( "--Menu::OnPageReset()" )
endEvent

event OnOptionSelect( int option )
	LTT.DebugLog( "++Menu::OnOptionSelect()" )
	LTT.DebugLog( "--Menu::OnOptionSelect()" )
endevent

event OnOptionSliderOpen( int option )
	LTT.DebugLog( "++Menu::OnOptionSliderOpen()" )
	LTT.DebugLog( "--Menu::OnOptionSliderOpen()" )
endevent

event OnOptionSliderAccept( int option, float value)
	LTT.DebugLog( "++Menu::OnOptionSliderAccept()" )
	LTT.DebugLog( "--Menu::OnOptionSliderAccept()" )
endevent

event OnOptionDefault( int option )
	LTT.DebugLog( "++Menu::OnOptionDefault()" )
	LTT.DebugLog( "--Menu::OnOptionDefault()" )
endevent

event OnOptionKeyMapChange( int a_option, int a_keyCode, string a_conflictControl, string a_conflictName )
	LTT.DebugLog( "++Menu::OnOptionKeyMapChange()" )
	LTT.DebugLog( "--Menu::OnOptionKeyMapChange()" )
endevent

event OnOptionHighlight( int option )
	LTT.DebugLog( "++Menu::OnOptionHighlight()" )
	LTT.DebugLog( "--Menu::OnOptionHighlight()" )
endevent

event OnKeyUp( int option, float holdTime )
	LTT.DebugLog( "++Menu::OnKeyUp()" )
	LTT.DebugLog( "--Menu::OnKeyUp()" )
endevent

;;;; DISABLE ;;;;event OnOptionSelect(int option)
;;;; DISABLE ;;;;	if (option == saveID)
;;;; DISABLE ;;;;		Bool Choice = ShowMessage("$Save Settings?", True, "$Save", "$Cancel")
;;;; DISABLE ;;;;		if (Choice)
;;;; DISABLE ;;;;			SaveSettings()
;;;; DISABLE ;;;;			ForcePageReset()
;;;; DISABLE ;;;;		endif
;;;; DISABLE ;;;;	endif
;;;; DISABLE ;;;;	if (option == loadID)
;;;; DISABLE ;;;;		Bool Choice = ShowMessage("$Load Settings?", True, "$Load", "$Cancel")
;;;; DISABLE ;;;;		if (Choice)
;;;; DISABLE ;;;;			LoadSettings()
;;;; DISABLE ;;;;			ForcePageReset()
;;;; DISABLE ;;;;		endif
;;;; DISABLE ;;;;	endif
;;;; DISABLE ;;;;	if ( option == isModActiveID )
;;;; DISABLE ;;;;		isModActive= !isModActive
;;;; DISABLE ;;;;		SetToggleOptionValue(isModActiveID , isModActive)
;;;; DISABLE ;;;;		InitMod()
;;;; DISABLE ;;;;	elseif ( option == isReadingActiveID )
;;;; DISABLE ;;;;		isReadingActive = !isReadingActive
;;;; DISABLE ;;;;		SetToggleOptionValue(isReadingActiveID, isReadingActive)
;;;; DISABLE ;;;;		if ( isReadingActive )
;;;; DISABLE ;;;;			RegisterForMenu("Book Menu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("Book Menu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isCraftingActiveID )
;;;; DISABLE ;;;;		isCraftingActive = !isCraftingActive 
;;;; DISABLE ;;;;		SetToggleOptionValue(isCraftingActiveID, isCraftingActive )
;;;; DISABLE ;;;;		if ( isCraftingActive )
;;;; DISABLE ;;;;			RegisterForMenu("Crafting Menu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("Crafting Menu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isContainerActiveID )
;;;; DISABLE ;;;;		isContainerActive = !isContainerActive 
;;;; DISABLE ;;;;		SetToggleOptionValue(isContainerActiveID, isContainerActive )
;;;; DISABLE ;;;;		if ( isContainerActive )
;;;; DISABLE ;;;;			RegisterForMenu("ContainerMenu")
;;;; DISABLE ;;;;			;RegisterForCrosshairRef()
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("ContainerMenu")
;;;; DISABLE ;;;;			;UnregisterForCrosshairRef()
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isLockpickActiveID )
;;;; DISABLE ;;;;		isLockpickActive = !isLockpickActive 
;;;; DISABLE ;;;;		SetToggleOptionValue(isLockpickActiveID, isLockpickActive )
;;;; DISABLE ;;;;		if ( isLockpickActive )
;;;; DISABLE ;;;;			RegisterForMenu("Lockpicking Menu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("Lockpicking Menu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isTrainingActiveID )
;;;; DISABLE ;;;;		isTrainingActive = !isTrainingActive
;;;; DISABLE ;;;;		SetToggleOptionValue(isTrainingActiveID, isTrainingActive )
;;;; DISABLE ;;;;		if ( isTrainingActive)
;;;; DISABLE ;;;;			RegisterForMenu("Training Menu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("Training Menu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isLevelUpActiveID )
;;;; DISABLE ;;;;		isLevelUpActive = !isLevelUpActive
;;;; DISABLE ;;;;		SetToggleOptionValue(isLevelUpActiveID, isLevelUpActive )
;;;; DISABLE ;;;;		if ( isLevelUpActive )
;;;; DISABLE ;;;;			RegisterForMenu("StatsMenu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("StatsMenu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isInventoryActiveID)
;;;; DISABLE ;;;;		isInventoryActive = !isInventoryActive 
;;;; DISABLE ;;;;		ReadingTakesTime.isInventoryActive = isInventoryActive 
;;;; DISABLE ;;;;		SetToggleOptionValue(isInventoryActiveID, isInventoryActive )
;;;; DISABLE ;;;;		if ( isInventoryActive )
;;;; DISABLE ;;;;			RegisterForMenu("InventoryMenu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("InventoryMenu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isMagicActiveID)
;;;; DISABLE ;;;;		isMagicActive = !isMagicActive 
;;;; DISABLE ;;;;		SetToggleOptionValue(isMagicActiveID, isMagicActive )
;;;; DISABLE ;;;;		if ( isMagicActive )
;;;; DISABLE ;;;;			RegisterForMenu("MagicMenu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("MagicMenu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isJournalActiveID)
;;;; DISABLE ;;;;		isJournalActive = !isJournalActive
;;;; DISABLE ;;;;		SetToggleOptionValue(isJournalActiveID, isJournalActive )
;;;; DISABLE ;;;;		if ( isJournalActive )
;;;; DISABLE ;;;;			RegisterForMenu("Journal Menu")
;;;; DISABLE ;;;;			ReadingTakesTime.StartReading = Utility.GetCurrentRealTime()
;;;; DISABLE ;;;;			ReadingTakesTime.StopReading = Utility.GetCurrentRealTime()
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("Journal Menu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isMapActiveID )
;;;; DISABLE ;;;;		isMapActive = !isMapActive
;;;; DISABLE ;;;;		SetToggleOptionValue(isMapActiveID, isMapActive )
;;;; DISABLE ;;;;		if ( isMapActive )
;;;; DISABLE ;;;;			RegisterForMenu("MapMenu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("MapMenu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isBarterActiveID )
;;;; DISABLE ;;;;		isBarterActive = !isBarterActive 
;;;; DISABLE ;;;;		SetToggleOptionValue(isBarterActiveID, isBarterActive )
;;;; DISABLE ;;;;		if ( isBarterActive )
;;;; DISABLE ;;;;			RegisterForMenu("BarterMenu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("BarterMenu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == isGiftActiveID )
;;;; DISABLE ;;;;		isGiftActive = !isGiftActive 
;;;; DISABLE ;;;;		SetToggleOptionValue(isGiftActiveID, isGiftActive )
;;;; DISABLE ;;;;		if ( isGiftActive )
;;;; DISABLE ;;;;			RegisterForMenu("GiftMenu")
;;;; DISABLE ;;;;		else
;;;; DISABLE ;;;;			UnregisterForMenu("GiftMenu")
;;;; DISABLE ;;;;		endIf
;;;; DISABLE ;;;;	elseif ( option == cantLootID )
;;;; DISABLE ;;;;		ReadingTakesTime.cantLoot = !ReadingTakesTime.cantLoot
;;;; DISABLE ;;;;		SetToggleOptionValue(cantLootID, ReadingTakesTime.cantLoot)
;;;; DISABLE ;;;;	elseif ( option == cantPickID )
;;;; DISABLE ;;;;		ReadingTakesTime.cantPick = !ReadingTakesTime.cantPick
;;;; DISABLE ;;;;		SetToggleOptionValue(cantPickID, ReadingTakesTime.cantPick)
;;;; DISABLE ;;;;	elseif ( option == showMessageID )
;;;; DISABLE ;;;;		ReadingTakesTime.showMessage = !ReadingTakesTime.showMessage
;;;; DISABLE ;;;;		SetToggleOptionValue(showMessageID , ReadingTakesTime.showMessage)
;;;; DISABLE ;;;;	elseif ( option == dontShowMessageID )
;;;; DISABLE ;;;;		ReadingTakesTime.dontShowMessage = !ReadingTakesTime.dontShowMessage 
;;;; DISABLE ;;;;		SetToggleOptionValue(dontShowMessageID, ReadingTakesTime.dontShowMessage )
;;;; DISABLE ;;;;	elseif ( option == expertiseReducesTimeID )
;;;; DISABLE ;;;;		ReadingTakesTime.expertiseReducesTime = !ReadingTakesTime.expertiseReducesTime 
;;;; DISABLE ;;;;		SetToggleOptionValue(expertiseReducesTimeID, ReadingTakesTime.expertiseReducesTime )
;;;; DISABLE ;;;;	elseif ( option == cantReadID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantRead = !ReadingTakesTime.cantRead
;;;; DISABLE ;;;;		SetToggleOptionValue(cantReadID, ReadingTakesTime.cantRead)
;;;; DISABLE ;;;;	elseif ( option == readingIncreasesSpeechID)
;;;; DISABLE ;;;;		ReadingTakesTime.readingIncreasesSpeech = !ReadingTakesTime.readingIncreasesSpeech
;;;; DISABLE ;;;;		SetToggleOptionValue(readingIncreasesSpeechID, ReadingTakesTime.readingIncreasesSpeech)
;;;; DISABLE ;;;;	elseif ( option == cantLevelUpID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantLevelUp = !ReadingTakesTime.cantLevelUp
;;;; DISABLE ;;;;		SetToggleOptionValue(cantLevelUpID, ReadingTakesTime.cantLevelUp)
;;;; DISABLE ;;;;	elseif ( option == cantInventoryID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantInventory = !ReadingTakesTime.cantInventory
;;;; DISABLE ;;;;		SetToggleOptionValue(cantInventoryID, ReadingTakesTime.cantInventory)
;;;; DISABLE ;;;;	elseif ( option == cantMagicID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantMagic = !ReadingTakesTime.cantMagic
;;;; DISABLE ;;;;		SetToggleOptionValue(cantMagicID, ReadingTakesTime.cantMagic)
;;;; DISABLE ;;;;	elseif ( option == cantJournalID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantJournal = !ReadingTakesTime.cantJournal
;;;; DISABLE ;;;;		SetToggleOptionValue(cantJournalID, ReadingTakesTime.cantJournal)
;;;; DISABLE ;;;;	elseif ( option == cantMapID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantMap = !ReadingTakesTime.cantMap
;;;; DISABLE ;;;;		SetToggleOptionValue(cantMapID, ReadingTakesTime.cantMap)
;;;; DISABLE ;;;;	elseif ( option == CFFirecraftImprovesID )
;;;; DISABLE ;;;;		ReadingTakesTime.cfFirecraftImproves = !ReadingTakesTime.cfFirecraftImproves
;;;; DISABLE ;;;;		SetToggleOptionValue(CFFirecraftImprovesID, ReadingTakesTime.cfFirecraftImproves)
;;;; DISABLE ;;;;	endIf
;;;; DISABLE ;;;;endEvent
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;event OnOptionSliderOpen(int option)
;;;; DISABLE ;;;;	if (option == readMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.readMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseif (option == showMessageThresholdID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.showMessageThreshold)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(1.0, 59.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1.0)
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	elseif (option == readingIncreaseMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.readingIncreaseMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 10.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	elseif (option == spellLearnTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.spellLearnTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseif (option == headCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.headCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(3.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseif (option == armorCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.armorCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(6.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseif (option == handsCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.handsCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(3.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseif (option == feetCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.feetCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(3.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseif (option == shieldCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.shieldCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseif (option == jewelryCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.jewelryCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == battleAxeCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.battleAxeCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == bowCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.bowCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == daggerCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.daggerCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(3.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == greatswordCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.greatswordCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == maceCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.maceCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == staffCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.staffCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == swordCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.swordCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == warhammerCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.warhammerCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == warAxeCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.warAxeCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == weaponCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.weaponCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == miscCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.miscCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == armorImproveTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.armorImproveTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == weaponImproveTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.weaponImproveTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == enchantingTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.enchantingTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == potionCraftTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.potionCraftTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == lootMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.lootMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == pickMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.pickMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	elseIf (option == pickpocketMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.pickpocketMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	ElseIf option == LightAmorID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.lightArmorTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(15)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ElseIf option == HeavyArmorID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.heavyArmorTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(45)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == trainingMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.trainingMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == trainingTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.trainingTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == levelUpMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.levelUpMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == levelUpTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.levelUpTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == inventoryMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.inventoryMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == eatTimeID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.eatTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(5)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == magicMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.magicMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == journalMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.journalMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == mapMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.mapMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == barterMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.barterMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	elseIf (option == giftMultID )
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.giftMult)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.00)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.00, 4.00)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.05)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	; Campfire Camping Items
;;;; DISABLE ;;;;	ElseIf option == CFCloakID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfCloakTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfCloakTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFStickID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfStickTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfStickTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFTorchID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfTorchTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfTorchTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFCookpotID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfCookpotTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfCookpotTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFBackpackID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfBackpackTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfBackpackTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFBeddingID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfBeddingTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfBeddingTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFSmallTentID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfSmallTentTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfSmallTentTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFLargeTentID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfLargeTentTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfLargeTentTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFHatchetID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfHatchetTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfHatchetTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFArrowsID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfArrowsTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfArrowsTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	; Campfire Materials
;;;; DISABLE ;;;;	ElseIf option == CFLinenID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfLinenTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfLinenTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFFurID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfFurTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfFurTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFLaceID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfLaceTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfLaceTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFTanRackID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfTanRackTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfTanRackTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFMortarID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfMortarTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfMortarTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == CFEnchID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfEnchTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfEnchTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	; Campfire Firecraft
;;;; DISABLE ;;;;	ElseIf option == CFMakeTinderID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfMakeTinderTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfMakeTinderTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFMakeKindlingID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfMakeKindlingTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfMakeKindlingTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFAddTinderID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfAddTinderTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfAddTinderTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFAddKindlingID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfAddKindlingTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfAddKindlingTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFLightFireID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfLightFireTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfLightFireTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == CFAddFuelID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.cfAddFuelTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_cfAddFuelTime)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ElseIf option == FFSnowberryID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.ffSnowberryTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(DEF_Extract)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ElseIf option == RNWaterskinID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnWaterskinTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == RNCookpotID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnCookpotTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == RNTinderboxID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnTinderboxTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == RNBedrollID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnBedrollTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(3.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == RNTentID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnTentTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(4.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == RNMilkBucketID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnMilkBucketTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(5)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNFoodSnackID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnEatSnackTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNFoodMediumID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnEatMediumTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(10)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNFoodFillingID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnEatFillingTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(30)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNWaterDrinkID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnDrinkTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNCookSnackID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnCookSnackTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(10)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNCookMediumID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnCookMediumTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(20)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNCookFillingID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnCookFillingTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(45)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNBrewDrinkID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnBrewTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(15)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNWaterPrepID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnWaterPrepTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(5)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == RNSaltID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.rnSaltTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == HBScrimBitsID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbScrimBitsTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(5)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == HBScrimIdolID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbScrimIdolTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == HBScrimToolID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbScrimToolTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == HBLeatherID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbLeatherTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == HBStripID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbStripTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(30)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == HBBedrollID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbBedrollTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(3.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == HBIngrID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbIngrTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(30)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == HBBrewID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbBrewTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(30)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == HBTallowID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbTallowTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(10)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == HBArrowsID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.hbArrowsTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(1.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	ElseIf option == WLLanternID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.wlWearableTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(30)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == WLChassisID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.wlChassisTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(2.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == WLOilID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.wlOilTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(30)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	ElseIf option == LCBasicID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.lcBasicTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(10)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	ElseIf option == LCForgeID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.lcForgeTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(3.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == LCArcaneID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.lcArcaneTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(6.0)
;;;; DISABLE ;;;;		SetSliderDialogRange(0.0, 24.0)
;;;; DISABLE ;;;;		SetSliderDialogInterval(0.1)
;;;; DISABLE ;;;;	ElseIf option == LCBrewID
;;;; DISABLE ;;;;		SetSliderDialogStartValue(ReadingTakesTime.lcBrewTime)
;;;; DISABLE ;;;;		SetSliderDialogDefaultValue(15)
;;;; DISABLE ;;;;		SetSliderDialogRange(0, 60)
;;;; DISABLE ;;;;		SetSliderDialogInterval(1)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	endIf
;;;; DISABLE ;;;;endEvent
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;event OnOptionSliderAccept(int option, float value)
;;;; DISABLE ;;;;    if (option == readMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.readMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(readMultID, ReadingTakesTime.readMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == showMessageThresholdID )
;;;; DISABLE ;;;;        ReadingTakesTime.showMessageThreshold = value as Int
;;;; DISABLE ;;;;        SetSliderOptionValue(showMessageThresholdID , ReadingTakesTime.showMessageThreshold)
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == readingIncreaseMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.readingIncreaseMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(readingIncreaseMultID , ReadingTakesTime.readingIncreaseMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == spellLearnTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.spellLearnTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(spellLearnTimeID , ReadingTakesTime.spellLearnTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == headCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.headCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(headCraftTimeID , ReadingTakesTime.headCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == armorCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.armorCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(armorCraftTimeID , ReadingTakesTime.armorCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == handsCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.handsCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(handsCraftTimeID , ReadingTakesTime.handsCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == feetCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.feetCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(feetCraftTimeID , ReadingTakesTime.feetCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == shieldCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.shieldCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(shieldCraftTimeID , ReadingTakesTime.shieldCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == jewelryCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.jewelryCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(jewelryCraftTimeID , ReadingTakesTime.jewelryCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == battleAxeCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.battleAxeCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(battleAxeCraftTimeID, ReadingTakesTime.battleAxeCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == bowCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.bowCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(bowCraftTimeID, ReadingTakesTime.bowCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == daggerCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.daggerCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(daggerCraftTimeID, ReadingTakesTime.daggerCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == greatswordCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.greatswordCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(greatswordCraftTimeID, ReadingTakesTime.greatswordCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == maceCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.maceCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(maceCraftTimeID, ReadingTakesTime.maceCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == staffCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.staffCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(staffCraftTimeID, ReadingTakesTime.staffCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == swordCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.swordCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(swordCraftTimeID, ReadingTakesTime.swordCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == warhammerCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.warhammerCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(warhammerCraftTimeID, ReadingTakesTime.warhammerCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == warAxeCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.warAxeCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(warAxeCraftTimeID, ReadingTakesTime.warAxeCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == weaponCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.weaponCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(weaponCraftTimeID, ReadingTakesTime.weaponCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == miscCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.miscCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(miscCraftTimeID, ReadingTakesTime.miscCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == armorImproveTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.armorImproveTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(armorImproveTimeID , ReadingTakesTime.armorImproveTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == weaponImproveTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.weaponImproveTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(weaponImproveTimeID , ReadingTakesTime.weaponImproveTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == enchantingTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.enchantingTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(enchantingTimeID, ReadingTakesTime.enchantingTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == potionCraftTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.potionCraftTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(potionCraftTimeID, ReadingTakesTime.potionCraftTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == lootMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.lootMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(lootMultID, ReadingTakesTime.lootMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == pickMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.pickMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(pickMultID, ReadingTakesTime.pickMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == pickpocketMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.pickpocketMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(pickpocketMultID, ReadingTakesTime.pickpocketMult, "$x{2}")
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	ElseIf option == LightAmorID
;;;; DISABLE ;;;;        ReadingTakesTime.lightArmorTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(LightAmorID, ReadingTakesTime.lightArmorTime, "${0} Minute(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == HeavyArmorID
;;;; DISABLE ;;;;        ReadingTakesTime.heavyArmorTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HeavyArmorID, ReadingTakesTime.heavyArmorTime, "${0} Minute(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == trainingMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.trainingMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(trainingMultID, ReadingTakesTime.trainingMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == trainingTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.trainingTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(trainingTimeID, ReadingTakesTime.trainingTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == levelUpMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.levelUpMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(levelUpMultID, ReadingTakesTime.levelUpMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == levelUpTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.levelUpTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(levelUpTimeID, ReadingTakesTime.levelUpTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == inventoryMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.inventoryMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(inventoryMultID, ReadingTakesTime.inventoryMult , "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == eatTimeID )
;;;; DISABLE ;;;;        ReadingTakesTime.eatTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(eatTimeID, ReadingTakesTime.eatTime, "${0} Minute(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == magicMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.magicMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(magicMultID, ReadingTakesTime.magicMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == journalMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.journalMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(journalMultID, ReadingTakesTime.journalMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == mapMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.mapMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(mapMultID, ReadingTakesTime.mapMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == barterMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.barterMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(barterMultID, ReadingTakesTime.barterMult, "$x{2}")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    elseIf (option == giftMultID )
;;;; DISABLE ;;;;        ReadingTakesTime.giftMult = value
;;;; DISABLE ;;;;        SetSliderOptionValue(giftMultID, ReadingTakesTime.giftMult, "$x{2}")
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	; Campfire Camping Items
;;;; DISABLE ;;;;	ElseIf option == CFCloakID
;;;; DISABLE ;;;;		ReadingTakesTime.cfCloakTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFCloakID, ReadingTakesTime.cfCloakTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFStickID
;;;; DISABLE ;;;;		ReadingTakesTime.cfStickTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFStickID, ReadingTakesTime.cfStickTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFTorchID
;;;; DISABLE ;;;;		ReadingTakesTime.cfTorchTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFTorchID, ReadingTakesTime.cfTorchTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFCookpotID
;;;; DISABLE ;;;;		ReadingTakesTime.cfCookpotTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFCookpotID, ReadingTakesTime.cfCookpotTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFBackpackID
;;;; DISABLE ;;;;		ReadingTakesTime.cfBackpackTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFBackpackID, ReadingTakesTime.cfBackpackTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFBeddingID
;;;; DISABLE ;;;;		ReadingTakesTime.cfBeddingTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFBeddingID, ReadingTakesTime.cfBeddingTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFSmallTentID
;;;; DISABLE ;;;;		ReadingTakesTime.cfSmallTentTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFSmallTentID, ReadingTakesTime.cfSmallTentTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFLargeTentID
;;;; DISABLE ;;;;		ReadingTakesTime.cfLargeTentTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFLargeTentID, ReadingTakesTime.cfLargeTentTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFHatchetID
;;;; DISABLE ;;;;		ReadingTakesTime.cfHatchetTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFHatchetID, ReadingTakesTime.cfHatchetTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFArrowsID
;;;; DISABLE ;;;;		ReadingTakesTime.cfArrowsTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFArrowsID, ReadingTakesTime.cfArrowsTime, "${1} hour(s)")
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	; Campfire Materials
;;;; DISABLE ;;;;	ElseIf option == CFLinenID
;;;; DISABLE ;;;;		ReadingTakesTime.cfLinenTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFLinenID, ReadingTakesTime.cfLinenTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFFurID
;;;; DISABLE ;;;;		ReadingTakesTime.cfFurTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFFurID, ReadingTakesTime.cfFurTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFLaceID
;;;; DISABLE ;;;;		ReadingTakesTime.cfLaceTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFLaceID, ReadingTakesTime.cfLaceTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFTanRackID
;;;; DISABLE ;;;;		ReadingTakesTime.cfTanRackTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFTanRackID, ReadingTakesTime.cfTanRackTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFMortarID
;;;; DISABLE ;;;;		ReadingTakesTime.cfMortarTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFMortarID, ReadingTakesTime.cfMortarTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == CFEnchID
;;;; DISABLE ;;;;		ReadingTakesTime.cfEnchTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFEnchID, ReadingTakesTime.cfEnchTime, "${1} hour(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	; Campfire Firecraft
;;;; DISABLE ;;;;	ElseIf option == CFMakeTinderID
;;;; DISABLE ;;;;		ReadingTakesTime.cfMakeTinderTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFMakeTinderID, ReadingTakesTime.cfMakeTinderTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFMakeKindlingID
;;;; DISABLE ;;;;		ReadingTakesTime.cfMakeKindlingTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFMakeKindlingID, ReadingTakesTime.cfMakeKindlingTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFAddTinderID
;;;; DISABLE ;;;;		ReadingTakesTime.cfAddTinderTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFAddTinderID, ReadingTakesTime.cfAddTinderTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFAddKindlingID
;;;; DISABLE ;;;;		ReadingTakesTime.cfAddKindlingTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFAddKindlingID, ReadingTakesTime.cfAddKindlingTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFLightFireID
;;;; DISABLE ;;;;		ReadingTakesTime.cfLightFireTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFLightFireID, ReadingTakesTime.cfLightFireTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == CFAddFuelID
;;;; DISABLE ;;;;		ReadingTakesTime.cfAddFuelTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(CFAddFuelID, ReadingTakesTime.cfAddFuelTime, "${0} Minute(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == FFSnowberryID
;;;; DISABLE ;;;;		ReadingTakesTime.ffSnowberryTime = value
;;;; DISABLE ;;;;		SetSliderOptionValue(FFSnowBerryID, ReadingTakesTime.ffSnowberryTime, "${0} Minute(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == RNWaterskinID
;;;; DISABLE ;;;;		ReadingTakesTime.rnWaterskinTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNWaterskinID, ReadingTakesTime.rnWaterskinTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == RNCookpotID
;;;; DISABLE ;;;;		ReadingTakesTime.rnCookpotTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNCookpotID, ReadingTakesTime.rnCookpotTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == RNTinderboxID
;;;; DISABLE ;;;;		ReadingTakesTime.rnTinderboxTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNTinderboxID, ReadingTakesTime.rnTinderboxTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == RNBedrollID
;;;; DISABLE ;;;;		ReadingTakesTime.rnBedrollTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNBedrollID, ReadingTakesTime.rnBedrollTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == RNTentID
;;;; DISABLE ;;;;		ReadingTakesTime.rnTentTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNTentID, ReadingTakesTime.rnTentTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == RNMilkBucketID
;;;; DISABLE ;;;;		ReadingTakesTime.rnMilkBucketTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNMilkBucketID, ReadingTakesTime.rnMilkBucketTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNFoodSnackID
;;;; DISABLE ;;;;		ReadingTakesTime.rnEatSnackTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNFoodSnackID, ReadingTakesTime.rnEatSnackTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNFoodMediumID
;;;; DISABLE ;;;;		ReadingTakesTime.rnEatMediumTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNFoodMediumID, ReadingTakesTime.rnEatMediumTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNFoodFillingID
;;;; DISABLE ;;;;		ReadingTakesTime.rnEatFillingTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNFoodFillingID, ReadingTakesTime.rnEatFillingTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNWaterDrinkID
;;;; DISABLE ;;;;		ReadingTakesTime.rnDrinkTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNWaterDrinkID, ReadingTakesTime.rnDrinkTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNCookSnackID
;;;; DISABLE ;;;;		ReadingTakesTime.rnCookSnackTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNCookSnackID, ReadingTakesTime.rnCookSnackTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNCookMediumID
;;;; DISABLE ;;;;		ReadingTakesTime.rnCookMediumTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNCookMediumID, ReadingTakesTime.rnCookMediumTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNCookFillingID
;;;; DISABLE ;;;;		ReadingTakesTime.rnCookFillingTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNCookFillingID, ReadingTakesTime.rnCookFillingTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNBrewDrinkID
;;;; DISABLE ;;;;		ReadingTakesTime.rnBrewTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNBrewDrinkID, ReadingTakesTime.rnBrewTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNWaterPrepID
;;;; DISABLE ;;;;		ReadingTakesTime.rnWaterPrepTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNWaterPrepID, ReadingTakesTime.rnWaterPrepTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == RNSaltID
;;;; DISABLE ;;;;		ReadingTakesTime.rnSaltTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(RNSaltID, ReadingTakesTime.rnSaltTime, "${1} hour(s)")
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ElseIf option == HBScrimBitsID
;;;; DISABLE ;;;;		ReadingTakesTime.hbScrimBitsTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBScrimBitsID, ReadingTakesTime.hbScrimBitsTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == HBScrimIdolID
;;;; DISABLE ;;;;		ReadingTakesTime.hbScrimIdolTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBScrimIdolID, ReadingTakesTime.hbScrimIdolTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == HBScrimToolID
;;;; DISABLE ;;;;		ReadingTakesTime.hbScrimToolTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBScrimToolID, ReadingTakesTime.hbScrimToolTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == HBLeatherID
;;;; DISABLE ;;;;		ReadingTakesTime.hbLeatherTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBLeatherID, ReadingTakesTime.hbLeatherTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == HBStripID
;;;; DISABLE ;;;;		ReadingTakesTime.hbStripTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBStripID, ReadingTakesTime.hbStripTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == HBBedrollID
;;;; DISABLE ;;;;		ReadingTakesTime.hbBedrollTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBBedrollID, ReadingTakesTime.hbBedrollTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == HBIngrID
;;;; DISABLE ;;;;		ReadingTakesTime.hbIngrTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBIngrID, ReadingTakesTime.hbIngrTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == HBBrewID
;;;; DISABLE ;;;;		ReadingTakesTime.hbBrewTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBBrewID, ReadingTakesTime.hbBrewTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == HBTallowID
;;;; DISABLE ;;;;		ReadingTakesTime.hbTallowTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBTallowID, ReadingTakesTime.hbTallowTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == HBArrowsID
;;;; DISABLE ;;;;		ReadingTakesTime.hbArrowsTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(HBArrowsID, ReadingTakesTime.hbArrowsTime, "${1} hour(s)")
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	ElseIf option == WLLanternID
;;;; DISABLE ;;;;		ReadingTakesTime.wlWearableTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(WLLanternID, ReadingTakesTime.wlWearableTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == WLChassisID
;;;; DISABLE ;;;;		ReadingTakesTime.wlChassisTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(WLChassisID, ReadingTakesTime.wlChassisTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == WLOilID
;;;; DISABLE ;;;;		ReadingTakesTime.wlOilTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(WLOilID, ReadingTakesTime.wlOilTime, "${0} Minute(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == LCBasicID
;;;; DISABLE ;;;;		ReadingTakesTime.lcBasicTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(LCBasicID, ReadingTakesTime.lcBasicTime, "${0} Minute(s)")
;;;; DISABLE ;;;;	ElseIf option == LCForgeID
;;;; DISABLE ;;;;		ReadingTakesTime.lcForgeTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(LCForgeID, ReadingTakesTime.lcForgeTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == LCArcaneID
;;;; DISABLE ;;;;		ReadingTakesTime.lcArcaneTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(LCArcaneID, ReadingTakesTime.lcArcaneTime, "${1} hour(s)")
;;;; DISABLE ;;;;	ElseIf option == LCBrewID
;;;; DISABLE ;;;;		ReadingTakesTime.lcBrewTime = value
;;;; DISABLE ;;;;        SetSliderOptionValue(LCBrewID, ReadingTakesTime.lcBrewTime, "${0} Minute(s)")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;    endIf
;;;; DISABLE ;;;;endEvent
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;event OnOptionDefault(int option)
;;;; DISABLE ;;;;	if (option == isModActiveID )
;;;; DISABLE ;;;;		isModActive = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(isModActiveID , isModActive)
;;;; DISABLE ;;;;	elseif (option == isReadingActiveID )
;;;; DISABLE ;;;;		isReadingActive = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(isReadingActiveID , isReadingActive)
;;;; DISABLE ;;;;	elseif (option == isCraftingActiveID )
;;;; DISABLE ;;;;		isCraftingActive = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(isCraftingActiveID , isCraftingActive)
;;;; DISABLE ;;;;	elseif (option == showMessageID )
;;;; DISABLE ;;;;		ReadingTakesTime.showMessage = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(showMessageID , ReadingTakesTime.showMessage)
;;;; DISABLE ;;;;	elseif (option == dontShowMessageID )
;;;; DISABLE ;;;;		ReadingTakesTime.dontShowMessage = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(dontShowMessageID, ReadingTakesTime.dontShowMessage )
;;;; DISABLE ;;;;	elseif (option == expertiseReducesTimeID )
;;;; DISABLE ;;;;		ReadingTakesTime.expertiseReducesTime = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(expertiseReducesTimeID, ReadingTakesTime.expertiseReducesTime )
;;;; DISABLE ;;;;	elseif (option == cantReadID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantRead = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantReadID, ReadingTakesTime.cantRead)
;;;; DISABLE ;;;;	elseif (option == readingIncreasesSpeechID)
;;;; DISABLE ;;;;		ReadingTakesTime.readingIncreasesSpeech = true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(readingIncreasesSpeechID, ReadingTakesTime.readingIncreasesSpeech)
;;;; DISABLE ;;;;	elseif (option == cantLootID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantLoot= true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantLootID, ReadingTakesTime.cantLoot)
;;;; DISABLE ;;;;	elseif (option == cantPickID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantPick= true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantPickID, ReadingTakesTime.cantPick)
;;;; DISABLE ;;;;	elseif (option == cantLevelUpID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantLevelUp= true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantLevelUpID, ReadingTakesTime.cantLevelUp)
;;;; DISABLE ;;;;	elseif (option == cantInventoryID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantInventory= true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantInventoryID, ReadingTakesTime.cantInventory)
;;;; DISABLE ;;;;	elseif (option == cantMagicID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantMagic= true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantMagicID, ReadingTakesTime.cantMagic)
;;;; DISABLE ;;;;	elseif (option == cantJournalID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantJournal= true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantJournalID, ReadingTakesTime.cantJournal)
;;;; DISABLE ;;;;	elseif (option == cantMapID)
;;;; DISABLE ;;;;		ReadingTakesTime.cantMap= true ; default value
;;;; DISABLE ;;;;		SetToggleOptionValue(cantMapID, ReadingTakesTime.cantMap)
;;;; DISABLE ;;;;	endIf
;;;; DISABLE ;;;;endEvent
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	DebugMode("OnOptionKeyMapChange a_option = " + a_option + " ; a_keyCode = " + a_keyCode + " ; a_conflictControl = " + a_conflictControl + " ; a_conflictName = " + a_conflictName)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	If (a_conflictControl != "")
;;;; DISABLE ;;;;		If (a_conflictName != "")
;;;; DISABLE ;;;;			ShowMessage("This key is already mapped to " + a_conflictControl + " in " + a_conflictName + ". Please choose a different key.")
;;;; DISABLE ;;;;		Else
;;;; DISABLE ;;;;			ShowMessage("This key is already mapped to " + a_conflictControl + " in Skyrim. Please choose a different key.")
;;;; DISABLE ;;;;		EndIf
;;;; DISABLE ;;;;		Return
;;;; DISABLE ;;;;	EndIf
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	If (a_option == hotkeySuspendID)
;;;; DISABLE ;;;;		DebugMode("Registered to HotkeySuspend.")
;;;; DISABLE ;;;;		ReadingTakesTime.hotkeySuspend = a_keyCode
;;;; DISABLE ;;;;	Else
;;;; DISABLE ;;;;		DebugMode("No matching registration.")
;;;; DISABLE ;;;;		Return
;;;; DISABLE ;;;;	EndIf
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	RegisterForKey(a_keyCode)
;;;; DISABLE ;;;;	ForcePageReset()
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;endEvent
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;event OnOptionHighlight(int option)
;;;; DISABLE ;;;;	if (option == isModActiveID )
;;;; DISABLE ;;;;		SetInfoText("$Activate or deactivate the mod.")
;;;; DISABLE ;;;;	elseif (option == isReadingActiveID || option == isCraftingActiveID || option == isContainerActiveID || option == isLockpickActiveID || option == isTrainingActiveID|| option == isLevelUpActiveID|| option == isInventoryActiveID|| option == isMagicActiveID|| option == isJournalActiveID|| option == isMapActiveID|| option == isBarterActiveID|| option == isGiftActiveID)
;;;; DISABLE ;;;;		SetInfoText("$Activate or deactivate this module.")
;;;; DISABLE ;;;;	ElseIf option == showMessageThresholdID
;;;; DISABLE ;;;;		SetInfoText("Notification of time passed only displayed if at least this many minutes have passed.")
;;;; DISABLE ;;;;	elseif (option == readMultID|| option == lootMultID|| option == pickMultID|| option == pickpocketMultID|| option == trainingMultID|| option == levelUpMultID|| option == inventoryMultID|| option == magicMultID|| option == journalMultID|| option == mapMultID|| option == barterMultID|| option == giftMultID)
;;;; DISABLE ;;;;		SetInfoText("$Multiplier used to calculate the time spent in this menu.")
;;;; DISABLE ;;;;	elseif (option == spellLearnTimeID|| option == headCraftTimeID|| option == armorCraftTimeID|| option == handsCraftTimeID|| option == feetCraftTimeID|| option == shieldCraftTimeID|| option == jewelryCraftTimeID|| option == battleAxeCraftTimeID|| option == bowCraftTimeID|| option == daggerCraftTimeID|| option == greatswordCraftTimeID|| option == maceCraftTimeID|| option == staffCraftTimeID|| option == swordCraftTimeID|| option == warhammerCraftTimeID|| option == warAxeCraftTimeID|| option == weaponCraftTimeID|| option == miscCraftTimeID|| option == armorImproveTimeID|| option == weaponImproveTimeID|| option == potionCraftTimeID|| option == enchantingTimeID|| option == trainingTimeID|| option == levelUpTimeID|| option == eatTimeID)
;;;; DISABLE ;;;;		SetInfoText("$Time spent when performing this action.")
;;;; DISABLE ;;;;	ElseIf option == hotkeySuspendID
;;;; DISABLE ;;;;		SetInfoText("Set a hotkey to suspend / resume the mod.")
;;;; DISABLE ;;;;	ElseIf option == LightAmorID
;;;; DISABLE ;;;;		SetInfoText("Additional time spent when stripping a corpse of a light armor cuirass.")
;;;; DISABLE ;;;;	ElseIf option == HeavyArmorID
;;;; DISABLE ;;;;		SetInfoText("Additional time spent when stripping a corpse of a heavy armor cuirass.")
;;;; DISABLE ;;;;	elseif (option == cantReadID || option == cantLootID|| option == cantPickID|| option == cantLevelUpID|| option == cantInventoryID|| option == cantMagicID|| option == cantJournalID|| option == cantMapID)
;;;; DISABLE ;;;;		SetInfoText("$Block this action while in combat.")
;;;; DISABLE ;;;;	elseif (option == readingIncreasesSpeechID )
;;;; DISABLE ;;;;		SetInfoText("$Reading increases speech.")
;;;; DISABLE ;;;;	elseif (option == readingIncreaseMultID )
;;;; DISABLE ;;;;		SetInfoText("$Reading increase multiplier.")
;;;; DISABLE ;;;;	elseif (option == showMessageID )
;;;; DISABLE ;;;;		SetInfoText("$Show notification messages with the time spent.")
;;;; DISABLE ;;;;	elseif (option == dontShowMessageID )
;;;; DISABLE ;;;;		SetInfoText("$RTT_DONTSHOWMESSAGE_HIGHLIGHT")
;;;; DISABLE ;;;;	elseif (option == expertiseReducesTimeID )
;;;; DISABLE ;;;;		SetInfoText("$RTT_EXPERTIESEREDUCESTIME_HIGHLIGHT")
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	; Campfire Camping
;;;; DISABLE ;;;;	ElseIf option == CFCloakID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft any of the Frostfall cloaks.")
;;;; DISABLE ;;;;	ElseIf option == CFStickID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a walking stick.")
;;;; DISABLE ;;;;	ElseIf option == CFTorchID
;;;; DISABLE ;;;;		SetInfoText("Time spent to create one torch.")
;;;; DISABLE ;;;;	ElseIf option == CFCookpotID
;;;; DISABLE ;;;;		SetInfoText("Time spent at the forge to craft a steel cookpot.")
;;;; DISABLE ;;;;	ElseIf option == CFBackpackID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft any of the Frostfall backpacks. Modifying backpacks costs no time.")
;;;; DISABLE ;;;;	ElseIf option == CFBeddingID
;;;; DISABLE ;;;;		SetInfoText("Time spent on bedrolls for tents, rough bedding takes half this time.")
;;;; DISABLE ;;;;	ElseIf option == CFSmallTentID
;;;; DISABLE ;;;;		SetInfoText("Time spent to create any small tent.")
;;;; DISABLE ;;;;	ElseIf option == CFLargeTentID
;;;; DISABLE ;;;;		SetInfoText("Time spent to create any large tent.")
;;;; DISABLE ;;;;	ElseIf option == CFHatchetID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a stone hatchet.")
;;;; DISABLE ;;;;	ElseIf option == CFArrowsID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a batch (24) of stone arrows.")
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	; Campfire Materials
;;;; DISABLE ;;;;	ElseIf option == CFLinenID
;;;; DISABLE ;;;;		SetInfoText("Time spent to make one linen wrap. Multiplied when crafting several.")
;;;; DISABLE ;;;;	ElseIf option == CFFurID
;;;; DISABLE ;;;;		SetInfoText("Time spent to create any single fur plate. Multiplied when crafting several.")
;;;; DISABLE ;;;;	ElseIf option == CFLaceID
;;;; DISABLE ;;;;		SetInfoText("Time spent to produce a string of hide lace. Multiplied when crafting several.")
;;;; DISABLE ;;;;	ElseIf option == CFTanRackID
;;;; DISABLE ;;;;		SetInfoText("Time spent to assemble a tanning rack.")
;;;; DISABLE ;;;;	ElseIf option == CFMortarID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a mortar and pestle, including Hunterborn's Scrimshaw recipe.")
;;;; DISABLE ;;;;	ElseIf option == CFEnchID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a set of enchanting supplies.")
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	; Campfire Firecraft
;;;; DISABLE ;;;;	ElseIf option == CFFirecraftImprovesID
;;;; DISABLE ;;;;		SetInfoText("Should the Firecraft perk of Campfire speed up the firecraft times at 20% off for each rank.\nDoes not help lighting with a torch or spell.")
;;;; DISABLE ;;;;	ElseIf option == CFMakeTinderID
;;;; DISABLE ;;;;		SetInfoText("Time spent making tinder from everyday objects.")
;;;; DISABLE ;;;;	ElseIf option == CFMakeKindlingID
;;;; DISABLE ;;;;		SetInfoText("Time spent making kindling from everyday objects.")
;;;; DISABLE ;;;;	ElseIf option == CFAddTinderID
;;;; DISABLE ;;;;		SetInfoText("Time spent prepping tinder on the campfire.")
;;;; DISABLE ;;;;	ElseIf option == CFAddKindlingID
;;;; DISABLE ;;;;		SetInfoText("Time spent arranging kindling on the campfire.")
;;;; DISABLE ;;;;	ElseIf option == CFLightFireID
;;;; DISABLE ;;;;		SetInfoText("Time spent trying to spark the fire.\nSpells and torches take one quarter this time.")
;;;; DISABLE ;;;;	ElseIf option == CFAddFuelID
;;;; DISABLE ;;;;		SetInfoText("Time spent tending to the fire, to replenish fuel or make it bigger.")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == FFSnowberryID
;;;; DISABLE ;;;;		SetInfoText("Time spent making snowberry extract.")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == RNWaterskinID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a waterskin, including Hunterborn's recipe.")
;;;; DISABLE ;;;;	ElseIf option == RNCookpotID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a cast iron pot at the forge.")
;;;; DISABLE ;;;;	ElseIf option == RNTinderboxID
;;;; DISABLE ;;;;		SetInfoText("Time spent to forge and assemble a tinderbox.")
;;;; DISABLE ;;;;	ElseIf option == RNBedrollID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a traveller's bedroll.")
;;;; DISABLE ;;;;	ElseIf option == RNTentID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a traveller's tent.")
;;;; DISABLE ;;;;	ElseIf option == RNMilkBucketID
;;;; DISABLE ;;;;		SetInfoText("Time spent preparing a common bucket for use as a milk bucket, at the tanning rack.")
;;;; DISABLE ;;;;	ElseIf option == RNFoodSnackID
;;;; DISABLE ;;;;		SetInfoText("Time spent eating a snack, or candy or fruit. Compatible with any food patched to have RND effects.")
;;;; DISABLE ;;;;	ElseIf option == RNFoodMediumID
;;;; DISABLE ;;;;		SetInfoText("Time spent eating a medium size meal. Compatible with any food patched to have RND effects.")
;;;; DISABLE ;;;;	ElseIf option == RNFoodFillingID
;;;; DISABLE ;;;;		SetInfoText("Time spent eating a filling meal. Compatible with any food patched to have RND effects.")
;;;; DISABLE ;;;;	ElseIf option == RNWaterDrinkID
;;;; DISABLE ;;;;		SetInfoText("Time spent consuming one drink. Compatible with any beverage patched to have RND effects.")
;;;; DISABLE ;;;;	ElseIf option == RNCookSnackID
;;;; DISABLE ;;;;		SetInfoText("Time spent to cook a snack. Compatible with any food patched to have RND effects. Batches take no extra time.")
;;;; DISABLE ;;;;	ElseIf option == RNCookMediumID
;;;; DISABLE ;;;;		SetInfoText("Time spent to cook a medium size meal. Compatible with any food patched to have RND effects. Batches take no extra time.")
;;;; DISABLE ;;;;	ElseIf option == RNCookFillingID
;;;; DISABLE ;;;;		SetInfoText("Time spent to cook a filling meal. Compatible with any food patched to have RND effects. Batches take no extra time.")
;;;; DISABLE ;;;;	ElseIf option == RNBrewDrinkID
;;;; DISABLE ;;;;		SetInfoText("Time spent to brew any drink, besides plain water. Compatible with any beverage patched to have RND effects. Batches take no extra time.")
;;;; DISABLE ;;;;	ElseIf option == RNWaterPrepID
;;;; DISABLE ;;;;		SetInfoText("Time spent at the cookpot to prepare water from any source. This includes boiling water, or changing from a waterskin to water for cooking.")
;;;; DISABLE ;;;;	ElseIf option == RNSaltID
;;;; DISABLE ;;;;		SetInfoText("Time spent boiling down sea water into a salt pile.")
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ElseIf option == HBScrimBitsID
;;;; DISABLE ;;;;		SetInfoText("Time spent to scrimshaw one set of bone bits. Multiplied when crafting several. Harvesting level reduces time taken.")
;;;; DISABLE ;;;;	ElseIf option == HBScrimIdolID
;;;; DISABLE ;;;;		SetInfoText("Time spent to scrimshaw various idol-like artifacts. Harvesting level reduces time taken.")
;;;; DISABLE ;;;;	ElseIf option == HBScrimToolID
;;;; DISABLE ;;;;		SetInfoText("Time spent to scrimshaw various tools. Harvesting level reduces time taken.")
;;;; DISABLE ;;;;	ElseIf option == HBLeatherID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft 1 piece of leather. Applies to tanning rack AND all other sources, such as armor breakdown. Harvesting level reduces time taken.")
;;;; DISABLE ;;;;	ElseIf option == HBStripID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft 3 leather strips. Applies to ANY source of leather strips. Harvesting level reduces time taken.")
;;;; DISABLE ;;;;	ElseIf option == HBWeapArmorTipID
;;;; DISABLE ;;;;		SetInfoText("Scrimshaw's weapons and armors use the times set in Crafting, but use Harvesting level to reduce time taken, not Smithing.")
;;;; DISABLE ;;;;	ElseIf option == HBBedrollID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a hunter's bedroll, at the tanning rack. Harvesting level reduces time taken.")
;;;; DISABLE ;;;;	ElseIf option == HBIngrID
;;;; DISABLE ;;;;		SetInfoText("Time spent to rework certain ingredients, such as polished eyes. Harvesting level reduces time taken.")
;;;; DISABLE ;;;;	ElseIf option == HBBrewID
;;;; DISABLE ;;;;		SetInfoText("Time spent when brewing any of Hunterborn's custom potions at the cookpot.")
;;;; DISABLE ;;;;	ElseIf option == HBTallowID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft each piece of tallow. Used only in the Hunterborn + Lanterns and Candles patch.")
;;;; DISABLE ;;;;	ElseIf option == HBArrowsID
;;;; DISABLE ;;;;		SetInfoText("Time spent to craft a batch of arrows with Scrimshaw. Same time for either 24 with firewood, or 12 with animal bones.")
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	ElseIf option == WLLanternID
;;;; DISABLE ;;;;		SetInfoText("Make a lantern wearable by attaching a leather strip. Done at the forge, but not considered smithing.")
;;;; DISABLE ;;;;	ElseIf option == WLChassisID
;;;; DISABLE ;;;;		SetInfoText("Craft a lantern chassis at a forge. It can then be converted into a wearable lantern.")
;;;; DISABLE ;;;;	ElseIf option == WLOilID
;;;; DISABLE ;;;;		SetInfoText("Crafting lantern oil is possible with other mods, such as Hunterborn.")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ElseIf option == LCBasicID
;;;; DISABLE ;;;;		SetInfoText("Simple assembly, like a candle in a wine bottle. Done at the forge, but not considered smithing.")
;;;; DISABLE ;;;;	ElseIf option == LCForgeID
;;;; DISABLE ;;;;		SetInfoText("Wrought iron work done at a forge, such as lanterns and shrines.")
;;;; DISABLE ;;;;	ElseIf option == LCArcaneID
;;;; DISABLE ;;;;		SetInfoText("Sophisticated works requiring skill as an arcane blacksmith, such as a wizard's lamp.")
;;;; DISABLE ;;;;	ElseIf option == LCBrewID
;;;; DISABLE ;;;;		SetInfoText("Time spent to sculpt one candle at the cookpot. Multiplied when crafting several.")
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	endIf
;;;; DISABLE ;;;;endEvent
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;Event OnKeyUp(int keyCode, float holdTime)
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	;DebugMode("OnKeyUp = " + keyCode)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	If !isModActive
;;;; DISABLE ;;;;		UnregisterForAllKeys()
;;;; DISABLE ;;;;		Return
;;;; DISABLE ;;;;	EndIf
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	If (UI.IsMenuOpen("Console") || Utility.IsInMenuMode() || Game.GetPlayer().GetSitState() != 0)
;;;; DISABLE ;;;;		; Ignore keystrokes in the console or at furniture (like naming an enchanted object)
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	ElseIf (keyCode == ReadingTakesTime.hotkeySuspend)
;;;; DISABLE ;;;;		ReadingTakesTime.Suspended = !ReadingTakesTime.Suspended
;;;; DISABLE ;;;;		If ReadingTakesTime.Suspended
;;;; DISABLE ;;;;			Debug.Notification("Living Takes Time suspended.")
;;;; DISABLE ;;;;		Else
;;;; DISABLE ;;;;			Debug.Notification("Living Takes Time resumed.")
;;;; DISABLE ;;;;		EndIf
;;;; DISABLE ;;;;		
;;;; DISABLE ;;;;	Else
;;;; DISABLE ;;;;		UnregisterForKey(keyCode)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	EndIf
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;EndEvent
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;string Function GetCustomControl(int keyCode)
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	;DebugMode("GetCustomControl = " + keyCode)
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	If (keyCode == ReadingTakesTime.hotkeySuspend)
;;;; DISABLE ;;;;		Return "Suspend/Resume"
;;;; DISABLE ;;;;	Else
;;;; DISABLE ;;;;		Return ""
;;;; DISABLE ;;;;	EndIf
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;EndFunction
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;Function ReassignHotKeys()
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ReassignHotkey(ReadingTakesTime.hotkeySuspend, "HotkeySuspend")
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;EndFunction
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;Function ReassignHotkey(int aiKeyCode, string akName)
;;;; DISABLE ;;;;	If aiKeyCode
;;;; DISABLE ;;;;		RegisterForKey(aiKeyCode)
;;;; DISABLE ;;;;		;DebugMode("Hotkey " + aiKeyCode + " registrationg refresh for " + akName + ".")
;;;; DISABLE ;;;;	EndIf
;;;; DISABLE ;;;;EndFunction
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;; Default time values for extra mods, FF / HB / WL / LaC
;;;; DISABLE ;;;;Function SetModDefaults()
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ReadingTakesTime.cfCloakTime = DEF_cfCloakTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfStickTime = DEF_cfStickTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfTorchTime = DEF_cfTorchTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfCookpotTime = DEF_cfCookpotTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfBackpackTime = DEF_cfBackpackTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfBeddingTime = DEF_cfBeddingTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfSmallTentTime = DEF_cfSmallTentTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfLargeTentTime = DEF_cfLargeTentTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfHatchetTime = DEF_cfHatchetTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfArrowsTime = DEF_cfArrowsTime
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ReadingTakesTime.cfLinenTime = DEF_cfLinenTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfFurTime = DEF_cfFurTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfLaceTime = DEF_cfLaceTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfTanRackTime = DEF_cfTanRackTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfMortarTime = DEF_cfMortarTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfEnchTime = DEF_cfEnchTime
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ReadingTakesTime.cfFirecraftImproves = DEF_cfFirecraftImproves
;;;; DISABLE ;;;;	ReadingTakesTime.cfMakeTinderTime = DEF_cfMakeTinderTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfMakeKindlingTime = DEF_cfMakeKindlingTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfAddTinderTime = DEF_cfAddTinderTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfAddKindlingTime = DEF_cfAddKindlingTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfLightFireTime = DEF_cfLightFireTime
;;;; DISABLE ;;;;	ReadingTakesTime.cfAddFuelTime = DEF_cfAddFuelTime
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ReadingTakesTime.ffSnowberryTime = DEF_Extract
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;	ReadingTakesTime.rnWaterskinTime = 2
;;;; DISABLE ;;;;	ReadingTakesTime.rnCookpotTime = 1
;;;; DISABLE ;;;;	ReadingTakesTime.rnTinderboxTime = 2
;;;; DISABLE ;;;;	ReadingTakesTime.rnBedrollTime = 3
;;;; DISABLE ;;;;	ReadingTakesTime.rnTentTime = 4
;;;; DISABLE ;;;;	ReadingTakesTime.rnMilkBucketTime = 5
;;;; DISABLE ;;;;	ReadingTakesTime.rnEatSnackTime = 2
;;;; DISABLE ;;;;	ReadingTakesTime.rnEatMediumTime = 10
;;;; DISABLE ;;;;	ReadingTakesTime.rnEatFillingTime = 30
;;;; DISABLE ;;;;	ReadingTakesTime.rnDrinkTime = 2
;;;; DISABLE ;;;;	ReadingTakesTime.rnCookSnackTime = 10
;;;; DISABLE ;;;;	ReadingTakesTime.rnCookMediumTime = 20
;;;; DISABLE ;;;;	ReadingTakesTime.rnCookFillingTime = 45
;;;; DISABLE ;;;;	ReadingTakesTime.rnBrewTime = 15
;;;; DISABLE ;;;;	ReadingTakesTime.rnWaterPrepTime = 5
;;;; DISABLE ;;;;	ReadingTakesTime.rnSaltTime = 2
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ReadingTakesTime.hbLeatherTime = 1
;;;; DISABLE ;;;;	ReadingTakesTime.hbStripTime = 30
;;;; DISABLE ;;;;	ReadingTakesTime.hbScrimBitsTime = 5
;;;; DISABLE ;;;;	ReadingTakesTime.hbTallowTime = 10
;;;; DISABLE ;;;;	ReadingTakesTime.hbIngrTime = 30
;;;; DISABLE ;;;;	ReadingTakesTime.hbBrewTime = 30
;;;; DISABLE ;;;;	ReadingTakesTime.hbScrimIdolTime = 2
;;;; DISABLE ;;;;	ReadingTakesTime.hbScrimToolTime = 1
;;;; DISABLE ;;;;	ReadingTakesTime.hbBedrollTime = 3
;;;; DISABLE ;;;;	ReadingTakesTime.hbArrowsTime = 1
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ReadingTakesTime.wlWearableTime = 30
;;;; DISABLE ;;;;	ReadingTakesTime.wlChassisTime = 2
;;;; DISABLE ;;;;	ReadingTakesTime.wlOilTime = 30
;;;; DISABLE ;;;;	
;;;; DISABLE ;;;;	ReadingTakesTime.lcBasicTime = 10
;;;; DISABLE ;;;;	ReadingTakesTime.lcForgeTime = 3
;;;; DISABLE ;;;;	ReadingTakesTime.lcArcaneTime = 6
;;;; DISABLE ;;;;	ReadingTakesTime.lcBrewTime = 15
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;EndFunction
;;;; DISABLE ;;;;
;;;; DISABLE ;;;;Function DebugMode(string sMsg)
;;;; DISABLE ;;;;	Debug.Trace("[RTT_Menu] " + sMsg)
;;;; DISABLE ;;;;EndFunction
;;;; DISABLE ;;;;