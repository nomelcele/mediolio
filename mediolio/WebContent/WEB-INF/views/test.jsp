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

/*
 * ***** 메세지 관련 시작 *****
 * *********************
 */
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

function getMsgListReceived(){
	$.ajax({
		url: "getMsgListReceived",
		dataType : "json",
		success: function(result){
			var msg = '';
			$.each(result.list, function(index, entry){
				var status;
				if(entry.msg_to_status == 'no-read') status = '읽지 않음';
				else if(entry.msg_to_status == 'read') status = '읽음';
				msg += returnMsgList(entry.msg_id, entry.msg_from, entry.msg_to, entry.msg_text, entry.msg_date, entry.msg_to_status, status);
			});
			$('#appendMsg').empty().append(msg);
		}
	});
}

function getMsgListSent(){
	$.ajax({
		url: "getMsgListSent",
		dataType : "json",
		success: function(result){
			var msg = '';
			$.each(result.list, function(index, entry){
				msg += returnMsgList(entry.msg_id, entry.msg_from, entry.msg_to, entry.msg_text, entry.msg_date, entry.msg_to_status, '보냄');
			});
			$('#appendMsg').empty().append(msg);
		}
	});
}

function returnMsgList(msg_id, msg_from, msg_to, msg_text, msg_date, msg_to_status, msg_status){
	var aMsg = '';
	aMsg += '<div class="sent">';
	aMsg += '<span>"'+msg_status+'" - </span><span>'+msg_from+'가 '+ msg_to + '에게 보낸 쪽지' +' : </span>';
	aMsg += '<span>'+msg_text+' </span>'+'<span> '+msg_date+'</span>';
	aMsg += '<input type="hidden" value="'+msg_id+'" class="msg_id"><input type="hidden" value="'+msg_to_status+'" class="msg_to_status">';
	aMsg += '<input type="hidden" value="'+msg_from+'" class="msg_from"><input type="hidden" value="'+msg_to+'" class="msg_to">';
	if(msg_status == '보냄') aMsg += '<input type="button" value="읽음" class="readMsgSent"><input type="button" value="삭제" class="deleteMsgSent">';
	else aMsg += '<input type="button" value="읽음" class="readMsgReceived"><input type="button" value="삭제" class="deleteMsgReceived">';
	aMsg += '</div>';
	return aMsg;
}

function deleteMsgSent($div){
	$.ajax({
		url: "deleteMsgSent",
		type: "POST",
		data: {msg_id:$div.find('input.msg_id').val()},
		dataType : "json",
		success: function(result){
			$div.remove();
			alert("success");
		}
	});
}

function deleteMsgReceived($div){
	$.ajax({
		url: "deleteMsgReceived",
		type: "POST",
		data: {msg_id:$div.find('input.msg_id').val()},
		dataType : "json",
		success: function(result){
			$div.remove();
			alert("success");
		}
	});
}

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

 
 /*
  * ***** 좋아요 관련 시작 *****
  * *********************
  */
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
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * ***** 좋아요 관련 끝 *****
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 */

 
 /*
  * ***** 팔로우 관련 시작 *****
  * *********************
  */
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
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * ***** 팔로우 관련 끝 *****
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 */

 
 /*
  * ***** 댓글 관련 시작 *****
  * *********************
  */
function submitReply(){
	$.ajax({
		url: "submitReply",
		type: "POST",
		data: $('#reply_form').serialize()+"&act_to="+$('#m_id').val(),
		dataType : "json",
		success: function(result){
			$('#appendReply').append(returnReplyList(result.reply.m_id, result.reply.r_text, result.reply.r_date, result.reply.r_id));
		}
	});
}

function deleteReply($div){
	//var reply_rid = $div.find('input.reply_rid').val();
	$.ajax({
		url: "deleteReply",
		type: "POST",
		data: {r_id:$div.find('input.reply_rid').val()},
		dataType : "json",
		success: function(result){
			$div.remove();
			alert("success");
		}
	});
}

function returnReplyList(m_id, r_text, r_date, r_id){
	var resultDateTime = r_date;
	var dateArr = resultDateTime.split(" ");
	var date = dateArr[0].replace(/-/gi, ".");
	var time = dateArr[1].substring(0, dateArr[1].lastIndexOf(":"));
	var aReply = '';
	aReply += '<div>';
	aReply += '<span>M_ID : </span><span>'+ m_id +'</span><span> '+ r_text+' </span>'
	aReply += '<span>'+ date +' '+time+'</span>';
	aReply += '<input type="hidden" value="'+r_id+'" class="reply_rid"><input type="button" value="삭제" class="deleteReply">';
	aReply += '</div>';
	return aReply;
}

function getReplyList(){
	$.ajax({
		url: "getReplyList",
		type: "POST",
		data: {p_id:$('#p_id').val()},
		dataType : "json",
		success: function(result){
			var replyList='';
			$.each(result.list, function(index, entry){
				replyList += returnReplyList(entry.m_id, entry.r_text, entry.r_date, entry.r_id);
			});
			$('#appendReply').empty().append(replyList);
		}
	});
}
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * ***** 댓글 관련 끝 *****
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
	
	$('.projectLike').click(projectLike);
	$('.projectLikeCancel').click(projectLikeCancel);
	
	$('.followMember').click(followMember);
	$('.followCancel').click(followCancel);
	$('.followCheck').click(followCheck);
	
	$('.submitReply').click(submitReply);
	$('.getReplyList').click(getReplyList);
	$('#appendReply').on('click', '.deleteReply', function(){
		deleteReply($(this).parent());
	});
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
	<input type="button" value="이 프로젝트의 모든 댓글 가져오기" class="getReplyList">
	<div id="appendReply">		
	</div>
</div>
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
		<span>to</span><input type="text" name="msg_to" value="2"><br>
		<textarea name="msg_text"></textarea>
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
</body>
</html>