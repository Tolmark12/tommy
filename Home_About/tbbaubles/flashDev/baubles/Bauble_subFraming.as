class baubles.Bauble_subFraming
{
	private var subMc:MovieClip
	private var framesTotal:Number;
	
	public function initSubFramer ( $mc:MovieClip ):Void
	{
		subMc = $mc
		subMc.framesTotal = subMc._totalframes;
	}
	
	public function subFramerPlay (  ):Void
	{
		subMc.onEnterFrame = function()
		{ 
			if(this._currentframe >= this.framesTotal -1) { this.onEnterFrame = null; };
			this.nextFrame();
		}
	}
	
	public function subFramerReverse (  ):Void
	{
		subMc.onEnterFrame = function()
		{
			if(this._currentframe <= 1) { this.onEnterFrame = null; };
			this.prevFrame();
		 }
	}
	
}