import util.Observable;
import lib.product.attribt_interface.drop.*;

class DM_Model extends Observable
{
	//Data
	//private var currentBtn		:Button;
	private var name			:String;
	private var currentValue	:String;
	private var titleText		:String;
	private var buttonsList	 	:Array;
	private var currentIndex 	:Number;
	private var isOpen			:Boolean;
	
	public function DM_Model( $name:String )
	{
		name = $name;
	}
	
	// Set the contents of the buttons array
	public function setButtonsAr ( $options:Array, $index:Number  ):Void
	{
		var info:DM_UpdateVO = new DM_UpdateVO();
		
		if( buttonsList != $options ) 
		{
			info.optionsAr  = $options;
			setChanged();
		}
		
		if( $index != currentIndex ) 
		{	
			currentIndex 			 = $index
			info.indexOfSelectedItem = $index;
			setChanged();
		}
		
		notifyObservers( info );
	}
	
	// Change the open state of the dropDown
	// $state - "open" or "closed"
	public function changeOpenState ( $newState:String ):Void
	{
		var info:DM_UpdateVO = new DM_UpdateVO();
		
		if( $newState == "open" && !isOpen ) 
		{
			info.isOpen = true
			isOpen = true;
			setChanged();
		}else if( $newState == "closed" && isOpen ) 
		{
			info.isOpen = false;
			isOpen = false;
			setChanged()
		}
		
		notifyObservers( info );
	}
	
	public function setNewValue ( $newValue:String, $newIndex:Number  ):Void
	{
		
		if( $newValue != currentValue )
		{
			changeMainTitleText( $newValue )
			currentValue = $newValue;
			var info:DM_UpdateVO = new DM_UpdateVO();
			info.name = name;
			info.newValue = $newValue;
			info.valueIndex = currentIndex = $newIndex;
			setChanged();
			notifyObservers( info );
		}
	}
	
	public function changeMainTitleText( $str:String ):Void
	{
		if( $str != titleText )
		{
			var info:DM_UpdateVO = new DM_UpdateVO();
			info.titleText = titleText = $str;
			setChanged();
			notifyObservers( info );
		}
	}
	
	// Set title only if there is not currently any text there
	public function setDefaultText ( $str:String ):Void
	{
		if( titleText == undefined )
		{
			changeMainTitleText( $str );
		}
	}
	
	public function getButtonsList 	(  ):Array	{ return buttonsList; };
	public function getButtonsArray (  ):Array	{ return buttonsList.split(','); };
	public function getCurrentIndex (  ):Number	{ return currentIndex; };
	public function getCurrentState (  ):Boolean{ return isOpen; };
}