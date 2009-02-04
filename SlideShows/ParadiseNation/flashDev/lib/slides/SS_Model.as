import util.Observable;
import lib.slides.*

class SS_Model extends Observable
{
	private var currentSlideIndex :Number;
	private var totalSlides 	  :Number;
	private var slidesAr		  :Array;	//An array full of "Slide.as" Objects
	private var currentSlide	  :Slide;
	private var autoPlayInterval  :Number;
	private var slideShowStatus	  :String;
	private var displayTime		  :Number;	// # of miliseconds to show the slide
	private var imagePath		  :String;
	
	public function SS_Model( $imagePath:String )
	{
		imagePath = $imagePath;
	}
	
	// ---------- Build Slides ---------- //
	public function createSlideShow ( $xml:Object ):Void
	{
		slidesAr = new Array();
		for( var i:String in $xml )
		{
			var slide = new Slide( imagePath + $xml[i].file, $xml[i].imageText, null, slidesAr.length );
			slidesAr.push( slide );
		}
				
		//  Notify observers that a new slide show is ready to be shown
		var info:SS_Update_VO = new SS_Update_VO();
		
		info.newSlideAr 	= slidesAr;
		currentSlideIndex	= slidesAr.length;
		totalSlides			= slidesAr.length;
		setChanged();
		notifyObservers( info );	
	}
	
	// ---------- Change existing slides ---------- //
	public function showCurrent	  (  ):Void{ gotoSlide( currentSlideIndex  	  ); };
	public function nextSlide 	  (  ):Void{ gotoSlide( currentSlideIndex + 1 ); };
	public function previousSlide (  ):Void{ gotoSlide( currentSlideIndex - 1 ); };
	public function firstSlide	  (  ):Void{ gotoSlide(0); 						 };
	public function gotoSlide	  ( $newIndex ):Void
	{
		if( $newIndex != currentSlideIndex ) // Make sure new slide isn't the one already showing
		{
			var info:SS_Update_VO = new SS_Update_VO();
			
			// If beyond either end of the list, loop to opposite end
			if( $newIndex < 0 )
			{
				currentSlideIndex = totalSlides -1;
			}else if( $newIndex >= totalSlides ) 
			{
				currentSlideIndex = 0;
			}else{
				currentSlideIndex = $newIndex;
			}
			
			// Update watchers
			info.newSlideIndex = currentSlideIndex;
			setChanged();
			notifyObservers( info );
		}
	}
	
	// Pausing the slide show
	public function startSlideShow (  ):Void
	{
		if(slideShowStatus != "running")
		{
			// Show current slide if it is not visible
			
			slideShowStatus = "running";
			nextSlide();
			clearInterval(autoPlayInterval);
			autoPlayInterval = setInterval( function($obj)
			{
				$obj.nextSlide();
			}, displayTime, this );
		}
	}
	
	// Starting the slide show
	public function stopSlideShow (  ):Void
	{
		slideShowStatus = "stopped";
		clearInterval(autoPlayInterval);
	}
	
	public function getCurrentSlide (  ):Slide
	{
		return currentSlide;
	}
	
	public function setCurrentSlide ( $slide:Slide ):Void
	{
		currentSlide = $slide;
	}
	
	public function setDisplayTime  ( $time:Number ):Void { displayTime  = $time; };
	public function setImagePath  	( $path:String ):Void { imagePath 	 = $path; };

	public function getSlideByIndex ( $ind ):Slide  { return slidesAr[$ind];  };
	public function getTotalSlides  ( $ind ):Number { return totalSlides; 	  };
	
}