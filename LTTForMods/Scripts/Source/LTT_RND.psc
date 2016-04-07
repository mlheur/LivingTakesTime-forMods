scriptname LTT_RND extends LTT_ModBase 

int	fID_Bedroll		= 0x0177CD

int prop_WaterskinHrs	= -1
int prop_CookpotHrs	= -1
int prop_TinderboxHrs	= -1
int prop_TentHrs	= -1
int prop_MilkBucketMins	= -1
int prop_EatSnackMult	= -1
int prop_EatMediumMins	= -1
int prop_EatFillingMult	= -1
int prop_EatDrinkMins	= -1
int prop_CookSnackMult	= -1
int prop_CookMediumMult	= -1
int prop_CookFillingMult	= -1
int prop_CookWaterMult	= -1
int prop_CookSaltMult	= -1

int stat_FoodEaten	= -1

form	Waterskin
form	Cookpot
form	Tinderbox
form	Bedroll
form	Tent
form	MilkBucket
form[]	Water
form[]	Salt
MagicEffect[]	mgefDrinks
MagicEffect	mgefSnack
MagicEffect	mgefMedium
MagicEffect	mgefFilling
MagicEffect	mgefCandy
MagicEffect	mgefFruit
MagicEffect[]	mgefFoods

event OnInit()
	ESP = "RealisticNeedsandDiseases.esp"
	TestForm = fID_Bedroll
	parent.OnInit()
endevent

event OnGameReload()
	LTT = LTT_Factory.LTT_getBase() ; not normally required, but handy if LTT changes between saves
	DebugLog( "++OnGameReload()" )
	isLoaded = false
	RegisterActs = LTT.LDH.act_ITEMADDED;
	RegisterActs = Math.LogicalOr( RegisterActs, LTT.LDH.act_ITEMREMOVED )
	RegisterActs = Math.LogicalOr( RegisterActs, LTT.LDH.act_MENUOPENED )
	RegisterMenus = LTT.LDH.menu_None
	modID = LTT.LDH.addMod( self, ModName, ESP, TestForm, RegisterActs, RegisterMenus )
	if modID < 0 ; We couldn't be added to the Mod table.
		DebugLog( "--OnGameReload(); unable to successfully addMod()" )
		return
	endif

	prop_WaterskinHrs = LTT.LDH.addFloatProp( modID, "RND_WaterskinHrs", 1.0, "$RND_WaterskinHrs", "$HLP_RND_WaterskinHrs", 2, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_CookpotHrs = LTT.LDH.addFloatProp( modID, "RND_CookpotHrs", LTT.craftMiscHrs, "$RND_CookpotHrs", "$HLP_RND_CookpotHrs", 4, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_MilkBucketMins = LTT.LDH.addIntProp( modID, "RND_MilkBucketMins", 15, "$RND_MilkBucketMins", "$HLP_RND_MilkBucketMins", 6, 0, LTT.LDH.maxMins, "minutes" )

	prop_TinderboxHrs = LTT.LDH.addFloatProp( modID, "RND_TinderboxHrs", LTT.craftMiscHrs, "$RND_TinderboxHrs", "$HLP_RND_TinderboxHrs", 3, 0.0, LTT.LDH.maxHrs, "hours" )
	prop_TentHrs = LTT.LDH.addFloatProp( modID, "RND_TentHrs", 4.0, "$RND_TentHrs", "$HLP_RND_TentHrs", 5, 0.0, LTT.LDH.maxHrs, "hours" )

	prop_EatSnackMult = LTT.LDH.addFloatProp( modID, "RND_EatSnackMult", (1/3), "$RND_EatSnackMults", "$HLP_RND_EatSnackMult", 11, 0, LTT.LDH.maxMins, "multiplier" )
	prop_EatMediumMins = LTT.LDH.addIntProp( modID, "RND_EatMediumMins", LTT.eatFoodMins, "$RND_EatMediumMins", "$HLP_RND_EatMediumMins", 13, 0, LTT.LDH.maxMins, "minutes" )
	prop_EatFillingMult = LTT.LDH.addFloatProp( modID, "RND_EatFillingMult", 3.0, "$RND_EatFillingMult", "$HLP_RND_EatFillingMult", 15, 0, LTT.LDH.maxMins, "multiplier" )
	prop_EatDrinkMins = LTT.LDH.addIntProp( modID, "RND_EatDrinkMins", LTT.eatFoodMins / 6, "$RND_EatDrinkMins", "$HLP_RND_EatDrinkMins", 17, 0, LTT.LDH.maxMins, "minutes" )

	prop_CookSnackMult = LTT.LDH.addFloatProp( modID, "RND_CookSnackMult", 0.5, "$RND_CookSnackMult", "$HLP_RND_CookSnackMult", 10, 0, LTT.LDH.maxMult, "multiplier" )
	prop_CookMediumMult = LTT.LDH.addFloatProp( modID, "RND_CookMediumMult", 1.0, "$RND_CookMediumMult", "$HLP_RND_CookMediumMult", 12, 0, LTT.LDH.maxMult, "multiplier" )
	prop_CookFillingMult = LTT.LDH.addFloatProp( modID, "RND_CookFillingMult", 1.5, "$RND_CookFillingMult", "$HLP_RND_CookFillingMult", 14, 0, LTT.LDH.maxMult, "multiplier" )
	prop_CookWaterMult = LTT.LDH.addFloatProp( modID, "RND_CookWaterMult", (2/3), "$RND_CookWaterMult", "$HLP_RND_CookWaterMult", 16, 0, LTT.LDH.maxMult, "multiplier" )
	prop_CookSaltMult = LTT.LDH.addFloatProp( modID, "RND_CookSaltMult", 3.0, "$RND_CookSaltMult", "$HLP_RND_CookSaltMult", 18, 0, LTT.LDH.maxMult, "multiplier" )
	
	stat_FoodEaten = LTT.LDH.addStat( "Food Eaten" )

	isLoaded = Load()
	DebugLog( "--OnGameReload(); success" )
endevent

bool function Load()
	DebugLog( "++Load()" )
	Cookpot		= Game.GetForm(0x318FB) ; "Cast Iron Pot" [MISC:000318FB]
	Waterskin	= Game.GetFormFromFile(0x46497, ESP) ; "Waterskin" [ALCH:03046497]
	Tinderbox	= Game.GetFormFromFile(0x3067C, ESP) ; "Tinderbox" [MISC:0303067C]
	Bedroll		= Game.GetFormFromFile(0x177CD, ESP) ; RND_PortableBedroll "Traveller's Bedroll" [MISC:060177CD]
	Tent		= Game.GetFormFromFile(0x31144, ESP) ; "Traveller's Tent" [MISC:03031144]
	MilkBucket	= Game.GetFormFromFile(0xB1CE9, ESP) ; "Milk Bucket" [MISC:030B1CE9]

	Water = new Form[11]
	Water[0]	= Game.GetFormFromFile(0x5968, ESP) ; "Water" [ALCH:03005968]
	Water[1]	= Game.GetFormFromFile(0x53EC, ESP) ; "Boiled Water" [ALCH:030053EC]
	Water[2]	= Game.GetFormFromFile(0x53EE, ESP) ; "Boiled Water" [ALCH:030053EE]
	Water[3]	= Game.GetFormFromFile(0x53F0, ESP) ; "Boiled Water" [ALCH:030053F0]
	Water[4]	= Game.GetFormFromFile(0xFBA0, ESP) ; "Boiled Water" [ALCH:0300FBA0]
	Water[5]	= Game.GetFormFromFile(0xFB99, ESP) ; "Boiled Water" [ALCH:0300FB99]
	Water[6]	= Game.GetFormFromFile(0xFB9B, ESP) ; "Boiled Water" [ALCH:0300FB9B]
	Water[7]	= Game.GetFormFromFile(0x47F94, ESP) ; "Waterskin(Boiled Water): Full" [ALCH:03047F94]
	Water[8]	= Game.GetFormFromFile(0x47F96, ESP) ; "Waterskin(Boiled Water): 3/4" [ALCH:03047F96]
	Water[9]	= Game.GetFormFromFile(0x47F9A, ESP) ; "Waterskin(Boiled Water): 2/4" [ALCH:03047F9A]
	Water[10]	= Game.GetFormFromFile(0x47F98, ESP) ; "Waterskin(Boiled Water): 1/4" [ALCH:03047F98]

	Salt = new Form[4]
	Salt[0]	= Game.GetFormFromFile(0x68A32, ESP) ; "Salt Pile" [MISC:03068A32]
	Salt[1]	= Game.GetFormFromFile(0x68A33, ESP) ; "Salt Pile" [MISC:03068A33]
	Salt[2]	= Game.GetFormFromFile(0x68A34, ESP) ; "Salt Pile" [MISC:03068A34]
	Salt[3]	= Game.GetFormFromFile(0x69FC1, ESP) ; "Salt Pile" [MISC:03069FC1]

	mgefDrinks = new MagicEffect[6]
	mgefDrinks[0]	= Game.GetFormFromFile(0x6437, ESP) as MagicEffect ; "Small Bottle" [MGEF:02006437]
	mgefDrinks[1]	= Game.GetFormFromFile(0x1114F, ESP) as MagicEffect ; "Medium Bottle" [MGEF:0201114F]
	mgefDrinks[2]	= Game.GetFormFromFile(0x11150, ESP) as MagicEffect ; "Large Bottle" [MGEF:02011150]
	mgefDrinks[3]	= Game.GetFormFromFile(0xFB9F, ESP) as MagicEffect ; "Decrease Thirst" [MGEF:0200FB9F]
	mgefDrinks[4]	= Game.GetFormFromFile(0x6442A, ESP) as MagicEffect ; "Seawater" [MGEF:0206442A]
	mgefDrinks[5]	= Game.GetFormFromFile(0x1BDD6, ESP) as MagicEffect ; "Skooma" [MGEF:0201BDD6]

	mgefSnack	= Game.GetFormFromFile(0x3375, ESP) as MagicEffect ; "Snack" [MGEF:02003375]
	mgefMedium	= Game.GetFormFromFile(0x4919, ESP) as MagicEffect ; "Medium Meal" [MGEF:02004919]
	mgefFilling	= Game.GetFormFromFile(0x4918, ESP) as MagicEffect ; "Filling Meal" [MGEF:02004918]
	mgefCandy	= Game.GetFormFromFile(0x3E4D, ESP) as MagicEffect ; "Sweet Candy" [MGEF:02003E4D]
	mgefFruit	= Game.GetFormFromFile(0x1114D, ESP) as MagicEffect ; "Fresh Fruit" [MGEF:0201114D]

	mgefFoods = new MagicEffect[5]
	mgefFoods[0]		= mgefSnack
	mgefFoods[1]		= mgefMedium
	mgefFoods[2]		= mgefFilling
	mgefFoods[3]		= mgefCandy
	mgefFoods[4]		= mgefFruit

	if !Cookpot || !Waterskin || !Tinderbox || !Bedroll || !Tent || !MilkBucket
		DebugLog( "--Load(); failed on items" )
		return false
	endif
	int i = 10
	while i >= 0
		if !Water[i]
			DebugLog( "--Load(); failed on Water["+i+"]" )
			return false
		endif
		i -= 1
	endwhile
	i = 3
	while i >= 0
		if !mgefDrinks[i]
			DebugLog( "--Load(); failed on mgefDrinks["+i+"]" )
			return false
		endif
		i -= 1
	endwhile
	i = 5
	while i >= 0
		if !Salt[i]
			DebugLog( "--Load(); failed on Salt["+i+"]" )
			return false
		endif
		i -= 1
	endwhile
	i = 4
	while i >= 0
		if !mgefFoods[i]
			DebugLog( "--Load(); failed on mgefFoods["+i+"]" )
			return false
		endif
		i -= 1
	endwhile

	DebugLog( "--Load(); success" )
	return true
endfunction

float function MenuOpened( int MenuID )
	DebugLog( "++MenuOpened() starting food eaten" )
	LTT.LDH.startStat( stat_FoodEaten )
	DebugLog( "--MenuOpened()=-1.0" )
	return -1.0
endfunction

float function EatFood( int i )
	DebugLog( "++EatFood()" )
	float t = 0.0
	if mgefFoods[i] == mgefSnack
		DebugLog( "eaten snack!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_EatMediumMins ) ) * LTT.LDH.getFloatProp( prop_EatSnackMult )

	elseif mgefFoods[i] == mgefMedium
		DebugLog( "eaten medium!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_EatMediumMins ) )

	elseif mgefFoods[i] == mgefFilling
		DebugLog( "eaten filling!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_EatMediumMins ) ) * LTT.LDH.getFloatProp( prop_EatFillingMult )

	endif
	DebugLog( "--EatFood(); t="+t )
	return t
endfunction

float function EatDrink( int i )
	DebugLog( "++AddDrink()" )
	float t = 0.0
;	mgefDrinks[0]	= Game.GetFormFromFile(0x6437, ESP) as MagicEffect ; "Small Bottle" [MGEF:02006437]
;	mgefDrinks[1]	= Game.GetFormFromFile(0x1114F, ESP) as MagicEffect ; "Medium Bottle" [MGEF:0201114F]
;	mgefDrinks[2]	= Game.GetFormFromFile(0x11150, ESP) as MagicEffect ; "Large Bottle" [MGEF:02011150]
;	mgefDrinks[3]	= Game.GetFormFromFile(0xFB9F, ESP) as MagicEffect ; "Decrease Thirst" [MGEF:0200FB9F]
;	mgefDrinks[4]	= Game.GetFormFromFile(0x6442A, ESP) as MagicEffect ; "Seawater" [MGEF:0206442A]
;	mgefDrinks[5]	= Game.GetFormFromFile(0x1BDD6, ESP) as MagicEffect ; "Skooma" [MGEF:0201BDD6]
;	prop_CookWaterMins = LTT.LDH.addIntProp( modID, "RND_CookWaterMins", LTT.craftFoodMins / 6, "$RND_CookWaterMins", "$HLP_RND_CookWaterMins", mcmCellCookWater, 0, LTT.LDH.maxMins, "minutes" )
;	prop_CookDrinkMins = LTT.LDH.addIntProp( modID, "RND_CookDrinkMins", LTT.craftFoodMins / 6, "$RND_CookDrinkMins", "$HLP_RND_CookDrinkMins", mcmCellCookDrink, 0, LTT.LDH.maxMins, "minutes" )

; TODO test food sizes, especially soups (medium bottles), ales & fruits (small bottles), 

	if i == 0 ; small bottle
		DebugLog( "small bottle!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_EatDrinkMins ) )

	elseif i == 1 ; medium bottle
		DebugLog( "medium bottle!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_EatDrinkMins ) ) * 2

	elseif i == 2 ; large bottle
		DebugLog( "large bottle!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_EatDrinkMins ) ) * 3

	elseif i == 5 ; skooma
		DebugLog( "skooma!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_EatDrinkMins ) ) * 100

	endif
	DebugLog( "--AddDrink(); t="+t )
	return t
endfunction

float function ItemRemoved( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemRemoved()" )
	float t = -1.0

	if Type == LTT.LDH.kPotion
		LTT.LDH.DumpTables( "Checking before if food was eaten" )
		int QtyEaten = LTT.LDH.endStat( stat_FoodEaten )
		DebugLog( "QtyEaten="+QtyEaten+"; Qty="+Qty )
		if QtyEaten > 0
			; TODO need to check if Qty and/or QtyEaten are both used when looting & eating many items.
			MagicEffect eff = CheckFoodEffect( BaseItem as Potion )
			DebugLog( "Food?" )
			int i = mgefFoods.Find( eff )
			if i >= 0
				t = EatFood( i ) * QtyEaten
			else
				DebugLog( "No" )
			endif
			DebugLog( "Drink?" )
			i = mgefDrinks.Find( eff )
			if i >= 0
				t = EatDrink( i ) * QtyEaten
			else
				DebugLog( "No" )
			endif
		endif
		LTT.LDH.DumpTables( "Checking after if food was eaten" )
	endif

	DebugLog( "--ItemRemoved(); t="+t )
	return t
endfunction

float function ItemAdded( form BaseItem, int Qty, form ItemRef, form Container, int Type, int Prefix )
	DebugLog( "++ItemAdded()" )
	float t = -1.0
	int i = -1
	
	
	; Check for drinks before non-RND items.
	if Type == LTT.LDH.kPotion && LTT.LDH.getStringState( LTT.LDH.state_CraftingStation ) == LTT.station_Cookpot
		DebugLog( "Is potion and am using cookpot" )
		
		if Water.Find( BaseItem ) >= 0 ; Check for water before drinks
			t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftDrinkMins ) ) * LTT.LDH.getFloatProp( prop_CookWaterMult ) * Qty
			DebugLog( "Boiled water: t="+t )
			
		elseif (BaseItem as Potion).isFood()
			MagicEffect eff = CheckFoodEffect( BaseItem as Potion )
			; this could be an attempt to cook food, or else
			; an attempt to eat larger food and gain a smaller one
			; although if eaten it should be removed as a free item
			; before getting here.
			DebugLog( "Cooked food?" )
			i = mgefFoods.Find( eff )
			if i >= 0
				t = AddFood( i ) * Qty
			else
				DebugLog( "No" )
			endif
			DebugLog( "Cooked drink?" )
			i = mgefDrinks.Find( eff )
			if i >= 0
				t = AddDrink( i ) * Qty
			else
				DebugLog( "No" )
			endif
		endif
	
	elseif Prefix != LTT.LDH.getModPrefix( modID ) && BaseItem != Cookpot
		DebugLog( "--ItemAdded() t="+t+"; not our item" )
		return t
	
	elseif Salt.Find( BaseItem ) >= 0
			t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftDrinkMins ) ) * LTT.LDH.getFloatProp( prop_CookSaltMult ) * Qty
		DebugLog( "Distilled salt: t="+t )
	
	elseif BaseItem == MilkBucket
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( prop_MilkBucketMins ) ) * Qty
		DebugLog( "Milk Bucket: t="+t )
	
	elseif BaseItem == Tinderbox
		t = LTT.LDH.getFloatProp( prop_TinderboxHrs ) * Qty
		DebugLog( "Tinderbox: t="+t )
	
	elseif BaseItem == Cookpot
		t = LTT.LDH.getFloatProp( prop_CookpotHrs ) * Qty
		DebugLog( "Cookpot: t="+t )
	
	elseif BaseItem == Bedroll
		t = LTT.LDH.getFloatProp( LTT.Skyrim.prop_CraftBeddingHrs ) * Qty
		DebugLog( "Bedroll: t="+t )
	
	elseif BaseItem == Tent
		t = LTT.LDH.getFloatProp( prop_TentHrs ) * Qty
		DebugLog( "Tent: t="+t )
	
	elseif BaseItem == Waterskin
		;if LTT.LDH.getStringState( LDH.state_CraftingStation )
		if LTT.LDH.getBoolState( LTT.LDH.state_IsCrafting )
			t = LTT.LDH.getFloatProp( prop_WaterskinHrs ) * Qty
			DebugLog( "Crafted waterskin: t="+t )
		else
			t = 0.0
			DebugLog( "Filled waterskin" )
		endif
	
	elseif Type == LTT.LDH.kMisc
		t = 0.0
		DebugLog( "Unknown misc item, but it belongs to RND" )
		
	endif
	DebugLog( "--ItemAdded(); t="+t )
	return t
endfunction

float function AddFood( int i )
	DebugLog( "++AddFood()" )
	float t = 0.0
	if mgefFoods[i] == mgefSnack
		DebugLog( "cooked snack!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_EatMins ) ) * LTT.LDH.getFloatProp( prop_CookSnackMult )

	elseif mgefFoods[i] == mgefMedium
		DebugLog( "cooked medium!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_EatMins ) ) * LTT.LDH.getFloatProp( prop_CookMediumMult )

	elseif mgefFoods[i] == mgefFilling
		DebugLog( "cooked filling!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_EatMins ) ) * LTT.LDH.getFloatProp( prop_CookFillingMult )

	endif
	DebugLog( "--AddFood(); t="+t )
	return t
endfunction

float function AddDrink( int i )
	DebugLog( "++AddDrink()" )
	float t = 0.0
;	mgefDrinks[3]	= Game.GetFormFromFile(0xFB9F, ESP) as MagicEffect ; "Decrease Thirst" [MGEF:0200FB9F]
;	mgefDrinks[4]	= Game.GetFormFromFile(0x6442A, ESP) as MagicEffect ; "Seawater" [MGEF:0206442A]
;	prop_CookWaterMins = LTT.LDH.addIntProp( modID, "RND_CookWaterMins", LTT.craftFoodMins / 6, "$RND_CookWaterMins", "$HLP_RND_CookWaterMins", mcmCellCookWater, 0, LTT.LDH.maxMins, "minutes" )
;	prop_CookDrinkMins = LTT.LDH.addIntProp( modID, "RND_CookDrinkMins", LTT.craftFoodMins / 6, "$RND_CookDrinkMins", "$HLP_RND_CookDrinkMins", mcmCellCookDrink, 0, LTT.LDH.maxMins, "minutes" )
	if i == 0 ; small bottle
		DebugLog( "small bottle!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftDrinkMins ) ) * LTT.LDH.getFloatProp( prop_CookWaterMult )

	elseif i == 1 ; medium bottle
		DebugLog( "medium bottle!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftDrinkMins ) ) * LTT.LDH.getFloatProp( prop_CookWaterMult ) * 2.0

	elseif i == 2 ; large bottle
		DebugLog( "large bottle!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftDrinkMins ) ) * LTT.LDH.getFloatProp( prop_CookWaterMult ) * 3.0

	elseif i == 5 ; skooma
		DebugLog( "skooma!" )
		t = LTT.LDH.convertMinsToHrs( LTT.LDH.getIntProp( LTT.Skyrim.prop_CraftDrinkMins ) ) * LTT.LDH.getFloatProp( prop_CookWaterMult ) * 100.0

	endif
	DebugLog( "--AddDrink(); t="+t )
	return t
endfunction

MagicEffect function CheckFoodEffect(Potion akFood)
	DebugLog( "++CheckFoodEffect()" )
	int n = akFood.GetNumEffects()
	MagicEffect eff
	MagicEffect result = None
	while n
		n -= 1
		eff = akFood.GetNthEffectMagicEffect(n)
		DebugLog( "testing nth effect: n="+n+"; eff="+eff )
		; Food effects need to take precedence, for soups.
		if mgefFoods.Find(eff) > -1 || (result == none && mgefDrinks.Find(eff) > -1)
			result = eff
		endif
	endwhile
	DebugLog( "--CheckFoodEffect(); result="+result )
	Return result
endfunction

