$(document).ready(function() {
	$(".historyWrap_main .timeCard_content, .newest_content").dotdotdot();
    
    $('.bxslider').bxSlider();
    
    
    $(".historyWrap_main .timeCard_more").on('click', function(){
        if( $(this).text() == '더 보기..' ){
            $(this).prev().trigger("destroy");
            $(this).prev().css({ height:'auto', overflow:'visible'});
            $(this).hide();
        }
        return false;
    })
});


/*
 * 이전 버전 index.jsp 관련 코드
 */

/*$('document').ready(function(){
    //카드 위에 태그 보이기
    $(".card_img").hover(function(){
        $('div', this).addClass("card_hover");
        $('p',this).show();
    },function(){
        $('div', this).removeClass("card_hover");
        $('p',this).hide();
    });
});

function tagHover(){
	$(".card_img").hover(function(){
        $('div', this).addClass("card_hover");
        $('p',this).show();
    },function(){
        $('div', this).removeClass("card_hover");
        $('p',this).hide();
    });
}*/