// Created by Mark Parson on 2007-08-01.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
//  
//
// -------- Description -------- //
// I imagine that this class would be extended by
// specific loaders such as progressbar, spinning progress, etc..
//
// -------- Sample Code -------- //
// import loadManager.LoadProgressDisp;
// import loadManager.ImageLoader
//
// var progressBar:LoadProgressDisp = new LoadProgressDisp( mc );				/* or set static "globalHolderMc" instead of passing mc */
// progressBar.setPosition(10, 30);												/* optional */
// 
// var ldr = new ImageLoader( 'flash_loads/images/pic.jpg', mc2 );			
// ldr.setProgressObj( progressBar );
// ldr.addItemToLoadQueue();
// - For further Image Loader methods, see "ImageLoader.as"

class lib.loadManager.LoadProgressDisp
{
	private static var globalHolderMc:MovieClip
	private var 	   holderMc:MovieClip;
	
	public function LoadProgressDisp( $mc:MovieClip )
	{
		var holderMc = ( globalHolderMc != undefined )? globalHolderMc : $mc ;
	}
	
	
// ---------- Loading Events ------------------------------//	
	public function onLoadInit()
	{
		// remove display
	}
	
	public function onLoadError()
	{
		// remove display?
	}
	
	public function onLoadProgress( $perc:Number )
	{
	 	trace('Percentage loaded: ' + $perc * 100);
	}
	
	public function onLoadStart()
	{
		// Show display
	}
	
	
// ---------- Functions for hiding and showing ------------//
	public function show (  ):Void
	{
		// show the loader
	}
	
	public function hide (  ):Void
	{
		// hide the loader
	}
	
	public function remove (  ):Void
	{
		// remove the loader from the stage
	}
	
	public function setPosition ( $x:Number, $y:Number ):Void
	{
		
	}
// ---------- getters and setters--------------------------//
	public static function  setGlobalHolderMc( $mc:MovieClip ):Void{ globalHolderMc = $mc; };
	public function getHolderMc (  ):MovieClip{ return holderMc; };
	
}