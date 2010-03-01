import mvc.*;
import util.*;
import tools.mix.detail_area.*;

class DetailAttributesControl extends AbstractController
{
	
	public function DetailAttributesControl($o:Observable)
	{
		super($o);
	}
	
	// Called when an attribute changes
	public function attributeClick (  $name:String, $newValue:String, $valIndex:Number ):Void
	{
		var model:DetailAreaModel = DetailAreaModel( getModel() );
		switch( $name )
		{
			case 'AddToBag':
				break
			
			case 'Colors':   
				model.setCurrentItemAttribute( $name, $newValue, $valIndex  );
				break;                               
			                                         
			case 'Size':
				model.setCurrentItemAttribute( $name, $newValue, $valIndex  );
				break;                         
			                                   
			case 'Quantity':
				model.setCurrentItemAttribute( $name, $newValue, $valIndex  );
				break;
		}
	}
	
	// Called when taggling between viewing product info and product controls
	public function displayBtnClick ( $action:String ):Void
	{
		var model:DetailAreaModel = DetailAreaModel( getModel() );
		switch( $action )
		{
			case 'info':
			  model.showProductInfo();
			break;
			
			case 'controls':
			  model.showProductControls();
			break;
		}
	}
}