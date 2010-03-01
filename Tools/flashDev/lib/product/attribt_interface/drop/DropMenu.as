import mvc.MvcWrapper;
import lib.product.attribt_interface.drop.*;


class DropMenu extends MvcWrapper
{
	private var dmModel		:DM_Model;
	private var dmDisplay	:DM_Display;
	private var dmControl	:DM_Control;
	
	public function DropMenu( $holderMc:MovieClip, $options:Array, $selectedIndex:Number, $name:String )
	{
		dmModel 	= new DM_Model( $name );
		dmControl	= new DM_Control( dmModel );
		dmDisplay	= new DM_Display( dmModel, dmControl, /**/ $holderMc );
		
		dmModel.addObserver( dmDisplay );
		super.setModel( dmModel );
		
		// Start the ball rolling
		( $selectedIndex == undefined )? $selectedIndex = 0 : '' ;
		dmModel.setButtonsAr( $options, $selectedIndex );
	}
}