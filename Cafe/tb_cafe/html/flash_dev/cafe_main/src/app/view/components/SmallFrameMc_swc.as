package app.view.components
{
	
import flash.display.*;
import delorum.loading.ImageLoader;
import flash.geom.ColorTransform;
import gs.TweenLite;
import flash.events.*;
import caurina.transitions.Tweener;

public class SmallFrameMc_swc extends MovieClip
{
	public var clickIndex:uint;
	private var _picHolder:Sprite;
	private var _active:Boolean = false;
	private var _frameMc:MovieClip;
	
	public function SmallFrameMc_swc (  ):void
	{
		this.buttonMode = true;
		this.addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, _mouseOut);
		_frameMc = getChildByName("frameMc") as MovieClip;
	}
	
	public function loadImage ( $path:String ):void
	{
		_picHolder = new Sprite();
		_picHolder.x = 5;
		_picHolder.y = 5;
		this.addChild(_picHolder);
		var ldr:ImageLoader = new ImageLoader( $path, _picHolder );
		this.setChildIndex(_frameMc,this.numChildren -1);
		var pos:String = ldr.addItemToLoadQueue();
	}
	
	// ______________________________________________________________ Changing state
	public function select (  ):void
	{
		_active = true;
		this._frameMc.transform.colorTransform = new ColorTransform(1,.93,.84,1,0,0,0,0);
		//TweenLite.to(this._frameMc, 0.2, {tint:0xB57B63});
	}
	
	public function unSelect (  ):void
	{
		_active = false;
		this._frameMc.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
		//TweenLite.to(this._frameMc, 0.2, {tint:null});
	}
	
	
	
	// ______________________________________________________________ Hiding / Showing
	
	public function hide (  ):void
	{
		Tweener.addTween(this, {alpha:0,time:0.4});
	}
	
	public function show (  ):void
	{
		Tweener.addTween(this, {alpha:1,time:0.4});
	}
	
	// ______________________________________________________________ Event Handlers
	private function _mouseOver ( e:Event ):void
	{
		if(!_active)
			this._frameMc.transform.colorTransform = new ColorTransform(1,.93,.84,1,0,0,0,0);
	}
	
	private function _mouseOut ( e:Event ):void
	{
		if(!_active)
			this._frameMc.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
	}

	
}

}