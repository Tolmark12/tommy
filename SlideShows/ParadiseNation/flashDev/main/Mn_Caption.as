import util.*;
import mvc.*;
import main.*;

class Mn_Caption extends AbstractView
{
	private var captionTxt	:TextField;
	private var positionTxt :TextField;
	
	public function Mn_Caption ( $m:Observable, $c:Controller, $cpt:TextField, $pst:TextField )
	{
		super($m, $c);
		captionTxt  = $cpt;
		positionTxt = $pst;
		captionTxt.autoSize  = true
		positionTxt.autoSize = true;
		make()
	}
	
	// ---------- Update from Model's broadcast ---------- //
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info:Mn_UpdateVO = Mn_UpdateVO( $infoObj );
		if( info.caption != undefined )
		{
			captionTxt.htmlText = info.caption;
		}
		
		if( info.index != undefined ) 
		{
			positionTxt.text = info.index + ' of ' + Mn_Model($o).getTotalSlides();
		}
	}
	
	private function make (  ):Void
	{
		var style:TextField.StyleSheet = new TextField.StyleSheet();
		
		style.setStyle("p", {
			letterSpacing:"-0.8"
		});
		
		
		style.setStyle("a:link", {
			color:"#345FAF"
		});
		
		style.setStyle("a:hover", {
			color:'#CD8501',
			textDecoration:'underline'
		});
		
		captionTxt.styleSheet = style;
	}
	// ---------- Bind the Controller to this View ---------- //
	//public function defaultController (model:Observable):Controller { return new YourControllersClassName(model); }
}