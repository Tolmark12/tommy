import mvc.*;
import util.*;
import lib.slides.*

class SS_Control extends AbstractController
{
	
	public function SS_Control($model:Observable)
	{
		super($model);
	}
	
	public function sendNewSlide ( $slide:Slide ):Void
	{
		SS_Model(model).setCurrentSlide($slide);
	}
}