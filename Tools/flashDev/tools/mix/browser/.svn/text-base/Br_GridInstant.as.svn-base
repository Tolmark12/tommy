import tools.mix.browser.*;
import util.*;
import mvc.*;
import tools.mix.browser.*;
import flash.filters.DropShadowFilter;
import tools.mix.browser.card.BrowserCard; 
import mx.utils.Delegate;
import tools.mix.browser.*;


class Br_GridInstant extends Br_GridBase // implements Br_GridDisplay
{
	
	//  For placing cards in correct grid position
	var rows						:Number;		// Incraments as cards are laid out
	var cols						:Number;		// Incraments as cards are laid out
	var rightProdIndex				:Number;		// ex: 4 in 1-4
	var leftProdIndex				:Number;		// ex: 1 in 1-4
	var columnIncMod				:Number;		// Modifies whether the columns are increasing or decreasing (either 1 or -1)
	var xInc						:Number;		// The diff between columns
	var yInc						:Number;		// The diff between rows
	var xtra						:Number;		// Will be added to the card position in the piles to give a random effect
	var pileWiggleRoom				:Number = 6;	// The amount of variance for the pile x and y position
	var incramentDir				:Number;		// Indicates the direction of incramenting for depth swappint the middle pile
	
	// For moving the cards
	var tempCardList				:Array ;		// Temporary list of all active cards
	var cardToMoveIndex 			:Number;
	var totalCardsInList			:Number;
	var moveCardsInterval			:Number;
	var oldRange					:Array ;
	var newRange					:Array ;
	
	// Temp
	private static var moveCount	:Number;
	
	
	public function Br_GridInstant( $m:Observable, $c:Controller, 
		 							$mc:MovieClip)
	{
		super($m, $c, $mc);
		incramentDir = 1;
		moveCount = 0;
	}
	
	// _______________________________________________________________________ Model Update
	public function update ( $o:Observable, $infoObj:Object ):Void
	{
		super.update( $o, $infoObj );
		var info:Browser_VO = Browser_VO($infoObj);

		
		if( info.incramentDirection != undefined)
		{
			incramentDir = info.incramentDirection * -1;
		}
				
		// Move the Products in the grid
		if( info.newProductRange != undefined )
		{
			showProductsByRange(info.newProductRange)
		}

	}

	
	// _______________________________________________________________________ Displaying the Products
	// Display the products whose index falls into the argument's range
	// $range: "3-6"
	
	public function showProductsByRange ( $range:String ):Void
	{
		$range = ( $range == null )? "1-4" /* Find the current amount displayed and the current item (to center on) */ : $range ;
		/*
		For Centering on the current Item
		
		var rangeSize = Number( $range[1]) - Number( $range[0] );
		$range = currentIndex + "-" + currentIndex + rangeSize; 
		*/
		
		var ar:Array	 = $range.split('-');
		rightProdIndex  = Number(ar[1]) - 1;	// subtract 1 to zero index the value
		leftProdIndex   = Number(ar[0]) - 1;	// subtract 1 to zero index the value
		
		columnIncMod = 1;
		rows = 0;
		cols = 0;
		xInc = super.getTargetWidth()  + PADDING;
		yInc = super.getTargetHeight() + PADDING;

		tempCardList = super.getMoveQueue();
		totalCardsInList = tempCardList.length;

		// Move all the cards
		cardToMoveIndex = 0;
		var len:Number = tempCardList.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			 moveNextCard ();
		}
        
		oldRange = newRange;
		newRange = ar;

	}

	public function moveNextCard ( )
	{
	//	trace(cardToMoveIndex)
		var i:Number;
		if( cardToMoveIndex <= totalCardsInList-2 )
		{
			i = cardToMoveIndex++
		}else{
			i = cardToMoveIndex++;
			cardToMoveIndex = 0;
		}

		var card:BrowserCard 		= BrowserCard( super.getCardObj()[ tempCardList[i] ] );
		var noNeedToMove:Boolean	= false;
		var xtra:Number				= 0; 
		
		card.show();
		if( i < leftProdIndex )							// In Left Pile
		{	
			if( card.getPile() != card.PILE_LEFT || card.getPile() == null )
			{
				xtra = (Math.floor(Math.random() * (pileWiggleRoom - (-pileWiggleRoom) + 1)) + (-pileWiggleRoom)) * cardScale/100;
			}
			noNeedToMove = card.moveAndScale( leftPileX + xtra, leftPileY + xtra, cardScale, cardScale, card.PILE_LEFT);
			card.swapMcDepth(i);
			card.twist();
		}
		else if(  i <= rightProdIndex )	 				// In the Middle
		{
			card.swapMcDepth( 10000 + ( i * incramentDir) );
			
			var x:Number = leftPileX + xInc * cols;
			var y:Number = yInc * rows; 
			
			noNeedToMove = card.moveAndScale( x, y, cardScale, cardScale, card.PILE_MIDDLE);
			card.unTwist();

			( columnIncMod == 1 )? cols++ : cols-- ;
			if ( cols >= totalCols || cols < 0) 
			{
				columnIncMod *= -1;
				cols += columnIncMod;
				if( rows < maxRows )
				{
					rows++;
				}
				else
				{
					return null;
				} 
			}
		}
		else 									// In Right Pile
		{       
			if( card.getPile() != card.PILE_RIGHT || card.getPile() == null )
			{                  
				xtra = (Math.floor(Math.random() * (pileWiggleRoom - (-pileWiggleRoom) + 1)) + (-pileWiggleRoom)) * cardScale/100;
			}
			noNeedToMove = card.moveAndScale( rightPileX +  xtra, rightPileY + xtra, cardScale, cardScale, card.PILE_RIGHT);
			card.swapMcDepth( 8000 - i );
			card.twist();
		}
	}
	
}