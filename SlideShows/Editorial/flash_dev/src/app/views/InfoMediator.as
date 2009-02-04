package app.views
{
import app.AppFacade;
import app.Model.vo.Slide_VO;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.interfaces.INotification;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

public class InfoMediator extends Mediator implements IMediator
{
	public static const NAME:String		= "info_mediator";
	
	public function InfoMediator($slideInfo:PaperTag_swc)
	{
		super(NAME, $slideInfo);
	}
	
	public function get slideInfo():PaperTag_swc
	{
		return getViewComponent() as PaperTag_swc;
	}
	
	override public function listNotificationInterests():Array
	{
		return [
					AppFacade.DISPLAY_NEW_SLIDE
				];
	}
	
	override public function handleNotification(notification:INotification):void
	{
		switch(notification.getName())
		{
			case AppFacade.DISPLAY_NEW_SLIDE :
				_changeInfo(notification.getBody() as Slide_VO);
				break;
		}
	}
	
	private function _changeInfo( $slide:Slide_VO ):void
	{
		slideInfo.changeInfo(	$slide.title,
								$slide.date,
								$slide.blurb,
								$slide.magazineLinkText,
								$slide.magazineLink,
								$slide.magazineLinkTarget,
								$slide.productLinkText,
								$slide.productLink,
								$slide.productLinkTarget
															);
	}
	
}
}