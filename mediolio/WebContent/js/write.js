var order=0; // 콘텐츠들의 순서
var fileNum=0; // 업로드할 파일 수

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
        $('#write_bd').append('<div class="write_textarea contentBox" contenteditable="true" onmouseup="getSelectedText()"></div>'
        		+'<ul class="text_toolBoxes" id="text_toolBox">'
        		+'<li id="text_size">'
        		+'<select id="select_fontSize" onchange="changeTxtSize(this)">'
        		+'<option value="10">10px</option value="11">'
        		+'<option>11px</option>'
        		+'</select></li>'
        		+'<li id="text_color"><a href="#"></a></li>'
        		+'<li id="text_bold"><a href="#"></a></li>'
        		+'<li id="text_italic"><a href="#"></a></li>'
        		+'<li id="text_under"><a href="#"></a></li></ul>'
        		+'<ul class="text_toolBoxes content_toolBoxes" id="content_toolBox">'
                +'<li id="text_up"><a href="#" onclick="moveUpElement(this); return false;"></a></li>'
                +'<li id="text_down"><a href="#" onclick="moveDownElement(this); return false;"></a></li>'
                +'<li id="text_delete"><a href="#" onclick="removeElement(this); return false;"></a></li></ul>'
        );
        $(".content_toolBoxes").hide();
        $('.text_toolBoxes').hide();
        $('select').niceSelect();
       
        
        
        //div.write_textarea에 focus된 경우 툴박스 보이기
        $('.write_textarea').on('focus', function(){
        	
         	
            $(".content_toolBoxes").hide();
            $(".text_toolBoxes").hide();
            
            $(this).next().css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
            $(this).next().next().css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
            
            $(this).next().show();
            $(this).next().next().show();
            
        })
        
        //다른 곳을 클릭했을 때 툴박스 숨기기
        $('html').click(function(e) {   
            if( !$(e.target).is( $('.write_textarea')) ) { 
               if( !$(e.target).is( $('.write_textarea').find('*') ) ){                    
                    if( !$(e.target).is( $('.text_toolBoxes').find('*') )){                    
                        $(".text_toolBoxes, .content_toolBoxes").hide();
                    }
               }
            }
        }); 
       
        
        
        
        //div.write_textarea에 mouseover된 경우 content툴박스 보이기
        $('.write_textarea').on('mouseover', function(){     	
        	$(this).next().next().css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
            $(this).next().next().show();
        })
        
       
        
        
        var focused = document.activeElement;
     	
        $('html').mouseover(function(e) {   
            if( !$(e.target).is( $('.write_textarea')) ) { 
               if( !$(e.target).is( $('.write_textarea').find('*') ) ){                    
                    if( !$(e.target).is( $('.text_toolBoxes').find('*') )){
                    	$(".content_toolBoxes").hide();
                    	document.activeElement.nextElementSibling.nextElementSibling.style.display = 'block';
                    }
               }
            }
        }); 
        
        
    })//끝- 텍스트 추가 버튼 누르고 난 후 이벤트
    
    
    $(".contentFile").change(function(){
    	// 파일(이미지, 문서) 추가
		var ext = $(this).val().split('.').pop().toLowerCase(); // 파일의 확장자
		var file = $(this).prop("files")[0];
		blobURL = window.URL.createObjectURL(file);
		if($.inArray(ext,['pdf','doc','docx','ppt','pptx','xls','xlsx',
		                  'txt','py','js','xml','css','md','pl','c','m','json']) == 1){
			// doc, pdf, ppt 파일 등(문서 형식 파일)
			// 미리보기 영역에 뷰어 표시
			$("#viewerForm").ajaxForm({
				dataType: "text",
				url: "showViewer",
				success: function(jdata){
					order++;
					$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
						+"<ul class='content_toolBoxes' id='content_toolBox'>"
						+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
						+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
						+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
						+"<iframe src='"+jdata+"' style='width:500px; height:500px;'/></div>");				
					
					//contentBox에 mouseover된 경우 content툴박스 보이기
				    $('.contentBox').on('mouseover', function(){ 
				    	$('.content_toolBoxes',this).css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
				        $('.content_toolBoxes',this).show();
				    })
				    
				 	//contentBox를 벗어난 경우 content툴박스 숨기기
				    $('html').mouseover(function(e) {   
				        if( !$(e.target).is( $('.contentBox')) ) { 
				           if( !$(e.target).is( $('.contentBox').find('*') ) ){                    
				                if( !$(e.target).is( $('.content_toolBoxes').find('*') )){
				                	$(".content_toolBoxes").hide();
				                }
				           }
				        }
				    }); 
				    
					/*
					 * 	+"<a href='#' onclick='moveUpElement(this); return false;' class='upBtn'>↑</a>"
						+"<a href='#' onclick='moveDownElement(this); return false;' class='downBtn'>↓</a>"
						+"<a href='#' onclick='removeElement(this); return false;' class='removeBtn'>X</a>"
					 * 
					 * */ 
				}
			}).submit();
			
			
		    
		} else if($.inArray(ext,['gif','png','jpg','jpeg']) == 1) {
			// 이미지 파일
			// 미리보기 영역에 이미지 표시
			order++;
			$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
					+"<ul class='content_toolBoxes' id='content_toolBox'>"
					+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
					+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
					+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
					+"<img src='"+blobURL+"' style='display:block; margin:auto;'/></div>");
			
			
			//contentBox에 mouseover된 경우 content툴박스 보이기
		    $('.contentBox').on('mouseover', function(){ 
		    	$('.content_toolBoxes',this).css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
		        $('.content_toolBoxes',this).show();
		    })
		    
		 	//contentBox를 벗어난 경우 content툴박스 숨기기
		    $('html').mouseover(function(e) {   
		        if( !$(e.target).is( $('.contentBox')) ) { 
		           if( !$(e.target).is( $('.contentBox').find('*') ) ){                    
		                if( !$(e.target).is( $('.content_toolBoxes').find('*') )){
		                	$(".content_toolBoxes").hide();
		                }
		           }
		        }
		    }); 
		    
		    
		} else {
			// 지원하지 않는 파일을 업로드했을 경우
			alert("업로드 할 수 없는 유형의 파일입니다.");
		}
		
		fileNum++;
		$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents["+fileNum+"]' onchange='fileChange(this)'/>");	
		
    });
    
    $("#selectedCategory").change(function(){
    	// 카테고리 새로 선택했을 때 기존에 있던 세부카테고리 초기화
    	if($("#write_dCategory a").html() != "세부 카테고리 선택.."){
    		$("#write_dCategory a").html("세부 카테고리 선택..");
    	}
    });
    
    $("#write_tagInput").keyup(function(){
    	// 태그 자동 완성
    	if($(this).val().trim() != ""){
    	$.ajax({
    		type: "POST",
    		url: "autocompleteTags",
    		data: {
    			h_value: $(this).val()
    		},
    		dataType: "json",
    		success: function(jdata){
    			var codes = "";
    			var arr = jdata;
    			for(var i=0; i<arr.length; i++){
    				codes += "<li onclick='addTag(this)'>"+arr[i]+"</li>";
    			}
    			if(arr.length>0){
    				$("#autoCompleteArea").html(codes);
        			$(".autoCompleteBox").css("display","block");
    			}
    		}
    	});
    	} else {
    		$(".autoCompleteBox").css("display","none");
    	}
    });
    
    $("#write_tagInput").keydown(function(e){
    	if(e.keyCode == 8 && $(this).val() == ""){
    		// 백스페이스 누르면 태그 삭제
	    	$("#write_tagTxt span:last-child").remove();
	    	if($("#write_tagTxt span").length == 0){
	    		// 입력된 태그가 하나도 없을 경우
	    		$("#write_tagInput").attr("placeholder","태그를 입력하세요.");
	    	}
    	} 
    });
    
    $("#write_tagInput").keyup(function(e){
    	if(e.keyCode == 188){
    		// 컴마 누르면 태그 입력
    		var newTag = $(this).val().replace(",","");
    		$(this).attr("placeholder","");
    		$("#write_tagTxt").append("<span>"+newTag+"</span>");
    		$(this).val("");
    		$(this).focus();
    		$(".autoCompleteBox").css("display","none");
    	}
    })
    
});

function moveUpElement(e){
	// 엘리먼트 위로 이동
	var element = e;
	var order = $(element).closest(".contentBox").attr("data-sort");
	$(element).closest(".contentBox").attr("data-sort",parseInt(order)-1);
	$(element).closest(".contentBox").prev(".contentBox").attr("data-sort",parseInt($(element).closest(".contentBox").prev(".contentBox").attr("data-sort"))+1);
	sortElements();	
}

function moveDownElement(e){
	// 엘리먼트 아래로 이동
	var element = e;
	var order = $(element).closest(".contentBox").attr("data-sort");
	$(element).closest(".contentBox").attr("data-sort",parseInt(order)+1);
	$(element).closest(".contentBox").next(".contentBox").attr("data-sort",parseInt($(element).closest(".contentBox").next(".contentBox").attr("data-sort"))-1);
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

function getSelectedText(){
	// 선택된 텍스트 출력
//	console.log("선택된 텍스트: "+window.getSelection());
	var obj = window.getSelection();
//	$(obj).css("font-size","20px");
}

function changeTxtSize(select){
	// 텍스트 사이즈 변경
	var txtSize = select;
	var selectedTxt = window.getSelection();
	$(txtSize).closest(".write_textarea").val().replace(selectedTxt,"<span>"+selectedTxt+"</span>");
}

function writeEmbedModalOpen(){
	// 미디어 태그 추가
    var win_w = $(window).width();
	var win_h = $(window).height();
	
	var movImg_w = $('#modal_writeEmbed').width();
	var movImg_h = $('#modal_writeEmbed').height();
	
	var movImg_posX = (win_w - movImg_w)/2;
	var movImg_posY = (win_h - movImg_h)/2;
		
	$('#modal_writeEmbed').css({ left: movImg_posX, top: movImg_posY });
    $('.modal_bg').show();
	$('#modal_writeEmbed').show();
    
    $('#btn_writeEmbed').on('click',function(){
    	// 임베드 태그 등록
        $('.modal_bg, .modal').hide();
        order++;
        $("#write_bd").append("<div class='contentBox' data-sort="+order+">"
    			+"<ul class='content_toolBoxes' id='content_toolBox'>"
    			+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
    			+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
    			+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
    			+$("#modal_bd_writeEmbed textarea").val()+"</div>");
        
      //contentBox에 mouseover된 경우 content툴박스 보이기
        $('.contentBox').on('mouseover', function(){ 
        	$('.content_toolBoxes',this).css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
            $('.content_toolBoxes',this).show();
        })
        
     	//contentBox를 벗어난 경우 content툴박스 숨기기
        $('html').mouseover(function(e) {   
            if( !$(e.target).is( $('.contentBox')) ) { 
               if( !$(e.target).is( $('.contentBox').find('*') ) ){                    
                    if( !$(e.target).is( $('.content_toolBoxes').find('*') )){
                    	$(".content_toolBoxes").hide();
                    }
               }
            }
        }); 
    });
    
  
    
}

function addTag(li){
	// 자동 완성된 태그 클릭 시 태그 추가
	var newTag = li;
	$("#write_tagInput").attr("placeholder","");
	$("#write_tagTxt").append("<span>"+$(newTag).find("span").html()+"</span>");
	$("#write_tagInput").val("");
	$("#write_tagInput").focus();
	$(".autoCompleteBox").css("display","none");
}

function fileChange(file){
	var newFile = file;
	// 파일(이미지, 문서) 추가
	var ext = $(newFile).val().split('.').pop().toLowerCase(); // 파일의 확장자
	var file = $(newFile).prop("files")[0];
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
					+"<ul class='content_toolBoxes' id='content_toolBox'>"
					+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
					+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
					+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
					+"<iframe src='"+jdata+"' style='width:500px; height:500px;'/></div>");				
				
				//contentBox에 mouseover된 경우 content툴박스 보이기
			    $('.contentBox').on('mouseover', function(){ 
			    	$('.content_toolBoxes',newFile).css('top', $(newFile).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
			        $('.content_toolBoxes',newFile).show();
			    })
			    
			 	//contentBox를 벗어난 경우 content툴박스 숨기기
			    $('html').mouseover(function(e) {   
			        if( !$(e.target).is( $('.contentBox')) ) { 
			           if( !$(e.target).is( $('.contentBox').find('*') ) ){                    
			                if( !$(e.target).is( $('.content_toolBoxes').find('*') )){
			                	$(".content_toolBoxes").hide();
			                }
			           }
			        }
			    }); 
			    
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
				+"<ul class='content_toolBoxes' id='content_toolBox'>"
				+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
				+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
				+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
				+"<img src='"+blobURL+"' style='display:block; margin:auto;'/></div>");
		
		
		//contentBox에 mouseover된 경우 content툴박스 보이기
	    $('.contentBox').on('mouseover', function(){ 
	    	$('.content_toolBoxes',newFile).css('top', $(newFile).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
	        $('.content_toolBoxes',newFile).show();
	    })
	    
	 	//contentBox를 벗어난 경우 content툴박스 숨기기
	    $('html').mouseover(function(e) {   
	        if( !$(e.target).is( $('.contentBox')) ) { 
	           if( !$(e.target).is( $('.contentBox').find('*') ) ){                    
	                if( !$(e.target).is( $('.content_toolBoxes').find('*') )){
	                	$(".content_toolBoxes").hide();
	                }
	           }
	        }
	    }); 
	    
	    
	}    
	
	fileNum++;
	$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents["+fileNum+"]' onchange='fileChange(this)'/>");	
	
}

function addProject(){
	// 프로젝트 등록
//	$("#addProjectForm").submit();
	$("#p_title").val($("#projectTitle").val()); // 프로젝트 이름
	$("#cate_id").val($("#selectedCategory").val()); // 카테고리 번호
	// 서브카테고리 번호
	$("#viewerForm").attr("action","addProject");
	$("#viewerForm").submit();
}