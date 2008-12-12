class bauble_code.HomeBottomNav
{
	private var _navWidth:Number = 780;
	private var _root:MovieClip;
	private var _navHolder:MovieClip;
	private var _navItemsAr:Array;
	public function HomeBottomNav( $xml:Object, $root:MovieClip )
	{
		_root = $root;
		_buildNav($xml);
	}
	
	// ______________________________________________________________ Build Nav
	private function _buildNav ( $xml:Object ):Void
	{
		_navHolder  = _root.createEmptyMovieClip("navHolder", _root.getNextHighestDepth());
		_navItemsAr = new Array();
		var count:Number = 0;
		var totalWidth:Number = 0;
		
		
		// Create items
		for( var i:String in $xml.nav )
		{
			var mc:MovieClip = _navHolder.attachMovie( "NavButton", "btn" + count, count++, {_x:i*20} );
			mc.subText.align = ( $xml.nav[i].subTextAlign == undefined )? 'left' : $xml.nav[i].subTextAlign ;
			mc.titleTxt.autoSize = true;
			mc.subText.titleTxt.autoSize = true;
			mc.subText._alpha = 0;
			mc.titleTxt.text = $xml.nav[i].text;
			mc.subText.titleTxt.text = $xml.nav[i].subText
			var txtWidth = mc.titleTxt.textWidth;
			totalWidth += txtWidth;
			
			_setEvents(mc.dummyBtn, $xml.nav[i].href);
			
			_navItemsAr.push(mc);
			
		}
		
		// Space items
		var padding:Number = Math.round( (_navWidth - totalWidth) / (_navItemsAr.length + 1) );
		var xPos = padding;
		
		var len:Number = _navItemsAr.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			var mc:MovieClip = _navItemsAr[i];
			var txtWidth = mc.titleTxt.textWidth;
			
			if( i != len-1 ) 
			{
				var divider:MovieClip = mc.attachMovie( "dividerMc", "divide", 2 );
				divider._x = txtWidth + padding/2
				divider._y = 4;
				divider._alpha = 50;
			}
			
			mc._y = 29;
			mc._x = xPos;
			mc.dummyBtn._x = -padding/2;
			mc.dummyBtn._width = txtWidth + padding;
			switch (mc.subText.align){
				case "right" :
					mc.subText._x = txtWidth - mc.subText.titleTxt.textWidth ;
				break;
				case "center" :
					mc.subText._x = txtWidth/2 - mc.subText.titleTxt.textWidth/2 ;
				break;
				default:
					mc.subText._x = 0;
				break;
			}
			xPos += txtWidth + padding;
		}
	}
	
	private function _setEvents ( $btn:MovieClip, $url:String ):Void
	{
		$btn.url = $url;
		$btn.colorObj = new Color($btn._parent.titleTxt);
		
		$btn.onRelease = function()
		{
			getURL( this.url, "_self" );
		}
		
		$btn.onRollOver = function()
		{
			this.colorObj.setRGB( 0x720505 /*0x5B0B0B*/ );
			this._parent.subText._alpha = 100;
		}
		
		$btn.onRollOut = $btn.onReleaseOutside = function()
		{
			this.colorObj.setRGB( 0x433A34 );
			this._parent.subText._alpha = 0;
		}
	}
	
}

