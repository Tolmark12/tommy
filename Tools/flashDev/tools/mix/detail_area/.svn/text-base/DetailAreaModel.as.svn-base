import util.Observable;
import lib.product.Item;
import tools.mix.detail_area.*;


class DetailAreaModel extends Observable
{                               	
	private var currentItem			:Item;
	private var currentItemId		:String;
	private var contentOnDisplay	:String;  // Either 'controls' or 'info'
	
	public function DetailAreaModel()
	{
		
	}
	
	//  Change which item is visible
	public function showNewItem ( $item:Item ):Void
	{
		if( currentItemId != $item.getId() ) 
		{
			var info = new DetailArea_Vo();
			
			currentItem 	= info.newItem = $item;
			currentItemId 	= currentItem.getId(); 
			
			setChanged();
			notifyObservers( info );
		}
	}
	
	
	//  Change the attributes of the current Item	
	public function setCurrentItemAttribute ( $attribute:String, $value:String, $valueIndex:Number ):Void
	{
		currentItem.setAttributeValue( $attribute, $value, $valueIndex );
	}
	
	
	// Swap between Info and Controls
	public function showProductInfo (  ):Void
	{
		if( contentOnDisplay != 'info' ) 
		{
			var info:DetailArea_Vo = new DetailArea_Vo();
			info.contentToShow = contentOnDisplay = 'info';
			setChanged();
			notifyObservers(info);
		}
	}
	
	public function showProductControls (  ):Void
	{
		if( contentOnDisplay != 'controls' ) 
		{
			var info:DetailArea_Vo = new DetailArea_Vo();
			info.contentToShow = contentOnDisplay = 'controls';
			setChanged();
			notifyObservers(info);
		}
	}
	
	// Getters / Setters
	public function getCurrentItemId  (  ):String   { return currentItem.getId() ; };
	public function getCurrentItem 	  (  ):Item     { return currentItem; };
}