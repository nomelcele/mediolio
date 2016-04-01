<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<title>Insert title here</title>
<link href="css/modal.css" rel="stylesheet" type="text/css"/>
<script>
/* $(function(){
	$('.l_button').on('click',function(){
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var email = $('.mail').val();
		if(email==""){
			alert('이메일을 입력하시오.');
		}
		else if(!regex.test(email)){
			alert('이메일 형식에 맞지 않습니다.');
		}
		else{
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
						location.href='menu=loginsuccess';
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
		} 	
	});
}); */
</script>
<script src="js/modal.js"></script>
</head>
<body>
<!-- 			로그인
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
			</div> -->
<div class="modal_bg"></div>
<div class="modal_bg2"></div>
    
<div class="modal" id="modal_login">
	<div class="modal_hd"></div> 
    <div class="modal_bd" id="modal_bd_login">
    	<div id="otherLoginWrap">
            <a id="link_facebook" href="#"></a>
            <span id="otherLogin">LOGIN WITH FACEBOOK</span>
        </div>
        
        <div class="login_inputWrap inputWrap_id">
            <div class="login_smallBox"></div><input class="inputStyle2" type="text" placeholder="ID"/>
        </div>
        <div class="login_inputWrap inputWrap_pw">
            <div class="login_smallBox"></div><input class="inputStyle2" type="password" placeholder="PASSWORD"/>
        </div>
        
        <input type="button" class="btnStyle2" id="btn_mdLogin" value="LOGIN"/>
        
        <p><a href="#">FIND PASSWORD</a></p>
        
        <hr>
        <input type="button" class="btnStyle2" id="btn_mdJoin" value="JOIN" onClick="joinModalOpen()"/>
    </div><!--//modal_bd -->
</div><!--//modal_login-->
</body>
</html>