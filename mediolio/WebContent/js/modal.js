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
    
    $('#btn_mdJoinForm').on('click',function(){
        $('.modal_bg, .modal').hide();
    })
    
    
}
    
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
        $('.modal_bg, .modal').hide();
    })
    
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