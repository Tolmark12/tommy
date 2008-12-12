class hint.Interface extends hint.Display
{
	public static var stageWid;
	public static var stageTal;
	public static var blackTxt:TextFormat;
	public static var redTxt:TextFormat;
	public static var blueTxt:TextFormat;
	
	public static function activateHint($rootMc:MovieClip)	
	{
		stageWid = Stage.width;
		stageTal = Stage.height;
		
		blackTxt = new TextFormat();
		blackTxt.size = 12;
		blackTxt.color = 0x000000;
		blackTxt.font = "Clarendon BT";
		
		redTxt = new TextFormat();
		redTxt.color = 0xCC1919;
		
		blueTxt = new TextFormat();
		blueTxt.color = 0x5D6FA3;
		
		hintMc = $rootMc.createEmptyMovieClip('hintMc', 28793);
		bgMc = hintMc.createEmptyMovieClip('hintMc', 1);
		txtField = bgMc.createTextField('txtField',2,4,4,10,10);
		txtField.autoSize = true;
		txtField.setNewTextFormat(blackTxt);
	}
	
	public static function hideHint()
	{
		hintMc.onMouseMove = null;
		makeInvisible();
	}
	
	public static function showHint($str)
	{
		txtField.text = ''		
		switch(typeof $str)
		{
			case "string":
			txtField.text += $str;
			break
			
			case "object":
			var len = $str.length;
			for(var i=0;i<len;i++)
			{
				if(typeof $str[i] == "string")
				{
					txtField.text += $str[i]; 
				}
				else
				{
					txtField.text += $str[i][0];
					txtField.setTextFormat(txtField.text.length - $str[i][0].length, txtField.text.length, hint.Interface[$str[i][1]]  );
				}
			}
		}
		hintMc.onMouseMove = function()
		{
			this._x = _root._xmouse;
			this._y = _root._ymouse;
			hint.Interface.findCorner(['this is a test ',['with and added bonus','redTxt']]);
			updateAfterEvent();
		}
		hintMc.onMouseMove();
		makeVisible();
	}
	
	public static function findCorner()
	{
		var corner:String;
		var wid = txtField.textWidth;
		var tall = 20;
		var xm = _root._xmouse;
		var ym = _root._ymouse;
		
		// Find which corner for the spur
		var yvar:String = (ym - tall - spurSize < 0)? 't' : 'b';
		var xvar:String = (xm + wid + spurSize + 15 < stageWid)? 'l' : 'r';
		
		drawBg(wid + 15, boxHeight, yvar + xvar);
	}
										  
}
