

	/*  좋아요, 팔로우, 댓글달기에 관련한 javascript
	 *  오지은 작성
	 * */

$('document').ready(function(){
	//댓글 지우기 버튼 클릭시
	$('#modal_ft_content').unbind("click").on('click', '.btn_deleteReply', function(){
		deleteReply($(this).closest('.replyContentWrap'));
	});
	//프로젝트 "좋아요" 버튼 클릭시
	$('#modal_hd_content').on('click', '.cancelLikeProject', cancelLikeProject);
	$('#modal_hd_content').on('click', '.likeProject', likeProject);
	
	//팔로우하기 버튼 클릭시
	$('#modal_content_userInfo').on('click', '.followMember', followMember);
	$('#modal_content_userInfo').unbind("click").on('click', '.unfollowMember', function(){
	    $.jAlert({
	        'title': '!!',
	        'content': '정말 팔로우를 취소하시겠습니까?',
	        'closeOnClick' : true,
	        'theme' : 'red',
	        'btns': [{ 'text': 'YES',  'theme' : 'green',
			        	'onClick' : function(e){
			        		e.preventDefault();
			        		followCancel();
			        	}
	        		  }, 
	                 { 'text': 'NO', 'theme' : 'red'}]
	      });
	})
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
//댓글 등록 버튼 클릭시 호출
function submitReply(){
	/*$('#writeReplyWrap textarea').val().replace(/\n/g, '<br>');*/ 
	if(!$.trim($("#writeReplyWrap textarea").val())){
		$.jAlert({
		    'title': '!!',
		    'content': '댓글을 입력해주세요.',
		    'closeOnClick' : true,
		    'theme' : 'red',
		    'size': 'xsm'
		  });
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

//댓글 삭제 버튼 클릭시 호출
function deleteReply($div){
    $.jAlert({
        'title': '!!',
        'content': '정말 삭제하시겠습니까?',
        'closeOnClick' : true,
        'theme' : 'red',
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


//등록한 댓글을 html로 가공하는 함수
function returnReplyList(m_id, m_studentID, m_name, r_text, r_date, r_id){

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