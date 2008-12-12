class Loading.ImageLoaderListener
{
	var cbo:Object;
	var cbf:String;
	var cba:Array;
	
	private  function onLoadStart()
	{
		
	}
	
	private  function onLoadProgress()
	{
		
	}
	
	private  function onLoadInit(targetMc:MovieClip)
	{
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
}
