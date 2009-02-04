package app.model {

	import asunit.framework.TestCase;
	import app.AppFacade;
	import app.model.vo.Slide_VO;

	public class SlidesProxyTest extends TestCase {
		private var instance:SlidesProxy;
		private var _appFacade:AppFacade;

		public function SlidesProxyTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			
			// Test sample xml
			var xml:String =
			"<MAIN>" + 
			"<slides imagePath=\"flash_loads/images/\">" + 
				"<slide>" + 
					"<main_img>temp_image_1.jpg</main_img>" + 
					"<thmb_img>temp_image_1_thmb.jpg</thmb_img>" + 
					"<text><h1>header</h1><p>my text</p><p>my text2</p></text>" + 
				"</slide>" + 
				"<slide>" + 
					"<main_img>temp_image_2.jpg</main_img>" + 
					"<thmb_img>temp_image_2_thmb.jpg</thmb_img>" + 
					"<text>" + 
						"<p>Phasellus non lorem vel elit consectetuer egestas. Curabitur vitae sem sit amet nisi fermentum molestie. Morbi vel lacus. Vivamus massa. Aliquam accumsan tempus purus. Suspendisse molestie eros a massa. Proin at ante vel turpis bibendum convallis. Donec quis dolor. Integer eu nisi. Aliquam dapibus scelerisque justo. Fusce sem. Nulla sed mauris sit amet erat rutrum venenatis. Vestibulum mi. Nam ut orci.</p>" + 
						"<p>Integer rhoncus tellus sit amet nibh. Maecenas pellentesque tincidunt elit. Ut sem lorem, commodo sit amet, accumsan eget, condimentum et, nulla. Suspendisse potenti. In leo sem, condimentum at, laoreet vitae, suscipit vel, lectus. Ut ullamcorper lacus eu nunc dapibus vulputate. Proin porta erat vel ante. porttitor.</p>" + 
					"</text>" + 
				"</slide>" + 
			"</slides>" + 
			"</MAIN>" ;
			
			// create test facade
			_appFacade = AppFacade.getInstance( 'app_facade' );
			_appFacade.registerProxy( new SlidesProxy( XML(xml) ) );
			instance = _appFacade.retrieveProxy( SlidesProxy.NAME ) as SlidesProxy;
			instance.createSlidesFromXml();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
			_appFacade = null;
		}

		//////////////////////////////////////////////////////
		// Total Slides should be (2) based on the test xml //
		//////////////////////////////////////////////////////
		
		public function testInstantiated():void {
			assertTrue("instance is SlidesProxy", instance is SlidesProxy);
		}
		
		public function testInitCorrectly():void {
			assertTrue("Initial slide index should default to 0, it is: " + instance.currentSlideIndex, instance.currentSlideIndex == 0);
			assertTrue("Initial number of slides should be 2, it is:" + instance.totalSlides, instance.totalSlides == 2);
		}

		public function testIncramentingSlides (  ):void
		{
			instance.incramentSlideIndex(1);
		    assertTrue("Incrament Slides", instance.currentSlideIndex == 1);
		    instance.incramentSlideIndex(1);
		    assertTrue("Incrament Slides beyond total", instance.currentSlideIndex == 1);
			instance.incramentSlideIndex(-1);
		    assertTrue("Incrament Slides with negative number", instance.currentSlideIndex == 0);
		    instance.incramentSlideIndex(20);
		    assertTrue("Incrament Slides above total", instance.currentSlideIndex == 1);
			instance.incramentSlideIndex(-10);
		    assertTrue("Incrament Slides beneath 0", instance.currentSlideIndex == 0);
		}
		
		public function testSettingSlideIndex (  ):void
		{
			instance.changeSlide(1);
			assertTrue("Setting slides inside range: " + instance.currentSlideIndex, instance.currentSlideIndex == 1);
			instance.changeSlide(0);
			assertTrue("Setting slides inside range 2", instance.currentSlideIndex == 0);
			instance.changeSlide(10);
			assertTrue("Attempt set slide index outside allowed range", instance.currentSlideIndex == 1);
		}
		
		public function testSlideData (  ):void
		{
			var slide:Slide_VO = instance.currentSlide;
			assertTrue("Slide image path should be 'flash_loads/images/temp_image_1.jpg', it is: " + slide.largeImagePath, slide.largeImagePath == "flash_loads/images/temp_image_1.jpg");
			assertTrue("Slide thumbnail path should be 'flash_loads/images/temp_image_1_thmb.jpg', it is: " + slide.thumbnailPath, slide.thumbnailPath == "flash_loads/images/temp_image_1_thmb.jpg");
			assertTrue("Slide description should be '<h1>header</h1>\n<p>my text</p>\n<p>my text2</p>', it is: " + slide.description  + '  :  ' + slide.largeImagePath, slide.description == "<h1>header</h1>\n<p>my text</p>\n<p>my text2</p>");
		}
	}
}