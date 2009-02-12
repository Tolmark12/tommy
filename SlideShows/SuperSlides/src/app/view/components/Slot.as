package app.view.components
{

import flash.display.Sprite;
import caurina.transitions.Tweener;

public class Slot extends Sprite
{
	public var id:String;
	public var isLoaded:Boolean = false;
	public var isInitiallyHidden:Boolean = false;
	
	public function Slot():void
	{
		
	}
	
	public function hide (  ):void
	{
		this.visible = false;
	}
	
	public function show (  ):void
	{
		this.visible = true;
		this.alpha = 0;
		Tweener.addTween( this, { alpha:1, time:2, transition:"EaseInOutQuint"} );
	}
	
}

}