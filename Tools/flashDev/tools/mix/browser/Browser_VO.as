import tools.mix.browser.Br_Model;


class tools.mix.browser.Browser_VO
{
	public var activeCategories		:Object;
	public var totalItems			:Number;
	public var newCategories		:Array;
	public var incramenting			:Boolean;
	public var incramentDirection	:Number; 	// Either -1 or 1, indicates when the right and left buttons
												// are clicked and which button was clicked
	
	// New items
	public var categories			:Object;	// Object full of "Browser_VO" objects
	
	// New Total list
	public var newProductRange		:String;	// ex: 1-4, ex: 3-20
	public var cardScale			:Number;
}