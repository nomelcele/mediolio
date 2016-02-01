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
			
			$('.findpwbtn').on('click',function(){
				var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
				var email = $('.email').val();
				if(email==""){
					alert('이메일을 입력하세요');
				}
				else if(!regex.test(email)){
					alert('이메일 형식에 맞지 않습니다.');
				}
				else{
					$.ajax({
						url : "DoubleInfo",
						type : "Post",
						data : {m_mail: email},
						cache : false,
						async : false,
						dataType : "JSON",
						success : function(response) {								
							if(response.m_id=='0')
							{
								alert('가입되어있지 않은 사용자입니다.');
								
							}
							else
							{
								alert('회원님의 이메일로 임시비밀번호를 전송하였습니다.');
								$.ajax({
									url : "sendEmailAction",
									type : "Post",
									data : {m_mail: email},
									cache : false,
									async : false,
									dataType : "JSON",
									success : function(data) {								
										location.href="menu=login";
									}
								});
							}
						}
					});
				} 	
			});
		});
</script>
</head>
<body>
비밀번호 확인
<br>
<div class = "emailbox">				
	<input type = "text" name="m_mail" class="email" placeholder = "이메일을 입력해주세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일을 입력해주세요.'">
</div>
<div class = "button">
	<input type = "submit" value = "비밀번호 찾기" class="findpwbtn">
</div>
<div class = "cancel">
	<a href = "/menu=login" target = "_self">취소</a>
</div>
</body>
</html>