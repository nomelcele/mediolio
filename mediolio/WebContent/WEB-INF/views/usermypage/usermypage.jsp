<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="resources/css/userPage.css" rel="stylesheet" type="text/css"/>    
<script src="js/userPage.js"></script>

<div id="contentsWrap">
<div class="cardWrap" id="userInfoWrap">
	<div id="userInfoWrap_hd">
        <span>${memberInfo.m_name }</span>
        <input type="hidden" value="${memberInfo.m_id }" class="memberId"/>
        <div id="btnWrap_userInfo">
        	<c:if test="${sessionScope.mev != null && sessionScope.mev.m_id != memberInfo.m_id}">
        	    <a class="btn_userInfo" id="btn_addFriend" href="#" data-click-state="0"></a>
            	<a class="btn_userInfo" id="btn_userNote" href="#" onclick="noteModalOpen('certain', '${memberInfo.m_id }', '${memberInfo.m_name }')"></a>
        	</c:if>
        </div>
    </div> 
    <div id="userInfoWrap_bd">
        <div class="box_userInfo" id="userIntro">
            <div class="title_userInfo">INTRODUCE</div>
            <div class="content_userInfo">
				${memberInfo.m_introduce }
            </div>
        </div><!--//modal_bd_content -->
        <div class="box_userInfo" id="userFavorite">
            <div class="title_userInfo">FAVORITE</div>
            <div class="content_userInfo">
            	<c:if test="${fn:length(memberInfo.m_interestingText1) ne 0}">
                	${memberInfo.m_interestingText1 }
                    <c:if test="${fn:length(memberInfo.m_interestingText2) ne 0}">
                        , ${memberInfo.m_interestingText2 }
                	</c:if>
            	</c:if>
			</div>
        </div>
        <div class="box_userInfo gallery" id="userProject">
            <a class="gallery_arrows gallery_left"  href="#"></a>
            <a class="gallery_arrows gallery_right" id="gallery_right" href="#"></a>
            <div class="title_userInfo">PROJECT</div>
            <div class="content_userInfo">
                <ul>
					<c:forEach var="a" items="${myProjects }">
                    <li>
                    	<c:choose>
                        	<c:when test="${a.p_coverImg eq ''}">
                        		<a href="projectView?m_id=${memberInfo.m_id}&p_id=${a.project_id }"><img src="resources/images/default.png" width="70" height="70"/></a>         	
                        	</c:when>
	                        <c:otherwise>
								<a href="projectView?m_id=${memberInfo.m_id}&p_id=${a.project_id }"><img src="resources/images/projectCover/${a.p_coverImg }" width="70" height="70"/></a>
							</c:otherwise>
                        </c:choose>
                        <p class="userProject_category"><span>${a.cate_name }</span></p>
                        <p class="userProject_title">${a.p_title }</p>
                        <c:if test="${a.hashtags ne null }">
                           	<c:set var="tagArr" value="${fn:split(a.hashtags, ',') }"/>
                           	<p class="userProject_tag">
                           		<c:forEach var="tag" items="${tagArr }">
                           			#${tag } 
                           		</c:forEach>
                        	</p>
                        </c:if>
                    </li>					
					</c:forEach>
                </ul>
            </div>
        </div><!--//userProject-->
        
        <div class="box_userInfo gallery" id="userLike">
            <a class="gallery_arrows gallery_left"  href="#"></a>
            <a class="gallery_arrows gallery_right" id="gallery_right" href="#"></a>
            <div class="title_userInfo">LIKE</div>
            <div class="content_userInfo">
                <ul>
					<c:forEach var="a" items="${likeProjects }">
						<li>
							<c:choose>
	                        	<c:when test="${a.p_coverImg eq ''}">
	                        		<a href="projectView?m_id=${a.m_id}&p_id=${a.project_id }"><img src="resources/images/default.png" width="70" height="70"/></a>         	
	                        	</c:when>
		                        <c:otherwise>
									<a href="projectView?m_id=${a.m_id}&p_id=${a.project_id }"><img src="resources/images/projectCover/${a.p_coverImg }" width="70" height="70"/></a>
								</c:otherwise>
	                        </c:choose>
	                        <p class="userProject_category"><span>${a.cate_name }</span></p>
	                        <p class="userProject_title">${a.p_title }</p>
		                    <c:if test="${a.hashtags ne null }">
	                           	<c:set var="tagArr" value="${fn:split(a.hashtags, ',') }"/>
	                           	<p class="userProject_tag">
	                           		<c:forEach var="tag" items="${tagArr }">
	                           			#${tag } 
	                           		</c:forEach>
	                        	</p>
	                        </c:if>
	                    </li>
					</c:forEach>
                </ul>
            </div>
        </div><!--//userLike-->
    </div>
    
</div><!--//modal_content_userInfo-->
</div>