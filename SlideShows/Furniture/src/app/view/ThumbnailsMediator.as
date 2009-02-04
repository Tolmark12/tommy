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

	// Constructor
	public function ThumbnailsMediator( $holder:Sprite ):void
	{
		super( NAME );
		_holder = $holder;
		_holder.y = 520;
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	
					AppFacade.DISPLAY_NEW_SLIDE,  
					AppFacade.INIT_SLIDES,
					AppFacade.NEXT_SLIDE,
					AppFacade.PREV_SLIDE
				];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.INIT_SLIDES :
				var slides:Array = note.getBody() as Array;
				_createArrowBtns();
				_createPictureBtns( slides );
				//_createScrollBar();
				_createMask();
				break;
			
			case AppFacade.DISPLAY_NEW_SLIDE:
				var newSlide:Slide_VO = note.getBody() as Slide_VO;
				_activateNewThumbnailBtn( newSlide.slideIndex );
				break;
				
			case AppFacade.NEXT_SLIDE:
				_moveThumbnails( 3 );
				break
				
			case AppFacade.PREV_SLIDE:
				_moveThumbnails( -3 );
				break
		}
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
		var nextBtn:ArrowBtn_swc = new ArrowBtn_swc();
		var prevBtn:ArrowBtn_swc = new ArrowBtn_swc();
		nextBtn.x 			= 700;
		prevBtn.x 			= 90;
		prevBtn.scaleX 		= -1;
		nextBtn.buttonMode 	= true;
		prevBtn.buttonMode 	= true;	
		nextBtn.addEventListener(MouseEvent.CLICK, _handleArrowBtnClick );
		prevBtn.addEventListener(MouseEvent.CLICK, _handleArrowBtnClick );
		_holder.addChild( nextBtn );
		_holder.addChild( prevBtn );
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
	
	// Build the scrollbar
	private function _createScrollBar (  ):void
	{	
		/*
		var scroller:Scroller = new Scroller( maskMc, _thumbnailHolder );
		scroller.createMaskArea( 600, 95 );
		*/
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