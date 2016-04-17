scriptname LTT_Base extends Quest
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	Base quest providing a framework over which other mods/ESPs can use
//	to receive event notifications and calculate the amount of time passed
//	for those events.
//	It also provides an interface between the mod's LTT settings and MCM
// Credits
//	- Akezhar for proviiding the original Living Takes Time (RTT) mod
//	- dragonsong/unuroboros for providing the first iteration of
//	  compatibility between RTT and Hunterborn, Frostfall & others, and the
//	  starting point for this mod
//	- Chesko for all his awesome mods and continuing dedication to skyrim
//	- SkyUI team for MCM and just being great modders
//	- SKSE team everything they've allowed modders to do.
// Changes
//	mlheur | v0.0-alpha | Initial release based on Hunterborn's misc addon.
///////////////////////////////////////////////////////////////////////////////;

;///////////////////////////////////////////////////////////////////////////////
// Object references
/;
LTT_DataHandler Property LDH Auto
LTT_Menu property mcm Auto
LTT_Skyrim property Skyrim Auto
FISSInterface fiss
FormList Property LTT_FL_msgTimePassed Auto
FormList Property LTT_FL_msgInCombat Auto
GlobalVariable Property TimeScale Auto	; TODO check how timescale is being used
GlobalVariable Property GameHour Auto

;///////////////////////////////////////////////////////////////////////////////
// Constants
/;
; Time values used by many mods
float property craftHeadHrs		= 2.0 AutoReadOnly
float property craftBodyHrs		= 6.0 AutoReadOnly
float property craftLimbHrs		= 3.0 AutoReadOnly
float property craftShieldHrs		= 4.0 AutoReadOnly
float property craftJewelryHrs		= 1.0 AutoReadOnly
float property craftOneHandedHrs	= 3.0 AutoReadOnly
float property craftDaggerHrs		= 1.5 AutoReadOnly
float property craftTwoHandedHrs	= 5.0 AutoReadOnly
float property craftStaffHrs		= 2.0 AutoReadOnly
float property craftBowHrs		= 3.0 AutoReadOnly
float property craftAmmoHrs		= 1.0 AutoReadOnly
float property craftMiscHrs		= 1.0 AutoReadOnly
float property craftImproveHrs		= 1.0 AutoReadOnly
float property craftBeddingHrs		= 0.5 AutoReadOnly
int   property craftTorchMins		= 15 AutoReadOnly
int   property eatFoodMins		= 15 AutoReadOnly
int   property craftFoodMins		= 30 AutoReadOnly
int   property craftIngredientMins	= 15 AutoReadOnly

; form types
int property kANIO				= 83 AutoReadOnly
int property kARMA				= 102 AutoReadOnly
int property kAcousticSpace			= 16 AutoReadOnly
int property kAction				= 6 AutoReadOnly
int property kActivator				= 24 AutoReadOnly
int property kActorValueInfo			= 95 AutoReadOnly
int property kAddonNode				= 94 AutoReadOnly
int property kAmmo				= 42 AutoReadOnly
int property kApparatus				= 33 AutoReadOnly
int property kArmor				= 26 AutoReadOnly
int property kArrowProjectile			= 64 AutoReadOnly
int property kArt				= 125 AutoReadOnly
int property kAssociationType			= 123 AutoReadOnly
int property kBarrierProjectile			= 69 AutoReadOnly
int property kBeamProjectile			= 66 AutoReadOnly
int property kBodyPartData			= 93 AutoReadOnly
int property kBook				= 27 AutoReadOnly
int property kCameraPath			= 97 AutoReadOnly
int property kCameraShot			= 96 AutoReadOnly
int property kCell				= 60 AutoReadOnly
int property kCharacter				= 62 AutoReadOnly
int property kClass				= 10 AutoReadOnly
int property kClimate				= 55 AutoReadOnly
int property kCollisionLayer			= 132 AutoReadOnly
int property kColorForm				= 133 AutoReadOnly
int property kCombatStyle			= 80 AutoReadOnly
int property kConeProjectile			= 68 AutoReadOnly
int property kConstructibleObject		= 49 AutoReadOnly
int property kContainer				= 28 AutoReadOnly
int property kDLVW				= 117 AutoReadOnly
int property kDebris				= 88 AutoReadOnly
int property kDefaultObject			= 107 AutoReadOnly
int property kDialogueBranch			= 115 AutoReadOnly
int property kDoor				= 29 AutoReadOnly
int property kDualCastData			= 129 AutoReadOnly
int property kEffectSetting			= 18 AutoReadOnly
int property kEffectShader			= 85 AutoReadOnly
int property kEnchantment			= 21 AutoReadOnly
int property kEncounterZone			= 103 AutoReadOnly
int property kEquipSlot				= 120 AutoReadOnly
int property kExplosion				= 87 AutoReadOnly
int property kEyes				= 13 AutoReadOnly
int property kFaction				= 11 AutoReadOnly
int property kFlameProjectile			= 67 AutoReadOnly
int property kFlora				= 39 AutoReadOnly
int property kFootstep				= 110 AutoReadOnly
int property kFootstepSet			= 111 AutoReadOnly
int property kFurniture				= 40 AutoReadOnly
int property kGMST				= 3 AutoReadOnly
int property kGlobal				= 9 AutoReadOnly
int property kGrass				= 37 AutoReadOnly
int property kGrenadeProjectile			= 65 AutoReadOnly
int property kGroup				= 2 AutoReadOnly
int property kHazard				= 51 AutoReadOnly
int property kHeadPart				= 12 AutoReadOnly
int property kIdle				= 78 AutoReadOnly
int property kIdleMarker			= 47 AutoReadOnly
int property kImageSpace			= 89 AutoReadOnly
int property kImageSpaceModifier		= 90 AutoReadOnly
int property kImpactData			= 100 AutoReadOnly
int property kImpactDataSet			= 101 AutoReadOnly
int property kIngredient			= 30 AutoReadOnly
int property kKey				= 45 AutoReadOnly
int property kKeyword				= 4 AutoReadOnly
int property kLand				= 72 AutoReadOnly
int property kLandTexture			= 20 AutoReadOnly
int property kLeveledCharacter			= 44 AutoReadOnly
int property kLeveledItem			= 53 AutoReadOnly
int property kLeveledSpell			= 82 AutoReadOnly
int property kLight				= 31 AutoReadOnly
int property kLightingTemplate			= 108 AutoReadOnly
int property kList				= 91 AutoReadOnly
int property kLoadScreen			= 81 AutoReadOnly
int property kLocation				= 104 AutoReadOnly
int property kLocationRef			= 5 AutoReadOnly
int property kMaterial				= 126 AutoReadOnly
int property kMaterialType			= 99 AutoReadOnly
int property kMenuIcon				= 8 AutoReadOnly
int property kMessage				= 105 AutoReadOnly
int property kMisc				= 32 AutoReadOnly
int property kMissileProjectile			= 63 AutoReadOnly
int property kMovableStatic			= 36 AutoReadOnly
int property kMovementType			= 127 AutoReadOnly
int property kMusicTrack			= 116 AutoReadOnly
int property kMusicType				= 109 AutoReadOnly
int property kNAVI				= 59 AutoReadOnly
int property kNPC				= 43 AutoReadOnly
int property kNavMesh				= 73 AutoReadOnly
int property kNone				= 0 AutoReadOnly
int property kNote				= 48 AutoReadOnly
int property kOutfit				= 124 AutoReadOnly
int property kPHZD				= 70 AutoReadOnly
int property kPackage				= 79 AutoReadOnly
int property kPerk				= 92 AutoReadOnly
int property kPotion				= 46 AutoReadOnly
int property kProjectile			= 50 AutoReadOnly
int property kQuest				= 77 AutoReadOnly
int property kRace				= 14 AutoReadOnly
int property kRagdoll				= 106 AutoReadOnly
int property kReference				= 61 AutoReadOnly
int property kReferenceEffect			= 57 AutoReadOnly
int property kRegion				= 58 AutoReadOnly
int property kRelationship			= 121 AutoReadOnly
int property kReverbParam			= 134 AutoReadOnly
int property kScene				= 122 AutoReadOnly
int property kScript				= 19 AutoReadOnly
int property kScrollItem			= 23 AutoReadOnly
int property kShaderParticleGeometryData	= 56 AutoReadOnly
int property kShout				= 119 AutoReadOnly
int property kSkill				= 17 AutoReadOnly
int property kSoulGem				= 52 AutoReadOnly
int property kSound				= 15 AutoReadOnly
int property kSoundCategory			= 130 AutoReadOnly
int property kSoundDescriptor			= 128 AutoReadOnly
int property kSoundOutput			= 131 AutoReadOnly
int property kSpell				= 22 AutoReadOnly
int property kStatic				= 34 AutoReadOnly
int property kStaticCollection			= 35 AutoReadOnly
int property kStoryBranchNode			= 112 AutoReadOnly
int property kStoryEventNode			= 114 AutoReadOnly
int property kStoryQuestNode			= 113 AutoReadOnly
int property kTES4				= 1 AutoReadOnly
int property kTLOD				= 74 AutoReadOnly
int property kTOFT				= 86 AutoReadOnly
int property kTalkingActivator			= 25 AutoReadOnly
int property kTextureSet			= 7 AutoReadOnly
int property kTopic				= 75 AutoReadOnly
int property kTopicInfo				= 76 AutoReadOnly
int property kTree				= 38 AutoReadOnly
int property kVoiceType				= 98 AutoReadOnly
int property kWater				= 84 AutoReadOnly
int property kWeapon				= 41 AutoReadOnly
int property kWeather				= 54 AutoReadOnly
int property kWordOfPower			= 118 AutoReadOnly
int property kWorldSpace			= 71 AutoReadOnly

; Skills
string property skill_OneHanded		= "OneHanded" AutoReadOnly
string property skill_TwoHanded		= "TwoHanded" AutoReadOnly
string property skill_Marksman		= "Marksman" AutoReadOnly
string property skill_Block		= "Block" AutoReadOnly
string property skill_Smithing		= "Smithing" AutoReadOnly
string property skill_HeavyArmor	= "HeavyArmor" AutoReadOnly
string property skill_LightArmor	= "LightArmor" AutoReadOnly
string property skill_Pickpocket	= "Pickpocket" AutoReadOnly
string property skill_Lockpicking	= "Lockpicking" AutoReadOnly
string property skill_Sneak		= "Sneak" AutoReadOnly
string property skill_Alchemy		= "Alchemy" AutoReadOnly
string property skill_Speechcraft	= "Speechcraft" AutoReadOnly
string property skill_Alteration	= "Alteration" AutoReadOnly
string property skill_Conjuration	= "Conjuration" AutoReadOnly
string property skill_Destruction	= "Destruction" AutoReadOnly
string property skill_Illusion		= "Illusion" AutoReadOnly
string property skill_Restoration	= "Restoration" AutoReadOnly
string property skill_Enchanting	= "Enchanting" AutoReadOnly

; Maximum values for MCM data
int	property maxMins		= 1440 AutoReadOnly ; 24 hours
float	property maxHrs			= 24.0 AutoReadOnly
float	property maxMult		= 10.0 AutoReadOnly

; Used for knowing what type of actions each mod wants to be notified of
int property act_NONE		= 0x00 AutoReadOnly
int property act_ITEMADDED	= 0x01 AutoReadOnly
int property act_ITEMREMOVED	= 0x02 AutoReadOnly
int property act_MENUOPENED	= 0x04 AutoReadOnly
int property act_MENUCLOSED	= 0x08 AutoReadOnly

; Which in game menus are watched for act_MENU(OPENED|CLOSED)
;//
// I want to use a bit-field to know which menus each mod cares about.
// The only thing is that there are more than 32 menus, so I need more than 32
// bits.  I can either eliminate some unlikely menus, or use two bit-fields and
// put each menu into one of two categories.
// I'm also not sure how I can map each each bitfield ID into an index for
// I think I'll have to eliminate some menus from the bitfield.
/;
int		_menuList		; the string list of all menus
int property	menu_None		= 0x00000000 AutoReadOnly
int property	menu_Barter		= 0x00000001 AutoReadOnly ; Part of trading
int property	menu_Book		= 0x00000002 AutoReadOnly ; while reading
int property	menu_Console		= 0x00000004 AutoReadOnly ; Probably not needed
int property	menu_ConsoleNative	= 0x00000008 AutoReadOnly ; Probably not needed
int property	menu_Container		= 0x00000010 AutoReadOnly ; while looting
int property	menu_Crafting		= 0x00000020 AutoReadOnly ; while crafting
int property	menu_Credits		= 0x00000040 AutoReadOnly ; probably not needed
int property	menu_Cursor		= 0x00000080 AutoReadOnly ; probably not needed
int property	menu_DebugText		= 0x00000100 AutoReadOnly ; probably not needed
int property	menu_Dialogue		= 0x00000200 AutoReadOnly ; in case to prevent during combat
int property	menu_Fader		= 0x00000400 AutoReadOnly ; probably not needed
int property	menu_Favorites		= 0x00000800 AutoReadOnly ; in case to prevent during combat
int property	menu_Gift		= 0x00001000 AutoReadOnly ; Part of trading
int property	menu_HUDMenu		= 0x00002000 AutoReadOnly ; probably not needed
int property	menu_Inventory		= 0x00004000 AutoReadOnly ; Part of preparing, and prevent during combat
int property	menu_Journal		= 0x00008000 AutoReadOnly ; Part of preparing, and prevent during combat
;int property	menu_Kinect		= 0x00010000 AutoReadOnly ; If this is the xbox kinect menu, then it's probably not needed
int property	menu_Training		= 0x00010000 AutoReadOnly
int property	menu_LevelUp		= 0x00020000 AutoReadOnly
int property	menu_Loading		= 0x00040000 AutoReadOnly ; probably don't want to pass time during a loading menu
int property	menu_Lockpicking	= 0x00080000 AutoReadOnly
int property	menu_Magic		= 0x00100000 AutoReadOnly ; Part of preparing, and prevent during combat
;int property	menu_MainMenu		= 0x00200000 AutoReadOnly ; not needed as there's no game being played at this menu
int property	menu_Tween		= 0x00200000 AutoReadOnly
int property	menu_Map		= 0x00400000 AutoReadOnly ; Part of preparing, and prevent during combat
int property	menu_MessageBox		= 0x00800000 AutoReadOnly ; Probably not needed, but an aggressive mod might want to consider this as preparation
int property	menu_Mist		= 0x01000000 AutoReadOnly ; Probably not needed, I think this is an overlay on loading and main meny screens
int property	menu_OverlayInteraction	= 0x02000000 AutoReadOnly ; Probably not needed
int property	menu_Overlay		= 0x04000000 AutoReadOnly ; Probably not needed
int property	menu_Quantity		= 0x08000000 AutoReadOnly ; Probably not needed
int property	menu_RaceSex		= 0x10000000 AutoReadOnly ; Probably not needed, but the face sculpter could take time
int property	menu_SleepWait		= 0x20000000 AutoReadOnly ; Probably not needed, already passes time
int property	menu_Stats		= 0x40000000 AutoReadOnly
int property	menu_TitleSequence	= 0x80000000 AutoReadOnly ; Probably not needed
; The rest are not possible as they would use bits 33 and above
;int property	menu_TopMenu		= 0x100000000 AutoReadOnly
; moved Training menu instead of kinect menu
;int property	menu_Tutorial		= 0x400000000 AutoReadOnly
; moved Tween menu instead of main menu

; Some canned crafting station indexes hard coded into LTT Data Handler
int property station_None	= 0 AutoReadOnly
int property station_Other	= 1 AutoReadOnly

; Spinlock management
float	property LockWaitTime		= 0.1 AutoReadOnly
int	property _spinlockTries		= 1000 AutoReadOnly

;///////////////////////////////////////////////////////////////////////////////
// Variable Declarations
/;
bool property isInit	= false Auto

bool property LTT_debug		= true Auto ; when set, LTT in beta testing
bool property LTT_verbose	= true Auto ; when set, LTT in alpha testing
int LTT_verMajor	= 0
int LTT_verMinor	= 0
int function getVersion()
	; Can't return a variable because it won't reinit if updated script on an old save...
	return 0
endfunction

string property SkillUsed = "" Auto

; LTT Base Related Properties
int property prop_LTTSaveFile		= -1 Auto
int property prop_BaseActive		= -1 Auto
int property prop_Paused		= -1 Auto
int property prop_PauseKey		= -1 Auto
int property prop_FirstPersonMsgs	= -1 Auto
int property prop_ExpertiseReducesTime	= -1 Auto
int property prop_ShowMsgThreshold	= -1 Auto
int property prop_DebugLevel		= -1 Auto

string property station_Cookpot		= "CraftingCookpot" Auto
string property	station_Smelter		= "CraftingSmelter" Auto
string property station_ArmorTable	= "CraftingSmithingArmorTable" Auto
string property station_Forge		= "CraftingSmithingForge" Auto
string property station_Sharpening	= "CraftingSmthingSharpeningWheel" Auto
string property station_SkyForge	= "CraftingSmithingSkyforge" Auto
string property station_TanningRack	= "CraftingTanningRack" Auto
string property station_Alchemy		= "isAlchemy" Auto
string property station_Enchanting	= "isEnchanting" Auto

; State tracker IDs
int property state_Menu			= -1 Auto
int property state_IsLooting		= -1 Auto
int property state_IsCrafting		= -1 Auto
int property state_CraftingStation	= -1 Auto
int property state_IsPickpocketing	= -1 Auto

; MCM Vars
string LTT_SaveFile	= "LTTForMods.xml"
int[]	mcmOID_Index
int[]	mcmOID_Prop
int	mcmOID_Count	= -1
int	mcmOID_Save	= -1
int	mcmOID_Load	= -1

int mcmCellBaseActive	= 0
int mcmCellPersonMsgs	= 2
int mcmCellMsgThreshold	= 4
int mcmCellPause	= 1
int mcmCellPauseKey	= 3
int mcmCellDebugLevel	= 5
int mcmCellExpertise	= 6
int mcmCellLoad		= 10
int mcmCellSave		= 11
int mcmCellVersion	= 22

;///////////////////////////////////////////////////////////////////////////////
// Event Handlers
/;

bool _spinlockOnUpdate = false
event OnUpdate()
	int lockTries = 0
	while _spinlockOnUpdate || !isInit
		Utility.WaitMenuMode( LockWaitTime )
		lockTries += 1
		if lockTries >= _spinlockTries
			return
		endif
	endwhile
	_spinlockOnUpdate = true
	DebugLog( "++OnUpdate()" )
	; Mods should call LTT.RegisterForSingleUpdate() so that we can check
	; them in after we've loaded.
	LDH.DumpTables( "start of on update" )
	mcmOnGameReload( mcm )
	LDH.DumpTables( "end of on update" )
	DebugLog( "--OnUpdate(); success" )
	_spinlockOnUpdate = false
endevent

;///////////////////////////////////////////////////////////////////////////////
// External Functions
/;

; Debug Levels:
; -1 = Critical errors, probably worth exiting the game...
;  0 = Errors, always print
;  1 = Warnings
;  2 = Info
;  3 = Debug
;  4 = Traces, like function call entry/exit points
; >5 = for highly iterative traces and very verbose troubleshooting
function DebugLog( string sMsg, int Level = 3, bool Verbose = false )
	bool Logged = false
	; we can't really debug until LDH is set up, otherwise we don't know the
	; debug level.
	if LDH && LDH.isInit && isInit
		int _Level = LDH.getIntProp( prop_DebugLevel )
		if _Level >= Level
			Log( "["+Level+","+_Level+"] "+sMsg )
		endif
		Logged = true
	endif
	; Print to screen
	if Verbose && LTT_verbose
		Debug.Notification( "[LTT] "+sMsg )
	endif
	; catch all in case we're in beta/alpha and don't have LDH yet to know the
	; debug level
	if LTT_debug && !Logged
		Logged = true
		Log( "[preProp] "+sMsg )
	endif	
endfunction
function Log( string sMsg )
	Debug.Trace( "[LTT] :: "+sMsg )
endfunction

string function verString()
	string ver = ""
	ver += LTT_verMajor+"."+LTT_verMinor
	if LTT_verbose
		ver += "-alpha"
	elseif LTT_debug
		ver += "-beta"
	endif
	return ver
endfunction

; Called from Player.OnSit()
function startStation(ObjectReference Station)
	DebugLog( "++startStation()" )
	int ID = LDH.getStationKeyword( Station )
	if ID < 0
		DebugLog( "setting station: KW="+LDH.getStation(station_Other) )
		LDH.setStringState( state_CraftingStation, LDH.getStation(station_Other) )
	else
		DebugLog( "setting station: ID="+ID+"; KW="+LDH.getStation(ID) )
		LDH.setStringState( state_CraftingStation, LDH.getStation(ID) )
	endif
	DebugLog( "--startStation(); success" )
endfunction

; Called from Player.OngGtUp
function stopStation(ObjectReference akFurniture)
	DebugLog( "++stopStation()" )
	LDH.setStringState( state_CraftingStation, LDH.getStation(station_None) )
	DebugLog( "--stopStation(); success" )
endfunction

function closeInCombat()
	DebugLog( "++closeInCombat()" )
	if LDH.getBoolProp( prop_Paused )
		DebugLog( "--closeInCombat(); skipping because we're paused" )
		return
	endif
	if ( LDH.getIntProp( prop_ShowMsgThreshold ) > 0 )
		(LTT_FL_msgInCombat.GetAt(GetMsgFormat()) as Message).Show()
	endif
	while (Utility.IsInMenuMode())
		Input.TapKey(15)
		Utility.WaitMenuMode(0.15)
	endwhile
	DebugLog( "--closeInCombat(); success" )
endfunction

;///////////////////////////////////////////////////////////////////////////////
// Internal functions, or called from mcm (almost parent to this)
/;

bool function CheckModCompatibility()
	bool Incompatible = false
	Log( ">>>>>>>>>>>>>>> Checking MOD Compatibility <<<<<<<<<<<<<<<" )
	Log( ">>>>>>>>>>>>>>> Ignore any errors about files not existing <<<<<<<<<<<<<<<" )
	; Check incompatible mods
	if Game.GetFormFromFile( 0xD62, "ReadingTakesTime.esp" )
		Debug.MessageBox( "$E_RTT_LOADED_INCOMPATIBLE" )
		Incompatible = true
	endif

	Log( ">>>>>>>>>>>>>>> Finished Checking MOD Compatibility <<<<<<<<<<<<<<<" )
	return Incompatible
endfunction

; Message formats are in a form list, return the index into the form list
; 0 - 1st person messages
; 1 - 3rd person messages
int function getMsgFormat()
	DebugLog( "++getMsgFormat()" )
	if LDH.getBoolProp( prop_FirstPersonMsgs )
		DebugLog( "--getMsgFormat() = 0; 1st person" )
		return 0
	endif
	DebugLog( "--getMsgFormat() = 1; 3rd person" )
	return 1
endfunction

bool function advanceTime(float hrsPassed)
	DebugLog( "++advanceTime(); hrsPassed="+hrsPassed )
	if !LDH.getBoolProp( prop_BaseActive ) || LDH.getBoolProp( prop_Paused ) || hrsPassed <= 0.0
		DebugLog( "--advanceTime(); skipping because we're !active, paused or no time passed" )
		return true
	endif
	
	hrsPassed *= ExpertiseMultiplier()
	DebugLog( "hrsPassed after ExpertiseMultiplier="+hrsPassed )
	
	bool ShowMsg = true
	float threshold = LDH.getIntProp( prop_ShowMsgThreshold ) as float
	float minsPassed = LDH.convertHrsToMins( hrsPassed )
	DebugLog( "Checking message threshold"\
	  +": threshold="+threshold \
	  +"; minsPassed="+minsPassed \
	)
	if ( minsPassed < threshold ) || threshold == 0
		ShowMsg = false
	endif
	
	float CurTime = GameHour.GetValue()
	
	; mlheur - not 100% sure why we need to take away the rounded portion
	; of current time, this was taken from the original RTT code, keeping it
	int Std = Math.Floor(CurTime)
	CurTime -= Std 
	CurTime += (hrsPassed)
	CurTime += Std
	
	int Hrs = Math.Floor(hrsPassed)
	int Mins =  Math.Floor(LDH.convertHrsToMins(hrsPassed - Hrs))
	
	DebugLog("Advancing Time" \
	  +": Hours="+Hrs \
	  +"; Minutes="+Mins \
	  +"; ShowMsg="+ShowMsg \
	)
	If ShowMsg
		(LTT_FL_msgTimePassed.GetAt(GetMsgFormat()) as Message).Show(Hrs,Mins)
	EndIf
	
	GameHour.SetValue(CurTime)
	DebugLog( "--advanceTime(); success" )
	return true
endfunction

function increaseSkill(string Skill, float Amt)
	DebugLog( "++increaseSkill()" )
	ActorValueInfo aVI = ActorValueInfo.GetActorValueInfobyName(Skill)
	aVI.AddSkillExperience(Amt)
	DebugLog( "--increaseSkill(); success" )
endfunction

float function ExpertiseMultiplier()
	DebugLog( "++ExpertiseMultiplier(): Skill="+SkillUsed )
	if !LDH.getBoolProp( prop_ExpertiseReducesTime ) || SkillUsed == ""
		DebugLog( "--ExpertiseMultiplier(); skipped" )
		return 1
	endif
	float SkillPoints = Game.GetPlayer().GetActorValue(SkillUsed)
	if (SkillPoints<0)
		SkillPoints = 0
	elseif (SkillPoints>150)
		SkillPoints = 150
	endif
	SkillUsed = ""
	DebugLog( "--ExpertiseMultiplier(); multiplier="+(100-(SkillPoints/2))/100 )
	return (100-(SkillPoints/2))/100
endfunction

;///////////////////////////////////////////////////////////////////////////////
// For performance reasons, use any excuse to exit ItemAdded/Removed or
// MenuOpened/Closed early as possible.
/;
;bool _spinlockItems = false
function ItemChanged( int ACT, form BaseItem, int Qty, ObjectReference ItemRef, ObjectReference SourceDest)
	if ( !LDH.getBoolProp( prop_BaseActive ) || UI.IsMenuOpen("Console") )
		DebugLog( "--ItemChanged(); !BaseActive || console is open" )
		return
	endif
;	int lockTries = 0
;	while _spinlockItems
;		DebugLog( "ItemChanged("+ACT+") locked; tries="+lockTries )
;		Utility.WaitMenuMode( LockWaitTime )
;		lockTries += 1
;		if lockTries >= _spinlockTries
;			DebugLog( "ItemChanged("+ACT+") skipped because it could not be handled after "+lockTries+" tries" )
;			return
;		endif
;	endwhile
;	_spinlockItems = true
;	DebugLog( "ItemChanged("+ACT+"); Got lock" )
	if ACT == act_ITEMADDED
		ItemAdded( BaseItem, Qty, ItemRef, SourceDest )
	elseif ACT == act_ITEMREMOVED
		ItemRemoved( BaseItem, Qty, ItemRef, SourceDest )
	endif
;	DebugLog( "ItemChanged("+ACT+"); Releasing lock" )
;	_spinlockItems = false
endfunction

function ItemAdded (form BaseItem, int Qty, ObjectReference ItemRef, ObjectReference Source)
	DebugLog( "++ItemAdded()" \
	  +": BaseItem="+BaseItem \
	  +": Name="+BaseItem.GetName() \
	  +"; Qty="+Qty \
	  +"; ItemRef="+ItemRef \
	  +"; Source="+Source \
	)
	float TimePassed = 0.0
	int Type = BaseItem.GetType()
	int Prefix = LDH.getFormPrefix(BaseItem)
	int modID = -1

	DebugLog( "Item"\
	  +": Type="+Type\
	  +"; Prefix="+Prefix\
	)

	if (!LDH.getBoolProp(state_IsLooting) && !LDH.getBoolProp(state_IsCrafting)) || Source 
		DebugLog( "--ItemAdded("+BaseItem.GetName()+", "+Qty+"); !isLooting && !isCrafting", 2, true )
		return
	endif

	if LDH.removeFreeItem( BaseItem )
		DebugLog( "--ItemAdded("+BaseItem.GetName()+", "+Qty+"); Had a free instance of this item in the queue", 2, true )
		return
	endif
	
	DebugLog( "adding item: "+BaseItem.GetName()+", "+Qty, 2 )
	SkillUsed = ""
	
	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	DebugLog( "starting modID="+modID )
	while modID >= 0
		DebugLog( "checking modID="+modID )
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			DebugLog( "mod="+mod \
			  +"; prefix="+LDH.getModPrefix(modID) \
			)
			if mod.isRunnable() && LDH.wantsAction( modID, act_ITEMADDED )
				TimePassed = mod.ItemAdded( BaseItem, Qty, ItemRef, Source, Type, Prefix )
				if TimePassed >= 0
					advanceTime( TimePassed )
					DebugLog( "--ItemAdded(); Handled by a mod: modID="+modID )
					return
				endif
			endif
		endif
		modID -= 1
	endwhile
	DebugLog( "--ItemAdded("+BaseItem.GetName()+", "+Qty+"); not handled", 1, true )
endfunction

function ItemRemoved(form BaseItem, int Qty, ObjectReference ItemRef, ObjectReference Destination )
	DebugLog( "++ItemRemoved()" \
	  +": BaseItem="+BaseItem \
	  +": Name="+BaseItem.GetName() \
	  +"; Qty="+Qty \
	  +"; ItemRef="+ItemRef \
	  +"; Destination="+Destination \
	)
	float TimePassed = 0.0
	int Type = BaseItem.GetType()
	int Prefix = LDH.getFormPrefix(BaseItem)
	string ItemName = BaseItem.GetName()
	int modID = -1

	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	while modID >= 0
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if mod.isRunnable() && LDH.wantsAction( modID, act_ITEMREMOVED )
				TimePassed = mod.ItemRemoved( BaseItem, Qty, ItemRef, Destination, Type, Prefix )
				if TimePassed >= 0
					advanceTime( TimePassed )
					DebugLog( "--ItemRemoved(); Handled by a mod: modID="+modID, 3 )
					return
				endif
			endif
		endif
		modID-=1
	endwhile
	DebugLog( "--ItemRemoved("+BaseItem.GetName()+", "+Qty+"); not handled", 1, true )
endfunction

event OnMenuOpen(string MenuName)
	DebugLog( "++OnMenuOpen()" \
	  +": MenuName="+MenuName \
	)
	float TimePassed = 0.0
	int modID = -1
	int menuID = LDH.getMenuID( MenuName )

	if ( !LDH.getBoolProp( prop_BaseActive ) || LDH.getBoolProp( prop_Paused ) || UI.IsMenuOpen("Console") )
		DebugLog( "--OnMenuOpen(); !BaseActive, BasePaused, or console is open" )
		return
	endif
	
	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	while modID >= 0
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if mod.isRunnable() && LDH.wantsAction( modID, act_MENUOPENED )
				TimePassed = mod.MenuOpened( menuID )
				if TimePassed >= 0.0
					advanceTime( TimePassed )
					DebugLog( "--OnMenuOpen(); Handled by a mod: modID="+modID )
					return
				endif
			endif
		endif
		modID -= 1
	endwhile
	DebugLog( "--OnMenuOpen(); Not handled by any mod, what to do?" )
endevent

event OnMenuClose(String MenuName)
	DebugLog( "++OnMenuClose()" \
	  +": MenuName="+MenuName \
	)
	float TimePassed = 0.0
	int modID = -1
	int menuID = LDH.getMenuID( MenuName )

	if ( !LDH.getBoolProp( prop_BaseActive ) || LDH.getBoolProp( prop_Paused ) || UI.IsMenuOpen("Console") )
		DebugLog( "--OnMenuClose(); !BaseActive, BasePaused, or console is open" )
		return
	endif
	
	; iterate through mods and call their instance
	modID = LDH.getLastMod()
	while modID >= 0
		LTT_ModBase mod = LDH.getMod(modID)
		if mod
			if mod.isRunnable() && LDH.wantsAction( modID, act_MENUCLOSED )
				TimePassed = mod.MenuOpened( menuID )
				if TimePassed >= 0.0
					advanceTime( TimePassed )
					DebugLog( "--OnMenuClose(); Handled by a mod: modID="+modID )
					return
				endif
			endif
		endif
		modID -= 1
	endwhile
	DebugLog( "--OnMenuClose(); Not handled by any mod, what to do?" )
endevent

;///////////////////////////////////////////////////////////////////////////////
// MCM Functions
//	These are all called from LTT_Menu.  They were put in here for easy
//	access to LDH and all the internal variables used in LTT_Base.
/;

function mcmOnConfigInit( LTT_Menu menu )
	DebugLog( "++mcmOnConfigInit()" )
	mcmOnVersionUpdate( mcm, getVersion() )
	DebugLog( "--mcmOnConfigInit(); success" )
	return
endfunction

function mcmOnVersionUpdate( LTT_Menu menu, int Version )
	DebugLog( "++mcmOnVersionUpdate()" )
	mcm = menu
	if ! LDH.isInit
		LDH._Init( Version )
	endif
	reRegisterMenus()	
	DebugLog( "--mcmOnVersionUpdate(); success" )
	return
endfunction

function mcmOnGameReload( LTT_Menu menu )
	isInit = false
	DebugLog( "++mcmOnGameReload()" )
	LDH.DumpTables( "start of on game reload" )
	LDH._Init( getVersion() )
	mcm = menu
	
	if CheckModCompatibility()
		return
	endif
	
	fiss = FISSFactory.getFISS() ; it's just a pointer so get it once, rather than each time we call save/load
	
	; Properties pertaining to the base mod, but not time passers for
	; vanilla skyrim
	int StartingDebug = 0
	if ( LTT_Debug )
		StartingDebug = 2
	elseif( LTT_Verbose )
		StartingDebug = 3
	endif
	prop_DebugLevel = LDH.addIntProp( -1, "LTT_DebugLevel", StartingDebug, "$LTT_UserDebug", "$HLP_DebugLevel", mcmCellDebugLevel, 0, 10, "" )
	prop_BaseActive = LDH.addBoolProp( -1, "LTT_BaseActive", false, "$LTT_BaseActive", "$HLP_BaseActive", mcmCellBaseActive )
	prop_FirstPersonMsgs = LDH.addBoolProp( -1, "LTT_FirstPersonMsgs", false, "$LTT_FirstPersonMsgs", "$HLP_FirstPersonMsgs", mcmCellPersonMsgs )
	prop_ShowMsgThreshold = LDH.addIntProp( -1, "LTT_ShowMsgThreshold", 10, "$LTT_ShowMsgTheshold", "$HLP_ShowMsgThreshold", mcmCellMsgThreshold, 0, maxMins, "minutes" )
	prop_Paused = LDH.addBoolProp( -1, "LTT_Paused", false, "$LTT_Paused", "$HLP_Paused", mcmCellPause )
	prop_PauseKey = LDH.addKeyProp( -1, "LTT_PauseKey", -1, "$LTT_PauseKey", "$HLP_PauseKey", mcmCellPauseKey )
	prop_ExpertiseReducesTime = LDH.addBoolProp( -1, "LTT_ExpertiseReducesTime", false, "$LTT_ExpertiseReducesTime", "$HLP_ExpertiseReducesTime", mcmCellExpertise )

	; Init states
	state_Menu = LDH.addStringState( "MenuName", LDH.getMenu( menu_None ) )
	state_IsLooting = LDH.addBoolState( "Looting" )
	state_IsCrafting = LDH.addBoolState( "Crafting" )
	state_CraftingStation = LDH.addStringState( "Crafting Station", LDH.getStation( station_None ) )
	state_IsPickpocketing = LDH.addBoolState( "Pickpocketing" )
	
	; Initialize vanilla crafting stations.  Would normally do this in LTT_Skyrim
	; but many mods may want to know which of these vanilla stations is in use
	; and they have no way to access private members of LTT_Skyrim through LTT.fns()
	LDH.addStation( station_Cookpot )
	LDH.addStation( station_Smelter )
	LDH.addStation( station_ArmorTable )
	LDH.addStation( station_Forge )
	LDH.addStation( station_Sharpening )
	LDH.addStation( station_SkyForge )
	LDH.addStation( station_TanningRack )
	LDH.addStation( station_Alchemy )
	LDH.addStation( station_Enchanting )
	
	isInit = true
	
	LDH._InitMenus()
	reloadMods( true )
	
	LDH.DumpTables( "after on game reload" )	
	DebugLog( "--mcmOnGameReload(); success" )
endfunction

bool _spinlockReloadMods = false
function reloadMods( bool forceReload = false )
	int lockTries = 0
	while _spinlockReloadMods
;;;		DebugLog( "reloadMods() locked; tries="+lockTries )
		Utility.WaitMenuMode( LockWaitTime )
		lockTries += 1
		if lockTries >= _spinlockTries
;;;			DebugLog( "reloadMods() skipped because it could not get a lock after "+lockTries+" tries" )
			return
		endif
	endwhile
	_spinlockReloadMods = true
	DebugLog( "++reloadMods()" )
	; iterate through mods and call their instance
	int i = LDH.getLastMod()
	while i >= 0
		DebugLog( "checking mod i="+i )
		LTT_ModBase mod = LDH.getMod(i)
		DebugLog( "got mod="+mod )
		if mod != none
			DebugLog( "2 got mod="+mod )

			; It's possible to get into a deadlock here if the
			; mod is doing its own OnInit at the same time.
			; That mod is trying to call LTT.RegisterForSingleUpdate() or LTT.DebugLog()
			; and is blocked while we're calling mod.isInit.get() or mod.ReInit().
			; Try to fix this by putting a utility.wait in the LTT_mod's OnInit
			; so we can finish first, then this'll get called again after
			; registering for single update.
			DebugLog( "mod="+mod \
			  +"; mod.isInit="+mod.isInit \
			  +"; mod.isLoaded="+mod.isLoaded \
			  +"; forceReload="+forceReload \
			)
			DebugLog( "3 got mod="+mod )
			mod.ReInit()
			if mod.isInit && ( !mod.isLoaded || forceReload )
				mod.isLoaded = false
				DebugLog( "calling mod.OnGameReload() for "+mod )
				mod.OnGameReload()
			endif
		else
			DebugLog( "mod == none" )
		endif
		i -= 1
	endwhile
	
	; Wait for mods to finish their loads before reloading MCM pages
	;Utility.Wait( 1.0 )
	reloadMCMPages()
		
	; Reassign Hot Keys
	DebugLog( "--reloadMods(); success" )
	_spinlockReloadMods = false
endfunction

function mcmOnPageReset( string Page )
	DebugLog( "++mcmOnPageReset() Page=\""+Page+"\"" )
	
	if Page == " "
		; This isn't really a page that's being used, so don't redraw anything.
		; ... now, how to force MCM to think it's on the last page it drew?
		return
	endif

	if (page == "")
		mcm.LoadCustomContent("LivingTakesTime/LTThome.dds",26,23)
		DebugLog( "--mcmOnPageReset(); success" )
		return
	else
		mcm.UnloadCustomContent()
	endIf
	
	mcmOID_Index = new int[128] ; max MCM cell ID's
	mcmOID_Prop = new int[128]
	mcmOID_Count = 0	
	int ID = LDH.getLastProp()
	while ID >= 0
		if Page == LDH.getPropPage(ID)
			int mcmCell = LDH.getPropMCMCell(ID)
			string Label = LDH.getPropTitle(ID)
			int Type = LDH.getPropType(ID)
			DebugLog( "mcmOnPageReset Adding Option: Label="+Label+"; Type="+Type+"; mcmCell="+mcmCell )
			mcm.SetCursorPosition( mcmCell )
			int OID = -1
			if Type < 0
				; error
			elseif Type == LDH.propType_NONE
				; also error?
			elseif Type == LDH.propType_TOGGLE
				OID = mcm.AddToggleOption( Label, LDH.getBoolProp(ID) )
			elseif Type == LDH.propType_INT
				OID = mcm.AddSliderOption( Label, LDH.getIntProp(ID), "{0} "+LDH.getPropUnits(ID) )
			elseif Type == LDH.propType_FLOAT
				OID = mcm.AddSliderOption( Label, LDH.getFloatProp(ID), "{1} "+LDH.getPropUnits(ID) )
			elseif Type == LDH.propType_TEXT
				OID = mcm.AddTextOption( Label, LDH.getStringProp(ID) )
			elseif Type == LDH.propType_KEY
				OID = mcm.AddKeyMapOption( Label, LDH.getIntProp(ID) )
			elseif Type == LDH.propType_LABEL
				OID = mcm.AddHeaderOption( Label )
			else
				Log( "Adding a property of unknown type, should never get here" )
			endif
			DebugLog( "Setting mcmOID sub["+mcmOID_Count+"] : Index to "+OID+"; Prop to "+ID )
			mcmOID_Index[mcmOID_Count] = OID
			mcmOID_Prop[mcmOID_Count] = ID
			mcmOID_Count += 1
		endif
		ID-=1
	endwhile
	
	;; I might have to hard-code the save & load buttons, and
	;; handle them as special cases.
	if Page == mcm.ModName
		mcm.SetCursorPosition( mcmCellSave )
		mcmOID_Save = mcm.AddToggleOption( "$LTT_Save", false )
		mcm.SetCursorPosition( mcmCellLoad )
		mcmOID_Load = mcm.AddToggleOption( "$LTT_Load", false )
		mcm.SetCursorPosition( mcmCellVersion )
		mcm.AddHeaderOption(  mcm.ModName+": Version "+verString() )
	else
		mcmOID_Save = -1
		mcmOID_Load = -1
	endif
	
;;	if LTT_verbose
;;		int i = 0
;;		while i < 128
;;			DebugLog( "mcmOID_Index["+i+"]="+mcmOID_Index[i] )
;;			i+=1
;;		endwhile
;;	endif
	LDH.DumpTables( "after on page reset" )
	
	DebugLog( "--mcmOnPageReset(); success" )
endfunction

int function getOID_Prop( int OID )
	int i = 0
	while ( i < mcmOID_Count )
		if mcmOID_Index[i] == OID
			return mcmOID_Prop[i]
		endif
		i+=1
	endwhile
	Log( self+" MCM Handler: Unable to find Property for OID "+OID )
	return -1
endfunction

; prop type doesn't matter, just treat all as strings.
function mcmOnOptionDefault( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionDefault() OID="+OID )
	int ID = getOID_Prop( OID )
	LDH.setPropToDefault( ID )
	int Type = LDH.getPropType( ID )
	if Type == LDH.propType_TOGGLE
		; Let the owning mod do any work associated with changing
		; this flag, like no longer wanting a menu.
		LTT_ModBase mod = LDH.getMod( LDH.getPropModID( ID ) )
		if mod
			mod.handlePropToggle( ID, LDH.getBoolProp( ID ) )		
		endif
		reRegisterMenus()
	endif
	mcm.ForcePageReset() ; this might be a little heavy-handed, is lazy.
	DebugLog( "--mcmOnOptionDefault(); success" )
endfunction

; prop type doesn't matter, just show its help text.
function mcmOnOptionHighlight( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionHighlight() OID="+OID )
	
	; Sepcial case for save/load "buttons"
	if mcm.CurrentPage == mcm.ModName && ( OID == mcmOID_Save || OID == mcmOID_Load )
		mcm.SetInfoText( "$HLP_SaveLoad" )
		DebugLog( "--mcmOnOptionSelect(); success Save/Load" )
		return
	endif
	
	; Generic handler for all other props.
	int ID = getOID_Prop( OID )
	mcm.SetInfoText( LDH.getPropHelper( ID ) )
	DebugLog( "--mcmOnOptionHighlight(); success" )
endfunction

; Toggles and Text
function mcmOnOptionSelect( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionSelect() OID="+OID )
	
	; Sepcial cases for save/load "buttons"
	if mcm.CurrentPage == mcm.ModName
		if OID == mcmOID_Save
			; Do Save
			LDH.savePropTable( fiss, LTT_saveFile )
			mcm.ForcePageReset()
			DebugLog( "--mcmOnOptionSelect(); success Save" )
			return
		elseif OID == mcmOID_Load
			; Do Load
			LDH.loadPropTable( fiss, LTT_saveFile )
			reRegisterMenus()
			mcm.ForcePageReset()
			DebugLog( "--mcmOnOptionSelect(); success Load" )
			return
		endif
	endif
	
	; Generic handler for all other props
	int ID = getOID_Prop( OID )
	int Type = LDH.getPropType( ID )
	if Type == LDH.propType_TOGGLE
		bool V = LDH.getBoolProp( ID )
		V = !V
		LDH.setBoolProp( ID, V )
		mcm.SetToggleOptionValue( OID, V )		
		; Let the owning mod do any work associated with changing
		; this flag, like no longer wanting a menu.
		LTT_ModBase mod = LDH.getMod( LDH.getPropModID( ID ) )
		if mod
			mod.handlePropToggle( ID, V )		
		endif
		reRegisterMenus()
	else ; LDH.propType_TEXT doesn't need any handlers, I don't think.
		Log( "mcm Option selected of unknown type, should never get here" )
	endif
	
	mcm.ForcePageReset() ; this might be a little heavy-handed, is lazy.
	DebugLog( "--mcmOnOptionSelect(); success" )
endfunction

; Int's and Floats
function mcmOnOptionSliderOpen( SKI_ConfigBase mcm, int OID )
	DebugLog( "++mcmOnOptionSliderOpen() OID="+OID )
	int ID = getOID_Prop( OID )
	int Type = LDH.getPropType( ID )
	float min = -1.0
	float max = -1.0
	float def = -1.0
	float step = -1.0
	float val = -1.0
	if Type == LDH.propType_INT
		val = LDH.getIntProp(ID) as float
		min = LDH.getIntPropMin(ID) as float
		max = LDH.getIntPropMax(ID) as float
		def = LDH.getIntPropDefault(ID) as float
		step = 1.0
	elseif Type == LDH.propType_FLOAT
		val = LDH.getFloatProp(ID)
		min = LDH.getFloatPropMin(ID)
		max = LDH.getFloatPropMax(ID)
		def = LDH.getFloatPropDefault(ID)
		step = 0.05
	else
		Log( "mcm Option slider of unknown type, should never get here" )
	endif
	
	mcm.SetSliderDialogStartValue( val )
	mcm.SetSliderDialogDefaultValue( def )
	mcm.SetSliderDialogRange( min, max )
	mcm.SetSliderDialogInterval( step )
	
	DebugLog( "--mcmOnOptionSliderOpen(); success" )
endfunction

; Int's and Floats
function mcmOnOptionSliderAccept( SKI_ConfigBase mcm, int OID, float val )
	DebugLog( "++mcmOnOptionSliderAccept() OID="+OID )
	int ID = getOID_Prop( OID )
	int Type = LDH.getPropType( ID )
	if Type == LDH.propType_INT
		LDH.setIntProp( ID, val as int )
	elseif Type == LDH.propType_FLOAT
		LDH.setFloatProp( ID, val )
	else
		Log( "mcm Option slider of unknown type, should never get here" )
	endif
	mcm.SetSliderOptionValue( OID, val )
	DebugLog( "--mcmOnOptionSliderAccept(); success" )
endfunction

function mcmOnOptionKeyMapChange( SKI_ConfigBase mcm, int OID, int KeyID, string Conflict, string ConflictOwner )
	DebugLog( "++mcmOnOptionKeyMapChange()"\
	  +": OID="+OID\
	  +": KeyID="+KeyID\
	  +": Conflict="+Conflict\
	  +": ConflictOwner="+ConflictOwner\
	)
	bool ReuseKey = true
	int ID = getOID_Prop( OID )
	
	if Conflict
		if ! ConflictOwner
			ConflictOwner = "Skyrim"
		endif
		ReuseKey = mcm.ShowMessage( "$E_REUSE_KEY"+" "+ConflictOwner+"::"+Conflict, true )
	endif
	
	if !ReuseKey
		DebugLog( "--mcmOnOptionKeyMapChange(); not reusing key" )
		return
	endif
	
	LDH.setIntProp( ID, KeyID )
	
	mcm.RegisterForKey( KeyID )
	mcm.ForcePageReset() ; this might be a little heavy-handed, is lazy.
	DebugLog( "--mcmOnOptionKeyMapChange(); success" )
endfunction

function mcmOnKeyUp( int KeyID, float Duration ) ; might not belong to base, check it out...
	DebugLog( "++mcmOnKeyUp() KeyID="+KeyID )
	if ( UI.IsMenuOpen( "Console" ) || Utility.IsInMenuMode() || Game.GetPlayer().GetSitState() != 0 )
		DebugLog( "--mcmOnKeyUp(); Ignoring key during menu and crafting" )
		return
	endif
	
	; All I know is the key pressed, I need to look up
	; which mod wants to know when that key was pressed and pass
	; them the event.
	; Do I run through all props looking those that have the key where propType == KEY
	int modID = -1
	int _ID = LDH.getLastProp()
	int ID = -1
	while _ID >= 0
		if LDH.getPropType(_ID) == LDH.propType_KEY
			if LDH.getIntProp(_ID) == KeyID
				modID = LDH.getPropModID(_ID)
				ID = _ID
			endif
		endif
		_ID-=1
	endwhile
	; ID is set to the mod's prop ID for the thing watching the key.
	
	if modID >= 0
		; Pass the event on to the mod.
		LTT_ModBase mod = LDH.getMod( modID )
		mod.OnKeyUp( KeyID, Duration )
	else
		; LTT_Base is the mod, probably the pause key was pressed.
		if ID == prop_PauseKey
			; toggle pause state.
			DebugLog( "Changing pause status", 1, true )
			LDH.setBoolProp( prop_Paused, !LDH.getBoolProp( prop_Paused ) )
		else
			; No Mod wanted this key, and neither do we, stop watching it.
			mcm.UnregisterForKey( KeyID )
		endif
	endif
	
	DebugLog( "--mcmOnKeyUp(); success" )
endfunction

function reloadMCMPages()
	DebugLog( "++reloadMCMPages()" )
	int i
	int p
	
	; Stupid hack because papyrus doesn't let me create a variable number
	; of pages based on how many mods are loaded, and these will all show
	; up OnPageReset as "", so I'm using " " as a 'false' page.
	mcm.Pages = new string[33]		; _maxMods + 1
	i = LDH.getMaxMods()+1
	while i >= 1
		i-=1
		mcm.Pages[i] = " "
	endwhile
	mcm.Pages[0] = mcm.ModName
	
	; iterate through mods and call their instance
	i = LDH.getLastMod()
	p = 1
	DebugLog( "Iterating through mods adding pages to MCM" )
	while i >= 0
		LTT_ModBase mod = LDH.getMod(i)
		if mod
			if mod.isLoaded
				mcm.Pages[p] = LDH.getModName(i)
				DebugLog( "Adding mod page: p="+p+"; i="+i+"; mod="+mcm.Pages[p] )
				p+=1
			endif
		endif
		i-=1
	endwhile
	DebugLog( "--reloadMCMPages(); success" )
endfunction

function reRegisterMenus()
	DebugLog( "++reRegisterMenus()" )
	UnregisterForAllMenus()
	int MenusWanted = 0
	; Iterate through all mods collecting which ones want menus
	int ID = LDH.getLastMod()
	while ID >= 0
		MenusWanted = Math.LogicalOr( MenusWanted, LDH.getModMenus( ID ) )
		ID-=1
	endwhile
	
	; Register whichever menus were called for
	ID = LDH.getLastMenu()
	while ID >= 1
		if Math.LogicalAnd( MenusWanted, Math.LeftShift( 1, (ID - 1) ) )
			DebugLog( "Want menu ID="+ID )
			RegisterForMenu( LDH.getMenu( ID ) )
		endif
		ID -= 1
	endwhile
	DebugLog( "--reRegisterMenus(); success" )
endfunction
