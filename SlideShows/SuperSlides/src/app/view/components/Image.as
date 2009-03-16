package app.view.components
{

import flash.display.*;
import flash.events.*;
import delorum.loading.ImageLoader;
import delorum.images.Pixasso;
import caurina.transitions.Tweener;
import flash.net.navigateToURL;
import flash.net.URLRequest;
import flash.geom.ColorTransform;


public class Image extends Slot
{
	public static const IMAGE_LOADED:String = "image_loaded";
	public static var transitionSpeed:Number;
	
	private var _imageHolder:Sprite;
	private var _images:Object = new Object();
	private var _currentImageId:String;
	private var _isLoading:Boolean = false;
	private var _ldr:ImageLoader;
	private var _href:String;
	private var _loadingImageId:String;
	
	public function Image():void
	{
		super();
		this.addEventListener( MouseEvent.CLICK, _onClick, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false,0,true );
		this.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false,0,true );
		this.buttonMode = true;
	}
	
	// ______________________________________________________________ Image Loading
	/** 
	*	Load the image
	*/
	public function loadImage ( $image:String, $href:String ):void
	{
		if( _images[$image] == null ) 
		{
			_href = $href;
			
			// Cancel the current load if it's not complete
			if( _isLoading ) {
				_ldr.cancelLoad();
				_ldr.removeEventListener( Event.COMPLETE, _handleImageLoaded );
			}
			
			_loadingImageId = $image;
			_isLoading = true;
			_imageHolder = new Sprite();
			_ldr = new ImageLoader( $image, _imageHolder );
			_ldr.checkCrossDomainXml = true;
			_ldr.addEventListener( Event.COMPLETE, _handleImageLoaded );
			_ldr.loadItem();	
		}else{
			_showNewImage($image);
		}
	}
	
	/** 
	*	Called on image load
	*/
	private function _handleImageLoaded ( e:Event ):void
	{
		_isLoading = false;
		this.dispatchEvent( new Event(IMAGE_LOADED, true) );
		
		// Draw the loaded image
		var myBitmapData:BitmapData = new BitmapData(_imageHolder.width, _imageHolder.height, true, 0x000000 );
		myBitmapData.draw( _imageHolder );
		
		// Apply effects
		var pixasso:Pixasso = new Pixasso( myBitmapData );
		pixasso.addBorderTexture( new BorderTexture_swc( 900, 8) );
		pixasso.roundCorners(44);
		
		// delete the loaded image
		_imageHolder = null;
		myBitmapData.dispose();
		
		// Show the new image with effects
		var bitmap:Bitmap = new Bitmap( pixasso.bitmapData );
		_images[ _loadingImageId ] = bitmap;
		this.addChild(bitmap);
		
		_showNewImage(_loadingImageId);
	}
	
	// ______________________________________________________________ Showing Hiding
	
	private function _showNewImage ( $id:String ):void
	{
		if( _images[$id] != null ) {
			_images[$id].alpha = 0
			_images[$id].visible = true;
			this.setChildIndex(_images[$id], this.numChildren-1);
			
			// Hide current image
			if( _currentImage != null ) 
				Tweener.addTween( _currentImage, { alpha:0, time:transitionSpeed + 0.5, transition:"EaseInOutQuint", onComplete:_hideImage, onCompleteParams:[_currentImageId]} );
			
			Tweener.addTween( _images[$id], { alpha:1, time:transitionSpeed, transition:"EaseInOutQuint", onComplete:_hideImage, onCompleteParams:[_currentImageId]} );
			_currentImageId = $id;
		}
	}
	
	private function _hideImage ( $id:String ):void
	{
		if( _images[$id] != null ) {
			_images[$id].visible = false;
		}
	}
	
	// ______________________________________________________________ Event Listeners
	
	private function _onClick ( e:Event ):void {
		if( _href != null ) 
			navigateToURL( new URLRequest(_href), "_self");
	}
	
	private function _onMouseOut ( e:Event ):void {
		this.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
	}
	
	private function _onMouseOver ( e:Event ):void {
		this.transform.colorTransform = new ColorTransform(1,.93,.84,1,0,0,0,0);
	}
	
	// ______________________________________________________________ Getters + Setters
	
	private function get _currentImage ():Bitmap { return _images[ _currentImageId ]; };
}

}