package components
{

import flash.display.MovieClip;
import flash.events.*;
import flash.text.TextField;
public class PaperTagsBtn extends MovieClip
{
	private var _btnTxt:TextField;
	private var _hitMc:MovieClip;
	private var _linkUrl:String;
	private var _linkTarget:String;
	
	public function PaperTagsBtn():void
	{
		this.buttonMode = true;
		_btnTxt = getChildByName("btnTxt") as TextField;
		_hitMc  = getChildByName("hitMc" ) as MovieClip;
		_btnTxt.autoSize = "left";
		_hitMc.addEventListener( MouseEvent.MOUSE_OVER, _mouseOver );
		_hitMc.addEventListener( MouseEvent.MOUSE_OUT,  _mouseOut  );
	}
	
	public function changeInfo ( $txt:String, $link:String, $target:String ):void
	{
		_btnTxt.text = $txt;
		_linkUrl	 = $link;
		_linkTarget  = $target;
		_hitMc.width = _btnTxt.textWidth + 10;
	}
	
	override public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
	{
		_hitMc.addEventListener( type, listener );
	}
	
	private function _mouseOver ( e:Event ):void
	{
		this.alpha = 0.7;
	}
	
	private function _mouseOut ( e:Event ):void
	{
		this.alpha = 1;
	}
	
	public function get link 		(  ):String{ return _linkUrl; };
	public function get linkTarget 	(  ):String{ return _linkTarget; };
	
}
}