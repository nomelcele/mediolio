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
})