// Created by Mark Parson on 2007-08-23.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
// 
// 
// -------- Description -------- //
// This is a shape drawing class
// 
// -------- Sample Code -------- //
//


class lib.shape.Square
{
	public function Square( $x:Number,
	                        $y:Number,
	                        $w:Number,
	                        $h:Number,
						    $mc:MovieClip,
							$hex:Number,
	                        $irregular:Boolean,
	 						$alpha:Number )
	
	{
		var cornerAr:Array 		 = new Array( 'tl', 'tr', 'br', 'bl', 'tl' );
		var xDirectionAr:Array   = new Array( 0,   1, 0.2, 1, 0 );
		var yDirectionAr:Array   = new Array( 0, 0.2,   1, 1, 0 );
		
		var tempObj  = new Object();
		tempObj.tl = [$x		, 	   $y];
		tempObj.tr = [$x  +$w	, 	   $y];
		tempObj.br = [$x + $w	, $y + $h];
		tempObj.bl = [$x		, $y + $h];
		
		var xPos:Number;
		var yPos:Number;
		
		$mc.clear();
		$mc.beginFill($hex, $alpha );
		
		if( $irregular )
		{
			for ( var i:Number=0; i<5; i++ ) 
			{
				xPos = tempObj[ cornerAr[i] ][0];
				yPos = tempObj[ cornerAr[i] ][1];
				
				$mc.lineTo( xPos, yPos );
				
				for(var j:Number=0; j<3; j++)
				{
					$mc.lineTo( xPos += random(3) * xDirectionAr[i], yPos += random(3) * yDirectionAr[i] );
				}
			}
		}
		else
		{
			for ( var i:Number=0; i<4; i++ ) 
			{
				$mc.lineTo( tempObj[cornerAr[i]][0], tempObj[cornerAr[i]][1] );
			}			
		}
		
		$mc.endFill();
	}
}