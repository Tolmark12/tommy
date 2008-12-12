package app.view.components
{

import flash.display.*;
import flash.text.TextField;
import gs.TweenLite;
import flash.events.*;

public class NavBtn extends MovieClip
{
	public static const NAV_CLICK:String = "nav_click";
	
	private static const COLOR_ACTIVE : uint = 0xF7732A;
	private static const COLOR_OVER : uint = 0x794723;
	private static const COLOR_UP : uint = 0x303030;
	
	private var _titleTxt:TextField;
	private var _hitArea:Sprite;
	
	public function NavBtn():void
	{
		_hitArea = new Sprite()
		this.addChild(_hitArea);
		_titleTxt = this.getChildByName("titleTxt") as TextField;
		_titleTxt.autoSize = "left";
	}
	
	public function initEvents ( $id:String ):void
	{
		if( $id == null ) 
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, _handlerMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, _handlerMouseOut);
			this.addEventListener(MouseEvent.CLICK, _handleClick);
		}
		else
		{
			TweenLite.to(this, 0, {tint:COLOR_OVER});
		}

	}
	
	private function _drawHitArea (  ):void
	{
		var xtra:uint = 5;
		_hitArea.graphics.beginFill(0xFF0000,0);
		_hitArea.graphics.drawRect(-xtra,-xtra,this.width + xtra*2, this.height + xtra*2)
	}
	
	
	// ______________________________________________________________ Event Handlers
	
	private function _handlerMouseOver ( e:Event ):void
	{
		TweenLite.to(this, 0, {tint:COLOR_OVER});
	}
	
	private function _handlerMouseOut ( e:Event ):void
	{
		TweenLite.to(this, 0.6, {tint:COLOR_UP});
	}
	
	private function _handleClick ( e:Event ):void
	{
		this.dispatchEvent( new Event( NAV_CLICK ) );
	}
	
	// ______________________________________________________________ Getters and Setters
	
	public function set text ( $txt:String ):void   { _titleTxt.text = $txt; _drawHitArea(); };
	public function get text ( 			   ):String { return _titleTxt.text;  };

	
}

}