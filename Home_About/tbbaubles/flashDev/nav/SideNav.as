import nav.TextBtn;
import nav.TextBtnMain;
import nav.TextBtnSub;
import baubles.BaubleControl;

class nav.SideNav
{

	private var xmlObj:Object;
	private var navMc:MovieClip;
	private var activeBtn:TextBtnMain;
	private var mainNavAr:Array;
	private var subMenuYpos:Number;
	private var spaceAfterSubMenu:Number;
	private var baubleCon:BaubleControl;
	
	// Holds references to the buttons based on their url string
	private var btnObj:Object;
	private var subBtrToTrigger:String;
	
	function SideNav ( $xmlObj:Object,
		 			   $navMc:MovieClip, 
		 			   $baubleCon:BaubleControl)
	{
		btnObj			  = new Object();
		baubleCon 		  = $baubleCon;
		subMenuYpos 	  = 14;
		spaceAfterSubMenu = 14;
		xmlObj 			  = $xmlObj;
		navMc 			  = $navMc;
		mainNavAr 		  = new Array();
		
		ClickHandler.setSideNav(this)
		buildNav( );
	}
	
	//-------- Menu Builders ------------------------------//
	// Build the Main Side Nav
	private function buildNav ( ):Void
	{
		var xPos:Number    = 2
		var yPos:Number    = 28;
		var yInc:Number    = 31;
		var dep:Number     = 1;
		var count:Number   = 0;
		var release:String = xmlObj.releaseFunction;
		delete xmlObj.releaseFunction;
		
		for( var i:String in xmlObj )
		{
			// Attach Btn and init
			var btn:TextBtnMain = new TextBtnMain( navMc, dep++, xPos, yPos += yInc );
			btn.setInfo(xmlObj[i], release, count );
			btn.setURLString(i);
			btn.setCallBackInfo( this, 'mainBtnClick');
			btn.setSideNav( this );
			mainNavAr[count] = btn;
			
			// Set Ref to btn in btn Object based on url id (ex: brands/tommy_bahama)
			btnObj[i] = btn;
			
			// Send Baubles to the Bauble loader
			if( btn.baubleExists() )
			{
				baubleCon.associateSisterWithBtn( btn.getBaubleArray(), btn );
			}
			count++;
		}
		//goToURL ('accessories/footwear_belts_hoosiery');
	}
	
	// Build Sub Menu after click, called by: buildNav() 
	private function buildSubNav ( $btn:TextBtnMain,
		 						   $subItems:Number ):Void
	{
		var holderMc:MovieClip = $btn.getSubHolderMc();
		var subXmlObj:Object = $btn.getSubMenuXmlObj();
		
		var xPos = 10
		var yPos = subMenuYpos;
		var yInc = 20;
		var dep = 1;
		var count = 0;
		var release:String = subXmlObj.releaseFunction;
		var rollOver:String = subXmlObj.rollOver;
		var rollOut:String = subXmlObj.rollOut;
		

		for( var i:String in subXmlObj )
		{
			if( typeof subXmlObj[i] == 'object' )
			{
				var btn:TextBtnSub = new TextBtnSub(holderMc, dep++, xPos, yPos += yInc);
				btn.setInfo( subXmlObj[i], release, rollOver, rollOut );
				btn.setURLString(i);
				btn.setSideNav( this );
				
				// Set Ref to btn in btn Object based on url id (ex: brands/tommy_bahama)
				btnObj[i] = btn;
				
				btn.setCallBackInfo( this, 'subBtnClick');
			}
		}
	}
	
	
	//-------- Button Event Handlers ----------------------//
	// Handle click in "TextBtnMain.as"
	public function mainBtnClick ( $btn:TextBtnMain ):Void
	{
		var numSubItems:Number = $btn.getTotalSubItems();
		var ind:Number = $btn.getIndex();
		var subItemSpace:Number = 18;
		var callBackIndex
		var xtraYspace = (numSubItems > 0)?  subMenuYpos + spaceAfterSubMenu : 0 ;
		var cbInd = ( ind <= mainNavAr.length )? ind + 1 : ind - 1;
		
		// Move all the buttons 
		var len:Number = mainNavAr.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			if(i > ind) 
			{
				// If btn is below the clicked button
				mainNavAr[i].closeUp( cbInd );
				mainNavAr[i].moveBtn( numSubItems * subItemSpace + xtraYspace );	
			}else if( i != ind ) { 
				// btn is below
				mainNavAr[i].closeUp();
			}else{
				mainNavAr[i].moveUp();
			}
		}
		
		// Add a sub menu if there is one
		if(numSubItems > 0)
		{
			buildSubNav($btn, numSubItems);
		}
		
		activeBtn = $btn;
		
		var subBtn:TextBtn = getBtnByURL(subBtrToTrigger)
		subBtn.Release();
		subBtrToTrigger = undefined;
	}
	
	public function btnRoll ( $btn:TextBtnMain ):Void
	{
		$btn.rollOverBaubles();
	}
	
	public function btnRollOut ( $btn:TextBtnMain ):Void
	{
		$btn.rollOutBaubles();
	}
	
	// Handle click in "TextBtnSub.as"
	public function subBtnClick ( $btn:TextBtnMain ):Void
	{
		//trace('subItemClicked');
	}
	

	public function handleItemsClosed (  ):Void
	{
		var len:Number = mainNavAr.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			mainNavAr[i].hideSubNav()
		}
		activeBtn.fadeInSubMenu ();
	}
	
	//-------- Triggering Buttons from URL ----------------//
	public function goToURL ( $url:String ):Void
	{
		var ar:Array = $url.split('/');
		var mainBtn = getBtnByURL( ar[0] );
		subBtrToTrigger = $url;
		mainBtn.Release();
	}
	
	public function getBtnByURL ( $urlStr:String ):TextBtn
	{
		return btnObj[$urlStr];
	}
	
	//-------- Getters and Setters ------------------------//
	public function getActiveBtn (  ):TextBtnMain { return activeBtn; };
	public function setActiveBtn ( $mc:TextBtnMain ):Void { activeBtn = $mc };
	public function getBaubleControl (  ):BaubleControl{ return baubleCon; };

}