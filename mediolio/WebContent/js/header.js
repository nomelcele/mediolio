

	/*  푸시알림을 위한 Websocket 관련 javascript
	 *  오지은 작성
	 * */

	var websocket;

	//헤더에 종모양 아이콘(#bellIcon)이 있을 때(=로그인했을때) 객체 생성
	function init() {
		output = document.getElementById("bellIcon");
	}
	
	function send_message(m_id) {
		// 웹소켓 생성
		// spring - "ws://localhost:8089/mediolio/websocket?id="+m_id;
		// 서버에 올릴 용 - "ws://52.79.195.100:8080/mediolio/websocket?id="+m_id;
		var wsUri = "ws://52.79.195.100:8080/mediolio/websocket?id="+m_id;
		websocket = new WebSocket(wsUri);
		
		//WebSocket 연결
		websocket.onopen = function(evt) {
			websocket.send("login");
		};
		
		//서버에서 메시지가 왔을 때 호출되는 메소드
		websocket.onmessage = function(evt) {
			//알림 갯수 표시
			if(evt.data != '0') $('#bellIcon').append('<span id="bellNum">'+evt.data+'</span>');
		};
		
		//전송 에러 발생
		websocket.onerror = function(evt) {
			disconnect();
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
	
	//리스너 등록
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
    	timeDisplay = diffHour+"시간 "+ diffHour+"분 전 ";
    }else if(diffMin){
    	//한시간 이내의 시간차
    	timeDisplay = diffMin+"분 전";
    }else if(diffSec){
    	//1분 이내의 시간차
    	timeDisplay = diffSec +"초 전";
    };
    return timeDisplay;
}


//메세지 알림 목록 받아와 뷰에 표시
function getMsgNotifications(){
	$.ajax({
		url: "getMsgNotifications",
		type: "POST",
		data: {m_id :$('#hidden_m_id').val()},
		dataType:"JSON",
		success: function(result){
			var appendMsg= '';
			if(result.msg.length>0){
				$.each(result.msg, function(index, entry){
					appendMsg += '<li class="bell_content">'
											+'<a href="#" class="bell_msg">'
												+'<span class="bell_what"><span>'+entry.msg_from_nickname+'</span> 님이 쪽지를 보냈습니다.</span>'
												+'<span class="bell_date">'+timeGapCalculate(entry.msg_date)+'</span>'
												+'<span class="ellipsis msg_text">'+entry.msg_text+'</span>'
											+'</a>'
										+'</li>';
				});
				$('#bellContent01').empty().append(appendMsg);
			}
			$('#bubble_bell, #bubbleAfter').show();  
		}//success함수 끝
	});
	
}

//팔로우 관련 알림 목록 받아와 뷰에 표시
function getFollowNotifications(){
	$.ajax({
		url: "getFollowNotifications",
		type: "POST",
		data: {m_id :$('#hidden_m_id').val()},
		dataType:"JSON",
		success: function(result){
			var appendMsg= '';

			if(result.msg.length>0){
				$.each(result.msg, function(index, entry){
					appendMsg += '<li class="bell_content">'
											+'<a href="#" class="bell_follow">'
												+'<span class="bell_what"><span>'+entry.m_studentID+' '+ entry.m_name + '</span> 님이 팔로우 했습니다.</span>'
												+'<span class="bell_date">'+timeGapCalculate(entry.act_date)+'</span>'
											+'</a>'
										+'</li>';
				});
				$('#bellContent02').empty().append(appendMsg);
			}
		}
	})
}

//댓글 알림 목록 받아와 뷰에 표시
function getReplyNotifications(){
	$.ajax({
		url: "getReplyNotifications",
		type: "POST",
		data: {m_id :$('#hidden_m_id').val()},
		dataType:"JSON",
		success: function(result){
			var appendMsg= '';

			if(result.msg.length>0){
				$.each(result.msg, function(index, entry){
					appendMsg += '<li class="bell_content">'
											+'<a href="projectView?m_id='+entry.author_m_id +'&p_id='+ entry.p_id+'" class="bell_reply">'
												+'<span class="bell_what"><span>'+entry.m_name + '</span></span> 님이'
												+'<span class="ellipsis bell_prjname">'+entry.p_title+'</span><span>에 댓글을 달았습니다</span>'
												+'<span class="bell_date">'+timeGapCalculate(entry.act_date)+'</span>'
											+'</a>'
										+'</li>';
				});
				$('#bellContent03').empty().append(appendMsg);
			}
		}
	})
}

$(function(){
	//로그인 했을 때  websocket 시작
	var login=$('#hidden_m_id').val();
	if(typeof login != 'undefined') send_message(login);
	
	//로그아웃 버튼 클릭시
	$('#btn_logout').click(function(){
		disconnect();
		location.href="logout";
	});
	
	//알림 쪽지목록 클릭했을 때
	$(document).on('click', '.bell_msg', function(){
		//쪽지페이지 열기
		openMyMsgPage();
		//해당 쪽지 읽음 처리
		
	});
	
	//알림 팔로우목록 클릭했을 때
	$(document).on('click', '.bell_follow', function(){
		//친구 페이지 열기
		openMyFriendPage();
		
	});
});