$('document').ready(function(){
	$('#modal_ft_content').on('click', '.btn_deleteReply', function(){
		deleteReply($(this).closest('.replyContentWrap'));
	});
});

/*
 * ***** 프로젝트 상세보기 댓글 관련 시작 *****
 * *********************
 */
function submitReply(){
	$.ajax({
		url: "submitReply",
		type: "POST",
		data: $('#reply_form').serialize()+"&act_to="+$('#writer_m_id').val(),
		dataType : "json",
		success: function(data){
			$('#writeReplyWrap textarea').val('');
			$('.replyContentsTotalWrap').append(
					returnReplyList(data.reply.m_id, data.reply.m_studentID, data.reply.m_nickname, data.reply.r_text, data.reply.r_date, data.reply.r_id)
				);
		}
	});
}

function deleteReply($div){
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

function returnReplyList(m_id, m_studentID, m_nickname, r_text, r_date, r_id){
/*	var resultDateTime = r_date;
	var dateArr = resultDateTime.split(" ");
	var date = dateArr[0].replace(/-/gi, ".");
	var time = dateArr[1].substring(0, dateArr[1].lastIndexOf(":"));*/
	var inserted = '<div class="replyContentWrap">'
							+'<p>'
								+'<a href="#">'+m_studentID+' '+m_nickname+'</a>'
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