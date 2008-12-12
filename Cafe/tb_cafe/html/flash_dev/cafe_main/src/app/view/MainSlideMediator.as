package app.view
{
import app.AppFacade;
import app.model.vo.Slide_VO;
import app.view.components.*;
import caurina.transitions.Tweener;
import delorum.loading.ImageLoader;
import flash.display.Sprite;
import flash.events.*;
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import flash.net.*;
import gs.TweenLite;
import fl.motion.easing.*;
import flash.text.StyleSheet;

public class MainSlideMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "main_slide_mediator";
	private var _slideHolder:Sprite;
	private var _progressHolder:Sprite;
	private var _slides:Object = new Object();
	private var _newSlide:Slide;
	private var _oldSlide:Slide;
	private var _newSlideDescription:TextMc_swc;
	private var _closeDetailsButton:CloseDetailsBtn_swc;
	private var _slideInfo:SlideInfo;

	public function MainSlideMediator():void
	{
		super( NAME );
   	}

	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ 	
					AppFacade.DISPLAY_NEW_SLIDE, 
					AppFacade.CSS_PARSED,
				];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.DISPLAY_NEW_SLIDE:
				var newSlide:Slide_VO = note.getBody() as Slide_VO;
				_swapSlides( newSlide );
				_slideInfo.setText( newSlide.description, newSlide.href );
				_setStackOrder();
			break;
			case AppFacade.CSS_PARSED :
				_slideInfo.applyStyleSheet( note.getBody() as StyleSheet );
			break;
		}
	}
	
	
	public function init ( $holder:Sprite ):void
	{
		var mainHolder:Sprite	= new Sprite();
		mainHolder.x 	= 62;
		mainHolder.y 	= 79;
		
		var bgImage:backgroundImage_swc	= new backgroundImage_swc();
		bgImage.x = 49;
		bgImage.y = 38;
		
		$holder.addChild( bgImage );
		$holder.addChild( mainHolder );
		
		_slideHolder	= new Sprite();
		_slideInfo		= new SlideInfo();
		//_progressHolder			= new Sprite();
		//_progressHolder.x 		= 335;
		//_progressHolder.y 		= 200;
		
		mainHolder.addChild( _slideHolder );
		mainHolder.addChild( _slideInfo   );
		//mainHolder.addChild(_progressHolder);
	}
	
	// Set the "_newSlide" variable in preparation to showing the slide
	private function _swapSlides ( $slide:Slide_VO ):void
	{
		var id:String = $slide.slideId;
		_oldSlide = _newSlide;
		
		if( _slides[id] == null )
		{
			//...create it...
			_slides[id] = new Slide();
			_newSlide = _slides[id];
			_newSlide.href   = $slide.href;
			_newSlide.hrefTarget = $slide.hrefWindowTarget;
			_newSlide.addEventListener( Slide.GOTO_URL, _handleSlideUrlRequest );
			_newSlide.addEventListener( Slide.SHOW_DETAILS, _handleShowDetails );
			_newSlide.activateClickEvent();
			_slideHolder.addChild( _slides[id] );
			
			// load image
			var ldr:ImageLoader = new ImageLoader( $slide.largeImagePath, _slides[id] );
			ldr.addEventListener(Event.COMPLETE, _showNewSlide);
			ldr.loadItem();
			
			//var display:SimpleSpinner_swc = new SimpleSpinner_swc(  );
			//ldr.connectToProgressDisplay( display );
			//_progressHolder.addChild(display);
			//display.build();
		}
		else
		{
			//...else show existing slide.
			if( _newSlide != null ) 
				_newSlide.deactivateClickEvent();
				
			_newSlide = _slides[id];
			_newSlide.activateClickEvent();
			_showNewSlide();
		}		
	}
	
	// Bring the current slide to the front, and display it. 
	private function _showNewSlide ( e:Event = null ):void
	{
		_newSlide.alpha = 0;
		//Tweener.addTween(_newSlide, {alpha:1, time:2} );
		TweenLite.to( _newSlide, 1.5, { alpha:1} );
	}
	
	private function _setStackOrder():void
	{
		_slideHolder.setChildIndex(_newSlide, _slideHolder.numChildren - 1);
	}
	
	// ______________________________________________________________ Event Handlers
	
	public function _handleSlideUrlRequest ( e:Event ):void {
		var request:URLRequest = new URLRequest( e.currentTarget.href );
		navigateToURL( request, e.currentTarget.hrefTarget );
	}
	
	public function _handleShowDetails ( e:Event ):void
	{
		_slideInfo.showSlideDescription();
	}
	
}

}