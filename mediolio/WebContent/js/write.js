jQuery.ajaxSettings.traditional = true;

var order=0; // 콘텐츠들의 순서
var fileNum=0; // 업로드할 파일 수
var orderArr=[];


function test(){
	$("#viewerForm").ajaxForm({
		dataType: "text",
		url: "showViewer",
		success: function(jdata){
			alert(jdata);
		}
	}).submit();
}

$('document').ready(function(){
	
	
//	$(document).bind("mouseup",function(){
//		console.log(document.activeElement);
//	});
    
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
        $('#write_bd').append('<div class="write_textarea contentBox" contenteditable="true" onmouseup="getSelectedText()" data-sort='+order+'>'
        		+'<ul class="text_toolBoxes" id="text_toolBox">'
        		+'<li id="text_size">'
        		+'<select id="select_fontSize" onchange="changeTxtSize(this)">'
        		+'<option value="10">10px</option value="11">'
        		+'<option>11px</option>'
        		+'</select></li>'
        		+'<li id="text_color"><a class="palette" href="#"></a></li>'
        		+'<li id="text_bold"><a href="#" onclick="txtBold(); return false;"></a></li>'
        		+'<li id="text_italic"><a href="#" onclick="txtItalic(); return false;"></a></li>'
        		+'<li id="text_under"><a href="#" onclick="txtUnderline(); return false;"></a></li></ul>'
        		+'<ul class="text_toolBoxes content_toolBoxes" id="content_toolBox">'
                +'<li id="text_up"><a href="#" onclick="moveUpTxt(this); return false;"></a></li>'
                +'<li id="text_down"><a href="#" onclick="moveDownTxt(this); return false;"></a></li>'
                +'<li id="text_delete"><a href="#" onclick="removeTxt(this); return false;"></a></li></ul>'
                +'</div>'
        );
        order++;
  

    	$(".palette").ColorPicker({
    		color: "#000000",
    		onShow: function(colpkr){
    			$(colpkr).fadeIn(500);
    			return false;
    		},
    		onHide: function(colpkr){
    			$(colpkr).fadeOut(500);
    			return false;
    		},
    		onChange: function (hsb, hex, rgb) {
    			console.log(window.getSelection());
    			var newColor = "#"+hex;
    			txtColor(newColor);
    		}
    	});
    	
        $(".content_toolBoxes").hide();
        $('.text_toolBoxes').hide();
        $('select').niceSelect();
        
        //div.write_textarea에 focus된 경우 툴박스 보이기
        $('.write_textarea').on('focus', function(){
        	
         	
            $(".content_toolBoxes").hide();
            $(".text_toolBoxes").hide();
            
            $(this).children().css('top', -40  );    //툴박스 위치
            $(this).children().next().css('top', 0 );    //툴박스 위치
            $(this).children().show();
            $(this).children().next().show();
            
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
       
        
        $(".write_textarea").on('keyup',function(){
        	orderArr[$(this).attr("data-sort")] = $(this).html();
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
//    	console.log("파일 이름: "+$(this).val().split("\\").pop());
    	console.log($(this).val().split('.')[1]);
		var ext = $(this).val().split('.')[1].toLowerCase(); // 파일의 확장자
		var file = $(this).prop("files")[0];
		var newFile = $(this);
		var contents = [];
		blobURL = window.URL.createObjectURL(file);
		if($.inArray(ext,['pdf','doc','docx','ppt','pptx','xls','xlsx',
		                  'txt','py','js','xml','css','md','pl','c','m','json']) != -1){
			// doc, pdf, ppt 파일 등(문서 형식 파일)
			// 미리보기 영역에 뷰어 표시
			 test();
		      
		        $("#submit_portfolio").on('click',function(){
		    		alert("submit");
		    		test();
		    	});
//			$("#viewerForm").ajaxForm({
//				dataType: "text",
//				url: "showViewer",
//				success: function(jdata){
//					$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
//						+"<ul class='content_toolBoxes' id='content_toolBox'>"
//						+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
//						+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
//						+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
//						+"<iframe src='"+jdata+"' style='width:500px; height:500px;'/></div>");		
//					console.log("파일 이름: "+$(newFile).val().split("\\")[2]);
//					orderArr[order] = $(newFile).val().split("\\")[2];
//					order++;
//					
//					//contentBox에 mouseover된 경우 content툴박스 보이기
//				    $('.contentBox').on('mouseover', function(){ 
//				    	$('.content_toolBoxes',this).css('top', $(this).offset().top - $('#write_bd').offset().top - 40 );    //툴박스 위치
//				        $('.content_toolBoxes',this).show();
//				    })
//				    
//				 	//contentBox를 벗어난 경우 content툴박스 숨기기
//				    $('html').mouseover(function(e) {   
//				        if( !$(e.target).is( $('.contentBox')) ) { 
//				           if( !$(e.target).is( $('.contentBox').find('*') ) ){                    
//				                if( !$(e.target).is( $('.content_toolBoxes').find('*') )){
//				                	$(".content_toolBoxes").hide();
//				                }
//				           }
//				        }
//				    }); 
//				    
//					/*
//					 * 	+"<a href='#' onclick='moveUpElement(this); return false;' class='upBtn'>↑</a>"
//						+"<a href='#' onclick='moveDownElement(this); return false;' class='downBtn'>↓</a>"
//						+"<a href='#' onclick='removeElement(this); return false;' class='removeBtn'>X</a>"
//					 * 
//					 * */ 
//				}
//			}).submit();
			
			fileNum++;
			$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents["+fileNum+"]' onchange='fileChange(this)'/>");	
					    
		} else if($.inArray(ext,['gif','png','jpg','jpeg']) != -1) {
			// 이미지 파일
			// 미리보기 영역에 이미지 표시
			$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
					+"<ul class='content_toolBoxes' id='content_toolBox'>"
					+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
					+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
					+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
					+"<img src='"+blobURL+"' style='display:block; margin:auto;'/></div>");
			orderArr[order] = $(this).val().split("\\")[2];
			order++;
			
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
		    
		    fileNum++;
			$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents["+fileNum+"]' onchange='fileChange(this)'/>");	
			
		} else {
			alert("업로드가 지원되지 않는 파일 형식입니다.");
		}
		
		
    });
    
    $("#selectedCategory").change(function(){
    	// 카테고리 새로 선택했을 때 기존에 있던 세부카테고리 초기화
    	$(".card_tag").html("");
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
    });
    
    $("#projectTitle").keyup(function(){
    	// 글 제목 입력하면 우측 미리보기 박스의 제목 변경
    	$(".card_title a").html($(this).val());
    });
    
});

function moveUpElement(e){
	// 엘리먼트 위로 이동
	var element = e;
	var order = $(element).closest(".contentBox").attr("data-sort");
	
	if(order != 0){
		$(element).closest(".contentBox").attr("data-sort",parseInt(order)-1);
		$(element).closest(".contentBox").prev(".contentBox").attr("data-sort",parseInt($(element).closest(".contentBox").prev(".contentBox").attr("data-sort"))+1);
	
		// 배열 순서 바꾸기
		var origin = orderArr[order]; 
		orderArr[order] = orderArr[order-1];
		orderArr[order-1] = origin;
		
		sortElements();	
	}
}

function moveUpTxt(e){
	var upBtn = e;
}

function moveDownElement(e){
	// 엘리먼트 아래로 이동
	var element = e;
	var order = $(element).closest(".contentBox").attr("data-sort");
	$(element).closest(".contentBox").attr("data-sort",parseInt(order)+1);
	$(element).closest(".contentBox").next(".contentBox").attr("data-sort",parseInt($(element).closest(".contentBox").next(".contentBox").attr("data-sort"))-1);

	// 배열 순서 바꾸기
	var origin = orderArr[order]; 
	orderArr[order] = orderArr[parseInt(order)+1];
	orderArr[parseInt(order)+1] = origin;
	
	sortElements();	
	
}

function moveDownTxt(e){
	var txt = e;
}

function removeElement(e){
	// 엘리먼트 삭제
	var element = e;
	var order = $(element).closest(".contentBox").attr("data-sort");
	$(element).closest(".contentBox").remove();
	
	console.log(order)
	console.log(orderArr.splice(order,1));
}

function removeTxt(e){
	var element = e;
	var toolbox = $(element).parent().parent();
	console.log($(toolbox));
	$(toolbox).prev().remove();
	$(toolbox).prev().remove();
	$(toolbox).remove();
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
        $("#write_bd").append("<div class='contentBox' data-sort="+order+">"
    			+"<ul class='content_toolBoxes' id='content_toolBox'>"
    			+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
    			+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
    			+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
    			+$("#modal_bd_writeEmbed textarea").val()+"</div>");
        orderArr[order] = $("#modal_bd_writeEmbed textarea").val();
        order++;
        
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
	if($.inArray(ext,['pdf','doc','docx','ppt','pptx','xls','xlsx',
	                  'txt','py','js','xml','css','md','pl','c','m','json']) != -1){
		// doc, pdf, ppt 파일
		// 미리보기 영역에 뷰어 표시
		$("#viewerForm").ajaxForm({
			dataType: "text",
			url: "showViewer",
			success: function(jdata){
				$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
					+"<ul class='content_toolBoxes' id='content_toolBox'>"
					+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
					+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
					+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
					+"<iframe src='"+jdata+"' style='width:500px; height:500px;'/></div>");				
				orderArr[order] = $(newFile).val().split("\\")[2];
				order++;
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
		
		fileNum++;
		$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents["+fileNum+"]' onchange='fileChange(this)'/>");	
		
	} else if($.inArray(ext,['gif','png','jpg','jpeg']) != -1){
		// 이미지 파일
		// 미리보기 영역에 이미지 표시
		$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
				+"<ul class='content_toolBoxes' id='content_toolBox'>"
				+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
				+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
				+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li></ul>"
				+"<img src='"+blobURL+"' style='display:block; margin:auto;'/></div>");
		orderArr[order] = $(newFile).val().split("\\")[2];
		order++;
		
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
	    
		fileNum++;
		$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents["+fileNum+"]' onchange='fileChange(this)'/>");	
		
	} else {
		alert("업로드가 지원되지 않는 파일 형식입니다.");
	}
}


function addProject(){
	// 프로젝트 등록
//	$("#addProjectForm").submit();
//	$("#p_title").val($("#projectTitle").val()); // 프로젝트 이름
//	$("#cate_id").val($("#selectedCategory").val()); // 카테고리 번호
	// 서브카테고리 번호
	// 이미지 파일은 잘 되는데 문서 파일 올리면 bad request
	console.log(orderArr);
//	$("#viewerForm").attr("action","addProject");
//	$("#orderArr").val(orderArr);
//	$("#p_title").val($("#projectTitle").val());
//	$("#cate_id").val($("#selectedCategory").val());
	
//	var hashtags = "";
//	$("#write_tagTxt span").each(function(){
//		hashtags += $(this).html()+"/";
//	});
//	var subcategories = "";
//	$(".subCategory").each(function(){
//		subcategories += $(this).val()+"/";
//	});
//	$("#hashtags").val(hashtags);
//	$("#sc_id").val(subcategories);
	 test();
	
}

function replaceSelectedText(replacementText) {
    var sel, range;
    if (window.getSelection) {
        sel = window.getSelection();
        if (sel.rangeCount) {
            range = sel.getRangeAt(0);
            range.deleteContents();
            range.insertNode(document.createTextNode(replacementText));
        }
    } else if (document.selection && document.selection.createRange) {
        range = document.selection.createRange();
        range.text = replacementText;
    }
}

function txtBold(){
	var range = window.getSelection().getRangeAt(0);
	console.log(range);
	console.log(range.toString());
	if(getSelectedNode().className.indexOf("txtBold") > -1){
		// 선택한 부분에 이미 txtBold 클래스가 적용된 부분이 있을 경우
		// 클래스 삭제
		// 1. 
//		console.log("클래스 이름: "+getSelectedNode().className);
//		getSelectedNode().classList.remove("txtBold");
		// 2. 선택된 부분 bold 해제
		var newNode = document.createElement("span");
		newNode.setAttribute("class", "txtBoldRemove");
		newNode.appendChild(range.extractContents());
//		range.surroundContents(newNode);
		range.insertNode(newNode);		
		
	} else {
		var newNode = document.createElement("span");
		newNode.setAttribute("class", "txtBold");
		newNode.appendChild(range.extractContents());
//		range.surroundContents(newNode);
		range.insertNode(newNode);
	}
	
}

function txtItalic(){
	var range = window.getSelection().getRangeAt(0);
	if(getSelectedNode().className.indexOf("txtItalic") > -1){
		// 선택한 부분에 이미 txtBold 클래스가 적용된 부분이 있을 경우
		// 클래스 삭제
		console.log("클래스 이름: "+getSelectedNode().className);
		getSelectedNode().classList.remove("txtItalic");
	} else {
		var newNode = document.createElement("span");
		newNode.setAttribute("class", "txtItalic");
		newNode.appendChild(range.extractContents());
//		range.surroundContents(newNode);
		range.insertNode(newNode);
	}
	
}

function txtUnderline(){
	var range = window.getSelection().getRangeAt(0);
	if(getSelectedNode().className.indexOf("txtUnderline") > -1){
		// 선택한 부분에 이미 txtBold 클래스가 적용된 부분이 있을 경우
		// 클래스 삭제
		console.log("클래스 이름: "+getSelectedNode().className);
		getSelectedNode().classList.remove("txtUnderline");
	} else {
		var newNode = document.createElement("span");
		newNode.setAttribute("class", "txtUnderline");
		newNode.appendChild(range.extractContents());
		
//		range.surroundContents(newNode);
		range.insertNode(newNode);
	}
	
}

function txtColor(color){
	var newColor = color;
	console.log(window.getSelection());
//	
//	var range = window.getSelection().getRangeAt(0);
//	var newNode = document.createElement("span");
//	newNode.style.color = newColor;
//	newNode.appendChild(range.extractContents());
//	range.insertNode(newNode);
}

function getSelectedNode()
{
    if (document.selection)
    	return document.selection.createRange().parentElement();
    else
    {
    	var selection = window.getSelection();
    	if (selection.rangeCount > 0)
    		return selection.getRangeAt(0).startContainer.parentNode;
    }
}


