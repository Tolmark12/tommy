package map.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import map.view.*;
import map.model.*;
import map.model.vo.*;

public class StateClick extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{
		var stateAbreviation:String =  note.getBody() as String;
		var statesProxy:StatesProxy = facade.retrieveProxy( StatesProxy.NAME ) as StatesProxy;
		statesProxy.activateStateByName( stateAbreviation );
	}
}
}