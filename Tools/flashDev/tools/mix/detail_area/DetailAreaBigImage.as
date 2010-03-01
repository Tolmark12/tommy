import util.*;
import mvc.*;
import tools.mix.detail_area.*;
import lib.scene7.SceneSevenImage;
import lib.product.Item;
import mx.utils.Delegate;
import caurina.transitions.Tweener;


class DetailAreaBigImage extends AbstractView
{
	private var mainMc		:MovieClip;
	private var dep			:Number = 1;
	private var imageMc		:MovieClip;
	private var currentMc	:MovieClip;
	private var oldMc		:MovieClip;
	
	public function DetailAreaBigImage ( $o:Observable, $m:Controller, $mc:MovieClip )
	{
		super($o, $m);
		mainMc = $mc;
		make();
	}
	
	// _______________________________________________________________________ Update
	public function update ($o:Observable, $infoObj:Object)
	{
		var info:DetailArea_Vo = DetailArea_Vo($infoObj);
		
		if(info.newItem != undefined)
		{
			var newItem:Item = Item( info.newItem );
			var newImage:MovieClip = imageMc.createEmptyMovieClip( "imageMc" + dep, dep++ )
			var img = new SceneSevenImage( newImage, newItem.getS7ImageName() );
			newImage._visible = false;
			newImage._alpha = 30;
			img.setCallBacks( this, 'newImageLoadedCallback', [ newImage ]);
			img.loadImage( true );
			
			//Tweener.addTween( currentMc, {_alpha:0, time:0.5, transition:"easeOutCubic", onComplete:removeOldMc} );
			//removeOldMc();
			oldMc = currentMc;
			currentMc = newImage;
		}
	}
	
	// _______________________________________________________________________  Make
	private function make (  ):Void
	{
		var bg:MovieClip = mainMc.createEmptyMovieClip('bg', 2);
		imageMc	= mainMc.createEmptyMovieClip('photoBox', 3);
		//imageMc.attachMovie('photoholder_temp','scene7holder',2);
		imageMc._x = -11;
		imageMc._y = -6;
	}
	
	// _______________________________________________________________________ Fade In image after load
	public function newImageLoadedCallback ( $mc:MovieClip ):Void
	{
		$mc._visible = true;
		Tweener.addTween( $mc, {_alpha:100, time:0.4, transition:"linear", onComplete:removeOldMc} );
	}
	
	// _______________________________________________________________________ Remove old image holder after fade out
	public function removeOldMc (  ):Void
	{
		oldMc.removeMovieClip();
	}
	
}