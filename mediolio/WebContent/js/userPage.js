$(function(){
    
	/* userPage.jsp에 관련된 javascript
	 *  이유라 - UI 관련 javascript
	 *  오지은 - 기능 관련 javasciript
	 * */
	
	
	//이유라 작성 부분
    //페이지처리 ul 3줄이상(240)이면 뜨도록
    $(".gallery").hover(function(){
        if( $('ul',this).height() >= 240 ){
            $(".gallery_arrows", this).fadeIn(500).show();    
        }
    }, function(){
        $(".gallery_arrows", this).fadeOut(500).hide();
    });
    
    $(".gallery_left").on('click',function(){
       
    	return false;
    });
    
    $(".gallery_right").on('click',function(){

        return false;
    })
    
    

    // 오지은 작성 부분 - 팔로우/팔로우취소
    $("#btn_addFriend").on('click',function(){
        if($(this).attr('data-click-state') == 0) {//친추 안되어 있는 상태. 팔로하고 싶을 때 클릭
        	$.ajax({
        		url: "followMember",
        		type: "POST",
        		data: {m_id:$('#contentsWrap').find('.memberId').val()},
        		dataType : "json",
        		success: function(result){
                    $("#btn_addFriend").css({ background: 'url(/mediolio/resources/images/removeFriend.png) center center no-repeat'});
                    $("#btn_addFriend").attr('data-click-state',1);
        		}
        	}); 
        }
        else if($(this).attr('data-click-state') == 1) { //친추된 상태. 팔로 취소하고 싶을 때 클릭
        	$.ajax({
        		url: "followCancel",
        		type: "POST",
        		data: {m_id:$('#contentsWrap').find('.memberId').val()},
        		dataType : "json",
        		success: function(result){
                    $("#btn_addFriend").css({ background:'url(/mediolio/resources/images/addFriend.png) center center no-repeat'});
                    $("#btn_addFriend").attr('data-click-state',0);
        		}
        	});
        }
        return false;
    });
    
});
