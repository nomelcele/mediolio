<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	fieldset{display:inline-block;}
	.mediaTagArea{display:none;}
	.textArea{display:none;}
</style>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery.gdocsviewer.min.js"></script>
<script>
	$(function(){
		$("#dbTestBtn").click(function(){
			location="dbTest";
		});
		
		$("#fileUpload").change(function(){
			// 파일 추가
			var ext = $(this).val().split('.').pop().toLowerCase(); // 파일의 확장자
			var file = $(this).prop("files")[0];
			console.log(file);
			blobURL = window.URL.createObjectURL(file);
			if($.inArray(ext,['gif','png','jpg','jpeg']) == -1){
				// doc, pdf, ppt
				$(".tempFilePath").attr("href",blobURL);
				// $(".tempFilePath").gdocsViewer()
				$("#docViewer").attr("src",blobURL);
				$("#docViewer2").attr("src","https://docs.google.com/viewer?url=http://localhost/mediolio/resources/doc/doctest.docx&embedded=true");
			} else {
				// 이미지 파일
				// 미리보기 영역에 이미지 표시
				$(".writeArea").append("<p><img src='"+blobURL+"' style='display:block;'/></p>");				
			}
		});
		
		$("#tagBtn").click(function(){
			// 미디어 태그 추가
			$(".mediaTagArea").css("display","block");
		});
		
		$("#mediaTagAddBtn").click(function(){
			// 미디어 태그 표시(비디오 등)
			$(".writeArea").append("<p>"+$("#mediaTagContent").val()+"</p>");
		});
		
		$("#textBtn").click(function(){
			// 텍스트 추가
			$(".textArea").css("display","block");
		});
		
		$("#textAddBtn").click(function(){
			// 텍스트 표시
			$(".writeArea").append("<p>"+$("#textContent").val()+"</p>");
		});
	});
</script>
</head>
<body>
	<fieldset>
		<legend>글쓰기</legend>
		<div>
			<div>
				<select>
					<option selected>카테고리 선택</option>
					<option>게임</option>
					<option>영상</option>
					<option>사운드</option>
					<option>웹/모바일</option>
					<option>디자인</option>
				</select>
				<input type="text" placeholder="제목을 입력하세요.">
			</div>
			<div>
				<div>
					<input type="file" id="fileUpload">
					<input type="button" id="tagBtn" value="embed">
					<input type="button" id="textBtn" value="텍스트">
				</div>
				<div class="mediaTagArea">
					<textarea id="mediaTagContent" placeholder="미디어 태그를 입력하세요."></textarea>
					<input type="button" id="mediaTagAddBtn" value="태그 추가">
				</div>
				<div class="textArea">
					<textarea id="textContent" placeholder="텍스트를 입력하세요."></textarea>
					<input type="button" id="textAddBtn" value="텍스트 추가">
				</div>				
				<div class="writeArea">
					
				</div>
			</div>
			<div>
				<input type="text" placeholder="태그를 입력하세요.">
			</div>
		</div>
	</fieldset>
	<fieldset>
		<legend>카드 미리보기</legend>
		<div>
			<input type="button" value="대표 이미지 선택">
		</div>
	</fieldset>	
</body>
</html>