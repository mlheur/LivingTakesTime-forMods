Scriptname LTT_PlayerAlias extends ReferenceAlias Conditional

LTTfM Property LTT Auto  

Event OnItemAdded (Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	LTT.ItemAdded (akBaseItem, aiItemCount, akItemReference, akSourceContainer)
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	LTT.ItemRemoved (akBaseItem, aiItemCount, akItemReference, akDestContainer)
endEvent

Event OnSit(ObjectReference akFurniture)
	LTT.StartFurniture(akFurniture)
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	LTT.StopFurniture(akFurniture)
EndEvent
