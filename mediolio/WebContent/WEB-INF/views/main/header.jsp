<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="header">
	<div id="headerWrap">
        <div class="inputStyle" id="search_main">
        	<div id="selectWrap_main">
                <select id="select_main">
                    <option value="title">TITLE</option>
                    <option value="id">ID</option>
                    <option value="tag">TAG</option>
                </select>
           </div>
            <input class="input_in" id="text_main" type="text"/>
            <input class="btn_search" type="button" />
        </div><!--//search_main-->
        <input class="btnStyle" id="btn_login" type="button" value="LOGIN" onClick="loginModalOpen()"/>
    </div><!--//headerWrap-->
    
    
</div>
</body>
</html>