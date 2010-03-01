class lib.product.ItemAttribute  
{
	public var currentValueIndex	:Number; // Index for options and values
	public var optionsAr			:Array; // options and values
	public var classType			:String;	

	public function ItemAttribute($oa:Array, $cv:Number, $ct:String)
	{
		optionsAr    		= $oa;
	 	currentValueIndex	= $cv;
		classType	 		= $ct;
	}
}