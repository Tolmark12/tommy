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
	
	// Text
	private var _text:Txt;
	
	// Total slides
	private var _totalSlides:Number;
	
	public function NavDrawer():void
	{
		
	}
	
	/** 
	*	Initialize, create the buttons, set the right position. Etc. 
	*/
	public function init ( $totalSlides:Number ):void
	{
		// Set Vars
		_totalSlides 	 = $totalSlides;
		_text 			 = new Txt(60);
		
		// Positioning
		_controlsMc.x    += 30;
		_controlsMc.y    += 80;
		_leftBtn.x       = 10;
		_rightBtn.x      = 80;
		_rightBtn.scaleX = -1;
		_text.x          = 20;
		_text.y          = -10;
		_text.textSize	 = 20;


		// Events
		_leftBtn.addEventListener( MouseEvent.CLICK, _onLeftClick, false,0,true );
		_rightBtn.addEventListener( MouseEvent.CLICK, _onRightClick, false,0,true );
		
		// Add to stage
		this.addChild(_controlsMc);
		_controlsMc.addChild(_leftBtn);
		_controlsMc.addChild(_rightBtn);
		_controlsMc.addChild(_text);
	}
	
	public function changeSlide ( $slideIndex:Number ):void
	{
		_text.text = $slideIndex + " of " + _totalSlides;
	}
	
	// ______________________________________________________________ Event handlers
	
	private function _onLeftClick ( e:Event ):void{
		this.dispatchEvent( new Event( NEXT_SLIDE, true) );
	}
	
	private function _onRightClick ( e:Event ):void{
		this.dispatchEvent( new Event( PREV_SLIDE, true) );
	}
	
	public function get controls ():Sprite { return _controlsMc; };
}

}