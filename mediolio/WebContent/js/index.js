
	/*  메인페이지(index.jsp) 관련된 javascript 1
	 * 	 이유라 - UI 관련 javascript
	 *  오지은 - 기능 관련 javascript
	 * */

//이유라
$('document').ready(function(){
    //카드 위에 태그 보이기
    $(".card_img").hover(function(){
        $('div', this).addClass("card_hover");
        $('p',this).show();
    },function(){
        $('div', this).removeClass("card_hover");
        $('p',this).hide();
    });
});

//이유라
function tagHover(){
	$(".card_img").hover(function(){
        $('div', this).addClass("card_hover");
        $('p',this).show();
    },function(){
        $('div', this).removeClass("card_hover");
        $('p',this).hide();
    });
}

//오지은 - 메인에서 최신 글 "더 보기" 버튼 눌렀을 때
function seeMore(cat){
	$.ajax({
		url : "mainMorePrjs",
		type : "POST",
		data : {cate: cat},
		success : function(data) {
			$('#default_body').empty().append(data);
			tagHover();
		}
	});
}