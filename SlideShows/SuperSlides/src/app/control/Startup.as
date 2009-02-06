package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;
import SuperSlides;

public class Startup extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var rootMc:SuperSlides = note.getBody() as SuperSlides;
		
		// Proxies
		var externalDataProxy:ExternalDataProxy 	= new ExternalDataProxy();
		var slidesProxy:SlidesProxy             	= new SlidesProxy();
		externalDataProxy.loadJson();
		
		// Mediators
		var controlsMediator:ControlsMediator		= new ControlsMediator( rootMc );
		
		
		// Register Proxies
		facade.registerProxy ( externalDataProxy );
		facade.registerProxy ( slidesProxy );
		
		// Register Mediators
		facade.registerMediator	( controlsMediator );
		
	}
}
}