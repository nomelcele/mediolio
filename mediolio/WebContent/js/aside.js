
$(function(){
	$(".nav_category>li>div").on('click',function(){
		var str="";
		str = $(this).attr('id');
		
		$.ajax({
			url : "selcatcard",
			type : "POST",
			data : {selcat: str},
			success : function(data) {
				$('#default_body').empty().append(data);
				tagHover();
			}
		});
	});
/*	$("#userBox #myPf a").click(function(){
		$.ajax({
			url : "selectmypage",
			type : "POST",
			success : function(data) {
				$('#default_body').empty().append(data);
				tagHover();
			}
		});
	});*/
	
	
	$("#userBox #likePf a").click(function(){
		$.ajax({
			url : "selectlikepage",
			type : "POST",
			success : function(data) {
				$('#default_body').empty().append(data);
				tagHover();
			}
		});
	});
	
});