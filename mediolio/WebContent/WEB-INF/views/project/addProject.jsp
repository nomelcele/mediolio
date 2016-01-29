<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	fieldset{display:inline-block;}
</style>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script>
	$(function(){
		$("#dbTestBtn").click(function(){
			location="dbTest";
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
				<div></div>
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