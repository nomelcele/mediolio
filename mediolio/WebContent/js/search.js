$(function(){


/*			$.ajax({
				url : "LoginInfo",
				type : "Post",
				data : {m_mail: $('#mail').val(), pw: $('#pw').val()},
				cache : false,
				async : false,
				dataType : "JSON",
				success : function(response) {								

				}
			});*/

});

/* 오지은
 * header.jsp 의 id 'select_main'의 onchange 이벤트 */
function selectChanged(){
	var select = document.getElementById('select_main');
	var option_value = select.options[select.selectedIndex].value;
	
	//학우 검색
	if(option_value == 'member'){
		//모두 보이기
		$('#category_select').show();
		$('#skill_select').show();
		$('.searchTermWrap').show();
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