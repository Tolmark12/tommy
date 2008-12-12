// Contains functionality specific to the about section

import mx.transitions.Tween;
import mx.transitions.easing.*;

import contentArea.Content;

class contentArea.PhotoBox_about extends contentArea.PhotoBox 
{
	var imageHasSlidOver:Boolean;
	
	public function PhotoBox_about (  )
	{
		super();
		imageHasSlidOver = false;
	}
	
	public function imageLoadedCallBack( $pan:String,
										 $cbObj:Object,
										 $cbFunc:String ): Void
	{
		super.imageLoadedCallBack($pan,$cbObj,$cbFunc);
		if(!imageHasSlidOver && Content.mayIslideThePhotoBox() )
		{
			new Tween( this, "_x", Strong.easeInOut, this._x, 205, 30, false);
			imageHasSlidOver = false;
		}
	}

}