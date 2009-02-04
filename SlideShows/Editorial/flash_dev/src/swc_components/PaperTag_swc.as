package swc_components
{

import flash.display.MovieClip;
import flash.events.*;
import flash.net.*;
import flash.text.TextField;

public class PaperTag_swc extends MovieClip
{
	private var _titleTxt:TextField;
	private var _bodyTxt:TextField;
	private var _btn1:PaperTagsBtn;
	private var _btn2:PaperTagsBtn;
	
	public function PaperTag_swc():void
	{
		_titleTxt = this.getChildByName( "titleTxt" ) as TextField;
		_bodyTxt  = this.getChildByName( "bodyTxt"  ) as TextField;
		_btn1     = this.getChildByName( "btn1" ) as PaperTagsBtn;
		_btn2     = this.getChildByName( "btn2" ) as PaperTagsBtn;
		
		_init();
		
		// Hide all content before make
		_btn1.alpha = _btn2.alpha = _titleTxt.alpha = _bodyTxt.alpha = 0;
	}
	
	// ______________________________________________________________ Make
	
	
	/**	
	*	Initialize text values and button event handlers  
	*	
	*	@param		The magazine name
	*	@param		The publication date
	*	@param		the body text
	*	@param		The top button's text
	*	@param		The top button's link
	*	@param		the bottom button's text
	*	@param		the bottom button's link
	*	*/
	public function changeInfo (  	$magazineTxt:String 	= null,
	 								$date:String			= null,
									$bodyTxt:String			= null,
									$btn1Txt:String			= null,
									$btn1Link:String		= null,
									$btn1LinkTarget:String 	= null,
									$btn2Txt:String			= null,
									$btn2Link:String		= null,
									$btn2LinkTarget:String	= null
								):void
	{
		var magText:String  = ($magazineTxt == null)? "" : $magazineTxt;
		var dateText:String	= ($date == null)? 		  "" : $date;
		
		_titleTxt.text 	= magText + ", " + dateText;
		_bodyTxt.text	= ($bodyTxt == null)? "" : $bodyTxt;
		
		_btn1.visible = ( $btn1Txt != null )? true : false;
		_btn2.visible = ( $btn2Txt != null )? true : false;
		
		_btn1.changeInfo( $btn1Txt, $btn1Link, $btn1LinkTarget );
		_btn2.changeInfo( $btn2Txt, $btn2Link, $btn2LinkTarget );
		
		// Show all active content
		_btn1.alpha = _btn2.alpha = _titleTxt.alpha = _bodyTxt.alpha = 1;
	}
	
	private function _init (  ):void
	{
		_btn2.addEventListener( MouseEvent.CLICK, _handleBtnClick );
		_btn1.addEventListener( MouseEvent.CLICK, _handleBtnClick );
	}
	
	// ______________________________________________________________ Event Handler
	
	public function _handleBtnClick ( e:Event ):void
	{
		var btn:PaperTagsBtn = e.currentTarget.parent as PaperTagsBtn;
		navigateToURL( new URLRequest( btn.link ), btn.linkTarget );
	}

}

}