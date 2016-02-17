jQuery.ajaxSettings.traditional = true;

var order=0; // 콘텐츠들의 순서
var fileNum=0; // 업로드할 파일 수
var orderArr=[];
var colorRange;
var colorNum=0;
var colorId=0;

$('document').ready(function(){
	
	$("#submit_portfolio").click(function(){
		// 프로젝트 등록
		
		// 유효성 검사
		if($("#selectedCategory").val() == 0){
			// 1. 카테고리 선택
			alert("카테고리를 선택해주세요.");
		} else if($("#write_dCategory a").html() == "세부 카테고리 선택.."){
			// 2. 세부카테고리 선택
			alert("세부카테고리를 선택해주세요.");
		} else if($.trim($("#projectTitle").val()) == ""){
			// 3. 글 제목 입력
			alert("제목을 입력해주세요.");
		} else if($("#write_bd .contentBox").size() == 0){
			// 4. 내용 입력
			// $("#write_tagTxt span").size()
			alert("내용을 입력해주세요.");
		} else{
			// 파일 업로드
			// 서버로 보내야 할 파라미터 목록
			// 1. 파일(이미지, 문서): formdata로 전송
			var formData = new FormData();
			var firstFile = $("input[name=contents]")[0];
			if($(firstFile).val() != ""){
				for(var i=0; i<$("input[name=contents]").length; i++){
					console.log($("input[name=contents]")[i]);
					formData.append("contents",$("input[name=contents]")[i].files[0]);
				};
			}
			
			
			// 2. 임베드 태그, 텍스트: orderArr에 있음
			// 3. orderArr: 콘텐츠 순서 정보 저장
			console.log("콘텐츠 순서: "+orderArr);
			for(var i=0; i<orderArr.length; i++){
				formData.append("orderArr",orderArr[i]);
			}
			// 4. 프로젝트 제목
			$("#p_title").val($("#projectTitle").val());
			// 5. 카테고리 아이디
			$("#cate_id").val($("#selectedCategory").val());
			// 6. 서브카테고리 아이디 목록
			var subcategories = "";
			$("#write_dCategory .subCategory").each(function(){
				subcategories += $(this).val()+"/";
			});
			$("#sc_id").val(subcategories);
			// 7. 커버 이미지 파일 이름
			$("#p_coverImgName").val($("#p_coverImg").val());
			// 8. 해쉬태그
			var hashtags = "";
			$("#write_tagTxt span").each(function(){
				hashtags += $(this).html()+"/";
			});
			$("#hashtags").val(hashtags);
	
			var other_data = $("#addProjectForm").serializeArray();
		    $.each(other_data,function(key,input){
		        formData.append(input.name,input.value);
		    });
			
			$.ajax({
				url: "addProject",
				processData: false,
				contentType: false,
				data: formData,
				type: "POST",
				success: function(result){
					alert("업로드 완료");
					$('#default_body').empty().append(result);
					tagHover();
				}
			});
		}
		
	});

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
//    	addContent();
    	
        $('#write_bd').append('<div class="write_textarea contentBox" contenteditable="true" data-sort='+order+'>'
        		+'<div contenteditable="true" style="min-height:inherit; height:auto;"></div>'
        		+'<ul class="text_toolBoxes" id="text_toolBox">'
        		+'<li id="text_size">'
        		+'<select id="select_fontSize" class="txtSize">'
        		+'<option value="10">10px</option>'+'<option value="11">11px</option>'+'<option value="12">12px</option>'+'<option value="14">14px</option>'+'<option value="16">16px</option>'+'<option value="18">18px</option>'+'<option value="20">20px</option>'+'<option value="22">22px</option>'
        		+'<option value="24">24px</option>'+'<option value="26">26px</option>'+'<option value="28">28px</option>'+'<option value="36">36px</option>'+'<option value="48">48px</option>'+'<option value="72">72px</option>'
        		+'</select></li>'
        		+'<li id="text_color"><a class="palette" href="#"></a></li>'
        		+'<li id="text_bold"><a href="#" onclick="txtBold(); return false;"></a></li>'
        		+'<li id="text_italic"><a href="#" onclick="txtItalic(); return false;"></a></li>'
        		+'<li id="text_under"><a href="#" onclick="txtUnderline(); return false;"></a></li></ul>'
        		+'<ul class="text_toolBoxes content_toolBoxes" id="content_toolBox">'
                +'<li id="text_up"><a href="#" onclick="moveUpElement(this); return false;"></a></li>'
                +'<li id="text_down"><a href="#" onclick="moveDownElement(this); return false;"></a></li>'
                +'<li id="text_delete"><a href="#" onclick="removeElement(this); return false;"></a></li></ul>'
                +'</div>'
        );
        
        $(".write_textarea:last").trigger("focus");
        
        $(".txtSize").on("change",function(){
        	var range = window.getSelection().getRangeAt(0);
        	console.log(range);
        	console.log(range.toString());
    		var newNode = document.createElement("span");
    		newNode.style.fontSize = $(this).val()+"px";
    		newNode.appendChild(range.extractContents());
    		range.insertNode(newNode);
    		
    		console.log($(this).closest(".write_textarea"));
        	var value = $(this).closest(".write_textarea").html();
        	orderArr[$(this).closest(".write_textarea").attr("data-sort")] = value.split("<ul")[0];
        });
        
        $("ul").find('*').attr('contenteditable','false');
        
        
        addContent();
        
    	$(".palette").ColorPicker({
    		color: "#000000",
    		onShow: function(colpkr){
    			$(colpkr).fadeIn(500);
    			colorRange = getColorRange();
    			colorNum = 0;
    			return false;
    		},
    		onHide: function(colpkr){
    			$(colpkr).fadeOut(500);
    			return false;
    		},
    		onChange: function (hsb, hex, rgb) {
    			colorNum++;
    			if(colorNum == 1){
	    			console.log(colorRange);
	        		var newNode = document.createElement("span");
	        		newNode.style.color = "#"+hex;
	        		colorId++;
	        		newNode.id = "color"+colorId;
	        		newNode.appendChild(colorRange.extractContents());
	        		colorRange.insertNode(newNode);
    			} else {
    				var spanId = "#color"+colorId;
    				$(spanId).css("color","#"+hex);
    			}
    			console.log($(this));
            	var value = $(this).closest(".write_textarea").html();
            	orderArr[$(this).closest(".write_textarea").attr("data-sort")] = value.split("<ul")[0];
    		}
    	});
    	
        
        $('select').niceSelect();
        
	    
	 	
        $(".write_textarea").on('keyup',function(){
        	var value = $(this).html();
        	orderArr[$(this).attr("data-sort")] = value.split("<ul")[0];
        });
       
        $(".write_textarea ul").on('click',function(){
        	var value = $(this).parent().html();
        	orderArr[$(this).parent().attr("data-sort")] = value.split("<ul")[0];
        });
        
        

        
        $('html').mouseover(function(e) {   
            if( !$(e.target).is( $('.contentBox')) ) { 
               if( !$(e.target).is( $('.contentBox').find('*') ) ){                    
                    if( !$(e.target).is( $('.text_toolBoxes').find('*') )){
                    	$(".content_toolBoxes").hide();
                    	$("#write_bd .text_toolBoxes").hide();
                    	
                    }
               }
            }
        }); 
        
        order = parseInt(order)+1;
        
        
        
        //div.write_textarea에 focus된 경우 툴박스 보이기
        $('.write_textarea').on('click', function(){
            $(".content_toolBoxes").hide();
            $(".text_toolBoxes").hide();
            
            $(this).children().css('top', -40  );    //툴박스 위치
            $(this).children().next().css('top', -40 );    //툴박스 위치
            $(this).children().show();
            $(this).children().next().show();
            
            addContent();
            
//            $(this).focus();
//            
//            var range = document.createRange(),
//                selection = window.getSelection();
//            
//            range.setStartAfter($(this).get(0).lastChild);
//            
//            selection.removeAllRanges();
//            selection.addRange(range);
            
        });
    });//끝- 텍스트 추가 버튼 누르고 난 후 이벤트
    
  
    $(".contentFile").change(function(){
    	if($(this).prop("files")[0].size > 10485500){
    		// 10메가 이상의 파일 업로드했을 때(톰캣 자체 설정 -> 설정 변경하면 업로드 가능한 max size 조절 가능)
    		alert("10MB 이하의 파일만 업로드 가능합니다.");
    	} else {
        	// 파일(이미지, 문서) 추가
    		var ext = $(this).val().split('.')[1].toLowerCase(); // 파일의 확장자
    		var file = $(this).prop("files")[0];
    		var newFile = $(this);
    		var contents = [];
    		blobURL = window.URL.createObjectURL(file);
    		if($.inArray(ext,['pdf','doc','docx','ppt','pptx','xls','xlsx',
    		                  'txt','py','js','xml','css','md','pl','c','m','json']) != -1){
    			// doc, pdf, ppt 파일 등(문서 형식 파일)
    			// 미리보기 영역에 뷰어 표시
				$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
						+"<div class='viewerBg'><div class='loading_wrap'><img class='project_loading' src='resources/images/project_loading.gif'></div></div>"
						+"<ul class='content_toolBoxes' id='content_toolBox'>"
						+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
						+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li>"
						+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
						+"</ul>"
						+"<iframe style='width:570px; height:740px;'/></div>");		
				$(".viewerBg .project_loading:last").css("display","block");
    			$("#viewerForm").ajaxForm({
    				dataType: "text",
    				url: "showViewer",
    				success: function(jdata){
    					$("#write_bd .contentBox:last").find("iframe").attr("src",jdata);
    					$("#write_bd .viewerBg:last").css("display","none");
//    					$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
//    						+"<ul class='content_toolBoxes' id='content_toolBox'>"
//    						+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
//    						+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li>"
//    						+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
//    						+"</ul>"
//    						+"<iframe src='"+jdata+"' style='width:570px; height:740px;'/></div>");		
    					console.log("파일 이름: "+$(newFile).val());
    					if($(newFile).val().split("\\")[2] == undefined){
    						orderArr[order] = $(newFile).val();
    					} else {
    						orderArr[order] = $(newFile).val().split("\\")[2];
    					}
    					

    				    addContent();
    				
    				}
    			}).submit();
    			
    			order = parseInt(order)+1;
    			fileNum++;
    			$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents' onchange='fileChange(this)'/>");	
    			
    		} else if($.inArray(ext,['gif','png','jpg','jpeg']) != -1) {
    			// 이미지 파일
    			// 미리보기 영역에 이미지 표시
    			console.log(order);
    			$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
    					+"<ul class='content_toolBoxes' id='content_toolBox'>"
    					+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
    					+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li>"
    					+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
    					+"</ul>"
    					+"<img src='"+blobURL+"' style='display:block; margin:auto;'/></div>");

    			if($(this).val().split("\\")[2] == undefined){
    				// 파이어폭스
    				orderArr[order] = $(this).val();
    			} else {
    				orderArr[order] = $(this).val().split("\\")[2];
    			}
    			
    			order = parseInt(order)+1;
    			console.log(order);
    		    fileNum++;
    			$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents' onchange='fileChange(this)'/>");	
    			addContent();
    			
    		} else {
    			alert("업로드가 지원되지 않는 파일 형식입니다.");
    		}
    	}
    });
    
    $("#selectedCategory").change(function(){
    	// 카테고리 새로 선택했을 때 기존에 있던 세부카테고리 초기화
    	$(".card_tag").html("");
//    	if($("#write_dCategory a").html() != "세부 카테고리 선택.."){
    		$("#write_dCategory a").html("세부 카테고리 선택..");
//    	}
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
            		moveAutoCompleteBox();
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

    		
    		
    		if( $('#write_tagTxt span').last().length == 0){
    			$('#write_tagInput').css({
        			left: 0
        		})
    		}
    		else if( $('#write_tagTxt span').last().length == 1){
    			var lastSpanOffset = $('#write_tagTxt span').last().offset().left;
        		var lastSpanWidth = $('#write_tagTxt span').last().width();
        		
    			$('#write_tagInput').css({
	    			left: lastSpanOffset+lastSpanWidth-280,
	    			top: $('#write_tagTxt').height()-30
	    		})
	    		$('#write_tagTitle').css({
	    			height:$('#write_ft').height()
	    		})
    		}
    		
	    	if($("#write_tagTxt span").length == 0){
	    		// 입력된 태그가 하나도 없을 경우
	    		$("#write_tagInput").attr("placeholder","태그를 입력하세요.");
	    	}
	    	
	    	$(".autoCompleteBox").css("display","none");
	    	
	    	if($("#write_tagTxt span").size() < 2){
	    		$(".autoCompleteBox").css({
	    			left: 0,
	    			top: 30
	    		});
	    		
	    	} else {
		    	var lastSpanOffset = $('#write_tagTxt span').last().offset().left;
		    	var lastSpanWidth = $('#write_tagTxt span').last().width();
		    	
		    	$('.autoCompleteBox').css({
		    		left: lastSpanOffset+lastSpanWidth-100,
		    		top: $('#write_tagTxt').height()
		    	});
	    	}
    	} 
    });
    
    
	
	
	
    $("#write_tagInput").keyup(function(e){
    	if(e.keyCode == 188 || e.keyCode == 13){
    		// 컴마 누르면 태그 입력
    		if(($.trim($(this).val()) != "") || ($(this).val() != ",")){
    			// 왜 이프문 먹통
	    		var newTag = $(this).val().replace(",","");
	    		$(this).attr("placeholder","");
	    		$("#write_tagTxt").append("<span>"+newTag+"</span>");
	    		
	    		var lastSpanOffset = $('#write_tagTxt span').last().offset().left;
	    		var lastSpanWidth = $('#write_tagTxt span').last().width();
	    		
	//    		var lastSpanOffset = $newTag.offset().left;
	//    		var lastSpanWidth = newTag.length;
	    		
	    		
	    		$(this).val("");
	    		$(this).focus();
	    		
	    		
	    		$('#write_tagInput').css({
	    			left: lastSpanOffset+lastSpanWidth-280,
	    			top: $('#write_tagTxt').height()-30
	    		})
	    		$('#write_tagTitle').css({
	    			height:$('#write_ft').height()
	    		})
	    		
	    		
	    		$(".autoCompleteBox").css("display","none");
	    		moveAutoCompleteBox();
    		}
    	}
    });
    
    $('#contentsWrap').click(function(){
    	if($.trim($("#write_tagInput").val()) != ""){
    		var newTag = $("#write_tagInput").val().replace(",","");
    		$("#write_tagInput").attr("placeholder","");
    		$("#write_tagTxt").append("<span>"+newTag+"</span>");
    		$("#write_tagInput").val("");

    		if( $('#write_tagTxt span').last().length == 0){
    			$('#write_tagInput').css({
        			left: 0
        		})
    		}
    		else if( $('#write_tagTxt span').last().length == 1){
    			var lastSpanOffset = $('#write_tagTxt span').last().offset().left;
        		var lastSpanWidth = $('#write_tagTxt span').last().width();
        		
    			$('#write_tagInput').css({
	    			left: lastSpanOffset+lastSpanWidth-280,
	    			top: $('#write_tagTxt').height()-30
	    		})
	    		$('#write_tagTitle').css({
	    			height:$('#write_ft').height()
	    		})
    		}
    		
	    	if($("#write_tagTxt span").length == 0){
	    		// 입력된 태그가 하나도 없을 경우
	    		$("#write_tagInput").attr("placeholder","태그를 입력하세요.");
	    	}
	    	
    		$(".autoCompleteBox").css("display","none");
    		moveAutoCompleteBox();
    	}
    });
    
    $("#projectTitle").keyup(function(){
    	// 글 제목 입력하면 우측 미리보기 박스의 제목 변경
    	$(".card_title a").html($(this).val());
    });
    
//    addContent();
    
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
		
		console.log(orderArr);
	}
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
	
	console.log(orderArr);
	
}

function removeElement(e){
	// 엘리먼트 삭제
	var element = e;
	var elementOrder = $(element).closest(".contentBox").attr("data-sort");
	var nextElements = $("#write_bd").find(".contentBox").filter(function(){
		// 삭제하려는 엘리먼트보다 뒤에 있는 엘리먼트 선택
		return $(this).attr("data-sort") > elementOrder;
	});
	for(var i=0; i<nextElements.length; i++){
		var e = nextElements[i];
		e.setAttribute("data-sort",parseInt(e.getAttribute("data-sort"))-1);
	}
	
	$(element).closest(".contentBox").remove();

	// 파일 삭제했을 경우 그 파일의 input file 삭제
//	$("input[name=contents]").each(function(){
//		if($(this).val().split("\\")[2] == orderArr[order]){
//			console.log("삭제할 파일: "+$(this).val());
//			$(this).remove();
//		}
//	});
//	   
	// 삭제하면 한칸씩 밀어야함...
	var arr1 = orderArr.slice(0,elementOrder);
	var arr2 = orderArr.slice(parseInt(elementOrder)+1,orderArr.length);
	orderArr = arr1.concat(arr2);
	
	console.log(orderArr);
	
	order = parseInt(order-1);
	console.log(order);
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
    			+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
    			+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li>"
    			+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
    			+"</ul>"
    			+$("#modal_bd_writeEmbed textarea").val()+"</div>");
        orderArr[order] = $("#modal_bd_writeEmbed textarea").val();
        order = parseInt(order)+1;
        addContent();
        
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
	
	if( $('#write_tagTxt span').last().length == 0){
		$('#write_tagInput').css({
			left: 0
		})
	}
	else if( $('#write_tagTxt span').last().length == 1){
		var lastSpanOffset = $('#write_tagTxt span').last().offset().left;
		var lastSpanWidth = $('#write_tagTxt span').last().width();
		
		$('#write_tagInput').css({
			left: lastSpanOffset+lastSpanWidth-280,
			top: $('#write_tagTxt').height()-30
		})
		$('#write_tagTitle').css({
			height:$('#write_ft').height()
		})
	}
	
	if($("#write_tagTxt span").length == 0){
		// 입력된 태그가 하나도 없을 경우
		$("#write_tagInput").attr("placeholder","태그를 입력하세요.");
	}
}

function fileChange(file){
	var newFile = file;
	// 파일(이미지, 문서) 추가
	var ext = $(newFile).val().split('.')[1].toLowerCase(); // 파일의 확장자
	var file = $(newFile).prop("files")[0];
	blobURL = window.URL.createObjectURL(file);
	if($.inArray(ext,['pdf','doc','docx','ppt','pptx','xls','xlsx',
	                  'txt','py','js','xml','css','md','pl','c','m','json']) != -1){
		// doc, pdf, ppt 파일
		// 미리보기 영역에 뷰어 표시
		$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
				+"<div class='viewerBg'><div class='loading_wrap'><img class='project_loading' src='resources/images/project_loading.gif'></div></div>"
				+"<ul class='content_toolBoxes' id='content_toolBox'>"
				+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
				+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li>"
				+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
				+"</ul>"
				+"<iframe style='width:570px; height:740px;'/></div>");		
		$(".viewerBg .project_loading:last").css("display","block");
		$("#viewerForm").ajaxForm({
			dataType: "text",
			url: "showViewer",
			success: function(jdata){
				$("#write_bd .contentBox:last").find("iframe").attr("src",jdata);
				$("#write_bd .viewerBg:last").css("display","none");							
//				orderArr[order] = $(newFile).val().split("\\")[2];
				if($(newFile).val().split("\\")[2] == undefined){
					// 파이어폭스
					orderArr[order] = $(newFile).val();
				} else {
					orderArr[order] = $(newFile).val().split("\\")[2];
				}
				
				
				addContent();
			}
		}).submit();
		
		order = parseInt(order)+1;
		fileNum++;
		$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents' onchange='fileChange(this)'/>");	
//		addContent();
		
	} else if($.inArray(ext,['gif','png','jpg','jpeg']) != -1){
		// 이미지 파일
		// 미리보기 영역에 이미지 표시
		console.log(order);
		$("#write_bd").append("<div class='contentBox' data-sort="+order+">"
				+"<ul class='content_toolBoxes' id='content_toolBox'>"
				+"<li id='text_up'><a href='#' onclick='moveUpElement(this); return false;'></a></li>"
				+"<li id='text_down'><a href='#' onclick='moveDownElement(this); return false;'></a></li>"
				+"<li id='text_delete'><a href='#' onclick='removeElement(this); return false;'></a></li>"
				+"</ul>"
				+"<img src='"+blobURL+"' style='display:block; margin:auto;'/></div>");
//		orderArr[order] = $(newFile).val().split("\\")[2];
		if($(newFile).val().split("\\")[2] == undefined){
			// 파이어폭스
			orderArr[order] = $(newFile).val();
		} else {
			orderArr[order] = $(newFile).val().split("\\")[2];
		}
		
		order = parseInt(order)+1;
		console.log(order);
		fileNum++;
		console.log("파일 이름: "+$(newFile).val());
		$("#btn_addFile").append("<input type='file' class='contentFile' id='file"+fileNum+"' name='contents' onchange='fileChange(this)'/>");	
		addContent();
		
	} else {
		alert("업로드가 지원되지 않는 파일 형식입니다.");
	}
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
	console.log(range);
	console.log(getSelectedNode());
//	if(getSelectedNode().className.indexOf("txtItalic") > -1){
//		// 선택한 부분에 이미 txtBold 클래스가 적용된 부분이 있을 경우
//		// 클래스 삭제
//		console.log("클래스 이름: "+getSelectedNode().className);
//		getSelectedNode().classList.remove("txtItalic");
//	} else {
//		var newNode = document.createElement("span");
//		newNode.setAttribute("class", "txtItalic");
//		newNode.appendChild(range.extractContents());
////		range.surroundContents(newNode);
//		range.insertNode(newNode);
//	}
	
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

function addContent(){
	$('#write_bd .contentBox').hover(function(){
    	$('.content_toolBoxes',this).css('top', - 40 );    //툴박스 위치
        $('.content_toolBoxes',this).show();
    }, function(){
    	$('.content_toolBoxes',this).hide();
    	
    });
    
	$(this).trigger("focus");
}

function getColorRange(){
	var range = window.getSelection().getRangeAt(0);
	return range;
}


function moveAutoCompleteBox(){
	var lastSpanOffset = $('#write_tagTxt span').last().offset().left;
	var lastSpanWidth = $('#write_tagTxt span').last().width();
	
	$('.autoCompleteBox').css({
		left: lastSpanOffset+lastSpanWidth-280,
		top: $('#write_tagTxt').height()
	});
}
