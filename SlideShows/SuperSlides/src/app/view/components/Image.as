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
		_imageHolder = new Sprite();
		var ldr:ImageLoader = new ImageLoader( $image, _imageHolder );
		ldr.addEventListener( Event.COMPLETE, _handleImageLoaded );
		ldr.loadItem();
	}
	
	private function _handleImageLoaded ( e:Event ):void
	{
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