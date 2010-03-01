import util.*;
import mvc.*;
import tools.mix.browser.Browse;
import tools.mix.save_look.SaveTheLook;
import tools.mix.detail_area.DetailArea;
import tools.mix.main.*
import lib.product.ItemRepository;

class MainDisplay extends AbstractView
{
	private var topBrowser	   :Browse;
	private var bottomBrowser  :Browse;
	private var topDetailArea  :DetailArea;
	private var btmDetailArea  :DetailArea;
	private var saveTheLook	   :SaveTheLook;
	private var subView		   :SubBroadcastView;
	
	public function MainDisplay ( $m:Observable, $c:Controller, $mc:MovieClip, $xmlObj:Object )
	{
		super($m, $c);
		buildDisplay( $mc, $xmlObj );
	}
	
	// ________________________________________________________________________ Update from the Model 
	public function update ( $o:Observable, $infoObj:Object )
	{
		var info:Main_UpdateVO = Main_UpdateVO( $infoObj );
		
		// Change Acive items on top and bottom
		topBrowser.getModel().changeActiveItem 	  (info.topItemId);
		bottomBrowser.getModel().changeActiveItem (info.btmItemId);
		
		// Create new items in the item repository
		ItemRepository.newItem( info.topItemId, topDetailArea.getModel(), "showNewItem" );
		ItemRepository.newItem( info.btmItemId, btmDetailArea.getModel(), "showNewItem" );
		
		// Send update to "Save The Look" section 
		saveTheLook.getModel().changeDisplayedItems(info.topItemId, info.btmItemId );
	}
	
	// ________________________________________________________________________ Initial build of all visible items
	private function buildDisplay ( $mc:MovieClip, $xmlObj:Object ):Void
	{
		var topBrowserMc:MovieClip = $mc.createEmptyMovieClip( 'topBrowser', 	2 	);
		var btmBrowserMc:MovieClip = $mc.createEmptyMovieClip( 'bottomBrowser', 3	);
		// On the stage
		var saveLookMc	:MovieClip = $mc.holdTheLookMc;
		var topDetailMc	:MovieClip = $mc.createEmptyMovieClip( 'topDetails', 	5 	);
		var btmDetailMc	:MovieClip = $mc.createEmptyMovieClip( 'bottomDetails', 7	);
		
		// Set any custom positioning
		btmBrowserMc._y	= 280;
		topBrowserMc._y	= 10;
		btmBrowserMc._x = 5
		topBrowserMc._x = 5
		topDetailMc._x 	= 520
		btmDetailMc._x 	= 522;
		topDetailMc._y 	= 67
		btmDetailMc._y 	= 296;
		
		// Add top and bottom broduct browsers
		topBrowser    = new Browse( topBrowserMc, $xmlObj.items.tops  );
	 	bottomBrowser = new Browse( btmBrowserMc, $xmlObj.items.bottoms  );
		saveTheLook	  = new SaveTheLook( saveLookMc );
		topDetailArea = new DetailArea ( topDetailMc );
		btmDetailArea = new DetailArea( btmDetailMc );
		
		// Create View to catch all the model "update()" broadcasts
		// Treat them kind of like button events
		subView = new SubBroadcastView( model );
		topBrowser.setBroadcastId	  ( 'topBrowser'    );
		bottomBrowser.setBroadcastId  ( 'bottomBrowser' );
		saveTheLook.setBroadcastId	  ( 'saveTheLook'   );
		topDetailArea.setBroadcastId  ( 'topDetailArea' );
		btmDetailArea.setBroadcastId  ( 'btmDetailArea' );
		                              
		// Add "subView" to each model's broadcast
		topBrowser.addObserverToModel	 ( subView );
		bottomBrowser.addObserverToModel ( subView );
		saveTheLook.addObserverToModel 	 ( subView );	  	
		topDetailArea.addObserverToModel ( subView );
		btmDetailArea.addObserverToModel ( subView );
		
		// Start the engine
		topBrowser.commence();
		bottomBrowser.commence()
	}
	
	// ________________________________________________________________________ Bind the Controller to this view 
	public function defaultController (model:Observable):Controller { return new MainControl(model); }
	
}
