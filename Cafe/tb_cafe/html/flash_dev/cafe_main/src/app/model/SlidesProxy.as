package app.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.AppFacade;
import app.model.vo.Slide_VO;
import flash.events.*;
import flash.text.StyleSheet;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class SlidesProxy extends Proxy implements IProxy
{
	public static const NAME:String = "slides_proxy";
	private var _currentSlideIndex:uint;
	private var _totalSlides:uint;
	private var _slideList:Array;
	private var _xmlData:XML;
	private var _autoTimer:Timer;
 	
	public function SlidesProxy():void
	{
		super( NAME );
	}
	
	/** 
	*	Build the Slide_VOs from the xml
	*/
	public function createSlides ( _xmlData:XML  ):void
	{
		_slideList = new Array();
		var count:uint = 0;
		
		for each( var node:XML in _xmlData.slides.slide)
		{
			var slide:Slide_VO 	    = new Slide_VO();
			slide.slideIndex	    = count;
			slide.slideId		    = "slide" + count++;
			slide.largeImagePath    = _xmlData.slides.@imagePath + String(node.main_img);
			slide.thumbnailPath     = _xmlData.slides.@imagePath + String(node.thmb_img);
			slide.description	    = node.text.elements("*").toXMLString();
			slide.href			    = node.@href;
			slide.hrefWindowTarget  = (String( node.@target ).length == 0)? "_self" : node.@target ;
			
			// Strip the new lines from the html
			slide.description = slide.description.replace(/\n/g, "");
			slide.description = slide.description.replace(new RegExp( "(?<=p>)\\s*(?=\\<a)", "g" ), "");
			
			_slideList.push(slide);
		}
		
		_totalSlides = _slideList.length;
		_currentSlideIndex = 0;
		
		// Send observers a list of slides
		sendNotification( AppFacade.INIT_SLIDES, _slideList );
		// load the first slide
		sendNotification( AppFacade.DISPLAY_NEW_SLIDE, this.currentSlide );
		
		if( _slideList.length  <= 1 ) 
			sendNotification( AppFacade.ONLY_ONE_SLIDE );
		
		// Autoplay
		if( _xmlData.slides.@autoPlay == "true" ) 
		{	
			var speed:Number = ( String( _xmlData.slides.@autoPlaySpeed ).length != 0 )? Number(_xmlData.slides.@autoPlaySpeed) * 1000 : 5000;
			_autoTimer = new Timer(speed);
			_autoTimer.addEventListener( TimerEvent.TIMER, _onTimer );
			_autoTimer.start();
		}
	}
	
	/** 
	*	Stop the autoplay of the slides
	*/
	public function killTimer (  ):void
	{
		if( _autoTimer != null ) 
		{
			_autoTimer.stop();
			_autoTimer = null;
		}
	}
	
	/** 
	*	Create css style sheet from xml css data
	*/
	public function createStyleSheet ( $xml:XML ):void
	{
		var styleSheet:StyleSheet = new StyleSheet();
		styleSheet.parseCSS( $xml.css.toString() );
		sendNotification( AppFacade.CSS_PARSED, styleSheet );
	}
	
	/** 
	*	Incrament the slide index
	*	@param		The incrament amount. This can be a positive OR a negative number.
	*	@param		Whether to loop back to the begining (or to the end) when incramenting beyond the slide range.
	*/
	public function incramentSlideIndex ( $incrament:int, $doLoop:Boolean=false ):void
	{
		var newIndex:int = _currentSlideIndex + $incrament;
		
		// Make sure the new index falls within the range of slides
		if( $doLoop ) 
		{
			if( newIndex > _totalSlides - 1 )		
				newIndex = 0;					// if new index is greater than the last slide, show the first slide.
			else if( newIndex < 0 )				
				newIndex = _totalSlides - 1;	// if the index is less than 0, the last slide.
				
		}
		else
		{
			if( newIndex > _totalSlides - 1 )		
				newIndex = _totalSlides - 1;	// if new index is greater than the last slide, show last slide.
			else if( newIndex < 0 )				
				newIndex = 0;					// if the index is less than 0, show first slide.
		}
		
		
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
	
	// ______________________________________________________________ Event Handlers
	private function _onTimer ( e:TimerEvent ):void
	{
		incramentSlideIndex(1, true);
	}
	
	// ______________________________________________________________ Getters and setters
	public function get currentSlideIndex 	(  ):uint{ return _currentSlideIndex; 	};
	public function get totalSlides			(  ):uint{ return _totalSlides; 		};
	public function get currentSlide 		(  ):Slide_VO{ return _slideList[ _currentSlideIndex ]; };
	
}
}