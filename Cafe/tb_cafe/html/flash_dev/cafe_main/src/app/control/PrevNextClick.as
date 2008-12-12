package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.model.SlidesProxy;


public class PrevNextClick extends SimpleCommand implements ICommand
{

	override public function execute( notification:INotification ):void
	{
		var proxy:SlidesProxy 	= facade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
		proxy.killTimer();
	}
}
}