<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="js/aside.js"></script>
<div id="aside">
    <div id="logoWrap">
		<a href="main"><img src="resources/images/mediolio.png"></a>
    </div>
	<div class="asideWrap" id="userBox">
		<c:choose> 
			<c:when test="${sessionScope.mev == null }">
				<div id="user_idWrap"><a onclick="loginModalOpen()" href="#" id="user_id">로그인 하세요.</a></div>
			</c:when>
			<c:otherwise>
				<div id="user_idWrap"><a href="userpage?usr_id=${sessionScope.mev.m_id }" class="user_id">${sessionScope.mev.m_studentID} ${sessionScope.mev.m_nickname}</a></div>
        			<ul>
        				<li id="myPf"><a class="indent" >MyPortfolio</a></li>
            			<li id="likePf"><a class="indent">Like</a></li>
            			<li id="follow"><a class="indent">Follow</a></li>
            			<li id="message"><a class="indent">Message</a></li>
        			</ul>
			</c:otherwise>
		</c:choose>
<!--     	<div id="user_idWrap"><a href="#" id="user_id">12LEEYURA</a></div>
        <ul>
        	<li id="myPf"><a href="#" class="indent">MyPortfolio</a></li>
            <li id="likePf"><a href="#" class="indent">Like</a></li>
            <li id="follow"><a href="#" class="indent">Follow</a></li>
            <li id="message"><a href="#" class="indent">Message</a></li>
        </ul> -->
    </div><!--//userBox-->
    <c:choose> 
			<c:when test="${sessionScope.mev == null }">
				
			</c:when>
			<c:otherwise>
				<div id="uploadWrap">
    				<a id="uploadPf" onclick="location='addProjectForm'; return false;" href="#">UPLOAD PORTFOLIO</a>
    			</div><!--//uploadWrap-->
			</c:otherwise>
		</c:choose>
<!--     <div id="uploadWrap">
    	<a id="uploadPf" onclick="location='addProjectForm'; return false;" href="#">UPLOAD PORTFOLIO</a>
    </div>//uploadWrap -->
    <div class="asideWrap" id="categoryTitle">
    	<p>CATEGORY</p>
    </div><!--//categoryTitle-->
    
    <div id="categoryWrap">
        <ul id="nav_category">
    		<li class="nav_group">
    			<div class="nav_title" id="ct_game"><span></span>GAME</div>
            	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>기획</a>
                    <li><a href="#" class='selsub'>개발</a>
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
            		<li><a href="#" class='selsub'>기획</a>
            		<li><a href="#" class='selsub'>개발</a>
                </ul>
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_video"><span></span>VIDEO</div>
            	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>시나리오</a>
                    <li><a href="#" class='selsub'>연출</a>
                    <li><a href="#" class='selsub'>촬영</a>
                    <li><a href="#" class='selsub'>OAP</a>
                    <!-- <li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                    <li><a href="#">tag</a> -->
                </ul>
            </li>

            <li class="nav_group">
    			<div class="nav_title" id="ct_3d"><span></span>3D</div>
            	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>모델링</a>
                    <li><a href="#" class='selsub'>애니메이션</a>
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
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_graphics"><span></span>COMPUTER GRAPHICS</div>
            	<!-- <ul class="nav_sub">
            		<li><a href="#">tag</a>
                    <li><a href="#">tag</a>
                </ul> -->
            </li>
            

    	</ul><!--//nav_category-->
	</div><!--//categoryWrap-->
	<input type='hidden' id='selectcat' >
</div><!--//aside-->
