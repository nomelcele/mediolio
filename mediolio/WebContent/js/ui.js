$('document').ready(function(){
	// 카테고리 시작
	var wHeight = $(window).height();
    $('#categoryWrap').css({
        'height' : (wHeight-225) + 'px'   
    }); 
	
	$(".nav_sub").hide();
		
	$(".nav_title").on('click', function(){
		$('.nav_title').removeClass('choose_menuText');
		$('.nav_title').removeClass('nav_selected');
		$('.nav_title span').css('background-position','left center');
		
		$('span', this).css('background-position','-20px center');
		$(this).addClass('choose_menuText');
		$(this).addClass('nav_selected');
		
		$(".nav_sub").hide();
		
		$(this).next().slideDown(1000, function(){
			$(this).next().show();
		});
		
	});
	
	
	$('.nav_title').on('mouseover',function(){
		$('span', this).css('background-position','-20px center');
		$(this).addClass('choose_menuText');
	})
	
	$('.nav_title').on('mouseleave',function(){
		$('span', this).not('.nav_selected span').css('background-position','left center');
		$(this).not('.nav_selected').removeClass('choose_menuText');
	})
	
	$("#categoryWrap").mCustomScrollbar();
	// 카테고리 끝
	
	
	
	// 검색_카테고리변경
	$('select').niceSelect();
    
    
    // 체크박스 스타일
    $(":checkbox").labelauty({ label: false });
    
    
  //헤더 알림 호버- 말풍선 띄우기
    $("#bubble_bell").mCustomScrollbar();
    $('#bellIcon').click(function(){
    	if(!$('#bellNum').length){
    		//새로 받아올 알림이 없을 때
    		$('#mCSB_2_container').empty().append("<li class='bell_nothing'>새로운 알림이 없습니다.</li>");
    		$('#bubble_bell, #bubbleAfter').show();  
    	}
    	else{
    	//받아올 알림이 있을 때	
    		if($('#bubble_bell').css("display") == "block"){
    			//알림창이 열려있을땐 받아오지 않음
    			$('#bubble_bell, #bubbleAfter').hide();
    		}else{
    			//알림목록 받아오는 함수 호출
    			getNotifications(); //header.js 에 있는 함수 
    		}
    	}
    });    
	$(document).click(function(e){
		var pos = $('#bubble_bell').offset();
		var menuPos = $('#bubbleAfter').offset();
		if(($('#bubble_bell').css("display") == "block") && ((e.pageX<pos.left) || (e.pageX>pos.left+480)|| (e.pageY>pos.top+155))){
			$('#bubble_bell, #bubbleAfter').hide();
		}
	});
    
	
	//쪽지페이지 리모콘
    $("#btn_rmcnUp").click(function() {
        $("html, body").animate({ scrollTop: 0 }, "slow");
        return false;
    });
    
    $("#btn_rmcnDown").click(function() {
        $("html, body").animate({ scrollTop: $(document).height() }, "slow");
        return false;
    });
    
    
    $('#userBox #message a').click(openMyMsgPage);
});

//aside에서 메세지 아이콘 누르거나, 알림 말풍선에서 도착한 메세지 눌렀을 때
function openMyMsgPage(){
	$.ajax({
		url: "message",
		type: "POST",
		success : function(result) {
			$('#default_body').empty().append(result);
		}
	});
}