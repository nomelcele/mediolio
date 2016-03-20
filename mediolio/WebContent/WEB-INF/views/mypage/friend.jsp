<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="resources/css/friend.css" rel="stylesheet" type="text/css"/>    
<script src="js/friend.js"></script>
<!--<div id="navigator"></div>-->
<div id="contentsWrap">
   <div class="rmcnWrap">
            <a class="btn_rmcn" id="btn_rmcnUp" href="#"></a>
            <a class="btn_rmcn" id="btn_rmcnDown" href="#"></a>
    </div><!--//rmcnWrap-->

    <div class="cardWrap friendWrap">
        <div class="friendwrap_content friendwrap_hd">FRIEND LIST</div>
        <ul class="friendwrap_content friendwrap_tab">
            <li><a href="#" class="friendTab" id="friendTab_following">FOLLOWING<span>${cnt.following }</span></a></li>
            <li><a href="#" class="friendTab" id="friendTab_follower">FOLLOWER<span>${cnt.follower }</span></a></li>
        </ul>
        
        <div class="friendwrap_content friendwrap_bd">
            <div class="friendWrap_bd_content" id="friendWrap_bd_following">
                <ul>
                <c:forEach var="a" items="${list }">
                    <li>
                        <p class="friendList_id">
                        	<input type="hidden" value="${a.m_id }" class="memberId"/>
                            <a href="userpage?usr_id=${a.m_id }">${a.m_nickname }</a>
                            <input type="button" value="X" class="btn_cancelFollow"/>
                        </p>
                        <p class="friendList_intro">${a.m_introduce }</p>
                        <p class="friendList_like">관심분야 : 
                        	<span>
                        	<c:if test="${fn:length(a.m_interestingText1) ne 0}">
                        		${a.m_interestingText1 }
                        		<c:if test="${fn:length(a.m_interestingText2) ne 0}">
                        			, ${a.m_interestingText2 }
                        			<c:if test="${fn:length(a.m_interestingText3) ne 0}">
                        				, ${a.m_interestingText3 }
                        			</c:if>
                        		</c:if>
                        	</c:if>
                        	</span>
                        </p>
                        <div class="friendList_project">
                        	<c:set var="projects" value="${a.projects }"/>
                        	<c:set var="projectArr" value="${fn:split(projects, '/') }"/>
                        	<c:forEach var="id_img_set" items="${projectArr }">
                        		<c:set var="id_img_arr" value="${fn:split(id_img_set, ',') }"/>
                        		<c:choose>
                        			<c:when test="${fn:length(id_img_arr) eq 1}">
                        				<a href="#detail?p_id=${id_img_arr[0] }" onclick="contentModalOpen(this, 'friend')"><img src="resources/images/default.png" width="80" height="80"/></a>
                        			</c:when>
	                        		<c:otherwise>
										<a href="#detail?p_id=${id_img_arr[0] }" onclick="contentModalOpen(this, 'friend')"><img src="resources/images/projectCover/${id_img_arr[1] }" width="80" height="80"/></a>	                        			
	                        		</c:otherwise>
                        		</c:choose>
                        	</c:forEach>
                        </div>
                    </li>
				</c:forEach>
                </ul>
            </div><!--//friendWrap_bd_following-->
            
            <div class="friendWrap_bd_content" id="friendWrap_bd_follower">
                <ul>
<!--                     <li>
                        <p class="friendList_id">
                            <a href="#">12USER</a>
                            <input type="button" value="X"/>
                        </p>
                        <p class="friendList_intro">안녕하세요. 자기소개입니다.</p>
                        <p class="friendList_like">관심분야 : <span>게임프로그래밍</span></p>
                        <div class="friendList_project">
                            <a href="#"><img src="http://placehold.it/80x80/eee" width=80 height=80/></a>
                            <a href="#"><img src="http://placehold.it/80x80/ccc" width=80 height=80/></a>
                            <a href="#"><img src="http://placehold.it/80x80/aaa" width=80 height=80/></a>
                        </div>
                    </li> -->

                </ul>
            </div><!--//friendWrap_bd_follower-->
        </div>  
    </div>   
</div>