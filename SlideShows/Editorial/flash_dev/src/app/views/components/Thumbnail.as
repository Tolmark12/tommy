package app.views.components
{
import app.Model.vo.Slide_VO;

import delorum.loading.ImageLoader;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Thumbnail extends Sprite
{
	private var slide:Slide_VO;
	
	private var _border:Sprite;
	
	private var _isSelected:Boolean = false;
	
	public function Thumbnail( $slide:Slide_VO , isDefault:Boolean=false)
	{
		super();
		slide = $slide;
		if(isDefault)
			_isSelected = true;
		_loadImage();
		_initEvents();
	}
	
	public function setSelected( $condition:Boolean ):void
	{
		_isSelected = $condition;
	}
	
	public function get index():uint
	{
		return slide.slideIndex;
	}
	
	private function _loadImage():void
	{
		var ldr:ImageLoader = new ImageLoader( slide.thumbnailPath, this );
		ldr.onComplete = _imgLoaded;
		ldr.loadItem();
	}
	
	private function _imgLoaded( e:Event ):void
	{
		_createBorder();
		if(slide.mediaType == Slide_VO.TYPE_MOVIE)
			_addPlayButton();
	}
	
	private function _createBorder():void
	{
		_border = new Sprite();
		addChild(_border);
		setBorder((_isSelected)? 2 : 1);
	}
	
	private function _initEvents():void
	{
		addEventListener(MouseEvent.MOUSE_OVER, _mouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, _mouseOut);
	}
	
	private function _mouseOver( e:Event ):void
	{
		setBorder(2);
	}
	
	private function _mouseOut( e:Event ):void
	{
		if(_isSelected)
			return;
			
		setBorder(1);
	}
	
	
	private function _addPlayButton():void
	{
		var play:MovieBtn_swc = new MovieBtn_swc();
		addChild(play);
		play.x = 20;
		play.y = 20;
	}
	
	public function setBorder( $thickness:uint ):void
	{
		_border.graphics.clear();
		_border.graphics.lineStyle($thickness, 0x000000);
		_border.graphics.drawRect(0, 0, width+$thickness, height+$thickness);
	}
	
}
}