package 
{

import flash.display.*;
import app.AppFacade;
import app.view.components.NavDrawer;

public class SuperSlides extends Sprite
{
	// Items on the stage
	public var navMc:NavDrawer;
	
	public function SuperSlides():void
	{
		navMc = this.getChildByName( "navMc" ) as NavDrawer;
		_start();
	}
	
	private function _start (  ):void
	{
		var myFacade:AppFacade = AppFacade.getInstance( 'app_facade' );
		myFacade.startup( this );
	}

}

}