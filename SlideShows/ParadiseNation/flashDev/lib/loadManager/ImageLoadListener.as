import lib.loadManager.ImageLoader;

class lib.loadManager.ImageLoadListener
{
	private var cbo:Object;
	private var cbf:String;
	private var cba:Array;
	
	private var progressObj:Object;
	
	private  function onLoadStart()
	{
		//trace('loadstarting');
		progressObj.onLoadStart();
	}
	
	private  function onLoadProgress( $target:MovieClip, $bytesLoaded:Number, $bytesTotal:Number)
	{
		// todo: add Load progress displaying ability "loadManager.progressHandler" ?
		var perc:Number = $bytesLoaded / $bytesTotal;
		progressObj.onLoadProgress( perc );
	}
	
	private function onLoadError ( $get_mc:MovieClip, $errorCode:String, $httpStatus:Number ):Void
	{
		progressObj.onLoadError( );
		ImageLoader.loadNextItem();
	}
	
	private  function onLoadInit(targetMc:MovieClip)
	{
		progressObj.onLoadInit( targetMc );
		cbo[cbf](cba[0],cba[1],cba[2],cba[3],cba[4],cba[5],cba[6],cba[7])
	}
	
	public function setCallBack($cbObj:Object,
						 		$cbFunc:String,
						 		$cbAr:Array)
	{
		cbo = $cbObj;
		cbf = $cbFunc;
		cba = $cbAr;
	}
	
	public function registerProgressObj ( $listener:Object ):Void
	{
		progressObj = $listener;
	}
}
