// Created by Mark Parson on 2007-08-28.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
// lib.product.ItemAttribute;
// lib.product.attribute.Colors;
// 
// -------- Description -------- //
// 
// 
// -------- Sample Code -------- //
//

import lib.product.attribute.Colors;
import lib.product.ItemAttribute;
import lib.product.attribute.OptionVo;

// !! An item is a: style + color + size !!

class lib.product.Item
{
	private var title			:String;
	private var description		:String;
	private var scene7Id		:String;
	private var uniqueId		:String;
	private var size			:String;
	private var style			:String;
	private var attributeObj	:Object;		// Holds all Attributes
	
	public function Item( $xmlObj:Object )
	{
		uniqueId 	= $xmlObj.productId;
		scene7Id 	= $xmlObj.scene7id;
		title 		= $xmlObj.title;
		description	= $xmlObj.description;
		populateAttributes( $xmlObj.attributes );
	}
	
	// The attribute  ("Color", "Size", "etc")
	// $value - The index of the value
	public function setAttributeValue( $kind:String, $newValue:String, $valueIndex:Number ):Void
	{
		attributeObj[$kind].currentValueIndex = $valueIndex;
		// TODO: Double check that this does change the value of the 
		// "ItemAttribute" inside of the attributeObj
		// var attribute = ItemAttribute( attributeObj[ $kind ] );
		// attribute.value = $newValue;
	}
	
	/////////////////////////////////////////////
	// ---------- Private Functions ---------- //
	/////////////////////////////////////////////
	
	private function populateAttributes ( $attributeXml:Object ):Void
	{
		attributeObj = new Object();
		for( var i:String in $attributeXml )
		{
			attributeObj[i] = new ItemAttribute();
			var ar:Array = new Array()
			ar.push( new OptionVo( 'null', $attributeXml[i].dispName) );
			for( var j:String in $attributeXml[i].options )
			{
				ar.push( new OptionVo( j, $attributeXml[i].options[j].value ) );
			}
			
			attributeObj[i].optionsAr 	= ar;
			attributeObj[i].classType	= i;
		}
	}
	
	// ---------- Getters and Setters ---------- //
	public function getId 			(  ) :String { return uniqueId; };
	public function getS7ImageName	(  ) :String { return scene7Id; };
	public function getTitle		(  ) :String { return title; };
	public function getAttributes 	(  ) :Object { return attributeObj; };
	public function getDescription 	(  ) :String { return description; };
}








