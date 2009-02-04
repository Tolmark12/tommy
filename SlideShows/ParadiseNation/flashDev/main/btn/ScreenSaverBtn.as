import mx.transitions.Tween;
import mx.transitions.easing.*;
import flash.filters.DropShadowFilter;
import mx.utils.Delegate;



class main.btn.ScreenSaverBtn extends MovieClip
{
	private var mainMc	:MovieClip;
	private var smallBtn:MovieClip;
	// Inside MainMc
	private var topMc	:MovieClip;
	private var midMc	:MovieClip;
	private var btmMc	:MovieClip;
	private var sizesMc	:MovieClip;
	
	// Tweening
	private var twnA1			:Tween;
	private var twnA2			:Tween;
	private var twnYS			:Tween;
	private var twnY			:Tween;
	private var speed			:Number = .3;
	private var state			:String;
	private var originalHeight	:Number;
	private var openHeight		:Number = 70;
	
	public function ScreenSaverBtn()
	{
		make();
	}
	
	public function resizeBtn ( $height:Number ):Void
	{
		if( $height != undefined ) 
		{
			twnYS.stop();
			twnY.stop();

			twnYS = new Tween( midMc, "_height", Regular.easeInOut, midMc._height, $height, speed, true);
			twnY  = new Tween( btmMc, "_y", Regular.easeInOut, btmMc._y,		$height + midMc._y, speed, true);
		}
	}
	
	public function make (  ):Void
	{
		mainMc._visible = false;
		topMc	= mainMc.topMc;
		midMc	= mainMc.midMc;
		btmMc	= mainMc.btmMc;
		sizesMc	= mainMc.sizesMc;
		
		var dropShadow:DropShadowFilter = new DropShadowFilter(5, 90, 0x000000, 0.1, 2,5, 2, 7);
		this.filters = [dropShadow];
		midMc.onRelease =  Delegate.create( this, Release );
		smallBtn.onRollOver = Delegate.create( this, RollOver );
		midMc.onReleaseOutside = midMc.onRollOut =  Delegate.create( this, RollOut );
		originalHeight = midMc._height;
	}
	
	public function Release (  ):Void
	{
		if( state == "open" || state == "opening" ) 
		{
			rollUp();
		}
		else
		{
			dropDown()
		}
	}
	
	public function dropDown (  ):Void
	{
		
		state = "opening";
		resizeBtn( openHeight );
		showSizes();
	
	}
	
	public function rollUp (  ):Void
	{
		state = "closed";
		resizeBtn( originalHeight );
		hideSizes();
	}
	
	public function RollOver (  ):Void
	{
		twnA2.stop();
		twnA2  = new Tween( mainMc, "_alpha", Regular.easeInOut, mainMc._alpha, 100, .3, true);
		mainMc._visible = true;
	}
	
	public function RollOut (  ):Void
	{
		twnA2.stop();
		twnA2  = new Tween( mainMc, "_alpha", Regular.easeInOut, mainMc._alpha, 0, .3, true);
		twnA2.onMotionFinished = Delegate.create(this,hideMainMc);
		rollUp();
	}
	
	public function hideMainMc (  ):Void
	{
		mainMc._visible = false;
	}
	
	// ---------- Changing sizes visibility ---------- //
	
	public function changeSizeVisiblity ( $alpha:Number ):Void
	{
		twnA1.stop();
		twnA1  = new Tween( sizesMc, "_alpha", Regular.easeInOut, sizesMc._alpha, $alpha, .3, true);
	}
	public function showSizes (  ):Void
	{
		changeSizeVisiblity ( 100 );
	}
	
	public function hideSizes (  ):Void
	{
		changeSizeVisiblity ( 0 );
	}
}