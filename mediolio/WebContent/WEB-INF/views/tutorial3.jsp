<!DOCTYPE html>
<html lang="en">
<head>
  <title>Aspect Ratio with Preview Pane | Jcrop Demo</title>
  <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />

<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/jquery.Jcrop.js"></script>
<script type="text/javascript">
	$(function($) {

		$('#representative_img').change(function(){
			
		});
		
		// Create variables (in this scope) to hold the API and image size
		var jcrop_api, boundx, boundy,

		// Grab some information about the preview pane
		$preview = $('#preview-pane'), 
		$pcnt = $('#preview-pane .preview-container'), 
		$pimg = $('#preview-pane .preview-container img'),

		xsize = $pcnt.width(), ysize = $pcnt.height();

		console.log('init', [ xsize, ysize ]);

		$('#target').Jcrop({
			onChange : updatePreview,
			onSelect : updatePreview,
			aspectRatio : xsize / ysize
		}, function() {
			// 이미지 사이즈 구함
			var bounds = this.getBounds();
			boundx = bounds[0];
			boundy = bounds[1];
			
			jcrop_api = this;

			// Move the preview into the jcrop container for css positioning
			$preview.appendTo(jcrop_api.ui.holder);
		});

		function updatePreview(c) {
			if (parseInt(c.w) > 0) {
				var rx = xsize / c.w;
				var ry = ysize / c.h;

				document.myForm.x.value = c.x;
				document.myForm.y.value = c.y;
				document.myForm.w.value = c.w;
				document.myForm.h.value = c.h;
				
				$pimg.css({
					width : Math.round(rx * boundx) + 'px',
					height : Math.round(ry * boundy) + 'px',
					marginLeft : '-' + Math.round(rx * c.x) + 'px',
					marginTop : '-' + Math.round(ry * c.y) + 'px'
				});
			}
		}
		
	});
	
	function checkCoordinates() {
		if (document.myForm.x.value == "" || document.myForm.y.value == "") {
			alert("Please select a crop region");
			return false;
		} else {
			$.ajax({
				url: "cropImage",
				data: {pic_id: $('#selected_img_id').val(), article_id: $('#this_article_id').val()},
				dataType: 'JSON', 
				type: 'POST',
				success: function (data) {
					$('#select_img').css("display","none");
					$('#move_to_main').css("display", "block");
				}
			});
			return true;
		}
	}
</script>

<link rel="stylesheet" href="resources/css/jquery.Jcrop.css" type="text/css" />
<style type="text/css">
/* Apply these styles only when #preview-pane has
   been placed within the Jcrop widget */
.jcrop-holder #preview-pane {
  display: block; position: absolute; z-index: 2000; top: 10px; right: -280px; padding: 6px; border: 1px rgba(0,0,0,.4) solid; background-color: white;
  -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px;
  -webkit-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2); -moz-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
}

/* The Javascript code will set the aspect ratio of the crop
   area based on the size of the thumbnail preview,
   specified here */
#preview-pane .preview-container {
	width: 250px; height: 170px; overflow: hidden;
}
</style>

</head>
<body>
<input type="file" id="representative_img" name="p_coverImg">
<div class="jc-demo-box">

  <img src="resources/images/test2.jpg" id="target" />

	<div id="preview-pane">
		<div class="preview-container">
		<img src="resources/images/test2.jpg" class="jcrop-preview" alt="Preview" />
    </div>
</div>
<div class="clearfix"></div>
</div>
<form name="myForm" action="cropper.jsp" method="post" onsubmit="return checkCoordinates();">
	<input type="hidden" name="x" value=""/>
	<input type="hidden" name="y" value=""/>
	<input type="hidden" name="w" value=""/>
	<input type="hidden" name="h" value=""/>
	<input type="submit" value="Crop Image"/>
</form>
</body>
</html>

