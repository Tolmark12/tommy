package app
{
import app.control.*;
import flash.display.Sprite;
import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;

public class AppFacade extends Facade implements IFacade
{
	public static const STARTUP:String 					= "startup";
	
	// Xml Loading
	public static const XML_LOAD_COMPLETE:String 		= 'xml_load_complete';
	
	// Css
	public static const CSS_PARSED:String 				= "css_parsed";
	
	// SlideShow
	public static const DISPLAY_NEW_SLIDE:String 		= "display_new_slide";
	public static const INIT_SLIDES:String 				= "init_slides";
	public static const NEXT_SLIDE:String 				= "next_slide";
	public static const PREV_SLIDE:String 				= "prev_slide";
	public static const CHANGE_SLIDE_BY_INDEX:String 	= "change_slide_by_index";
	public static const ONLY_ONE_SLIDE:String 			= "only_one_slide";
	public static const HIT_RIGHT_WALL:String 			= "hit_right_wall";
	public static const HIT_LEFT_WALL:String 			= "hit_left_wall";
	public static const SHOW_DETAILS:String 			= "show_details";
	
	// Navigation
	public static const INIT_FRAME:String 				= "init_navigation";
	public static const BUILD_NAVIGATION:String 		= "build_navigation";
	public static const NAV_BTN_CLICK:String 			= "nav_btn_click";
	public static const LOGO_BTN_CLICK:String 			= "logo_btn_click";
	
	
	
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
	
	public function begin ( $stage:Sprite ):void
	{
		sendNotification( STARTUP, $stage );
	}


	/** Register Controller commands */
	override protected function initializeController( ) : void 
	{
		super.initializeController();
		registerCommand( STARTUP, Startup );
		registerCommand( CHANGE_SLIDE_BY_INDEX, ChangeSlideByIndex );
		registerCommand( XML_LOAD_COMPLETE, XmlLoaded );
		registerCommand( NAV_BTN_CLICK, NavBtnClick );
		registerCommand( LOGO_BTN_CLICK, LogoBtnClick );
		registerCommand( NEXT_SLIDE, PrevNextClick );
		registerCommand( PREV_SLIDE, PrevNextClick );
		registerCommand( SHOW_DETAILS, PrevNextClick );
	}

}
}