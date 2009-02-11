package app.view.components
{

import flash.display.Sprite;
import flash.utils.Timer;
import flash.events.*;

public class SlidesTimer extends Sprite
{
	public static const TICK:String = "tick";
	
	private var _timer:Timer;
	private var _slideDisplayTime:Number;
	
	public function SlidesTimer( $displayTime:Number ):void
	{
		_slideDisplayTime = $displayTime * 1000;
	}
	
	/** 
	*	Start the timer
	*/
	public function startTimer (  ):void
	{
		_timer = new Timer( _slideDisplayTime );
		_timer.addEventListener("timer", _tick);
		_timer.start();
	}
	
	/** 
	*	Stop the timer
	*/
	public function stopTimer (  ):void
	{
		if( _timer != null ) 
		{
			_timer.stop();
			_timer.removeEventListener("timer", _tick);
			_timer = null;
		}
	}
	
	// ______________________________________________________________ Event Handler
	
	private function _tick ( e:Event ):void
	{
		this.dispatchEvent( new Event( TICK, true ) );
	}
	
}

}