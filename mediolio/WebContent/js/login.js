$(function(){
	$('#btn_mdLogin').on('click',function(){
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var email = $('#mail').val();
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
				data : {m_mail: $('#mail').val(), pw: $('#pw').val()},
				cache : false,
				async : false,
				dataType : "JSON",
				success : function(response) {								
					if($('#pw').val()==response.m_pw)
					{
						location.href='main';
						
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
});