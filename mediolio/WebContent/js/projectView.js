$('document').ready(function(){
    
    $('.btn_userPop').on('click', function(){
        return false; 
    })
})


function userPop(event){
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