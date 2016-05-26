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
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이메일을 입력해주세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if(!regex.test(mail)){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이메일의 형식에 맞지 않습니다.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if($('#m_pw').val()==""){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '비밀번호를 올바르게 입력해주세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if($("#m_nickname").val()==""){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이름을 입력해주세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}

		else if($("#sel_gender").text()=="GENDER"){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '성별을 입력해주세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if(stdid>16&&stdid<98||$("#m_studentID").val().length==0||$("#m_studentID").val().length==1){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '학번을 올바르게 입력해주세요.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
		}
		else if($('#m_interesting1').val()==""||$('#m_interesting2').val()==""){
    		$.jAlert({
    		    'title': '!!',
    		    'content': '관심분야를 2개 입력해주세요(필수)',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
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
			    		$.jAlert({
			    		    'title': '!!',
			    		    'content': '이메일이 중복됩니다.',
			    		    'closeOnClick' : true,
			    		    'theme' : 'red',
			    		    'size': 'xsm'
			    		  });
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
							    		$.jAlert({
							    		    'title': '!!',
							    		    'content': '회원가입 실패',
							    		    'closeOnClick' : true,
							    		    'theme' : 'red',
							    		    'size': 'xsm'
							    		  });
									}
									else{
										$(":checkbox[name='skill']:checked").each(function() {
											var allData = {"m_id" : data.m_id,  "sk_id" : $(this).val()};
											$.ajax({
												url: "InsertSkillInfo",
												data: allData,
												dataType: 'JSON',
												async: false,
												type: 'POST',
												success: function (data1) {
													if(data1.m_id==null){
											    		$.jAlert({
											    		    'title': '!!',
											    		    'content': '관련기술 입력 실패',
											    		    'closeOnClick' : true,
											    		    'theme' : 'red',
											    		    'size': 'xsm'
											    		  });
													}
												}
											});
										});
							    		$.jAlert({
							    		    'title': '!!',
							    		    'content': '회원가입 성공',
							    		    'closeOnClick' : true,
							    		    'theme' : 'blue',
							    		    'size': 'xsm'
							    		  });
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
		var count=0;
		$(":checkbox[name='check']:checked").each(function () {  
			  str += $(this).parent().find(".label_category").text() + ", ";
			  if(count==0){
				  $("#m_interesting1").val($(this).val());
				  count++;
			  }
			  else{
				  $("#m_interesting2").val($(this).val());
				  count=0;
			  }
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
	
	$("#btn_tool").on('click',function(){
		var str="";
		var count=0;
		$(":checkbox[name='skill']:checked").each(function () {
			if(str.length<30){
			  str += $(this).parent().find(".label_category").text() + ", ";
			  count++;
			}
			count--;
		});
		var strr = "";
		if(str==""){
			strr="보유 기술";
		}
		else{
			strr = str.slice(0,-2);
			if(count<0){
				strr+="...";
			}
		}
		$("#btn_addTool").val(strr);
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