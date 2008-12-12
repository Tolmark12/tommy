class hint.Display extends  hint.DrawingFunctions
{
	
	private function displayhint()
	{
		
	}
	
	private static function makeVisible()
	{
		hintMc.fadeTo(100,1);
	}
	
	private static function makeInvisible()
	{
		hintMc.fadeTo(0, 2, hint.Display, 'moveOffScreen');
	}
	
	private static function moveOffScreen()
	{
		hintMc._x = -200000;
	}
}