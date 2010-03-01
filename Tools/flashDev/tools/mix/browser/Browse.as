import mvc.MvcWrapper;
import tools.mix.browser.*;

class tools.mix.browser.Browse extends MvcWrapper
{
	private var browserModel	:Br_Model;
	private var browserBtns		:Br_Buttons;
//	private var browserDisplay	:Br_Display;
	private var browserGrid		:Br_GridInstant;
	private var gridControl		:Br_Control;
	
	public function Browse( $holderMc:MovieClip, $xmlObj:Object )
	{
		// Model
		browserModel =	new Br_Model();
		
		// Control
		gridControl	=	new Br_Control( browserModel );
		
		var buttonsMc:MovieClip = $holderMc.createEmptyMovieClip('buttonsMc', 3);
		var browserMc:MovieClip = $holderMc.createEmptyMovieClip('browserMc', 2);
		
		// Views
		browserBtns =	new Br_Buttons( browserModel, undefined, 
										buttonsMc );
		
		browserGrid =	new Br_GridInstant( browserModel, gridControl, 
											browserMc );		
		
		// Binding Model to Views
		browserModel.addObserver( browserBtns );
		browserModel.addObserver( browserGrid );
		
		// Load xml data into model
		browserModel.initCategories( $xmlObj );
		super.setModel( browserModel );
	}
	
	// Set the browsers in motion starting the 
	// browsercards at 100% scale
	public function commence (  ):Void
	{
		browserModel.setCardScale ( .01 );
	}
}