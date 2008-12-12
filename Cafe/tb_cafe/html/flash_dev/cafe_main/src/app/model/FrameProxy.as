package app.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.model.vo.*;
import app.AppFacade;
import flash.net.*;
public class FrameProxy extends Proxy implements IProxy
{
	public static const NAME:String = "frame_proxy";
	
	private var _navAr:Array;
	
	public function FrameProxy( ):void
	{
		super( NAME );
	}
	
	public function initFrame ( $xml:XML ):void
	{
		_navAr = new Array()
		for each( var node:XML in $xml.topnav.a)
		{
			var vo:NavItem_VO = new NavItem_VO();
			vo.href 		= node.@href;
			vo.text 		= String( node ).toUpperCase();
			vo.target		= ( String( node.@target ).length != 0 )? node.@target : "_self";
			vo.linkClass	= ( String( node.@id ).length != 0 )? node.@id : null;
			_navAr.push( vo );
		}
		var navVo:Nav_VO			= new Nav_VO();
		var frameVo:FrameParams_VO 	= new FrameParams_VO();
		frameVo.logoPath			= $xml.logo.@src;
		frameVo.logoHref			= $xml.logo.@href;
		frameVo.logoX			   	= Number( $xml.logo.@x );
		frameVo.logoY			   	= Number( $xml.logo.@y );
		
		navVo.navItems = _navAr;
		
		sendNotification( AppFacade.INIT_FRAME, frameVo			);
		sendNotification( AppFacade.BUILD_NAVIGATION, navVo		);
	}
	
	public function gotoNewPage ( $txt:String ):void
	{
		var len:uint = _navAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var vo:NavItem_VO = _navAr[i] as NavItem_VO;
			if( vo.text == $txt ) {
				gotoURL( vo.href, vo.target );
			}
		}
	}
	
	public function gotoURL ( $url:String="", $target:String="_self" ):void
	{
		var loader:URLLoader = new URLLoader();
		var request:URLRequest = new URLRequest( $url );
		navigateToURL( request, $target );
	}
	
	//sendNotification( AppFacade.NOTIFICATION, someParameter );
}
}
