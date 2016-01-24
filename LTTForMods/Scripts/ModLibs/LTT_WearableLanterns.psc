scriptname LTT_WearableLanterns extends LTT_ModBase 

string	property LTT_Name	= "Wearable Lanterns" AutoReadOnly
string	property LTT_ESP	= "lanterns.esm" AutoReadonly
int	fID_Candle		= 0x00234E

;;;;;;;;;;;;;;;;;;;;
; Wearable Lanterns
float	WL_CraftWearableMins	= 30.0
float	WL_CraftChassisHrs	= 2.0
float	WL_CraftOilMins		= 30.0

;;;;;;;;;;;;;;;;;;;;
; Wearable Lanterns
form	WL_FormWearable
form	WL_FormChassis
form	WL_FormOil

Function Init_WL_Items()

	WL_Items_Wearable = Game.GetFormFromFile(0x0012C9, "Chesko_WearableLantern.esp")
	WL_Prefix = GetFormPrefix(WL_Items_Wearable)
	_is_WL_Active = WL_Prefix > 0
	DebugMode("WL prefix: " + WL_Prefix)

	If !_is_WL_Active
		Return
	EndIf

	WL_Items_Chassis = Game.GetForm(0x000318EC)
	WL_Items_Oil = Game.GetFormFromFile(0x002300, "Chesko_WearableLantern.esp")

EndFunction

Bool Function Check_WL_Craft(Form akBaseItem, int aiItemCount)
	DebugMode("Check_WL_Craft...")

	Float t
	Float totalBaseTime

	If akBaseItem == WL_Items_Wearable
		t = ToMinutes(wlWearableTime)
		DebugMode("Travel Lantern. Base time = " + t)
		TimeCalc(t)

	ElseIf akBaseItem == WL_Items_Chassis
		DebugMode("Lantern chassis. Base time = " + wlChassisTime + "; Smithing = " + Game.GetPlayer().GetActorValue("Smithing") + "; Mult = " + ExpertiseMultiplier("Smithing"))
		TimeCalc( wlChassisTime * ExpertiseMultiplier("Smithing") )

	; http://imgur.com/gallery/g2CGG
	ElseIf akBaseItem == WL_Items_Oil
		t = ToMinutes(wlOilTime)
		totalBaseTime = t * aiItemCount
		DebugMode("Lantern oil. Base time = " + t + "; x" + aiItemCount + " = " + totalBaseTime)
		TimeCalc(totalBaseTime)

	Else
		DebugMode("No match found. This one's free!")
	EndIf

	Return True

EndFunction

