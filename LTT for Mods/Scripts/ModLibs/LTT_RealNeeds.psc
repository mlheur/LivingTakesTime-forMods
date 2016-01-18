scriptname LTT_RealNeeds extends LTT_ModBase 

string	LTT_Name		= "Real Needs & Diseases" AutoReadOnly
string	LTT_ESP			= "RealisticNeedsandDiseases.esp" AutoReadonly
int	fID_Bedroll		= 0x0177CD

;;;;;;;;;;;;;;;;;;;;
; Real Needs
float	RND_CraftWaterskinHrs	= 1.0
float	RND_CraftPotHrs		= FF_CraftPotHrs
float	RND_CraftTinderboxHrs	= 1.0
float	RND_CraftBedrollMins	= CF_CraftBeddingHrs
float	RND_CraftTentMins	= FF_CraftSmTentHrs
float	RND_CraftMilkBucketMins	= 5.0
float	RND_EatSnackMins	= LTT_EatMins * 0.5
float	RND_EatMediumMins	= LTT_EatMins * 2.0
float	RND_EatFillingMins	= LTT_EatMins * 3.0
float	RND_EatDrinkMins	= RND_EatSnackMins
float	RND_CookSnackMins	= RND_EatSnackMins * 3.0
float	RND_CookMediumMins	= RND_EatMediumMins * 3.0
float	RND_CookFillingMins	= RND_EatFillingMins * 3.0
float	RND_CookWaterMins	= 5.0
float	RND_CookDrinkMins	= RND_CookWaterMins * 3.0
float	RND_CraftSaltMins	= RND_CookWaterMins

;;;;;;;;;;;;;;;;;;;;
; Real Needs
form	RND_FormWaterskin
form	RND_FormCookpot
form	RND_FormTinderbox
form	RND_FormBedroll
form	RND_FormTent
form	RND_FormMilkBucket
form[]	RND_FormWater
form[]	RND_FormSalt
form[]	RND_MgefDrinks
form	RND_MgefFoodSnack
form	RND_MgefFoodMedium
form	RND_MgefFoodFilling
form	RND_MgefFoodCandy
form	RND_MgefFoodFruit
form[]	RND_MgefFoods

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

	RN_MgefDrinks = new MagicEffect[6]
	RN_MgefDrinks[0]			= Game.GetFormFromFile(0x006437, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Small Bottle" [MGEF:02006437]
	RN_MgefDrinks[1]			= Game.GetFormFromFile(0x01114F, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Medium Bottle" [MGEF:0201114F]
	RN_MgefDrinks[2]			= Game.GetFormFromFile(0x011150, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Large Bottle" [MGEF:02011150]
	RN_MgefDrinks[3]			= Game.GetFormFromFile(0x00FB9F, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Decrease Thirst" [MGEF:0200FB9F]
	RN_MgefDrinks[4]			= Game.GetFormFromFile(0x06442A, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Seawater" [MGEF:0206442A]
	RN_MgefDrinks[5]			= Game.GetFormFromFile(0x01BDD6, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Skooma" [MGEF:0201BDD6]

	RN_MgefFood_Snack			= Game.GetFormFromFile(0x003375, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Snack" [MGEF:02003375]
	RN_MgefFood_Medium			= Game.GetFormFromFile(0x004919, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Medium Meal" [MGEF:02004919]
	RN_MgefFood_Filling		= Game.GetFormFromFile(0x004918, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Filling Meal" [MGEF:02004918]
	RN_MgefFood_Candy			= Game.GetFormFromFile(0x003E4D, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Sweet Candy" [MGEF:02003E4D]
	RN_MgefFood_Fruit			= Game.GetFormFromFile(0x01114D, "RealisticNeedsandDiseases.esp") as MagicEffect ; "Fresh Fruit" [MGEF:0201114D]

	RN_MgefFoods = new MagicEffect[5]
	RN_MgefFoods[0]			= RN_MgefFood_Snack
	RN_MgefFoods[1]			= RN_MgefFood_Medium
	RN_MgefFoods[2]			= RN_MgefFood_Filling
	RN_MgefFoods[3]			= RN_MgefFood_Candy
	RN_MgefFoods[4]			= RN_MgefFood_Fruit

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
		If RN_MgefFoods.Find(eff) > -1 || (result == none && RN_MgefDrinks.Find(eff) > -1)
			result = eff
		EndIf
	EndWhile

	If result
		DebugMode("Check_RN_FoodEffect found " + result)
	EndIf

	Return result

EndFunction

