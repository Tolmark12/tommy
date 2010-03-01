import mvc.*;
import util.*;
import tools.mix.browser.Br_Model;

class tools.mix.browser.Br_Control extends AbstractController
{
	
	public function Br_Control($model:Observable)
	{
		super($model);
	}
	
	public function changeActiveProduct ( $id:String ):Void
	{
		var mod:Br_Model = Br_Model(model);
		mod.changeActiveItem($id);
	}
	
	public function newProductRange ( $range:String ):Void
	{
		var mod:Br_Model = Br_Model(model);
		mod.setVisProdRange( $range );
	}
}