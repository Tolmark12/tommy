import util.*;
import mvc.*;
import tools.mix.main.MainControl; 

class tools.mix.main.SubBroadcastView extends AbstractView
{
	
	public function SubBroadcastView ( $m:Observable, $c:Controller )
	{
		super($m, $c);
	}
	
	// _____________________________________________________________________ Update from Model's broadcast
	
	public function update ( $o:Observable, $infoObj:Object )
	{
		getController()['handleBroadcast']($o.getBroadcastId(), $o, $infoObj)
	}

	// _____________________________________________________________________ Bind the Controller to this View
	
	public function defaultController (model:Observable):Controller { return new MainControl(model); }
}