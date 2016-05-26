$(function(){
	$('#btn_mdLogin').on('click',function(){
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var email = $('#mail').val();
		if(email==""){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이메일을 입력하세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if(!regex.test(email)){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이메일 형식에 맞지 않습니다.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if($('#pw').val()==""){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '비밀번호를 입력해주세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
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
			    		$.jAlert({
			    		    'title': '!!',
			    		    'content': '가입되지 않은 사용자 입니다.',
			    		    'closeOnClick' : true,
			    		    'theme' : 'red',
			    		    'size': 'xsm'
			    		  });
					}
					else
					{
			    		$.jAlert({
			    		    'title': '!!',
			    		    'content': '비밀번호가 일치하지 않습니다.',
			    		    'closeOnClick' : true,
			    		    'theme' : 'red',
			    		    'size': 'xsm'
			    		  });
					}	
				}
			});
		} 	
	});
	 
/*	$("input[name=m_mail]").keypress(function(e){
	    if(e.which == 13) {
	        $("#btn_mdLogin").click();  // 이벤트 실행
	    }   
	});
	$("input[name=m_pw]").keypress(function(e){
        if(e.which == 13) {
            $("#btn_mdLogin").click();  // 이벤트 실행
        }   
    });*/
    $("#modal_login input").keypress(function(e){
	    if(e.which == 13) {
	        $("#btn_mdLogin").click();  // 이벤트 실행
	    }   
	});
    $('#btn_pwSend').on('click',function(){
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var email = $('#fpw_email').val();
		if(email==""){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이메일을 입력하세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if(!regex.test(email)){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이메일 형식에 맞지 않습니다.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
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
			    		$.jAlert({
			    		    'title': '!!',
			    		    'content': '가입되어있지 않은 사용자입니다.',
			    		    'closeOnClick' : true,
			    		    'theme' : 'red',
			    		    'size': 'xsm'
			    		  });
						
					}
					else
					{
			    		$.jAlert({
			    		    'title': '!!',
			    		    'content': '회원님의 이메일로 임시비밀번호를 전송하였습니다.',
			    		    'closeOnClick' : true,
			    		    'theme' : 'blue',
			    		    'size': 'xsm'
			    		  });
						$('#modal_findPw').hide();
						$('.modal_bg2').hide();
						$('.modal_bg').show();
						$('#fpw_email').val("");
						$.ajax({
							url : "sendEmailAction",
							type : "Post",
							data : {m_mail: email},
							cache : false,
							async : false,
							dataType : "JSON",
							success : function(data) {								
								
							}
						});
					}
				}
			});
		} 	
	});
});