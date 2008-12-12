import ClickHandler;

class baubles.Bauble_framing extends baubles.Bauble_subFraming
{
	private var hasRollOverFrames:Boolean;
	private var baubleMc:MovieClip;
	private var animationMc:MovieClip;
	private var frames_total:Number;
	
	private function addFramesMotionIfItExists ( $frameVar:String, $mc:MovieClip ):Void
	{
		animationMc = $mc;
		$mc.gotoAndStop(1);
		
		hasRollOverFrames = false;
		switch( $frameVar )
		{
			case "roll":
			hasRollOverFrames = true;
			break
			
			case "animation":
			hasRollOverFrames = true;
			rollOverFrames();
			break
		}
	}
	
	//---- Initializing ------//
	public function prepareFrames (  ):Void
	{
		frames_total = animationMc._totalframes;
		animationMc.con = this;
	}
	
	//---- Event Handlers ----//
	private function rollOverFrames (  ):Void
	{
		if( hasRollOverFrames )
		{
			animationMc.onEnterFrame = function(){ this.con.advanceFrame(); };
		}
	}
	private function rollOutFrames (  ):Void
	{
		if( hasRollOverFrames )
		{
			animationMc.onEnterFrame = function(){ this.con.retreatFrame(); };
		}
	}
	
	//---- Moving Functions ----//
	public function advanceFrame (  ):Void
	{
		if(animationMc._currentframe >= frames_total -1)
		{
			ClickHandler.notifyThatAnimationIsComplete( this );
			animationMc.onEnterFrame = null;
		}
		animationMc.nextFrame();
	}
	public function retreatFrame (  ):Void
	{
		if(animationMc._currentframe <= 1)
		{
			animationMc.onEnterFrame = null;
		}
		animationMc.prevFrame();
	}
}