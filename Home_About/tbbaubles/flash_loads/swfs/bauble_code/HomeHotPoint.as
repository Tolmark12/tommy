class bauble_code.HomeHotPoint
{
	// Items on the stage
	private var _root:MovieClip;
	private var _mainTxt:MovieClip;
	private var _subTxt:MovieClip;
	private var _box:MovieClip;

	public function HomeHotPoint( $xml:Object, $root:MovieClip )
	{
		_root    = $root;
		_mainTxt = _root.mainTxt;
		_subTxt  = _root.subTxt;
		_box     = _root.box
		
		_make( $xml );
	}
	
	/** 
	*	Make the hot point
	*	@param		an "xml" object defined in the content xml
	*/
	private function _make ( $xml:Object ):Void
	{
		var hex:String;
		var defaultColor 	= "FFFFFF";
		var tntBox:Color 	= new Color( _box );
		var tntTitle:Color 	= new Color( _mainTxt );
		var tntSub:Color	= new Color( _subTxt );
		
		// Set the colors if they exist
		hex = ($xml.box.color == undefined)? defaultColor : $xml.box.color ;
		tntBox.setRGB( Number( '0x' + hex ) );
		hex = ($xml.titleTxt.color == undefined)? defaultColor : $xml.titleTxt.color ;
		tntTitle.setRGB( Number( '0x' + hex  ));
		hex = ($xml.subTxt.color == undefined)? defaultColor : $xml.subTxt.color ;
		tntSub.setRGB( Number( '0x' + hex ) );
		
		// Set the text
		_mainTxt.titleTxt.text = $xml.titleTxt.text;
		_subTxt.titleTxt.text  = $xml.subTxt.text;

	}
	
}