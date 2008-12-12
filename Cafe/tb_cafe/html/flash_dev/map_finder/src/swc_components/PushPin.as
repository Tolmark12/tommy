package swc_components
{

import flash.display.MovieClip;
import caurina.transitions.Tweener;
import flash.events.*;

public class PushPin extends MovieClip
{
	public function PushPin():void
	{
		scaleX = scaleY = 0;
//		this.addEventListener( MouseEvent.MOUSE_OUT, _mouseOut   );
//		this.addEventListener( MouseEvent.MOUSE_OVER, _mouseOver );
	}
	
	public function show ( $speed:Number=0.4 ):void
	{
		scaleX = scaleY = 0;
		//var origY:Number = this.y;
		//this.y = -10;
		
		Tweener.addTween( this, { scaleX:1, scaleY:1, time:$speed, transition:"EaseOutBounce" } );
		//Tweener.addTween( this, { y:origY, time:0.3, transition:"EaseInQuint" } );
	}
	
	
	// ______________________________________________________________ Everns
	
	private function _mouseOver ( e:Event ):void
	{
		//var scale:Number = 1.1;
		//Tweener.addTween( this, { scaleY:scale, scaleX:scale, time:0.2, transition:"EaseInOutQuint"	} );
	}
	
	private function _mouseOut ( e:Event ):void
	{
		//Tweener.addTween( this, { scaleY:1, scaleX:1, time:0.1, transition:"EaseOutQuint"	} );
	}
	
}

}