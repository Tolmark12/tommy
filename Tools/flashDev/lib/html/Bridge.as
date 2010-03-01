// Created by Mark Parson on 2007-08-08.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
// flash.external.ExternalInterface
//
// -------- Description -------- //
//  Handles all communication with external javascript, php, etc
//
// -------- Sample Code -------- //
// html.Bridge.addToCart();

import flash.external.ExternalInterface;
import lib.loadManager.XmlLoader;

class lib.html.Bridge
{

	// _______________________________________________________________________ Get Specific Product XML
	public static function getProductXmlById ( $id:String, $obj:Object, $cbFunc:String, $cbAr:Array):Void
	{
		// TODO: Will need to call a javascript function or a serverside script
		// that outputs the xml
		
		var mainXml:XmlLoader = new XmlLoader();
		mainXml.setCallBack($obj, $cbFunc, $cbAr);
		mainXml.startLoadingXML( "flash_loads/xml/" + $id +".xml" );  //FIXME - Dummy Data
	}
	
	public static function getPage($url:String)
	{
		getURL( $url, '_BLANK' );
	}
	
	public static function javascript($function:String, $varsAr:String)
	{
		var vars = $varsAr.split(',');
		var temp = ExternalInterface.call($function, vars[0],vars[1], vars[2], vars[3],vars[4], vars[5], vars[6]) ;
	}
	
	public static function javaTrace($str)
	{
		var temp = ExternalInterface.call('alert', $str);
		trace($str);
	}
	
	public static function addToCart()
	{
		// Add functionality for adding to cart
		trace('addingToCart');
	}
}