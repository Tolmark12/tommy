import contentArea.Content2;
import InteractiveContent;
import PathFinder;

class Doc_home_oct08 extends Doc_BASE
{
	private var contentConRight:Content2;
	private var contentConLeft:Content2;
	private var interactiveCon:InteractiveContent;
	private var navMc:MovieClip;
	private var introSound:Sound;
	
	public function Doc_home_oct08( $rootMc:MovieClip )
	{
		super( $rootMc );
		
		//hint.Interface.activateHint(this);
		
		// Init the various movie clips and set their respective depths
		rootMc.baubleHolder.swapDepths(5010);
		rootMc.photoFrameRight.swapDepths(5011);
		rootMc.photoFrameRight._visible = false;
		rootMc.photoFrameLeft.swapDepths(5012);
		
		// Position the left frame's sub elements
		rootMc.photoFrameLeft._visible = false;
		rootMc.photoFrameLeft.paperClip._visible = false;
		rootMc.photoFrameLeft.frameMc.gotoAndStop(2)
		rootMc.photoFrameLeft.maskMc._x 		= -22.1
		rootMc.photoFrameLeft.maskMc._y 		= 9.8;
		rootMc.photoFrameLeft.maskMc._rotation 	= -3.5;
		

		var altBaubleMc:MovieClip = rootMc.createEmptyMovieClip( 'altBaubleMc', 5013 );
		
		// Control for managing the text and the images
		contentConRight = new Content2( rootMc.photoFrameRight, rootMc.textMc, PathFinder.getImagePath() );
		contentConLeft  = new Content2( rootMc.photoFrameLeft, rootMc.textMc, PathFinder.getImagePath() );
		
		ClickHandler.addContentPlace( contentConRight );
		ClickHandler.addContentPlace( contentConLeft  );
		
		// Inits the Side nav and the baubles
		interactiveCon = new InteractiveContent( null, rootMc.baubleHolder, altBaubleMc, this );
	}
	
	public function xmlLoaded ( $xmlObj:Object ):Void
	{
		super.xmlLoaded( $xmlObj );
		interactiveCon.setXmlInfo( $xmlObj, navMc );
		// Load the default images
		contentConRight.loadImages( $xmlObj.globals, false, "imagesRight" );
		contentConLeft.loadImages ( $xmlObj.globals, false, "imagesLeft"  );
		contentConRight.setImageBoxSize( Number($xmlObj.globals.imageBoxWidth  + 20),
			 							 Number($xmlObj.globals.imageBoxHeight + 20) );
		
		contentConLeft.setImageBoxSize( Number($xmlObj.globals.imageBoxWidth  + 20),
								 		Number($xmlObj.globals.imageBoxHeight + 20) );
	}
	
	// Send list of mask mcs to the bauble control
	// Called from the stage
	public function registerBaubleMasks ( $ar:Array ):Void
	{
		interactiveCon.registerBaubleMasks( $ar )
	}
	
	public function getRootMc ():MovieClip { return rootMc; };

}