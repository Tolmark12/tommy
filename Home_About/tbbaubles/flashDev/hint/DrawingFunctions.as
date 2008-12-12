class  hint.DrawingFunctions
{
	static var hintMc:MovieClip;
	static private var bgMc:MovieClip;
	static private var txtField:TextField;
	static private var spurSize = 5;
	static private var cornerSize = 4;
	static private var boxHeight = 24;
	
	private static function drawBg($width:Number,
						   $height:Number,
						   $corner:String)
	{
		bgMc.clear();
		bgMc.beginFill(0xFFFFFF, 77);
		bgMc.lineStyle(2, 0x777777, 100, false, "noScale", "round", "round")
		bgMc.moveTo(0,0);
		bgMc.lineTo($width, 0);
		bgMc.lineTo($width, $height);
		bgMc.lineTo(0, $height);
		bgMc.lineTo(0, 0);
		bgMc.endFill();
		
		
		var x1:Number;
		var x2:Number;
		var x3:Number;
		
		var y1:Number;
		var y2:Number;
		var y3:Number;
		
		var mcX:Number;
		var mcY:Number;
		
		switch($corner)
		{
			// Top Left
			case "tl":
			x1 = 0; 
			x2 = -spurSize; 
			x3 = cornerSize;
			
			y1 = cornerSize;
			y2 = -spurSize;
			y3 = 0;
			
			mcX = spurSize;
			mcY = spurSize;
			break;
			
			// Top Right
			case "tr":
			x1 = $width-cornerSize; 
			x2 = $width+spurSize; 
			x3 = $width;
			
			y1 = 0;
			y2 = -spurSize;
			y3 = cornerSize;
			
			mcX = -($width + spurSize);
			mcY = spurSize;
			break;
			
			// Bottom Left
			case "bl":
			x1 = cornerSize; 
			x2 = -spurSize; 
			x3 = 0;
			
			y1 = $height;
			y2 = $height + spurSize;
			y3 = $height - cornerSize;
			
			mcX = spurSize;
			mcY = -($height + spurSize);
			break;
			
			// Bottom Right
			case "br":
			x1 = $width; 
			x2 = $width + spurSize; 
			x3 = $width - cornerSize;
			
			y1 = $height - cornerSize;
			y2 = $height + spurSize;
			y3 = $height;
			
			mcX = -($width + spurSize);
			mcY = -($height + spurSize);
			break;
		}
		
		
		bgMc.beginFill(0xFF0000, 70);
		bgMc.lineStyle(0, 0x777777, 0);	
		bgMc.moveTo(x1,y1);
		bgMc.lineTo(x2,y2);
		bgMc.lineTo(x3,y3);
		bgMc.endFill();
		
		bgMc.lineStyle(2, 0x777777, 16, false, "noScale", "round", "round")		
		bgMc.moveTo(x1,y1);
		bgMc.lineTo(x2,y2);
		bgMc.lineTo(x3,y3);
		
		bgMc._x = mcX + 2;
		bgMc._y = mcY -2;
	}
}