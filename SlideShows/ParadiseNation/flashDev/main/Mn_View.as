import util.*;
import mvc.*;
import main.*;

import lib.slides.SlideShow;


class Mn_View extends AbstractView
{
	private var slideShow:SlideShow;
	
	public function Mn_View ( $m:Observable, $c:Controller, $photoMc:MovieClip, $xml:Object, $imagePath:String )
	{
		super($m, $c);
		make( $photoMc, $xml, $imagePath );
	}
	
	private function make ( $photoMc:MovieClip, $xml:Object, $imagePath:String ):Void
	{
		slideShow = new SlideShow( $photoMc, $imagePath );
		slideShow.setTiming ( Number($xml.globals.displayTime), Number($xml.globals.transitionSpeed) );
		slideShow.createSlideShow ( $xml.photos );
		slideShow.addObserverToModel ( this );
		
		Mn_Control( getController() ).initTotalSlides( slideShow.getTotalSlides() );
		
		// TODO: I should probably listen to the slideshow model's broadcast so that 
		// this class is informed as to the current slide (used to change text, and link)
	}
	
	// ---------- Update from Model's broadcast ---------- //
	public function update ( $o:Observable, $infoObj:Object )
	{
		//var info:Mn_UpdateVO = Mn_UpdateVO( $infoObj );
		var info = $infoObj;
		
		if( info.command != undefined )
		{
			slideShow.issueCommand( info.command );
			Mn_Control( getController() ).changeCurrentSlide( slideShow.getCurrentSlide() );
		}
		
		if( info.newSlideIndex != undefined )
		{
			Mn_Control( getController() ).changeCurrentSlide( slideShow.getSlideByIndex( info.newSlideIndex ), info.newSlideIndex );
		}
		
		
	}

	// ---------- Bind the Controller to this View ---------- //
	//public function defaultController (model:Observable):Controller { return new YourControllersClassName(model); }
}