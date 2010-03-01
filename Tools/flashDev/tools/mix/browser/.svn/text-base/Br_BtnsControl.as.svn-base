import mvc.*;
import util.*;
import tools.mix.browser.*;


class tools.mix.browser.Br_BtnsControl extends AbstractController
{
	private static var sizeOfSet:Number = 4;		// Number of products to show
	
	public function Br_BtnsControl($model:Observable)
	{
		super($model);
	}
	
	public function changeCategoryStatus ( $status, $category ):Void
	{
		var model:Br_Model = Br_Model( getModel() );
		if($status == 'active')
		{
			model.activateCategory ( $category );
		}
		else
		{
			model.deactivateCategory ( $category );
		}
	}
	
	// _______________________________________________________________________ Button Click Event Handlers
	
	public function nextSet (  ):Void
	{
		var model:Br_Model = Br_Model( getModel() );
		model.incramentProductSet ( 1 ); 
	}
	
	public function prevSet (  ):Void
	{
		var model:Br_Model = Br_Model( getModel() );
		model.incramentProductSet ( -1 ); 
	}
	
	// _______________________________________________________________________ Called when the slider is dragged
	
	public function changeViewPercentage ( $perc:Number ):Void
	{
		var model:Br_Model = Br_Model( getModel() );
		model.setCardScale ( $perc );
	}
	
	// _______________________________________________________________________ Private helper functions
	
	private function getSetSizeString ( $inc:Number ):String
	{
		var range:String = Br_Model( getModel() ).getVisProdRange();
		var ar 	 :Array  = range.split('-');
		var len	 :Number = Br_Model( getModel() ).getTotalItems();
		
		
		// Make sure it is in the range of items
		var leftStr :Number = Number(ar[0]) + $inc;   
		var rightStr:Number = Number(ar[1]) + $inc;   
		
		// Check to see if values are in range
		if( leftStr  < 1 )			// Is less than minimum
		{
			leftStr  = 1;
			rightStr = sizeOfSet;
		}
		else if( rightStr > len )	// Is greater than total items
		{
			leftStr  = len - sizeOfSet + 1;
			rightStr = len;
		}
		
		return leftStr + '-' + rightStr;
	}
}