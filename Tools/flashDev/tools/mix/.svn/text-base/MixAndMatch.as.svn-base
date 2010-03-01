// Created by Mark Parson on 2007-08-14.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
//  
//
// -------- Description -------- //
// 
//
// -------- Sample Code -------- //
//



// Possibly TEMP
import lib.loadManager.XmlLoader;
import lib.loadManager.ImageLoader;
import lib.loadManager.LoadProgressDisp;
import tools.mix.main.MainArea;
import lib.scene7.SceneSevenImage;

// Vars set in parent
// baseMc:MovieClip;


class tools.mix.MixAndMatch extends tools.BaseTool
{
	private var xmlObj		:Object;
	private var main		:MainArea;
		
	public function MixAndMatch( $baseMc:MovieClip, 
								 $xmlPath:String )
	{
		
		super( $baseMc );
		initXml( $xmlPath );
		
		// Todo: SCENE 7 IMAGES- Should probably load this in via xml
		SceneSevenImage.setScene7Path( 'http://s7d1.scene7.com/is/image/TommyBahama/' );
		SceneSevenImage.setDefaultStyle( 'cat' );
		
		//TEMP_imageLoad();
		//TEMP_newProduct();
	}
	
	// ---------- Xml Loading ---------- //
	private function initXml ( $xmlPath:String ):Void
	{
		var mainXml:XmlLoader = new XmlLoader();
		mainXml.setCallBack(this, "xmlLoadedCallback");
		mainXml.startLoadingXML( $xmlPath );
	}
	
	private function xmlLoadedCallback ( $xmlObj:Object ):Void
	{
		xmlObj = $xmlObj;
		main = new MainArea( baseMc, $xmlObj );
	}
	
	
	
	
	
	
	// ---------- Temp Functions - probably usable though.. ---------- //
	private function TEMP_newProduct (  ):Void
	{
		//var prod = new lib.product.Item();
	}
	
	private function TEMP_imageLoad (  ):Void
	{
		var mc = baseMc.createEmptyMovieClip('holderThingy', 10);
		var mc2 = baseMc.createEmptyMovieClip('holderThingy', 11);
		
		var progressBar:LoadProgressDisp = new LoadProgressDisp( mc2 );				/* or set globalHolderMc instead of passing mc */
		progressBar.setPosition(10, 30);
		
		var ldr = new ImageLoader( 'flash_loads/images/pic.jpg', mc);			
		//ldr.setCallBacks( callBackObject, 'callBackFunction', [call,back,args] );  	/* optional */
		ldr.setProgressObj( progressBar );
		ldr.addItemToLoadQueue(); 	
	}
	

}