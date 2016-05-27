

/*  
 *  글 작성시 이미지 크롭 관련 javascript
 *  오지은 작성
 * */


// <input type="file" id="cover_img"> 클릭 시 value를 비워주는 함수
function emptyValue(){
	$('#cover_img').val("");
}

//<input type="file" id="cover_img"> 에서 파일을 선택했을 때 호출되는 함수
//업로드할 수 있는 형식과 크기의 이미지인지 체크하여, 가능한 파일일 때 크롭 모달 오픈
function fileValidation(){
	var maxFileSize=10000; //10MB 제한
	var file = $('#cover_img').prop("files")[0];
	var img;
	var size = file.size;
	size  = Math.round(size/1024);
	
	if (size > maxFileSize){
		//파일용량 체크
		$.jAlert({
		    'title': '!!',
		    'content': '10MB 이하의 파일을 올려주세요.',
		    'closeOnClick' : true,
		    'theme' : 'red',
		    'size': 'xsm'
		  });
		return false;
	}	
	else{//용량이 10MB 이하일  때 계속 검사
        var ext = $('#cover_img').val().split('.').pop().toLowerCase(); //확장자
        
        //업로드 불가능한 확장자 필터링
        if($.inArray(ext, ['png', 'jpg', 'jpeg']) == -1) {
    		$.jAlert({
    		    'title': '!!',
    		    'content': 'png, jpg, jpeg 만 업로드 가능합니다.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
            return false;
        } 
        else {//업로드 가능한 확장자일 때
        	var _URL = window.URL;
            img = new Image();
            img.src = _URL.createObjectURL(file);
            img.onload = function () { //이미지가 너무 작을 때
            	if(img.width<200 || img.height<200){
            		$.jAlert({
            		    'title': '!!',
            		    'content': '이미지가 너무 작습니다.',
            		    'closeOnClick' : true,
            		    'theme' : 'red',
            		    'size': 'xsm'
            		  });
            		return false;
            	}
            	else if(img.width/img.height>3 || img.height/img.width>3) {
            		$.jAlert({
            		    'title': '!!',
            		    'content': '정사각형에 가까운 이미지를 올려주세요.',
            		    'closeOnClick' : true,
            		    'theme' : 'red',
            		    'size': 'xsm'
            		  });
            		return false;
            	}
            	else {
                    $('#preview_url').val(img.src);
                    show_cropModal(img.src); //이미지 크롭 모달 열기
            	}
            };
        }
	}
}

//이미지를 크롭하는 모달을 여는 함수
function show_cropModal(url){
	if(url.length==0) //url값이 제대로 전달되지 않았을 때
		$.jAlert({
		    'title': '!!',
		    'content': '이미지 업로드가 실패했습니다.',
		    'closeOnClick' : true,
		    'theme' : 'red',
		    'size': 'xsm'
		  });
	else{
		//ajax를 거쳐 모달 오픈
		$.ajax({
			url: "imgCrop_modal",
			type: "POST",
			data: {url : $('#preview_url').val()},
			success: function(result){
				$('#contentsWrap').css({position: 'fixed'});
				$("#modalBox").html(result);
				location.href="#crop";
			}
		});
	}
}
