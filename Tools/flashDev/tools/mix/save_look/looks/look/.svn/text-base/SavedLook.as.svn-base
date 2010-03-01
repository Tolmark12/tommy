import tools.mix.save_look.looks.look.*;
import lib.scene7.SceneSevenImage;
import lib.product.ItemRepository;
import lib.product.Item;
import mx.utils.Delegate;



class SavedLook
{
	private var holderMc:MovieClip;
	private var topImageHolder:MovieClip
	private var btmImageHolder:MovieClip
	
	// Holds the ids
	private var topId:String;
	private var btmId:String;
	
	// 
	private var cbObj:Object;
	private var cbFnc:String;
	
	
	public function SavedLook( $mc:MovieClip, $topId:String, $btmId:String )
	{
		holderMc = $mc;
		topId = $topId;
		btmId = $btmId;
		
		make();
	}
	
	// _______________________________________________________________________ Make
	private function make (  ):Void
	{
		topImageHolder = holderMc.createEmptyMovieClip("topItemMc", 1);
		btmImageHolder = holderMc.createEmptyMovieClip("btmItemMc", 2);
		btmImageHolder._x = 18;
		
		var topItem:Item = ItemRepository.getItemById( topId );
		var img = new SceneSevenImage( topImageHolder, topItem.getS7ImageName() );
		img.loadImage( true );
		
		var btmItem:Item = ItemRepository.getItemById( btmId );
		var img = new SceneSevenImage( btmImageHolder, btmItem.getS7ImageName() );
		img.loadImage( true );
		
		btmImageHolder._xscale = btmImageHolder._yscale =
		topImageHolder._xscale = topImageHolder._yscale = 10; 
	}
	
	// _______________________________________________________________________ Event Handler
	
	public function setClickCallBack ( $cbO:Object, $cbF:String ):Void
	{
		cbObj = $cbO;
		cbFnc = $cbF;
		holderMc.onRelease = Delegate.create( this, Release); 
	}
	
	public function Release (  ):Void
	{
		cbObj[ cbFnc ]( topId, btmId );
	}
	
	// _______________________________________________________________________ Unmake
	public function remove (  ):Void
	{
		// remove object
		holderMc.removeMovieClip();
		this = null;
	}
}