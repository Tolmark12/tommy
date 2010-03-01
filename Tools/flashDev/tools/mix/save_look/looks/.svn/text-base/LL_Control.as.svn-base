import mvc.*;
import util.*;
import tools.mix.save_look.looks.*;

class LL_Control extends AbstractController
{
	
	public function LL_Control($model:Observable)
	{
		super($model);
	}
	
	// _______________________________________________________________________ Handle Release from View
	
	public function click ( $topId:String, $btmId:String ):Void
	{
		LL_Model( getModel() ).activateLook( $topId, $btmId );
	}
}