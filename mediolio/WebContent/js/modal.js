$('document').ready(function(){

	/*  각종 모달에서 행해지는 액션을 처리하는 javascript
	 *  이유라 - UI 관련 javascript
	 *  모하람/박성준/오지은 - 기능 관련 javasciript
	 * */
	
    //모달 닫기-클래스
	$('.modal_bg, .modal_scroll').click(function(e) {   
		if( !$(e.target).is( $('.modal_scroll').find('*')) &&  !$(e.target).is( $('.modal_bg2').find('*')) ) {
            $('body').removeClass('preventScroll');
            modalClose();
            
            $('body').css({
                position: 'static'
            })
        }
	})
    
    //모달 스크롤 스타일
    $('.modal_bd_dCategory').mCustomScrollbar();
    
	
	
})

function selectCategory(){
	var search_category = $( ".selectbox select option:selected" ).text();
	$('.selectbox label').text(search_category);
}

function modalClose(){
	$('.modal').attr('style','');
    
    $('.modal_bg').css({
        zIndex:100,
        overflowY:'hidden'
    });
	$('.modal_bg, .modal').hide();
	
	$('#mail').val("");
	$('#pw').val("");
	$('#id').val("");
	$('#jpw').val("");
	$('#jpw_correct').val("");
	$('#m_nickname').val("");
	$('#m_studentID').val("");
	$('#btn_addBookmark').val("관심분야 (필수 2개)");
	$('#btn_addTool').val("보유 기술");
	$("#sel_gender").text("GENDER");
	$(":checkbox[name='check']:checked").each(function () {  
		$(this).attr('checked', false);
	});
	$(":checkbox[name='skill']:checked").each(function () {  
		$(this).attr('checked', false);
	});
}

function loginModalOpen(){
	$('body').addClass('preventScroll');
	$('.modal_bg, #modal_login').show();
	
	return false;
}
    
    
    
function joinModalOpen(){
    $('body').addClass('preventScroll');
	$('#modal_login').hide();
	$('#modal_join').show();
    $('#btn_mdJoinForm').on('click',function(){
        $('.modal_bg, .modal').hide();
    })
}

var likestr="";

function likeCategoryModalOpen(){
   
    $(":checkbox").labelauty({ label: false });
    
    $('.modal_bg').hide();
    $('.modal_bg2, #modal_likeCategory').show();

    
    $('#btn_likeCategory').on('click',function(){
        $('#modal_likeCategory, .modal_bg2').hide();
        $('.modal_bg').show();
    	if($(this).attr('class')=='modal_bg2'){
    		var strarray = likestr.split(',');
    		$(":checkbox[name='check']:checked").each(function () { 
    			if($(this).val()!=strarray[0]&&$(this).val()!=strarray[1])
    			$(this).attr('checked', false);
    		});
    		$(":checkbox[name='check']").removeAttr("disabled");
    	}
    	else{
    		likestr="";
    		$(":checkbox[name='check']:checked").each(function () {  
				likestr += $(this).val() + ",";
			});
    	}

    })
    
    
    
}


function toolModalOpen(){
    $(":checkbox").labelauty({ label: false });
    
    $('.modal_bg').hide();
    $('.modal_bg2, #modal_tool').show();
    $('#btn_tool').on('click',function(){
        $('#modal_tool, .modal_bg2').hide();
        $('.modal_bg').show();
    })
    
}

// (이유라+모하람): 게시물 작성 페이지에서 세부카테고리 선택 모달 띄우는 함수
function writeDCategoryModalOpen(){
	// 모하람 작성
   	// 카테고리 선택 안 하고 세부카테고리 선택 클릭했을 때
	if($("#selectedCategory").val() == 999){
 	    $.jAlert({
 	        'title': '!!',
 	        'content': '카테고리를 선택해주세요.',
 	        'closeOnClick' : true,
 	        'theme' : 'red',
 	      });
	} else {
		// 이유라 작성
		$('body').addClass('preventScroll');
	    $('.modal_bg, #modal_writeDCategory').show();
	    
	    
	    $('#btn_writeDCategory').on('click',function(){
	    	var arr = $(":checkbox:checked");
	     	var str = "";
	     	if($(arr).size() == 0){
	     	    $.jAlert({
	     	        'title': '!!',
	     	        'content': '세부카테고리를 선택해주세요.',
	     	        'closeOnClick' : true,
	     	        'theme' : 'red',
	     	      });
	     	} else {
	     		// 모하람 작성
		     	$(".card_tag").html("");
		    	for(var i=0; i<arr.length; i++){
		    		var el = arr[i];
		    		$("input[name=cate_id]").val($(el).val());
		    		str += "<span><input type='hidden' class='subCategory' value="+$(el).val()+">"+$(el).parent().find(".label_category").html()+"</span>";
		    		$(".card_tag").append("<span><input type='hidden' class='subCategory' value="+$(el).val()+">"+$(el).parent().find(".label_category").html()+"</span>");
		    		if(i<arr.length-1){
		    			str += ", "
		    			$(".card_tag").append(", ");
		    		}
		    	}
		    	
		    	// 이유라 작성
		    	$('.modal_bg, .modal').hide();
		    	$("#write_dCategory a").html(str);
		    	$('body').removeClass('preventScroll');

	     	}
	    });
	    
	    // 모하람 작성 - 모달에 세부카테고리 목록 보여주기
		$("#modal_bd_writeDCategory ul").html("<li><input type='checkbox' value='1' data-labelauty='게임'/><label class='label_category'>게임</label></li>"+
				"<li><input type='checkbox' value='2' data-labelauty='웹&앱'/><label class='label_category'>웹&앱</label></li>"+
				"<li><input type='checkbox' value='3' data-labelauty='영상&사운드'/><label class='label_category'>영상&사운드</label></li>"+
				"<li><input type='checkbox' value='4' data-labelauty='3D'/><label class='label_category'>3D</label></li>"+
				"<li><input type='checkbox' value='5' data-labelauty='디자인'/><label class='label_category'>디자인</label></li>"+
				"<li><input type='checkbox' value='6' data-labelauty='기타'/><label class='label_category'>기타</label></li>");
		
		$(":checkbox").labelauty({ label: false });
	    
	}
}    




//(이유라+오지은) 쪽지보내기 모달 열기
function noteModalOpen(send_to, send_to_name){
	if(send_to==''){
		send_to = 0;
		send_to_name='';
	}
	
	//ajax 오지은 작성
	$.ajax({
		url : "msgModalOpen",
		type : "POST",
		data : {m_id: send_to, m_nickname: send_to_name},
		success : function(data) {
			$("#modalBox2").html(data);
			location.href="#msgSend";
			
			$('body').addClass('preventScroll'); //이유라
		    $('.modal_bg, #writeNoteWrap').show(); //이유라
		    
		    //오지은
		    if(send_to_name == ''){
				//보내는 대상을 직접 입력하는 쪽지일 경우
		    	$("#writeNoteWrap #input_noteTo" ).prop('disabled', false);
		    }else{
		    	//특정인을 지정해 쪽지보내기를 누른 경우 - 보내는 대상 수정 불가
		    	$("#writeNoteWrap #input_noteTo" ).prop('disabled', true);
		    }
		    
		    //오지은
			$('#btn_sendNote').on('click', function(){
				msgSend();
			});
			
			//이유라
		    $('.modal_bg2').on('click',function(){
		    	$('.modal_bg, .modal').hide();
		    });
		}
	});
}


function pwModalOpen() {
	$('#modal_findPw, .modal_bg').hide();
	$('.modal_bg2, #modal_findPw').show();
	
	$('.modal_bg2, #btn_pwSend').on('click', function() {
		$('#modal_findPw, .modal_bg2').hide();
		$('.modal_bg').show();
		$('#fpw_email').val("");
		
	})

}


function modalScroll(){
    var currentTop = $('#modal_content').offset().top;
    scrollAmount = 200;
    
    if( delta > 0 ) {  //delta > 0 : 마우스 휠을 위로 올림
        prevSize = $(this).prev().height();
        $('#modal_content').stop().animate( {top:currentTop + scrollAmount} )          
        if(currentTop >= 0 ){
            $('#modal_content_userInfo').stop().animate({
                top: 100
            });
            $('#modal_content').stop().animate({
                top: 100
            });
        }
    }//마우스휠 위로 올릴 때 끝
    
    else {  //마우스휠 아래로 내릴 때
        nextSize = $(this).next().height();
        $('#modal_content').stop().animate( {top: currentTop - scrollAmount} )
        
        if(currentTop <= -($('#modal_content').height() - $(window).height()) ){
            $('#modal_content').stop();
        }      
        if(currentTop <= 100){
            $('#modal_content_userInfo').stop().animate({
                top: 0 
            });
        }          
    }//마우스휠 아래로 내릴 때 끝   
}

function modalResize(){
	$(window).resize(function(){
		var win_w = $(window).width();
		var win_h = $(window).height();
		
		var movImg_w = $('.modal').width();
		var movImg_h = $('.modal').height();
		
		var movImg_posX = (win_w - movImg_w)/2;
		var movImg_posY = (win_h - movImg_h)/2;
		
		$('.modal').css({ left: movImg_posX, top: movImg_posY });
		
	}).resize();
}