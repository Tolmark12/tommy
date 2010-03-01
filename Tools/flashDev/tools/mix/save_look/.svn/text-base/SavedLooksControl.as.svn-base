import mvc.*;
import util.*;
import tools.mix.save_look.*;


class SavedLooksControl extends AbstractController
{
	
	public function SavedLooksControl($model:Observable)
	{
		super($model);
	}
	
	public function saveLookBtnClick (  ):Void
	{
		SavedLooksModel( getModel() ).saveCurrentLook();
	}
	
	public function lookLockerClick ( $ids:String ):Void
	{
		var ar:Array = $ids.split('-');
		SavedLooksModel( getModel() ).activateLookById( ar[0], ar[1] );
	}
}