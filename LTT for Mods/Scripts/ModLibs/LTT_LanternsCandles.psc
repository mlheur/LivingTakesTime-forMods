scriptname LTT_Campfire extends LTT_ModBase 

string	property LTT_Name	= "Lanterns & Candles" AutoReadOnly
string	property LTT_ESP	= "Chesko_WearableLantern.esm" AutoReadonly
int	fID_TravelLantern	= 0x0012C9

;;;;;;;;;;;;;;;;;;;;
; Lanterns and Candles
float	LC_BasicTMins		= 10.0
float	LC_ForgeHrs		= 3.0
float	LC_ArcaneHrs		= 6.0
float	LC_BrewMins		= 15.0

;;;;;;;;;;;;;;;;;;;;
; Lanterns and Candles
form[]	LC_FormBasic
form[]	LC_FormArcane
form	LC_FormCandle

Function Init_LC_Items()

	LC_Items_Candle = Game.GetFormFromFile(0x00234E, "lanterns.esp")
	LC_Prefix = GetFormPrefix(LC_Items_Candle)
	_is_LC_Active = LC_Prefix > 0
	DebugMode("LC prefix: " + LC_Prefix)

	If !_is_LC_Active
		Return
	EndIf

	LC_Items_Basic = new Form[7]
	LC_Items_Basic[0]			= Game.GetFormFromFile(0x0028CC, "lanterns.esp") ; Wine Bottles...
	LC_Items_Basic[1]			= Game.GetFormFromFile(0x0028C7, "lanterns.esp")
	LC_Items_Basic[2]			= Game.GetFormFromFile(0x0028C2, "lanterns.esp")
	LC_Items_Basic[3]			= Game.GetFormFromFile(0x0028B8, "lanterns.esp")
	LC_Items_Basic[4]			= Game.GetFormFromFile(0x001863, "lanterns.esp") ; "Glazed Candle" [MISC:01001863]
	LC_Items_Basic[5]			= Game.GetFormFromFile(0x001868, "lanterns.esp") ; "Glazed Candle" [MISC:01001868]
	LC_Items_Basic[6]			= Game.GetFormFromFile(0x000D72, "lanterns.esp") ; "Lantern" [MISC:01000D72]

	LC_Items_Arcane = new Form[2]
	LC_Items_Arcane[0]			= Game.GetFormFromFile(0x0043C4, "lanterns.esp") ; Bottle Wizard's Lamps
	LC_Items_Arcane[1]			= Game.GetFormFromFile(0x0038F7, "lanterns.esp")

EndFunction

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
