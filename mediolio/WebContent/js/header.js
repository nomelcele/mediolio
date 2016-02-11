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
			alert("success");
		}
	});
	//$('#bubble_bell, #bubbleAfter').show();  
}
	
$(function(){
	alert("header");
	var login=$('#hidden_m_id').val();
	if(typeof login != 'undefined') send_message(login);
	
	$('#btn_logout').click(function(){
		disconnect();
		location.href="logout";
	});
});