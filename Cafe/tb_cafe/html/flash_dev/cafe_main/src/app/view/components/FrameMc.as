package app.view.components
{

import flash.display.MovieClip;

public class FrameMc extends MovieClip
{
	public static const NO_THUMBNAILS:String = "no_thumbnails";
	public static const YES_THUMBNAILS:String = "yes_thumbnails";
	
	private var _blueLineMask:MovieClip;
	
	public function FrameMc():void
	{
		var frameMc:MovieClip = getChildByName( "frameMc" ) as MovieClip;
		_blueLineMask = frameMc.blueFrame.masker;
	}
	
	public function setLineState ( $state:String=null ):void
	{
		switch( $state )
		{
			case NO_THUMBNAILS :
				_blueLineMask.gotoAndStop( NO_THUMBNAILS );
			break;
			
			case YES_THUMBNAILS:
			default:
				_blueLineMask.gotoAndStop( YES_THUMBNAILS )
			break
		}
		
	}

}

}