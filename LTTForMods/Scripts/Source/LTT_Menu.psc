scriptname LTT_Menu extends SKI_ConfigBase
;///////////////////////////////////////////////////////////////////////////////
// Purpose:
//	LTT For Mods provides a sort of transparent interface to MCM.  With all
//	the variables a properties stored in LTT_DataHandler tables, it makes
//	more sense to implement MCM within LTT_Base.  This file provides a
//	sort of wrapper/interface that calls the LTT_Base version of MCM events.
///////////////////////////////////////////////////////////////////////////////;

LTT_Base Property LTT Auto
bool property isInit = false Auto

int function GetVersion()
	; It's ok to use a variable here since LTT will hardcode the answer,
	; and then we don't have to worry about keeping them consistent
	LTT.DebugLog( "++Menu::GetVersion()", 5 )
	LTT.DebugLog( "--Menu::GetVersion(); success", 5 )
	return LTT.getVersion()
endfunction

event OnGameReload() ; this is called before OnConfigInit() - why???
;;	; Do a little wait here for any LTT_mods who are getting their
;;	; first OnInit().
;;	Utility.Wait( 1.0 )
	LTT.DebugLog( "++Menu::OnGameReload()", 5 )
	parent.OnGameReload()
	LTT.mcmOnGameReload( self )
	LTT.DebugLog( "--Menu::OnGameReload(); success", 5 )
endEvent

event OnConfigInit()
	LTT.DebugLog( "++Menu::OnConfigInit()", 5 )
	parent.OnConfigInit()
	if ! isInit
		LTT.mcmOnConfigInit( self )
		isInit = true
	endif
	LTT.DebugLog( "--Menu::OnConfigInit(); success", 5 )
endEvent

event OnVersionUpdate( int Version )
	LTT.DebugLog( "++Menu::OnVersionUpdate()", 5 )
	Pages = LTT.mcmOnVersionUpdate( self, Version )
	LTT.DebugLog( "--Menu::OnVersionUpdate(); success", 5 )
endevent

event OnPageReset(string page)
	LTT.DebugLog( "++Menu::OnPageReset()", 5 )
	LTT.mcmOnPageReset( Page )
	LTT.DebugLog( "--Menu::OnPageReset(); success", 5 )
endEvent

event OnOptionDefault( int option )
	LTT.DebugLog( "++Menu::OnOptionDefault()", 5 )
	LTT.mcmOnOptionDefault( self, option )
	LTT.DebugLog( "--Menu::OnOptionDefault(); success", 5 )
endevent

event OnOptionHighlight( int option )
	LTT.DebugLog( "++Menu::OnOptionHighlight()" )
	LTT.mcmOnOptionHighlight( self, option )
	LTT.DebugLog( "--Menu::OnOptionHighlight(); success", 5 )
endevent

event OnOptionSelect( int option )
	LTT.DebugLog( "++Menu::OnOptionSelect()" )
	LTT.mcmOnOptionSelect( self, option )
	LTT.DebugLog( "--Menu::OnOptionSelect(); success", 5 )
endevent

event OnOptionSliderOpen( int option )
	LTT.DebugLog( "++Menu::OnOptionSliderOpen()", 5 )
	LTT.mcmOnOptionSliderOpen( self, option )
	LTT.DebugLog( "--Menu::OnOptionSliderOpen(); success", 5 )
endevent

event OnOptionSliderAccept( int option, float Value)
	LTT.DebugLog( "++Menu::OnOptionSliderAccept()", 5 )
	LTT.mcmOnOptionSliderAccept( self, option, Value )
	LTT.DebugLog( "--Menu::OnOptionSliderAccept(); success", 5 )
endevent

event OnOptionKeyMapChange( int a_option, int a_keyCode, string a_conflictControl, string a_conflictName )
	LTT.DebugLog( "++Menu::OnOptionKeyMapChange()", 5 )
	LTT.mcmOnOptionKeyMapChange( self, a_option, a_keyCode, a_conflictControl, a_conflictName )
	LTT.DebugLog( "--Menu::OnOptionKeyMapChange(); success", 5 )
endevent

event OnKeyUp( int KeyID, float Duration )
	LTT.DebugLog( "++Menu::OnKeyUp()", 5 )
	LTT.mcmOnKeyUp( KeyID, Duration )
	LTT.DebugLog( "--Menu::OnKeyUp(); success", 5 )
endevent