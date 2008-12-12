package 
{

import flash.display.*;
import app.AppFacade;
import flash.events.*;
import delorum.loading.XmlLoader;


/**
* 	A slideshow viewer created to view Tommy Bahama's ourdoor furniture line
* 	
* 	@language ActionScript 3, Flash 9.0.0
* 	@author   Mark Parson. 2008-05-13
* 	@rights	  Copyright (c) Delorum inc. 2008. All rights reserved
*	
*	The following assets have been embedded in the SWC:
*	- 	FrameMc_swc
*	-	SmallFrameMc_swc
*	-	TextMc_swc
*			> displayTxt : Text field 
*			> bgMc		 : Movie clip holds the background image
*	-	ShowDetailsBtn_swc
*	-	ArrowBtn_swc
*	-	CloseDetailsBtn_swc
*	
*	EXAMPLE
*	var myMc:TextMc_swc = new TextMc_swc();
*	myMc.displayTxt.text = "My text";
*	docu
*/

public class CafeFlash extends Sprite 
{
	private var _appFacade:AppFacade;
	private var _picture:Sprite;
	private var _buttons:Sprite;
	private var _frame:FrameMc_swc;
	
	public function CafeFlash()
	{		
		_appFacade = AppFacade.getInstance( "app_facade" );
		_appFacade.begin( this );
	}	
}
}
