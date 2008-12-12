﻿import nav.SideNav;import nav.TextBtn;import contentArea.Content;import baubles.Bauble;import baubles.BaubleControl;import SWFAddress;import flash.external.ExternalInterface;class ClickHandler{	private static var contentPlaceAr:Array;	private static var contentPlace:Content;	private static var docCon;	private static var baubleObj:Object;	private static var baubleCon:BaubleControl;		// For Browser URL Handling	private static var urlString:String;		// Called from nav.TextBtn.as	public static function loadTextAndImage ( $btn:TextBtn ):Void	{		if( contentPlaceAr == undefined ) 		{			contentPlace.loadImages( $btn.getXmlObj() );			contentPlace.loadText  ( $btn.getXmlObj() );		}		else		{			var len:Number = contentPlaceAr.length;			for ( var i:Number=0; i<len; i++ ) 			{				var _content:Content = contentPlaceAr[i];				_content.loadImages( $btn.getXmlObj() );				_content.loadText  ( $btn.getXmlObj() );			}		}			}		// Called from "baubles.BaubleControl.as"s	public static function notifyThatBaubleIsLoaded ( $justLoadedBauble:Bauble, 		  											  $baublesLeftToLoad:Number):Void	{		ClickHandler[ $justLoadedBauble.getLoadCallBack() ]();	}		// Called from "baubles.BaubleControl.as"	public static function notifyThatBaubleIsVisible ( $justLoadedBauble:Bauble, 		  											  $baublesLeftToLoad:Number):Void	{		ClickHandler[ $justLoadedBauble.getFadeCallBack() ]();	}		// Called from "baubles.Bauble.as"	public static function notifyThatAnimationIsComplete( $bauble /* :Bauble */ ):Void	{		ClickHandler[ $bauble.getAnimateCallBack() ]();	}			// Called fron "baubles.BaubleControl.as - initBaubles()"	public static function registerBaubleForCommands ( $baubleRef:String, $bauble:Bauble ):Void	{		baubleObj = (baubleObj == undefined)? new Object() : baubleObj;		baubleObj[ $baubleRef ] = $bauble;	}		// Set as custom release in xml. Probably called from a TextBtn.as	public static function gotoURL ( $textBtn:TextBtn ):Void	{		var args:Array = $textBtn.getReleaseParams();		getURL( args[0], args[1] );	}			// Call from Doc....	public static function setContentArea  ( $c:Content  )      :Void { contentPlace = $c; };	public static function setDocumentCon  ( $c )		         :Void { docCon = $c;       };	public static function setBaubleHolder ( $c:BaubleControl ) :Void { baubleCon = $c;    };	public static function addContentPlace ( $c:Content  ) :Void 	{		if( contentPlaceAr == undefined ) 			contentPlaceAr = new Array();					contentPlaceAr.push($c); 	};									//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//	//++++ Functions called from Bauble xml or from TextBtn xml ++++//	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//		//----------- Home ---------------------------------------------//		// called by book xml bauble	public static function hidePostCard (  ):Void	{		docCon.getRootMc().photoFrame._visible = true;		var mc:MovieClip = baubleObj.postcard.getImageHolder();		if(mc._currentframe == "stopFrame")		{			mc.play();		}else{			mc.dontStop = true;		}	}		public static function showWatchAndCompass (  ):Void	{		baubleObj.compass.simpleShow( 40 );		baubleObj.watch.simpleShow  ( 40 );		baubleObj.match.simpleShow  ( 40 );  		baubleObj.dollar.simpleShow  ( 40 );		baubleObj.about.simpleShow  ( 40 );		docCon.getRootMc().photoFrame._visible = true;		var temp = ExternalInterface.call('showElements');	}		public static function showHolidayItems (  ):Void	{		setInterval()		baubleObj.ribbon.simpleShow( 40 );		baubleObj.watch.simpleShow  ( 40 );		baubleObj.about.simpleShow  ( 40 );		baubleObj.compass.simpleShow  ( 40 );  		baubleObj.match.simpleShow  ( 40 );		baubleObj.holidayTag.simpleShow  ( 40 );		docCon.getRootMc().photoFrame._visible = true;		var temp = ExternalInterface.call('showElements');	}		public static function showSpringItems (  ):Void	{		setInterval()		baubleObj.watch.simpleShow( 40 );		baubleObj.about.simpleShow( 40 );		baubleObj.compass.simpleShow( 40 );  		baubleObj.holidayTag.simpleShow( 40 );		baubleObj.postcard2.simpleShow(40);		baubleObj.paradise.simpleShow(40);		baubleObj.radio.simpleShow(40);		baubleObj.shadowRight.simpleShow(40);		baubleObj.shadowBottom.simpleShow(40);		baubleObj.valentine.simpleShow( 40 );		baubleObj.giftcards.simpleShow( 40 );		docCon.getRootMc().photoFrameRight._visible = true;		docCon.getRootMc().photoFrameLeft._visible  = true;		var temp = ExternalInterface.call('showElements');	}		public static function october08Callback (  ):Void	{		baubleObj.nav_shadow.simpleShow(40);		baubleObj.bottom_nav.simpleShow(40);		baubleObj.book.simpleShow(40);		baubleObj.pen.simpleShow(40);		baubleObj.big_rock.simpleHide(40);		baubleObj.big_block.simpleShow(40);		baubleObj.sand_gradient.simpleShow(40);		docCon.getRootMc().photoFrameRight.show();		docCon.getRootMc().photoFrameLeft.show();		var temp = ExternalInterface.call('showElements');	}		public static function nov08Callback (  ):Void	{		baubleObj.bottom_nav.simpleShow(40);		baubleObj.book.simpleShow(40);		baubleObj.pen.simpleShow(40);				baubleObj.pen.simpleShow(40);		baubleObj.gifts_paradise.simpleShow(40);		baubleObj.ribbon.simpleShow(40);		baubleObj.gift_cards.simpleShow(40);		baubleObj.blue_stamp.simpleShow(40);		baubleObj.shipping_card.simpleShow(40);						baubleObj.big_rock.simpleHide(40);		baubleObj.big_block.simpleShow(40);		baubleObj.sand_gradient.simpleShow(40);		docCon.getRootMc().photoFrameRight.show();		docCon.getRootMc().photoFrameLeft.show();		var temp = ExternalInterface.call('showElements');	}		public static function showHeaderElements (  ):Void	{		docCon.getRootMc().photoFrame._visible = true;		docCon.getRootMc().photoFrameRight.show();		docCon.getRootMc().photoFrameLeft.show();		var temp = ExternalInterface.call('showElements');	}		//----------- About --------------------------------------------//	private static var sideNav:SideNav;		public static function slideOutSubTag ( $btn:TextBtn ):Void	{		var baubleName:String = $btn.getRollOverParams()[0];		var subBaubleMc:String = $btn.getRollOverParams()[1];				var bauble:Bauble = baubleCon.getBaubleByName( baubleName );		var targetMc:MovieClip = bauble.getImageHolder()[ subBaubleMc ];				bauble.RollOut();				bauble.initSubFramer ( targetMc );		bauble.subFramerPlay();	}		public static function returnSubTag ( $btn:TextBtn ):Void	{		var baubleName:String = $btn.getRollOverParams()[0];		var subBaubleMc:String = $btn.getRollOverParams()[1];				var bauble:Bauble = baubleCon.getBaubleByName( baubleName );		var targetMc:MovieClip = bauble.getImageHolder()[ subBaubleMc ];						bauble.initSubFramer ( targetMc );		bauble.subFramerReverse();	}		// Changing the URL in the browser, and handling its change	public static function handleUrlChange ( $newURL:String ):Void	{//		javaTrace($newURL  + '  :  ' +  urlString);		if( $newURL != urlString)		{			sideNav.goToURL($newURL);		}	}		public static function sendUrlChange ( $newURL:String ):Void	{		urlString = $newURL;		SWFAddress.setValue(urlString);	}		// Set in nan.SideNav	public static function setSideNav ( $sn:SideNav ):Void	{		sideNav = $sn;	}	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//	//++++ Temp function for testing online ++++++++++++++++++++++++//	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//		public static function javaTrace($str)	{		var temp = ExternalInterface.call('alert', $str);		trace($str);	}}