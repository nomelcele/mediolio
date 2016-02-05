<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="aside">
    <div id="logoWrap"></div>
	<div class="asideWrap" id="userBox">
    	<p><a href="#">12LEEYURA</a></p>
        <ul>
        	<li id="myPf"><a href="#" class="indent">MyPortfolio</a></li>
            <li id="likePf"><a href="#" class="indent">Like</a></li>
            <li id="follow"><a href="#" class="indent">Follow</a></li>
            <li id="message"><a href="#" class="indent">Message</a></li>
        </ul>
    </div><!--//userBox-->
    <div id="uploadWrap">
    	<a id="uploadPf" onclick="location='addProjectForm'; return false;" href="#">UPLOAD PORTFOLIO</a>
    </div><!--//uploadWrap-->
    <div class="asideWrap" id="categoryTitle">
    	<p>CATEGORY</p>
    </div><!--//categoryTitle-->
    
    <div id="categoryWrap">
        <ul id="nav_category">
    		<li class="nav_group">
    			<div class="nav_title" id="ct_game"><span></span>GAME</div>
            	<ul class="nav_sub">
            		<li><a href="#">기획</a>
                    <li><a href="#">개발</a>
                    <!-- <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">태그이름</a> -->
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_webApp"><span></span>WEB &amp; APP</div>
            	<ul class="nav_sub">
            		<li><a href="#">기획</a>
            		<li><a href="#">개발</a>
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_video"><span></span>VIDEO</div>
            	<ul class="nav_sub">
            		<li><a href="#">시나리오</a>
                    <li><a href="#">연출</a>
                    <li><a href="#">촬영</a>
                    <li><a href="#">OAP</a>
                    <!-- <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a> -->
                </ul>
            </li>

            <li class="nav_group">
    			<div class="nav_title" id="ct_3d"><span></span>3D</div>
            	<ul class="nav_sub">
            		<li><a href="#">모델링</a>
                    <li><a href="#">애니메이션</a>
                </ul>
            </li>  
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_design"><span></span>DESIGN</div>
            	<!-- <ul class="nav_sub">
            		<li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                </ul> -->
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_sound"><span></span>SOUND</div>
            	<!-- <ul class="nav_sub">
            		<li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                </ul> -->
            </li>
            

    	</ul><!--//nav_category-->
	</div><!--//categoryWrap-->
</div><!--//aside-->
</body>
</html>