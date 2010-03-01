package app.model.helpers
{
	
import app.model.vo.*;

public class JsonParser extends Parser
{
	/** 
	*	Parse the json object, creating all the slide value objects
	*	@param		A json object
	*/
	public function parseJson ( $json:Object ):void
	{
		// Loop through each of the slides, and create a SlideVO
		var count:Number = 0;
		var len:uint = $json.slides.length;
		for ( var i:uint=0; i<len; i++ ) 
		{
			// Create SlideVO
			var slide:SlideVO = new SlideVO();
			slide.slideIndex = i;
			slide.slots = _createSlotDataVOs( $json.slides[i], $json.template )
			slideList.push(slide);
		}
		
		templateSlots = new Array()
		// Create Slots Template
		for( var k:String in $json.template )
		{
			var slotTemplateVO  		= new SlotTemplateVO();
			slotTemplateVO.x    		= $json.template[k].x;
			slotTemplateVO.y    		= $json.template[k].y;
			slotTemplateVO.id   		= k;
			slotTemplateVO.kind 		= $json.template[k].kind;
			slotTemplateVO.width		= ($json.template[k].width == null)? 100 : $json.template[k].width ;
			slotTemplateVO.inNavDrawer	= ($json.template[k].inNavDrawer == null )? false : $json.template[k].inNavDrawer ;
			slotTemplateVO.isHidden		= ($json.template[k].initially_hidden == null)? false : $json.template[k].initially_hidden;
			
			templateSlots.push( slotTemplateVO );
		}
		staticContent = _createSlotDataVOs( $json.staticContent, $json.template)
		
	}
	
	
	private function _createSlotDataVOs ( $slotData:Object, $slotTemplate:Object ):Object
	{
		var slotObj:Object = new Object();
		
		// Now create the right kind of slotVO for each slot
		for( var j:String in $slotData )
		{
			// Determine the type of slot by checking the 
			// template slot with this same name
			switch ( $slotTemplate[j].kind  )
			{
				case "image" :
					var slotImageVo:SlotImageVO = new SlotImageVO();
					slotImageVo.slotId 		= j;
					slotImageVo.kind		= $slotTemplate[j].kind
					slotImageVo.src 		= $slotData[j].src;
					slotImageVo.href 		= $slotData[j].href;
					slotObj[j]				= slotImageVo;
				break;
				
				case "text" :
					var slotTextVo:SlotTextVO = new SlotTextVO();
					slotTextVo.kind			= $slotTemplate[j].kind
					slotTextVo.slotId 		= j;
					slotTextVo.text 		= $slotData[j].text;
					slotObj[j]				= slotTextVo;
				break;
			}
		}
		return slotObj;
	}

}

}