package app.view.components
{

import flash.display.Sprite;
import delorum.text.QuickText;

public class Txt extends Slot
{
	private var _text:QuickText = new QuickText();
	public static var css:String;
	
	public function Txt($width:Number):void
	{
		_text.textWidth = $width;
		_text.useBitmap = false;
		_text.txtField.selectable = false;
		this.addChild(_text);
		_text.parseCss( css );
	}
	
	// Set the text
	public function set text ( $text:String ):void
	{
		_text.htmlText = "<p>" + $text + "<p>";
	}
	
	// ______________________________________________________________ Getters Setters
	
	public function set textSize ( $val:Number ):void { _text.parseCss("p{font-size:" + $val + "; }"); };
	
}

}