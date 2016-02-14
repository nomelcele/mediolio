$('document').ready(function(){
    //윈도우 크기변경 시 모달 위치 조정
	$(window).resize(function(){
		var win_w = $(window).width();
		var win_h = $(window).height();
		
		var movImg_w = $('.modal').width();
		var movImg_h = $('.modal').height();
		
		var movImg_posX = (win_w - movImg_w)/2;
		var movImg_posY = (win_h - movImg_h)/2;
		
		$('.modal').css({ left: movImg_posX, top: movImg_posY });
		
	}).resize();
	
    //모달 닫기-클래스
	$('.modal_bg').on('click', function(){
		modalClose();
	})	
    
    //모달 스크롤 스타일
    $('.modal_bd_dCategory').mCustomScrollbar();
    
})

function selectCategory(){
	var search_category = $( ".selectbox select option:selected" ).text();
	$('.selectbox label').text(search_category);
}

function modalOpen(){
	$('.modal_bg, .modal').show();	
	return false;
}

function modalClose(){
    $('.modal_bg').css('z-index','100');
	$('.modal_bg, .modal').hide();
	
	$('#mail').val("");
	$('#pw').val("");
	$('#id').val("");
	$('#jpw').val("");
	$('#jpw_correct').val("");
	$('#m_nickname').val("");
	$('#m_studentID').val("");
	$('#btn_addBookmark').val("LIKE");
	$("#sel_gender").text("GENDER");
	$(":checkbox[name='check']:checked").each(function () {  
		$(this).attr('checked', false);
	});
	
}

function loginModalOpen(){
    var win_w = $(window).width();
	var win_h = $(window).height();
	
	var movImg_w = $('#modal_login').width();
	var movImg_h = $('#modal_login').height();
	
	var movImg_posX = (win_w - movImg_w)/2;
	var movImg_posY = (win_h - movImg_h)/2;
    
    $('#modal_login').css({ left: movImg_posX, top: movImg_posY });
	$('.modal_bg, #modal_login').show();
	

    
	return false;
}
    
    
    
function joinModalOpen(){
	var win_w = $(window).width();
	var win_h = $(window).height();
	
	var movImg_w = $('#modal_join').width();
	var movImg_h = $('#modal_join').height();
	
	var movImg_posX = (win_w - movImg_w)/2;
	var movImg_posY = (win_h - movImg_h)/2;
		
	$('#modal_login').hide();
	$('#modal_join').css({ left: movImg_posX, top: movImg_posY });
	$('#modal_join').show();
	
	
    
/*    $('#btn_mdJoinForm').on('click',function(){
        $('.modal_bg, .modal').hide();
    })*/
    
    
}

var likestr="";

function likeCategoryModalOpen(){
    var win_w = $(window).width();
	var win_h = $(window).height();
	
	var movImg_w = $('#modal_likeCategory').width();
	var movImg_h = $('#modal_likeCategory').height();
	
	var movImg_posX = (win_w - movImg_w)/2;
	var movImg_posY = (win_h - movImg_h)/2;
    
    $('#modal_likeCategory').hide();
    $(":checkbox").labelauty({ label: false });
    
	$('#modal_likeCategory').css({ left: movImg_posX, top: movImg_posY });
    
    $('.modal_bg').hide();
    $('.modal_bg2').show();
	$('#modal_likeCategory').show();
    
    $('.modal_bg2, #btn_likeCategory').on('click',function(){
    	if($(this).attr('class')=='modal_bg2'){
    		var strarray = likestr.split(',');
    		$(":checkbox[name='check']:checked").each(function () { 
    			if($(this).val()!=strarray[0]&&$(this).val()!=strarray[1]&&$(this).val()!=strarray[2])
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
        $('#modal_likeCategory').hide();
        $('.modal_bg2').hide();
        $('.modal_bg').show();
    })
    
}


function writeDCategoryModalOpen(){
	var win_w = $(window).width();
	var win_h = $(window).height();
	
	var movImg_w = $('#modal_writeDCategory').width();
	var movImg_h = $('#modal_writeDCategory').height();
	
	var movImg_posX = (win_w - movImg_w)/2;
	var movImg_posY = (win_h - movImg_h)/2;
		
	$('#modal_writeDCategory').css({ left: movImg_posX, top: movImg_posY });
    $('.modal_bg').show();
	$('#modal_writeDCategory').show();
    
    $('#btn_writeDCategory').on('click',function(){
    	var arr = $(":checkbox:checked");
     	var str = "";
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
    });
    
    // 1. 선택한 카테고리를 가지고 세부 카테고리 검색
    $.ajax({
    	type: "POST",
    	url: "subcategoryList",
    	data: {
    		sc_parent: $("#selectedCategory").val()
    	},
    	dataType: "json",
    	success: function(jdata){
    		var scList = jdata;
    		var codes = "";
    		for(var i=0; i<scList.length; i++){
    			codes += "<li>"+scList[i]+"</li>";
    		}
    	    // 2. 세부 카테고리 목록 출력
    	    $("#modal_bd_writeDCategory ul").html(codes);
    	    $(":checkbox").labelauty({ label: false });
    	}
    });

}    

function writeEmbedModalOpen(){
    var win_w = $(window).width();
	var win_h = $(window).height();
	
	var movImg_w = $('#modal_writeEmbed').width();
	var movImg_h = $('#modal_writeEmbed').height();
	
	var movImg_posX = (win_w - movImg_w)/2;
	var movImg_posY = (win_h - movImg_h)/2;
		
	$('#modal_writeEmbed').css({ left: movImg_posX, top: movImg_posY });
    $('.modal_bg').show();
	$('#modal_writeEmbed').show();
    
    $('#btn_writeEmbed').on('click',function(){
        $('.modal_bg, .modal').hide();
    })
    
}


//인덱스 모달 추가
function contentModalOpen(){
    var win_w = $(window).width();
	var win_h = $(window).height();
	
	$.ajax({
		url : "projectDetail",
		type : "POST",
		data : {p_id: 1, m_id: 1},
		success : function(data) {
			$("#modalBox").html(data);
			location.href="#detail";
			
			var movImg_w = $('#modal_content').width();
			var movImg_h = $('#modal_content').height();
			
			var movImg_posX = (win_w - movImg_w)/2;
			var movImg_posY = (win_h - movImg_h)/2;
			
			$('#modal_content').css({ left: movImg_posX-150, top: 100 });
		    $('#modal_content_userInfo').css({ left: movImg_posX+670, top: 100 });
		    $('.modal_bg').show();
			$('#modal_content').show();
		    $('#modal_content_userInfo').show();
		}
	});
	
//    $('#btn_writeEmbed').on('click',function(){
//        $('.modal_bg, .modal').hide();
//    })
    
    
    
    $(document).scroll(function(){
        if( $(window).scrollTop() >0){
//          $('#modal_content_userInfo').stop().animate( {top: $(window).scrollTop() } )
            $('#modal_content_userInfo').css( {top: $(window).scrollTop() } )

        }
        
        else if( $(window).scrollTop() <100){
//          $('#modal_content_userInfo').stop().animate( {top: 100 } )
            $('#modal_content_userInfo').css( {top: 100})
        }
    });
    
}


//쪽지보내기 모달
function noteModalOpen(step){
    var win_w = $(window).width();
	var win_h = $(window).height();
	var sent_to, sent_to_name;
	if(step=='1'){
		//페이지 상세보기 페이지에서 열었을 경우
		sent_to=0;
		sent_to_name='';
	}else if(step=='2'){
		//메세지 페이지에서 열었을 경우
		sent_to = $('#other_m_id').val();
		sent_to_name = $('#other_nickname').val();
	}
	
	$.ajax({
		url : "msgModalOpen",
		type : "POST",
		data : {m_id: sent_to, m_nickname: sent_to_name},
		success : function(data) {
			$("#modalBox2").html(data);
			location.href="#sendmsg";
			
			var movImg_w = $('#writeNoteWrap').width();
			var movImg_h = $('#writeNoteWrap').height();
			
			var movImg_posX = (win_w - movImg_w)/2;
			var movImg_posY = (win_h - movImg_h)/2;
				
			$('#writeNoteWrap').css({ left: movImg_posX, top: movImg_posY });
			
		    $('.modal_bg').hide();
		    $('.modal_bg2').show();
			$('#writeNoteWrap').show();
		    
		    $('.modal_bg2, #btn_sendNote').on('click',function(){
		        $('.modal_bg2, #writeNoteWrap').hide();
		        if(step=='2'){
		        	//프로젝트 상세보기 모달에서 열었을 경우
		        	$('.modal_bg').show();
		        }
		    });
		}
	});
}



