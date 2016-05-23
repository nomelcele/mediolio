//오지은 - 좋아요, 팔로우, 댓글달기

$('document').ready(function(){
	$('#modal_ft_content').on('click', '.btn_deleteReply', function(){
		deleteReply($(this).closest('.replyContentWrap'));
	});
	$('#modal_hd_content').on('click', '.cancelLikeProject', cancelLikeProject);
	$('#modal_hd_content').on('click', '.likeProject', likeProject);
	
	$('#modal_content_userInfo').on('click', '.followMember', followMember);
	$('#modal_content_userInfo').on('click', '.unfollowMember', followCancel);
});

/*
 * ***** 팔로우 관련 시작 *****
 * *********************
 */
function followMember(){
	$.ajax({
		url: "followMember",
		type: "POST",
		data: {m_id:$('#other_m_id').val()},
		dataType : "json",
		success: function(result){
			$('#modal_content_userInfo .followMember').removeClass().addClass('unfollowMember').text('UNFOLLOW');
		}
	});
}

function followCancel(){
	$.ajax({
		url: "followCancel",
		type: "POST",
		data: {m_id:$('#other_m_id').val()},
		dataType : "json",
		success: function(result){
			$('#modal_content_userInfo .unfollowMember').removeClass().addClass('followMember').text('FOLLOW');
		}
	});
}

/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* ***** 팔로우 관련 끝 *****
* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/


/*
 * ***** 좋아요 관련 시작 *****
 * *********************
 */
function likeProject(){
	$.ajax({
		url: "projectLike",
		type: "POST",
		data: {p_id:$('#this_p_id').val(), act_to:$('#other_m_id').val()},
		dataType : "json",
		success: function(result){
			$('#heartNum').text(result.likeNum);
			$('#contentHeart').removeClass().addClass('cancelLikeProject');
			$('#contentHeart img').attr('src','resources/images/heartAfter.png');
		}
	});
}

function cancelLikeProject(){
	$.ajax({
		url: "projectLikeCancel",
		type: "POST",
		data: {p_id:$('#this_p_id').val(), act_to:$('#other_m_id').val()},
		dataType : "json",
		success: function(result){
			$('#heartNum').text(Number($('#heartNum').text())-1);
			$('#contentHeart').removeClass().addClass('likeProject');
			$('#contentHeart img').attr('src','resources/images/heartBefore.png');
		}
	});
}
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* ***** 좋아요 관련 끝 *****
* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

/*
 * ***** 댓글 관련 시작 *****
 * *********************
 */
function submitReply(){
	/*$('#writeReplyWrap textarea').val().replace(/\n/g, '<br>');*/ 
	if(!$.trim($("#writeReplyWrap textarea").val())){
		alert('댓글을 입력해주세요');
	}
	else{
		
		$.ajax({
			url: "submitReply",
			type: "POST",
			data: $('#reply_form').serialize()+"&act_to="+$('#other_m_id').val(),
			dataType : "json",
			success: function(data){
				$('#writeReplyWrap textarea').val('');
				$('.replyContentsTotalWrap').append(
						returnReplyList(data.reply.m_id, data.reply.m_studentID, data.reply.m_name, data.reply.r_text, data.reply.r_date, data.reply.r_id)
					);
			}
		});
	}
}

function deleteReply($div){
    $.jAlert({
        'title': '!!',
        'content': '정말 삭제하시겠습니까?',
        'closeOnClick' : true,
        'btns': [{ 'text': 'YES',  'theme' : 'green',
		        	'onClick' : function(e){
		        		e.preventDefault();
		        		$.ajax({
		        			url: "deleteReply",
		        			type: "POST",
		        			data: {r_id:$div.find('input').val()},
		        			dataType : "json",
		        			success: function(result){
		        				$div.remove();
		        			}
		        		});
		        	}
        		  }, 
                 { 'text': 'NO', 'theme' : 'red'}]
      });
}

function returnReplyList(m_id, m_studentID, m_name, r_text, r_date, r_id){
/*	var resultDateTime = r_date;
	var dateArr = resultDateTime.split(" ");
	var date = dateArr[0].replace(/-/gi, ".");
	var time = dateArr[1].substring(0, dateArr[1].lastIndexOf(":"));*/
	var inserted = '<div class="replyContentWrap">'
							+'<p>'
								+'<a href="#">'+m_studentID+' '+m_name+'</a>'
								+'<c:choose>'
									+'<c:when test="${sessionScope.mev.m_id == '+m_id+' }">'
										+'<a class="btn_deleteReply">X<input type="hidden" value="'+r_id+'"></a>'
									+'</c:when>'
								+'</c:choose>'
								+'<span>'+r_date+'</span>'
							+'</p>'
							+'<div class="replyContent">'+r_text+'</div>'
						+'</div>';
	return inserted;
}

/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* ***** 댓글 관련 끝 *****
* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/