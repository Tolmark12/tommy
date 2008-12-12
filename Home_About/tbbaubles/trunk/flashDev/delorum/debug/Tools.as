import delorum.debug.*;
import flash.external.ExternalInterface;

class Tools
{
	public static function javascript($varsAr:String)
	{
		var vars = $varsAr.split(',');
		var temp = ExternalInterface.call(vars[0],vars[1], vars[2], vars[3],vars[4], vars[5], vars[6]) ;
	}
	
	public static function javaTrace($str)
	{
		var temp = ExternalInterface.call('alert', $str);
		trace($str);
	}
}