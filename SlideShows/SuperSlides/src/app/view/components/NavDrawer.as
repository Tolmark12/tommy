package app.view.components
{

import flash.display.*;
import flash.events.*;

public class NavDrawer extends MovieClip
{
	// Events
	public static const NEXT_SLIDE:String = "next_slide";
	public static const PREV_SLIDE:String = "prev_slide";

	// Main holder
	private var _controlsMc:Sprite = new Sprite();
	
	// Arrow Btns
	private var _leftBtn:ArrowBtn_swc = new ArrowBtn_swc();
	private var _rightBtn:ArrowBtn_swc = new ArrowBtn_swc();
	
	public function NavDrawer():void
	{
		
	}
	
	/** 
	*	Initialize, create the buttons, set the right position. Etc. 
	*/
	public function init (  ):void
	{
		// Positioning
		_controlsMc.x = 30;
		_controlsMc.y = -40;
		_leftBtn.x = 10;
		_rightBtn.x = 40;
		_rightBtn.scaleX = -1;

		// Events
		_leftBtn.addEventListener( MouseEvent.CLICK, _onLeftClick, false,0,true );
		_rightBtn.addEventListener( MouseEvent.CLICK, _onRightClick, false,0,true );
		
		// Add to stage
		this.addChild(_controlsMc);
		_controlsMc.addChild(_leftBtn);
		_controlsMc.addChild(_rightBtn);
	}
	
	// ______________________________________________________________ Event handlers
	
	private function _onLeftClick ( e:Event ):void{
		this.dispatchEvent( new Event( NEXT_SLIDE, true) );
	}
	
	private function _onRightClick ( e:Event ):void{
		this.dispatchEvent( new Event( PREV_SLIDE, true) );
	}

}

}