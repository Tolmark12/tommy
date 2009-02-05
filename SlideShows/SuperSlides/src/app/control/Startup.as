package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;

public class Startup extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		// Proxies
		var externalDataProxy:ExternalDataProxy 	= new ExternalDataProxy();
		var slidesProxy:SlidesProxy             	= new SlidesProxy();
		externalDataProxy.loadJson();

		
		// Register Proxies
		facade.registerProxy		( externalDataProxy );
		facade.registerProxy		( slidesProxy );
		
		// Register Mediators
		//facade.registerMediator	( new SomeMediator() );
		
	}
}
}