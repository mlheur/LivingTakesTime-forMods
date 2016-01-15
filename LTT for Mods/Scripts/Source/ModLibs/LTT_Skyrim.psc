scriptname LTT_Skyrim extends LTT_ModBase 

string	LTT_Name		= "Living TakeS Time" AutoReadOnly
string	LTT_ESP			= "Skyrim.esm" AutoReadonly

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables

;;;;;;;;;;
; While Reading
bool	LTT_WhileReading	= true
bool	LTT_ReadInCombat	= false
float	LTT_ReadTimeMult	= 1.0
bool	LTT_ReadIncreasesSpeech	= false
flaot	LTT_SpeechIncreaseMult	= 1.0
float	LTT_SpellLearnHrs	= 2.0

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions

event OnGameRelaod()
	LTT_ID = LTT_addMod( LTT_Name, LTT_ESP, 0xF, LTT_ACT_ALL )
	kSnowberryExtract = Game.GetFormFromFile( 0, ESP )
endevent

float function ItemAdded( form Item, int Prefix, int Type, int Count, form Source )
	if prefix != LTT_getModPrefix( LTT_ID )
		return -1.0
	endif
	Float t = 0.0
	If akBaseItem == FF_SnowberryExtract
		t = LTT_MinsToHrs( FF3_SnowberryMins )
		DebugMode("Snowberry Extract. Base time = " + t)
		return t

	EndIf
	; Frostfall "gives" objects when its changing exposure status, handle & ignore those.
	if aiType == 32 && akBaseItem == FF_Dummy ; Chesko made it too heavy to be ignored :)
		return 0.0
	endif
	return -1.0
EndFunction