package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;

public class XmlLoaded extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var xml:XML = note.getBody() as XML;
		
		// Retrieve
		var slidesProxy:SlidesProxy = facade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
		var frameProxy:FrameProxy = facade.retrieveProxy( FrameProxy.NAME ) as FrameProxy;
		
		// Send xml data to proxies
		slidesProxy.createStyleSheet( xml );
		slidesProxy.createSlides( xml );
		frameProxy.initFrame( xml );
	}
	
	
}
}

