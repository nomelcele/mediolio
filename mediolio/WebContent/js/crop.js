function show_cropModal(url){
	if(url.length==0) alert("이미지 업로드가 실패했습니다.");
	else{
		$.ajax({
			url: "imgCrop_modal",
			type: "POST",
			data: {url : $('#preview_url').val()},
			success: function(result){
				$("#modalBox").html(result);
				location.href="#crop";
			}
		});
	}
}

    
function emptyValue(){
	$('#cover_img').val("");
}

function fileValidation(){
	var maxFileSize=10000;
	var file = $('#cover_img').prop("files")[0];
	var img;
	var size = file.size;
	size  = Math.round(size/1024);
	console.log("imgSize : "+size);
	
	if (size > maxFileSize){
		//파일용량 체크
		alert("10MB 이하의 파일을 올려주세요.");
		return false;
	}	
	else{//용량이 10MB 이하일  때 계속 검사
        var ext = $('#cover_img').val().split('.').pop().toLowerCase(); //확장자
        //업로드 불가능한 확장자 필터링
        if($.inArray(ext, ['png', 'jpg', 'jpeg']) == -1) {
            alert('png, jpg, jpeg 만 업로드 가능합니다.');
            return false;
        } 
        else {//업로드 가능한 확장자일 때
        	var _URL = window.URL;
            img = new Image();
            img.src = _URL.createObjectURL(file);
            img.onload = function () {
            	if(img.width<180 || img.height<180){
            		alert("이미지가 너무 작습니다.");
            		return false;
            	}
            	else if(img.width/img.height>3 || img.height/img.width>3) {
            		alert("정사각형에 가까운 이미지를 올려주세요.");
            		return false;
            	}
            	else {
                    $('#preview_url').val(img.src);
                    $('#target').attr('src', '');
                    $('#target-preview').attr('src', '');
                    show_cropModal(img.src);
            	}
            };
        }
	}
}

