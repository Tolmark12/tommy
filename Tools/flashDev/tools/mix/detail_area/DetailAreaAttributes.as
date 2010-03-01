import util.*;
import mvc.*;
import tools.mix.detail_area.*;
import lib.product.Item;
import lib.product.ItemAttribute;
import lib.product.attribt_interface.bagbtn.AddToBagBtn;

import lib.product.attribute.*;


class DetailAreaAttributes extends AbstractView
{
	private var mainMc			:MovieClip;
	
	// Visible ObjectS in MainMc
	private var titleTxtField	:TextField;
	private var attributeMc		:MovieClip;
	private var addToBagHolder	:MovieClip;
	private var attributeObj	:Object;			// An object that stores references to all the Attributes for removing
	private var showInfoBtn		:MovieClip;
	private var showControlsBtn	:MovieClip;
	private var bodyTxtField	:TextField;
	private var bodyTxtHolder	:MovieClip;
	
	public function DetailAreaAttributes( $o:Observable, $m:Controller, $mc:MovieClip )
	{
		super($o, $m);
		mainMc = $mc;
		make();
	}
	
	public function update ($o:Observable, $infoObj:Object)
	{
		var info:DetailArea_Vo = DetailArea_Vo($infoObj);
		
		if(info.newItem != undefined)
		{
			//Consider moving this into a function
			var newItem:Item = Item( info.newItem );
			
			updateTitle       ( newItem.getTitle() 	 		);
			updateDescription ( newItem.getDescription() 	);
			addAttributes  	  ( newItem.getAttributes() 	);
			showControlsBtn.onRelease();
		}
		
		if( info.contentToShow != undefined ) 
		{
			if( info.contentToShow == 'info' ) 
				toggleWhatIsVisible ('controls');
			else
				toggleWhatIsVisible ('info');
		}
	}
	
	// _______________________________________________________________________ Make
	
	private function make (  ):Void
	{
		mainMc._x = 200;
		
		// Product Title
		var titleMc:MovieClip = mainMc.attachMovie('typeTxtField', 'titleHolderMc', 1 );
		titleTxtField = titleMc.titleTxt;
		titleTxtField.text = "Tommy Bahama shirts of the long sleeve"
		titleTxtField.autoSize = true;
		titleTxtField.multiline = true;
		
		// Buttons to switch between seeing product info, and product controls
		var con = DetailAttributesControl( getController() );
		showInfoBtn		= mainMc.attachMovie('categoryBtn', 'switchBth', 2  );
		showControlsBtn = mainMc.attachMovie('categoryBtn', 'controlsBtn', 3);
		showInfoBtn.setText ("Show Product Info");
		showControlsBtn.setText ("Show Controls");
		showInfoBtn._x = 100;
		showControlsBtn._x = 120;
		showInfoBtn._y = showControlsBtn._y = 20;
		showControlsBtn._visible = false;
		// -- Set Release functionality
		showInfoBtn.param	  = 'info';
		showControlsBtn.param = 'controls';
		showInfoBtn.con = showControlsBtn.con = con;
		showInfoBtn.onRelease = showControlsBtn.onRelease = function(){this.con.displayBtnClick( this.param ); };
		
		// TODO: Create button for toggling between info and controls. It should extend the same class as the info button
		//showInfoBtn.setReleaseCallBack	   	( DetailAttributesControl( getController() ), 'displayBtnClick', 'info');
		//showControlsBtn.setReleaseCallBack	( DetailAttributesControl( getController() ), 'displayBtnClick', 'controls');
		
		// Add the product info Text Field
		bodyTxtHolder = mainMc.attachMovie('productInfo', 'bodyTxtHolder', 4);
		bodyTxtHolder._y = 40;
		bodyTxtField  = bodyTxtHolder.txtField;	
		
		// Add-to-Bag button holder
		addToBagHolder = mainMc.createEmptyMovieClip('bagHolder', 5);
		addToBagHolder._y = 145;	
		
		// Attribute holder
		attributeMc = mainMc.createEmptyMovieClip('attholder', 6);
		attributeMc._y = 30;
	}
	
	// _______________________________________________________________________ Updating Item Info
	
	//  Build the appropriate attribute values
	private function addAttributes ( $attributes:Object ):Void
	{	
		removeCurrentAttributes ();
		var con = DetailAttributesControl( getController() );
		var count:Number = 0;
		for( var i:String in  $attributes )
		{
			var itemAtrbt:ItemAttribute = ItemAttribute( $attributes[i] )
			var mc:MovieClip = attributeMc.createEmptyMovieClip('holder' + count, 100 - count);
			mc._y = 25 * count++
			var attClass = getClass (i);
			var attrbt = attributeObj[i] = new attClass( mc, itemAtrbt.optionsAr, $attributes[i].currentValueIndex, i);
			attrbt.setChangeHandler( con, 'attributeClick' );
		}
		
		// Attach Add To Bag Button
		var bagBtn:AddToBagBtn = new AddToBagBtn( addToBagHolder );
		bagBtn.setChangeHandler( con, 'attributeClick', ['AddToBag'] );
	}
	
	//  Title 
	private function updateTitle ( $str:String ):Void
	{
		titleTxtField.text = $str;
	}
	//  Body Text 
	private function updateDescription ( $str:String ):Void
	{
		bodyTxtField.htmlText = $str;
	}
	//  Showing and Hiding the info/controls
	private function toggleWhatIsVisible ( $str:String ):Void
	{
		var showVis:Boolean;
		var infoVis:Boolean;
		
		if( $str == 'info' ) 
		{
			showVis = true;
			infoVis = false;
		}else{
			showVis = false;
			infoVis = true;
		}
		
		showInfoBtn._visible = showVis;
		showControlsBtn._visible = infoVis;
		bodyTxtHolder._visible = infoVis;
		attributeMc._visible = showVis;
	}
	

	// _______________________________________________________________________ Private Helper methods

	public function removeCurrentAttributes (  ):Void
	{
		for( var i:String in attributeObj )
		{
			attributeObj[i].remove();
		}
	}
	

	// _______________________________________________________________________ Getters / Setters

	public function getClass( $cls:String ):Object
	{
		switch( $cls )
		{
			case "Size":
			  return Size;
			break
			case "Colors":
			  return Quantity;
			break
			case "Quantity":
			  return Quantity;
			break
		}
	}
}
