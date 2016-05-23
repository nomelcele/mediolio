
function msgSend(){
	if(!$("#writeNoteWrap #input_noteTo").prop('disabled')){
		//보낼 대상을 fix하지 않은 경우
		$.jAlert({
		    'title': '!!',
		    'content': '보낼 대상을 정확히 선택하세요',
		    'theme': 'black',
		    'size': 'xsm'
		  });
	}else if($('#msgForm textarea').val().length<6){
		$.jAlert({ //this is the normal usage
		    'title': '!!',
		    'content': '다섯 자 이상 입력하세요',
		    'theme': 'black',
		    'size': 'xsm'
		  });

	}else{
		
		$.ajax({
			url: "msgSend",
			type: "POST",
			data: $('#msgForm').serialize(),
			dataType : "json",
			success : function(data) {
				alert("쪽지를 보냈습니다.");
				
				$('.modal_bg, #writeNoteWrap').hide();
			}
		});
	}
}

//받는 사람 자동완성
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
    			var codes = "";
    			$.each(data.list, function(index, entry){
    				codes += "<li onclick='set_to_mid(this,"+entry.m_id+")'>"
    								+"<span class='memberName'>"+entry.m_studentID +' ' + entry.m_name+"</span>"
    							+"</li>";
    			});
    			if(data.list.length>0){
    				$("#msgAutoCompleteArea").html(codes).show();
        			$(".msgAutoCompleteBox").css({
        				display: "block"
        			});
    			}else if(data.list.length == 0){
    				$("#msgAutoCompleteArea").html("<li><span>검색 결과가 없습니다.</span></li>").show();
        			$(".msgAutoCompleteBox").css({
        				display: "block"
        			});
    			}
    		}
    	});
    }else {
		$(".msgAutoCompleteBox").css("display","none");
	}
}

function set_to_mid(li, to_mid){
	$('#msgForm input').val(to_mid);
	$('#input_noteTo').val($(li).text());
	$('.msgAutoCompleteBox').css("display","none");
	$('#msgAutoCompleteArea').empty();
	
	//input 수정 불가하게 막기
	$("#writeNoteWrap #input_noteTo" ).prop('disabled', true);
}

$(function(){
	/*
	 * 쪽지 받을 사람 자동완성
	 */
	$(document).on('keydown', '#input_noteTo', function(event){
		var keyword = document.getElementById('input_noteTo');
		autoCompleteWhoReceive(keyword.value);
		
	});
})