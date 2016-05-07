/* 오지은
 * header.jsp 의 id 'select_main'의 onchange 이벤트 */
function selectChanged(){
	var select = document.getElementById('select_main');
	var option_value = select.options[select.selectedIndex].value;
	
	//학우 검색
	if(option_value == 'member'){
		//모두 보이기
        $('.team_category input[type="button"]').removeClass('btn_222');
        $('#teamCategory_total').addClass('btn_222');
        $('.searchTermWrap .team_techWrap').hide();
        $('.techWrap_language, .techWrap_game, .techWrap_webApp, .techWrap_design, .techWrap_video, .techWrap_3d, .techWrap_etc').show();
        $('#category_select, #skill_select, .searchTermWrap').show();
	}
	//글 제목 검색
	else if(option_value == 'title'){
		//보유기술란 숨기기
		$('#category_select').show();
		$('#skill_select').hide();
		$('.searchTermWrap').show();
	}
	//태그 검색
	else if(option_value == 'tag' || option_value == 'subject'){
		//모두 숨기기
		$('.searchTermWrap').hide();
	}
}

function autoRecommendClass(classname){
	console.log(classname);
    // 태그 자동 완성
    if( classname.trim() != ""){
    	$.ajax({
    		type: "POST",
    		url: "autocompleteClass",
    		data: {
    			cl_name:  classname.trim()
    		},
    		dataType: "json",
    		success: function(jdata){
    			var codes = "";
    			var arr = jdata;
    			for(var i=0; i<arr.length; i++){
    				codes += "<li onclick='addClass(this)'>"+arr[i]+"</li>";
    			}
    			if(arr.length>0){
    				$("#searchAutoCompleteArea").html(codes);
        			$(".searchAutoCompleteBox").css({
        				display: "block",
        				left: 120
        			});

    			}
    		}
    	});
    }
}

function moveAutoCompleteBox(){
	var lastSpanOffset = $('#write_tagTxt span').last().offset().left;
	var lastSpanWidth = $('#write_tagTxt span').last().width();
	
	$('.autoCompleteBox').css({
		left: lastSpanOffset+lastSpanWidth-280,
		top: $('#write_tagTxt').height()
	});
}

$('document').ready(function(){
/*	if(isFireFox()) {
	    element.bind("keypress", function (event) {
	        var keyCode = event.which || event.keyCode;
	        if(keyCode === 13 || keyCode === 9) { // 13: enter, 9: tab
	        	alert("키키");
	        }
	    })
	}*/
	
	var select = document.getElementById('select_main');
	var keyword = document.getElementById('text_main');
	
	//과목검색 시 과목 자동완성
	$('#text_main').on('keydown',function(){
		var option_value = select.options[select.selectedIndex].value;
		if(option_value == 'subject'){
			var keyword = document.getElementById('text_main');
			autoRecommendClass(keyword.value);
		}
	});

});
