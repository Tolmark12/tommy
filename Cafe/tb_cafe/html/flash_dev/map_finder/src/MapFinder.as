package 
{
import flash.display.Sprite;
import flash.display.MovieClip;
import map.MapFacade;
public class MapFinder extends Sprite 
{
	private var _mapFacade:MapFacade;

	public function MapFinder() 
	{
		_mapFacade = MapFacade.getInstance( "map_facade" );
		_mapFacade.startup( this );
		//var map:UsaMap = new UsaMap();
		//this.addChild(map);
		//map.build();
	}
}
}
