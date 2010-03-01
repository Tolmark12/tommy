package app
{
import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.control.*;
import SuperSlides;

public class AppFacade extends Facade implements IFacade
{
	// Loading + Init
	public static const SET_GLOBALS:String 				= "set_globals";
	public static const STARTUP:String 					= "startup";
	public static const JSON_LOADED:String 				= "json_loaded";
	public static const XML_LOADED:String 				= "xml_loaded";
	                                                	
	// Slides                                       	
	public static const INIT_SLOTS:String 				= "init_slots";
	public static const POPULATE_SLOTS:String 			= "populate_slots";
	public static const CHANGE_SLIDE:String 			= "change_slide";
	public static const INIT_SLIDES:String 				= "init_slides";
	public static const NEXT_SLIDE:String 				= "next_slide";
	public static const PREV_SLIDE:String 				= "prev_slide";
	public static const STOP_AUTOPLAY:String 			= "stop_autoplay";
	public static const SHOW_HIDDEH_ITEMS:String 		= "show_hiddeh_items";
	
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
	
	public function startup($root:SuperSlides):void
	{
	 	sendNotification( STARTUP, $root ); 
	}

	/** Register Controller commands */
	override protected function initializeController( ) : void 
	{
		super.initializeController();			
		registerCommand( STARTUP, Startup );
		registerCommand( JSON_LOADED, ProxyToProxy );
		registerCommand( XML_LOADED, ProxyToProxy );
		registerCommand( PREV_SLIDE, Clicks );
		registerCommand( NEXT_SLIDE, Clicks );
	}

}
}