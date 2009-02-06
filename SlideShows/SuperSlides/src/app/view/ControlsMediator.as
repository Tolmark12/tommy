package app.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.AppFacade;
import app.model.vo.*;
import app.view.components.*;
import SuperSlides;
import caurina.transitions.Tweener;

public class ControlsMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "controls_mediator";
	
	// On the stage
	private var _nav:NavDrawer;

	public function ControlsMediator( $root:SuperSlides ):void
	{
		super( NAME );
		_nav = $root.navMc;
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ AppFacade.INIT_SLIDES ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.INIT_SLIDES:
				trace( "init slides from ControlsMediator.as" );
			break;
		}
	}
	
}
}