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
import flash.display.Stage;

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
	public function loadJson ( $stage:Stage ):void
	{
		var jsonPath:String = ( $stage.loaderInfo.parameters.json != null )? $stage.loaderInfo.parameters.json : 'content/json/slide_show1.json' ;
		
		var ldr:DataLoader = new DataLoader( jsonPath );
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
		globals.navY 			= (json.globals.nav_y == null)? 0 : json.globals.nav_y ;
		globals.css				= (json.globals.css == null)? "p{ color:#796443; font-family:VTypewriterTelegram; font-size:17 } a{ text-decoration:underline;  } a:hover{ color:#FF0000; }" : json.globals.css ;
		globals.controlsX		= (json.globals.arrows_position.x == null)? 0 : json.globals.arrows_position.x ;
		globals.controlsY		= (json.globals.arrows_position.y == null)? 0 : json.globals.arrows_position.y ;
		globals.slideShowSpeed	= (json.globals.slide_show_speed == null)? 3 : json.globals.slide_show_speed ;
		globals.slideTransSpeed	= (json.globals.slide_trans_speed == null)? 1 : json.globals.slide_trans_speed ;
		
		sendNotification( AppFacade.SET_GLOBALS, globals );
		
		sendNotification( AppFacade.JSON_LOADED, json );
	}
}
}