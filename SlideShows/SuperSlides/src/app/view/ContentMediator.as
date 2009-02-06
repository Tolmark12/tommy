package app.view
{
import org.puremvc.as3.multicore.interfaces.*;
import org.puremvc.as3.multicore.patterns.mediator.Mediator;
import org.puremvc.as3.multicore.patterns.observer.Notification;
import app.AppFacade;
import app.model.vo.*;
import app.view.components.*;
import SuperSlides;
import flash.display.Sprite;

public class ContentMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "content_mediator";
	
	private var _root:SuperSlides;
	private var _slotHolder:Sprite 	= new Sprite();
	private var _slotObj:Object 	= new Object;

	public function ContentMediator( $root:SuperSlides ):void
	{
		super( NAME );
   		_root = $root;
		_root.addChild(_slotHolder);
	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ AppFacade.INIT_SLOTS, 
		 		 AppFacade.POPULATE_SLOTS, ];
	}
	
	// PureMVC: Handle notifications
	override public function handleNotification( note:INotification ):void
	{
		switch ( note.getName() )
		{
			case AppFacade.INIT_SLOTS:
				_createSlots( note.getBody() as Array );
			break;
			
			case AppFacade.POPULATE_SLOTS :
				_populateSlots( note.getBody() as Object)
			break;
		}
	}
	
	
	/** 
	*	Build the slot objects
	*	@param		A list of slot value objects.
	*/
	private function _createSlots ( $slots:Array ):void
	{
		var newSlot:Slot;
		var len:uint = $slots.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var vo:SlotTemplateVO = $slots[i];
			switch (vo.kind) {
				case "image" :						// Image
					var img:Image = new Image();
					newSlot = img;
				break;
				
				case "text" :						// Text
					var txt:Txt = new Txt();
					newSlot = txt;
				break;
			}
			
			// Position and ID
			_slotObj[vo.id] = newSlot;
			newSlot.x  = vo.x;
			newSlot.y  = vo.y;
			newSlot.id = vo.id;
			_slotHolder.addChild(newSlot)
		}
	}
	
	/** 
	*	Populate slots with content
	*/
	private function _populateSlots ( $slots:Object ):void
	{
		for( var i:String in $slots )
		{
			switch ( $slots[i].kind ){
				case "image" :
					var slotImageVo:SlotImageVO = $slots[i];
					var img:Image = _slotObj[i] as Image;
					img.loadImage( "content/images/test_image.jpg" );
				break;
				case "text" :
					
				break;
			}
		}
	}
	
}
}