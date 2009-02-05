import caurina.transitions.Tweener;
import mx.utils.Delegate;

class bauble_code.HomeHotPoint
{
	// stage
	private var _root:MovieClip;
	
	// Items on the stage
	private var _mainTxt:MovieClip;
	private var _subTxt:MovieClip;
	private var _box:MovieClip;
	
	// Colors
	private var _boxUp:Number;
	private var _boxOver:Number;

	private var _titleUp:Number;
	private var _titleOver:Number;
	
	private var _subUp:Number;
	private var _subOver:Number;
	
	private var _tntBox:Color;
	private var _tntTitle:Color;
	private var _tntSub:Color;
	
	public function HomeHotPoint( $xml:Object, $root:MovieClip )
	{
		_root    = $root;
		_mainTxt = _root.mainTxt;
		_subTxt  = _root.subTxt;
		_box     = _root.box
		
		_make( $xml );
	}
	
	/** 
	*	Make the hot point
	*	@param		an "xml" object defined in the content xml
	*/
	private function _make ( $xml:Object ):Void
	{
		var hex:String;
		var defaultColor:Number 	= 0xFFFFFF;
		_tntBox		= new Color( _box );
		_tntTitle	= new Color( _mainTxt );
		_tntSub		= new Color( _subTxt );
		
		// Set the colors if they exist
		// UP
		_boxUp 		= ($xml.box.color == undefined)? defaultColor 			: Number( '0x' + $xml.box.color ) ;
		_titleUp 	= ($xml.titleTxt.color == undefined)? defaultColor 		: Number( '0x' + $xml.titleTxt.color ) ;
		_subUp 		= ($xml.subTxt.color == undefined)? defaultColor 		: Number( '0x' + $xml.subTxt.color ) ;
		
		// Over
		_boxOver 	= ($xml.box.colorOver == undefined)? _boxUp 			: Number( '0x' + $xml.box.colorOver ) ;
		_titleOver 	= ($xml.titleTxt.colorOver == undefined)? _titleUp 		: Number( '0x' + $xml.titleTxt.colorOver ) ;
		_subOver 	= ($xml.subTxt.colorOver == undefined)? _subUp		 	: Number( '0x' + $xml.subTxt.colorOver ) ;
		
		// Set the font style
		var frameStyle:Number = ($xml.titleTxt.fontStyle == undefined)? 1 : Number($xml.titleTxt.fontStyle) ;
		_mainTxt.gotoAndStop(frameStyle);
		
		// Set the text
		_mainTxt.titleTxt.text = $xml.titleTxt.text;
		_subTxt.titleTxt.text  = $xml.subTxt.text;
		_mainTxt.titleTxt.autoSize = true;
		_subTxt.titleTxt.autoSize = true;
		
		// Align
		if( $xml.box.align == "left" ) 
		{
			_mainTxt._x = _box._x - 9 - _mainTxt.titleTxt.textWidth
			_subTxt._x = _box._x - 9 - _subTxt.titleTxt.textWidth
		}
		
		if( $xml.subTxt.text.length == 0 || $xml.subTxt.text == undefined ) 
			_subTxt._visible = false;
		
		_changeColor(false);
	}
	
	// ______________________________________________________________ Color
	
	/** 
	*	Change the text color
	*/
	private function _changeColor ( $isOver:Boolean ):Void
	{
		if( $isOver ) {
			_tntBox.setRGB( _boxOver );
			_tntTitle.setRGB( _titleOver );
			_tntSub.setRGB( _subOver );
		}else{
			_tntBox.setRGB( _boxUp );
			_tntTitle.setRGB( _titleUp );
			_tntSub.setRGB( _subUp );
		}
	}
	
	/** 
	*	Change the visiblilty of the text
	*/
	public function _toggleTextVisibility ( $showText:Boolean ):Void
	{
		if( $showText ) 
		{
			_mainTxt._visible = true;
			_subTxt._visible = true;
			Tweener.addTween( _box, {_alpha:100, time:0, transition:"linear" } );
			Tweener.addTween( _mainTxt, {_alpha:100, time:0, transition:"linear" } );
			Tweener.addTween( _subTxt, {_alpha:100, time:0, transition:"linear" } );
		}
		else
		{
			_mainTxt._visible = false;
			_subTxt._visible = false;
			Tweener.addTween( _box, {_alpha:50, time:0, transition:"linear" } );
			Tweener.addTween( _mainTxt, {_alpha:0, time:0, transition:"linear" }  );
			Tweener.addTween( _subTxt, {_alpha:0, time:0, transition:"linear" } );
		}
	}
	
	// ______________________________________________________________ Event Handlers
	
	public function onRollOver (  ):Void
	{
		_changeColor(true);
		_toggleTextVisibility(true);
	}
	
	public function onRollOut (  ):Void
	{
		_changeColor(false);
		_toggleTextVisibility(false);
	}
	
	public function onFadedIn (  ):Void
	{
		Tweener.addTween( _box, {_alpha:50, time:3, transition:"linear" } );
		Tweener.addTween( _mainTxt, {_alpha:0, time:3, transition:"linear", onComplete:Delegate.create(this, _toggleTextVisibility) } );
		Tweener.addTween( _subTxt, {_alpha:0, time:3, transition:"linear"} );
	}
	
}