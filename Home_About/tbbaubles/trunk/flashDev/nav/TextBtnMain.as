import mx.transitions.Tween;
import mx.transitions.easing.*;

class nav.TextBtnMain extends nav.TextBtn
{
	private var totalSubItems:Number;
	private var origY:Number;
	private var myIndex:Number;
	private var subMenuMc:MovieClip;
	private static var activeMainBtn:TextBtnMain;
	
	public function TextBtnMain( $navMc:MovieClip,
		 					 	 $dep:Number,
							 	 $x:Number,
							 	 $y:Number )
	{
		super( $navMc,$dep,$x,$y );
		origY = $y;
	}
	
	public function setInfo ( $xmlObj:Object, $release:String, $index:Number ):Void
	{
		super.setInfo($xmlObj, $release);
		myIndex = $index;
		totalSubItems = 0;
		
		for( var i:String in xmlObj.subMenu )
		{
			// Make sure they are sub items
			if( i.split('/').length > 1 )
			{
				totalSubItems++;
			}
		}
	}
	
	public function getIndex ():Number { return myIndex; };
	public function getName ():Number { return xmlObj.title; };
	public function getTotalSubItems ():Number { return totalSubItems; };
	public function getSubMenuXmlObj ():Number { return xmlObj.subMenu; };
		
	public function getSubHolderMc (  ):MovieClip	
	{
		subMenuMc.removeMovieClip();
		subMenuMc = btnMc.createEmptyMovieClip( 'subBtnHolder', btnMc.getNextHighestDepth() );
		subMenuMc._alpha = 0;
		return subMenuMc;
	}
	
	
	public function moveBtn ( $xtra:Number ):Void
	{
		new Tween(btnMc, "_y", Strong.easeIn, btnMc._y, origY + $xtra, 15, false);
	}
	
	public function closeUp ( $cbIndex:Number ):Void
	{
		moveUp();
		var tween_handler = new Tween(subMenuMc, "_alpha", Strong.easeOut, subMenuMc._alpha, 0, 15, false);
		new Tween(subMenuMc, "_x", Strong.easeInOut, subMenuMc._x, -10, 10, false);
		if($cbIndex == myIndex)
		{
			tween_handler.con = this;
			tween_handler.onMotionFinished = function() {
			    this.con.cbObj.handleItemsClosed();
			};	
		}
	}
	
	public function moveUp (  ):Void
	{
		new Tween(btnMc, "_y", Strong.easeIn, btnMc._y, origY, 15, false);
	}
	
	public function fadeInSubMenu (  ):Void
	{
		subMenuMc._visible = true;
		subMenuMc._x = -10;
		new Tween(subMenuMc, "_alpha", Strong.easeInOut, 0, 100, 12, false);
		new Tween(subMenuMc, "_x", Strong.easeInOut, subMenuMc._x, 0, 13, false);
	}
	
	public function hideSubNav():Void
	{
		subMenuMc._visible = false;
	}


//--------- Event Handlers ---------//
	public function Release (  ):Void
  	{
		var currBtn = cbObj.getActiveBtn();
		if( currBtn != this )
		{
			super.Release()
			nav.TextBtnSub.currentBtn.RollOut(true);
			currBtn.RollOut();
		}else{
			// Todo: add ability to show the content without changing the dropdown
		}

	}
	
	public function RollOver (  ):Void
	{
		super.RollOver();
	}
	
	public function RollOut (  ):Void
	{
		if( cbObj.getActiveBtn() != this )
		{
			super.RollOut();	
		}
		super.rollOutBaubles();
	}
	
	// Overwriting in super
	private function getTitleTxt (  ):String
	{
		return xmlObj.title.toUpperCase();
	}
}