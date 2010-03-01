// Created by Mark Parson on 2007-10-01.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required classes -------- //
// 
// 
// -------- Description ------------- //
// This triad manages the looks as a series. I am looking forward to
// the point where we may need to scroll through a series of saved looks
// 
// -------- Sample Code ------------- //
//


import mvc.MvcWrapper;
import lib.product.Item;
import tools.mix.save_look.looks.*;

class LookLocker extends MvcWrapper
{
	private var model	  :LL_Model;
	private var view	  :LL_View;
	private var control   :LL_Control;
	
	public function LookLocker( $mc:MovieClip )
	{
		model 	= new LL_Model();
		control = new LL_Control( model );
		view  	= new LL_View( model, control, $mc );
		
		model.addObserver( view );
	}
	
	public function addLook ( $topItemId:String, $btmItemId:String ):Void
	{
		model.addLook($topItemId, $btmItemId);
	}

}