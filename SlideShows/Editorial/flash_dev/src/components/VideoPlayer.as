package components
{
	
import flash.display.Sprite;
import fl.video.FLVPlayback

public class VideoPlayer extends Sprite
{
	private var _player:FLVPlayback;
	
	public function VideoPlayer(  ):void
	{
		this.graphics.beginFill( 0x000000 );
 		this.graphics.drawRect( 0, 30, 325, 369 );
		
		_player = new FLVPlayback();
		_player.y = 90;
		
		this.addChild( _player );
	}
	
	public function loadVideo ( $vidUrl:String ):void
	{
		_player.source = $vidUrl;
	}
	
	public function playVideo():void
	{
		_player.play();
	}
	
	public function rewind():void
	{
		_player.stop();
		_player.seek(0);
	}

}

}