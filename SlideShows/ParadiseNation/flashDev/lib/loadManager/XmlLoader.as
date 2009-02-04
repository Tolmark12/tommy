// Created by Mark Parson on 2007-08-01.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
//  
//
// -------- Description -------- //
//  
//
// -------- Sample Code -------- //
// import lib.loadManager.XmlLoader;
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
	
	function XmlLoader()
	{
		this.ignoreWhite = true;
	}
	
	function setCallBack($obj:Object, $func:String)
	{
		cbObj = $obj;
		cbFunc = $func;
	}
	
	function callBack($cbAR:Array)
	{
		cbObj[cbFunc]($cbAR[0], $cbAR[1], $cbAR[2], $cbAR[3], $cbAR[4], $cbAR[5], $cbAR[6]);
	}
	
	function onLoad()
	{
		var MainObj:Object = XmlParser.convertToObj(this.firstChild.childNodes);
		callBack([MainObj]);
	}
	
	function startLoadingXML($url:String)
	{
		this.load($url);
	}
}