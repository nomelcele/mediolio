var usr_name;
var usr_id;

$('document').ready(function(){
    
    $('.btn_userPop').on('click', function(){	
        return false; 
    })
    
    $('.userPopWrap .msg').unbind("click").on('click', function(){
    	if($('#bellWrap').length) noteModalOpen(usr_id, usr_name);
    	else {
    		$.jAlert({
    		    'title': '!!',
    		    'content': '로그인하세요.',
    		    'theme' : 'red',
    		    'closeOnClick' : true,
    		    'size': 'xsm'
    		  });
    	}
    });
    $('.userPopWrap .userPop_userHt').unbind("click").on('click', function(){
		$.jAlert({
		    'title': '!!',
		    'content': '준비중입니다.',
		    'closeOnClick' : true,
		    'theme' : 'red',
		    'size': 'xsm'
		  });
    	/*    	if($('#bellWrap').length) location.href="gotoMyPage"
    	else {
    		$.jAlert({
    		    'title': '!!',
    		    'content': '로그인하세요.',
    		    'closeOnClick' : true,
    		    'size': 'xsm'
    		  });
    	}*/
    })
})


function userPop(event, aObj, m_id){
	usr_name = $(aObj).text();
	usr_id = m_id;
	$('.userPopWrap .userPop_userPage').attr("href", "userpage?usr_id="+usr_id);
	
    var mouseX = event.clientX;
    var mouseY = event.clientY;
    
    $('.userPopWrap').show();
    
    $('body').on('click',function(e){
        if(e.target.className != "btn_userPop"){
            $('.userPopWrap').hide();
        }
    })
    $(window).scroll(function(){
            $('.userPopWrap').hide();
    })
    
    $('.userPopWrap').css({
        left:mouseX,
        top:mouseY+10
        
    })
    
}