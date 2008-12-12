package map.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import map.MapFacade;
import map.model.vo.*;
import flash.display.Sprite;
import flash.events.*;
import swc_components.Map;

public class MapMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "map_mediator";
	
	private var _holder:Sprite;
	private var _map:Map_swc;
	
	public function MapMediator():void
	{
		super( NAME );
   	}
	
	public function init ( $stage:Sprite ):void
	{
		_holder = $stage;
	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [	MapFacade.INIT_STATES,
		    		MapFacade.DESELECT_STATE,
					MapFacade.SELECT_STATE];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case MapFacade.INIT_STATES:
				_createMap( note.getBody() as Array );
				break;
			case MapFacade.SELECT_STATE:
				_map.selectState( note.getBody() as String )
				break;
			case MapFacade.DESELECT_STATE:
				_map.deselectState( note.getBody() as String)
				break
		}
	}
	
	// ______________________________________________________________ Make
	
	private function _createMap ( $activeStates:Array ):void
	{
		_map = new Map_swc();
		_map.x = 5;
		_map.y = 5;
		_holder.addChild(_map);
		_map.build();
		_map.addEventListener( Map.STATE_CLICKED, _handleStateClick );
		
		var len:uint = $activeStates.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var stateVo:State_VO = $activeStates[i] as State_VO;
			_map.activateState(stateVo.id, stateVo.locations);
		}
		
		_map.showPushPins();
	}
	
	// ______________________________________________________________ Event Handlers
	
	public function _handleStateClick ( e:Event ):void{ facade.sendNotification( MapFacade.STATE_CLICK, _map.lastClickedStateId); };
}
}