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
				<div id="user_idWrap"><a onclick="loginModalOpen()" href="#" id="user_id">로그인 하세요</a></div>
				    <ul>
        				<li id="unlog_myPf"><a class="indent">MyPortfolio</a></li>
            			<li id="unlog_likePf"><a class="indent">Like</a></li>
            			<li id="unlog_follow"><a class="indent">Follow</a></li>
            			<li id="unlog_message"><a class="indent">Message</a></li>
        			</ul>				
			</c:when>
			<c:otherwise>
				<div id="user_idWrap"><a href="userpage?usr_id=${sessionScope.mev.m_id }" class="user_id">${sessionScope.mev.m_studentID} ${sessionScope.mev.m_name}</a></div>
        			<ul>
        				<li id="myPf" class="logon"><a class="indent"  href="gotoMyPage">MyPortfolio</a></li>
            			<li id="likePf" class="logon"><a class="indent">Like</a></li>
            			<li id="follow" class="logon"><a class="indent">Follow</a></li>
            			<li id="message" class="logon"><a class="indent">Message</a></li>
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
    				<a id="uploadPf" onclick="location='addProjectForm'; return false;" href="#">게시글 작성하기</a>
    			</div><!--//uploadWrap-->
			</c:otherwise>
		</c:choose>
<!--     <div id="uploadWrap">
    	<a id="uploadPf" onclick="location='addProjectForm'; return false;" href="#">UPLOAD PORTFOLIO</a>
    </div>//uploadWrap -->
    <div class="asideWrap categoryTitle">
    	<p>프로젝트</p>
    </div><!--//categoryTitle-->
    <div class="categoryWrap">
        <ul class="nav_category">
    		<li class="nav_group">
    			<div class="nav_title" id="ct_game"><span></span>PROJECT</div>
<!--             	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>기획</a>
                    <li><a href="#" class='selsub'>개발</a>
                </ul> -->
            </li>
   		</ul>
    </div>
    
    
    <div class="asideWrap categoryTitle">
    	<p>과제</p>
    </div><!--//categoryTitle-->
    
    <div class="categoryWrap" id="categoryWrap2">
        <ul class="nav_category">
    		<li class="nav_group">
    			<div class="nav_title" id="ct_game"><span></span>GAME</div>
<!--             	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>기획</a>
                    <li><a href="#" class='selsub'>개발</a>
                </ul> -->
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_webApp"><span></span>WEB &amp; APP</div>
<!--             	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>기획</a>
            		<li><a href="#" class='selsub'>개발</a>
                </ul> -->
            </li>
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_video"><span></span>VIDEO  &amp;  SOUND</div>
<!--             	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>시나리오</a>
                    <li><a href="#" class='selsub'>연출</a>
                    <li><a href="#" class='selsub'>촬영</a>
                    <li><a href="#" class='selsub'>OAP</a>
                    <li><a href="#" class='selsub'>SOUND</a>
                </ul> -->
            </li>

            <li class="nav_group">
    			<div class="nav_title" id="ct_3d"><span></span>3D</div>
<!--             	<ul class="nav_sub">
            		<li><a href="#" class='selsub'>모델링</a>
                    <li><a href="#" class='selsub'>애니메이션</a>
                </ul> -->
            </li>  
            
            <li class="nav_group">
    			<div class="nav_title" id="ct_design"><span></span>DESIGN</div>
            </li>

            
            <li class="nav_group">
    			<div class="nav_title" id="ct_misc"><span></span>MISC</div>
            </li>
            

    	</ul><!--//nav_category-->
	</div><!--//categoryWrap-->
	<input type='hidden' id='selectcat' >
</div><!--//aside-->
