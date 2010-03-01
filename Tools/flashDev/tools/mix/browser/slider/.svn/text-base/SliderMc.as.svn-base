import tools.mix.browser.slider.*

class SliderMc extends MovieClip
{
	// Mcs
	private var trackMc	:MovieClip;
	private var dragMc	:MovieClip;
	// Callback
	private var cbObj	:Object;
	private var cbFnc	:String;
	
	// Dragging vars
	private var trackLen:Number;
	public var left:Number;
	public var right:Number;
	public var top:Number;
	
	public function SliderMc()
	{
		make();
	}
	
	// _______________________________________________________________________ Make
	
	private function make (  ):Void
	{
		trackLen = trackMc._width;
		left  = trackMc._x;
		right = trackMc._x + trackMc._width;
		top   = trackMc._y;
		
		dragMc._x = trackLen;
		dragMc.con = this;
		dragMc.onRollOver = function(){this._alpha = 60};
		dragMc.onRollOut = function(){this._alpha = 100};

		dragMc.onPress = function()
		{
			this.startDrag(false, this.con.left, this.con.top, this.con.right, this.con.top);
			this.onEnterFrame = function()
			{
				this.con.updatePercentage();
			}
		}
		dragMc.onRelease = dragMc.onReleaseOutside = function()
		{
			this.stopDrag();
			this.onEnterFrame = null;
			this.onRollOut();
			//this.con.updatePercentage();
		}
	}
	
	public function updatePercentage (  ):Void
	{
		var perc = (dragMc._x - left)/trackLen;
		cbObj[cbFnc](1-perc);
	}
	
	public function setSlideCallBack ( $cbo:Object, $cbf:String ):Void
	{
		cbObj = $cbo;
		cbFnc = $cbf
	}
}