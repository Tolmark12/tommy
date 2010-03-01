import util.*;
import mvc.*;
import tools.mix.browser.*;
import flash.filters.DropShadowFilter;
import tools.mix.browser.card.BrowserCard; 
import mx.utils.Delegate;
import tools.mix.browser.*;


class Br_GridBase extends AbstractView
{	
	private var holderMc			:MovieClip;				// Holds all MovieClip
	private var categoryObj			:Object;				// Holds "CategoryMc_VO" objects. One for each category
	// should this be here??
	private var cardObj				:Object;				// Reference object holding all the cards

	// Queues of cards ]
	private var moveQueue			:Array;					// Cards visible and to be moved	(active categories)
	private var hideQueue			:Array;					// Cards to be hidden 				(inactive categories)
	
	
	////-- GRID --\\\\
	
	// Constants
	private var PADDING				:Number = 8;
	private var LEFT_WALL			:Number = 10;
	private var RIGHT_WALL			:Number = 490;
	
	// Grid Descriptors
	private var MAX_HEIGHT			:Number = 170;
	private var MIN_COLUMNS			:Number = 4;
	private var MAX_COLUMNS			:Number = 8;
	private var rightPileX			:Number = 370;
	private var leftPileX			:Number = 10;
	private var rightPileY			:Number;
	private var leftPileY			:Number;

	private var totalCols			:Number = 4;
	private var maxRows				:Number;
	private var cardScale			:Number;
	private var targetWidth			:Number;
	private var targetHeight		:Number;



	private function Br_GridBase (  $m:Observable, $c:Controller, 
		 							$mc:MovieClip )
	{
		super($m, $c);
		
		cardObj			= new Object();
		holderMc 	 	= $mc;
		holderMc._y    += 20;
		categoryObj  	= new Object();
		addDropShadowToHolderMc();
		
		// set initial vars?
		LEFT_WALL = leftPileX;
		
	}
	
	// _______________________________________________________________________ Model Update
	public function update ( $o:Observable, $infoObj:Object ):Void
	{		
		var info:Browser_VO = Browser_VO($infoObj);
		var model:Br_Model = Br_Model($o);
		

		
		/*

		Essentially, based on which categories are active, we activate (or deactivate) each card. 
		We then loop through the "moveQueue" array positioning each card according to its status. 
		If it is active, it is added to the nest open grid position. If it is in-active, it is 
		hidden.

		*/
		
		if( info.categories != null ) 
		{
			activateOrDeactivateCategories( info.categories );
			setGridVars()
		}
		
		// Changing the size of the cards
		if( info.cardScale != undefined )
		{
			determineTotalColumnsViaPercentage( info.cardScale );
		}
		
	}
	
	// ** New **
	// _______________________________________________________________________ Activate cards that are active and deactivates thos that are not
	// $categories: full of Category_VO objects
	public function activateOrDeactivateCategories ( $categories:Object ):Void
	{
		var dep:Number 	= holderMc.getNextHighestDepth(); // For attaching the MCs
		moveQueue	 	= new Array();
		hideQueue		= new Array();
		
		for( var i:String in $categories )
		{
			// Datatype the value object
			var category:Category_VO = Category_VO( $categories[i] )
			
			
			// Loop through all items
			for( var j:String in category.items )	
			{
				// name of the card
				var cardName:String = category.name + '_' +  j;
				
				///// Create -or- activate card
				if( category.active == true ) 
				{
					moveQueue.push( cardName );
					
					// >> Card does not exist, so create it
					if( cardObj[ cardName ] == null ) 
					{
						var cardMc:MovieClip = holderMc.createEmptyMovieClip( cardName, dep++ );
					 	var card:BrowserCard = cardObj[ cardName ] = new BrowserCard( cardMc, category.items[j], j, super.getController() );
						card.loadImage();
						//card.show();
					}
					
					// >> Card does exist, activate it
					else
					{
						cardObj[ cardName ].show();
					}
				}
				
				///// Deactivate card 
				else
				{
					var cardName:String = category.name + '_' +  j;
					hideQueue.push( cardName );
					cardObj[ cardName ].hide();
				}
			}
			
			
			
		}
	}
	// ** End New

	public function setGridVars (  ) 
	{
		// This is all based on the total number of columns
		var totalProducts:Number = moveQueue.length;

		// Find the correct scale using a temporary mc
		var tempMc:MovieClip = cardObj[ moveQueue[0] ].getMainMc();
		var snapShotWid:Number = tempMc._width;
		var snapShotTal:Number = tempMc._height;

		// Find the appropriate size for the cards based on the
		// total columns just set by the model's update
		targetWidth  	= tempMc._width = (RIGHT_WALL - LEFT_WALL) / totalCols - PADDING;
		cardScale  		= tempMc._xscale;		// convert width to scale
		tempMc._yscale 	= cardScale;			// set the yscale
		targetHeight 	= tempMc._height;		// convert the scale to height

		// Determine how many rows can be laid with the movie clips at the curent height
		maxRows = Math.round( MAX_HEIGHT / (tempMc._height + PADDING) );

		// Restore the test mc to its previous size
		tempMc._width  = snapShotWid;
		tempMc._height = snapShotTal;        
		
		// Set the "pile's" positions, right and left
		if( maxRows == 2 || maxRows == 4 ) 
		{
			rightPileX = 0;
		}else{
			rightPileX = (targetWidth + PADDING)  * (totalCols - 1);
		}
		
		rightPileY = (targetHeight + PADDING) * (maxRows - 1);
		leftPileX  = 0;
		leftPileY  = 0;
	}

	private function determineTotalColumnsViaPercentage ( $perc ):Void
	{
		var snapShot:Number = totalCols;
		// FIXME!! Remove the /3. I need to determine the real max columns
		totalCols = MIN_COLUMNS + Math.round( (MAX_COLUMNS - MIN_COLUMNS) * $perc );

		//if(snapShot != totalCols)
		//{
			totalCols = (totalCols == 0)? 1 : totalCols ;
			setGridVars (  );
			Br_Control( super.getController() ).newProductRange("1-"+(totalCols*maxRows) );
		//}
	}



	// _______________________________________________________________________ Styling
	private function addDropShadowToHolderMc (  ):Void
	{
		var dropShadow:DropShadowFilter = new DropShadowFilter(5, 90, 0x000000, 0.1, 2,5, 2, 7);
		holderMc.filters = [dropShadow]
	}

	// _______________________________________________________________________ Getters and Setters
	public function getTargetWidth  (  ):Number { return targetWidth;	};
	public function getTargetHeight (  ):Number { return targetHeight;	};
	public function getMoveQueue	(  ):Array	{ return moveQueue;		};
	public function getCardObj		(  ):Object	{ return cardObj;		};
}




