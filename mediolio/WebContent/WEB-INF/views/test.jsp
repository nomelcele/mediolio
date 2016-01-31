<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.container { width: 500px; clear: both;}
.container input {width: 100%;clear: both;}
#wrapper {margin: 0 auto; width: 400px;}
#wrapper2 {margin: 0 auto; width: 200px;}
</style>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery.Jcrop.js"></script>
<link rel="stylesheet" href="resources/css/jquery.Jcrop.css" type="text/css" />
<script type="text/javascript">

function show_cropModal(url){
	if(url.length==0) alert("이미지 업로드가 실패했습니다.");
	else{
		//var formData = new FormData($('#coverImg_form')[0]);
		$.ajax({
			url: "imgCrop_modal",
			type: "POST",
			data: new FormData(document.getElementById("coverImg_form")),
            enctype: "multipart/form-data",
		    processData: false,
		    contentType: false,
			async:false,
			success: function(result){
				$("#modalBox").html(result);
				location.href="#crop";
			}
		});
	}
}

function fileCheck(){
	var size=0;
	var maxFileSize=5000;
	size = document.getElementById('cover_img').files[0].size;
	size  = Math.round(size/1024);
	console.log("imgSize : "+size);
	if (size > maxFileSize){
	    alert("5MB 이하의 이미지파일만 올려주십시오.");

	}else{//용량이 5MB 이하일  때 계속 진행
        var ext = $('#cover_img').val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['png', 'jpg', 'jpeg']) == -1) {
            window.alert('png, jpg, jpeg 만 업로드 가능합니다.');
        } else {
            var file = $('#cover_img').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            console.log("blobURL : " + blobURL);
            $('#preview_url').val(blobURL);
            show_cropModal(blobURL);
        }
	}
}

$(function (){

});


</script>
</head>
<body>
<div id="modalBox"></div>
<form method="post" id="coverImg_form" enctype="multipart/form-data">
	<input type="file" id="cover_img" name="p_coverImg" onchange="fileCheck()">
 	<input type="hidden" id="preview_url" name="preview_url">
</form>


</body>
</html>