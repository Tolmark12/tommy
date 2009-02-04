<?php

$scroll = $_GET['normalScroll'];

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" >
    <head>
        <title>Tommy Bahama Furniture Viewer</title>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

		<!-- Flash Embed -->
		<script type="text/javascript" src="js/swfobject/swfobject.js"></script>
		<script type="text/javascript" src="js/swfaddress/swfaddress.js"></script>
		<script type="text/javascript">
			/* <![CDATA[ */
				flashVars   = { xmlPath: 'flash_loads/xml/slides.xml', normalScroll: "<?= $scroll ?>" };
				flashParams = {bgcolor:  '#F7EDD9', menu: 'false' };
				swfobject.embedSWF( 'FurnitureViewer.swf', 'furniture_viewer', '790', '590', '9.0.45', 
		    	                	'js/swfobject/expressinstall.swf', flashVars, flashParams, {id: 'website'}  );
			/* ]]> */
		</script>
		<!-- Flash Embed END -->
		
		<style type="text/css">
			/* hide from ie on mac */
			html, body, #furniture_viewer {
		        height: 100%;
		    }
			/* end hide */

			body {
				height: 100%;
				margin: 0;
				padding: 0;
				background:#F7EDD9;
				text-align:CENTER;
			}
		</style>
    </head>

    <body id="body">
		<div style="margin-top:20px">
			<div id="furniture_viewer">
			    <p>In order to view this page you need Flash Player 9+ support!</p>
			    <p>
			        <a href="http://www.adobe.com/go/getflashplayer">
			            <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
			        </a>
			    </p>
			</div>
		</div>
    </body>
</html>
