package app.view.components
{

import app.view.ThumbnailsMediator;
import flash.display.Sprite;
import flash.events.*;
import caurina.transitions.Tweener;

public class Scroller extends EventDispatcher
{
	// Events
	public static const SCROLL:String = "scroll";
	
	// Sprites
	private var _maskMc:Sprite;
	private var _scrollTarget:Sprite;
	
	// Scroll Values
	private var _originalX:Number;
	private var _scrollWidth:Number;
	private var _difference:Number;
	
	//
	private var _currentTarget:Number;	
	
	
	public function Scroller( $maskHolder:Sprite, $scrollTarget:Sprite ):void
	{
		_maskMc 		= $maskHolder;
		_scrollTarget 	= $scrollTarget;
		_originalX		= _scrollTarget.x
	}
	
	public function createMaskArea ( $w:int, $h:int ):void
	{
		_scrollWidth = $w;
		_maskMc.graphics.beginFill(0xFF0000);
		_maskMc.graphics.drawRect(0,0,$w,$h);
		_difference = _scrollTarget.width - _maskMc.width;
		
		_scrollTarget.mask = _maskMc;
		_maskMc.stage.addEventListener(MouseEvent.MOUSE_MOVE, _mouseMove );
	}
	
	// ______________________________________________________________ Scrolling
	/** 
	*	Scroll the content
	*	
	*	@param		Number from 0 - 1; O meaning content is at far left, 1 means content is at far right
	*/
	private function scrollContent ( $percentage:Number ):void
	{
		var incrament:uint = ThumbnailsMediator.THUMBNAIL_SPACING;
		var targ:Number = _difference * -$percentage;
		var xtra:Number = ( targ % incrament < -60 )? incrament :  0;
		
		targ = _originalX + (targ  - (targ % incrament)) - xtra;
		
		
		if( targ != _currentTarget ) 
		{
			_currentTarget = targ;
			Tweener.addTween( _scrollTarget, {x:targ, time:1.6, transition:"easeOutQuint"} );
			dispatchEvent( new Event( SCROLL ) );
		}
		
	}
	
	// ______________________________________________________________ Event Handlers
	
	// Find the scroll percentage based on the mouse position
	private function _mouseMove ( e:Event ):void
	{
		var perc:Number = Math.round( _maskMc.mouseX / _scrollWidth * 100 ) / 100;
		if( perc > 1 )
			perc = 1;
		else if( perc < 0)
			perc = 0
		
		scrollContent( perc );
	}
	

	
}

}