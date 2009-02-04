import lib.slides.Slide;


class main.Mn_UpdateVO
{
	public var command:String; // ex: play, next, prev
	public var caption:String;
	public var slide:Slide;
	public var index:Number;
	
	public function Mn_UpdateVO ( $cmd:String,
								  $cpt:String,
								  $sld:Slide, 
								  $ind:Number )
	{
		command = $cmd;
		caption = $cpt;
		slide	= $sld;
		index   = $ind;
	}
}