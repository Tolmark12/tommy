package app.control
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
import app.view.*;
import app.model.*;
import app.model.vo.*;
import app.AppFacade;

public class Clicks extends SimpleCommand implements ICommand
{

	override public function execute( note:INotification ):void
	{		
		var slidesProxy:SlidesProxy = facade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
		
		switch (note.getName() as String){
			case AppFacade.NEXT_SLIDE :
				slidesProxy.incramentSlideIndex(1);
			break;
			case AppFacade.PREV_SLIDE :
				slidesProxy.incramentSlideIndex(-1);
			break;
		}
	}
}
}