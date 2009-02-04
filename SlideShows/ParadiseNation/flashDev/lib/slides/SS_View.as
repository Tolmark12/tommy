import util.*;
import mvc.*;
import lib.slides.*

class SS_View extends AbstractView
{
	private var mainMc:MovieClip;
	private var slides			:Array;
	
	
	// Variable paramaters controlling how the slideshow behaves
	private var transitionSpeed:Number;
	private var displayTime		:Number;
	private var highestDepth:Number;
	
	public function SS_View ( $m:Observable, $c:Controller, $mc:MovieClip )
	{
		super($m, $c);
		mainMc = $mc;
	}
	
	// ---------- Update from Model's broadcast ---------- //
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info = SS_Update_VO( $infoObj );
		
		if( info.newSlideAr != undefined )
		{
			addSlides(info.newSlideAr);
			// Build out the movieclips holding the slides
		}
		
		if( info.newSlideIndex != undefined )
		{
			var slide:Slide = slides[info.newSlideIndex];
			// Incrament depth of fading in slide so it is above all other slides
			slide.swapDepths(highestDepth++);
			slide.loadImage();
			SS_Control( getController() ).sendNewSlide(slide);
			// set old slide visibility to "false"
		}
	}
	
	// ---------- Adding and Removing the slides ---------- //
	private function addSlides ( $ar:Array ):Void
	{
		removeCurrentSlides()
		
		slides = $ar;
		var slide:Slide;
		
		var len:Number = slides.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			slide = Slide(slides[i])
			var mc:MovieClip = mainMc.createEmptyMovieClip('slide'+i, i);
			slide.make ( mc );
		}
		highestDepth = len +5;
	}
	
	private function removeCurrentSlides (  ):Void
	{
		// remove and slids
	}
	
	public function setTransitionSpeed  ( $speed:Number   ):Void { Slide.setFadeSpeed($speed) };
}