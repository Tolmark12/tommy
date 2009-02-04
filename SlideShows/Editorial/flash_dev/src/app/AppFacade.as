package app
{
import app.controllers.ChangeSlideByIndex;
import app.controllers.InitAppCommand;

import flash.display.Sprite;

import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;

import app.controllers.InitStageComponents;

public class AppFacade extends Facade implements IFacade
{
	public static const INIT:String						= "init";
	public static const XML_LOADED:String				= "xml_loaded";
	public static const INIT_MAIN_SLIDE:String			= "init_main_slide";
	public static const INIT_THUMBNAILS:String			= "init_thumbnails";
	public static const DISPLAY_NEW_SLIDE:String		= "display_new_slide";
	public static const CHANGE_SLIDE_BY_INDEX:String 	= "change_slide_by_index";
	public static const SHIFT_SLIDES_RIGHT:String		= "shift_slides_right";
	public static const SHIFT_SLIDES_LEFT:String		= "shift_slides_left";
	
	public function AppFacade(key:String)
	{
		super(key);
	}
	
	/** Return instance of this Facade */
	public static function getInstance($key:String) : AppFacade
	{
		 if ( instanceMap[ $key ] == null ) instanceMap[ $key ]  = new AppFacade( $key );
    	return instanceMap[ $key ] as AppFacade;
	}
	
	/** Start Application */
	public function init( $stage:Sprite ) : void
	{
		sendNotification(INIT, $stage);
	}
	
	override protected function initializeController():void
	{
		super.initializeController();
		
		//register commands
		registerCommand( INIT, InitAppCommand );
		registerCommand( XML_LOADED, InitStageComponents );
		registerCommand( CHANGE_SLIDE_BY_INDEX, ChangeSlideByIndex );
	}
	
}
}