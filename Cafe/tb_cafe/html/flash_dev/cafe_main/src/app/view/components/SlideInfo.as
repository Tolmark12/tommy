package app.view.components
{

import flash.display.Sprite;
import flash.events.*;
import caurina.transitions.Tweener;
import flash.text.StyleSheet;

public class SlideInfo extends Sprite
{
	public static const SHOW_SLIDE_DETAILS:String = "show_slide_details";
	private var _text:TextMc_swc;
	private var _showDetailsButton:ShowDetailsBtn_swc;
	private var _closeDetailsButton:CloseDetailsBtn_swc;
	private var _styleSheet:StyleSheet;
	
	public function SlideInfo():void
	{
		this.visible = false;
		build();
	}
	
	// ______________________________________________________________ API
	
	public function setText ( $txt:String, $href:String ):void
	{
		if( $txt != "" ) 
		{
			this.visible = true;
			_text.displayTxt.htmlText = $txt;
			Tweener.addTween( this, { alpha:1, time:1, transition:"EaseInOutQuint"} );
						
			if( $href == "show_details" ) 
				_showDetailsButton.y = -400000;
			else
				_showDetailsButton.y = 25;
		}
		else
		{
			Tweener.addTween( this, { alpha:0, time:1, transition:"EaseInOutQuint", onComplete:_hideAndReset} );
		}
		_text.displayTxt.styleSheet = _styleSheet;
	}
	
	private function _hideAndReset (  ):void
	{
		this.visible = false;
		_hideSlideDescription()
	}
	
	// ______________________________________________________________ Make
	
	public function build (  ):void
	{
		_text = new TextMc_swc();
		this.addChild(_text);
//		_text.x = 675;
		_text.alpha = 0;

		//create a mask
		var mask:Sprite = new Sprite();
		mask.graphics.beginFill(0x00000);
		mask.graphics.drawRect(0, 0, 350, 480);
		this.addChild(mask);
		mask.x = 350;
		//apply mask
		_text.mask = mask;

		//add show details button
		_showDetailsButton = new ShowDetailsBtn_swc();
		this.addChild(_showDetailsButton);
		_showDetailsButton.x = 525;
		_showDetailsButton.y = 25;
		_showDetailsButton.buttonMode = true;
		//add button event listeners
		_showDetailsButton.addEventListener(MouseEvent.CLICK, showSlideDescription);

		//add close details button
		_closeDetailsButton = new CloseDetailsBtn_swc();
		_text.addChild(_closeDetailsButton);
		_closeDetailsButton.x = 275;
		_closeDetailsButton.y = 8;
		_closeDetailsButton.buttonMode = true;
		_closeDetailsButton.addEventListener(MouseEvent.CLICK, _hideSlideDescription);
	}
	
	// ______________________________________________________________ Text Styling
	
	public function applyStyleSheet ( $styleSheet:StyleSheet ):void
	{
		_styleSheet = $styleSheet;
		_text.displayTxt.styleSheet = $styleSheet;
	}
	
	// ______________________________________________________________ Event Handlers
	
	public function showSlideDescription( e:MouseEvent=null ):void
	{
		_text.x = 675;
		Tweener.addTween(_showDetailsButton, {alpha: 0, time: .3, onComplete: _hideButton});
		Tweener.addTween(_text, {x: 350, alpha: 1, time: 1});
		_text.displayTxt.styleSheet = _styleSheet;
		this.dispatchEvent( new Event(SHOW_SLIDE_DETAILS, true) );
	}

	private function _hideSlideDescription( e:MouseEvent=null ):void
	{
		Tweener.addTween(_showDetailsButton, {alpha: 1, time: 2, delay:.2});
		Tweener.addTween(_text, {/*x:700,*/ time: .8, alpha: 0, onComplete:_moveTextOffStage });
		_showDetailsButton.visible = true;
	}
	
	private function _moveTextOffStage ( ):void
	{
		_text.x = 300000;
	}
	
	private function _hideButton():void
	{
		_showDetailsButton.visible = false;
	}

	
}

}