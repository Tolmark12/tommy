package app.Model
{
import app.AppFacade;
import app.Model.vo.Slide_VO;
import delorum.loading.XmlLoader;
import flash.events.Event;
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import flash.display.Sprite;

public class SlidesProxy extends Proxy implements IProxy
{
	public static const NAME:String	= "xml_config_proxy";
	
	private var _currentSlideIndex:uint;
	private var _totalSlides:uint;
	private var _slideList:Array;
	private var _xmlData:XML;
	private var _xmlPath:String;
	
	public function SlidesProxy( $stage:Sprite )
	{
		super(NAME);
		_xmlPath = ( $stage.loaderInfo.parameters.xmlPath != null )? $stage.loaderInfo.parameters.xmlPath : 'flash_loads/xml/slides.xml' ;
	}
	
	public function get slideList():Array
	{
		return _slideList;
	}
	
	public function get currentSlideIndex():uint
	{
		return _currentSlideIndex; 	
	}
	
	public function get totalSlides():uint
	{
		return _totalSlides; 		
	}
	
	public function get currentSlide():Slide_VO
	{
		return _slideList[ _currentSlideIndex ];
	}
	
	/** load xml file */
	public function loadConfig():void
	{
		
		var ldr:XmlLoader 	= new XmlLoader( _xmlPath );
		ldr.onComplete		= _xmlLoadSuccess;
		ldr.loadItem();	
	}
	
	private function _buildSlidesFromXml():void
	{
		_slideList = new Array();
		var count:uint = 0;
		
		for each( var node:XML in _xmlData.slides.slide)
		{
			var slide:Slide_VO 		= new Slide_VO();
			slide.slideIndex		= count;
			slide.slideId			= "slide" + count++;
			slide.title				= String(node.title);
			slide.date				= String(node.date);
			slide.blurb				= String(node.blurb);
			slide.mediaType			= node.media.@type;
			slide.main 				= ((slide.mediaType == Slide_VO.TYPE_MOVIE) ? _xmlData.slides.@mainMoviePath : _xmlData.slides.@mainImagePath) + "/" + String(node.media.main);
			slide.thumbnailPath 	= _xmlData.slides.@thumbImagePath + "/" + String(node.media.thumb_img);
			slide.fullImagePath 	= ( String(node.media.fullsize).length != 0 )?_xmlData.slides.@fullImagePath + "/" + String(node.media.fullsize) : null;
			slide.magazineLink		= String(node.link_mag.@href);
			slide.magazineLinkText 	= String(node.link_mag);
			slide.magazineLinkTarget	= (node.link_mag.@target) ? node.link_mag.@target : "_self";
			slide.productLink	 	= String(node.link_prod.@href);
			slide.productLinkText	= String(node.link_prod);
			slide.productLinkTarget	= (node.link_prod.@target) ? node.link_prod.@target : "_self";
			_slideList.push(slide);
		}
		_totalSlides = _slideList.length;
	}
	
	/** success handler */
	private function _xmlLoadSuccess( e:Event ) :void
	{
		_xmlData = XML(e.target.data);
		_buildSlidesFromXml();
		sendNotification(AppFacade.XML_LOADED);
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
	
	public function setDefaultSlide():void
	{
		sendNotification( AppFacade.DISPLAY_NEW_SLIDE, this.currentSlide );
	}
	
}
}