scriptname LTT_Factory
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	Allows the user to get a handle to the LTT_Base, in order to register
//	itself.
///////////////////////////////////////////////////////////////////////////////;

LTT_Base function LTT_getBase() global
	return Game.GetFormFromFile( 0x0800, "LivingTakesTime for Mods.esp" ) as LTT_Base
endfunction