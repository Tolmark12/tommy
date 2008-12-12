class contentArea.SoundTool extends Sound
{
	private var volumeInterval	:Number;
	private var vol				:Number;
	
	// Call backs
	private var cbObj  :Object;
	private var cbFunc :Object;
	private var cbar   :Object;
	
	public function SoundTool(){}
	
	public function fadeOutSound ( $mc:MovieClip ):Void
	{
		vol = 100;
		volumeInterval = setInterval( function( $obj:SoundTool, $func:String )
		{
			$obj[$func]();
		}, 50, this, "fadeOutLoop" )
	}
	
	public function fadeOutLoop (  ):Void
	{
		if(vol > 5)
		{
			vol -= 3;
		}
		else
		{
			vol = 0;
			clearInterval( volumeInterval );
			cbObj[cbFunc]( cbar[0],cbar[1],cbar[2],cbar[3],cbar[4] );
		}
		super.setVolume( vol );
	}
	
	public function setCallBacks ( $o:Object, $f:String, $ar:Array ):Void
	{
		cbObj  = $o;
	    cbFunc = $f; 
		cbar   = $ar; 
	} 
}