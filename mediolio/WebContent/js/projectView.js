var usr_name;
var usr_id;

$('document').ready(function(){
    
    $('.btn_userPop').on('click', function(){	
        return false; 
    })
    
    $('.userPopWrap .msg').on('click', function(){
    	if($('#bellWrap').length) noteModalOpen(usr_id, usr_name);
    	else {
    		$.jAlert({
    		    'title': '!!',
    		    'content': '로그인하세요.',
    		    'closeOnClick' : true,
    		    'size': 'xsm'
    		  });
    	}
    });
})


function userPop(event, aTag, m_id){
	usr_name = $(aTag).text();
	usr_id = m_id;
	
    var mouseX = event.screenX;
    var mouseY = event.screenY;
    
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
        top:mouseY-65
        
    })
    
}