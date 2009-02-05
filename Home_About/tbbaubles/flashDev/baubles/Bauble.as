﻿import mx.transitions.Tween; import mx.transitions.easing.*;import baubles.BaubleControl;import mx.utils.Delegate;import nav.TextBtnimport ClickHandler;import flash.external.ExternalInterface;// Temp for testing//import delorum.debug.Tools;class baubles.Bauble extends baubles.Bauble_framing{		private var stageAlign:String = "left"		private var xmlObj:Object;	private var baubleMc:MovieClip;	private var baubleHolderMc:MovieClip;		// Vars dealing with motion	private var rollOutX:Number;	private var rollOutY:Number;	private var rollOutR:Number;		// _rotation	private var rollOutA:Number;		// _alpha	private var rollOutXS:Number;	private var rollOutYS:Number;		private var rollOverX:Number;	private var rollOverY:Number;	private var rollOverR:Number;	private var rollOverA:Number;	private var rollOverXS:Number;	private var rollOverYS:Number;			private var baubleCon:BaubleControl;	private var twnX:Tween;	private var twnY:Tween;	private var twnR:Tween;	private var twnA:Tween;	private var twnXS:Tween;	private var twnYS:Tween;	private var hasCalledBack:Boolean;		//For determining of fade in call back has ran		// Vars dealing with clicking	private var sisterBtn:TextBtn;	private var uniqueName:String;	private var releaseFunction:Function;	private var myURL:String;	private var rollState:String;	private var isVisible:Boolean;		// Patch oct 08	private var _isLoaded:Boolean = false;	private var _loadedCb:String;	private var _loadedParam;		public function Bauble ( )	{		super();		rollState = 'out';	}		public function setInfo ( $xmlObj:Object, $holderMc:MovieClip, $dep:Number, $baubleCon:BaubleControl ):Void	{		xmlObj = $xmlObj;		uniqueName = "bauble" + $dep;		baubleMc = $holderMc.createEmptyMovieClip( uniqueName, $dep );		if( $xmlObj.useHandCursor == "false" ) 			baubleHolderMc.useHandCursor = false;		baubleHolderMc = baubleMc.createEmptyMovieClip( "imageHolder", 1 );		baubleCon = $baubleCon;		setMaskIfItExists();		setPositions();		setReleaseFunctionality();	}		public function loadedCallBack()	{		super.addFramesMotionIfItExists( xmlObj.frames, baubleHolderMc );		super.prepareFrames();				// If we are passing any code into the bauble for it's use, 		// create a function called: runBaubleCode(); This will be		// called on the bauble's load, and if there is an xml node called		// bauble content that looks like:				/*				<bauble id="bottom_nav" file="HOME_bottom_nav.swf" x="6" y="475" maskMc="bottomNavMask" depth="2" fade="hide" clickable="false"   >			<baubleContent>				<!-- ... xml here .... -->			</baubleContent>		</bauble>				*/				if(xmlObj.baubleContent != undefined)		{			baubleMc.imageHolder.runBaubleCode( xmlObj.baubleContent )		}		_isLoaded = true;		this[_loadedCb]( _loadedParam );				if( xmlObj.jsOnLoaded != undefined ) 			ExternalInterface.call( xmlObj.jsOnLoaded );			}		//------- Event Handlers -------//	public function Release()	{		sisterBtn.Release();		releaseFunction();		// Call any custom rollover functionality		baubleMc.imageHolder.mainClass.onRelease();	}		public function RollOver()	{		// Call any custom rollover functionality		baubleMc.imageHolder.mainClass.onRollOver();		if( rollState == 'out' && isVisible)		{			baubleHolderMc._visible = true;			//hint.Interface.showHint(xmlObj.title); // Fix this			rollState = 'over';			sisterBtn.RollOver();			tweenTo( rollOverX, rollOverY, rollOverR, rollOverA, rollOverXS, 15) ;			super.rollOverFrames();		}	}		public function RollOut()	{		// Call any custom rollover functionality		baubleMc.imageHolder.mainClass.onRollOut();				if( rollState == 'over' && isVisible)		{			rollState = 'out';			sisterBtn.RollOut();			tweenTo( rollOutX, rollOutY, rollOutR, rollOutA, rollOutXS, 10) ;			super.rollOutFrames();		}	}		private function setReleaseFunctionality (  ):Void	{		// activate goto functionality		// If I have to, I could add each function to an array, 		// and loop through it like:		// for(...) { this[ functionAr[i] ](); }				if(xmlObj.link != undefined)		{			myURL = xmlObj.link;			releaseFunction = gotoNewPage;		}				if(xmlObj.javascript != undefined)		{			myURL = xmlObj.javascript;			releaseFunction = callJavascript;		}	}		private function callJavascript (  ):Void	{		var temp = ExternalInterface.call( myURL );	}		private function gotoNewPage ():Void	{		var window:String = ( xmlObj.linkWindow != undefined )? xmlObj.linkWindow : '_self' ;		getURL( myURL, '_self' );	}		//------- Transitions / Movement -------//	public function show (  )	{		var speed:Number;		setPositions ();		switch(xmlObj.fade)		{			case "none":			baubleHolderMc._alpha = 100;			this.fadeInCallBack();			return null;			break						case "fast":			speed = 4			break						case "slow":			speed = 25;			break						case "veryslow":			speed = 30;			break						case "hide":			baubleHolderMc._alpha = 0;			//baubleHolderMc._visible = false;			baubleCon.baubleDisplayedCallBack( this );			//this.fadeInCallBack();			return null						default:			speed = 12		}				twnA.stop();		twnA = new Tween( baubleHolderMc, "_alpha", Regular.easeInOut, 0, 100, speed, false);		twnA.onMotionFinished = Delegate.create(this, fadeInCallBack);	}		public function simpleShow ( $speed:Number ):Void	{		if( _isLoaded ) 		{			baubleHolderMc._visible = true;						twnA.stop();			twnA = new Tween( baubleHolderMc, "_alpha", Regular.easeInOut, 0, 100, $speed, false);			twnA.onMotionFinished = Delegate.create(this, fadeInCallBack);		}		else		{			_loadedCb = "simpleShow";			_loadedParam = $speed;		}	}		public function simpleHide ( $speed:Number ):Void	{		twnA.stop();		twnA = new Tween( baubleHolderMc, "_alpha", Regular.easeInOut, baubleHolderMc._alpha, 0, $speed, false);	}		public function fadeInCallBack (  ):Void	{				if(!hasCalledBack)		{			baubleMc.imageHolder.mainClass.onFadedIn();			hasCalledBack = true;			baubleCon.baubleDisplayedCallBack( this );			setEvents();			isVisible = true;			//ClickHandler.notifyThatFadeinIsComplete( this );		}	}		//------- Setting the Position -------//	private function setPositions (  ):Void	{		var wid:Number = PathFinder.getMovWidth();		var tal:Number = PathFinder.getMovHeight();		var x:Array = xmlObj.x.split('*');		var y:Array = xmlObj.y.split('*');		var width:Array = xmlObj.width.split("%");		var height:Array = xmlObj.height.split("%");				if( stageAlign == "center" ) 			centerAlign( x[0] ,y[0], wid, tal );		else			leftAlign( x[0], y[0], wid, tal );				if( width.length == 2 ) 		{			baubleMc._width = Stage.width * (Number(width[0])/100);			baubleCon.addBaubleToStageResize(this);		}				if( height.length == 2 ) 		{			baubleMc._height = Stage.height * (Number(height[0])/100);			baubleCon.addBaubleToStageResize(this);			trace( baubleMc + '  :  ' + baubleMc._height + '  :  ' + Stage.height * (Number(height[0])/100) );		}						rollOverXS = rollOverYS = rollOutXS = rollOutYS = 100;		// Add any extra distance to the rollout position		rollOutX += (x.length == 2)? Number( x[1] ) : 0 ;		rollOutY += (y.length == 2)? Number( y[1] ) : 0 ;		rollOutA = (xmlObj.alpha != null)? Number(xmlObj.alpha) : 100 ;		rollOutR = (xmlObj.rot != null)? Number(xmlObj.rot) : 0 ;		if( xmlObj.scale != null )		{			rollOutXS = 			rollOutYS = Number( xmlObj.scale );		}				rollOverX = rollOutX + Number(xmlObj.hover_x);		rollOverY = rollOutY + Number(xmlObj.hover_y);		rollOverA = (xmlObj.hover_alpha != null)? Number(xmlObj.hover_alpha) : 100 ;		rollOverR = (xmlObj.hover_rot != null)? Number(xmlObj.hover_rot) : 0 ;		if( xmlObj.hover_scale != null )		{			rollOverXS = 			rollOverYS = Number( xmlObj.hover_scale );		}				baubleMc._x = rollOutX; 		baubleMc._y = rollOutY;		//baubleMc._xscale = 		//baubleMc._yscale = rollOutXS;				baubleMc._rotation = rollOutR;		baubleMc._alpha = rollOutA;	}		private function centerAlign ( $x:String, $y:String, wid:Number, tal:Number ):Void	{		switch($x){				case "right":			rollOutX = Stage.width - (Stage.width - wid)/2;			baubleCon.addBaubleToStageResize(this)			break						case "left":			rollOutX = 0 - (Stage.width - wid)/2;			baubleCon.addBaubleToStageResize(this);			break						case "center":			rollOutX = (wid / 2) - baubleMc._width/2;			baubleCon.addBaubleToStageResize(this);			break						default:			rollOutX = Number($x);		}				switch($y){			case "top":			//rollOutY = 0 - (Stage.height - tal)/2;			rollOutY = 0;			baubleCon.addBaubleToStageResize(this);			break						case "bottom":			rollOutY = Stage.height;			baubleCon.addBaubleToStageResize(this);			break						case"center":			rollOutY = (tal / 2) - baubleMc._height/2;			baubleCon.addBaubleToStageResize(this);			break						default:			rollOutY = Number($y);			}	}		private function leftAlign ( $x:String, $y:String, wid:Number, tal:Number ):Void	{		switch($x){				case "right":			rollOutX = Stage.width - baubleMc._width;			baubleCon.addBaubleToStageResize(this)			break						case "left":			rollOutX = 0;			baubleCon.addBaubleToStageResize(this);			break						case "center":			rollOutX =  Stage.width/2 - baubleMc._width/2;			baubleCon.addBaubleToStageResize(this);			break						default:			rollOutX = Number($x);		}				switch($y){			case "top":			//rollOutY = 0 - (Stage.height - tal)/2;			rollOutY = 0;			baubleCon.addBaubleToStageResize(this);			break						case "bottom":			rollOutY = Stage.height;			baubleCon.addBaubleToStageResize(this);			break						case"center":			rollOutY = (tal / 2) - baubleMc._height/2;			baubleCon.addBaubleToStageResize(this);			break						default:			rollOutY = Number($y);			}	}		private function tweenTo ( $x:Number, $y:Number, $rot:Number, $alph:Number, $scale:Number, $speed:Number ):Void	{		twnX.stop();		twnY.stop();		twnR.stop();		twnA.stop();		twnXS.stop();		twnYS.stop();						twnX  = new Tween( baubleMc, "_x", Strong.easeInOut, baubleMc._x, $x, $speed, false);		twnY  = new Tween( baubleMc, "_y", Strong.easeInOut, baubleMc._y, $y, $speed, false);		twnR  = new Tween( baubleMc, "_rotation", Strong.easeInOut, baubleMc._rotation, $rot, $speed, false);		twnA  = new Tween( baubleMc, "_alpha", Strong.easeInOut, baubleMc._alpha, $alph, $speed, false);		//twnXS = new Tween( baubleMc, "_xscale", Strong.easeInOut, baubleMc._xscale, $scale, $speed, false);		//twnYS = new Tween( baubleMc, "_yscale", Strong.easeInOut, baubleMc._yscale, $scale, $speed, false);				twnA.onMotionFinished = Delegate.create(this, fadeInCallBack);	}		//------- Getters / Setters -------//	// Called by baubles.BaubleControl.as		// For use in situations where the bauble is connected to a navigation item	public function associateSisterWithBtn ( $sisterBtn:TextBtn ):Void { sisterBtn = $sisterBtn; };		private function setMaskIfItExists (  ):Void	{		if(xmlObj.maskMc != undefined && xmlObj.maskMc != "none")		{			baubleMc.setMask( baubleCon.getMaskMc( xmlObj.maskMc ) );		}	}		//------- Getters / Setters -------//	public function getImageHolder     (  ):MovieClip { return baubleHolderMc; };	public function getUniqeName       (  ):String	  { return uniqueName };	public function getFileToLoad      (  ):MovieClip { return xmlObj.file; };	public function getLoadCallBack    (  ):MovieClip { return xmlObj.loadedCallBack; };	public function getFadeCallBack    (  ):MovieClip { return xmlObj.fadedCallBack; };	public function getAnimateCallBack (  ):MovieClip { return xmlObj.animationDoneCallBack; };		// Called from BaubleControl.as	public function setEvents	       (  ):Void	{		if( xmlObj.clickable != "false" )		{			// See if there is a hit area other than the whole bauble			var mc:MovieClip = ( baubleHolderMc.dummyHitArea == undefined )? baubleMc : baubleHolderMc.dummyHitArea;						if( xmlObj.useHandCursor == "false" ) 				mc.useHandCursor = false;						mc.con = this;			mc.onRelease = function(){ this.con.Release(); };			mc.onRollOver = function(){ this.con.RollOver(); };			mc.onRollOut = function(){ this.con.RollOut(); };			}	}}