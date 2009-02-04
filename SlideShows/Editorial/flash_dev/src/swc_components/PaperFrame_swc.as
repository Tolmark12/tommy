package swc_components
{
	
import flash.display.MovieClip;

public class PaperFrame_swc extends MovieClip
{
	// Black border around photos. This is a transparent png.
	// place photos behind this movie clip to create illusion
	// of a black border.
	private var _blackFrameMc:MovieClip;
	
	public function PaperFrame_swc()
	{
		// Declare assets placed on the stage in the Flash IDE
		_blackFrameMc = getChildByName("frameMc") as MovieClip;
	}
	
	public function moveFrameToFront (  ):void
	{
		setChildIndex(_blackFrameMc, this.numChildren - 1);
	}

}
}