package map.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import map.model.vo.*;
import map.MapFacade;

public class XmlProxy extends Proxy implements IProxy
{
	public static const NAME:String = "xml_proxy";

	public function XmlProxy( ):void
	{
		super( NAME );
	}
	
	public function loadXml ( $stage:Stage ):void
	{
		// Get the var from the html flash tag params, or use the local testing file.
		var xmlPath:String	= ( $stage.loaderInfo.parameters.xmlPath   != null )? $stage.loaderInfo.parameters.xmlPath   : 'flash_xml/activeStates.xml' ;
		
		// Load Xml
		var ldr:XmlLoader 	= new XmlLoader( xmlPath );
		ldr.onComplete = _parseXml;
		//ldr.addEventListener( Event.COMPLETE, _parseXml );
		ldr.loadItem();
	}
	
	private function _xmlLoaded ( e:Event ):void
	{
		sendNotification( MapFacade.XML_LOAD_COMPLETE, XML( e.target.data ) )
	}	
}
}