package app.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import flash.display.Sprite;
import app.AppFacade;
import app.model.vo.Slide_VO;
import flash.events.*;
import caurina.transitions.Tweener;
import gs.TweenLite;
import fl.motion.easing.*;


public class ThumbnailsMediator extends Mediator implements IMediator
{	
	public static const NAME:String 			= "thumbnails_mediator";
	public static const THUMBNAIL_SPACING:uint 	= 155;
	
	private var _holder:Sprite;
	private var _thumbnailHolder:Sprite;
	private var _thumbnailBtnList:Array;
	private var _currentBtn:SmallFrameMc_swc;
	private var _lineHolder:Sprite;
	
	// Thumbnail motion
	private var _leftMostSlideIndex:uint = 0;
	private var _totalSlides:uint;
	private var _originalX:Number;

	// Arrow Buttons
	private var _nextBtn:ArrowBtn_swc 
    private var _prevBtn:ArrowBtn_swc 

	// Constructor
	public function ThumbnailsMediator():void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	
					AppFacade.DISPLAY_NEW_SLIDE,  
					AppFacade.INIT_SLIDES,
					AppFacade.NEXT_SLIDE,
					AppFacade.PREV_SLIDE,
					AppFacade.ONLY_ONE_SLIDE,
					AppFacade.HIT_RIGHT_WALL,
					AppFacade.HIT_LEFT_WALL,
				];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.INIT_SLIDES :
				var slides:Array = note.getBody() as Array;
				_createPictureBtns( slides );
				if( slides.length > 4 ) 
					_createArrowBtns();
				_createMask();
				break;
			
			case AppFacade.DISPLAY_NEW_SLIDE:
				var newSlide:Slide_VO = note.getBody() as Slide_VO;
				_activateNewThumbnailBtn( newSlide.slideIndex );
				
				
				if( _leftMostSlideIndex < newSlide.slideIndex - 3 ) 
					_moveThumbnails( 4 );
				else if( _leftMostSlideIndex > newSlide.slideIndex ) 
					_moveThumbnails( - (_leftMostSlideIndex - newSlide.slideIndex) );
				
				break;
				
			case AppFacade.NEXT_SLIDE:
				_moveThumbnails( 3 );
				break;
			case AppFacade.PREV_SLIDE:
				_moveThumbnails( -3 );
				break;
			case AppFacade.ONLY_ONE_SLIDE :
				_holder.visible = false;
				break;
			case AppFacade.HIT_RIGHT_WALL:
				_prevBtn.visible = false;
				break
			case AppFacade.HIT_LEFT_WALL:
				_nextBtn.visible = false;
				break
		}
	}
	
	public function init ( $holder:Sprite ):void
	{
		_holder = new Sprite();
		$holder.addChild( _holder );
		_holder.y = 512;
	}
	
	// ______________________________________________________________ Moving the thumbnails
	
	// Slides the thumbnails "x" places to the right or the left
	private function _moveThumbnails ( $places:int ):void
	{
		// if attempting to slide slides beyond the total # of slides...
		if( _leftMostSlideIndex + $places + 4 > _totalSlides - 1)
			_leftMostSlideIndex = _totalSlides - 4;
		// if attempting to slided slides to an index that is less than 0	
		else if( _leftMostSlideIndex + $places < 0 )
			_leftMostSlideIndex = 0;
		// else, slides are within bounds
		else
			_leftMostSlideIndex += $places;
			
		// Toggle arrow button visibility
		if( _leftMostSlideIndex == 0 )  sendNotification(AppFacade.HIT_RIGHT_WALL);
		else 							_prevBtn.visible = true
		if( _leftMostSlideIndex == _totalSlides - 4 )	sendNotification(AppFacade.HIT_LEFT_WALL);
		else 											_nextBtn.visible = true;
			
		// If current position is different than new position
		var newX:Number = _originalX + THUMBNAIL_SPACING * -_leftMostSlideIndex;
		if( _thumbnailHolder.x != newX ) 
		{
			Tweener.addTween( _lineHolder, { alpha:1, time:1, transition:"EaseOut"} );
			Tweener.addTween(_thumbnailHolder, {x:newX, time:1.5, transition:"easeinoutexpo", onComplete:_hideLines});
		}			
	}
	
	private function _hideLines (  ):void
	{
		Tweener.addTween( _lineHolder, { alpha:0, time:0.6, transition:"EaseOut"} );
	}
	
	// ______________________________________________________________ Creating the pieces
	
	// Create the next and the previous "Arrow" buttons
	private function _createArrowBtns (  ):void
	{
		_nextBtn			 		= new ArrowBtn_swc();
		_prevBtn			 		= new ArrowBtn_swc();
		_nextBtn.x 			  		= 700;
		_prevBtn.x 			  		= 90;
		_prevBtn.y = _nextBtn.y 	= 5;
		_prevBtn.scaleX 		  	= -1;
		_nextBtn.buttonMode 	  	= true;
		_prevBtn.buttonMode 	  	= true;	
		_prevBtn.visible 			= false
		_nextBtn.addEventListener(MouseEvent.CLICK, _handleArrowBtnClick );
		_prevBtn.addEventListener(MouseEvent.CLICK, _handleArrowBtnClick );
		_holder.addChild( _nextBtn );
		_holder.addChild( _prevBtn );
	}
	
	// Create the thumbnail buttons at the bottom of the screen
	private function _createPictureBtns ( $slides:Array ):void
	{
		// Initialize and position thumbnail-holder Sprite
		_lineHolder			= new Sprite();
		_thumbnailHolder  	= new Sprite();
		_thumbnailHolder.x 	= 100;
		_thumbnailHolder.y 	= -30;
		_originalX			= _thumbnailHolder.x;
		_holder.addChild( _thumbnailHolder );
		_holder.addChild( _lineHolder	   );
		
		// holds a list of all buttons
		_thumbnailBtnList = new Array();
		// "x" position; Incraments with each button.
		var xPos:uint     = 0;
		
		// Loop through array of Slide_VOs and create buttons
		var len:Number = $slides.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			var slide:Slide_VO 		= $slides[i];
			var mc:SmallFrameMc_swc = new SmallFrameMc_swc();
			mc.clickIndex = slide.slideIndex;
			mc.x = xPos;
			mc.loadImage( slide.thumbnailPath );
			
			// listen for click event
			mc.addEventListener(MouseEvent.CLICK, _handlerPictureBtnClick );
			
			// add to display list
			_thumbnailHolder.addChild( mc );
			xPos += THUMBNAIL_SPACING;
			_thumbnailBtnList.push(mc);
		}
		
		_totalSlides = _thumbnailBtnList.length;
	}
	
	// Draw the mask
	private function _createMask (  ):void
	{
		var maskMc:Sprite = new Sprite();
		maskMc.x = _thumbnailHolder.x - 8;
		maskMc.y = _thumbnailHolder.y;
		maskMc.graphics.beginFill(0xFF0000);
		maskMc.graphics.drawRect(0,0,608,95);
		_thumbnailHolder.mask = maskMc;
		
		var leftLine:LineBorder  = new LineBorder();
		var rightLine:LineBorder = new LineBorder();
		leftLine.x  = maskMc.x;
		rightLine.scaleX = -1;
		rightLine.x = maskMc.x + maskMc.width;
		leftLine.y = rightLine.y = maskMc.y;
		
		_lineHolder.alpha = 0;
		_holder.addChild(maskMc);
		_lineHolder.addChild(leftLine);
		_lineHolder.addChild(rightLine);		
	}
	
	// ______________________________________________________________ Activate / De-activate buttons
	
	// Activates a thumbnail 
	private function _activateNewThumbnailBtn ( $slideIndex:uint ):void
	{
		// De-select current button if it exists
		if(_currentBtn != null)
			_currentBtn.unSelect();
		
		_currentBtn = _thumbnailBtnList[ $slideIndex ];
		_currentBtn.select()
	}
	
	
	// ______________________________________________________________ Event Handlers
	
	// Triggered when either "arrow" button is clicked
	private function _handleArrowBtnClick ( e:Event ):void
	{
		if( e.currentTarget.scaleX == 1 )					// Next Btn
			sendNotification( AppFacade.NEXT_SLIDE );
		else 												// Prev Btn
			sendNotification( AppFacade.PREV_SLIDE );
	}
	
	// Triggered when any thumbnail button is clicked
	private function _handlerPictureBtnClick ( e:Event ):void
	{
		var mc:SmallFrameMc_swc = e.currentTarget as SmallFrameMc_swc;
		sendNotification( AppFacade.CHANGE_SLIDE_BY_INDEX, mc.clickIndex );
	}
}
}