$(function(){
    
    //페이지처리 ul 3줄이상(240)이면 뜨도록
    $(".gallery").hover(function(){
        if( $('ul',this).height() >= 240 ){
            $(".gallery_arrows", this).fadeIn(500).show();    
        }
    }, function(){
        $(".gallery_arrows", this).fadeOut(500).hide();
        
    })
    
    $(".gallery_left").on('click',function(){
        
        
        return false;
    })
    
    $(".gallery_right").on('click',function(){
        
        
        return false;
    })
    
    $("#btn_addFriend").on('click',function(){
        if($(this).attr('data-click-state') == 0) {
            $(this).css({ background:'url(../images/removeFriend.png) center center no-repeat'
            })
            $(this).attr('data-click-state',1);
        }
        
        else if($(this).attr('data-click-state') == 1) {
            $(this).css({ background:'url(../images/addFriend.png) center center no-repeat'
            })
            $(this).attr('data-click-state',0);
        }
        return false;
    })
    
    
    
    
})