// Created by Mark Parson on 2007-07-27.
// Copyright (c) Coal Interactive 2007. All rights reserved.

// ------ Description ------- //
// Used to load an image into a movie clip immediately,  
// or it can be added to the end of the load queue

// ------ Sample Code ------- //
// import loadManager.ImageLoader
//
// var ldr = new ImageLoader( 'flash_loads/images/pic.jpg', targetMc );			
// ldr.setCallBacks( callBackObject, 'callBackFunction', [call,back,args] );  	/* optional */
//
// - Add item to load queue -  
// ldr.addItemToLoadQueue(); 
// - or to load immediately: - 
// ldr.loadItem();

import lib.loadManager.ImageLoadListener

class lib.loadManager.ImageLoader  
{
	private static var imageQueue		:Array;
	private static var currentlyLoading	:Boolean;	
	private var 	   loadPath			:String;
	private var 	   holderMc			:MovieClip;
	
	// Listener
	private var listener:ImageLoadListener;
	                   
	// Callbacks       
	public var 		   cbObj			:Object;
	public var 		   cbFunc			:String
	public var 		   cbAr				:Array;
	
	// Constructor
	public function ImageLoader( $loadPath:String, $loadTarget:MovieClip )
	{
		loadPath = $loadPath;
		holderMc = $loadTarget;
		imageQueue = ( imageQueue == undefined )? new Array() : imageQueue ;
		listener = new ImageLoadListener();
		listener.setCallBack(this, 'loadedCallback' );	
	}
	
	// Adding to the global Queue
	public function addItemToLoadQueue ( ):Void
	{
		imageQueue.push( this );
		loadNextItem();
	}
	
	// Loading the item
	public function loadItem (  ):Void
	{	
		var movieClipLoader:MovieClipLoader = new MovieClipLoader();
		movieClipLoader.addListener(listener);
		movieClipLoader.loadClip( loadPath, holderMc );
	}
	
	// Item loaded callback
	public function loadedCallback (  ):Void
	{
		cbObj[cbFunc](cbAr[0],cbAr[1],cbAr[2],cbAr[3],cbAr[4],cbAr[5],cbAr[6],cbAr[7],cbAr[8]);
		currentlyLoading = false;
		loadNextItem();
	}
	
	// Called by: "loadManager.ImageLoader 		 -> addItemToLoadQueue"
	// And by:	  "loadManager.ImageLoadListener -> onLoadError"
	public static function loadNextItem()
	{
		if( !currentlyLoading && imageQueue.length != 0 )
		{
			var newLoader = imageQueue.pop();
			
			// In case holder mc has been removed or deleted
			if( newLoader.getHolderMc() != undefined )
			{
				currentlyLoading = true;
				newLoader.loadItem();
			}else{
				loadNextItem();
			}
		}
		
	}
	
	// Getters and Setters
	public function getHolderMc (  ):Object { return holderMc; };
	public function setCallBacks ( $cbObj:Object, $cbFunc:String, $cbAr:Array ):Void
	{ 
		cbObj = $cbObj;
		cbFunc = $cbFunc;
		cbAr = $cbAr;
 	}

	public function setProgressObj ( $listener:Object ):Void
	{
		listener.registerProgressObj($listener);
	}
	
}