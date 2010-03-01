// Created by Mark Parson on 2007-08-17.
// Copyright (c) Coal Interactive 2007. All rights reserved.
// -------- Required packages -------- //
// util (Observable.as and Observer.as)
// 
// -------- Description -------- //
// Creates an extendable class that wraps the mvc triad, importantly adding the 
// ability for an external "Observer" (probably a View) to receive the model's 
// update() broadcsts.
// 
// -------- Sample Code -------- //
// ## Sample class constructor
// public function MyWrapper (  )     
// {
//    browserModel = new MyModell();
//    super.setModel( browserModel );
// }
// 
// ## Sample call
// var MyWrapper = new MyWrapper();
// MyWrapper.addObserverToModel( someObserverView );

import util.*;

class mvc.MvcWrapper
{
	private var model:Observable;
	
	public function MvcWrapper()
	{
		
	}
	
	public function addObserverToModel ( $o:Observer ):Void
	{
		 model.addObserver( $o );
	}
	
	public function setModel ( $model:Observable ):Void
	{
		model = $model;
	}
	
	public function setBroadcastId ( $id:String ):Void
	{
		model.setBroadcastId($id);
	}
	
	public function getModel (  )
	{
		return model;
	}
	
}