
/*  팔로우/팔로잉 페이지 관련 javascript
 *  이유라 - UI 관련 javascript
 *  오지은 - 기능 관련 javasciript
 * */


$(document).ready(function(){
	
	//이유라 작성 - 탭 클릭 시 UI 변화
    $('#friendTab_following').addClass("friendTabClick");
    $("#friendWrap_bd_following").show();
    $("#friendWrap_bd_follower").hide();
    
    
    //오지은 작성 - 팔로우 삭제 버튼 눌렀을 때 cancelFollow() 호출
    $(document).unbind("click").on('click', '.btn_cancelFollow', function(){
    	var liObj = $(this).closest('li');
	    $.jAlert({
	        'title': '!!',
	        'content': '정말 팔로우를 취소하시겠습니까?',
	        'closeOnClick' : true,
	        'theme' : 'red',
	        'btns': [{ 'text': 'YES',  'theme' : 'green',
			        	'onClick' : function(e){
			        		e.preventDefault();
			        		cancelFollow(liObj);
			        	}
	        		  }, 
	                 { 'text': 'NO', 'theme' : 'red'}]
	      });
	})
    
    //following 탭
    $('#friendTab_following').on('click',function(){
    	if($('#friendWrap_bd_following').find('li').length || $('#friendTab_following').find('span').text() == '0'){
    		//내용물이 이미 존재하면 다시 받아오지 않음
            
    		//이유라 작성
    		$('.friendTab').removeClass("friendTabClick");
            $("#friendWrap_bd_follower").hide();
            $("#friendWrap_bd_following").show();
            $(this).addClass("friendTabClick");
    	}
    	else{
    		//ajax 오지은 작성
    		$.ajax({
    			url : "getFollowingList",
    			type : "POST",
    			dataType : "JSON",
    			success : function(data) {
    				$('#friendWrap_bd_following ul').empty().append(returnFriendList(data.list, "following"));		
    	            
    				//이유라 작성
    				$('.friendTab').removeClass("friendTabClick");
    	            $("#friendWrap_bd_follower").hide();
    	            $("#friendWrap_bd_following").show();
    	            $(this).addClass("friendTabClick");
    			}
    		});
    	}
    });
    
    //follower 탭
    $('#friendTab_follower').on('click',function(){
    	if($('#friendWrap_bd_follower').find('li').length){
    		//내용물이 이미 존재하면 새로 데이터를 받아오지 않음

    		//이유라 작성
    		$('.friendTab').removeClass("friendTabClick");
            $("#friendWrap_bd_following").hide();
            $("#friendWrap_bd_follower").show();
            $(this).addClass("friendTabClick");
    	}else if($('#friendTab_follower').find('span').text() == '0'){
    		
    		//팔로워가 없을때
    		$('.friendTab').removeClass("friendTabClick");
            $("#friendWrap_bd_following").hide();
            $('#friendWrap_bd_follower ul').empty().append('<li><p>팔로워가 없습니다</p></li>');
            $("#friendWrap_bd_follower").show();
            $(this).addClass("friendTabClick");
    	}
    	else{
    		//ajax 오지은 작성
    		$.ajax({
    			url : "getFollowerList",
    			type : "POST",
    			dataType : "JSON",
    			success : function(data) {
    				$('#friendWrap_bd_follower ul').empty().append(returnFriendList(data.list, "follower"));
    	            
    				//이유라 작성
    				$('.friendTab').removeClass("friendTabClick");
    	            $("#friendWrap_bd_following").hide();
    	            $("#friendWrap_bd_follower").show();
    	            $(this).addClass("friendTabClick");
    			}
    		});
    	}
    });
});

//오지은 작성 - 팔로우 취소 눌렀을 때 처리하는 ajax
function cancelFollow($li){
	$.ajax({
		url: "followCancel",
		type: "POST",
		data: {m_id:$li.find('.memberId').val()},
		dataType : "json",
		success: function(result){
			$li.remove();
		}
	});
}

//오지은 작성 - 팔로우/팔로워 탭을 눌렀을 때 동적으로 받아온 팔로워 목록을 html로 가공하여 리턴하는 함수
function returnFriendList(list, type){
	var aRow='';

	$.each(list, function(index, entry){
		aRow += '<li>'
					+'<p class="friendList_id"><input type="hidden" value="'+entry.m_id+'" class="memberId"/>'
						+'<a href="userpage?usr_id='+entry.m_id+'">'+entry.m_studentID +' '+ entry.m_name+'</a>';
		if(type=="following"){
			aRow += '<input type="button" value="X" class="btn_cancelFollow"/>';
		}
		aRow		+='</p>'
					+'<p class="friendList_intro">';
		if(entry.m_introduce != null) aRow += entry.m_introduce;
		aRow +='</p>'
				+'<p class="friendList_like">관심분야 : <span>'+entry.m_interestingText1;
		if(entry.m_interestingText2 != null){
			aRow += ', ' +entry.m_interestingText2;
		}
		aRow += '</span></p>'
					+'<div class="friendList_project">';
		if(entry.projects != null){
			var projectArr = (entry.projects).split("/"); //projectArr에는 프로젝트 1, 2, 3에 관한 정보 나눠서 들어감
			//projectArr[0]에 "id,img" 붙어있음 
			for(var i=0; i<projectArr.length; i++){
				var aSetArr = projectArr[i].split(",");
				//aSetArr[0]=p_id, aSetArr[1]= coverImg
				if(aSetArr.length==2){
					aRow += '<a href="projectView?p_id='+aSetArr[0]+'&m_id='+entry.m_id+'"><img src="resources/images/projectCover/'+aSetArr[1]+'" width="80" height="80"/></a>';
				}else{
					aRow += '<a href="projectView?p_id='+aSetArr[0]+'&m_id='+entry.m_id+'"><img src="resources/images/default.png" width="80" height="80"/></a>';
				}
				
			}
		}
		aRow +='</div>'
				+'</li>';
	});
	return aRow;
}
