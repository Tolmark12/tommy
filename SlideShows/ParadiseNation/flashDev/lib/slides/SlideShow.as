// Created by Mark Parson on 2007-09-06.
// Copyright (c) Coal Interactive 2007. All rights reserved.
//
// -------- Required classes -------- //
// mx.transitions.Tween;
// mx.transitions.easing.*;
// mvc.*;
// util.*;
// lib.loadManager.*
// lib.slides.*
//
// -------- Description -------- //
// An engine for a simple slideshow
// 
// -------- Sample Code -------- //
/*

	import lib.slides.SlideShow;
	
	//---- Basic Implementation ----//
	slideShow = new SlideShow( mc, 'path/' );		// $mc - holder movieClip, 'path/' - String where images are located
	slideShow.setTiming ( 3, 1 );					// Seconds, first is time to display image, second is transition duration
	slideShow.createSlideShow ( $xml.photos ); 		// { 01:{file:"image.jpg", imageText:"<p>some text</p>"}, 02:{..}, 03{..} }
	
	//---- Optional commands ----//
	slideShow.addObserverToModel ( this );			// Optional, Add this to an extention of "AbstractView.as" to receive the model's updates
	slideShow.issueCommand 	  ( command );			// 'start', 'stop', 'next', 'prev', 'first'
	slideShow.nextSlide ();                         // Next slide
	slideShow.prevSlide ();                         // Goto previous Slide
	slideShow.pause 	();                         // Stop Slide Show
	slideShow.start 	();                         // Start Slide Show
	slideShow.reset		();                         // Goto begining of Slide Show
	slideShow.getCurrentSlide ();					// Returns: lib.slides.Slide
	slideShow.getTotalSlides  ();					// Returns: Number
	slideShow.getSlideByIndex ( $ind );				// Returns: lib.slides.Slide
	
	//---- Todo ----//
	// Allow slideshow from array and comma-delimited string : createSlideShowFromString ()
	// Give option to not play slideshow 
	// Give the option to pre-load the images in a queue instead of as requested
	
*/
//

import mvc.MvcWrapper;
import lib.slides.*


class SlideShow extends MvcWrapper
{
	private var model	:SS_Model;
	private var control	:SS_Control;
	private var view	:SS_View;
	
	public function SlideShow( $mainMc	  :MovieClip, 
							   $imagePath :String )
	{
		model 	= new SS_Model	( $imagePath );
		control	= new SS_Control( model );
		view	= new SS_View	( model, control,    $mainMc );
	 	
		model.addObserver( view );
	}
	
	public function setTiming( $len:Number,			// Number of seconds to show each image
							   $spd:Number ):Void	// Length of transition
	{
		model.setDisplayTime	( $len * 1000 + $spd * 1000 );
		view.setTransitionSpeed ( $spd );
	}
	
	public function createSlideShow ( $obj:Object ):Void
	{
		model.createSlideShow($obj);
	}
	
	public function createSlideShowFromString (  ):Void
	{
		// Include the option to just pass a comma-delimited list of files
	}
	
	public function issueCommand ( $cmd ):Void
	{
		switch( $cmd )
		{
			case 'start':
			  start();
			break
			case 'stop':
			  pause();
			break
			case 'next':
			 nextSlide();
			break
			case 'prev':
			  prevSlide();
			break
			case 'first':
			  reset();
			break
		}
		
	}
	
	// ---------- Called from the outside world to control the slideshow ---------- //
	public function nextSlide (  ):Void
	{
		model.stopSlideShow();
		model.nextSlide();
	}   
	
	public function prevSlide (  ):Void
	{
		model.stopSlideShow();
		model.previousSlide();
	}
	
	public function pause (  ):Void
	{
		model.stopSlideShow();
	}
	
	public function start (  ):Void
	{
		model.startSlideShow();
	}
	
	public function reset(  ):Void
	{
		model.startSlideShow();
		model.firstSlide();
	}
	public function getCurrentSlide (  ):Slide
	{
		return model.getCurrentSlide();
	}
	
	public function getSlideByIndex ( $ind ):Slide
	{
		return model.getSlideByIndex($ind)
	}
	
	public function getTotalSlides (  ):Number
	{
		return model.getTotalSlides();
	}
	
	public function setImagePath ( $path:String ):Void
	{
		model.setImagePath($path)
	}
}


