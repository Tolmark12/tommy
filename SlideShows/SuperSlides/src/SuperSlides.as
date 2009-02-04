package 
{

import flash.display.Sprite;
import app.AppFacade;

public class SuperSlides extends Sprite
{
	public function SuperSlides():void
	{
		_start();
	}
	
	private function _start (  ):void
	{
		var myFacade:AppFacade = AppFacade.getInstance( 'app_facade' );
		myFacade.startup( this );
	}

}

}