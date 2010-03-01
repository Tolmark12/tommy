import util.*;
import mvc.*;
import lib.product.attribute.OptionVo;
import lib.product.attribt_interface.drop.*;
import caurina.transitions.Tweener;
import mx.utils.Delegate;

class DM_Display extends AbstractView
{
	//Display
	private var mainMc	  	:MovieClip;
	private var triggerMc 	:MovieClip;
	private var buttonsMc 	:MovieClip;
	private var bgMc	  	:MovieClip;
	private var mainTitle	:TextField;
	private var dropMc		:MovieClip;
	private var widestText	:Number  = 5;
	private var buttonsAr	:Array;
	private var newYpos		:Number;
	
	public function DM_Display ( $m:Observable, $c:Controller, $mc:MovieClip )
	{
		super($m, $c);
		mainMc = $mc;
		make( mainMc );
	}
	
	// ---------- Update from Model's broadcast ---------- //
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info = DM_UpdateVO( $infoObj );
		
		// Open or Close the drop down
		if( info.isOpen != null ) {
			openOrCloseDropDown( info.isOpen )
		}
		
		// Change the options available
		if( info.optionsAr != null){
			createButtons ( info.optionsAr )
		}
		
		if( info.titleText != null ) 
		{
			setText(info.titleText);
		}
		
		// Change active button
		if( info.indexOfSelectedItem != null ) {
			setSelectedItem( info.indexOfSelectedItem );
		}
	}
	
	/////////////////////////////////////////////
	// ---------- Private Functions ---------- //
	/////////////////////////////////////////////

	
	// ---------- Createing buttons ---------- //
	private function createButtons ( newBtnsAr:Array ):Void
	{
		buttonsMc = bgMc.createEmptyMovieClip( 'buttonsMc', 5 );
		buttonsAr = new Array();
		var yInc:Number = 20;
		var yPos:Number;
		
		var len:Number = newBtnsAr.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			yPos = (i+1)*yInc;
			var obj = OptionVo( newBtnsAr[i] );
			// Todo: Should probably create a class for these buttons
			var mc:MovieClip = buttonsMc.attachMovie("typeTxtField", "typeTxtField" + i, i + 1, {_y:yPos});
			buttonsAr[i] = mc;
			mc.titleTxt.text = obj.val;
			
			mc.con 	 = super.getController()
			mc.index = i;
			// Temp 
			mc.onRelease = function(){ this.con.dropDownClick(this.titleTxt.text, this.index); };
			mc.onRollOver = function(){this._alpha = 50;};
			mc.onRollOut = function(){this._alpha = 100;};
			
			if( mc.titleTxt.textWidth > widestText )
			{
				widestText = mc.titleTxt.textWidth;
			}
			// Temp
		}
		bgMc.whiteBg._height = buttonsMc._height + 15
		bgMc.whiteBg._y = -buttonsMc._height - 12;
		resize();
		
		buttonsMc._y -= yPos + 12;
	}
	
	// ---------- Open / Close the drop down ---------- //
	private function openOrCloseDropDown ( $isOpen:Boolean ):Void
	{
		if($isOpen != null)
		{
			if( $isOpen ) 
			{ 
				bgMc._y = buttonsMc._height + 15;
				fadeTo(100, buttonsMc._height + 15);
			}
			else
			{     
				fadeTo(0, 0);
				//slideBgMcTo(0);
			}
		}
	}
	
	// ---------- Set which item is active ---------- //
	private function setSelectedItem ( $index:Number ):Void
	{
		buttonsAr[$index].onRelease();
	}
	
	// ---------- Building DropDown ---------- //
	private function make ( $holderMc:MovieClip ):Void
	{
		var dep:Number = $holderMc.getNextHighestDepth();
		
		// Make MovieClips
		mainMc    			 = $holderMc.createEmptyMovieClip( 'dropDown' + dep, dep );
		triggerMc 			 = mainMc.createEmptyMovieClip( 'triggerMc', 2 );
		dropMc			 	 = triggerMc.attachMovie('drop_down', 'dropDownBg', 1);
		mainTitle 			 = dropMc.titleMc.titleTxt;
		bgMc = dropMc.bgMc;
				
		// Set Event Handlers
		dropMc.dropDownMc.con = super.getController();
		dropMc.dropDownMc.onPress = function()
		{
			this.con.click("toggleOpen");
		}
		
		dropMc.dropDownMc.onDragOut = function()
		{
			this.onReleaseOutside = this.onDragRelease;
		}
		
		dropMc.dropDownMc.onDragRelease = function()
		{
			this.onReleaseOutside = undefined;
			this.con.click("toggleOpen");
		}
	}
	
	// ---------- Private  ---------- //
	private function slideBgMcTo ( $y ):Void
	{
		Tweener.addTween( bgMc, {_y:$y, time:.4, transition:"easeOutExpo"} )
	}
	
	private function fadeTo ( $alpha:Number, $yPos:Number ):Void
	{
		newYpos = $yPos;
		Tweener.addTween( bgMc, {_alpha:$alpha, time:.4, transition:"easeOutExpo", onComplete: Delegate.create(this, setYPos)} )
	}
	
	private function setYPos (  ):Void
	{
		bgMc._y = newYpos;
	}
	
	private function setText ( $str:String ):Void
	{
		mainTitle.text = $str;
		if( mainTitle.textWidth > widestText )
		{
			widestText = mainTitle.textWidth;
			resize();
		}
	}
	
	private function resize (  ):Void
	{
		var m:MovieClip = dropMc.dropDownMc.midMc;
		var r:MovieClip = dropMc.dropDownMc.rightMc;
		var l:MovieClip = dropMc.dropDownMc.leftMc;
		bgMc.whiteBg._width = widestText + 8;
		m._width = widestText;
		r._x = m._x + m._width;
	}
	
	
	private function remove (  ):Void
	{
		mainMc.removeMovieClip();
		triggerMc.removeMovieClip();
		mainMc.removeMovieClip();
	}
}