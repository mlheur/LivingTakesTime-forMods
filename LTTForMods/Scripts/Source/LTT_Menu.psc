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
	LTT.DebugLog( "++Menu::GetVersion()" )
	return LTT.getVersion()
	LTT.DebugLog( "--Menu::GetVersion(); success" )
endfunction

event OnGameReload() ; this is called before OnConfigInit() - why???
	LTT.DebugLog( "++Menu::OnGameReload()" )
	parent.OnGameReload()
	LTT.mcmOnGameReload( self )
	LTT.DebugLog( "--Menu::OnGameReload(); success" )
endEvent

event OnConfigInit()
	LTT.DebugLog( "++Menu::OnConfigInit()" )
	parent.OnConfigInit()
	if ! isInit
		LTT.mcmOnConfigInit( self )
		isInit = true
	endif
	LTT.DebugLog( "--Menu::OnConfigInit(); success" )
endEvent

event OnVersionUpdate( int Version )
	LTT.DebugLog( "++Menu::OnVersionUpdate()" )
	Pages = LTT.mcmOnVersionUpdate( self, Version )
	LTT.DebugLog( "--Menu::OnVersionUpdate(); success" )
endevent

event OnPageReset(string page)
	LTT.DebugLog( "++Menu::OnPageReset()" )
	LTT.mcmOnPageReset( Page )
	LTT.DebugLog( "--Menu::OnPageReset(); success" )
endEvent

event OnOptionDefault( int option )
	LTT.DebugLog( "++Menu::OnOptionDefault()" )
	LTT.mcmOnOptionDefault( self, option )
	LTT.DebugLog( "--Menu::OnOptionDefault(); success" )
endevent

event OnOptionHighlight( int option )
	LTT.DebugLog( "++Menu::OnOptionHighlight()" )
	LTT.mcmOnOptionHighlight( self, option )
	LTT.DebugLog( "--Menu::OnOptionHighlight(); success" )
endevent

event OnOptionSelect( int option )
	LTT.DebugLog( "++Menu::OnOptionSelect()" )
	LTT.mcmOnOptionSelect( self, option )
	LTT.DebugLog( "--Menu::OnOptionSelect(); success" )
endevent

event OnOptionSliderOpen( int option )
	LTT.DebugLog( "++Menu::OnOptionSliderOpen()" )
	LTT.mcmOnOptionSliderOpen( self, option )
	LTT.DebugLog( "--Menu::OnOptionSliderOpen(); success" )
endevent

event OnOptionSliderAccept( int option, float Value)
	LTT.DebugLog( "++Menu::OnOptionSliderAccept()" )
	LTT.mcmOnOptionSliderAccept( self, option, Value )
	LTT.DebugLog( "--Menu::OnOptionSliderAccept(); success" )
endevent

event OnOptionKeyMapChange( int a_option, int a_keyCode, string a_conflictControl, string a_conflictName )
	LTT.DebugLog( "++Menu::OnOptionKeyMapChange()" )
	LTT.mcmOnOptionKeyMapChange( self, a_option, a_keyCode, a_conflictControl, a_conflictName )
	LTT.DebugLog( "--Menu::OnOptionKeyMapChange(); success" )
endevent

event OnKeyUp( int KeyID, float Duration )
	LTT.DebugLog( "++Menu::OnKeyUp()" )
	LTT.mcmOnKeyUp( KeyID, Duration )
	LTT.DebugLog( "--Menu::OnKeyUp(); success" )
endevent