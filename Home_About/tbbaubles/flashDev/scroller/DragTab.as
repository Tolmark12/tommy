import mx.transitions.Tween;
import mx.transitions.easing.*;
import mx.utils.Delegate;

class scroller.DragTab extends MovieClip
{
	// MovieClips
	private var dumbBtn:MovieClip;  // Set in the .fla
	private var scrollArrowBottom:MovieClip;
	private var scrollArrowTop:MovieClip;
	private var scrollMiddle:MovieClip;
	
	// Scrolling
	private var 		perc:Number;
	private var 		ceil:Number;
	private var 		flor:Number;
	private var 		xPos:Number;
	private var 		maskTal:Number;
	private static var  tal:Number = 105;
	private var 		scrollTarget:Object;
	private var 		scrollWindowTop:Number;
	private var 		highlightMc:MovieClip;
	private var 		alphaTwn:Tween;
	private var 		targetTween:Tween;
	private var 		dragTabTween:Tween;
	
	// for finding the scroll percentage
	private var origY:Number;
	private var scrollSpace:Number;

	
	// Dragging Functionality
	public function DragTab()
	{
		perc = 0;
		dumbBtn.con = scrollArrowBottom.con = scrollArrowTop.con = this;
		dumbBtn.onRollOver = function() { this.con.RollOver();   };
		dumbBtn.onRollOut  = function() { this.con.RollOut();   };	
		dumbBtn.onPress    = function() { this.con.Press();   };
		dumbBtn.onRelease  = dumbBtn.onReleaseOutside 
		                   = function() { this.con.Release(); };
		
		scrollArrowBottom.onPress   = function() { this.con.arrowPress( 'botm' );   };
		scrollArrowBottom.onRelease = dumbBtn.onReleaseOutside 
						            = function() { this.con.arrowRelease( 'botm' ); };
						
		scrollArrowTop.onPress  	= function() { this.con.arrowPress( 'top' );   };
		scrollArrowTop.onRelease 	= dumbBtn.onReleaseOutside 
									= function() { this.con.arrowRelease( 'top' ); };
		_visible = false;
	}
	
	private function updatePercentage ( $perc:Number ):Void
	{
		trace(this._xmouse  + '  :  ' + this._x)
		if( this._xmouse > -172 )
		{
			perc = ( $perc == undefined )? ( (this._y - ceil)/ scrollSpace  ) : $perc ;
			scrollTarget._y = ceil - scrollWindowTop * perc;
			updateAfterEvent();
		}
		else
		{
			Release();
		}
		
	}
	
	// Event Handlers
	public function Press (  ):Void
	{
		this.startDrag( false,xPos,ceil,xPos,flor );
		this.onMouseMove = updatePercentage;
	}
	
	public function Release (  ):Void
	{
		this.stopDrag()
		this.onMouseMove = null;
	}
	
	private function RollOver (  ):Void
	{
		scrollMiddle._alpha = 100;
	}
	
	private function RollOut (  ):Void
	{
		scrollMiddle._alpha = 0;
	}
	
	// Display Fynctions
	public function hide (  ):Void
	{
		alphaTwn.stop();
		alphaTwn = new Tween( this, "_alpha", Regular.easeInOut, _alpha, 0, 3, false);
		alphaTwn.onMotionFinished = Delegate.create(this, makeInVisible);
	}
	
	public function makeInVisible (  ):Void { _visible = false; };
	
	public function show (  ):Void
	{
		_visible = true;
		alphaTwn.stop();
		alphaTwn = new Tween( this, "_alpha", Regular.easeInOut, _alpha, 100, 2, false);
	}
	
	//For Scrolling with small Arrows
	public function arrowPress ( $arrow:String ):Void
	{
		if( $arrow == 'top' )
		{
			//trace('top');
		}else{
			//trace('bottom');
		}
	}
	
	public function arrowRelease ( $arrow:String ):Void
	{
		var targY:Number;
		
		if( $arrow == 'top' )
		{
			targY = ( scrollWindowTop - scrollTarget._y - scrollSpace > 0)? scrollTarget._y - scrollSpace : "ceil" ;	
		}else{
			targY = ( scrollWindowTop - scrollTarget._y - scrollSpace > 0)? scrollTarget._y - scrollSpace : "flor" ;			
		}
		//trace($arrow + '  :  ' + targY)
	}
	
	// Getters and Setters
	public function setDragInfo( $ceil:Number, $floor:Number, 
								 $maskHeight:Number, $scrollObjectHeight:Number,
								 $target:Object ) 
	{
		ceil    	      = $ceil + 5;
		flor    	      = ($floor - tal);
		maskTal 	      = $maskHeight;
		xPos    	      = this._x;
		scrollSpace       = ceil - flor;
		scrollTarget      = $target
		scrollWindowTop   = $ceil - ($scrollObjectHeight + 10 - maskTal);
		this._y = ceil;
		
		if(maskTal < $scrollObjectHeight - 40)
		{
			show();
		}else{
			hide();
		}
	}
}