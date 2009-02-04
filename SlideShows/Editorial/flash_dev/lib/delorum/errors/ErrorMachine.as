package delorum.errors
{

import delorum.util.JavaTrace;
import flash.display.Stage;
/**
 *	This class is used to report errors or other messages independent
 *	of how the swf has been deployed. For instance, if the swf has been
 *	embedded in an html page, the errors and messages are sent as Javascript
 *	alerts; When deployed to the flash runtime, as flash trace statements.
 *	
 *	@example
 *	<listing version="3.0">
 *	
 *	// Determine what mode to output errors and messages
 *	ErrorMachine.setErrorModeAutomatically( this.stage );
 *	// or, to set the error mode manually... 
 *	// ErrorMachine.errorMode = ErrorMachine.FLASH;
 *	
 *	// Add a sample error
 *	ErrorMachine.addErrorToLog( "This is a fake error." );
 *	// Print all errors
 *	ErrorMachine.printErrors();
 *	// Outputs:
 *	// >> Errors
 *	// This is a fake error.
 *	// << End
 *
 *	
 *	</listing>
 *	
 *	@language ActionScript 3, Flash 9.0.0
 *	@author   Mark Parson, 24.03.2008
 *	@rights	  Copyright (c) Delorum inc. 2008. All rights reserved	
 */


public class ErrorMachine
{
	// Error modes
	/** Error Mode: For testing in flash */
	public static const FLASH:String		= "flash";
	/** Error Mode: Quiet, does not print any errors */
	public static const QUIET:String 		= "quiet";
	/** Error Mode: For testing on web, uses javascript alert*/
	public static const WEB:String 			= "web";
	/** Error Mode: For saving errors to a log (not implemented yet) */
	public static const LOG:String 			= "log";
	

	/**	Set the errorMode to indicate how errors should be reported 
	*	
	*	@default    ErrorMachine.QUIET 							 */
	public static var errorMode:String		= QUIET;

	/**	@private 	Store Messages here for later output */ 
	private static var _messageLog:Array 	= new Array();
	/**	@private 	Store Errors here for later output */ 
	private static var _errorLog:Array 		= new Array();
	
	
	// ______________________________________________________________ PUBLIC FUNCTIONS
	/** Add message to the message log 
	* 	@param		Message to be added to the log*/
	public static function addMessageToLog ( $m:String ):void
	{
		_messageLog.push( $m );
	}

	/** Add error to log 
	* 	@param		Error*/
	public static function addErrorToLog ( $e:String ):void
	{
		_errorLog.push( $e );
	}
	
	/** Similar to the trace function, traces immediately 
	* 	@param		Message
	* 	@param		Error Mode [FLASH, QUIET, WEB, WEB_ALERT, LOG] */
	public static function print ( $str:String, $emode:String = null  ):void
	{
		outputMessage( $str, $emode );
	}
	
	/** Automatically detect if flash is embedded in html, and set error mode appropriately 	*/
	public static function setErrorModeAutomatically ( $stage:Stage ):void
	{
		errorMode = ( isOnWeb( $stage ) )? ErrorMachine.WEB : ErrorMachine.FLASH 
	}
	
	/** 
	*	@return		Returns <code>true</code> if swf is embedded in html
	*/
	public static function isOnWeb ( $stage:Stage ):Boolean
	{
		return ( $stage.loaderInfo.url.indexOf("http://") == 0 )? true : false;
	}
	
	
	/** Prints all Errors in log 
	* 	@param		Error Mode [FLASH, QUIET, WEB, WEB_ALERT, LOG] */
	public static function printErrors ( $emode:String = null ):void
	{	
		if( _errorLog.length != 0 ) 
		{
			outputMessage(  getErrorsAsString(), $emode );
		}
	}
	
	/** Prints all messages in the log 
	* 	@param		Error Mode [FLASH, QUIET, WEB, WEB_ALERT, LOG] */
	public static function printMessages ( $emode:String = null ):void
	{
		if( _messageLog.length != 0 ) 
		{
			outputMessage(  getMessagesAsString(), $emode );
		}
	}
	
	/** @private 	Send message to output receiver
	* 	@param		Message
	* 	@param		Error Mode [FLASH, QUIET, WEB, WEB_ALERT, LOG] */
	private static function outputMessage( $str:String,  $emode:String = null ):void
	{
		// If no error mode sent, use the static errorMode
		$emode = ( $emode == null )? errorMode : $emode ;
		
		if( $str.length != 0 ) 
		{
			switch( $emode )
			{
				case QUIET:
				  // Do nothing
				break
			
				case FLASH:
				  trace( $str );
				break
			
				case WEB:
				  JavaTrace.confirm( $str );
				break
			
				case LOG:
					// Nothing here yet :-D
				break
				default :
				
				break
			}
		}
		
	}
	
	public static function get errorLog 	(  ):Array{ return _errorLog; };
	public static function get messageLog 	(  ):Array{ return _messageLog; };
	
	// ______________________________________________________________ PRIVATE parsers
	/** 
	*	@private 	Returns all errors as a String
	*	
	*	@return		Returns contents of Error Log
	*/
	
	private static function getErrorsAsString():String
	{
		var newLine:String 		= (errorMode == WEB)? "\n" : "\n";
		var lineStart:String	= ""
		var preamble:String		= ">> Errors" + newLine;
		var conclusion:String	= "<< End";
		
		var str:String = preamble;
		var len:Number = _errorLog.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			str += lineStart + _errorLog[ i ] + newLine;
		}
		return str + conclusion;
	}
	
	/** 
	*	@private	Parse all messages into a string 
	*	
	*	@return		Returns contents of Message Log
	*/
	private static function getMessagesAsString():String
	{
		var newLine:String 		= (errorMode == WEB)? "\n" : "\n";
		var lineStart:String	= ""
		var preamble:String		= ">> Message Log" + newLine;
		var conclusion:String	= "<< End";
		
		var str:String = preamble;
		var len:Number = _messageLog.length;
		for ( var i:Number=0; i<len; i++ ) 
		{
			str += lineStart + _messageLog[ i ] + newLine;
		}
		return str + conclusion;
	}
}

}