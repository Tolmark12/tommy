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
		// root
		var rootMc:SuperSlides = note.getBody() as SuperSlides;
		
		
		// Proxies creation
		var externalDataProxy:ExternalDataProxy 	= new ExternalDataProxy();
		var slidesProxy:SlidesProxy             	= new SlidesProxy();
		externalDataProxy.loadJson();
		
		// Mediators creation
		var controlsMediator:ControlsMediator		= new ControlsMediator( rootMc );
		var contentMediator:ContentMediator			= new ContentMediator( rootMc );
		
		
		// Register Proxies
		facade.registerProxy ( externalDataProxy );
		facade.registerProxy ( slidesProxy );
		
		// Register Mediators
		facade.registerMediator	( controlsMediator );
		facade.registerMediator ( contentMediator );
	}
}
}