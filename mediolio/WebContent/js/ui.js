$('document').ready(function(){
	// 카테고리 시작
	var wHeight = $(window).height();
    $('#categoryWrap2').css({
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
//	
//	$(".categoryWrap").mCustomScrollbar();
//	// 카테고리 끝
	
	
	
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
    
    //aside 쪽지 아이콘 클릭
    $('#userBox #message a').click(openMyMsgPage);
    //aside 팔로워 아이콘 클릭
    $('#userBox #follow a').click(openMyFriendPage);
    
    
    //header 검색창
    $('#selectWrap_main').on('click',function(){
        $('#bellWrap, #btn_login, #btn_logout').hide();
        $('#headerWrap .btn_close').show();
        $('#headerWrap').css({ width:'100%', paddingLeft:250});/*402*/
        $('#search_main').css({ width:'95%', margin:'0 auto'})/*260*/
        $('#selectWrap_main').css({ width:120});
        
    });
    $('#text_main').on('click',function(){
        $('#bellWrap, #btn_login, #btn_logout').hide();
        $('#headerWrap .btn_close').show();
        
        //오지은 추가
        var select = document.getElementById('select_main');
    	var selectbox_val = select.options[select.selectedIndex].value;
    	if(selectbox_val == 'member'){
    		//학우 검색 시 전체검색이 default로 나타나도록.
    		$('#teamCategory_total').click();
    		$('.searchTermWrap').show();
    	}
    	else if( selectbox_val == 'tag' || selectbox_val == 'subject'){
        	$('.searchTermWrap').hide();
        }else{
        	$('.searchTermWrap').show();
        }
        //추가 끝
        
        $('#headerWrap').css({ width:'100%', paddingLeft:250});/*402*/
        $('#search_main').css({ width:'95%', margin:'0 auto'})/*260*/
        $('#selectWrap_main').css({ width:120});
    });
    
    $('#headerWrap .btn_close').on('click', function(){
        $('#bellWrap, #btn_login, #btn_logout').show();
        $('#headerWrap .btn_close, .searchTermWrap').hide();
        $('#headerWrap').css({ width:502, paddingLeft:0});/*402*/
        $('#search_main').css({ width:360, margin:'0 20px 0 0'})/*260*/
        $('#selectWrap_main').css({ width:103});
    })
    
    $('#teamCategory_total').on('click', function(){
        $('.team_category input[type="button"]').removeClass('btn_222');
        $(this).addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_language, .techWrap_game, .techWrap_webApp, .techWrap_design, .techWrap_video, .techWrap_3d, .techWrap_etc').show();
    })
    $('#teamCategory_game').on('click', function(){
        $('.team_category input[type="button"]').removeClass('btn_222');
        $(this).addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_language, .techWrap_game').show();
    })
    $('#teamCategory_webApp').on('click', function(){
        $('.team_category input[type="button"]').removeClass('btn_222');
        $(this).addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_language, .techWrap_webApp').show();
    })
    $('#teamCategory_design').on('click', function(){
        $('.team_category input[type="button"]').removeClass('btn_222');
        $(this).addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_design').show();
    })
    $('#teamCategory_video').on('click', function(){
        $('.team_category input[type="button"]').removeClass('btn_222');
        $(this).addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_video').show();
    })
    $('#teamCategory_3d').on('click', function(){
        $('.team_category input[type="button"]').removeClass('btn_222');
        $(this).addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_3d, .techWrap_design').show();
    })
    $('#teamCategory_etc').on('click', function(){
        $('.team_category input[type="button"]').removeClass('btn_222');
        $(this).addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_language, .techWrap_etc').show();
    })
});

function openMyFriendPage(){
	$.ajax({
		url: "follow",
		type: "POST",
		success : function(result){
			$('#default_body').empty().append(result);
		}
	});
}

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