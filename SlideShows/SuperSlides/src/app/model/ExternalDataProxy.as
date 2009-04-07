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
	public function loadData ( $stage:Stage ):void
	{
		var path:String = ( $stage.loaderInfo.parameters.json != null )? $stage.loaderInfo.parameters.json : 'content/json/slide_show0.json' ;
		var ldr:DataLoader = new DataLoader( path );
		
		var typeAr:Array = path.split(".");
		
		// If we're loading json...
		if(typeAr[typeAr.length-1] == "json")
			ldr.addEventListener( Event.COMPLETE, _onJsonLoad );
		// else we're loading xml...
		else
			ldr.addEventListener( Event.COMPLETE, _onXmlLoad  ); 
		
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
	
	/** 
	*	Parse the xml and send the notifications
	*	@param		event
	*/
	private function _onXmlLoad ( e:Event ):void
	{
		var xml:XML = new XML( e.target.data );
		// Set global vars
		var globals:GlobalsVO = new GlobalsVO();
		globals.navY 			= (xml.globals.@nav_y == null)? 0 : xml.globals.@nav_y ;
		globals.css				= (xml.globals.css == null)? "p{ color:#796443; font-family:VTypewriterTelegram; font-size:17 } a{ text-decoration:underline;  } a:hover{ color:#FF0000; }" : xml.globals.css ;
		globals.controlsX		= (xml.globals.arrows_position.@x == null)? 0 : xml.globals.arrows_position.@x ;
		globals.controlsY		= (xml.globals.arrows_position.@y == null)? 0 : xml.globals.arrows_position.@y ;
		globals.slideShowSpeed	= (xml.globals.@slide_show_speed == null)? 3 : xml.globals.@slide_show_speed ;
		globals.slideTransSpeed	= (xml.globals.@slide_trans_speed == null)? 1 : xml.globals.@slide_trans_speed ;
	
		sendNotification( AppFacade.SET_GLOBALS, globals );
		sendNotification( AppFacade.XML_LOADED, xml );
	}
}
}