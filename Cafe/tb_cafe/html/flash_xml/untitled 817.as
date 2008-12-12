
package site.model
{
import org.puremvc.as3.multicore.interfaces.IProxy;
import org.puremvc.as3.multicore.patterns.proxy.Proxy;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import site.model.vo.ProjectStub_VO;
import delorum.loading.DataLoader;
import flash.events.*;
import site.SiteFacade;
import site.model.vo.*;
import delorum.echo.EchoMachine;
import delorum.slides.SlideShow_VO;

/** 
*	This is a singleton class
*/

public class PortfolioProxy extends Proxy implements IProxy
{
	public static const NAME:String = "portfolio_proxy";
	private static var  _instance:PortfolioProxy;
	
	private var _portfolioAr:Array;
	private var _xmlLoaded:Boolean = false;
	private var _portfolioPagesDir:String;
	private var _xml:XML;
	
	private static var _defaultProject:String;
	private static var _semiActiveStubIndex:int;
	private static var _fullyActiveStubIndex:int;
	
	public function PortfolioProxy( ):void
	{
		super( NAME );
	}
		
	public static function getInstance() : PortfolioProxy 
	{
		_defaultProject 		= null;
		_semiActiveStubIndex 	= -1;
		_fullyActiveStubIndex 	= -1;
		
		if ( _instance == null ) 
			 _instance = new PortfolioProxy( );
		return _instance;
	}
	
	// ______________________________________________________________  Whole Portfolio
	
	public function loadPortfolioXml ( $xmlPath:String ):void
	{
		// If the xml has not yet been loaded...
		if( !_xmlLoaded ) {
			//...load xml
			var ldr:DataLoader 	= new DataLoader( $xmlPath );
			ldr.onComplete		= _handlePortfolioXmlLoaded;
			ldr.loadItem();
		// else...
		} else {
			// ...reset state
			_semiActiveStubIndex = -1;
			sendInitNotification();
		}
	}
	
	private function _handlePortfolioXmlLoaded ( e:Event ):void
	{
		_xml = XML(e.target.data);
		sendNotification( SiteFacade.LOAD_CSS, String( _xml.projects.@cssFile ) );
		//_parsePortfolioXml( xml );
	}
	
	public function parsePortfolioXml (  ):void
	{
		var $xml:XML = _xml
		_portfolioPagesDir = $xml.projects.@portfolioImagesDir;
		_portfolioAr = new Array();
		for each( var stubNode:XML in $xml.projects.projectStub )
		{
			var vo:ProjectStub_VO 	= new ProjectStub_VO();
			vo.xmlPath		   		= $xml.projects.@xmlDir + stubNode.@xml;
			vo.image		   		= $xml.projects.@imageStubDir + stubNode.@image;
			vo.title		   		= stubNode.@title;
			vo.shortDescription		= stubNode.shortDescription.elements("*").toXMLString();
			vo.arrayIndex			= _portfolioAr.length;
			vo.cssStyleList			= ( String( stubNode.@css ).length == 0 )? [ $xml.projects.@defaultCss ]: stubNode.@css.split(",") ;
			vo.row					= ( rowAr.length == 0 )? null : rowAr[0];
			vo.frameX				= stubNode.@frameX;
			vo.frameY				= stubNode.@frameY;
			
			// Css styling - create a list of css objects
			var tempCssList:Array = new Array();
			var len:uint = vo.cssStyleList.length;
			for ( var i:uint=0; i<len; i++ ) 
			{
				var tempStyleSheet:StyleSheet = new StyleSheet;
				var cssData:Css_VO = CssProxy.getCss( vo.cssStyleList[i] );
				tempCssList.push( cssData.getStyle("row") );
			}
			
			var rowAr:Array 		= _parseRows( stubNode.row, tempCssList );

			// create slideshow if it exists
			var slideShowVo			= new SlideShow_VO();
			slideShowVo.parseXml( stubNode.slideShow, $xml.projects.@portfolioImagesDir );
			vo.slideShow			= ( slideShowVo.slides.length != 0 )? slideShowVo : null ;
			_portfolioAr.push( vo );
		}
		sendInitNotification()
	}
	
	public function sendInitNotification (  ):void
	{
		sendNotification( SiteFacade.INIT_PORTFOLIO, _portfolioAr );
		makeStubSemiActiveByName( _defaultProject );
	}
	
	// ______________________________________________________________ Project Stub
	
	public function makeStubSemiActive ( $stubArIndex:uint ):void
	{
		// If stub is not already active, activate it
		if( $stubArIndex != _semiActiveStubIndex ) 
		{
			_fullyActiveStubIndex   = -1;
			_semiActiveStubIndex    = $stubArIndex;
			var stub:ProjectStub_VO = _portfolioAr[ _semiActiveStubIndex ];
			sendNotification( SiteFacade.SHOW_STUB_OVERVIEW, _semiActiveStubIndex );
		}
	}
	
	public function deactivateActiveStub (  ):void
	{
		sendNotification( SiteFacade.DEACTIVATE_PROJECT, _semiActiveStubIndex );
		_semiActiveStubIndex = _fullyActiveStubIndex = -1;
	}
	
	public function makeStubSemiActiveByName ( $name:String ):void
	{
		var len:uint = _portfolioAr.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var vo:ProjectStub_VO = _portfolioAr[i] as ProjectStub_VO;
			if( _replaceSpaces(vo.title, /\s/g) == $name )
				makeStubSemiActive( vo.arrayIndex );
		}
	}
	
	public function loadProjectXml ( $projectIndex:uint ):void
	{
		// if project is not currently active...
		if( _fullyActiveStubIndex != $projectIndex ){
			_fullyActiveStubIndex = $projectIndex;
			sendNotification( SiteFacade.PROJECT_XML_LOADING );
			var project:ProjectStub_VO = _portfolioAr[ $projectIndex ];
			var ldr:DataLoader 	= new DataLoader( project.xmlPath );
			ldr.onComplete		= _parseProjectXml;
			ldr.loadItem();
		}
	}
	
	// Return current project to it's semi active state
	public function hideCaseStudy (  ):void
	{
		if( _fullyActiveStubIndex != -1 ) {
			_fullyActiveStubIndex = -1;
			sendNotification( SiteFacade.HIDE_CASE_STUDY );
		}
	}
	
	private function _parseProjectXml ( e:Event ):void
	{
		
		var xml:XML 		= XML(e.target.data);
		var page:Page_VO	= new Page_VO();
		page.setImagesDir(_portfolioPagesDir, xml.page.@imageDir);
		page.rowsAr = _parseRows(xml.page.row);
		sendNotification( SiteFacade.PROJECT_XML_LOADED, page );
	}
	
	// ______________________________________________________________ Private Helpers
	
	private function _getAttributeFromCss ( $cssStyles:Array, $styleName:String, $defaultValue:* ):*
	{
		var len:uint = $cssStyles.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			//trace( $cssStyles[i][$styleName] );
			//if( $cssStyles[i][$styleName] != null ) 
				//$defaultValue = $cssStyles[i][$styleName];
		}
		
		return $defaultValue;
	}
	
	private function _parseRows ( $rowXml:XMLList, $tempCssList:Array = [] ):Array
	{
		var rowAr:Array = new Array()
		for each( var node:XML in $rowXml)
		{
			var row_vo:Row_VO		= new Row_VO();
			row_vo.columnAr 		= new Array();
			row_vo.title 			= ( String(node.@title).length == 0 )? null 	   : node.@title;
			row_vo.cssStyleList		= ( String(node.@css).length   == 0 )? ["default"] : node.@css.split(",") ;
			row_vo.bgColor			= ( String(node.@bgColor).length == 0)? null 	   : "0x" + node.@bgColor ;
			row_vo.bgAlphaMode      = ( String(node.@bgWidth).length == 0)? null 	   : node.@bgAlphaMode;
			row_vo.bgAlpha          = ( String(node.@bgWidth).length == 0)? 1    	   : Number(node.@bgAlpha);
			row_vo.bgWidth			= ( String(node.@bgWidth).length == 0)? -1   	   : Number(node.@bgWidth);
			row_vo.bgHeight			= ( String(node.@bgHeight).length == 0)? -1   	   : Number(node.@bgHeight);
			row_vo.slideShowId		= ( String(node.@slideShowId).length == 0)? null   : String(node.@slideShowId);
			
			
			vo.bgColor				= ( String( stubNode.@bgColor ).length == 0 )? 		 _getAttributeFromCss( tempCssList, "bgColor", 0xFFFFFF ) 	: uint("0x" + stubNode.@bgColor) ;
			vo.columnPadding        = ( String( stubNode.@columnPadding ).length == 0 )? _getAttributeFromCss( tempCssList, "columnPadding", "0" ) 	: stubNode.@columnPadding ;
			vo.padding              = ( String( stubNode.@padding ).length == 0 )? 		 _getAttributeFromCss( tempCssList, "padding", "0" ) 		: stubNode.@padding ;
			vo.totalColumns         = ( String( stubNode.@totalColumns ).length == 0 )?  _getAttributeFromCss( tempCssList, "totalColumns", "0" ) 	: stubNode.@totalColumns ;
			vo.marginTop            = ( String( stubNode.@marginTop ).length == 0 )? 	 _getAttributeFromCss( tempCssList, "marginTop", "0" ) 		: stubNode.@marginTop ;
			vo.marginBottom         = ( String( stubNode.@marginBottom ).length == 0 )?  _getAttributeFromCss( tempCssList, "marginBottom", "0" ) 	: stubNode.@marginBottom ;
			
			for each( var col:XML in node.col)
			{
				var col_vo:Col_VO 	= new Col_VO();
				col_vo.colSpan 		= uint( col.@span );
				col_vo.align		= ( String( col.@align ).length == 0)? null : col.@align ;
				col_vo.float		= ( String( col.@float ).length == 0)? null : col.@float ;
				col_vo.content	 	= col;
				row_vo.columnAr.push( col_vo );
			}
			rowAr.push( row_vo );
		}
		return rowAr;
	}
	private function _replaceSpaces ( $str:String, $searchPattern:RegExp, $replacement:String="_" ):String
	{
	 	return $str.replace( $searchPattern, $replacement)
	}
	
	// ______________________________________________________________ Getters / Setters
	
	public function get semiActiveStubIndex (  ):uint   { return _semiActiveStubIndex; };
	public function get currentProjectUrl   (  ):String { 
		var stub:ProjectStub_VO = _portfolioAr[_semiActiveStubIndex] as ProjectStub_VO;
		return _replaceSpaces( stub.title, /\s/g );  
	}
	
	public function set defaultProject ( $str:String ):void	{ _defaultProject = $str; };
	

}
}