import util.Observable;
import tools.mix.browser.*;

// Todo: Consider instead of sending the categories to activate and deactivate in the 
// update broadcast, instead just send the object ref since many diff things are listening to the broadcast

class tools.mix.browser.Br_Model extends Observable
{
	private var FIXED_INCRAMENT		:Boolean = true;
	private var INCRAMENT_AMOUNT	:Number = 2;	// The amount to incrament the products by when using the right and left buttons
	private var activeItemId		:String;		// Currently selected item
//	private var categories			:Object;		// Object that holds the categories 				EX- { shirts:{active:true, items:{id:'1a' file='filename'}, vests:{..} }
	private var activeCategories	:Object;		// Object with ref to all active categories 		EX- { shirts:'', vests:'' }
	private var visProdRange		:String;		// String that holds the range of producst visible 	EX-  "1-4" or "1-30"
	private var totalItems			:Number;		// Remembers the total number of items
	private var showingAll			:Boolean;		// Whether all of the products are visible or not
	private var currentRangeSize	:Number;		// The number of visible products
	private var cardScale			:Number;		// Scale of card size. 0 being smallest, 1 being the largest
	                                            	
	// Working                                  	
	private var activeItems			:Array;			// [id1, id2, id3, id4]
	private var inactiveItems		:Array;			// [id1, id2, id3, id4]
	private var categories			:Object;		// It is full of Category_VO objects 
	
	public function Br_Model(  )
	{
		categories			= new Object();
	}
	
	public function changeActiveItem ( $id:String ):Void
	{
		if(activeItemId != $id)
		{
			activeItemId = $id;
			var dataObj:Browser_VO = new Browser_VO( null, null );
			setChanged();
			notifyObservers( dataObj );
		}
	}
	
	

	// _______________________________________________________________________ Initial Building of the categories
	
	public function initCategories ( $xmlObj:Object ):Void
	{
		var catsToActivate = new Array();
		
		for( var i:String in $xmlObj )
		{			
			// Add category name to activation queue
 			categories[i] 		 = new Category_VO()    /* new */
 			categories[i].active = true;         		/* new */
			categories[i].name 	 = i;         			/* new */
			
			// Create obj to hold items (should I init a data object here)
			categories[i].items  = new Object();
			
			for( var j:String in $xmlObj[i] )
			{
				// Add items to the category object's item object
				categories[i].items[j] = $xmlObj[i][j];
			}
		}
		
		updateTotalItems()
		var info:Browser_VO		= new Browser_VO( );
		info.totalItems			= totalItems;
		info.categories			= categories;
		setChanged();
		notifyObservers( info );
	}
	

	// _______________________________________________________________________ Activate / Deactivate categories
	
	// $catname: "Shirts"
	public function activateCategory ( $catName:String ):Object
	{
		// Datatype the var
		var category:Category_VO = Category_VO( categories[$catName])
		
		// Only activate if it isn't active :-0
		if( categories[$catName].active == true ) 
		{
			return null; // Kill the method
		}
		
		// else, Category is not yet active...
		categories[$catName].active = true;
		
		// Prepare the update
		setChanged();
		updateTotalItems()
		var info:Browser_VO = new Browser_VO();
		info.totalItems 	 	= totalItems;
		info.categories			= categories;
		info.cardScale			= cardScale;

		// send the update
		notifyObservers( info );
		setVisProdRange(visProdRange,true);
	}
	
	public function deactivateCategory ( $catName:String ):Void
	{
		// Datatype the var
		var category:Category_VO = Category_VO( categories[$catName])
		
		// Only deactivate if it is curretly active
		if( category.active == true )
		{
			category.active = false; 
			updateTotalItems()
			setChanged();
		}
		
		// Prepare update
		var info:Browser_VO = new Browser_VO();
		info.totalItems 	 	= totalItems;
		info.categories			= categories;
		info.cardScale			= cardScale;
		
		// Send update
		notifyObservers( info );
		setVisProdRange(visProdRange,true)		
	}

	// _______________________________________________________________________ Change the visible product range
	
	//  Set the range of products that are visible
	public function setVisProdRange 		( $range:String, $forceChange:Boolean ):Void	 
	{ 
		//visProdRange = $range;
		var ar:Array = $range.split('-');
		var btm:Number = Number(ar[0]);
		var top:Number = Number(ar[1]);
		
		if( top > totalItems)
		{
			btm = 1;
			top = totalItems;
		}
		currentRangeSize = top - btm;
		
		var info:Browser_VO = new Browser_VO();
		info.newProductRange = btm  + '-' + top;
		
		if(visProdRange != info.newProductRange || $forceChange)
		{
			visProdRange = info.newProductRange;
			info.totalItems = totalItems;
			
			setChanged();
			notifyObservers( info );
		}
	}

	//  Incrament an entire set 
	public function incramentProductSet ( $inc:Number /* Either 1 or -1 */ ):String
	{	
		var rangeAr:Array 			= new Array();
		var ar:Array 				= visProdRange.split('-');
		var btmIndex:Number			= Number(ar[0]);
		var topIndex:Number			= Number(ar[1]);
		var amountOfChange:Number 	= (currentRangeSize + 1) * $inc;
		var productInc:Number;
		
		if( FIXED_INCRAMENT ) 
		{
			productInc = INCRAMENT_AMOUNT * ( ($inc<0)? -1 : 1 ) ;
		}
		else
		{
			productInc = amountOfChange;
		}
		
		// If the range is within the total # of products
		if( topIndex + productInc < totalItems && btmIndex + productInc > 0  ) 
		{
			rangeAr[0] = btmIndex + productInc;
			rangeAr[1] = topIndex + productInc;
		}
		// If the new range is less than 0
		else if( btmIndex + productInc < 1 )
		{
			rangeAr[0] = 1;
			rangeAr[1] = currentRangeSize + 1;
		}
		// If the new range is greater than the total items
		else{
			rangeAr[0] = totalItems - currentRangeSize;
			rangeAr[1] = totalItems;
		}
		
		
		// If all the products are visibl -OR- if 
		showingAll = (  rangeAr[0] == '1' && Number(rangeAr[1]) >= totalItems )? true : false ;
		if( showingAll || visProdRange ==  rangeAr[0] + '-' + rangeAr[1] ){ return ''; }
		
		visProdRange = rangeAr[0] + '-' + rangeAr[1];
		setChanged();
		var info:Browser_VO 	= new Browser_VO();
		info.totalItems 		= totalItems;
		info.newProductRange 	= visProdRange;
		info.incramenting		= true;
		info.incramentDirection	= $inc;
		notifyObservers( info );
	}
	

	// _______________________________________________________________________ Change the realitive scale of the cards
	
	public function setCardScale ( $scale:Number ):Void
	{
		if( cardScale != $scale )
		{
			var info:Browser_VO = new Browser_VO();
			info.cardScale = cardScale = $scale
			setChanged()
			notifyObservers( info );
		}
	}
	
	
	// _______________________________________________________________________ Private Helper Functions
	
	private function updateTotalItems (  ):Void
	{
		var snapShot:Number = totalItems;
		totalItems = 0;
		
		// Loop through all the categories.. 
		for( var i:String in categories )
		{
			// if the category is active...
			if( categories[i].active == true ) 
			{
				// Count each item in the category
				for( var i:String in categories[i].items )
				{
					totalItems++;
				}
			}
		}
				
		var ar:Array = visProdRange.split('-');
		if( Number(ar[1]) > totalItems )
		{
			ar[1] = totalItems;
			ar[0] = Number (ar[0]) - (snapShot - totalItems)
			ar[0] = (ar[0]<1)? 1 : ar[0]
			visProdRange = ar[0] + '-' + ar[1];
		}
		
	}
	
	// _______________________________________________________________________ Getters / Setters
	
	public function getVisProdRange 		(  ):String				 { return visProdRange;  };
	public function getActiveItemId	 		(  ):String				 { return activeItemId; };
	public function getCategoryObjByName 	( $name:String ) :Object { return categories[$name]; };
	public function getTotalItems	 		(  ):Number				 { return totalItems; };
	public function getShowingAll	 		(  ):Boolean			 { return showingAll; };
	
}