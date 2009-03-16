<?

$_GET['id'] = ($_GET['id'])? $_GET['id'] : "0" ;

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" >
    <head>
        <title>Tommy Bahama || Slides Preview</title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<link rel="stylesheet" href="style.css" type="text/css" media="screen" charset="utf-8">

    </head>

    <body id="body">
        
        <!-- Javascript for embedding flash and checking for flash plugin -->
        <script type="text/javascript" src="js/swfobject/swfobject.js"></script>
        <script type="text/javascript" src="js/swfaddress/swfaddress.js"></script>
        <script type="text/javascript">
            /* <![CDATA[ */
                flashVars   = { json:"content/json/slide_show<?= $_GET['id'] ?>.json" }; // <- Set the json location here
                flashParams = { bgcolor: "#FBF7F0" };
                swfobject.embedSWF( 'SuperSlides.swf', 'flash_div', '685', '683', '9.0.45', 
                                    'js/swfobject/expressinstall.swf', flashVars, flashParams, {id: 'slideshow'}  );
				
            /* ]]> */
        </script>
        <!-- Javascript END -->
        <div id="flash_wrapper">
            <div id="flash_div" >
                <p>In order to view this page you need Flash Player 9+ support. Click on the following link to download it.</p>
                <p>
                    <a href="http://www.adobe.com/go/getflashplayer">
                        <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
                    </a>
                </p>
            </div>
        </div>
		<div>
			<ol>
				<li>
					File: <span class="file_name">slide_show0</span>
					<ul>
						<li>bigSlide:  <b>609x540</b></li>
					</ul>
            	</li>
				<li>
					File: <span class="file_name">slide_show1</span>
					<ul>
						<li>topSlide: <b>609x355</b></li>
						<li>bottomSlide: <b>609x180</b></li>
					</ul>
				</li>
				<li>
					File: <span class="file_name">slide_show2</span>
					<ul>
						<li>topSlide: <b>609x355</b></li>
						<li>bottomSlide: <b>408x180</b></li>
					</ul>
				</li>
				<li>
					File: <span class="file_name">slide_show3</span>
					<ul>
						<li>topSlide: <b>609x355</b></li>
						<li>bottomLeftSlide:  	<b>300x180</b></li>
						<li>bottomRightSlide:  	<b>300x180</b></li>
					</ul>
				</li>
				<li>
					File: <span class="file_name">slide_show4</span>
					<ul>
						<li>leftSlide: <b>395x540</b></li>
						<li>rightSlide: <b>208x540</b></li>
					</ul>
				</li>
				<li>
					File: <span class="file_name">slide_show5</span>
					<ul>
						<li>leftSlide: <b>405x540</b></li>
						<li>rightSlide: <b>200x365</b></li>
					</ul>
				</li>
				<li>
					File: <span class="file_name">slide_show6</span>
					<ul>
						<li>leftSlide: <b>405x540</b></li>
						<li>topRightSlide: <b>208x265</b></li>
						<li>bottomRightSlide: <b>208x265</b></li>
					</ul>
				</li>
			</ol>
		</div>
    </body>
</html>

