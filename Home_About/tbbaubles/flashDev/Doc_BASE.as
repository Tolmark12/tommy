import xmlParse.TommyBahamaXML;
import PathFinder;
import ClickHandler;


class Doc_BASE
{
	private var rootMc:MovieClip;
	
	public function Doc_BASE( $rootMc:MovieClip )
	{
		rootMc = $rootMc;
		ClickHandler.setDocumentCon( this );
	}
	
	public function commence():Void
	{
		var tmXml = new TommyBahamaXML();
		tmXml.setCallBack( this, 'xmlLoaded' );
		tmXml.startLoadingXML( PathFinder.getXmlPath() );
	}

	public function xmlLoaded ( $xmlObj:Object ):Void
	{
		PathFinder.setGlobals($xmlObj.globals);
	}

}
