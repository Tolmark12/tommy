import lib.product.attribt_interface.drop.DropMenu;


class lib.product.attribute.Quantity extends lib.product.attribute.Basic //implements lib.product.attribute.Attrbt
{
	private var dropDownMenu :DropMenu;
	
	
	// $mc 				- Main holderMovieClip
	// $options			- Comma delimited list of options
	// $selectedIndex	- Index in the $options list of the selected item. (optional
	public function Quantity( $mc:MovieClip, $optionsAr:Array, $defaultSelection:Number, $name:String )
	{
		super( $mc );
				
		dropDownMenu = new DropMenu( mainMc, $optionsAr, $defaultSelection, $name );
		dropDownMenu.addObserverToModel(this);
	}
	
	public function remove (  ):Void
	{
		super.remove();
		dropDownMenu = null;
		this = null;
	}
}

