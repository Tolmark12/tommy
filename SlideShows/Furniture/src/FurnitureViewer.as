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

public class FurnitureViewer extends Sprite 
{
	private var _appFacade:AppFacade;
	private var _picture:Sprite;
	private var _buttons:Sprite;
	private var _frame:FrameMc_swc;
	
	public function FurnitureViewer()
	{		
		var xmlPath:String	= ( this.loaderInfo.parameters.xmlPath != null )? this.loaderInfo.parameters.xmlPath : 'flash_loads/xml/slides.xml' ;
		var ldr:XmlLoader 	= new XmlLoader( xmlPath );
		ldr.onComplete		= initAfterXmlLoad;
		ldr.loadItem();	
	}
	
	private function initAfterXmlLoad ( e:Event ):void
	{		
		// create and position the various sprites
		_picture = new Sprite();
		_buttons = new Sprite();
		_frame	 = new FrameMc_swc();
		_picture.x 	= 62;
		_picture.y 	= 79;
		_frame.x	= 6;
		_frame.y	= 6;
		this.addChild( _picture );
		this.addChild( _frame	);
		this.addChild( _buttons );

		// create the main app facade, and start the application
 		_appFacade = AppFacade.getInstance( "app_facade" );
		_appFacade.buildApp( _picture, _buttons, XML(e.target.data) );
	}
}
}
