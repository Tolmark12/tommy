// Created by Mark Parson on 2007-07-30.
// Copyright (c) Coal Interactive 2007. All rights reserved.

// -------- Required classes -------- //
//  "loadManager" package
//
// -------- Description -------- //
//  For making scene 7 image calls in flash
//
// -------- Sample Scene 7 HTTP Call -------- //
// Using Syle: 		 http://s7d1.scene7.com/is/image/TommyBahama/T31700_954_main?$cat$
// Using Attributes: http://s7d1.scene7.com/is/image/TommyBahama/T31732_646_main?layer=comp&wid=500&hei=500&fmt=jpeg&qlt=100,0&op_sharpen=0&resMode=sharp&op_usm=4.0,0.25,10,0&iccEmbed=0&layer=0&effect=-1&op_blur=35&.effect=Drop%20Shadow&opac=20&blendmode=mult&pos=5,50&bgc=255,255,255
//
// -------- Sample Code -------- //
// import scene7.SceneSevenImage
// 
// SceneSevenImage.setScene7Path( 'http://www.web.com/path/to/Images/' );		/* optional, can pass full path in constructor. need only set once per compile */
// SceneSevenImage.setDefaultStyle( 'mystyle' );								/* optional, need only set once per compile */
//
// img = new SceneSevenImage( holderMovieClip, 'imagename' );
// img.setImageStyle( 'mystyle' );
// img.setCallBacks( callBackObject, 'callBackFunction', [call,back,args] );  	/* optional */
// img.loadImage( /*To load immediately, pass: true. Else, added to end of load queue */ );

import lib.loadManager.ImageLoader;

class lib.scene7.SceneSevenImage
{
	private static var scene7path	:String;
	private static var defualtStyle :String;
	private var imageStyle			:String;
	private var imageName			:String;
	private var holderMc			:MovieClip;
	private var useLongAttributes	:Boolean;			// Haven't added support for this yet, if we do, we should create vars for each attribute, and loop through them at call
	
	// Callbacks
	public var 			 cbObj:Object;
	public var 			 cbFunc:String
	public var 			 cbAr:Array;
	
	
	public function SceneSevenImage( $mc:MovieClip, $image:String )
	{
		holderMc = $mc;
		imageName = $image;
		useLongAttributes = false;
	}
	
	public function loadImage ( $loadImmediately:Boolean ):Void
	{
		var loadStr:String;
		var style:String = (imageStyle == undefined)? defualtStyle : imageStyle ;
		var path:String  = (scene7path == undefined)? '' : scene7path ;
		if( !useLongAttributes )
		{
			loadStr = path + imageName + '?$' + style + '$';
		}
		else
		{
			// if wanted, add support for long calls here.
		}

		// Create Image loader object
		var ldr:ImageLoader = new ImageLoader(loadStr, holderMc);
		// Set callbacks if they exist
		ldr.setCallBacks( cbObj,cbFunc,cbAr );
		// Either load immediately, or add to queue
		( $loadImmediately )? ldr.loadItem() : ldr.addItemToLoadQueue() ;  
	}
	
	//-------- Getters and Setters ----------//
	public static function setScene7Path 	  ( $str:String )	:Void { scene7path   = $str; };
	public static function setDefaultStyle 	  ( $str:String )	:Void { defualtStyle = $str; };
	public function setImageStyle 	  		  ( $str:String )	:Void { imageStyle   = $str; }; // 		//T31700_954_main?$cat$
	public function setUseAttributes 		  ( $bool:Boolean ) :Void { useLongAttributes = $bool };
	public function setCallBacks			  ( $cbObj:Object, $cbFunc:String, $cbAr:Array ):Void
	{ 
		cbObj = $cbObj;
		cbFunc = $cbFunc;
		cbAr = $cbAr;
 	}
}