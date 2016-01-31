<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<title>Insert title here</title>
</head>
<body>
			로그인
			<form action = "" method="post">
				<div class = "l_id">
					<input type = "text" name="m_mail" placeholder = "이메일을 입력하세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일을 입력하세요.'" class = "mail"/>
				</div>
				<div class = "l_pw">	
					<input type = "password" name="m_pw" placeholder = "비밀번호를 입력하세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호를 입력하세요.'" class = "pw"/>
				</div>
			</form>
			<div class = "loginbotton">
				<input type = "submit" value = "로그인" class="l_button">
			</div>
			<div class = "other">
				<div class = "join"><a href = "/mediolio/menu=join" target = "_self">회원가입</a></div>
				<div class = "password"><a href = "/mediolio/menu=password" target = "_self">비밀번호 찾기</a></div>
			</div>
</body>
</html>