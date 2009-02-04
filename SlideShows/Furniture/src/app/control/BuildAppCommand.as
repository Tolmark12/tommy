package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

import app.model.SlidesProxy;
import app.view.MainSlideMediator;
import app.view.ThumbnailsMediator;

public class BuildAppCommand extends SimpleCommand implements ICommand
{

	override public function execute( $note:INotification ):void
	{
		var params:Object = $note.getBody() as Object;
		
		// Create the parts
		facade.registerMediator	( new MainSlideMediator( params.pictureHolder ) );
		facade.registerMediator	( new ThumbnailsMediator( params.buttonHolder ) );
		facade.registerProxy	( new SlidesProxy( params.xmlData ) 			);
		
		// Start the application
		var proxy:SlidesProxy = facade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
		proxy.createSlidesFromXml();
	}
}
}