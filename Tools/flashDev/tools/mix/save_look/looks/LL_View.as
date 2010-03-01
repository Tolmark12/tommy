import util.*;
import mvc.*;
import tools.mix.save_look.looks.*;
import tools.mix.save_look.looks.look.SavedLook;


class LL_View extends AbstractView
{
	private var mainMc		:MovieClip;
	private var xIncrament	:Number = 45;
	private var looksObject	:Object;
	
	public function LL_View ( $m:Observable, $c:Controller, $mc:MovieClip )
	{
		super($m, $c);
		looksObject = new Object();
		mainMc = $mc;
	}
	
	// _______________________________________________________________________ Update
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info:LL_Update_VO = LL_Update_VO( $infoObj );
		
		if( info.lookAr != null ) 
		{
			addOrRemoveLooks(info.lookAr);
		}
	}
	
	// _______________________________________________________________________ Adding / Removing looks
	private function addOrRemoveLooks ( $ar:Array ):Void
	{
		// Create a temp object holding all the Saved Looks We will delete all objects 
		// from this object contained in the array sent from the model
		var snapshot:Object = {};
		for( var i:String in looksObject )
		{
			snapshot[i] = '';
		}
		
		// Add new items (not in savedLook object)
		var len:Number = $ar.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			var savedLook:SavedLook = SavedLook( looksObject[i] );
			
			if(  looksObject[ $ar[i] ] == undefined ) 				// It doesn't yet exists in the looksObject
			{
				var temp:Array = $ar[i].split('-');
				addLook( temp[0], temp[1], xIncrament * i );
			}else{													// It does exist in the looksObject
				// remove it from the "to delete" list
				delete snapshot[$ar[i]];
			}
		}
		
		// Delete any items in the object not in the array sent from the model
		for( var i:String in snapshot )
		{
			var savedLook:SavedLook = looksObject[i]
			savedLook.remove();
			looksObject[i] = null;
		}
	}
	
	private function addLook ( $topId:String, $btmId:String, $xpos:Number ):Void
	{
		var ids:String	   = $topId + '-' + $btmId;
		var mc:MovieClip   = mainMc.createEmptyMovieClip( ids + 'mc', mainMc.getNextHighestDepth() );
		mc._x 			   = $xpos;
		var look:SavedLook = looksObject[ ids ] = new SavedLook(  mc, $topId, $btmId );
		var con:LL_Control = LL_Control( getController() );
		look.setClickCallBack( con, "click" );
	}
}