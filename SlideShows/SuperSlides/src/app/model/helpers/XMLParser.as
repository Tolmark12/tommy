package app.model.helpers
{
	
import app.model.vo.*;

public class XMLParser extends Parser
{

	/** 
	*	Parse the xml, creating all the slide value objects
	*	@param		An xml object
	*/
	public function parseXML ( $xml:XML ):void
	{
		var len:uint = $xml.slides.slide.length();
		for ( var i:uint=0; i<len; i++ ) 
		{
			// Create SlideVO
			var slide:SlideVO = new SlideVO();
			slide.slideIndex = i;
			slide.slots = _createSlotDataVOs( $xml.slides.slide[i], XML($xml.template) )
			slideList.push(slide);
		}
		
		templateSlots = new Array()
		// Create Slots Template
		for each( var node:XML in $xml.template.children())
		{
			
			var slotTemplateVO  		= new SlotTemplateVO();
			slotTemplateVO.x    		= node.@x;
			slotTemplateVO.y    		= node.@y;
			slotTemplateVO.id   		= node.name().localName;
			slotTemplateVO.kind 		= node.@kind;
			slotTemplateVO.width		= (String( node.@width ).length == 0)? 100 : node.@width ;
			slotTemplateVO.inNavDrawer	= (String( node.@inNavDrawer ).length == 0 )? false : node.@inNavDrawer ;
			slotTemplateVO.isHidden		= (String( node.@initially_hidden).length == 0)? false : node.@initially_hidden;
			
			templateSlots.push( slotTemplateVO );
		}
		
		staticContent = _createSlotDataVOs( XML( $xml.staticContent ), XML( $xml.template ))
		
	}
	
	
	private function _createSlotDataVOs ( $slotData:XML, $slotTemplate:XML ):Object
	{
		var slotObj:Object = new Object();
		var len:uint = $slotData.children().length();
		for ( var j:uint=0; j<len; j++ ) 
		{
			var item:XML 				= $slotData.children()[j];
			var itemId:String			= item.name().localName;
			var template:XML			= XML( $slotTemplate[itemId] );

			switch ( String( template.@kind ) )
			{
				case "image" :
					var slotImageVo:SlotImageVO = new SlotImageVO();
					slotImageVo.slotId 		= itemId;
					slotImageVo.kind		= template.@kind;
					slotImageVo.src 		= item.@src;
					slotImageVo.href 		= item.@href;
					slotObj[itemId]			= slotImageVo;
				break;
				
				case "text" :
					var slotTextVo:SlotTextVO 	= new SlotTextVO();
					slotTextVo.slotId 			= itemId;
					slotTextVo.kind				= template.@kind;
					slotTextVo.text 			= item.p.children().toXMLString();
					slotTextVo.text 			= slotTextVo.text.replace(/\n/g, "");	// Remove hard returns
					slotTextVo.text 			= slotTextVo.text.replace(/\s/g, " ");	// Quirk with xml, replace spaces with real spaces
					slotObj[itemId]				= slotTextVo;
				break;
			}
		}
		
		return slotObj;
	}

}

}