<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

	$(function($) {
		// Create variables (in this scope) to hold the API and image size
		var jcrop_api, boundx, boundy;
		var box_width = 740;
		var box_height = 700;
		
		// Grab some information about the preview pane
		$preview = $('#preview-pane');
		$pcnt = $('#preview-pane .preview-container');
		$pimg = $('#preview-pane .preview-container img');

		var xsize = 200; 
		var ysize = 200;
		//xsize = $pcnt.width(), ysize = $pcnt.height();

		var target = document.getElementById("target");
		var imgWidth = target.width;
		var imgHeight = target.height;
		console.log("target W/H : " + imgWidth + " , " + imgHeight);
		
		$('#target').Jcrop({
			boxWidth: box_width, 
			boxHeight: box_height,
			minSize:[200, 200],
			setSelect:[imgWidth/2-90, imgHeight/2-90, imgWidth/2+90, imgHeight/2+90],
			onChange : updatePreview,
			onSelect : updatePreview,
			aspectRatio : xsize / ysize
		}, function() {
			
			// 이미지 사이즈 구함
			var bounds = this.getBounds();
			boundx = bounds[0];
			boundy= bounds[1];
			jcrop_api = this;
			
			//모달 크기 결정----------------------------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			if(boundx>box_width && boundy>box_height){
				//이미지 가로세로 모두 박스 범위보다 클때
				if(box_width/box_height < boundx/boundy){
					//비율상 가로가 더 길때
					$('.modal-content').css({ width: box_width + 210});
				}else if(box_width/box_height > boundx/boundy){
					//비율상 세로가 더 길때
					$('.modal-content').css({ width: boundx*box_height/boundy + 210});
				}
			}else if(boundx>box_width){
				//이미지 가로만 박스 범위보다 클때
				$('.modal-content').css({ width: box_width + 210});
			}else if(boundy>box_height){
				//이미지 세로만 박스 범위보다 클때
				$('.modal-content').css({ width: boundx*box_height/boundy + 210 });
			}else{
				//이미지가 박스 범위보다 작을 때
				$('.modal-content').css({ width: boundx + 210});
			}
			console.log($('.modal-content').width());
			$preview.appendTo(jcrop_api.ui.holder);
		});

		function updatePreview(c) {
			if (parseInt(c.w) > 0) {
				var rx = xsize / c.w;
				var ry = ysize / c.h;

				$('#preview_x').val(c.x);
				$('#preview_y').val(c.y);
				$('#preview_w').val(c.w);
				$('#preview_h').val(c.h);
				
				$pimg.css({
					width : Math.round(rx * boundx) + 'px',
					height : Math.round(ry * boundy) + 'px',
					marginLeft : '-' + Math.round(rx * c.x) + 'px',
					marginTop : '-' + Math.round(ry * c.y) + 'px'
				});
			}
		}
		
	});
	
	function uploadAjax() {
		var form = new FormData(document.getElementById("coverImg_form"));
		form.append("coverImg", $('#cover_img').prop("files")[0], $('#cover_img').val());
		
		$.ajax({
			url: "cropImage",
			type: "POST",
			data: form,
	        enctype: "multipart/form-data",
			processData: false,
			contentType: false,
			dataType : "json",
			async:false,
			success: function(result){
				if(result.result == "fail") alert("이미지 크롭에 실패하였습니다.");
				else{
					$('.card_img>a').empty().append('<img src="resources/images/projectCover/'+result.result+'" class="">');
				
					$('#p_coverImg').val(result.result);
				}
				$('#contentsWrap').css({position: 'relative'});
				$('#crop').remove();
			}
		});
	}
	
	function cancelCrop(){
		$('#contentsWrap').css({position: 'relative'});
		$('#crop').remove();
	}
</script>

<div id="crop" class="crop_modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="jc-demo-box">
  				<img src="${imgUrl }" id="target" alt="original image"/>
				<div id="preview-pane">
					<div class="preview-container">
						<img src="${imgUrl }" id="target-preview" class="jcrop-preview" alt="Preview" />
    				</div>
				</div>

			</div>
			<div class="crop_btns">
				<input type="button" value="CROP" id="crop_submit" onclick="uploadAjax()" class="btnStyle2"/>
				<input type="button" value="CANCEL" id="crop_cancel" onclick="cancelCrop()" class="btnStyle2">
			</div>
		</div>
	</div>
</div>

