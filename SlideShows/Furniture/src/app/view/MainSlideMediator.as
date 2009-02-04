package app.view
{
import app.AppFacade;
import app.model.vo.Slide_VO;

import caurina.transitions.Tweener;

import delorum.loading.ImageLoader;

import flash.display.Sprite;
import flash.events.*;

import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;


public class MainSlideMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "main_slide_mediator";
	private var _slideHolder:Sprite;
	private var _descriptionHolder:Sprite;
	private var _progressHolder:Sprite;
	private var _slides:Object = new Object();
	private var _newSlide:Sprite;
	private var _oldSlide:Sprite;
	private var _newSlideDescription:TextMc_swc;
	private var _showDetailsButton:ShowDetailsBtn_swc;
	private var _closeDetailsButton:CloseDetailsBtn_swc;
	

	public function MainSlideMediator( $mainHolder:Sprite  ):void
	{
		super( NAME );
		_slideHolder 		= new Sprite(); 
		_descriptionHolder 	= new Sprite();
		_progressHolder		= new Sprite();
		_progressHolder.x 	= 335;
		_progressHolder.y 	= 200;
		
		$mainHolder.addChild(_slideHolder);
		$mainHolder.addChild(_descriptionHolder);
		$mainHolder.addChild(_progressHolder);

		_buildDescription();
   	}

	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ 	
					AppFacade.DISPLAY_NEW_SLIDE, 
					AppFacade.NEXT_SLIDE,
					AppFacade.TEST
				];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.DISPLAY_NEW_SLIDE:
				var newSlide:Slide_VO = note.getBody() as Slide_VO;
				_swapSlides( newSlide );
				_swapDescription( newSlide );
				_setStackOrder();
			break;
		}
	}
	
	// ______________________________________________________________ Private Methods
	
	// Set the "_newSlide" variable in preparation to showing the slide
	private function _swapSlides ( $slide:Slide_VO ):void
	{
		var id:String = $slide.slideId;
		_oldSlide = _newSlide;
		
		if( _slides[id] == null )
		{
			//...create it...
			_slides[id] = new Sprite();
			_newSlide = _slides[id];
			_slideHolder.addChild( _slides[id] );
			// load image
			var ldr:ImageLoader = new ImageLoader( $slide.largeImagePath, _slides[id] );
			ldr.onComplete = _showNewSlide;
			ldr.loadItem();
			
			var display:SimpleSpinner_swc = new SimpleSpinner_swc(  );
			ldr.connectToProgressDisplay( display );
			_progressHolder.addChild(display);
			display.build();
		}
		else
		{
			//...else show existing slide.
			_newSlide = _slides[id];
			_showNewSlide();
		}		
	}
	
	// Bring the current slide to the front, and display it. 
	private function _showNewSlide ( e:Event = null ):void
	{
		
		_newSlide.alpha = 0;
		Tweener.addTween(_newSlide, {alpha:1, time:2} );
	}
	
	private function _buildDescription():void
	{
		// TODO: remove this
		_descriptionHolder.visible = false;
		
		_newSlideDescription = new TextMc_swc();
		_descriptionHolder.addChild(_newSlideDescription);
//		_newSlideDescription.x = 675;
		_newSlideDescription.alpha = 0;
		
		//create a mask
		var mask:Sprite = new Sprite();
		mask.graphics.beginFill(0x00000);
		mask.graphics.drawRect(0, 0, 350, 480);
		_descriptionHolder.addChild(mask);
		mask.x = 350;
		//apply mask
		_newSlideDescription.mask = mask;
		
		//add show details button
		_showDetailsButton = new ShowDetailsBtn_swc();
		_descriptionHolder.addChild(_showDetailsButton);
		_showDetailsButton.x = 525;
		_showDetailsButton.y = 25;
		_showDetailsButton.buttonMode = true;
		//add button event listeners
		_showDetailsButton.addEventListener(MouseEvent.CLICK, _showSlideDescription);
		
		//add close details button
		_closeDetailsButton = new CloseDetailsBtn_swc();
		_newSlideDescription.addChild(_closeDetailsButton);
		_closeDetailsButton.x = 275;
		_closeDetailsButton.y = 5;
		_closeDetailsButton.buttonMode = true;
		_closeDetailsButton.addEventListener(MouseEvent.CLICK, _hideSlideDescription);
		
		
		
	}
	
	private function _swapDescription ( $slide:Slide_VO ):void
	{
		_newSlideDescription.displayTxt.htmlText = $slide.description;
	}

	private function _showSlideDescription( e:MouseEvent ):void
	{
			_newSlideDescription.x = 675;
			Tweener.addTween(_showDetailsButton, {alpha: 0, time: .3, onComplete: _hideButton});
			Tweener.addTween(_newSlideDescription, {x: 350, alpha: 1, time: 1});
	}

	private function _hideSlideDescription( e:MouseEvent ):void
	{
		Tweener.addTween(_newSlideDescription, {/*x:700,*/ time: .8, alpha: 0});
		Tweener.addTween(_showDetailsButton, {alpha: 1, time: 2, delay: .2});
		_showDetailsButton.visible = true;
	}
	
	private function _hideButton():void
	{
		_showDetailsButton.visible = false;
	}
	
	private function _setStackOrder():void
	{
		_slideHolder.setChildIndex(_newSlide, _slideHolder.numChildren - 1);
	}
}

}