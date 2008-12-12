package app.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.AppFacade;
import app.model.vo.*;
import flash.display.Sprite;
import delorum.loading.ImageLoader;
import flash.events.*;
import flash.display.*;
import flash.geom.*;
import app.view.components.*;

public class FrameMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "frame_mediator";
	
	private var _frame:FrameMc_swc;
	private var _logoHolder:Sprite;
	private var _navHolder:Sprite;
	
	// Line
	private var _lineBitmap:Bitmap;
	private var _lineBox:Sprite;
	
	// Logo
	private var _logoHref:String;
	
	public function FrameMediator():void
	{
		super( NAME );
   	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	AppFacade.INIT_FRAME,
		    		AppFacade.BUILD_NAVIGATION,
					AppFacade.ONLY_ONE_SLIDE,	];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.INIT_FRAME:
				_initNav( note.getBody() as FrameParams_VO );
				break;
			case AppFacade.BUILD_NAVIGATION:
				_buildNav( note.getBody() as Nav_VO );
				break;
			case AppFacade.ONLY_ONE_SLIDE:
				_frame.setLineState( FrameMc.NO_THUMBNAILS );
				break;
		}
	}
	
	public function init ( $stage:Sprite ):void 
	{
		_frame	 		= new FrameMc_swc();
		_logoHolder		= new Sprite();
		_navHolder		= new Sprite();
		_lineBox		= new Sprite();
		
		_frame.x		= 6;
		_frame.y		= 6;
		_navHolder.x	= 33;
		_navHolder.y	= 20;

		_frame.addChild( _lineBox 	 );
		_frame.addChild( _logoHolder );
		_frame.addChild( _navHolder  );
		$stage.addChild( _frame 	 );
		
		// set default state
		_frame.setLineState();
	}
	
	// ______________________________________________________________ Initializing and building frame
	
	private function _initNav ( $frameParams:FrameParams_VO ):void
	{
		// logo
		_logoHref = $frameParams.logoHref;
		var ldr:ImageLoader = new ImageLoader( $frameParams.logoPath, _logoHolder );
		_logoHolder.x = $frameParams.logoX;
		_logoHolder.y = $frameParams.logoY;
		ldr.addEventListener( Event.COMPLETE, _logoLoadedHandler );
		ldr.loadItem();
	}
	
	// ______________________________________________________________ Building navigation
	
	public function _buildNav ( $navVo:Nav_VO ):void
	{
		var xPos:uint = 0;
		var len:uint = $navVo.navItems.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var navItemVo:NavItem_VO 	= $navVo.navItems[i] as NavItem_VO;
			var navBtn:NavBtn_swc		= new NavBtn_swc();
			navBtn.addEventListener( NavBtn.NAV_CLICK, _handleNavBtnClick );
			
			navBtn.text		= navItemVo.text;
			navBtn.x 		= xPos;
			navBtn.initEvents( navItemVo.linkClass );
			
			_navHolder.addChild( navBtn );
			xPos += navBtn.width + 13;
		}
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _handleNavBtnClick ( e:Event ):void
	{
		var navBtn:NavBtn_swc = e.currentTarget as NavBtn_swc;
		sendNotification( AppFacade.NAV_BTN_CLICK, navBtn.text );
	}
	
	private function _handleLogoClick ( e:Event ):void
	{
		sendNotification( AppFacade.LOGO_BTN_CLICK, _logoHref );
	}
	
	private function _logoLoadedHandler ( e:Event ):void
	{
		_logoHolder.buttonMode = true;
		_logoHolder.addEventListener(MouseEvent.CLICK, _handleLogoClick);
	}
	
}
}