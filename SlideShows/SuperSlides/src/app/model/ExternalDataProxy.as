package app.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.model.vo.*;
import app.AppFacade;
import com.adobe.serialization.json.JSON;
import flash.events.*;
import flash.net.*;
import delorum.loading.DataLoader;

public class ExternalDataProxy extends Proxy implements IProxy
{
	public static const NAME:String = "external_data_proxy";

	public function ExternalDataProxy( ):void
	{
		super( NAME );
	}
	
	/** 
	*	Load the json instructional file
	*/
	public function loadJson (  ):void
	{
		var ldr:DataLoader = new DataLoader( "content/json/example_a.json" );
		ldr.addEventListener( Event.COMPLETE, _onJsonLoad );
		ldr.loadItem();
	}
	
	/** 
	*	Parse the json file
	*	@param		Event object 
	*/
	private function _onJsonLoad ( e:Event ):void
	{
		var loader:URLLoader = e.target as URLLoader;
		var json:Object = JSON.decode( loader.data );
		
		// Set global vars
		var globals:GlobalsVO = new GlobalsVO();
		globals.navY = (json.globals.nav_y == null)? 0 : json.globals.nav_y ;
		
		sendNotification( AppFacade.SET_GLOBALS, globals );
		
		sendNotification( AppFacade.JSON_LOADED, json );
	}
}
}