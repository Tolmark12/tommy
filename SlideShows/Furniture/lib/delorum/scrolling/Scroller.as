package delorum.scrolling
{

import flash.display.Sprite;
import flash.events.*;
import flash.geom.Rectangle;
import caurina.transitions.Tweener;


/**
* 	A simple scrollbar
* 	
*	@requires caurina.transitions.Tweener
* 	@example Sample usage:
* 	<listing version=3.0>
* 	
*	// Working code:
*	_scrollHolder = new Sprite();
*	
*	// Create vertical scroller and listen to onScroll updates
*	_scroller = new Scroller( _scrollHolder, 500, Scroller.VERTICAL );
*	_scroller.addEventListener( Scroller.SCROLL, _handlerScroll );
*	
*	// Manually et the scroller's height based on the realative scale of 
*	// the item we're scrolling and the window we're scrolling through.
*	_scroller.updateScrollWindow( window.width / target.width );
*	// You can also manually set the scrollbar's position
*	_scroller.changeScrollPosition( 0.5 );
*	
* 	</listing>
* 	
* 	@language ActionScript 3, Flash 9.0.0
* 	@author   Mark Parson. 2008-07-07
* 	@rights	  Copyright (c) Delorum 2008. All rights reserved	
*/


public class Scroller extends EventDispatcher
{
	// NOTE: all var names assume a horizontal scrollbar orientation
	
	public static const SCROLL:String 		= "scroll";
	public static const VERTICAL:String 	= "vertical";
	public static const HORIZONTAL:String 	= "horizontal";
	
	// For tweening the bar
	public var tweenWidth:Number = 0;
	
	// Sizes
	private var _barHeight:Number  	= 16;
	private var _padding:Number		= 3;
	
	// Sprites
	private var _holderMc:Sprite;
	private var _trackMc:Sprite;
	private var _barMc:Sprite;
	private var _rightBtn:Sprite;
	private var _leftBtn:Sprite;
	
	// Colors
	private var _trackFill:Number 	= 0x494F57;			//
	private var _trackStroke:Number	= 0x767676;			// Default colors
	private var _barFill:Number		= 0xFFFFFF;			//
	
	// Math
	private var _trackWidth:Number;						// The static width of the track
	private var _scrollWidth:Number;					// This is the horizontal width the scrollbar moves in
	private var _percentOfContentVisible:Number = 0.5;	// The quotient of the window's width / target's width
	
	// Dragging
	private var _dragArea:Rectangle;
	private var _isDragging:Boolean;
	private var _currentPercent:Number = 0;
	
	/** 
	*	Constructor
	*	
	*	@param		The sprite to build the scrollbar in
	*	@param		How wide (or tall) the scrollbar should be
	*	@param		Whether the scrollbar should be VERTICAL or HORIZONTAL
	*/
	public function Scroller( $parentMc:Sprite, $width:Number, $orientation:String = HORIZONTAL ):void
	{
		_trackWidth	= $width;
		_holderMc 	= new Sprite();
		$parentMc.addChild( _holderMc );
		_make();
		_changeOrientation( $orientation )
	}
	
	// ______________________________________________________________ Make
	
	private function _make (  ):void
	{
		_trackMc 	= new Sprite();
		_barMc		= new Sprite();
		
		_holderMc.addChild( _trackMc );
		_holderMc.addChild( _barMc   );
		
		_barMc.buttonMode = true;
		_barMc.addEventListener( MouseEvent.MOUSE_DOWN, _startScroll );
		_barMc.stage.addEventListener( MouseEvent.MOUSE_UP, _stopScrolling );
		
		_drawTrack();
		updateScrollWindow(0);
	}   
	
	private function _changeOrientation( $orientation:String )
	{
		if( $orientation == HORIZONTAL ){
			_holderMc.x = _padding;
		}else{
			_holderMc.rotation = 90;
			_holderMc.x = _barHeight + _padding;
		}

		_holderMc.y = _padding;
	}
	
	// ______________________________________________________________ API
	
	/** 
	*	This changes the bar-width to track-width ratio
	*	
	*	@param		The percentage (0 - 1) of the target that is visible in the window 
	*/
	public function updateScrollWindow ( $percentVisible:Number ):void
	{
		_percentOfContentVisible = $percentVisible;
		_scrollWidth = _trackWidth - (_trackWidth * _percentOfContentVisible);
		Tweener.addTween( this, { tweenWidth:_trackWidth * _percentOfContentVisible, time:1, transition:"EaseInOutQuint", onUpdate:_tweenUpdate } );
		changeScrollPosition( _currentPercent );
	}
	
	/** 
	*	Manually changes the scrollbar's position (0 - 1)
	*	
	*	@param		The scrollbar's percentage (0 - 1), 0 is at left (or top), 1 is at right, (or bottom)
	*/
	public function changeScrollPosition ( $percent:Number ):void
	{
		Tweener.addTween( _barMc, { x:_scrollWidth * $percent,time:1, transition:"EaseInOutQuint"} );
	}
	
	// Called on tween update, see:  updateScrollWindow()
	private function _tweenUpdate (  ):void
	{
		_drawBar();
	}
	
	// ______________________________________________________________ Drawing
	
	// This is called by via Tweener. see: updateScrollWindow()
	public function _drawBar ():void
	{
		_barMc.graphics.clear();
		_barMc.graphics.beginFill( _barFill );
		_barMc.graphics.drawRoundRect(0, 0, tweenWidth, _barHeight, _barHeight, _barHeight);
		_dragArea = new Rectangle(0, 0, _scrollWidth, 0)
	}
	
	public function _drawTrack ():void
	{
		_trackMc.graphics.beginFill( _trackFill );
		_trackMc.graphics.lineStyle( 1, _trackStroke );
		_trackMc.graphics.drawRoundRect(-_padding, -_padding, _trackWidth + _padding * 1.8, _barHeight + _padding * 1.8, _barHeight + _padding, _barHeight + _padding);
	}
	
	// ______________________________________________________________ Scrolling Event Handlers
	
	private function _startScroll ( e:Event ):void
	{
		_isDragging = true;
		_barMc.startDrag( false, _dragArea );
		_barMc.stage.addEventListener( MouseEvent.MOUSE_MOVE, _sendScrollEvent );
	}
	
	private function _stopScrolling ( e:Event ):void
	{
		if( _isDragging ) 
		{
			_isDragging = false;
			_barMc.stopDrag();
			_barMc.stage.removeEventListener( MouseEvent.MOUSE_MOVE, _sendScrollEvent );
		}
	}
	
	private function _sendScrollEvent ( e:Event ):void
	{
		var scrollEvent:ScrollEvent = new ScrollEvent( SCROLL );
		scrollEvent.percent = _currentPercent = _barMc.x / _scrollWidth;
		this.dispatchEvent( scrollEvent );
	}
}

}