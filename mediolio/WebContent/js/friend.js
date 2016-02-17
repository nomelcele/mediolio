$(document).ready(function(){
    $('#friendTab_following').addClass("friendTabClick");
    $("#friendWrap_bd_following").show();
    $("#friendWrap_bd_follower").hide();
    
    $(document).on('click', '.btn_cancelFollow', function(){
    	cancelFollow($(this).closest('li'));
    });
    
    //following 탭
    $('#friendTab_following').on('click',function(){
    	if($('#friendWrap_bd_following').find('li').length || $('#friendTab_following').find('span').text() == '0'){
    		//내용물이 이미 존재하면 다시 받아오지 않음
            $('.friendTab').removeClass("friendTabClick");
            $("#friendWrap_bd_follower").hide();
            $("#friendWrap_bd_following").show();
            $(this).addClass("friendTabClick");
    	}
    	else{
    		$.ajax({
    			url : "getFollowingList",
    			type : "POST",
    			dataType : "JSON",
    			success : function(data) {
    				$('#friendWrap_bd_following ul').empty().append(returnFriendList(data.list, "following"));		
    	            
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
    	if($('#friendWrap_bd_follower').find('li').length || $('#friendTab_follower').find('span').text() == '0'){
    		//내용물이 이미 존재하거나 follower 수가 0이면 받아오지 않음
            $('.friendTab').removeClass("friendTabClick");
            $("#friendWrap_bd_following").hide();
            $("#friendWrap_bd_follower").show();
            $(this).addClass("friendTabClick");
    	}
    	else{
    		$.ajax({
    			url : "getFollowerList",
    			type : "POST",
    			dataType : "JSON",
    			success : function(data) {
    				$('#friendWrap_bd_follower ul').empty().append(returnFriendList(data.list, "follower"));
    	            
    				$('.friendTab').removeClass("friendTabClick");
    	            $("#friendWrap_bd_following").hide();
    	            $("#friendWrap_bd_follower").show();
    	            $(this).addClass("friendTabClick");
    			}
    		});
    	}
    });
});

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

function returnFriendList(list, type){
	var aRow='';
	$.each(list, function(index, entry){
		aRow += '<li>'
					+'<p class="friendList_id"><input type="hidden" value="'+entry.m_id+'" class="memberId"/>'
						+'<a href="#">'+entry.m_name+'</a>';
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
			if(entry.m_interestingText3 != null) aRow += ', ' +entry.m_interestingText3;
		}
		aRow += '</span></p>'
					+'<div class="friendList_project">';
		var projectArr = (entry.projects).split("/"); //projectArr에는 프로젝트 1, 2, 3에 관한 정보 나눠서 들어감
		//projectArr[0]에 "id,img" 붙어있음 
		for(var i=0; i<projectArr.length; i++){
			var aSetArr = projectArr[i].split(",");
			//aSetArr[0]에는 p_id가, aSetArr[1]에는 coverImg가 들어있음
			if(aSetArr[1].length){
				aRow += '<a href="#detail?p_id='+aSetArr[0]+'" onclick="contentModalOpen(this, '+'\'friend\''+')"><img src="resources/images/projectCover/'+aSetArr[1]+'" width="80" height="80"/></a>';
			}else{
				aRow += '<a href="#detail?p_id='+aSetArr[0]+'" onclick="contentModalOpen(this, '+'\'friend\''+')"><img src="resources/images/default.png" width="80" height="80"/></a>';
			}
			
		}
		aRow +='</div>'
				+'</li>';
	});
	return aRow;
}
