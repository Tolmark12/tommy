package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;
import flash.display.Sprite;

public class Startup extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var $stage:Sprite = note.getBody() as Sprite;
		
		// Create
		var slidesProxy:SlidesProxy               = new SlidesProxy();
		var xmlProxy:XmlProxy		              = new XmlProxy();
		var frameProxy:FrameProxy				  = new FrameProxy();
		var thumbnailsMediator:ThumbnailsMediator = new ThumbnailsMediator();
		var mainSlideMediator:MainSlideMediator   = new MainSlideMediator();
		var frameMediator:FrameMediator  		  = new FrameMediator();

		// Register
		facade.registerProxy    ( xmlProxy	 		 );
		facade.registerProxy    ( slidesProxy 		 );
		facade.registerProxy    ( frameProxy 		 );
		facade.registerMediator ( thumbnailsMediator );
		facade.registerMediator ( mainSlideMediator  );
		facade.registerMediator ( frameMediator		 );
		
		// Init
		mainSlideMediator.init($stage);
		frameMediator.init($stage);
		thumbnailsMediator.init($stage);
		xmlProxy.loadXml( $stage );
	
	}
}
}