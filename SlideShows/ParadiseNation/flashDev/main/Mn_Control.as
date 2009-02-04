import mvc.*;
import util.*;
import main.*;
import lib.slides.Slide;


class Mn_Control extends AbstractController
{
	
	public function Mn_Control($model:Observable)
	{
		super($model);
	}
	
	public function changeCurrentSlide ( $slide:Slide, $newIndex:Number ):Void
	{
		Mn_Model(model).changeCurrentSlide   ( $slide );
	}
	
	public function initTotalSlides ( $total:Number ):Void
	{
		Mn_Model(model).setTotalSlides( $total )
	}
}