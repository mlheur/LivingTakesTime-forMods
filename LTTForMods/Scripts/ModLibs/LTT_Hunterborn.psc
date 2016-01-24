scriptname LTT_Hunterborn extends LTT_ModBase 

string	property LTT_Name	= "Hunterborn" AutoReadOnly
string	property LTT_ESP	= "Hunterborn.esp" AutoReadonly
int	fID_BitsOfBone		= 0x006953

;;;;;;;;;;;;;;;;;;;;
; Hunterborn
float	HB_ScrimBitsMins	= 5.0
float	HB_ScrimIdolHrs		= 2.0
float	HB_ScrimToolHrs		= LTT_CraftDaggerHrs
float	HB_CraftLeatherMins	= LTT_CraftBodyHrs * 0.2
float	HB_CraftStripMins	= FF_CraftLaceMins
float	HB_CraftBedrollHrs	= CF_CraftBeddingHrs
float	HB_CraftTallowMins	= 10.0
float	HB_CraftIngrMins	= 30.0
float	HB_CookDrinkMins	= RND_CookWaterMins * 3.0
float	HB_CraftAmmoHrs		= LTT_CraftAmmoHrs

;;;;;;;;;;;;;;;;;;;;
; Hunterborn
form[]	HB_FormVanilla
form	HB_FormLeather
form	HB_FormLeatherStrips
form	HB_FormScrimBits
form[]	HB_FormScrimIdols
form	HB_FormCacheMarker
form[]	HB_FormScrimTools
form	HB_FormBedroll
form	HB_FormTallow
form[]	HB_FormLures
form	HB_GlobSkinRank
form	HB_GlobHarvestRank

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

