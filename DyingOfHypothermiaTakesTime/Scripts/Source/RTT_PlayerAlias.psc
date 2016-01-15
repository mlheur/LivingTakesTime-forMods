Scriptname RTT_PlayerAlias extends ReferenceAlias  Conditional

RTT Property ReadingTakesTime  Auto  

Event OnItemAdded (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	ReadingTakesTime.ItemAdded (akBaseItem, aiItemCount, akItemReference, akSourceContainer)
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	ReadingTakesTime.ItemRemoved (akBaseItem, aiItemCount, akItemReference, akDestContainer)
endEvent

Event OnSit(ObjectReference akFurniture)
	ReadingTakesTime.StartFurniture(akFurniture)
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	ReadingTakesTime.StopFurniture(akFurniture)
EndEvent
