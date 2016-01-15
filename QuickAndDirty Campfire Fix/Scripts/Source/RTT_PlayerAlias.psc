scriptName RTT_PlayerAlias extends ReferenceAlias conditional

;-- Properties --------------------------------------
rtt property ReadingTakesTime auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	ReadingTakesTime.ItemAdded(akBaseItem, aiItemCount, akItemReference, akSourceContainer)
endFunction

; Skipped compiler generated GotoState

function OnSit(ObjectReference akFurniture)

	ReadingTakesTime.StartFurniture(akFurniture)
endFunction

; Skipped compiler generated GetState

function OnGetUp(ObjectReference akFurniture)

	ReadingTakesTime.StopFurniture(akFurniture)
endFunction

function OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)

	ReadingTakesTime.ItemRemoved(akBaseItem, aiItemCount, akItemReference, akDestContainer)
endFunction
