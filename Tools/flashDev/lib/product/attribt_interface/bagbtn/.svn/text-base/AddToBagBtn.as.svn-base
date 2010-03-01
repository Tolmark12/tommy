import lib.product.attribt_interface.bagbtn.*
import mx.utils.Delegate;


class AddToBagBtn
{
	private var cbObj:Object;
	private var cbFnc:String;
	private var cbAr :Array;
	
	private var buttonMc:MovieClip;
	
	public function AddToBagBtn( $holderMc:MovieClip )
	{
		make($holderMc);
	}
	
	public function make ( $mc:MovieClip ):Void
	{
		var dep:Number = $mc.getNextHighestDepth();
		buttonMc = $mc.attachMovie('addToBagMc', 'addToBagMc' + dep, dep );
		
		buttonMc.onRelease  = 							  Delegate.create( this, Release );
		buttonMc.onRollOver = 							  Delegate.create( this, RollOver);
		buttonMc.onRollOut  = buttonMc.onReleaseOutside = Delegate.create( this, RollOut);
	}
	
	public function setChangeHandler ( $cbo:Object, $cbf:String, $cba:Array ):Void
	{
		cbObj = $cbo;
		cbFnc = $cbf;
		cbAr  = $cba;
	}
	
	public function Release (  ):Void
	{
		cbObj[cbFnc](null, cbAr[0],cbAr[1],cbAr[2],cbAr[3],cbAr[4],cbAr[5])
	}
	
	public function RollOver (  ):Void
	{

	}
	
	public function RollOut (  ):Void
	{

	}
}