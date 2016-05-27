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

	$('.button').on('click',function(){
		/* var mail = $('.id input').val()+'@'+$('.adress input').val(); */
		var mail = $('.id input').val();
		/* var pw = $('.passwordcorrect input').val(); */
		if($('.passwordcorrect input').val()==$('.password input').val()){
			$('#m_pw').attr('value',$('.password input').val());
		}
		var str="";
		$('#m_mail').attr('value',mail);
		/* $('#m_pw').attr('value',pw); */
		$(":checkbox[name='check']:checked").each(function () {  
		  str += $(this).val() + ",";  
		});
		$('#m_interestingPart').prop('value',str);
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var stdid=Number($(".m_studentID").val());
		
		if(mail==""){
			alert('이메일을 입력해주세요');
		}
		else if(!regex.test(mail)){
			alert('이메일의 형식에 맞지 않습니다.');
		}
		else if($('#m_pw').val()==""){
			alert('비밀번호를 올바르게 입력해주세요.');
		}
		else if($(":input:radio[name=m_gender]:checked").val()!="male"&&$(":input:radio[name=m_gender]:checked").val()!="female"){
			alert('성별을 입력해주세요');
		}
		else if($('#m_interestingPart').val()==""){
			alert('관심분야를 하나이상 입력해주세요');
		}
		else if(stdid>16&&stdid<98||$(".m_studentID").val().length==0||$(".m_studentID").val().length==1){
			alert('학번을 올바르게 입력해주세요');
		}
		else if($(".m_nickname").val()==""){
			alert('닉네임을 입력해주세요');
		}
		else{
			$.ajax({
				url : "DoubleInfo",
				type : "Post",
				data : {m_mail: mail},
				cache : false,
				async : false,
				dataType : "JSON",
				success : function(response) {								
					if(response.m_id!='0')
					{
						alert('이메일이 중복됩니다');
					}
					else
					{
						var form = $("form[name=sendForm]").serialize();
						$.ajax({
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
					}
				}
			});
		}
		

	});
	$("input[name='m_studentID']").keypress(function (event) {
        if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
            event.preventDefault();
        }
	});
	
	$(":checkbox[name='check']").change(function() {
        if( $(":checkbox[name='check']:checked").length==3 ) {
            $(":checkbox[name='check']:not(:checked)").attr("disabled", "disabled");
        }
        // 체크된 갯수가 다르면 활성화 시킴
        else {
            $(":checkbox[name='check']").removeAttr("disabled");
        }
    });

});

 
</script>
</head>
<body>
	<form action="" method="post" name="sendForm">
		이메일
		<div class="mail">
			<span class="id"> <input type="text" name="mail"
				placeholder="이메일을 입력해주세요." onfocus="this.placeholder = ''"
				onblur="this.placeholder = '이메일을 입력해주세요.'">
			</span>
			<!-- 	<span>@</span>
	<span class = "adress">
		<input type = "text" name="adress">
	</span> -->
			<input type="hidden" id="m_mail" name="m_mail">
			<!-- 	<span class = "double">
		<input type = "button" value = "중복확인" class = "doublebutton">
	</span>		 -->
		</div>
		<br> 비밀번호
		<div class="password">
			<input type="password" name="pw" placeholder="비밀번호를 입력해주세요.(4자 이상)"
				onfocus="this.placeholder = ''"
				onblur="this.placeholder = '비밀번호를 입력해주세요.(4자 이상)'">
		</div>
		<br> 비밀번호확인
		<div class="passwordcorrect">
			<input type="password" name="pw_correct"
				placeholder="비밀번호를 한번 더 입력해주세요." onfocus="this.placeholder = ''"
				onblur="this.placeholder = '비밀번호를 한번 더 입력해주세요.'">
		</div>
		<input type="hidden" id="m_pw" name="m_pw" value=""> <br>
		성별
		<div>
			<input type="radio" id="radio1" name="m_gender" value="male">
			<label for="radio1">남자</label> <input type="radio" id="radio2"
				name="m_gender" value="female"> <label for="radio2">여자</label>
		</div>
		<br> 관심분야
		<div class="interest">
			<input type="checkbox" name='check' value="1"> 게임<br> <input
				type="checkbox" name='check' value="2"> 웹&앱<br> <input
				type="checkbox" name='check' value="3"> 영상&사운드<br> <input
				type="checkbox" name='check' value="4"> 3D<br> <input
				type="checkbox" name='check' value="5"> 디자인<br>


		</div>
		<input type="hidden" name="m_interestingPart" id="m_interestingPart"
			value="">
		<!-- <input type = "button" value = "추가" class = "addbutton" onclick = "addcat()" > -->
		<br> 학번
		<div>
			<input type="text" name="m_studentID" maxlength="2"
				class="m_studentID">
		</div>
		<br> 닉네임
		<div>
			<input type="text" name="m_name" class="m_nickname" maxlength="14"
				placeholder="닉네임을 입력해 주세요 (최대 14자)" onfocus="this.placeholder = ''"
				onblur="this.placeholder = '닉네임을 입력해 주세요 (최대 14자)'">
		</div>
		<br> 자기소개
		<div>
			<input type="text" name="m_introduce" class="m_introduce"
				maxlength="17" placeholder="자신을 표현해 보세요! (1~17자)"
				onfocus="this.placeholder = ''"
				onblur="this.placeholder = '자신을 표현해 보세요! (1~17자)'">
		</div>
		<br>
	</form>
	<div>
		<input type="submit" value="가입" class="button">
	</div>
</body>
</html>