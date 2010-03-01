// Created by Mark Parson on 2007-08-14.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// ________ Required classes ________ //
// tools.mix.MixAndMatch;
// tools.outfit.Outfitter;
//  
// ________ Description ________ //
// Essentially, this initializes the correct class, and sends it
// the xml path, and the base movieclip. 
//
// These vars must be set in the .fla:
// - tool 		Name of the class to be loaded, see getToolClass() 
// - xmlPath	Location of the xml to be loaded.


import tools.mix.MixAndMatch;
import tools.outfit.Outfitter;


class Doc_single_tool extends Doc_BASE
{	
	private var tool	:Object;
	
	public function Doc_single_tool( $baseMc:MovieClip )
	{
		super( $baseMc );
		
		// Find which tool this should be
		var toolClass:Function = getToolClass( $baseMc.tool );
		tool = new toolClass( $baseMc, $baseMc.xmlPath );
	}   
	
	private function getToolClass ( $className:String ):Function
	{
		switch ($className )
		{
			case "mixAndMatch":
			return MixAndMatch;
			break
			
			case "outfitter":
			return Outfitter;
			break
		}
	}
	
	
}