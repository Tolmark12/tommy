class bauble_code.Thumbnail
{
	// Items on the stage
	private var _root:MovieClip;
	private var _imageDir:String;

	public function Thumbnail( $xml:Object, $root:MovieClip, $imageDirectory:String )
	{
		_imageDir 	= $imageDirectory;
		_root    	= $root;
		_make( $xml );
	}
	
	/** 
	*	Make the hot point
	*	@param		an "xml" object defined in the content xml
	*/
	private function _make ( $xml:Object ):Void
	{
		var movieClipLoader:MovieClipLoader = new MovieClipLoader();
		movieClipLoader.loadClip( _imageDir + $xml.info.image, _root.holder );
	}
	
}