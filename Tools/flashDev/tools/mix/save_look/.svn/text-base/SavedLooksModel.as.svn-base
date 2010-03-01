import util.Observable;
import tools.mix.save_look.*;


class SavedLooksModel extends Observable
{
	
	
	private var potentialTopItemId		:String;				// Currently selected items in the display area, not
	private var potentialBtmItemId		:String;				//   in the saved looks area
	private var activeTopLookId			:String;				// Id of active top saved look 
	private var activeBtmLookId			:String;				// Id of active bottom saved look
	private var isPotentialUnsavedLook	:Boolean;
	private var savedLooks				:Object;		// What is the best way to store these?
														// These will be "Items.as"
														// they will be refered to by: savedObj[ topId + bottomId ] = [topIem, bottomItem];
									
	public function SavedLooksModel()
	{
		savedLooks = new Object();
	}
	
	// _______________________________________________________________________ Save the current look displayed in the main area
	
	public function saveCurrentLook (  ):Void
	{
		var t:String = potentialTopItemId;
		var b:String = potentialBtmItemId;

		if( savedLooks[ t + b ] == undefined ) 
		{
			savedLooks[ t + b ] = new SavedLook_VO(t, b );
			var info = new SavedLookUpdate_VO();
			info.newLookToSave = savedLooks[ t + b ];
			setChanged();
			notifyObservers( info );			
		}
	}
	
	// _______________________________________________________________________ Change the main display, after click of a saved look
	
	// $ti: top product id
	// $bi: btm product id
	public function activateLookById ( $ti:String, $bi:String ):Void
	{
		if( activeBtmLookId != $ti || activeTopLookId != $bi ) 
		{
			activeBtmLookId = $ti;
			activeTopLookId = $bi;
			
			var info:SavedLookUpdate_VO = new SavedLookUpdate_VO()
			info.activeLook = new SavedLook_VO( $ti, $bi );
			setChanged();
			notifyObservers( info );		
		}

	}
	
	
	// _______________________________________________________________________ This is called every time the main displayed items change
	
	// Store a working copy of the potential items (ids)
	// Notify model which items are currently being displayed
	// Called by mix.tools.main.MainDisplay.as
	//
	// $ti: top product id
	// $bi: btm product id
	private function changeDisplayedItems ( $ti:String, $bi:String )
	{
		activeBtmLookId = null;
		activeTopLookId = null;
				
		potentialTopItemId = $ti;
		potentialBtmItemId = $bi;
		
		// If there is a top item and a bottom item, update view to know this
		if( $ti != undefined && $bi != undefined ) 
		{
			var lookExists:Boolean = false;
			
			// Determine if this look currently exists
			for( var i:String in savedLooks )
			{
				var item = SavedLook_VO( savedLooks[i] )
				if ( item.topItemId == $ti && item.btmItemId == $bi )
				{
					lookExists = true;
					break
				}
			}
						
			var info = new SavedLookUpdate_VO();
			if( lookExists )
			{
				// Indicate somehow that this look exists	
			}
			else
			{
				info.potentialLook = new SavedLook_VO( $ti, $bi );
				setChanged();
			}
			
			notifyObservers( info );
		}
	}
}