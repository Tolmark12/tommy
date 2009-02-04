import mvc.MvcWrapper;
import main.*;


class MainArea extends MvcWrapper
{
	private var model	:Mn_Model;
	private var view	:Mn_View;
	private var control :Mn_Control;
	private var buttons	:Mn_Buttons;
	private var btnCon	:Mn_Btns_Control;
	private var caption :Mn_Caption;
	
	public function MainArea( $xml:Object, 
							  $photoMc:MovieClip,
							  $buttonsMc:MovieClip,
							  $captionTxt:TextField,
							  $positionTxt:TextField,
							  $imagePath:String )
	{
		model	= new Mn_Model();
		control	= new Mn_Control ( model );
		view  	= new Mn_View 	 ( model, control,   $photoMc, $xml, $imagePath );
		
		btnCon  = new Mn_Btns_Control( model )
		buttons = new Mn_Buttons ( model, btnCon,    $buttonsMc );
		
		caption = new Mn_Caption ( model, null, $captionTxt, $positionTxt );
		
		model.addObserver( view );
		model.addObserver( buttons );
		model.addObserver( caption );
		
		model.setDefaultTextCaption ( $xml.globals.defaultText );
		model.startSlideShow();
	}
}