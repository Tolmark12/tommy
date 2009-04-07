package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;
import app.AppFacade;

public class ProxyToProxy extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var slidesProxy:SlidesProxy = facade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
		
		switch ( note.getName() )
		{
			case AppFacade.JSON_LOADED :
				slidesProxy.parseData( note.getBody() as Object, "json" );
			break;
			case AppFacade.XML_LOADED :
				slidesProxy.parseData( note.getBody() as XML, "xml"  );
			break;
		}
	}
}
}