import util.Observable;
import main.*;
import lib.slides.Slide;


class Mn_Model extends Observable
{
	private var isStopped		:Boolean;
	private var slide			:Slide;
	private var defaultCaption	:String = "This is the default text";
	private var totalSlides		:Number;
	private var currentSlide	:Number;
	
	public function Mn_Model()
	{
		
	}
	
	public function changeCurrentSlide ( $slide:Slide ):Void
	{
		if( $slide != slide ) 
		{
			slide = $slide;
			var info = new Mn_UpdateVO();
			info.slide = slide;
			info.caption = ( slide.getText() == undefined )? defaultCaption : slide.getText() ;
			info.index	 = slide.getIndex() + 1;
			setChanged();
			notifyObservers(info);
		}
	}
	
	public function stopSlideShow (  ):Void
	{
		isStopped = true;
		var info = new Mn_UpdateVO('stop');
		setChanged();
		notifyObservers(info);
	}
	
	public function startSlideShow (  ):Void
	{
		isStopped = false;
		var info = new Mn_UpdateVO('start');
		setChanged();
		notifyObservers(info);
	}
	
	public function resetSlideShow (  ):Void
	{
		isStopped = false;
		var info = new Mn_UpdateVO('first');
		setChanged();
		notifyObservers(info);
	}
	
	public function showNextSlide (  ):Void
	{
		var info = new Mn_UpdateVO('next');
		setChanged();
		notifyObservers(info);
	}
	
	public function showPrevSlide (  ):Void
	{
		var info = new Mn_UpdateVO('prev');
		setChanged();
		notifyObservers(info);
	}
	
	
	public function slideShowIsStopped 		(  ):Object			 { return isStopped; };
	public function setDefaultTextCaption 	( $str:String ):Void { defaultCaption = $str; };
	
	public function getCurrentSlideIndex 	(  ):Number	{ return currentSlide; };
	public function getTotalSlides 			(  ):Number	{ return totalSlides; };
	public function setCurrentSlideIndex 	( $val ):Void { currentSlide = $val; };
	public function setTotalSlides 			( $val ):Void { totalSlides  = $val; };
}