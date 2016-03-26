/*
 *	websocket 시작    **********************
 * (notification 기능) *********************
 */
	var websocket;

	function init() {
		output = document.getElementById("bellIcon");
	}
	
	function send_message(m_id) {
		console.log("m_id : " + m_id);
		// 웹소켓 생성
		var wsUri = "ws://localhost:8089/mediolio/websocket?id="+m_id;
		websocket = new WebSocket(wsUri);
		
		//WebSocket 연결
		websocket.onopen = function(evt) {
			websocket.send("login");
		};
		
		//메시지가 왔을 때 호출되는 메소드
		websocket.onmessage = function(evt) {
			if(evt.data != '0') $('#bellIcon').append('<span id="bellNum">'+evt.data+'</span>');
		};
		
		//전송 에러 발생
		websocket.onerror = function(evt) {
		
		};
		//WebSocket 연결 끊기
		websocket.onclose = function(evt){
		
		};
	}

	function disconnect(){
        if (websocket) {
        	websocket.close();
        	websocket = null;
        }
	}

	window.addEventListener("load", init, false);

/*
 *	websocket 끝    **********************
 */

//sql datetime 타입을 javascript Date 형식으로 변환
function timeGapCalculate(pushed_date){	
	var conversion = (pushed_date).split(/[. :]/);
	var old = new Date(conversion[0], conversion[1]-1, conversion[2], conversion[3], conversion[4], conversion[5]);
    var now = new Date();
    
    var dateGap = now.getTime() - old.getTime();
    var timeGap = new Date(0, 0, 0, 0, 0, 0, now - old);
    
    var diffDay  = Math.floor(dateGap / (1000 * 60 * 60 * 24)); // 일수       
    var diffHour = timeGap.getHours();       // 시간
    var diffMin  = timeGap.getMinutes();      // 분
    var diffSec  = timeGap.getSeconds();      // 초
	
    var timeDisplay;
    if(diffDay>30){
    	//1달 이상의 시간차는 날짜 표시
    	var dateArr = (pushed_date).split(" ");
    	timeDisplay = dateArr[0];
    }else if(diffDay){
    	//하루 이상 한달 이내의 시간차
    	timeDisplay = diffDay+"일 전";
    }else if(diffHour){
    	//하루 이내의 시간차
    	timeDisplay = diffHour+"시간 " +diffMin+ "분 전";
    }else if(diffMin){
    	//한시간 이내의 시간차
    	timeDisplay = diffMin+"분 전";
    }else if(diffSec){
    	//1분 이내의 시간차
    	timeDisplay = diffSec +"초 전";
    };
    return timeDisplay;
}

//푸쉬알림 목록 받아오기
function getNotifications(){
	$.ajax({
		url: "getNotifications",
		type: "POST",
		data: {m_id :$('#hidden_m_id').val()},
		dataType:"JSON",
		success: function(result){
			$('#mCSB_2_container').empty();
			
			var appendMsg= '';
			var appendAct ='';
			if(result.msg.length>0){
				$.each(result.msg, function(index, entry){
					appendMsg += '<li class="bell_content">'
											+'<img src="resources/images/push/push_msg.png">'
											+'<a href="#" class="bell_msg">'
												+'<span>'+entry.msg_from_studentID +' '+entry.msg_from_nickname+'님이 메시지를 보냈습니다.</span>'
												+'<span class="bell_date">'+timeGapCalculate(entry.msg_date)+'</span>'
												+'<span class="ellipsis msg_text"> >> '+entry.msg_text+'</span>'
											+'</a>'
										+'</li>';
				});
				$('#mCSB_2_container').append(appendMsg);
			}
			if(result.act.length>0){
				$.each(result.act, function(index, entry){
					if(entry.act_type == 'like'){
						appendAct += '<li class="bell_content">'
												+'<img src="resources/images/push/push_like.png">'
												+'<a href="#">'
													+'<span>'+entry.m_studentID +' '+entry.m_name+'님이 </span>'
													+'<span class="ellipsis">'+entry.p_title+'</span><span>를 좋아합니다</span>'
													+'<span class="bell_date">'+timeGapCalculate(entry.act_date)+'</span>'
												+'</a>'
											+'</li>';
					}else if(entry.act_type == 'follow'){
						appendAct += '<li class="bell_content">'
												+'<img src="resources/images/push/push_follow.png">'
												+'<a href="#">'
													+'<span>'+entry.m_studentID +' '+entry.m_name+'님이 회원님을 팔로우합니다</span>'
													+'<span class="bell_date">'+timeGapCalculate(entry.act_date)+'</span>'
												+'</a>'
											+'</li>';
					}else if(entry.act_type=="reply"){
						appendAct += '<li class="bell_content">'
												+'<img src="resources/images/push/push_reply.png">'
												+'<a href="#">'
													+'<span>'+entry.m_studentID +' '+entry.m_name+'님이 </span>'
													+'<span class="ellipsis">'+entry.p_title+'</span><span>에 댓글을 달았습니다</span>'
													+'<span class="bell_date">'+timeGapCalculate(entry.act_date)+'</span>'
												+'</a>'
											+'</li>';
					}
				});
				$('#mCSB_2_container').append(appendAct);
			}
			$('#bubble_bell, #bubbleAfter').show();  
		}//success함수 끝
	});
	
}
	
function goSearch(){

	$.ajax({
		url : "search",
		type : "POST",
		data : {key : $('#text_main').val(), section : $('#select_main').val()},
		dataType : "JSON",
		success : function(data) {
			alert(sss);
		}
	});
}


$(function(){
	var login=$('#hidden_m_id').val();
	//if(typeof login != 'undefined') send_message(login);
	
	$('#btn_logout').click(function(){
		disconnect();
		location.href="logout";
	});
	
	$(document).on('click', '.bell_msg', openMyMsgPage);
});