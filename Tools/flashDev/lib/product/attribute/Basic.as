import util.*;
import lib.product.AttributeVO;
import lib.product.attribute.OptionVo;



class lib.product.attribute.Basic implements Observer
{
	private var currentValue:String;
	private var mainMc		:MovieClip;
	
	private var optionsAr	:Array;
	
	private var callBackObj	:Object;
	private var callBackFnc	:String;
	private var callBackAr 	:Array;
	
	public function Basic ( $mc:MovieClip )
	{
		mainMc = $mc.createEmptyMovieClip('mainMc', $mc.getNextHighestDepth() )
	}
	
	public function getValue (  ):String
	{
		return currentValue;
	}
	
	public function setValue ( $val:String ):Void 
	{ 
		currentValue = $val;
	}
	
	public function setChangeHandler ( $cbO:Object, $cbF:String, $cbA:Array ):Void
	{
		callBackObj = $cbO;
		callBackFnc = $cbF;
		callBackAr  = $cbA;
	}
	
	public function update ( $o:Observable, $infoObj:Object  ):Void
	{
		
		var info = AttributeVO($infoObj)
		if( info.newValue != undefined )
		{
			callBackObj[callBackFnc](  info.name, info.newValue, info.valueIndex );
		}
	}
	
	public function remove (  ):Void
	{
		mainMc.removeMovieClip();
	}
}