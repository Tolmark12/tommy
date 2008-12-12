package swc_components
{

import flash.display.*;
import flash.events.*;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import delorum.loading.*;
import map.model.vo.Location_VO;
import flash.utils.Timer;
import flash.events.TimerEvent;

public class Map extends MovieClip
{
	public static const STATE_CLICKED:String = "state_clicked";
	
	// The selected state
	private var _selectedState:State;
	
	// Push pins
	private var _pins:Sprite;
	private var _pinAr:Array;
	private var _pinShowIndex:uint;
	
	// The state last clicked
	public var lastClickedStateId:String;

	public function Map():void
	{
	}
	
	
	// ______________________________________________________________ Make
	
	public function build (  ):void
	{
		var statesAr:Array = 
		[
			'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA',
			'KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ',
			'NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT',
			'VA','WA','WV','WI','WY'
		];
		
		_pinAr = new Array(); 
		_pins = new Sprite();
		_pins.mouseChildren = false;
		_pins.mouseEnabled  = false;
		this.addChild( _pins );
		_texturizeStates( statesAr );
		//activateStates( statesAr );
	}
	
	// ______________________________________________________________ Activation initialization
	
	public function activateState ( $id:String, $locations:Array  ):void
	{
		var state:State = _getState( $id );
		if( state != null ) {
			state.makeActive();
			state.addEventListener( MouseEvent.CLICK,_handleStateClick );
			
			// Add any pushpin locations
			if( $locations != null ){
				_addPushPin( $locations, state );
			}
		}
	}
	
	private function _addPushPin ( $locations:Array, $state:State ):void
	{
		var len:uint = $locations.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var locationVo:Location_VO = $locations[i] as Location_VO;
			var pushPin:PushPin_swc = new PushPin_swc();
			pushPin.x = locationVo.x;
			pushPin.y = locationVo.y;
			_pins.addChild( pushPin );
			_pinAr.push (pushPin );
		}
	}
	
	public function showPushPins ( $delay:Number=100 ):void
	{
		_pinShowIndex = 0;
		var pinTimer:Timer = new Timer($delay, _pinAr.length-1);
		pinTimer.addEventListener("timer", _showAnotherPin );
		pinTimer.start();
		_showAnotherPin();
	}
	
	private function _showAnotherPin ( e:TimerEvent=null ):void
	{
		var pushPin:PushPin_swc = _pinAr[ _pinShowIndex++ ];
		pushPin.show();
	}
	
	// ______________________________________________________________ Selecting / DeSelecting
	
	public function deselectState ( $stateId:String ):void
	{
		_getState( $stateId ).deselect();
	}
	
	public function selectState ( $stateId ):void
	{
		_getState( $stateId ).select();
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _handleStateClick ( e:Event ):void
	{
		lastClickedStateId = e.currentTarget.name;
		this.dispatchEvent( new Event( STATE_CLICKED ) );
	}
	
	// ______________________________________________________________ Texturizing states
	
	private function _texturizeStates ( $states:Array ):void
	{
		// Copy the texture from the texture MovieClip that sits off stage
		var texture:MovieClip = this.getChildByName("textureMc") as MovieClip;
		var myBitmapData:BitmapData = new BitmapData(texture.width, texture.height);
		myBitmapData.draw( texture );
		texture.visible = false;
		
		// Plan for the fact that the states have been slightly shrunk
		var scaleBoost:Number = 1.1 + (1 - _getState("TX").scaleX);
		
		// Loop through all the states and apply the texture
		var len:uint = $states.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var state:State = _getState( $states[i] );
			if( state != null ) {
				var wide:Number = state.width * scaleBoost;
				var tall:Number = state.height * scaleBoost;
				
				var pixels:ByteArray = myBitmapData.getPixels( new Rectangle(state.x,state.y,wide,tall) );
				pixels.position = 0;
				var stateBitmapData = new BitmapData(wide, tall);
				stateBitmapData.setPixels( new Rectangle(0,0,wide,tall), pixels);
				var bitmap:Bitmap = new Bitmap( stateBitmapData );
				state.setTexture(bitmap);
			}
		}
	}


	// ______________________________________________________________ Helpers
	
	private function _getState ( $stateName:String ):State
	{
		return this.getChildByName( $stateName ) as State;
	}
}

}