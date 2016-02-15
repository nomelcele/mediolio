<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.coverImg_box{width:180px; height:180px; display:block; float:left;}
#total_wrapper{margin:100px 0 0 300px;}
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

/*
 * ***** 메세지 관련 시작 *****
 * *********************
 */


function readMsgReceived($div){
	if($div.find('input.msg_to_status').val() == 'read') alert("이미 읽음");
	else{
		//안 읽은 쪽지일 때
		$.ajax({
			url: "readMsgReceived",
			type: "POST",
			data: {msg_id:$div.find('input.msg_id').val()},
			dataType : "json",
			success: function(result){
				$div.find('span:first').text('"읽음" - ');
				$div.find('input.msg_to_status').val('read');
				alert("success");
			}
		});
	}
}

/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * ***** 메세지 관련 끝 *****
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 */


 
$(function (){
	
	$('.msgSend').click(msgSend);
	$('.getMsgListReceived').click(getMsgListReceived);
	$('.getMsgListSent').click(getMsgListSent);
	$('#appendMsg').on('click', '.deleteMsgReceived', function(){
		deleteMsgReceived($(this).parent());
	});
	$('#appendMsg').on('click', '.deleteMsgSent', function(){
		deleteMsgSent($(this).parent());
	});
	$('#appendMsg').on('click', '.readMsgReceived', function(){
		readMsgReceived($(this).parent());
	});
	
	$('.followMember').click(followMember);
	$('.followCancel').click(followCancel);
	$('.followCheck').click(followCheck);

});

</script>
<div id="total_wrapper">
<h2>내 ID : ${sessionScope.mev.m_id }</h2>

<div>
	<h2>팔로우!!!</h2>
	<span>내가 팔로우할 대상 m_id : </span><input type="text" value="2" id="m_id">
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
		<input type="button" value="보내기" class="msgSend">
		<input type="button" value="취소" class="msgCancel">
	</form>
	<input type="button" value="내게 도착한 모든 메세지" class="getMsgListReceived">
	<input type="button" value="내가 보낸 모든 메세지" class="getMsgListSent">
	<div id="appendMsg">
	</div>
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
</div>