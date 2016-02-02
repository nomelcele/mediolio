<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.coverImg_box{width:180px; height:180px; display:block; float:left;}
</style>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery.Jcrop.js"></script>
<link rel="stylesheet" href="resources/css/jquery.Jcrop.css" type="text/css" />
<script type="text/javascript">

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
                    show_cropModal(img.src);
            	}
            };
        }
	}

}
function msgSend(){
	$.ajax({
		url: "msgSend",
		type: "POST",
		data: $('#msg_form').serialize(),
		dataType : "json",
		success: function(result){
			alert("success");
		}
	});
}
function projectLike(){
	$.ajax({
		url: "projectLike",
		type: "POST",
		data: {p_id:$('#p_id').val(), act_to:$('#m_id').val()},
		dataType : "json",
		success: function(result){
			$('#likeNum').val(result.likeNum);
		}
	});
}

function followMember(){
	$.ajax({
		url: "followMember",
		type: "POST",
		data: {m_id:$('#m_id').val()},
		dataType : "json",
		success: function(result){
			alert("success");
		}
	});
}

function followCancel(){
	$.ajax({
		url: "followCancel",
		type: "POST",
		data: {m_id:$('#m_id').val()},
		dataType : "json",
		success: function(result){
			alert("success");
		}
	});
}

function followCheck(){
	$.ajax({
		url: "followCheck",
		type: "POST",
		data: {m_id:$('#m_id').val()},
		dataType : "json",
		success: function(result){
			if(result.isFollowed == 'y'){
				$('.followCheck_result').text("팔로우 되어 있습니다.");
			}else if(result.isFollowed == 'n'){
				$('.followCheck_result').text("팔로우 된 상태가 아닙니다.");
			}
		}
	});
}

function projectLikeCancel(){
	$.ajax({
		url: "projectLikeCancel",
		type: "POST",
		data: {p_id:$('#p_id').val(), act_to:$('#m_id').val()},
		dataType : "json",
		success: function(result){
			alert("success");
		}
	});
}

function submitReply(){
	$.ajax({
		url: "submitReply",
		type: "POST",
		data: $('#reply_form').serialize()+"&act_to="+$('#m_id').val(),
		dataType : "json",
		success: function(result){
			alert("success");
		}
	});
}

$(function (){
	$('.msgSend').click(msgSend);
	$('.projectLike').click(projectLike);
	$('.projectLikeCancel').click(projectLikeCancel);
	$('.followMember').click(followMember);
	$('.followCancel').click(followCancel);
	$('.followCheck').click(followCheck);
	$('.submitReply').click(submitReply);
});


</script>
</head>
<body>
<div>
	<h2>댓글!!!</h2>
	<form id="reply_form">
		<span>P_ID : </span><input type="text" value="1" name="p_id"><br>
		<textarea name="r_text"></textarea>
		<input type="button" value="댓글등록" class="submitReply">
	</form>
</div>
<div>
	<h2>팔로우!!!</h2>
	<span>내가 팔로우 대상 m_id : </span><input type="text" value="2" id="m_id">
	<input type="button" value="팔로우" class="followMember">
	<input type="button" value="언팔로우" class="followCancel"><br>
	<input type="button" value="팔로우여부" class="followCheck">
	<span class="followCheck_result"></span>
</div>
<div>
	<h2>좋아요!!!</h2>
	<span>프로젝트ID : </span><input type="text" value="1" id="p_id"><br>
	<span>좋아요 수 : </span><input type="text" id="likeNum">
	<input type="button" value="좋아요" class="projectLike">
	<input type="button" value="좋아요 취소" class="projectLikeCancel">
</div>
<div>
	<h2>쪽지!!!</h2>
	<form id="msg_form">
		<span>to</span><input type="text" name="msg_to" value="2"><br>
		<textarea name="msg_text"></textarea>
		<input type="button" value="보내기" class="msgSend">
		<input type="button" value="취소" class="msgCancel">
	</form>
</div>

<div id="modalBox"></div>
<h2>이미지 첨부!!!</h2>
<form method="post" id="coverImg_form" enctype="multipart/form-data">
	<input type="file" id="cover_img" name="coverImg" onchange="fileValidation()">
 	<input type="hidden" id="preview_url" name="preview_url">
 	<input type="hidden" id="preview_x" name="x" value=""/>
	<input type="hidden" id="preview_y"name="y" value=""/>
	<input type="hidden" id="preview_w"name="w" value=""/>
	<input type="hidden" id="preview_h"name="h" value=""/>
</form>
<input type="hidden" id="p_coverImg" name="p_coverImg">
<div class="coverImg_box">

</div>
</body>
</html>