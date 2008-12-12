package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;

public class NavBtnClick extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var navItemText:String = note.getBody() as String;
		var frameProxy:FrameProxy = facade.retrieveProxy( FrameProxy.NAME ) as FrameProxy;
		frameProxy.gotoNewPage( navItemText );
	}
}
}