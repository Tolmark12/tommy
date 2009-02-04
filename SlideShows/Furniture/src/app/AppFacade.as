package app
{
import app.control.BuildAppCommand;
import app.control.ChangeSlideByIndex;
import flash.display.Sprite;

import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;

public class AppFacade extends Facade implements IFacade
{
	public static const BUILD:String 					= "init";
	public static const DISPLAY_NEW_SLIDE:String 		= "display_new_slide";
	public static const INIT_SLIDES:String 				= "init_slides";
	public static const NEXT_SLIDE:String 				= "next_slide";
	public static const PREV_SLIDE:String 				= "prev_slide";
	public static const CHANGE_SLIDE_BY_INDEX:String 	= "change_slide_by_index";
	public static const TEST:String						= "test";

	public function AppFacade( key:String ):void
	{
		super(key);	
	}

	/** Singleton factory method */
	public static function getInstance( key:String ) : AppFacade 
    {
        if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new AppFacade( key );
        return instanceMap[ key ] as AppFacade;
    }
	
	/** 
	*	Initialize and build the application
	*	
	*	@param		Sprite that holds the images
	*	@param		Sprite that holds the buttons along the bottom
	*	@param		The slide xml data defining the image paths and such. 
	*/
	public function buildApp( $pictureHolder:Sprite, $buttonHolder:Sprite, $xmlData:XML ):void
	{
		var params:Object = { pictureHolder : $pictureHolder, 
							  buttonHolder  : $buttonHolder,
							  xmlData	    : $xmlData  };
		sendNotification( BUILD, params );
	}

	/** Register Controller commands */
	override protected function initializeController( ) : void 
	{
		super.initializeController();
		registerCommand( BUILD, BuildAppCommand );
		registerCommand( CHANGE_SLIDE_BY_INDEX, ChangeSlideByIndex );
	}

}
}