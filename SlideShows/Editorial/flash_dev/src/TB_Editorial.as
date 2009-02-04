package 
{
import app.AppFacade;

import flash.display.Sprite;

public class TB_Editorial extends Sprite
{
	private var _facade:AppFacade;
	
	public function TB_Editorial()
	{
		_facade = AppFacade.getInstance('app_facade');
		_facade.init(this);
	}

}
}