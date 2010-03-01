import util.*;
import mvc.*;
import tools.mix.save_look.*;
import caurina.transitions.Tweener;
import mx.utils.Delegate;
import tools.mix.save_look.looks.LookLocker;


class SavedLooksView extends AbstractView
{
	private var savedLooksMc	:MovieClip;
	private var holdLookBtn 	:MovieClip;
	private var lookLocker		:LookLocker;
	private var updateListener	:SavedLookSubBroadcast;
	
	public function SavedLooksView ( $m:Observable, $c:Controller, $mc:MovieClip )
	{	
		super($m, $c);
		savedLooksMc = $mc;
		holdLookBtn  = savedLooksMc.holdLookBtn;
		make();
	}
	
	// _______________________________________________________________________ Update from Model's broadcast
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info = SavedLookUpdate_VO( $infoObj );
		
		if( info.potentialLook != undefined ) 
		{
			var itemIds = SavedLook_VO( info.potentialLook );
			showSavedLooksMc();
		}
				
		if( info.newLookToSave != undefined ) 
		{
			var look:SavedLook_VO = info.newLookToSave;
			addNewSavedLook( look.topItemId, look.btmItemId );
		}
	}
	
	// _______________________________________________________________________ Make
	
	private function make (  ):Void
	{
		// Set Event Handler
		holdLookBtn.onRelease 	=  Delegate.create( this.getController(), this.getController()['saveLookBtnClick'] );
		// Create holder mc for looks
		var lockerMc:MovieClip	= savedLooksMc.createEmptyMovieClip( 'lockerMc', 2 );
		lockerMc._x = 145; 
		lockerMc._y = 14;
		
		lookLocker = new LookLocker( lockerMc );
		
		// Add Listener to look Locker's model broadcast
		updateListener = new SavedLookSubBroadcast( lookLocker.getModel(), getController() );
		lookLocker.addObserverToModel( updateListener );
		
	}
	
	
	
	// _______________________________________________________________________ Managing saved looks
	
	private function addNewSavedLook ( topItemId:String, btmItemId:String ):Void
	{
		lookLocker.addLook(topItemId, btmItemId);
	}
	
	// _______________________________________________________________________  Tween Main Mc into the visible position
	private function showSavedLooksMc (  ):Void
	{
		// If it hasn't twneede up into place yet...
		if( savedLooksMc._y != 15 ) 
		{
			Tweener.addTween( savedLooksMc, {_y:15, time:1.3, transition:"easeInOutQuint"} );
			
		}
	}
}