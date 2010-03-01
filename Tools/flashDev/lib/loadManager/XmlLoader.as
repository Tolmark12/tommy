// Created by Mark Parson on 2007-08-01.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
//  
//
// -------- Description -------- //
//  
//
// -------- Sample Code -------- //
// import loadManager.XmlLoader;
//
// var mainXml:XmlLoader = new XmlLoader();
// mainXml.setCallBack(this, "XMLisLoadedCallBack");
// mainXml.startLoadingXML( "xml/file.xml" );

// todo: it would be nice if I could add some sort of "onData" handler
// http://livedocs.adobe.com/flash/8/main/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=00001586.html

import lib.loadManager.XmlParser

class lib.loadManager.XmlLoader extends XML
{
	var cbObj:Object;
	var cbFunc:String;
	var cbAr:Array;
	
	function XmlLoader()
	{
		this.ignoreWhite = true;
	}
	
	function setCallBack($obj:Object, $func:String, $ar:Array)
	{
		cbObj = $obj;
		cbFunc = $func;
		cbAr = $ar
	}
	
	function callBack($xml:Object)
	{
		cbObj[cbFunc]( $xml, cbAr[0], cbAr[1], cbAr[2], cbAr[3], cbAr[4], cbAr[5], cbAr[6] );
	}
	
	function onLoad()
	{
		var MainObj:Object = XmlParser.convertToObj(this.firstChild.childNodes);
		callBack( MainObj );
	}
	
	function startLoadingXML($url:String)
	{
		this.load($url);
	}
}