
/*  쪽지 관련
 *  이유라 - UI 관련 javascript
 *  오지은 - 기능 관련 javasciript
 * */


//오지은 작성 - 보낸 메세지 삭제
function deleteMsgSent($div){
	$.ajax({
		url: "deleteMsgSent",
		type: "POST",
		data: {msg_id:$div.find('input.this_msg_id').val()},
		dataType : "json",
		success: function(result){
			$div.remove();
		}
	});
}

//오지은 작성 - 받은 메세지 삭제
function deleteMsgReceived($div){
    $.ajax({
		url: "deleteMsgReceived",
		type: "POST",
		data: {msg_id:$div.find('input.this_msg_id').val()},
		dataType : "json",
		success: function(result){
			$div.remove();
		}
	});
}

$(function(){	
	
	//오지은 작성 - 삭제버튼 눌렀을 때
	$(document).unbind("click").on('click', '.btn_deleteNote', function(){
		$msg = $(this).closest('.noteWrap');
		
		if($(this).hasClass('receiveNote')){ //받은 쪽지일 때 - deleteMsgReceived() 호출
		    $.jAlert({
		        'title': '!!',
		        'content': '정말 삭제하시겠습니까?',
		        'theme' : 'red',
		        'closeOnClick' : true,
		        'btns': [{ 'text': 'YES',  'theme' : 'green',
				        	'onClick' : function(e){
				        		e.preventDefault();
				        		deleteMsgReceived($msg);
				        	}
		        		  }, 
		                 { 'text': 'NO', 'theme' : 'red'}]
		      });
		}else{ //보낸 쪽지일 때 - deleteMsgSent() 호출
		    $.jAlert({
		        'title': '!!',
		        'content': '정말 삭제하시겠습니까?',
		        'theme' : 'red',
		        'closeOnClick' : true,
		        'btns': [{ 'text': 'YES', 'theme' : 'green',
		        				'onClick' : function(e){
		        					e.preventDefault();
		        					deleteMsgSent($msg);
		        				}
		        		  },
		                 { 'text': 'NO', 'theme' : 'red'}]
		      });
		}
	});
	  
	
	//이유라 작성
    $('#card_note_hd a').on('click',function(){
        $('#card_note_hd a').css({
            background: '#29AE5D',
            color: '#fff'
        });
        $(this).css({
            background: '#fff',
            color: '#666'
        });
    });

    
    // 이유라 작성 - 받은쪽지함 탭 클릭 시 UI변화
    // 오지은 ajax 추가
    $('.btn_receiveView').on('click',function(){
    	if($('.receiveNoteWrap').length){
    		//내용물이 이미 존재하면 다시 받아오지 않음
            $('.card_note_bd').hide();
            $('#card_receiveNote_bd').show();
    	}else{
    		$.ajax({
    			url : "getMsgListReceived",
    			type : "POST",
    			dataType : "JSON",
    			success : function(data) {
    				$('#card_receiveNote_bd').append(returnMsgs(data.list, "r"));    				
    	            $('#card_sendNote_bd').hide();
    	            $('#card_receiveNote_bd').show();
    			}
    		});
    	}
    });
    
    
    // 이유라 작성 - 보낸쪽지함 탭 클릭 시 UI변화
    // 오지은 ajax 추가
    $('.btn_sendView').on('click',function(){
    	if($('.sendNoteWrap').length){
    		//내용물이 이미 존재하면 다시 받아오지 않음
            $('.card_note_bd').hide();
            $('#card_sendNote_bd').show();
    	}else{
    		$.ajax({
    			url : "getMsgListSent",
    			type : "POST",
    			dataType : "JSON",
    			success : function(data) {
    				$('#card_sendNote_bd').append(returnMsgs(data.list, "s"));
    				$('#card_receiveNote_bd').hide();
    	            $('#card_sendNote_bd').show();
    			}
    		});
    	}
    });
    
    
    // 오지은 작성 - ajax로 받아온 메세지 목록들을 html 태그로 만들어 반환하는 함수
    function returnMsgs(msgs, type){
    	var msg = '';
    	$.each(msgs, function(index, entry){
    		if(type=="r"){
    			//받은 메세지 탭일 경우
    			msg+= '<div class="noteWrap receiveNoteWrap">'
			    			+'<div class="noteWrap_hd">'
			    				+'<input type="hidden" class="this_msg_id" value="'+entry.msg_id+'">'
								+'<a class="noteId" href="userpage?usr_id='+entry.msg_from+'">FROM : '+entry.msg_from_studentID+' '+entry.msg_from_nickname+'</a>'
								+'<p class="noteDate">'+entry.msg_date+'</p>'
								+'<a href="#" class="btn_note replyNote">답장</a>'
								+'<a href="#" class="btn_note btn_deleteNote receiveNote">삭제</a>';
    		} 
    		else{
    			//보낸 메세지 탭일 경우
	    		msg+= '<div class="noteWrap sendNoteWrap">'
							+'<div class="noteWrap_hd">'
								+'<input type="hidden" class="this_msg_id" value="'+entry.msg_id+'">'
								+'<a class="noteId" href="userpage?usr_id='+entry.msg_to+'">TO : '+entry.msg_to_studentID+' '+entry.msg_to_nickname+'</a>'
								+'<p class="noteDate">'+entry.msg_date+'</p>'
								+'<a href="#" class="btn_note btn_deleteNote sendNote">삭제</a>';
    		} 
			
    		msg +=			  '<hr>'
    						+'</div>' //noteWrap_hd 끝
    						+'<div class="noteWrap_bd">'
    							+'<p>'+entry.msg_text+'</p>'
    							+'<a href="#" class="noteMore">>> more</a>'
    						+'</div>' //noteWrap_bd 끝
    					+'</div>';//noteWrap 끝
    	});
    	return msg;
    }
    
    //이유라 작성
    //쪽지 내용 더보기/숨기기 버튼 띄우기
    $(document).on('mouseenter','.noteWrap',function(){
    	$('.noteMore',this).fadeIn(300).show();  
    });
    $(document).on('mouseleave','.noteWrap',function(){
    	$('.noteMore',this).fadeOut(300).hide();
    });
    
    //쪽지 내용 더보기/숨기기 기능
    $(document).on('click','.noteMore',function(){
        if( $(this).text() == '>> more' ){
            $(this).parent().css({
                height: 200,
                overflow: 'visible'
            });
            $(this).fadeOut(300).hide();
            $(this).text('hide <<');
        }
        else if( $(this).text() == 'hide <<' ){
            $(this).parent().css({
                height: 50,
                overflow: 'hidden'
            });
            $(this).fadeOut(300).hide();
            $(this).text('>> more');
        }
        return false;
    });
    
});
