import util.Observable;
import tools.mix.save_look.looks.*;
import tools.mix.save_look.looks.look.SavedLook;

class LL_Model extends Observable
{
	private var lookAr			:Array;
	private var activeLookId	:String;
	
	public function LL_Model()
	{
		lookAr = new Array();
	}
	
	
	// _______________________________________________________________________ Add and remove looks
	
	public function addLook ( $topItemId:String, $btmItemId:String ):Void
	{
		lookAr.push( $topItemId + "-" + $btmItemId );
		
		var info:LL_Update_VO = new LL_Update_VO();
		info.lookAr = lookAr;
		
		setChanged();
		notifyObservers( info );
	}
	
	public function removeLook ( $topId:String, $btmId:String ):Void
	{
		var len:Number = lookAr.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			if( $topId + '-' + $btmId == lookAr[i] ) 
			{
				lookAr.splice(i,1);
				break;
			}
		}
		
		var info:LL_Update_VO = new LL_Update_VO();
		info.lookAr = lookAr;
		
		setChanged();
		notifyObservers( info );	
	}
	
	// _______________________________________________________________________ Indicate Look is clicked
	
	public function activateLook ( $topId:String, $btmId:String ):Void
	{
	   activeLookId = $topId + "-" + $btmId;
	   var info:LL_Update_VO = new LL_Update_VO()
	   info.activeLookId = activeLookId;
	   setChanged();
	   notifyObservers( info );
	}
}