/**
 * 
 */
var imgCnt = 1;

$(function(){
	$("#addHistoryBtn").click(function(){
		// 히스토리 추가
		$("#addHistoryForm").submit();
	});
	
	$(".btn_timeCard_addImage").click(function(){
		// 사진 추가
		if(imgCnt<=3)
			imgCnt++;
		
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
				alert("이미지는 최대 3개까지만 업로드 가능합니다.");	
		}
	});
	
	$(".file_timeCard").change(function(){
		// 파일 업로드 했을 때 이름 보여주기
		var fileName = $(this).val().split("\\")[2];
		$(this).parent().parent().find("label").html(fileName);
	});
	
	$(".btn_timeCard_delImage").click(function(){
		// 사진 삭제
		imgCnt--;
		$(this).parent().css("display","none");
		// 왜 위로 올라감 ㅡㅡ
		// input 파일 내용 비우기
	});
	
});

