package app.controllers
{
import app.Model.SlidesProxy;
import app.views.MainSlideMediator;
import app.views.StageMediator;
import app.views.ThumbnailMediator;

import flash.display.Sprite;

import org.puremvc.as3.multicore.interfaces.ICommand;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

import app.views.InfoMediator;

public class InitStageComponents extends SimpleCommand implements ICommand
{
	override public function execute(notification:INotification):void
	{
		var stage:StageMediator = facade.retrieveMediator(StageMediator.NAME) as StageMediator;
		var mainSlide:PaperFrame_swc = stage.mainSlide;
		var thumbnails:Sprite = stage.thumbnails;
		var info:PaperTag_swc = stage.info;
		
		facade.registerMediator( new MainSlideMediator( mainSlide ) );
		facade.registerMediator(new InfoMediator( info ) );
		
		var slideProxy:SlidesProxy = facade.retrieveProxy(SlidesProxy.NAME) as SlidesProxy;
		slideProxy.setDefaultSlide();

		var thumbNailMediator:ThumbnailMediator = new ThumbnailMediator( thumbnails );
		facade.registerMediator( thumbNailMediator );
		thumbNailMediator.build( slideProxy.slideList );
	}
	
}
}