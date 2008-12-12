package map.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import map.MapFacade;
import map.model.vo.*;
import delorum.loading.XmlLoader;
import flash.display.*;
import flash.events.*;
import flash.external.ExternalInterface;

public class StatesProxy extends Proxy implements IProxy
{
	public static const NAME:String = "states_proxy";
	
	private var _states:Array;
	private var _currentStateIndex:int = -1;
	
	public function StatesProxy( ):void
	{
		super( NAME );
	}
	
	public function loadXml ( $stage:Stage ):void
	{
		// Get the var from the html flash tag params, or use the local testing file.
		var xmlPath:String	= ( $stage.loaderInfo.parameters.xmlPath   != null )? $stage.loaderInfo.parameters.xmlPath   : 'flash_xml/activeStates.xml' ;
		
		// Load Xml
		var ldr:XmlLoader 	= new XmlLoader( xmlPath );		
		ldr.onComplete		= _parseXml;
		ldr.loadItem();
	}
	
	private function _parseXml ( e:Event ):void
	{
		_states 	= new Array
		var xml:XML =  XML( e.target.data );
		for each( var node:XML in xml.states.state )
		{
			var stateVo:State_VO = new State_VO();
			stateVo.id			= node.@id;
			stateVo.locations	= new Array();
			
			for each( var loc:XML in XML( node ).loc )
			{
				var locationVo:Location_VO = new Location_VO();
				locationVo.x 			= loc.@x;
				locationVo.y 			= loc.@y;
				locationVo.link 		= loc.@link;
				locationVo.type 		= loc.@type;
				locationVo.name 		= loc.@name;
				locationVo.description	= String( loc.description.descendants("*").toXMLString() );
				
				stateVo.locations.push( locationVo );
			}
			
			_states.push( stateVo );
		}
		
		sendNotification( MapFacade.INIT_STATES, _states );
	}
	
	// ______________________________________________________________ Activating States
	
	public function activateStateByIndex ( $index:uint ):void
	{
		var newStateVo:State_VO 	= _states[ $index ];
		
		if( _currentStateIndex != $index ){
			// Deselect active state, if there is one
			if( _currentStateIndex != -1){
				var oldStateVo:State_VO = _states[_currentStateIndex] as State_VO;
				sendNotification( MapFacade.DESELECT_STATE, oldStateVo.id );
			}
			
			// Save active index, and activate
			_currentStateIndex = $index;
			sendNotification( MapFacade.SELECT_STATE, newStateVo.id );
			
			// Send notification to javascript
			if( ExternalInterface.available ) 
				ExternalInterface.call( "flashStateClicked", newStateVo.id );
		}
			
	}
	
	public function activateStateByName ( $stateId:String ):void
	{
		var len:uint = _states.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var stateVo:State_VO = _states[i] as State_VO;
			if( stateVo.id == $stateId ) 
				activateStateByIndex( i );
		}
	}
}
}
