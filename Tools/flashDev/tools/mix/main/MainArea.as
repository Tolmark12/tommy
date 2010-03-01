import tools.mix.main.*;
import mvc.MvcWrapper;


class MainArea extends MvcWrapper
{
	private var mainModel:MainModel;
	private var mainDisplay:MainDisplay;
	
	public function MainArea( $mc:MovieClip, $xmlObj:Object )
	{
		// Model
		mainModel = 	 	new MainModel();
		// Views
		mainDisplay =	 	new MainDisplay( mainModel, undefined, /**/ $mc, $xmlObj );
		
		// Binding Model to Views
		mainModel.addObserver( mainDisplay );
	}

}