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
			slide.slots = _createSlotDataVOs( $json.slides[i], $json.template )
			_slideList.push(slide);
		}
		
		var templateSlots:Array = new Array()
		// Create Slots Template
		for( var k:String in $json.template )
		{
			var slotTemplateVO  = new SlotTemplateVO();
			slotTemplateVO.x    = $json.template[k].x;
			slotTemplateVO.y    = $json.template[k].y;
			slotTemplateVO.id   = k;
			slotTemplateVO.kind = $json.template[k].kind;
			templateSlots.push(slotTemplateVO);
		}
		
		// Initialize model
		_totalSlides = _slideList.length;
		_currentSlideIndex = 0;
		
		var staticContent:Object = _createSlotDataVOs( $json.staticContent, $json.template)
		
		// Create the template slots
		sendNotification( AppFacade.INIT_SLOTS, templateSlots );
		// Populate the static content
		sendNotification( AppFacade.POPULATE_SLOTS, staticContent );
		// Send observers a list of slides
		sendNotification( AppFacade.INIT_SLIDES, _slideList );
		// load the first slide
		sendNotification( AppFacade.DISPLAY_NEW_SLIDE, this.currentSlide );
	}
	
	
	private function _createSlotDataVOs ( $slotData:Object, $slotTemplate:Object ):Object
	{
		var slotObj:Object = new Object();
		
		// Now create the right kind of slotVO for each slot
		for( var j:String in $slotData )
		{
			// Determine the type of slot by checking the 
			// template slot with this same name
			switch ( $slotTemplate[j].kind  )
			{
				case "image" :
					var slotImageVo:SlotImageVO = new SlotImageVO();
					slotImageVo.slotId 	= j;
					slotImageVo.kind	= $slotTemplate[j].kind
					slotImageVo.src 	= $slotData[j].src;
					slotImageVo.href 	= $slotData[j].href;
					slotObj[j]			= slotImageVo;
				break;
				
				case "text" :
					var slotTextVo:SlotTextVO = new SlotTextVO();
					slotTextVo.kind		= $slotTemplate[j].kind
					slotTextVo.slotId 	= j;
					slotTextVo.text 	= $slotData[j].text;
					slotObj[j]			= slotTextVo;
				break;
			}
		}
		return slotObj;
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