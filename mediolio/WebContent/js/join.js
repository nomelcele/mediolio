$(function(){
	$('#btn_mdJoinForm').on('click',function(){
		/* var mail = $('.id input').val()+'@'+$('.adress input').val(); */
		var mail = $('#id').val();
		/* var pw = $('.passwordcorrect input').val(); */
		if($('#jpw').val()==$('#jpw_correct').val()&&$('#jpw').val().length>=4){
			$('#m_pw').attr('value',$('#jpw_correct').val());
		}
		var str="";
		$('#m_mail').attr('value',mail);
		/* $('#m_pw').attr('value',pw); */
		$(":checkbox[name='check']:checked").each(function () {  
		  str += $(this).val() + ",";  
		});
		$('#m_interestingPart').prop('value',str);
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var stdid=Number($("#m_studentID").val());
		
		if(mail==""){
			alert('이메일을 입력해주세요');
		}
		else if(!regex.test(mail)){
			alert('이메일의 형식에 맞지 않습니다.');
		}
		else if($('#m_pw').val()==""){
			alert('비밀번호를 올바르게 입력해주세요.');
		}
		else if($("#m_nickname").val()==""){
			alert('닉네임을 입력해주세요');
		}
/*		else if($("#input_gender").val()!="male"&&$("#input_gender").val()!="female"){
			alert('성별을 입력해주세요');
		}*/
		else if($("#sel_gender").text()=="GENDER"){
			alert('성별을 입력해주세요');
		}
		else if(stdid>16&&stdid<98||$("#m_studentID").val().length==0||$("#m_studentID").val().length==1){
			alert('학번을 올바르게 입력해주세요');
		}
		else if($('#m_interestingPart').val()=="LIKE"){
			alert('관심분야를 하나이상 입력해주세요');
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
										location.href="main";
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
        if( $(":checkbox[name='check']:checked").length==2 ) {
            $(":checkbox[name='check']:not(:checked)").attr("disabled", "disabled");
        }
        // 체크된 갯수가 다르면 활성화 시킴
        else {
            $(":checkbox[name='check']").removeAttr("disabled");
        }
    });
	$("#btn_likeCategory").on('click',function(){
		var str="";
		$(":checkbox[name='check']:checked").each(function () {  
			  str += $(this).parent().find(".label_category").text() + ", ";
		});
		var strr = "";
		if(str==""){
			strr="관심분야 (필수 2개)";
		}
		else{
			strr = str.slice(0,-2);
		}
		$("#btn_addBookmark").val(strr);
	});
	
	$("#modal_join input").keypress(function(e){
	    if(e.which == 13) {
	        $("#btn_mdJoinForm").click();  // 이벤트 실행
	    }   
	});
	/*$("input[name=pw]").keypress(function(e){
	    if(e.which == 13) {
	        $("#btn_mdJoinForm").click();  // 이벤트 실행
	    }   
	});
	$("input[name=pw_correct]").keypress(function(e){
	    if(e.which == 13) {
	        $("#btn_mdJoinForm").click();  // 이벤트 실행
	    }   
	});
	$("input[name=m_nickname]").keypress(function(e){
	    if(e.which == 13) {
	        $("#btn_mdJoinForm").click();  // 이벤트 실행
	    }   
	});
	$("input[name=m_studentID]").keypress(function(e){
	    if(e.which == 13) {
	        $("#btn_mdJoinForm").click();  // 이벤트 실행
	    }   
	});*/

});