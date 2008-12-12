class nav.TextBtnSub extends nav.TextBtn
{
	private var subMenuSpace:Number;
	private var origY:Number;
	private var myIndex:Number;
	private var lineMc:MovieClip;
	private var rollColor:Number   = 0x111111;
	
	static var currentBtn:TextBtnSub
	
	public function TextBtnSub( $navMc:MovieClip,
		 					 	 $dep:Number,
							 	 $x:Number,
							 	 $y:Number )
	{
		super( $navMc,$dep,$x,$y );
		btnMc.lineMc._visible = false;
	}
	
	//--------- Event Handlers ---------//
	public function Release (  ):Void
	{
		if( currentBtn != this )
		{
			super.Release();
			var oldBtn:TextBtnSub = currentBtn;
			currentBtn = this;
			oldBtn.RollOut();
		}else{
			// Todo: add ability to show the content without changing the dropdown
		}
    
	}
    
	public function RollOver (  ):Void
	{
		if( currentBtn != this )
		{
			super.RollOver();
		}
	}
    
	public function RollOut ( $bool:Boolean ):Void
	{
		if( currentBtn != this || $bool)
		{
			super.RollOut();	
		}
	}
	
}
