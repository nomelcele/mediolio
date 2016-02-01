<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<title>Insert title here</title>
<script>
$(function(){
$('.lo_button').click(function(){
	location.href="logout";
});
});
</script>
</head>
<body>
로그인 성공!
<div class = "logoutbutton">
	<input type = "submit" value = "로그아웃" class="lo_button">
</div>
</body>
</html>