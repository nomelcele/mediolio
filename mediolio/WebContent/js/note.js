$(function(){
  
    
    $('#card_note_hd a').on('click',function(){
        $('#card_note_hd a').css({
            background: '#29AE5D',
            color: '#fff'
        });
        $(this).css({
            background: '#fff',
            color: '#666'
        });
    })
    
    //받은쪽지함 보낸쪽지함 탭
    $('.btn_receiveView').on('click',function(){
        $('.card_note_bd').hide();
        $('#card_receiveNote_bd').show();
    })
    
    $('.btn_sendView').on('click',function(){
        $('.card_note_bd').hide();
        $('#card_sendNote_bd').show();
    })
    
    //쪽지 내용 더보기/숨기기 버튼 띄우기
    $('.noteWrap').hover(function(){
        $('.noteMore',this).fadeIn(300).show();    
    }, function(){
        $('.noteMore',this).fadeOut(300).hide();
    })
    
    
    //쪽지 내용 더보기/숨기기 기능
    $('.noteMore').on('click',function(){
        if( $(this).text() == '>> more' ){
            $(this).parent().css({
                height: 200,
                overflow: 'visible'
            })
            $(this).fadeOut(300).hide();
            $(this).text('hide <<');
        }
        else if( $(this).text() == 'hide <<' ){
            $(this).parent().css({
                height: 50,
                overflow: 'hidden'
            })
            $(this).fadeOut(300).hide();
            $(this).text('>> more');
        }
        return false;
    })
        
    
    
})

