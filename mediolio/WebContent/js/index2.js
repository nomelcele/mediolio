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