package app.view.components
{

import flash.display.Sprite;
import flash.events.*;
import flash.filters.*;
import caurina.transitions.Tweener;

public class Slide extends Sprite
{
	public static const GOTO_URL:String = "goto_url";
	public static const SHOW_DETAILS:String = "show_details";
	
	private var _href:String;
	public var hrefTarget:String;
	public var showDetailsOnClick:Boolean = false;
	
	public function Slide():void
	{	
	}

	// ______________________________________________________________ Event Activation / Deactivation
	
	public function activateClickEvent (  ):void
	{
		if( _href.length != 0 ) 
		{
			this.buttonMode = true;
			this.addEventListener( MouseEvent.MOUSE_OVER, _mouseOver );
			this.addEventListener( MouseEvent.MOUSE_OUT, _mouseOut );
			this.addEventListener( MouseEvent.CLICK, _click );
			this.addEventListener( MouseEvent.CLICK, _click );
		}
		
	}
	
	public function deactivateClickEvent (  ):void
	{
		this.buttonMode = false;
		this.removeEventListener( MouseEvent.CLICK, _click );
		this.removeEventListener( MouseEvent.MOUSE_OVER, _mouseOver );
		this.removeEventListener( MouseEvent.MOUSE_OUT, _mouseOut );
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _click ( e:Event ):void
	{
		if( _href.length != 0 ){
		 	if( _href != "show_details" ) 
				this.dispatchEvent( new Event( GOTO_URL ) );
			else
				this.dispatchEvent( new Event( SHOW_DETAILS ) );
		}
	}
	
	
	private function _mouseOut ( e:Event ):void
	{
		Tweener.addTween( this, { _amt:0, time:0.4, transition:"EaseInOutQuint", onUpdate:_updateMatrix} );
	}
	
	private function _mouseOver ( e:Event ):void
	{
		Tweener.addTween( this, { _amt:20, time:0.4, transition:"EaseOutQuint", onUpdate:_updateMatrix} );
	}
	
	public var _amt:uint;
	private function _updateMatrix (  ):void
	{
		var _brightMatrix:Array  = [1,0,0,0,_amt,0,1,0,0,_amt,0,0,1,0,_amt,0,0,0,1,0];
		var filter:ColorMatrixFilter = new ColorMatrixFilter(_brightMatrix);
		this.filters = [ filter ];
	}
	
	// ______________________________________________________________ Getters / setters
	
	public function set href ( $str:String ):void 	{ _href = $str};
	public function get href (  ):String			{ return _href; };
	
}

}