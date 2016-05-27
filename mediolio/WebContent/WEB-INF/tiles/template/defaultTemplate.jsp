<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MEDIOLIO</title>
</head>
<body>

<!-- 오지은 작성 (Spring Tiles 템플릿)-->

	<!-- 헤더 영역 -->
	<tiles:insertAttribute name="header"/>

	<!--left메뉴 영역 -->
	<tiles:insertAttribute name="aside"/>
	
	<!-- 바디 영역 -->
	<div id="default_body">
		<tiles:insertAttribute name="body"/>
	</div>
</body>
</html>