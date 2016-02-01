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
	$('.doublebutton').on('click',function(){
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var email = $('.id input').val()+'@'+$('.adress input').val();
		if($('.id input').val()==""||$('.adress input').val()==""){
			alert('이메일을 올바르게 입력하시오.');
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
						alert('사용할 수 있는 이메일 입니다.');
					}
					else
					{
						alert('이메일이 중복됩니다');
					}
				}
			});
		} 	
	});
	$('.button').on('click',function(){
		var mail = $('.id input').val()+'@'+$('.adress input').val();
		var pw = $('.passwordcorrect input').val();
		$('#m_mail').attr('value',mail);
		$('#m_pw').attr('value',pw);
		var form = $("form[name=sendForm]").serialize();
		$.ajax({/******************************************************/
				url: "InsertJoinInfo",
				data: form,
				dataType: 'JSON',
				async: false,
				type: 'POST',
				success: function (data) {
					if(data.m_id==null){
						alert('회원가입 실패');	
					}
					else{
						alert('회원가입 성공');
						location.href="menu=loginsuccess";
					}
				}
		});
	});
});
</script>
</head>
<body>
<form action = "" method="post" name="sendForm">
이메일
<div class = "mail">
	<span class = "id">
		<input type = "text" name="mail" placeholder = "이메일을 입력해주세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일을 입력해주세요.'">
	</span> 
	<span>@</span>
	<span class = "adress">
		<input type = "text" name="adress">
	</span>
	<input type="hidden" id="m_mail" name="m_mail">
	<span class = "double">
		<input type = "button" value = "중복확인" class = "doublebutton">
	</span>						 
</div>
<br>
비밀번호
<div class = "password">
	<input type = "password" name="pw" placeholder = "비밀번호를 입력해주세요.(4자 이상)" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호를 입력해주세요.(4자 이상)'">
</div>
<br>
비밀번호확인
<div class = "passwordcorrect">
	<input type = "password" name="pw_correct" placeholder = "비밀번호를 한번 더 입력해주세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호를 한번 더 입력해주세요.'">
</div>
<input type="hidden" id="m_pw" name="m_pw">
<br>
성별
<div>
<input type="radio" id="radio1" name="m_gender" value="male">
  	<label for="radio1">남자</label>
<input type="radio" id="radio2" name="m_gender"value="female">
	<label for="radio2">여자</label>
</div>
<br>
관심분야

<br>
학번
<div>
<input type = "text" name="m_studentID" maxlength="2">
</div>
<br>
닉네임
<div>
<input type = "text" name="m_nickname" maxlength="14" placeholder = "닉네임을 입력해 주세요 (최대 14자)" onfocus="this.placeholder = ''" onblur="this.placeholder = '닉네임을 입력해 주세요 (최대 14자)'">
</div>
<br>
자기소개
<div>
<input type = "text" name="m_introduce" maxlength="17" placeholder = "자신을 표현해 보세요! (1~17자)" onfocus="this.placeholder = ''" onblur="this.placeholder = '자신을 표현해 보세요! (1~17자)'">
</div>
<br>
</form>
<div>
<input type = "submit" value = "가입" class = "button">
</div>
</body>
</html>