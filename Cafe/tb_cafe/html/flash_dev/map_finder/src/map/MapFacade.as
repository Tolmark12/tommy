package map
{
import org.puremvc.as3.multicore.interfaces.IFacade;
import org.puremvc.as3.multicore.patterns.facade.Facade;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import map.control.*;
import flash.display.Sprite;

public class MapFacade extends Facade implements IFacade
{
	public static const STARTUP:String 			= "startup";
	public static const INIT_STATES:String 		= "init_states";
	public static const STATE_CLICK:String 		= "state_click";
	public static const SELECT_STATE:String 	= "select_state";
	public static const DESELECT_STATE:String 	= "deselect_state";
	// Example: var myFacade:MapFacade = MapFacade.getInstance( 'map_facade' );
	public function MapFacade( key:String ):void
	{
		super(key);	
	}

	/** Singleton factory method */
	public static function getInstance( key:String ) : MapFacade 
    {
        if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new MapFacade( key );
        return instanceMap[ key ] as MapFacade;
    }
	
	public function startup( $root:Sprite ):void
	{
	 	sendNotification( STARTUP, $root ); 
	}

	/** Register Controller commands */
	override protected function initializeController( ) : void 
	{
		super.initializeController();			
		registerCommand( STARTUP, Startup );
		registerCommand( STATE_CLICK, StateClick );
	}

}
}