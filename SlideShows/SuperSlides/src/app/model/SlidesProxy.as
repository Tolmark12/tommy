package app.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.AppFacade;
import app.model.vo.*;
import app.model.helpers.*;

public class SlidesProxy extends Proxy implements IProxy
{
	public static const NAME:String = "slides_proxy";
	private var _currentSlideIndex:uint;
	private var _totalSlides:uint;
	private var _slideList:Array = new Array();
	private var _autoPlayIsActive:Boolean = true;
	
	public function SlidesProxy(  ):void
	{
		super( NAME );
	}
	
	// ______________________________________________________________ Make
	/** 
	*	Parse the json object, creating all the slide value objects
	*	@param		The data to parse
	*	@param		The data type (either json or xml)
	*/
	public function parseData ( $data:*, $kind:String ):void
	{	
		var parser:Parser;
		
		// If the datatype is json...
		if( $kind == "json" ) {
			var jsonParser:JsonParser = new JsonParser();
			jsonParser.parseJson( $data );
			parser = jsonParser;
		}
		// else the datatype is xml...
		else{
			var xmlParser:XMLParser = new XMLParser()
			xmlParser.parseXML( $data );
			parser = xmlParser
		}
		
		
		// Initialize model
		_slideList = parser.slideList;
		_totalSlides = _slideList.length;
		_currentSlideIndex = 0;
		
		// Create the template slots
		sendNotification( AppFacade.INIT_SLOTS, parser.templateSlots );
		// Populate the static content
		sendNotification( AppFacade.POPULATE_SLOTS, parser.staticContent );
		// Send observers a list of slides
		sendNotification( AppFacade.INIT_SLIDES, _slideList );
		// load the first slide
		sendNotification( AppFacade.POPULATE_SLOTS, currentSlide.slots  );
		sendNotification( AppFacade.CHANGE_SLIDE, _currentSlideIndex );
	}
	
	// ______________________________________________________________ Slide Changing
	/** 
	*	Incrament the slide index
	*	@param		The incrament amount. This can be a positive -OR- a negative number.
	*/
	public function incramentSlideIndex ( $incrament:int, $doLoop:Boolean=false ):void
	{
		var newIndex:int = _currentSlideIndex + $incrament;
		
		if( !$doLoop ) {
			// Make sure the new index falls within the range of slides
			if( newIndex > _totalSlides - 1 )		
				newIndex = _totalSlides - 1;	// if new index is greater than the last slide, show last slide.
			else if( newIndex < 0 )				
				newIndex = 0;					// if the index is less than 0, show first slide.
		} else {
			if( newIndex > _totalSlides - 1 )		
				newIndex = 0;					// if new index is greater than the last slide, show first slide.
			else if( newIndex < 0 )				
				newIndex = _totalSlides - 1;	// if the index is less than 0, show last slide.
		}
		
		// Only send broadcast if the new slide 
		// is different than the current slide
		if( _currentSlideIndex != newIndex ) {
			_currentSlideIndex = newIndex;
			sendNotification( AppFacade.POPULATE_SLOTS, currentSlide.slots  );
			sendNotification( AppFacade.CHANGE_SLIDE, _currentSlideIndex );
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
	
	public function stopAutoPlay (  ):void
	{
		if( _autoPlayIsActive ) 
		{
			_autoPlayIsActive = false;
			sendNotification( AppFacade.STOP_AUTOPLAY );
		}
	}
	
	// ______________________________________________________________ Getters and setters
	
	public function get currentSlideIndex 	(  ):uint{ return _currentSlideIndex; 	};
	public function get totalSlides			(  ):uint{ return _totalSlides; 		};
	public function get currentSlide 		(  ):SlideVO{ return _slideList[ _currentSlideIndex ]; };
	
}
}