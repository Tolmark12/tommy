import mx.transitions.Tween;
import mx.transitions.easing.*;

import lib.loadManager.ImageLoader

class lib.slides.Slide
{
	private static var	fadeSpeed:Number = 37;
	
	
	private var wrapMc 		:MovieClip;
	private var imageMc 	:MovieClip;
	private var file		:String;
	private var text		:String;
	private var link		:String;
	private var twnA 		:Tween;
	private var loadStatus	:String;
	private var index		:Number;

	public function Slide( $f:String, $t:String, $l:String, $i:Number )
	{
		file  = $f;
		text  = $t;
		link  = $l;
		index = $i;
		loadStatus = 'notLoaded';
	}
	
	
	// ---------- Make Movie Clip ---------- //
	public function make ( $mc:MovieClip ):Void
	{
		wrapMc  = $mc;
		imageMc = wrapMc.createEmptyMovieClip( 'imageMc',1 );
		wrapMc._alpha = 0;
	}
	
	// ---------- Load the Image ---------- //
	public function loadImage ( $image:String ):Void
	{
		if( loadStatus == 'notLoaded' )
		{
			loadStatus = 'loading';
			var ldr = new ImageLoader( file, imageMc );			
			ldr.setCallBacks( this, 'imageLoadedCallBack' );

			// - Add item to load queue -  
			// ldr.addItemToLoadQueue(); 
			// - or to load immediately: - 
			ldr.loadItem();
		}else{
			wrapMc._alpha = 0;
			fadeIn();
		}
	}
	
	public function imageLoadedCallBack (  ):Void
	{
		loadStatus = 'loaded';
		fadeIn();
	}
	
	// ---------- Fading Functions ---------- //
	public function fadeIn  (  ):Void { fadeTo(100);}
	public function fadeOut (  ):Void { fadeTo(0); 	}
 	public function fadeTo  ( $targ:Number ):Void
	{
		twnA.stop();
		twnA = new Tween( wrapMc, "_alpha", Regular.easeInOut, wrapMc._alpha, $targ, fadeSpeed, true);
	}
	
	public function remove (  ):Void
	{
		
	}
	
	public function swapDepths ( $newDepth ):Void
	{
		wrapMc.swapDepths( $newDepth );
	}
	
	public static function setFadeSpeed ( $speed:Number ):Void{ fadeSpeed = $speed; };
	public function getText  (  ):String{ return text; };
	public function getIndex (  ):Number{ return index; };
}
