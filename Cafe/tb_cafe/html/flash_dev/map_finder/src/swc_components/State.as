package swc_components
{

import flash.display.*;
import flash.events.*;
import flash.filters.*;


public class State extends MovieClip
{
	
	private var _isSelected:Boolean = false;
	private var _holder:Sprite;
	private var _matrixActive:Array;
	
	public function State():void
	{
		//makeActive();
		_holder = new Sprite();
		this.addChild(_holder);
		_initMatrix()
	}
	
	// ______________________________________________________________ API
	
	public function makeActive (  ):void
	{
		var filter:ColorMatrixFilter = new ColorMatrixFilter(_matrixActive);
		_holder.filters = [ filter ];
		
		_holder.buttonMode = true;
		_holder.addEventListener( MouseEvent.MOUSE_OVER, _mouseOver );
		_holder.addEventListener( MouseEvent.MOUSE_OUT, _mouseOut   );
	}
	
	public function setTexture ( $bitmap:Bitmap ):void
	{
		var maskShape:MovieClip = this.getChildByName( "masker" ) as MovieClip;
		_holder.addChild( $bitmap );
		if( maskShape != null ) 
			$bitmap.mask = maskShape;	
	}
	
	// ______________________________________________________________ State
	
	public function select (  ):void
	{
		_isSelected = true;
		_holder.alpha = .8;
	}
	
	public function deselect (  ):void
	{
		_isSelected = false;
		_holder.alpha = 1;
	}
	
	// ______________________________________________________________ Color Matrix
	
	private function _initMatrix (  ):void
	{
		_matrixActive = new Array()
		_matrixActive = _matrixActive.concat( [1, 0.25, 0, 0, -91] );
		_matrixActive = _matrixActive.concat( [0, 1, 0, 0, -58]    );
		_matrixActive = _matrixActive.concat( [0, 0, 1, 0, -46]    );
		_matrixActive = _matrixActive.concat( [0, 0.03, 0, 1, 0]   );
	}
	
	// ______________________________________________________________ Event Handlers
	
	private function _mouseOver ( e:Event ):void
	{
		if( !_isSelected ) 
			_holder.alpha = 0.9;
	}
	
	private function _mouseOut ( e:Event ):void
	{
		if( !_isSelected ) 
			_holder.alpha = 1;
	}
	
}

}