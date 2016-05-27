var usr_name;
var usr_id;

/* projectView.jsp 관련 javascript
 *  이유라 - UI 관련 javascript
 *  오지은 - 기능 관련 jvavasciript
 * */


$('document').ready(function(){
    
	//이유라 작성
    $('.btn_userPop').on('click', function(){	
        return false; 
    })
    
    //오지은 작성 - 팝업메뉴에서 각 메뉴 클릭시 발생하는 이벤트
    //쪽지보내기 클릭
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
    
    //오지은 작성 - 히스토리 가기 클릭 
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


//이유라 작성 - 팝업메뉴 보이기
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