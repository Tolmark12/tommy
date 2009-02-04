import mvc.*;
import util.*;
import main.*;


class Mn_Btns_Control extends AbstractController
{
	
	public function Mn_Btns_Control($model:Observable)
	{
		super($model);
	}
	
	public function click ( $btn:String ):Void
	{
		var mod:Mn_Model = Mn_Model(getModel());
		switch( $btn )
		{
			case 'pause':
				mod.stopSlideShow();
			break
				
			case 'play':
				mod.startSlideShow();
			break
			
			case 'prev':
				mod.showPrevSlide();
			break
			
			case 'next':
				mod.showNextSlide();
			break
			
			case 'reset':
				mod.resetSlideShow();
			break
		}
	}
}