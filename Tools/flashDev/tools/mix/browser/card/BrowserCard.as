import lib.scene7.SceneSevenImage;
import tools.mix.browser.Br_Control;
import mx.utils.Delegate;
import lib.shape.Square;
import flash.filters.DropShadowFilter;
import caurina.transitions.Tweener;


class tools.mix.browser.card.BrowserCard 
{
	public static var PILE_LEFT		:String = "leftpile"
	public static var PILE_RIGHT	:String = "rightpile"
	public static var PILE_MIDDLE	:String = "middlepile"
	
	private var mainMc			:MovieClip;
	private var imageHolderMc	:MovieClip;
	private var bgHolderMc		:MovieClip;
	private var shadowMc		:MovieClip;
	private var rotationBox		:MovieClip;
	private var productId		:String;
	private var imageName		:String;
	private var releaseCon		:Br_Control;
	private var isTwisted		:Boolean;
	private var cardHeight		:Number = 115;
	private var cardWidth		:Number = 114;
	private var state			:String = '';
	private var currentPile		:String;
	
	public function BrowserCard( $mc:MovieClip, 
								 $xmlObj:Object, 
								 $itemId:String,
								 $releaseControl )
	{
		isTwisted		= false;
		releaseCon		= $releaseControl;
		mainMc 			= $mc;
		productId 		= $itemId; //FIXME - Dummy Data
		imageName		= $xmlObj.file;
		make();
	}
	
	public function loadImage ():Void
	{
		// Todo: Clean up the image loading functions
		// Right now, I am saving the product id, which also happens to be
		// The scene7 image id. I should keep these separate 
		
		// Currently setting the scene 7 image path in"MixAndMatch.as"
		
		var img = new SceneSevenImage( imageHolderMc, imageName );
		img.setImageStyle( 'suggest' );
		img.loadImage( true );
	}
	
	// _______________________________________________________________________ Make
	public function make (  ):Void
	{
		rotationBox		 = mainMc.createEmptyMovieClip( 'rotationBox', 1 )
		imageHolderMc 	 = rotationBox.createEmptyMovieClip( 'imageHolder', 3 );
		bgHolderMc		 = rotationBox.createEmptyMovieClip( 'bgHolder', 2 );
		shadowMc		 = rotationBox.createEmptyMovieClip( 'shadowMc', 1)	
		bgHolderMc._x = imageHolderMc._x = shadowMc._x = - cardWidth/2;
		bgHolderMc._y = imageHolderMc._y = shadowMc._y =- cardHeight/2;
		rotationBox._x = cardWidth/2;
		rotationBox._y = cardHeight/2;
		imageHolderMc._x += 6;
		imageHolderMc._y += 6;
		
		var sqr:Square  = new Square( 0, 0, cardHeight, cardWidth, bgHolderMc, 0xFFFFFF, false, 100 );
		var sqr2:Square = new Square( -1, -1, cardHeight+2, cardWidth+2, shadowMc, 0x666666, false, 9 );
		//imageHolderMc._x = imageHolderMc._y = 6;
		//bgHolderMc.attachMovie('photoholder_temp', 'bgMc', 1 );
		//var dropShadow:DropShadowFilter = new DropShadowFilter(5, 90, 0x000000, 0.1, 2,5, 2, 7);
		//dropShadow.alpha = 0.05;
		//bgHolderMc.filters = [dropShadow]
		
		
		// Set Event Handlers
		mainMc.onRelease  = Delegate.create( this, Release );
		mainMc.onRollOver = Delegate.create( this, RollOver );
		mainMc.onRollOut = mainMc.onReleaseOutside = Delegate.create( this, RollOut );
	}
	
	
	// _______________________________________________________________________ Event Handlers
	public function Release (  ):Void
	{
		releaseCon['changeActiveProduct'] ( productId );
	}
	public function RollOver (  ):Void
	{
		bgHolderMc._alpha = 70;
	}
	public function RollOut (  ):Void
	{
		bgHolderMc._alpha = 100;
	}
	
	// _______________________________________________________________________ Functionality
	public function moveAndScale ( $x:Number,  $y:Number,
		  						   $xs:Number, $ys:Number,
		 						   $newPile:String ):Boolean
	{
		// If the card is already at the target location and scale
		if( $newPile == currentPile && $xs == mainMc._xscale && $y == mainMc._y && $x == mainMc._x )
		{
			return true;
		}
	   	setPile( $newPile );
		Tweener.addTween( mainMc, {_x:$x, _y:$y, _xscale:$xs, _yscale:$ys, time:0.5, transition:"easeInOutQuint"} );
	}
	
	public function twist (  ):Void
	{
		if( !isTwisted )
		{
			isTwisted = true;
			var max:Number = 3;
			var min:Number = max *- 1;
			var rot:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			Tweener.addTween( mainMc, { _rotation:rot, time:0.5, transition:"easeInOutQuint"} );
		}
	}
	
	public function unTwist (  ):Void
	{
		if( isTwisted )
		{
			isTwisted = false;
			var max:Number = 1;
			var min:Number = max *- 1;
			var rot:Number = Math.floor(Math.random() * (max - min + 1)) + min;			
			Tweener.addTween( mainMc, { _rotation:rot, time:0.5, transition:"easeInOutQuint"} );
		}
	}
	
	public function swapMcDepth ( $dep:Number ):Void
	{
		mainMc.swapDepths( $dep );
	}
	
	public function getMainMc(  ):MovieClip
	{
		return mainMc;
	}
	
	public function hide (  ):Void
	{
		if(state == "visible")
		{
			state = "hidden";
			Tweener.addTween( mainMc, {_alpha:0, time:0.5, transition:"easeInOutQuint", onComplete:makeInvisible} );
		}
	}
	
	public function makeInvisible (  ):Void
	{
		mainMc._visible = false;
	}
	
	public function show (  ):Void
	{
		if(state != "visible")
		{
			state = "visible"
			mainMc._visible = true;
			Tweener.addTween( mainMc, {_alpha:100, time:0.5, transition:"easeInOutQuint"} );
		}
	}
	
	public function unmake (  ):Void
	{
		hide();
		// todo: I don't believe I using this, but in the 
		// future, I'd need to add a call to removeMe if I do
	}
	
	public function removeMe (  ):Void
	{
		mainMc.removeMovieClip();
	}
	
	public function getPile (  ):String
	{
		return currentPile;
	}
	
	public function setPile ( $pile:String ):Void
	{
		currentPile = $pile;
	}
}