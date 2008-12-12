package app.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.model.vo.*;
import app.AppFacade;
import flash.events.*;
import delorum.loading.XmlLoader;


public class XmlProxy extends Proxy implements IProxy
{
	public static const NAME:String = "xml_proxy";

	public function XmlProxy( ):void
	{
		super( NAME );
	}

	public function loadXml ( $stage ):void
	{
		var xmlPath:String	= ( $stage.loaderInfo.parameters.xmlPath != null )? $stage.loaderInfo.parameters.xmlPath : 'flash_xml/cafe_sample.xml' ;
		var ldr:XmlLoader 	= new XmlLoader( xmlPath );
		ldr.addEventListener( Event.COMPLETE, _xmlLoaded );
		ldr.loadItem();
	}
	
	private function _xmlLoaded ( e:Event ):void
	{
		sendNotification( AppFacade.XML_LOAD_COMPLETE, XML( e.target.data ) );
	}	
	

}
}