/* 오지은
 * header.jsp 의 id 'select_main'의 onchange 이벤트 */

//검색옵션 select 값 변경 시 호출되는 함수
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
        $('.team_category input[type="button"]').removeClass('btn_222');
        $('#teamCategory_total').addClass('btn_222');
		
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

//과목 자동완성
function autoRecommendClass(classname){
    if( classname.trim() != ""){
    	$.ajax({
    		type: "POST",
    		url: "searchAutoCompleteClass",
    		data: {
    			cl_name:  classname.trim()
    		},
    		dataType: "json",
    		success: function(data){
    			var codes = "";
    			$.each(data.list, function(index, entry){
    				codes += "<li onclick='search("+entry.cl_id+", " + '\"subject\"' + ")'>"
    								+"<span class='className'>"+entry.cl_name+"</span>"
    							+"</li>";
    			});
    			if(data.list.length>0){
    				$("#searchAutoCompleteArea").html(codes).show();
        			$(".searchAutoCompleteBox").css({
        				display: "block",
        				left: 120
        			});

    			}
    		}
    	});
    }
}


function search(keyword, option){
	alert(keyword + ", " + option);
	$.ajax({
		url : "search",
		type : "POST",
		data : {key : keyword, section : option},
		dataType : "JSON",
		success : function(data) {
			
		}
	});
}
function searchTitle(keyword, option, category){
	//option : 검색옵션(학우검색, 제목검색..) , category : 검색결과를 뽑고 싶은 카테고리(웹앱, 게임 ...)
	alert(keyword +", " + option + ", " + category);
	$.ajax({
		url : "searchTitle",
		type : "POST",
		data : {key : keyword.trim(), section : option, ct : category},
		dataType : "JSON",
		success : function(data) {
			
		}
	});
}

function searchMember(keyword, option, category, skill){
	alert(keyword +", " + option + ", " + category + "," + skill);
	if(skill == null || skill == undefined) skill = '0';
	$.ajax({
		url : "searchMember",
		type : "POST",
		data : {key : keyword.trim(), section : option, ct : category, sk : skill},
		dataType : "JSON",
		success : function(data) {
			
		}
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
	$('#text_main').on('keydown',function(event){
		var option_value = select.options[select.selectedIndex].value;
		var keyword = document.getElementById('text_main');
		
		if(event.keyCode==13){
			if(option_value == 'subject') alert("제시된 목록에서 선택하세요.");
			else if(option_value == 'tag' ) search(keyword.value, option_value);
			else if(option_value == 'title'){
				if(keyword.value.length !=0) alert("검색어를 입력하십시오.");
				else searchTitle(keyword.value, option_value, $('.team_category').find('.btn_222').val());
			}
			else if(option_value == 'member'){
				var skVal = $('.team_techWrap input:radio[name="skills"]:checked').val();
				if(keyword.value.length == 0 && skVal === undefined) alert("검색어를 입력하거나 보유기술을 선택하십시오.");
				else searchMember(keyword.value, option_value, $('.team_category').find('.btn_222').val(), skVal);
			}
		}
		else if(option_value == 'subject'){
			autoRecommendClass(keyword.value, option_value);
		}
	});

});
