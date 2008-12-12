import scroller.DragTab;


class contentArea.TextBox extends MovieClip
{
	private var displayTxt:TextField;
	private var textHolder:MovieClip; // Embedded in movie
	private var maskMc:MovieClip;	  // Embedded in movie
	private var dragTabMc:DragTab;	  // Embedded in movie
	private var textOrigY:Number;
	
	// Todo: Get the text box working. These things will be needed:
	// 1- A scrollbar
	// 2- Transparent PNGs where the text fades into the bg
	// 3- Loading function (setting the text)
	
	public function TextBox()
	{
		textOrigY = textHolder._y;
		displayTxt = textHolder.displayTxt;
		displayTxt.autoSize = true;
		textHolder.setMask(maskMc);
		
		var style:TextField.StyleSheet = new TextField.StyleSheet();
		
		
		style.setStyle("div", {
			
		});
		
		style.setStyle("small", {
			fontSize:"8"
		})
		
		style.setStyle("h1", {
			display:"block",
			fontFamily:"Clarendon Bd BT",
			kerning:true,
			letterSpacing:"1"
		});

		style.setStyle("a:link", {
			textDecoration:'underline'
		});
		
		style.setStyle("a:hover", {
			color:'#CD8501'
		});
		
		displayTxt.styleSheet = style;
	}
	
	public function setText ( $str:String ):Void
	{
		textHolder._y = textOrigY;
		displayTxt.htmlText = $str;
		dragTabMc.setDragInfo( maskMc._y , maskMc._y + maskMc._height, 
							   maskMc._height, displayTxt.textHeight + 40,
							   textHolder );
	}
	
	// Called from DragTab, set in "setText()"
	public function scrollText ( $perc:Number ):Void
	{
		
	}
	
	public function getTextField (  ):TextField{ return displayTxt; };
}