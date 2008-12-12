package map.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import map.view.*;
import map.model.*;
import map.model.vo.*;
import flash.display.Sprite;

public class Startup extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var _root:Sprite 				= note.getBody() as Sprite;
		var statesProxy:StatesProxy		= new StatesProxy();
		var mapMediator:MapMediator		= new MapMediator();
		
		facade.registerProxy( statesProxy );
		facade.registerMediator( mapMediator );
		
		mapMediator.init( _root );
		statesProxy.loadXml( _root.stage );
	}
}
}