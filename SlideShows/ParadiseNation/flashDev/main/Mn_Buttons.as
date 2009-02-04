import util.*;
import mvc.*;
import main.*;

class Mn_Buttons extends AbstractView
{
	//TEMP
	public var onKeyDown:Function;
	//TEMP
	
	private var playBtn		:MovieClip;
	private var pauseBtn	:MovieClip;
	private var nextBtn		:MovieClip;
	private var prevBtn		:MovieClip;
	private var resetBtn	:MovieClip;

	
	public function Mn_Buttons ( $m:Observable, $c:Controller,   $btnsMc:MovieClip )
	{
		super($m, $c);
		TEMP_setEvenTriggers();
		setButtonEvents( $btnsMc );
	}
	
	private function setButtonEvents ( $btnsMc:MovieClip ):Void
	{
		
		
		playBtn   = $btnsMc.playBtn;
		pauseBtn  = $btnsMc.pauseBtn;
		prevBtn   = $btnsMc.prevBtn;
		nextBtn   = $btnsMc.nextBtn;
		resetBtn  = $btnsMc.resetBtn;
		
		
		playBtn.con   = this;
		pauseBtn.con  = this;
		prevBtn.con   = this;
		nextBtn.con   = this;
		resetBtn.con  = this;
		
		playBtn.onPress = function()
		{
			this.con.getController().click('play');
		}
		pauseBtn.onPress = function()
		{
			this.con.getController().click('pause');
		}
		prevBtn.onPress = function()
		{
			this.con.getController().click('prev');
		}
		nextBtn.onPress = function()
		{
			this.con.getController().click('next');
		}
		resetBtn.onPress = function()
		{
			this.con.getController().click('reset');
		}
		
	}
	
	private function TEMP_setEvenTriggers (  ):Void
	{
		Key.addListener(this);
		this.onKeyDown = function()
		{
			switch( Key.getCode() )
			{
				case 32: // Play
				  getController().click('play');
				break
			
				case 37: // Prev
				  getController().click('prev');
				break
			
				case 39: // Next
				  getController().click('next');
				break
			}
		}
	}
	
	// ---------- Update from Model's broadcast ---------- //
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info:Mn_UpdateVO = Mn_UpdateVO($infoObj);
		if( info.command == 'start' || info.command == 'first' )
		{
			playBtn._visible  = false;
			pauseBtn._visible = true;
		}
		else if( info.command == 'stop' || info.command == 'prev' || info.command == 'next' ) 
		{
			playBtn._visible  = true;
			pauseBtn._visible = false;
		}
	}

	// ---------- Bind the Controller to this View ---------- //
	//public function defaultController (model:Observable):Controller { return new YourControllersClassName(model); }
}