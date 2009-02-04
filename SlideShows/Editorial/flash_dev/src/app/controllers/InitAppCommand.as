package app.controllers
{
import app.Model.SlidesProxy;
import app.views.StageMediator;

import flash.display.Sprite;

import org.puremvc.as3.multicore.interfaces.ICommand;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

public class InitAppCommand extends SimpleCommand implements ICommand
{
	
	override public function execute(notification:INotification):void
	{
		var stage:Sprite = notification.getBody() as Sprite;
		
		//register Mediators
		facade.registerMediator( new StageMediator( stage ) );
		
		//register Proxies
		var slideProxy:SlidesProxy = new SlidesProxy( stage );
		facade.registerProxy( slideProxy );
		
		//load xml configuration
		slideProxy.loadConfig();
	}
	
	
}
}