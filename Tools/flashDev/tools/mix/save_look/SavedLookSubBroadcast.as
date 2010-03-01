import util.*;
import mvc.*;
import tools.mix.save_look.*;
import tools.mix.save_look.looks.LL_Update_VO;

class SavedLookSubBroadcast extends AbstractView
{
	
	public function SavedLookSubBroadcast ( $m:Observable, $c:Controller )
	{
		super($m, $c);
	}
	
	// ---------- Update from Model's broadcast ---------- //
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info:LL_Update_VO = LL_Update_VO( $infoObj );
		
		if( info.activeLookId != undefined )
		{
			SavedLooksControl( getController() ).lookLockerClick( info.activeLookId );
		}
	}
}