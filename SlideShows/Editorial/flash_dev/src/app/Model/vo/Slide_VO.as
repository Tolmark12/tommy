package app.Model.vo
{

public class Slide_VO
{
	public static const TYPE_MOVIE:String	= "movie";
	public static const TYPE_IMAGE:String	= "image";
	
	/** unique id */
	public var slideId:String;
	
	/** number assigned by order */
	public var slideIndex:uint;
	
	/** title */
	public var title:String;
	
	/** publication date */
	public var date:String;
	
	/** the body or info for the slide */
	public var blurb:String;
	
	/** link to magazine location */
	public var magazineLink:String;
	
	/** label for anchor reference */
	public var magazineLinkText:String;
	
	/** type of window to open */
	public var magazineLinkTarget:String;
	
	/** link to product */
	public var productLink:String;
	
	/** label for anchor reference */
	public var productLinkText:String;
	
	/** type of window to open */
	public var productLinkTarget:String;
	
	/** movie or image type */
	public var mediaType:String
	
	/** path to thumbnail image */
	public var thumbnailPath:String;
	
	/** path to image displayed in paper frame */
	public var main:String;
	
	/** path to image loaded by browser */
	public var fullImagePath:String
	
}

}