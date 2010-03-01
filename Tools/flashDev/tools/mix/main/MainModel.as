import util.Observable;
import lib.product.Item;
import tools.mix.main.*

class MainModel extends Observable
{
	private var topProductId:String;
	private var btmProductId:String;
	
	public function MainControl()
	{
		
	}
	
	public function changeTopProduct ( $prodId:String ):Void
	{
		if( topProductId != $prodId && $prodId != null )
		{
			topProductId = $prodId;
			var info:Main_UpdateVO = new Main_UpdateVO( topProductId, btmProductId );
			setChanged();
			notifyObservers( info );
		}
		
	}
	
	public function changeBtmProduct ( $prodId:String ):Void
	{
		if( btmProductId != $prodId && $prodId != null )
		{
	   		btmProductId = $prodId;
	   		var info:Main_UpdateVO = new Main_UpdateVO( topProductId, btmProductId );
			setChanged();
			notifyObservers( info );
		}
	}
}