import util.*;
import mvc.*;
import tools.mix.browser.*;

class Br_Slider extends AbstractView
{
	// TEMP
	public var onKeyDown:Function;
	// TEMP
	
	
	public function Br_Slider ( $m:Observable, $c:Controller, $TEMP:Boolean )
	{
		super($m, $c);
		
		// TEMP
		if( $TEMP ) 
		{
			TEMP_columnIncramenter()
		}
		// TEMP
	}
	
	// _______________________________________________________________________ Model Update
	public function update ( $o:Observable, $infoObj:Object )
	{

	}
	
	// TEMP
	private function TEMP_columnIncramenter (  ):Void
	{
		Key.addListener(this);
		this.onKeyDown = function()
		{
			if(Key.getCode() == 187)        // +++
			{
				// Should evaluate and set the right and left pile positions
				// Also need to evaluate how many rows should be shown
				// Will be using the "Next" & "Previous" set buttons to move the items
				// Will use a scrollBar to change how the products are displayed
				( totalCols <= MAX_COLUMNS )? totalCols++ : '' ;
				setGridVars (  );
			}
			else if (Key.getCode() == 189)  // ---
			{
				( totalCols > MIN_COLUMNS )? totalCols-- : '' ;
				setGridVars (  );
			}
		
		}		
	}
	// TEMP

	// ---------- Bind the Controller to this View ---------- //
	//public function defaultController (model:Observable):Controller { return new YourControllersClassName(model); }
}