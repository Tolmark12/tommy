import mvc.MvcWrapper;
import tools.mix.detail_area.*;


class tools.mix.detail_area.DetailArea extends MvcWrapper
{
	private var detailModel			:DetailAreaModel;
	private var control				:DetailAttributesControl;
	private var bigImage			:DetailAreaBigImage;	// Display - Large display photo
	private var prodAttributes		:DetailAreaAttributes; 	// Display - Controls for editing attributes
	
	public function DetailArea( $mc:MovieClip )
	{
		var bigImageMc :MovieClip = $mc.createEmptyMovieClip('bigImageMc', 1);
		var attribuetMc:MovieClip = $mc.createEmptyMovieClip('attributeMc', 2);
	
		// Model
		detailModel = new DetailAreaModel();
		                 
		// Control       
		control		= new DetailAttributesControl( detailModel )
		                 
		// Views         
		bigImage 	= new DetailAreaBigImage( detailModel, control, 
						   			   		  bigImageMc );
		                 
		prodAttributes = new DetailAreaAttributes( detailModel, control,
			 										attribuetMc )

		detailModel.addObserver( bigImage );
		detailModel.addObserver( prodAttributes );
		
		super.setModel( detailModel );
	}

}