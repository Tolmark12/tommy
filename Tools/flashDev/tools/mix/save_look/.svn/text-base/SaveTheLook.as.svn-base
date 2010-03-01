import mvc.MvcWrapper;
import tools.mix.save_look.*;

class SaveTheLook extends MvcWrapper
{
	private var model	  :SavedLooksModel;
	private var view	  :SavedLooksView;
	private var control   :SavedLooksControl;
	
	public function SaveTheLook( $mc:MovieClip )
	{
		model 	= new SavedLooksModel();
		control = new SavedLooksControl( model );
		view  	= new SavedLooksView( model, control, $mc );

		model.addObserver( view );
	}

}