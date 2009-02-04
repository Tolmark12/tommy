package app.views
{
import app.AppFacade;
import app.views.components.Thumbnail;

import caurina.transitions.Tweener;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;


public class ThumbnailMediator extends Mediator implements IMediator
{
	public static const  NAME:String		= "thumbnail_mediator";
	private static const COLUMNS:uint 		= 2;
	private static const ROWS:uint			= 4;
	private static const THUMB_WIDTH:uint	= 90;
	private static const THUMB_HEIGHT:uint	= 100;

	/** total pages of thumbnails */
	private var _totalPages:uint = 1;

	/** current page index */
	private var _currentPage:int = 1;
	
	private var _selectedThumbnail:Thumbnail;
	
	/** sprite container to hold the thumbnail images and apply a mask */
	private var _thumbnailHolder:Sprite = new Sprite();
	
	/** sprite container to hold the navigation */
	private var _navigation:Sprite = new Sprite();
	
	/** text field status within navigation */
	private var _status:TextField;
	
	/** safety switch variable when page is in transition */
	private var _isMoving:Boolean = false;
	
	/**	The initial x position of the thumbnail holder */
	private var _thumbnailStartX:int;
	
	public function ThumbnailMediator($thumbnail:Sprite)
	{
		super(NAME, $thumbnail);
		thumbnailContainer.addChild(_thumbnailHolder);
		_createMask();
	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	
					AppFacade.SHIFT_SLIDES_LEFT,  
					AppFacade.SHIFT_SLIDES_RIGHT,
				];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.SHIFT_SLIDES_RIGHT :
				_moveThumbnails( 1 );
				break;
			
			case AppFacade.SHIFT_SLIDES_LEFT:
				_moveThumbnails( -1 );
				break;
		}
	}
	
	
	public function get thumbnailContainer() : Sprite
	{
		return this.getViewComponent() as Sprite;
	}
	
	// ______________________________________________________________ Building the display
	
	/** 
	*	Builds the thumbnail display
	*	
	*	@param		an array of Slide_VO objects
	*/
	public function build( $slides:Array ):void
	{
		_createPictureGrid( $slides );
		_buildNavigation();
	}
	
	private function _createPictureGrid( $slides:Array ):void
	{
		var rowCount:uint = 0;
		var colCount:uint = 0;
		
		for(var i:uint = 0; i < $slides.length; i++)
		{
			var thumbnail:Thumbnail;
			
			if(i==0){
				thumbnail = new Thumbnail($slides[i], true);
				_selectedThumbnail = thumbnail;
			}else{
				thumbnail = new Thumbnail($slides[i]);
			}
			_thumbnailHolder.addChild(thumbnail);
			thumbnail.x = (_totalPages > 1) ? (THUMB_WIDTH * COLUMNS) * (_totalPages - 1) + (THUMB_WIDTH * colCount) : (THUMB_WIDTH * colCount) * _totalPages;
			thumbnail.y = THUMB_HEIGHT * rowCount;
			thumbnail.buttonMode = true;
			thumbnail.addEventListener(MouseEvent.CLICK, _changeMainSlide);
			_thumbnailStartX = _thumbnailHolder.x;
			
			if(i < $slides.length -1){
				if(colCount == COLUMNS -1){
					colCount = 0;
					if(rowCount == ROWS -1){
						rowCount = 0;
						_totalPages++;	
					}else{
						rowCount++;
					}
				}else{
					colCount++;
				}
			}
		}
	}
	
	private function _createMask():void
	{
		var mask:Sprite = new Sprite();
		mask.graphics.beginFill(0x00000);
		mask.graphics.drawRect(-3, -2, COLUMNS * THUMB_WIDTH, ROWS * THUMB_HEIGHT + 20);
		thumbnailContainer.addChild(mask);
		//apply mask
		thumbnailContainer.mask = mask;
	}

	private function _buildNavigation():void
	{
		thumbnailContainer.addChild(_navigation);
		_loadLeftArrow();
		_loadStatus();
		_loadRightArrow();
		_navigation.x = (((COLUMNS * THUMB_WIDTH) - _navigation.width) / 2) + 20;
		_navigation.y = ROWS * THUMB_HEIGHT;
	}
	
	private function _loadLeftArrow():void
	{
		var leftArrow:ArrowBtn_swc = new ArrowBtn_swc();
		_navigation.addChild(leftArrow);
		leftArrow.scaleX = -1;
		leftArrow.addEventListener(MouseEvent.CLICK, _handleArrowBtnClick);
	}
	
	private function _loadRightArrow():void
	{
		var rightArrow:ArrowBtn_swc = new ArrowBtn_swc();
		_navigation.addChild(rightArrow);
		rightArrow.x = 73;
		rightArrow.addEventListener(MouseEvent.CLICK, _handleArrowBtnClick);
	}
	
	private function _loadStatus():void
	{
		_status = new TextField();
		_status.width = 70;
		_refreshStatus();
		_status.autoSize = "center";
		_navigation.addChild(_status);
		_status.x = 10;
		_status.y = 3;
	}
	
	// ______________________________________________________________ Text status indicator ex: 1 - 12 of 25
	
	private function _refreshStatus():void
	{
		_status.text = _getLow() + " - " + _getHigh() + " of " + _thumbnailHolder.numChildren;
	}
	
	private function _getLow():uint
	{
		return (ROWS * COLUMNS) * (_currentPage - 1) + 1;
	}
	
	private function _getHigh():uint
	{
		var totalThumbnails:uint = _thumbnailHolder.numChildren;
		var possibleCount:uint = (ROWS * COLUMNS) * _currentPage;
		
		return (totalThumbnails < possibleCount) ? totalThumbnails : possibleCount;
	}
	
	
	// ______________________________________________________________ Arrow Buttons - Next and Previous page
	
	// Event Handlers
	private function _handleArrowBtnClick ( e:Event ):void
	{
		if( e.currentTarget.scaleX == 1 )					// Right button's click
			sendNotification( AppFacade.SHIFT_SLIDES_RIGHT );
		else 												// Left button's click
			sendNotification( AppFacade.SHIFT_SLIDES_LEFT  );
	}
	
	// Slides the thumbnails "x" number of pages to the right or the left
	private function _moveThumbnails ( $pages:int ):void
	{		
		// if attempting to slide slides beyond the total # of pages:
		if( _currentPage + $pages > _totalPages  ){ 
			_currentPage = _totalPages;
		}
		// if attempting to slided slides to an index that is less than 1:
		else if( _currentPage + $pages < 1 ){		 
			_currentPage = 1
		}
		// else, slides are within bounds:
		else{ 										
			_currentPage += $pages;
		}
		
		// Set the x position target and slide thumbnails
		var xTarget:int = _thumbnailStartX - (_currentPage -1) * (THUMB_WIDTH * COLUMNS);
		Tweener.addTween(_thumbnailHolder, {x:xTarget, time:1.2, transition:"easeInOutExpo"});
		
		// update text status
		_refreshStatus();
	}

	// ______________________________________________________________ Changing the main picture
	
	private function _changeMainSlide( e:Event ):void
	{
		var thumbnail:Thumbnail = e.currentTarget as Thumbnail;
		sendNotification(AppFacade.CHANGE_SLIDE_BY_INDEX, thumbnail.index);
		_selectedThumbnail.setSelected(false);
		_selectedThumbnail.setBorder(1);
		thumbnail.setSelected(true);		
		thumbnail.setBorder(2);
		_selectedThumbnail = thumbnail;
	}
	
}
}