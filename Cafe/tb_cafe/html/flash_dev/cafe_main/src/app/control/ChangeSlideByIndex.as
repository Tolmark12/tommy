package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.model.SlidesProxy;


public class ChangeSlideByIndex extends SimpleCommand implements ICommand
{

	override public function execute( notification:INotification ):void
	{
		var newIndex:uint		= notification.getBody() as uint;
		
		var proxy:SlidesProxy 	= facade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
		proxy.changeSlide( newIndex );
		proxy.killTimer();
	}
}
}