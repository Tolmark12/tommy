// Created by Mark Parson on 2007-09-24.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
// 
// 
// -------- Description -------- //
// This class allows the storage of items. It also handles their modification as 
// well as their retrieval.
// 
// -------- Sample Code -------- //
//

import lib.product.*
import lib.html.Bridge;


class ItemRepository
{
	private static var itemObj:Object = new Object();
	
	
	//////////////////////////////////////////////////////
	// ---------- Create new Item + load xml ---------- //
	//////////////////////////////////////////////////////
	public static function newItem ( $id:String,
		 							 $cbObj:Object,
									 $cbFunc:String )
	{		
		// make sure an $id was passed
		if( $id == undefined ) 
		{
			return null
		}
		// If it alread exists, send existing Item to callback
		else if( itemObj[$id] != undefined ) 
		{
			$cbObj[$cbFunc]( itemObj[$id] );
		}
		// Else create a new item, and load new xml
		else
		{
			Bridge.getProductXmlById ( $id, ItemRepository, "itemXmlLoadedCallBack", [$id, $cbObj, $cbFunc] );
		}
	}
	
	public static function itemXmlLoadedCallBack ( 	$xml:Object, 
													$id:String, 
													$cbObj:Object, 
													$cbFunc:String ):Void
	{                                                           
		var item:Item = new Item( $xml.product );
		itemObj[$id] = item;
		$cbObj[$cbFunc]( item );
	}
	//////////////////////////////////////////////////////
	//////////////////////////////////////////////////////
	
	// Returns the Item specified via the "id"
	public static function getItemById ( $id:String ):Item
	{
		return Item( itemObj[$id] );
	}
	
	public static function modifyItemProperty ( $id:String,				// Item Id
												$prop:String, 			// Property to receive new value
												$val:String ):Void		// New value
	{
		var item = Item( itemObj[$id] );
		item.setAttributeValue ($prop, $val);
	}
}