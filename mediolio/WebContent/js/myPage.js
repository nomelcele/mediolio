/*  마이 페이지 관련 javascript
 *  이유라 - UI 관련 javascript
 *  모하람 - 기능 관련 javascript
 * */

$(document).ready(function(){
	$("#myProjectWrap").hide();
//	$('#bxslider').bxSlider();
	
	$(".showMyHistory").click(function(){
		// 모하람 작성 - 내 히스토리 보기
		$("#myHistoryWrap").show();
		$("#myProjectWrap").hide();
		$(".showMyHistory a").css("color","#333");
		$(".showMyHistory a").hover(
				  function () {
				    $(this).css("color", "#0F84CF");
				  }, 
				  function () {
				    $(this).css("color", "#333");
				  }
		);
		$(".pageTitleNext a").css("color","#999");
		$(".pageTitleNext a").hover(
				  function () {
				    $(this).css("color", "#0F84CF");
				  }, 
				  function () {
				    $(this).css("color", "#999");
				  }
		);
	});
	
	$(".pageTitleNext").click(function(){
		// 모하람 작성 - 내 게시물 보기
		$("#myHistoryWrap").hide();
		$("#myProjectWrap").show();
		$(".showMyHistory a").css("color","#999");
		$(".showMyHistory a").hover(
				  function () {
				    $(this).css("color", "#0F84CF");
				  }, 
				  function () {
				    $(this).css("color", "#999");
				  }
		);
		$(".pageTitleNext a").css("color","#333");
		$(".pageTitleNext a").hover(
				  function () {
				    $(this).css("color", "#0F84CF");
				  }, 
				  function () {
				    $(this).css("color", "#333");
				  }
		);
	});
	
    
    // 이유라 작성 - 히스토리 카드 전체 편집 버튼
    var btn_editAllCards=false;
    $('#btn_editAllCards').on('click',function(){
        btn_editAllCards=!btn_editAllCards;
        if(btn_editAllCards){
            $('.timeCard_btnBox').show();
        }
        else{
            $('.timeCard_btnBox').hide();    
        }
    })
    
    
    
    
    // 이유라 작성
    /* 히스토리 목록 */
    var btn_difHistory = false;
    /*-- 히스토리 선택 전 숨기기 --*/
    $('.historyList_contentWrap, .historyList_pop').hide();
    $('.bd_historyEx table').css({ minHeight:40 });
    
    
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
        
    })
    
    
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
    })
    
})