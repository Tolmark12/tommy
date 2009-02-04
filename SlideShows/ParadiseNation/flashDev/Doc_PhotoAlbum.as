import main.MainArea;
import lib.loadManager.XmlLoader;

class Doc_PhotoAlbum
{
	private var photosMc   	 :MovieClip;
	private var buttonsMc  	 :MovieClip;
	private var paths	   	 :Object;
	private var captionTxt 	 :TextField;
	private var positionTxt	 :TextField;
	
	public function Doc_PhotoAlbum ( $pathsObj	 :Object,
									 $photosMc	 :MovieClip,
									 $buttonsMc	 :MovieClip,
									 $captionTxt :TextField,
									 $positionTxt:TextField )
	{
		photosMc 	= $photosMc;
		buttonsMc	= $buttonsMc;
		paths		= $pathsObj;
		captionTxt	= $captionTxt;
		positionTxt = $positionTxt;
		
		var mainXml:XmlLoader = new XmlLoader();
		mainXml.setCallBack(this, "xmlIsLoaded");
		mainXml.startLoadingXML( paths.xmlFile );
		
	}
	
	public function xmlIsLoaded ( $xmlObj:Object ):Void
	{
		var mainArea:MainArea = new MainArea( $xmlObj, photosMc, buttonsMc, captionTxt, positionTxt, paths.imagePath );
	}
}