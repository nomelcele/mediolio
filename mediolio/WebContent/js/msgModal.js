
	/*  메세지 보내기 모달(msgModal.jsp)에 관련된 javascript
	 *  이유라 - UI 관련 javascript
	 *  오지은 - 기능 관련 javasciript
	 * */

//오지은 작성 - 메세지 send 버튼 눌렀을 때 호출
function msgSend(){
	if(!$("#writeNoteWrap #input_noteTo").prop('disabled')){
		//보낼 대상을 fix하지 않은 경우
		$.jAlert({
		    'title': '!!',
		    'content': '보낼 대상을 정확히 선택하세요',
		    'theme' : 'red',
		    'closeOnClick' : true,
		    'size': 'xsm'
		  });
	}else if($('#msgForm textarea').val().length<6){
		//메세지가 너무 짧은 경우
		$.jAlert({
		    'title': '!!',
		    'content': '다섯 자 이상 입력하세요.',
		    'theme' : 'red',
		    'closeOnClick' : true,
		    'size': 'xsm'
		  });

	}else{
		//메세지를 보낼 수 있는 경우
		$.ajax({
			url: "msgSend",
			type: "POST",
			data: $('#msgForm').serialize(),
			dataType : "json",
			success : function(data) {
				$.jAlert({
				    'title': '!!',
				    'content': '쪽지를 보냈습니다.',
				    'theme' : 'blue',
				    'closeOnClick' : true,
				    'size': 'xsm'
				  });
				
				$('.modal_bg, #writeNoteWrap').hide(); //이유라 작성 - 메세지 모달 숨기기
			}
		});
	}
}

//오지은 작성 - 받는 사람 자동완성(input란에 타이핑 할 때 호출)
function autoCompleteWhoReceive(whom){
    if( whom.trim() != "" && whom.trim().length>1){
    	$('#msgForm input').val('');
    	$.ajax({
    		type: "POST",
    		url: "autoCompleteWhoReceive",
    		data: {
    			m_name:  whom.trim()
    		},
    		dataType: "json",
    		success: function(data){
    			//검색한 이름에 매칭되는 회원들이 json 형태로 리턴
    			//html로 가공하여 동적으로 append
    			var codes = "";
    			$.each(data.list, function(index, entry){
    				codes += "<li onclick='set_to_mid(this,"+entry.m_id+")'>"
    								+"<span class='memberName'>"+entry.m_studentID +' ' + entry.m_name+"</span>"
    							+"</li>";
    			});
    			if(data.list.length>0){
    				$("#msgAutoCompleteArea").html(codes).show();
        			$(".msgAutoCompleteBox").css({ //css 이유라 작성
        				display: "block"
        			});
    			}else if(data.list.length == 0){
    				$("#msgAutoCompleteArea").html("<li><span>검색 결과가 없습니다.</span></li>").show();
        			$(".msgAutoCompleteBox").css({ //css 이유라 작성
        				display: "block"
        			});
    			}
    		}
    	});
    }else {
		$(".msgAutoCompleteBox").css("display","none"); //css 이유라 작성
	}
}

//오지은 작성 - 자동완성으로 검색된 회원목록을 클릭했을 때 호출되는 함수
function set_to_mid(li, to_mid){
	$('#msgForm input').val(to_mid);
	$('#input_noteTo').val($(li).text());
	$('.msgAutoCompleteBox').css("display","none");
	$('#msgAutoCompleteArea').empty();
	
	//input 수정 불가하게 막기
	$("#writeNoteWrap #input_noteTo" ).prop('disabled', true);
}

$(function(){

	 // 오지은 작서 - keyevent 쪽지 받을 사람 자동완성
	$(document).on('keydown', '#input_noteTo', function(event){
		var keyword = document.getElementById('input_noteTo');
		autoCompleteWhoReceive(keyword.value);
		
	});
})