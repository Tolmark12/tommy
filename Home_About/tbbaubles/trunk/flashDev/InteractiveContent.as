﻿import nav.SideNav;import baubles.BaubleControl;class InteractiveContent{	private var sideNav:SideNav;	private var baubleHolder:MovieClip;	private var baubleCon:BaubleControl;		public function InteractiveContent( $navMc:MovieClip, 										$baubleHolder:MovieClip,										$altBaubleMc:MovieClip,										$mainCon )	{		baubleCon = new BaubleControl( $baubleHolder, $altBaubleMc );	}		public function registerBaubleMasks ( $ar:Array ):Void	{		baubleCon.registerBaubleMasks( $ar );	}		public function setXmlInfo( $xmlObj, $navMc:MovieClip ):Void	{		baubleCon.initBaubles( $xmlObj.baubles );		sideNav = new SideNav( $xmlObj.nav, $navMc, baubleCon );	}		public function getBaubleCon  (  ):BaubleControl { return baubleCon; };}