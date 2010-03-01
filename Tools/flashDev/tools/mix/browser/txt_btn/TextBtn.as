import tools.mix.browser.txt_btn.*

class TextBtn extends MovieClip
{
	private var titleTxt		:TextField;
	private var lineMc			:MovieClip;
	private var catSeparator	:MovieClip;
	private var state			:String;
	private var hitBtn			:MovieClip;
	private var cbObj			:Object;
	private var cbFnc			:String;
	private var cbAr 			:Array;
	
	public function TextBtn()
	{
		titleTxt.autoSize = true;
	}
	
	public function setText ( $str:String ):Void
	{
		titleTxt.text 	= $str;
		lineMc._width 	= titleTxt.textWidth;
		lineMc._alpha   = 0;
		catSeparator._x = titleTxt.textWidth + 8;
		hitBtn._width = titleTxt.textWidth + 22;
		hitBtn.onRelease 	= function(){ this._parent.Release(); };
		hitBtn.onRollOver 	= function(){ this._parent.RollOver(); };
		hitBtn.onRollOut 	= hitBtn.onReleaseOutside = function(){ this._parent.RollOut(); };
		setAsSelected();
	}
	
	public function addSeparator (  ):Void
	{
		catSeparator._alpha = 100;
	}
	
	public function removeSeparator (  ):Void
	{
		catSeparator._alpha = 0;
	}
	
	public function setAsSelected()
	{
		state = 'selected';
		titleTxt._alpha = 100;
	}
	
	public function setAsUnSelected (  ):Void
	{
		state = 'unselected';
		titleTxt._alpha = 60;
	}
	
	// _______________________________________________________________________ Release Handlers
	
	public function Release (  ):Void
	{
		if( state == 'selected' ) 
		{
			setAsUnSelected();
			cbObj[cbFnc]('inactive', cbAr[0],cbAr[1],cbAr[2],cbAr[3],cbAr[4],cbAr[5]);
		}
		else
		{
			setAsSelected();
			cbObj[cbFnc]('active', cbAr[0],cbAr[1],cbAr[2],cbAr[3],cbAr[4],cbAr[5]);
		}
	}
	
	public function RollOver (  ):Void
	{
		lineMc._alpha	= 100;
	}
	
	public function RollOut (  ):Void
	{
		lineMc._alpha	= 0;
	}
	
	// _______________________________________________________________________ Getters / Setters
	
	public function setReleaseCallBack ( $cbo:Object, $cbf:String, $cba:Array ):Void
	{
		cbObj = $cbo;
		cbFnc = $cbf;
		cbAr  = $cba;
	}
	
	public function getWidth (  ):Number
	{
		return catSeparator._x;
	}
}