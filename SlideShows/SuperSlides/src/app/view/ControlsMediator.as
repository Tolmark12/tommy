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
import flash.events.*;

public class ControlsMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "controls_mediator";
	
	// On the stage
	private var _nav:NavDrawer_swc;

	public function ControlsMediator( $root:SuperSlides ):void
	{
		super( NAME );
		_nav = $root.navMc;
		init();
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ AppFacade.SET_GLOBALS,
				 AppFacade.INIT_SLIDES, 
				 AppFacade.CHANGE_SLIDE, ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.SET_GLOBALS :
				var globals:GlobalsVO = note.getBody() as GlobalsVO;
				_nav.y = _nav.y + globals.navY;
			break;
			case AppFacade.INIT_SLIDES:
				_nav.init( (note.getBody() as Array).length );
			break;
			case AppFacade.CHANGE_SLIDE :
				_nav.changeSlide( (note.getBody() as Number ) + 1  );
			break;
		}
	}
	
	/** 
	*	Initialize the app
	*/
	public function init (  ):void
	{
		// Listen for the next / previous slide events
		_nav.addEventListener( NavDrawer.NEXT_SLIDE, _onNextSlide, false,0,true );
		_nav.addEventListener( NavDrawer.PREV_SLIDE, _onPrevSlide, false,0,true );
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _onNextSlide ( e:Event ):void {
		sendNotification( AppFacade.PREV_SLIDE );
	}
	
	private function _onPrevSlide ( e:Event ):void {
		sendNotification( AppFacade.NEXT_SLIDE );
	}
	
}
}