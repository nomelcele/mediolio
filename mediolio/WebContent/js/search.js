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
    				codes += "<li onclick='searchbyClass("+entry.cl_id+ ",\"" +entry.cl_name+"\")'>"
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

function searchbyClass(cl_id, cl_name){
	location.href="searchC?cl_id="+cl_id+"&cl_n="+cl_name;
}

//검색 옵션에 따라 각각 다른 처리 컨트롤러로 이동
function handlingSearch(option, keyword){
	if(option == 'tag' ) {
		if(keyword.length ==0) 		
			$.jAlert({
			    'title': '!!',
			    'content': '검색어를 입력하십시오.',
			    'closeOnClick' : true,
			    'theme' : 'red',
			    'size': 'xsm'
			  });
		else location.href="searchH?key="+keyword;		
	}
	else if(option == 'title'){
		if(keyword.length ==0) 
			$.jAlert({
			    'title': '!!',
			    'content': '검색어를 입력하십시오.',
			    'closeOnClick' : true,
			    'theme' : 'red',
			    'size': 'xsm'
			  });
		else {
			var ctgr = returnCategoryVal($('.team_category').find('.btn_222').val());
			location.href="searchT?key="+keyword+"&ct="+ctgr;
		}
	}
	else if(option == 'member'){
		var skVal = $('.team_techWrap input:radio[name="skills"]:checked').val();
		if(keyword.length == 0 && skVal === undefined) 
			$.jAlert({
			    'title': '!!',
			    'content': '검색어를 입력하거나 보유기술을 선택하십시오.',
			    'closeOnClick' : true,
			    'theme' : 'red',
			    'size': 'xsm'
			  });
		else {
			if(skVal == null || skVal == undefined) skVal = '0';
			var ctgr = returnCategoryVal($('.team_category').find('.btn_222').val());
			location.href="searchM?key="+keyword+"&ct="+ctgr+"&sk="+skVal;
		}
	}
}

function returnCategoryVal(text){
	var cateIntVal = "0";
	if(text == "게임") cateIntVal = "1";
	else if(text == "웹 & 앱") cateIntVal = "2";
	else if(text == "디자인") cateIntVal = "5";
	else if(text == "영상 & 사운드") cateIntVal = "3";
	else if(text == "3D") cateIntVal = "4";
	else if(text == "기타") cateIntVal = "6";
	return cateIntVal;
}

$('document').ready(function(){
	//검색창에 검색중인 옵션 표시
	$('#text_main').val($('.searchResult .searchKey').text());
	var searched_option = $('.searchResult .searchType').text();
	
	$('#selectWrap_main .list li').removeClass("selected");
	if(searched_option == ''){
		$('#selectWrap_main .nice-select .current').text('학우 검색');
	}else{
		$('#selectWrap_main .nice-select .current').text(searched_option+' 검색');
		
		if(searched_option == '학우') $('#selectWrap_main .list li:eq(0)').addClass("selected");
		else if(searched_option == '제목') $('#selectWrap_main .list li:eq(1)').addClass("selected");
		else if(searched_option == '태그') $('#selectWrap_main .list li:eq(2)').addClass("selected");
		else if(searched_option == '과목') $('#selectWrap_main .list li:eq(3)').addClass("selected");
	}
	
	//검색버튼 클릭 시 액션
	$(document).on('click', '#search_main .btn_search', function(){
		var option_value = select.options[select.selectedIndex].value;
		var keyword = document.getElementById('text_main');
		
		handlingSearch(option_value, keyword.value);
	});
	
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
			if(option_value == 'subject') 
				$.jAlert({
				    'title': '!!',
				    'content': '제시된 목록에서 선택하세요.',
				    'closeOnClick' : true,
				    'theme' : 'red',
				    'size': 'xsm'
				  });
			else handlingSearch(option_value, keyword.value);
		}
		else if(option_value == 'subject'){
			autoRecommendClass(keyword.value, option_value);
		}
	});

});
