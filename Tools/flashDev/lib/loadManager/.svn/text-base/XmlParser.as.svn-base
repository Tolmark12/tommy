// Created by Mark Parson on 2007-08-01.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
//  
//
// -------- Description -------- //
// Not the best parser, I much prefer the one built into 
// Actionscript 3.0, but it works.. 
//
// -------- Sample Code -------- //


class lib.loadManager.XmlParser
{

public static function convertToObj($kids:Object) {
	var obj:Object = {};
	var count:Number = 0;
	for (var i:String in $kids) 
	{	
		// SPECIAL "variable" TAG
		if($kids[i].nodeName == 'v')
		{
			
			// To add html text to a "v" node, add: type="html"
			if($kids[i].attributes.type == "html")
			{
				var nam:String = checkForTitle($kids[i], 'V' + count++);
				
				// Init Temp vars
				var AR:Array = new Array();
				var str:String = ''
				
				// Pull out html nodes
				for (var j:String in $kids[i].childNodes) 
				{
					AR.unshift( String($kids[i].childNodes[j]) );
				}
				
				// AR.reverse();
				var len = AR.length;
				for(var j:Number=0;j<len;j++)
				{
					str += AR[j];
				}
				obj[nam] = str;		
			}
			else
			{
				var nam:String = checkForTitle($kids[i], 'V' + count++);
				obj[nam] = $kids[i].firstChild.nodeValue;
			}
		}

		else if($kids[i].nodeName <> undefined)
		{
			var nam:String = checkForTitle($kids[i], i);
			obj[nam] = {};
			obj[nam] = XmlParser.convertToObj($kids[i].childNodes);
			for (var j:String in $kids[i].attributes) {
				obj[nam][j] = $kids[i].attributes[j];
			}
		}
		
	}
	return obj;
}

private static function checkForTitle($node, $count)
{
	var x:String = ($node.attributes.id <> undefined)? $node.attributes.id : $node.nodeName;
	delete $node.attributes.id;
	return x;
}

}
