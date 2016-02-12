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
					appendMsg += '<li class="bell_content"><a href="#">'+entry.msg_from_nickname+'님이 메시지를 보냈습니다.</a></li>';
				});
				$('#mCSB_2_container').append('<li class="bell_sort">메시지</li>'+appendMsg);
			}
			if(result.act.length>0){
				$.each(result.act, function(index, entry){
					if(entry.act_type == 'like'){
						appendAct += '<li class="bell_content"><a href="#">'+entry.m_nickname+'님이 '+entry.p_title+' 프로젝트를 <span class="bell_like">좋아요</span> 하였습니다.</a></li>';
					}else if(entry.act_type == 'follow'){
						appendAct += '<li class="bell_content"><a href="#">'+entry.m_nickname+'님이 <span class="bell_follow">팔로우</span> 하였습니다.</a></li>';
					}else if(entry.act_type=="reply"){
						appendAct += '<li class="bell_content"><a href="#">'+entry.m_nickname+'님이 '+entry.p_title+' 프로젝트에 <span class="bell_reply">댓글</span>을 달았습니다.</a></li>';
					}
				});
				$('#mCSB_2_container').append('<li class="bell_sort">소식</li>'+appendAct);
			}
			$('#bubble_bell, #bubbleAfter').show();  
		}//success함수 끝
	});
	
}
	
$(function(){
	var login=$('#hidden_m_id').val();
	if(typeof login != 'undefined') send_message(login);
	
	$('#btn_logout').click(function(){
		disconnect();
		location.href="logout";
	});
});