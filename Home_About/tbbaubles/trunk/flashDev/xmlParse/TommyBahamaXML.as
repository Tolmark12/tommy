import xmlParse.XMLparser;

class xmlParse.TommyBahamaXML extends XML
{
	var cbObj:Object;
	var cbFunc:String;
	var cbAr:Array;
	
	function TommyBahamaXML()
	{
		this.ignoreWhite = true;
	}
	
	function setCallBack($obj:Object, $func:String, $ar:Array)
	{
		cbObj = $obj;
		cbFunc = $func;
		cbAr = $ar
	}
	
	function callBack($xmlObj:Object)
	{
		cbObj[cbFunc]($xmlObj, cbAr[0], cbAr[1], cbAr[2], cbAr[3], cbAr[4], cbAr[5], cbAr[6]);
	}
	
	function onLoad()
	{
		var MainObj:Object = XMLparser.convertToObj(this.firstChild.childNodes);
		callBack(MainObj);
	}
	
	function startLoadingXML($url:String)
	{
		this.load($url);
	}
	
}