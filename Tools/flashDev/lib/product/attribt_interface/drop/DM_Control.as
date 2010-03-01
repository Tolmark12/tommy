import mvc.*;
import util.*;
import lib.product.attribt_interface.drop.*;


class DM_Control extends AbstractController
{
	
	public function DM_Control ($model:Observable)
	{
		super($model);
	}
	
	public function click ( $action:String ):Void
	{
		switch($action)
		{
			case "toggleOpen":
				toggleOpen();
			break
		}
	}
	
	private function toggleOpen (  ):Void
	{
		var model:DM_Model = DM_Model( super.getModel() );
		if( !model.getCurrentState() )
		{
			model.changeOpenState("open");
		}
		else
		{
			model.changeOpenState("closed");
		}
	}
	
	public function dropDownClick ( $newVal:String, $newIndex:Number ):Void
	{
		// Also pass the new value
		var model:DM_Model = DM_Model( super.getModel() );
		model.setNewValue( $newVal, $newIndex );
		model.changeOpenState("closed");
	}
}