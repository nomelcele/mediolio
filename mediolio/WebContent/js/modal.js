$('document').ready(function(){
    
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
/*    $('#btn_likeCategory').on('click',function(){
        $('#modal_likeCategory, .modal_bg2').hide();
        $('.modal_bg').show();
    })*/
    
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


function writeDCategoryModalOpen(){
   	// 카테고리 선택 안 하고 세부카테고리 선택 클릭했을 때
	if($("#selectedCategory").val() == 0){
		alert("카테고리를 선택해주세요.");
	} else {
		$('body').addClass('preventScroll');
	    $('.modal_bg, #modal_writeDCategory').show();
	    
	    
	    $('#btn_writeDCategory').on('click',function(){
	    	var arr = $(":checkbox:checked");
	     	var str = "";
	     	if($(arr).size() == 0){
	     		alert("세부카테고리를 선택해주세요.");
	     	} else {
		     	$(".card_tag").html("");
		    	for(var i=0; i<arr.length; i++){
		    		var el = arr[i];
		    		str += "<span><input type='hidden' class='subCategory' value="+$(el).val()+">"+$(el).parent().find(".label_category").html()+"</span>";
		    		$(".card_tag").append("<span><input type='hidden' class='subCategory' value="+$(el).val()+">"+$(el).parent().find(".label_category").html()+"</span>");
		    		if(i<arr.length-1){
		    			str += ", "
		    			$(".card_tag").append(", ");
		    		}
		    	}
		    	
		    	$('.modal_bg, .modal').hide();
		    	$("#write_dCategory a").html(str);
		    	$('body').removeClass('preventScroll');

	     	}
	    });
	    
//		sb.append("\"<input type='checkbox' value="+scIds[i]+" data-labelauty='"+scNames[i]+"'/>");
//		sb.append("<label class='label_category'>"+scNames[i]+"</label>");

//	    $("#modal_bd_writeDCategory ul").html("<li>"+scList[i]+"</li>");
		$("#modal_bd_writeDCategory ul").html("<li><input type='checkbox' value='0' data-labelauty='프로젝트'/><label class='label_category'>프로젝트</label></li>"+
				"<li><input type='checkbox' value='1' data-labelauty='과제'/><label class='label_category'>과제</label></li>");
		
		$(":checkbox").labelauty({ label: false });
	    
	    // 1. 선택한 카테고리를 가지고 세부 카테고리 검색
//	    $.ajax({
//	    	type: "POST",
//	    	url: "subcategoryList",
//	    	data: {
//	    		sc_parent: $("#selectedCategory").val()
//	    	},
//	    	dataType: "json",
//	    	success: function(jdata){
//	    		var scList = jdata;
//	    		var codes = "";
//	    		for(var i=0; i<scList.length; i++){
//	    			codes += "<li>"+scList[i]+"</li>";
//	    		}
//	    	    // 2. 세부 카테고리 목록 출력
//	    	    $("#modal_bd_writeDCategory ul").html(codes);
//	    	    $(":checkbox").labelauty({ label: false });
//	    	}
//	    });
	}
}    

function writeEmbedModalOpen(){
	$('body').addClass('preventScroll');
    $('.modal_bg, #modal_writeEmbed').show();
    
    $('#btn_writeEmbed').on('click',function(){
        $('.modal_bg, .modal').hide();
    	$('body').removeClass('preventScroll');
    })
}


//인덱스 모달 추가
function contentModalOpen(a, type){
	$('body').addClass('preventScroll');
    $('#modal_content').parents('.modal_bg').animate({ scrollTop: 0 })
    
    $('.modal').css({ 
        position:'static',
        left:0,
        top:0
    });
    $(".project_loading").css("display","block");

	var anchor = a;
    
	var open_p_id;
	var open_m_id;
	
	if(type=="index"){
/*		open_p_id = $(anchor).closest(".cardWrap").find(".projectId").val();
		open_m_id = $(anchor).closest(".cardWrap").find(".memberId").val();*/
	}else if(type=="friend"){
		open_p_id = (($(anchor).attr('href')).split('='))[1];
		open_m_id = $(anchor).closest("li").find(".memberId").val();
	}else if(type=="myProj"){
		open_p_id = (($(anchor).attr('href')).split('='))[1];
		open_m_id = $('#contentsWrap').find('.memberId').val();
	}else if(type=="likeProj"){
		var href= $(anchor).attr('href');
		open_p_id = href.substr(href.indexOf("=")+1, 1);
		open_m_id = href.substr(href.lastIndexOf("=")+1, 1);
	}
	
	$.ajax({
		url : "projectView",
		type : "POST",
		data : {
			p_id: open_p_id, 
			m_id: open_m_id
		},
		success : function(data) {
			$('.modal_bg').css({ overflowY:'scroll'});
		    $('.modal_bg, #modal_content, #modal_content_userInfo').show();

		}
	});
	
    $(".project_loading").css("display","none");

}


//쪽지보내기 모달
function noteModalOpen(step, oponent_id, oponent_name){
	var send_to, send_to_name;
	if(step=='somebody'){
		//메세지 페이지에서 열었을 경우
		send_to=0;
		send_to_name='';
	}else if(step=='modal'){
		//페이지 상세보기 페이지에서 열었을 경우
		send_to = $('#other_m_id').val();
		send_to_name = $('#other_nickname').val();
	}else if(step=='certain'){
		//특정인에게 보낸 경우
		// - 받은쪽지 목록에서 답장하는 경우
		// - usermypage에서 해당 페이지 주인에게 쪽지보내는 경우
		console.log(oponent_id + ", " + oponent_name);
		send_to = oponent_id;
		send_to_name=oponent_name;
	}
	
	$.ajax({
		url : "msgModalOpen",
		type : "POST",
		data : {m_id: send_to, m_nickname: send_to_name},
		success : function(data) {
			$("#modalBox2").html(data);
			location.href="#msgSend";
			//console.log('success : ' + step);
			
			$('body').addClass('preventScroll');
		    $('.modal_bg, #writeNoteWrap').show();
		    
		    
			$('#btn_sendNote').on('click', function(){
				msgSend(step);
			});
			
		    $('.modal_bg2').on('click',function(){
		    	$('.modal_bg, .modal').hide();
		        if(step=='modal'){
		        	//프로젝트 상세보기 모달에서 열었을 경우
		        	$('.modal_bg').show();
		        }
		    });
		}
	});
	
}

function msgSend(step){
	$.ajax({
		url: "msgSend",
		type: "POST",
		data: $('#msgForm').serialize(),
		dataType : "json",
		success : function(data) {
			alert("쪽지를 보냈습니다.");
			
			$('.modal_bg2, #writeNoteWrap').hide();
			if(step=='modal'){
		    	//프로젝트 상세보기 모달에서 열었을 경우
		    	$('.modal_bg').show();
			}
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
/*$(function(){
	$("#reply_form textarea").keypress(function(e){
	    if(e.which == 13) {
	    	submitReply();  // 이벤트 실행
	    }   
	});
});*/
/*function handleEnter (field, event, num) {
    // 눌려진 키 코드를 가져온다.
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;   

    // Enter 키가 눌린 경우
    	if (keyCode == 13) {
    		event.keyCode = null;
            	if(num == 1){
            		if($('#writeReplyWrap textarea').val()!='')
            		submitReply();// 엔터키가 눌렸을 때 처리할 코드
                }
        }

}*/

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