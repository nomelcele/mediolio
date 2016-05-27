/*  히스토리 관련 javascript
 * 	 이유라 - UI 관련 javascript
 *  모하람 - 기능 관련 javascript
 * */

var imgCnt = 1;

$(function(){
	$("#addHistoryBtn").click(function(){
		// 모하람 작성 - 히스토리 추가
		$("#addHistoryForm").submit();
	});
	
	
	$(".historyList_addRelated").keyup(function(){
		// 모하람 작성 - 관련 과목 입력 시 자동 완성
		if($(this).val().trim() != ""){
	    	$.ajax({
	    		type: "POST",
	    		url: "autocompleteClass",
	    		data: {
	    			cl_name: $(this).val()
	    		},
	    		dataType: "json",
	    		success: function(jdata){
	    			var codes = "";
	    			var arr = jdata;
	    			for(var i=0; i<arr.length; i++){
	    				codes += "<li onclick='addClass(this)'>"+arr[i]+"</li>";
	    			}
	    			if(arr.length>0){
	    				$("#autoCompleteArea").html(codes);
	        			$(".autoHtClass").css({
	        				display: "block",
	        				top: $(".historyList_addRelated").offset().top-108,
	        				left: 24
	        			});
	        			
	            		// moveAutoCompleteBox();
	        			// 자동 완성 목록 위치 변경: 현재 커서 위치에 맞게
	    			}
	    		}
	    	});
    	} else {
    		$(".autoHtClass").css("display","none");
    	}

	});
	
	listLoad();

	
	$(".btn_timeCard_addImage").click(function(){
		// 모하람 작성 - 브랜치 등록 시 사진 추가
		if(imgCnt<=3)
			imgCnt++;
		
		console.log("사진 수: "+imgCnt);
		
		switch(imgCnt){
			case 1:
				$("#imgFileBox1").css("display","block");
				break;
			case 2:
				$("#imgFileBox2").css("display","block");
				break;
			case 3:
				$("#imgFileBox3").css("display","block");
				break;
			default:
	    		$.jAlert({
	    		    'title': '!!',
	    		    'content': '이미지는 최대 3개까지만 업로드 가능합니다.',
	    		    'closeOnClick' : true,
	    		    'theme' : 'red',
	    		    'size': 'xsm'
	    		  });
		}
	});

	$(".file_timeCard").change(function(){
		// 모하람 작성 - 파일 업로드 했을 때 이름 보여주기
		var fileName = $(this).val().split("\\")[2];
		$(this).parent().parent().find("label").html(fileName);
	});

	$(".btn_timeCard_delImage").click(function(){
		// 모하람 작성 - 등록한 사진 삭제
	
		if(imgCnt == 4){
			imgCnt -= 2;
		} else if(imgCnt > 1){
			imgCnt--;
		} 
		
		console.log("사진 수: "+imgCnt);
		if($(this).parent().prop("id") != "imgFileBox1"){
			$(this).parent().css("display","none");
		} else {
			console.log("첫번째 사진 삭제");
			$(this).parent().find("label").html("");
		}
		// input 파일 내용 비우기
		$(this).parent().find(".fileWrap_timeCard").find("input[type=file]").val("");
	});

	$(".br_delete_btn").click(function(){
		// 모하람 작성 - 브랜치 삭제
		$.ajax({
			type: "POST",
			url: "deleteBranch",
			data: {
				br_id: $(this).parent().find(".branch_id").val(),
				ht_id: $("#recentHtId").val(),
				ht_title: $("#recentHtTitle").val()
			}, 
			success: function(result){
				$(".historyWrap").html(result);
				imgCnt = 1;
			}
		});
	});
});

function addClass(li){
	// 모하람 작성 - 자동 완성 목록에서 항목 클릭 시 관련 과목 영역에 추가
	var newClass = li;
	console.log("과목: "+$(newClass).find("span").html());
	$(".historyList_addRelated").val($(newClass).find("span").html());
	$(".autoHtClass").css("display","none");
	$(".timeCard_writeDisplayWrap").append("<input type='hidden' name='cl_id' value="+$(newClass).find(".classId").val()+">");
}

function deleteHistory(ht_id){
	// 모하람 작성 - 히스토리 삭제
	$("#deleteHt"+ht_id).submit();
}

function changeHtPublic(ht_id,ht_public){
	// 모하람 작성 - 히스토리의 공개 여부 변경
	var new_public;
	if(ht_public == 1){
		new_public = 0;
	} else {
		new_public = 1;
	}
	$.ajax({
		type: "POST",
		url: "changeHtPublic",
		data: {
			ht_id: ht_id,
			ht_public: new_public
		}, 
		success: function(result){
			$(".historyExWrap").html(result);
			listLoad();
		}
	});
}

function listLoad(){
	$("#addHistoryBtn").click(function(){
		// 모하람 작성 - 히스토리 추가
		$("#addHistoryForm").submit();
	});
	
	// 이유라 작성 
    /* 히스토리 목록 */
    var btn_difHistory = false;
    /*-- 히스토리 선택 전 숨기기 --*/
    $('.historyList_contentWrap, .historyList_pop').hide();
    $('.bd_historyEx table').css({ minHeight:40 });
    
    //.historyList_name
    $('.historyList_name').on('click',function(e){
    	// 모하람 작성 - 선택한 히스토리 보여주기
		$.ajax({
			type: "POST",
			url: "historyDetail",
			data: {
				ht_id: $(this).find(".history_id").val(),
				ht_title: $(this).find(".history_title").html(),
				type: $("#mypageType").val()
			},
			success: function(result){
				$(".historyWrap").html(result);
				imgCnt = 1;
				
			}
		});
    	
		// 이유라 작성
        $('.historyList_name .history_popMenuWrap').not($(this).find('.history_popMenuWrap')).hide();
        /*-- 선택한 것 이외의 것들 숨기기 --*/
        $('.historyList_contentWrap, .historyList_pop').hide();
        $('.bd_historyEx table').css({ minHeight:40 });
        /*-- 하나의 히스토리 선택 후 --*/ $(this).parent().siblings().find('.historyList_contentWrap').show();
        $(this).parents('.bd_historyEx table').css({ minHeight:100 });
        $('.historyList_pop',this).show();
        btn_historyList_pop = false;
        
    });
    
    
    // 이유라 작성
    var btn_historyList_pop = false;
    $('.historyList_name .historyList_pop').on('click', function(){
        btn_historyList_pop = !btn_historyList_pop; 
        if(btn_historyList_pop){
            $(this).next('.history_popMenuWrap').show();//hide();

        }
        else{
            $('.history_popMenuWrap').hide();
        }
        return false;
    });
    
}

function autoCompleteHtClass(txt){
	// 모하람 작성 - 히스토리 관련 과목 자동 완성
	var htClass = txt;
	if($(htClass).val().trim() != ""){
    	$.ajax({
    		type: "POST",
    		url: "autocompleteClass",
    		data: {
    			cl_name: $(htClass).val()
    		},
    		dataType: "json",
    		success: function(jdata){
    			var codes = "";
    			var arr = jdata;
    			for(var i=0; i<arr.length; i++){
    				codes += "<li onclick='addClass(this)'>"+arr[i]+"</li>";
    			}
    			if(arr.length>0){
    				$("#autoCompleteArea").html(codes);
        			$(".autoHtClass").css({
        				display: "block",
        				top: $(".historyList_addRelated").offset().top-108,
        				left: 24
        			});
        			
            		// moveAutoCompleteBox();
        			// 자동 완성 목록 위치 변경: 현재 커서 위치에 맞게
    			}
    		}
    	});
	} else {
		$(".autoHtClass").css("display","none");
	}
}

function addBrImg(){
	// 모하람 작성 - 브랜치에 사진 추가
	if(imgCnt<=3)
		imgCnt++;
	
	console.log("사진 수: "+imgCnt);
	
	switch(imgCnt){
		case 1:
			$("#imgFileBox1").css("display","block");
			break;
		case 2:
			$("#imgFileBox2").css("display","block");
			break;
		case 3:
			$("#imgFileBox3").css("display","block");
			break;
		default:
    		$.jAlert({
    		    'title': '!!',
    		    'content': '이미지는 최대 3개까지만 업로드 가능합니다.',
    		    'closeOnClick' : true,
    		    'theme' : 'red',
    		    'size': 'xsm'
    		  });
	}
}

function showFileName(file){
	// 모하람 작성 - 파일 업로드 시 파일 이름 보여주기
	var imgFile = file;
	var fileName = $(imgFile).val().split("\\")[2];
	$(imgFile).parent().parent().find("label").html(fileName);
}

function deleteBrImg(num){
	// 모하람 작성 - 브랜치에 등록한 사진 삭제

	if(imgCnt == 4){
		imgCnt -= 2;
	} else if(imgCnt > 1){
		imgCnt--;
	} 
	
	console.log("사진 수: "+imgCnt);
	
	
	switch(num){
		case 1:
			$("#imgFileBox1").find("label").html("");
			$("input[name=imgFiles[0]").val("");
			break;
		case 2:
			$("#imgFileBox2").css("display","none");
			$("input[name=imgFiles[1]").val("");
			break;
		case 3:
			$("#imgFileBox3").css("display","none");
			$("input[name=imgFiles[2]").val("");
			break;	
	}
	
	
//	if($(delBtn).parent().prop("id") != "imgFileBox1"){
//		$(delBtn).parent().css("display","none");
//	} else {
//		$(delBtn).parent().find("label").html("");
//	}
	// input 파일 내용 비우기
//	$(delBtn).parent().find(".fileWrap_timeCard").find("input[type=file]").val("");
}

function deleteBranch(){
	// 모하람 작성 - 브랜치 삭제
	$.ajax({
		type: "POST",
		url: "deleteBranch",
		data: {
			br_id: $(this).parent().find(".branch_id").val(),
			ht_id: $("#recentHtId").val(),
			ht_title: $("#recentHtTitle").val()
		}, 
		success: function(result){
			$(".historyWrap").html(result);
			imgCnt = 1;
		}
	});
}