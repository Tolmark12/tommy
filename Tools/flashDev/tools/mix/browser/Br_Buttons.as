import util.*;
import mvc.*;
import mx.utils.Delegate;
import tools.mix.browser.*;
import tools.mix.browser.slider.*;
import tools.mix.browser.txt_btn.TextBtn;



class tools.mix.browser.Br_Buttons extends AbstractView
{
	private var statusTxt		:MovieClip;
	private var holderMc		:MovieClip;
	private var haveBuiltBtns	:Boolean;
	
	public function Br_Buttons( $m:Observable, $c:Controller, $holderMc:MovieClip )
	{
		super($m, $c);
		holderMc = $holderMc;
		makeButtons( holderMc );
	}
	
	// _______________________________________________________________________ Model Update
	
	public function update ( $o:Observable, $infoObj:Object ):Void
	{

		var info = Browser_VO( $infoObj );
		
		if( info.newProductRange != undefined ) 
		{
			statusTxt.text = info.newProductRange  + ' of ' + info.totalItems;
		}
		
		
		// Called only once 
		if( info.categories != undefined && !haveBuiltBtns ) 
		{
			addCategoryButtons( info.categories );
			haveBuiltBtns = true;
		}
	}
	
	
	// _______________________________________________________________________ Build the Category buttons (Shirts, Pants, etc)
	
	private function addCategoryButtons ( $cats:Object ):Void
	{
		// Holder Mc
		var mc:MovieClip = holderMc.createEmptyMovieClip('categoryBtnsMc', 7);
		
		// Positioning
		mc._x = -40;
		mc._y = -5;
		var xPos = 0;
		
		// Depth
		var dep:Number = 1;
		var btn:MovieClip;
		
		// Create Category Buttons
		for ( var i:String in $cats ) 
		{
			btn = mc.attachMovie('categoryBtn','categoryBtn'+dep, dep+=1, {_x:xPos});
			btn.setText ( i );
			xPos += btn.getWidth()+10;
			btn.addSeparator();
			btn.setReleaseCallBack( Br_BtnsControl( getController() ), 'changeCategoryStatus', [i] )
		}
		btn.removeSeparator();
	}
	
	
	// _______________________________________________________________________ Create Next/Previous Btns
	
	private function makeButtons ( $mc:MovieClip ):Void
	{
		//var showBtn =  $mc.createEmptyMovieClip( 'showAllBtn', 5 );
		//var mc = showBtn.attachMovie('showAllBtn', 'tshowAllBtn', 2);
		//mc.onRelease = Delegate.create( getController(), getController()['toggleShowAll'] );
		//mc._x += 367;
		//mc._y -= 10;
		
		var midX = 122;
		var midY = 235;
		
		// TODO: Clean this mess up
		var sliderMc:MovieClip 	= $mc.createEmptyMovieClip( 'slideMc', 5 );
		sliderMc._x = 250;
		sliderMc._y = 8
		var slider	:SlideBar	= new SlideBar( sliderMc );
		slider.setSlideCallBack( getController(), 'changeViewPercentage' );
		
				
		var typeDisplay =  $mc.createEmptyMovieClip( 'typeBtn', 4 );
		var mc = typeDisplay.attachMovie('typeTxtField', 'textDisplay', 2);
		statusTxt = mc.titleTxt;
		mc._y = midY -10;
		mc._x = midX + 10;
		statusTxt.autoSize = true;
		statusTxt.selectable = false;
		
		var tempBtn2 = $mc.createEmptyMovieClip( 'tempBtn', 3 );
		var imageMc:MovieClip = tempBtn2.attachMovie('nextBtn', 'temper2', 2);
		imageMc.con = this;
		imageMc.onRelease = Delegate.create( getController(), getController()['prevSet'] );
		tempBtn2._xscale = -100;
		tempBtn2._x = midX;
		tempBtn2._y = midY;
		
		var tempBtn = $mc.createEmptyMovieClip( 'tempBtn', 2 );
		var imageMc:MovieClip = tempBtn.attachMovie('nextBtn', 'temper', 2);
		imageMc.con = this;
		imageMc.onRelease = Delegate.create( getController(), getController()['nextSet'] );
		tempBtn._x = midX + 100
		tempBtn._y = midY;
		
		// Position all mcs
		$mc._x += 50;
		
		
	}
	
	// _______________________________________________________________________ Bind the Browser Btn Controller to this view
	public function defaultController (model:Observable):Controller { return new Br_BtnsControl(model); }
}