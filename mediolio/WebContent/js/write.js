$('document').ready(function(){
    
    //팝업 쓰기버튼 호버- 말풍선 띄우기
    $('#btn_addWrite').hover(function(){
        $('#bubble_addWrite').show();
    },function(){
        $('#bubble_addWrite').mouseenter(function(){
            $('#bubble_addWrite').show();
        });
        $('#bubble_addWrite').mouseleave(function(){
            $('#bubble_addWrite').hide();
        });
        $('#bubble_addWrite').hide();
    });
    
    
    //텍스트 추가 버튼 누르고 난 후 이벤트
    $('#btn_addText').on('click',function(){
        $('#write_bd').append('<div class="write_textarea" contenteditable="true"></div><ul class="text_toolBoxes"id="text_toolBox"><li id="text_size"><select id="select_fontSize"><option>10px</option><option>11px</option></select></li><li id="text_color"><a href="#"></a></li><li id="text_bold"><a href="#"></a></li><li id="text_italic"><a href="#"></a></li><li id="text_under"><a href="#"></a></li><li id="text_delete"><a href="#"></a></li><li id="text_up"><a href="#"></a></li><li id="text_down"><a href="#"></a></li></ul>');
       
        $('.text_toolBoxes').hide();
        $('select').niceSelect();
        
        //div.write_textarea에 focus된 경우 툴박스 보이기
        $('.write_textarea').on('focus', function(){
            $(".text_toolBoxes").hide();
            $(this).next().css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
            $(this).next().show();
        })
        
        //다른 곳을 클릭했을 때 툴박스 숨기기
        $('html').click(function(e) {   
            if( !$(e.target).is( $('.write_textarea')) ) { 
               if( !$(e.target).is( $('.write_textarea').find('*') ) ){                    
                    if( !$(e.target).is( $('.text_toolBoxes').find('*') )){                    
                        $(".text_toolBoxes").hide();
                    }
               }
            }
        });     
    })//끝- 텍스트 추가 버튼 누르고 난 후 이벤트
    
    
})