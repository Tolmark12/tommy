import mvc.*;
import util.*;
import tools.mix.main.*;


class tools.mix.main.MainControl extends AbstractController
{
	public function MainControl($model:Observable)
	{
		super($model);
	}
	
	// Signal change in the main top item
	private function changeTopItem ( $id ):Void
	{
		MainModel( getModel() ).changeTopProduct($id);
	}
	
	// Signal change in the main bottom item
	private function changeBtmItem ( $id ):Void
	{
		MainModel( getModel() ).changeBtmProduct($id);
	}
	
	
	// _______________________________________________________________________ Switch Function
	
	public function handleBroadcast($broadcastId:String, 
									$o,//:Observable, 
									$infoObj:Object):Void
	{
		switch( $broadcastId )
		{
			case 'topBrowser':
			  changeTopItem( $o.getActiveItemId() );
			break;
			
			case 'bottomBrowser':
			  changeBtmItem( $o.getActiveItemId() );
			break;
			
			case 'saveTheLook':
			  var info = tools.mix.save_look.SavedLookUpdate_VO( $infoObj )
			  if( info.activeLook != undefined ) 
			  {
				// The info.activeLook's type is: tools.mix.save_look.SavedLook_VO
				var look = tools.mix.save_look.SavedLook_VO( info.activeLook );
			    changeTopItem( look.topItemId );
			    changeBtmItem( look.btmItemId );
			  }
			break;
			
			case 'topDetailArea':
			  //
			break;
			
			case 'bottomDetailArea':
			  //
			break;
		}
	}
}