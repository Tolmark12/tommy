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
import flash.events.*;

public class ContentMediator extends Mediator implements IMediator
{	
	public static const NAME:String = "content_mediator";
	
	private var _root:SuperSlides;
	private var _nav:NavDrawer_swc;
	private var _slotHolder:Sprite 		= new Sprite();
	private var _slotObj:Object 		= new Object;
	private var _hiddenSlots:Array 		= new Array();

	public function ContentMediator( $root:SuperSlides ):void
	{
		super( NAME );
   		_root = $root;
		_nav = _root.navMc;
		_root.addChild(_slotHolder);
		_slotHolder.addEventListener( Image.IMAGE_LOADED, _onImageLoaded, false,0,true );
	}
	
	// PureMVC: List notifications
	override public function listNotificationInterests():Array
	{
		return [ AppFacade.INIT_SLOTS, 
		 		 AppFacade.POPULATE_SLOTS,
		 		 AppFacade.SHOW_HIDDEH_ITEMS, ];
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
			
			case AppFacade.SHOW_HIDDEH_ITEMS :
				_showHiddenItems()
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
					var txt:Txt = new Txt(vo.width);
					newSlot = txt;
				break;
			}
			
			// Position and ID
			_slotObj[vo.id] = newSlot;
			newSlot.x  = vo.x;
			newSlot.y  = vo.y;
			newSlot.id = vo.id;
			
			// If hidden, hide
			if( vo.isHidden ) {
				_hiddenSlots.push(newSlot)
				newSlot.hide();
			}
			
			// Add to the correct parent
			if( vo.inNavDrawer ) 
				_nav.addChild(newSlot);
			else
				_slotHolder.addChild(newSlot)
		}
	}
	
	/** 
	*	Populate slots with content
	*	@param		A list of slot objects
	*/
	private function _populateSlots ( $slots:Object ):void
	{
		for( var i:String in $slots )
		{
			// 1) Determine what kind of slot we have (switch statement)
			// 2) Grab the slot component with the same id 
			// 3) Fill that slot component with the new content 
			switch ( $slots[i].kind ){
				case "image" : 											// Image
					var slotImageVo:SlotImageVO = $slots[i];
					var img:Image = _slotObj[i] as Image;
					img.loadImage( slotImageVo.src, slotImageVo.href );
				break;
				case "text" : 											// Text
					var slotTextVo:SlotTextVO = $slots[i];
					var txt:Txt = _slotObj[i] as Txt;
					txt.text = slotTextVo.text;
				break;
			}
		}
	}
	
	/** 
	*	We need to have some slots remaion hidden until other slots have loaded. 
	*	Therefore, when we create a slot, if it is to be hidden, we will hide it
	*	until a slot is filled whose content is marked NOT hidden. At that point, 
	*	we will show all the slots that ARE marked hidden. 
	*/
	private function _onImageLoaded ( e:Event ):void
	{
		var img:Image =  e.target as Image;
		if( !img.isInitiallyHidden ){
			// Stop listening for image loads
			_slotHolder.removeEventListener( Image.IMAGE_LOADED, _onImageLoaded );
			sendNotification( AppFacade.SHOW_HIDDEH_ITEMS );
		} 
	}
	
	private function _showHiddenItems (  ):void
	{
		// Show all hidden content
		var len:uint = _hiddenSlots.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			var slot:Slot = _hiddenSlots[i];
			slot.show();
		}
	}
	
}
}