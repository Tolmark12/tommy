package app.view.components
{

import flash.display.*;
import flash.events.*;
import delorum.loading.ImageLoader;
import delorum.images.Pixasso;
import caurina.transitions.Tweener;

public class Image extends Slot
{
	private var _imageHolder:Sprite;
	private var _images:Object = new Object();
	private var _isLoading:Boolean = false;
	private var _ldr:ImageLoader;
	
	public function Image():void
	{
		super();
	}
	
	// ______________________________________________________________ Image Loading
	/** 
	*	Load the image
	*/
	public function loadImage ( $image:String ):void
	{
		// TODO: Might be nice to not load images that are already loaded. 
		// ie, cache the loaded bitmaps. 
		
		if( _isLoading ) {
			_ldr.cancelLoad();
			_ldr.removeEventListener( Event.COMPLETE, _handleImageLoaded );
		}
		
		_isLoading = true;
		_imageHolder = new Sprite();
		_ldr = new ImageLoader( $image, _imageHolder );
		_ldr.addEventListener( Event.COMPLETE, _handleImageLoaded );
		_ldr.loadItem();
	}
	
	private function _handleImageLoaded ( e:Event ):void
	{
		_isLoading = false;
		
		// Draw the loaded image
		var myBitmapData:BitmapData = new BitmapData(_imageHolder.width, _imageHolder.height, true, 0x000000 );
		myBitmapData.draw( _imageHolder );
		
		// Apply effects
		var pixasso:Pixasso = new Pixasso( myBitmapData );
		pixasso.addBorderTexture( new BorderTexture_swc( 900, 8) );
		pixasso.roundCorners(40);
		
		// delete the loaded image
		_imageHolder = null;
		myBitmapData.dispose();
		
		// Show the new image with effects
		var bitmap:Bitmap = new Bitmap( pixasso.bitmapData );
		bitmap.alpha = 0;
		Tweener.addTween( bitmap, { alpha:1, time:1, transition:"EaseInOutQuint"} );
		this.addChild(bitmap);
	}
	
}

}