package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;

public class JsonLoaded extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{		
		var jsonObj:Object = note.getBody() as Object;
		var slidesProxy:SlidesProxy = facade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
		
		slidesProxy.parseJson( jsonObj );
	}
}
}