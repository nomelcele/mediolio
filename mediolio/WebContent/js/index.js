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

function tagHover(){
	$(".card_img").hover(function(){
        $('div', this).addClass("card_hover");
        $('p',this).show();
    },function(){
        $('div', this).removeClass("card_hover");
        $('p',this).hide();
    });
}

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