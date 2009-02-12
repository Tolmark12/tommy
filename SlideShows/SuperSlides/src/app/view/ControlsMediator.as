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
	private var _timer:SlidesTimer;

	public function ControlsMediator( $root:SuperSlides ):void
	{
		super( NAME );
		_nav = $root.navMc;
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ AppFacade.SET_GLOBALS,
				 AppFacade.INIT_SLIDES, 
				 AppFacade.CHANGE_SLIDE,
				 AppFacade.STOP_AUTOPLAY,
				 AppFacade.SHOW_HIDDEH_ITEMS ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.SET_GLOBALS :
				var globals:GlobalsVO = note.getBody() as GlobalsVO;
				Txt.css = globals.css
				_nav.y = _nav.y + globals.navY;
				_nav.controls.x += globals.controlsX;
				_nav.controls.y += globals.controlsY;
				_timer = new SlidesTimer( globals.slideShowSpeed );
				Image.transitionSpeed = globals.slideTransSpeed
			break;
			case AppFacade.INIT_SLIDES:
				_init();
				_timer.startTimer();
				_nav.init( (note.getBody() as Array).length );
			break;
			case AppFacade.CHANGE_SLIDE :
				_nav.changeSlide( (note.getBody() as Number ) + 1  );
			break;
			case AppFacade.STOP_AUTOPLAY :
				_timer.stopTimer();
			break;
			case AppFacade.SHOW_HIDDEH_ITEMS :
				_nav.showControls();
			break;
		}
	}
	
	/** 
	*	Initialize the app
	*/
	private function _init (  ):void
	{
		// Listen for the next / previous slide events
		_nav.addEventListener( NavDrawer.NEXT_SLIDE, _onNextSlide, false,0,true );
		_nav.addEventListener( NavDrawer.PREV_SLIDE, _onPrevSlide, false,0,true );
		_timer.addEventListener( SlidesTimer.TICK, _onTick, false,0,true );
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _onNextSlide ( e:Event ):void {
		sendNotification( AppFacade.PREV_SLIDE, false );
	}
	
	private function _onPrevSlide ( e:Event ):void {
		sendNotification( AppFacade.NEXT_SLIDE, false );
	}
	
	private function _onTick ( e:Event ):void{
		sendNotification( AppFacade.NEXT_SLIDE, true );
	}
	
}
}