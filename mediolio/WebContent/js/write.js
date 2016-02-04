var order=0;

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
        $('#write_bd').append('<div class="write_textarea contentBox" contenteditable="true"></div><ul class="text_toolBoxes"><li id="text_size"><select id="select_fontSize"><option>10px</option><option>11px</option></select></li><li id="text_color"><a href="#"></a></li><li id="text_bold"><a href="#"></a></li><li id="text_italic"><a href="#"></a></li><li id="text_under"><a href="#"></a></li><li id="text_delete"><a href="#" onclick="removeElement(this); return false;"></a></li><li id="text_up"><a href="#" onclick="moveUpElement(this); return false;"></a></li><li id="text_down"><a href="#" onclick="moveDownElement(this); return false;"></a></li></ul>');
       
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
    
    $("#contentFile").change(function(){
    	// 파일(이미지, 문서) 추가
		var ext = $(this).val().split('.').pop().toLowerCase(); // 파일의 확장자
		var file = $(this).prop("files")[0];
		blobURL = window.URL.createObjectURL(file);
		if($.inArray(ext,['gif','png','jpg','jpeg']) == -1){
			// doc, pdf, ppt 파일
			// 미리보기 영역에 뷰어 표시
			$("#viewerForm").ajaxForm({
				dataType: "text",
				url: "showViewer",
				success: function(jdata){
					order++;
					$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
						+"<ul class='text_toolBoxes content_toolBox'>"
						+"<li id='text_delete'><a href='#'></a></li>"
						+"<li id='text_up'><a href='#'></a></li>"
						+"<li id='text_down'><a href='#'></a></li></ul>"
						+"<iframe src='"+jdata+"' style='width:500px; height:500px;'/></div>");				

					/*
					 * 	+"<a href='#' onclick='moveUpElement(this); return false;' class='upBtn'>↑</a>"
						+"<a href='#' onclick='moveDownElement(this); return false;' class='downBtn'>↓</a>"
						+"<a href='#' onclick='removeElement(this); return false;' class='removeBtn'>X</a>"
					 * 
					 * */ 
				}
			}).submit();
		} else {
			// 이미지 파일
			// 미리보기 영역에 이미지 표시
			order++;
			$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
					+"<ul class='text_toolBoxes content_toolBox'>"
					+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
					+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
					+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
					+"<img src='"+blobURL+"' style='display:block;'/></div>");				
		}    	
    	
    });
    
});

function moveUpElement(e){
	// 엘리먼트 위로 이동
	var element = e;
	var order = $(element).closest(".contentBox").attr("data-sort");
	$(element).closest(".contentBox").attr("data-sort",parseInt(order)-1);
	sortElements();	
}

function moveDownElement(e){
	// 엘리먼트 아래로 이동
	var element = e;
	var order = $(element).closest(".contentBox").attr("data-sort");
	$(element).closest(".contentBox").attr("data-sort",parseInt(order)+1);
	sortElements();	
}

function removeElement(e){
	// 엘리먼트 삭제
	var element = e;
	$(element).closest(".contentBox").remove();
}

function sortElements(){
	// 순서에 따라 엘리먼트 정렬
	var $wrapper = $('#write_bd');

	$wrapper.find('.contentBox').sort(function (a, b) {
	    return +a.getAttribute('data-sort') - +b.getAttribute('data-sort');
	})
	.appendTo($wrapper);
}