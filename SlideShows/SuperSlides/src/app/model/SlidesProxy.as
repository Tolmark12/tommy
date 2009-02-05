package app.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.AppFacade;
import app.model.vo.SlideVO;

public class SlidesProxy extends Proxy implements IProxy
{
	public static const NAME:String = "slides_proxy";
	private var _currentSlideIndex:uint;
	private var _totalSlides:uint;
	private var _slideList:Array;
	private var _xmlData:XML;
	
	public function SlidesProxy(  ):void
	{
		super( NAME );
	}	
	
	/** 
	*	Parse the json object, creating all the slide value objects
	*	@param		The json object
	*/
	public function parseJson ( $jsonObj:Object ):void
	{
		trace( $jsonObj.template.slot_a.x );
	}
	
	/** 
	*	Build the SlideVOs from the xml
	*/
	public function createSlidesFromXml ():void
	{		
//		_slideList = new Array();
//		var count:uint = 0;
//		
//		for each( var node:XML in _xmlData.slides.slide)
//		{
//			var slide:SlideVO 	 = new SlideVO();
//			slide.slideIndex	 = count;
//			slide.slideId		 = "slide" + count++;
//			slide.largeImagePath = _xmlData.slides.@imagePath + String(node.main_img);
//			slide.thumbnailPath  = _xmlData.slides.@imagePath + String(node.thmb_img);
//			slide.description	 = node.text.elements("*").toXMLString()
//						
//			_slideList.push(slide);
//		}
//		
//		_totalSlides = _slideList.length;
//		_currentSlideIndex = 0;
//		
//		// Send observers a list of slides
//		sendNotification( AppFacade.INIT_SLIDES, _slideList );
//		// load the first slide
//		sendNotification( AppFacade.DISPLAY_NEW_SLIDE, this.currentSlide );
	}
	
	/** 
	*	Incrament the slide index
	*	@param		The incrament amount. This can be a positive OR a negative number.
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
		if( _currentSlideIndex != newIndex ) 
		{
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