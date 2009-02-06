package app.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.AppFacade;
import app.model.vo.*;

public class SlidesProxy extends Proxy implements IProxy
{
	public static const NAME:String = "slides_proxy";
	private var _currentSlideIndex:uint;
	private var _totalSlides:uint;
	private var _slideList:Array = new Array();
	
	public function SlidesProxy(  ):void
	{
		super( NAME );
	}	
	
	
	// ______________________________________________________________ Make
	/** 
	*	Parse the json object, creating all the slide value objects
	*	@param		A json object
	*/
	public function parseJson ( $json:Object ):void
	{
		// Loop through each of the slides, and create a SlideVO
		var count:Number = 0;
		var len:uint = $json.slides.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			// Create SlideVO
			var slide:SlideVO = new SlideVO();
			slide.slideIndex = i;
			slide.slots = new Object();
			
			// Now create the right kind of slotVO for each slot
			for( var j:String in $json.slides[i] )
			{
				// Determine the type of slot by checking the 
				// template slot with this same name
				switch ( $json.template[j].kind  )
				{
					case "image" :
						var slotImageVo:SlotImageVO = new SlotImageVO();
						slotImageVo.slotId 	= j;
						slotImageVo.src 	= $json.slides[i][j].src;
						slotImageVo.href 	= $json.slides[i][j].href;
						slide.slots[j]		= slotImageVo;
					break;
					
					case "text" :
						var slotTextVo:SlotTextVO = new SlotTextVO();
						slotTextVo.slotId 	= j;
						slotTextVo.text 	= $json.slides[i][j].text;
						slide.slots[j]		= slotTextVo;
					break;
				}
			}
			_slideList.push(slide);
		}
		
		// Initialize model
		_totalSlides = _slideList.length;
		_currentSlideIndex = 0;
		
		// Send observers a list of slides
		sendNotification( AppFacade.INIT_SLIDES, _slideList );
		// load the first slide
		sendNotification( AppFacade.DISPLAY_NEW_SLIDE, this.currentSlide );
	}
	
	
	// ______________________________________________________________ Slide Changing
	/** 
	*	Incrament the slide index
	*	@param		The incrament amount. This can be a positive -OR- a negative number.
	*/
	public function incramentSlideIndex ( $incrament:int ):void
	{
		var newIndex:int = _currentSlideIndex + $incrament;
		
		// Make sure the new index falls within the range of slides
		if( newIndex > _totalSlides - 1 )		
			newIndex = _totalSlides - 1;	// if new index is greater than the last slide, show last slide.
		else if( newIndex < 0 )				
			newIndex = 0;					// if the index is less than 0, show first slide.
		
		// Only send broadcast if the new slide 
		// is different than the current slide
		if( _currentSlideIndex != newIndex ) {
			_currentSlideIndex = newIndex;
			sendNotification( AppFacade.DISPLAY_NEW_SLIDE, this.currentSlide );
		}
	}
	
	/** 
	*	Change which slide to display by passing the new slide index
	*	@param		The index of the new slide
	*/
	public function changeSlide ( $newIndex:uint ):void
	{
		var plusOrMinus:int 		= ($newIndex > _currentSlideIndex)? 1 : -1;
		var incramentDifference:int	= Math.abs( _currentSlideIndex - $newIndex ) * plusOrMinus;
		
		incramentSlideIndex( incramentDifference );
	}
	
	// ______________________________________________________________ Getters and setters
	
	public function get currentSlideIndex 	(  ):uint{ return _currentSlideIndex; 	};
	public function get totalSlides			(  ):uint{ return _totalSlides; 		};
	public function get currentSlide 		(  ):SlideVO{ return _slideList[ _currentSlideIndex ]; };
	
}
}