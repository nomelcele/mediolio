<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
	var wsUri = "ws://localhost:8089/mediolio/websocket/echo";

	function init() {
		output = document.getElementById("output");
	}

	function send_message() {
		// 웹소켓 생성
		websocket = new WebSocket(wsUri);
		
		//WebSocket 연결
		websocket.onopen = function(evt) {
			onOpen(evt)
		};
		//메시지가 왔을 때 호출되는 메소드
		websocket.onmessage = function(evt) {
			onMessage(evt)
		};
		//전송 에러 발생
		websocket.onerror = function(evt) {
			onError(evt)
		};
		//WebSocket 연결 끊기
		websocket.onclose = function(evt){
			onClose(evt);
		};
		
	}

	//WebSocket 연결
	function onOpen(evt) {
		writeToScreen("Connected to Endpoint!");
		doSend("login");
	}
	//메시지 수신	
	function onMessage(evt) {
		writeToScreen("Message Received: " + evt.data);
	}
	//전송 에러 발생
	function onError(evt) {
		writeToScreen('ERROR: ' + evt.data);
	}
	//WebSocket 연결 끊기
	function onClose(evt){
		writeToScreen('Connection Closed!');
	}

	function doSend(message) {
		writeToScreen("Message Sent: " + message);
		websocket.send(message);
		//websocket.close();
	}

	function disconnect(){
        if (websocket) {
        	websocket.close();
        	websocket = null;
        }
	}
	
	function writeToScreen(message) {
		var pre = document.createElement("p");
		pre.style.wordWrap = "break-word";
		pre.innerHTML = message;
		output.appendChild(pre);
	}

	window.addEventListener("load", init, false);
	
	$(function (){
		$('.l_button').on('click',function(){
			$.ajax({
				url : "LoginInfo",
				type : "Post",
				data : {m_mail: $('.mail').val(), pw: $('.pw').val()},
				cache : false,
				async : false,
				dataType : "JSON",
				success : function(response) {								
					if($('.pw').val()==response.m_pw)
					{
						send_message();
					}
					else if(response.m_id==null){
						alert('가입되지 않은 사용자 입니다.');
					}
					else
					{
						alert('비밀번호가 일치하지 않습니다.');
					}	
				}
			});
		});
	});
</script>
</head>
<body>
			로그인
			<form method="post">
				<div class = "l_id">
					<input type = "text" name="m_mail" placeholder = "이메일을 입력하세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일을 입력하세요.'" class = "mail"/>
				</div>
				<div class = "l_pw">	
					<input type = "password" name="m_pw" placeholder = "비밀번호를 입력하세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호를 입력하세요.'" class = "pw"/>
				</div>
			</form>
			<div class = "loginbotton">
				<input type = "submit" value = "로그인" class="l_button">
				<input onclick="disconnect()" value="Disconnect" type="button">
			</div>

	<div id="output"></div>
</body>
</html>