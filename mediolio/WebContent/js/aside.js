$(function(){
	$(".selsub, #ct_design, #ct_sound").on('click',function(){
		var str="";
		if($(this).text()=='기획'){
			if(($(this).parent().parent().parent().contents(":first-child").text()=='GAME')){
				str="게임기획";
			}
			else{
				str="웹기획";
			}
		}
		else if($(this).text()=='개발'){
			if(($(this).parent().parent().parent().contents(":first-child").text()=='GAME')){
				str="게임개발";
			}
			else{
				str="웹개발";
			}

		}
		else{
			str = $(this).text();
		}
		$.ajax({
			url : "selcatcard",
			type : "POST",
			data : {selcat: str},
			success : function(data) {
				$('#default_body').empty().append(data);
			}
		});
		
	});
});