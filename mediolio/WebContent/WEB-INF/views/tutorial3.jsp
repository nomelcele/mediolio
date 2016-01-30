<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Aspect Ratio with Preview Pane | Jcrop Demo</title>
  <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
 <link rel="stylesheet" href="resources/css/jquery.Jcrop.css" type="text/css" />
<style type="text/css">
/* 모달 설정 */
/* The modal's background */
.modal { display: none; position: fixed; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0.4); padding-top: 50px; padding-bottom: 50px; z-index: 800;}
/* Display the modal when targeted */
.modal:target {display: table; /* table*/ position: absolute;}
/* The modal box */
.modal-dialog {display: table-cell; vertical-align: middle;}
/* The modal's content */
.modal-dialog .modal-content {margin: auto; background-color: #fff; position: relative; padding: 0; outline: 0; border: 1px #777 solid; text-align: justify; width:985px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); border-radius:10px; 

</style>
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.Jcrop.js"></script>
<script type="text/javascript">

	$(function($) {

		// Create variables (in this scope) to hold the API and image size
		var jcrop_api, boundx, boundy,

		// Grab some information about the preview pane
		$preview = $('#preview-pane'), 
		$pcnt = $('#preview-pane .preview-container'), 
		$pimg = $('#preview-pane .preview-container img'),

		xsize = $pcnt.width(), ysize = $pcnt.height();

		console.log('init', [ xsize, ysize ]);

		$('#target').Jcrop({
			boxWidth: 700, 
			boxHeight: 500,
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
/* 			$.ajax({
				url: "cropImage",
				data: {},
				dataType: 'JSON', 
				type: 'POST',
				success: function (data) {
					
				}
			}); */
			return true;
		}
	}
</script>
<style type="text/css">
/* jcrop 속성 */
#preview-pane{ 
  display: block; position: absolute; z-index: 2000; top: 10px; right: -280px; padding: 6px; border: 1px rgba(0,0,0,.4) solid; background-color: white;
  -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px;
  -webkit-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2); -moz-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
}

/* thumbnail preview 창 크기 비율에 따라 crop 비율이 정해짐 */
#preview-pane .preview-container {
	width: 250px; height: 170px; overflow: hidden;
}
</style>
</head>
<body>
<div id="crop" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="jc-demo-box">

  				<img src="${imgUrl }" id="target" alt="original image"/>

					<div id="preview-pane">
						<div class="preview-container">
							<img src="${imgUrl }" id="target-preview" class="jcrop-preview" alt="Preview" />
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
		</div>
	</div>
</div>
</body>
</html>

