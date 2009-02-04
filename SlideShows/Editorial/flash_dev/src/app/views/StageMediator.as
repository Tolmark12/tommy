package app.views
{
import flash.display.Sprite;

import org.puremvc.as3.multicore.interfaces.IMediator;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;

public class StageMediator extends Mediator implements IMediator
{
	public static const NAME:String 	= "stage_mediator";
	
	/** MainSlide Sprite object */
	private var _mainSlide:PaperFrame_swc;
	
	/** side thumbnail preview Sprite object */
	private var _thumbnails:Sprite;
	
	/** paper clip containing slide info */
	private var _slideInfo:PaperTag_swc;
	
	public function StageMediator( $stage:Sprite )
	{
		super(NAME, $stage);
		_initMainSlide();
		_initThumbnails();
		_initInfo();
	}
	
	/** return stage instance */
	public function get stage() : Sprite
	{
		return this.getViewComponent() as Sprite;
	}
	
	/** return mainSlide view component */
	public function get mainSlide():PaperFrame_swc
	{
		return _mainSlide;
	}
	
	/** return thumbnail view component */
	public function get thumbnails() : Sprite
	{
		return _thumbnails;
	}
	
	public function get info():PaperTag_swc
	{
		return _slideInfo;
	}
	
	/** load MainSlide container on stage */
	private function _initMainSlide() :void
	{
		_mainSlide = new PaperFrame_swc();
		stage.addChild(_mainSlide);
	}
	
	/** load thumbnails container on stage */
	private function _initThumbnails() :void
	{
		_thumbnails = new Sprite();
		stage.addChild(_thumbnails);
		_thumbnails.x = 410;
		_thumbnails.y = 25;
	}
	
	private function _initInfo():void
	{
		_slideInfo = new PaperTag_swc();
		_slideInfo.x = 10;
		_slideInfo.y = 340;
		stage.addChild(_slideInfo);
		
	}
	
}
}