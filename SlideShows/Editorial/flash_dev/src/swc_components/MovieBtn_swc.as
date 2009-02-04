package swc_components
{

import flash.display.MovieClip;

public class MovieBtn_swc extends MovieClip
{
	public function MovieBtn_swc():void
	{
		gotoAndStop("_out");
	}
	
	/**	Call this to show the "hover" state */
	public function rollOver (  ):void
	{
		this.gotoAndStop("_over");
	}
	
	/**	Call this to reset the visual state to normal */
	public function rollOut (  ):void
	{
		this.gotoAndStop("_out");
	}

}

}