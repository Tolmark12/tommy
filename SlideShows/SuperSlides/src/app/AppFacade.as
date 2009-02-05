package app
{
import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.control.*;
import SuperSlides;

public class AppFacade extends Facade implements IFacade
{
	public static const STARTUP:String 				= "startup";
	public static const JSON_LOADED:String 			= "json_loaded";
	public static const DISPLAY_NEW_SLIDE:String 	= "display_new_slide";
	
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
		registerCommand( JSON_LOADED, JsonLoaded );
	}

}
}