package app.views
{
import app.AppFacade;
import app.Model.vo.Slide_VO;

import caurina.transitions.Tweener;

import components.VideoPlayer;

import delorum.loading.ImageLoader;

import flash.display.Sprite;
import flash.events.*;
import flash.external.ExternalInterface;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;


public class MainSlideMediator extends Mediator implements IMediator
{
	public static const NAME:String	= "main_slide_mediator";
	
	private var _slides:Object = new Object();
	private var _slideHolder:Sprite;
	private var _newSlide:Sprite;
	private var _oldSlide:Sprite;
	private var _currentSlideVO:Slide_VO;
	private var _invisibleButton:Sprite;
	
	public function MainSlideMediator($mainSlide:PaperFrame_swc)
	{
		super(NAME, $mainSlide);
		_slideHolder = new Sprite(); 
		mainSlide.addChild(_slideHolder);
		mainSlide.moveFrameToFront();
		_createMaskAndHitArea();
	}
	
	public function get mainSlide():PaperFrame_swc
	{
		return this.getViewComponent() as PaperFrame_swc;
	}
	
	override public function listNotificationInterests():Array
	{
		return [
					AppFacade.DISPLAY_NEW_SLIDE
				];
	}
	
	override public function handleNotification(notification:INotification):void
	{
		switch(notification.getName())
		{
			case AppFacade.DISPLAY_NEW_SLIDE :
				_swapSlides(notification.getBody() as Slide_VO);
				break;
		}
	}
	
	/** Set the "_newSlide" variable in preparation to showing the slide */
	private function _swapSlides ( $slide:Slide_VO ):void
	{
		_currentSlideVO = $slide;
		var id:String = $slide.slideId;
		_oldSlide = _newSlide;
		
		if( _slides[id] == null )
		{
			//...create it...
			_slides[id] = new Sprite();
			_newSlide = _slides[id];
			_slideHolder.addChild( _newSlide );
			_newSlide.x = 25;
			_newSlide.y = 25;
			
			if($slide.mediaType == Slide_VO.TYPE_MOVIE)
			{
				//load movie clip
				var videoPlayer:VideoPlayer = new VideoPlayer();
				_slides[id].addChild( videoPlayer );
				videoPlayer.x = 10;
				videoPlayer.y = -25;
				videoPlayer.loadVideo($slide.main);
			}
			else
			{
				// load image
				var ldr:ImageLoader = new ImageLoader( $slide.main, _slides[id] );
				ldr.onComplete = _showNewSlide;
				ldr.loadItem();
			}
		}
		else
		{
			//...else show existing slide.
			_newSlide = _slides[id];
			_showNewSlide();
			if($slide.mediaType == Slide_VO.TYPE_MOVIE)
			{
				var clip:VideoPlayer = _newSlide.getChildAt(0) as VideoPlayer;
				clip.playVideo();
			}
		}
		
		if(_oldSlide && _oldSlide.getChildAt(0) is VideoPlayer)
		{
			var oldClip:VideoPlayer = _oldSlide.getChildAt(0) as VideoPlayer;
			oldClip.rewind();
		}
		
		if( _currentSlideVO.fullImagePath != null ) 
		{
			trace( "true" );
			_invisibleButton.buttonMode = true;
			_invisibleButton.addEventListener(MouseEvent.CLICK, _mouseClick);
		}else{
			trace( "false" );
			_invisibleButton.buttonMode = false;
			_invisibleButton.removeEventListener(MouseEvent.CLICK, _mouseClick);
		}
		
		_setStackOrder();	
	}
	
	/** display new slide */
	private function _showNewSlide ( e:Event = null ):void
	{
		_newSlide.alpha = 0;
		Tweener.addTween(_newSlide, {alpha:1, time:2} );
	}
	
	private function _setStackOrder():void
	{
		_slideHolder.setChildIndex(_newSlide, _slideHolder.numChildren - 1);
	}
	
	private function _createMaskAndHitArea():void
	{
		var mask:Sprite = new Sprite();
		mask.graphics.beginFill(0x00000);
		mask.graphics.drawRect(35, 30, 450, 370);
		_slideHolder.addChild(mask);
		//apply mask
		_slideHolder.mask = mask;
		
		_invisibleButton = new Sprite();
		_invisibleButton.graphics.beginFill(0xFF0000,0);
		_invisibleButton.graphics.drawRect(35,30,330,370);
		mainSlide.addChild(_invisibleButton);
	}
	
	private function _mouseClick( e:Event ):void
	{
		trace( _currentSlideVO.fullImagePath );
		if( ExternalInterface.available ) 
			ExternalInterface.call('showFullAd',  _currentSlideVO.fullImagePath );
	}
}
}