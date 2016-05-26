<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="resources/css/userPage.css" rel="stylesheet" type="text/css"/>    
<script src="js/userPage.js"></script>

<div id="contentsWrap">
<div class="cardWrap" id="userInfoWrap">
	<div id="userInfoWrap_hd">
        <span>${memberInfo.m_studentID } ${memberInfo.m_name }</span>
        <input type="hidden" value="${memberInfo.m_id }" class="memberId"/>
        <div id="btnWrap_userInfo">
        	<c:if test="${sessionScope.mev != null && sessionScope.mev.m_id != memberInfo.m_id}">
        	    <a class="btn_userInfo" id="btn_addFriend" href="#" data-click-state="0"></a>
            	<a class="btn_userInfo" id="btn_userNote" href="#" onclick="noteModalOpen('${memberInfo.m_id }', '${memberInfo.m_studentID } ${memberInfo.m_name }')"></a>
        	</c:if>
        </div>
    </div> 
    <div id="userInfoWrap_bd">
        <div class="box_userInfo" id="userIntro">
            <div class="title_userInfo">자기 소개</div>
            <div class="content_userInfo">
            <c:choose>
            	<c:when test="${memberInfo.m_introduce eq '' || memberInfo.m_introduce eq null }">
            	  <!-- 자기소개 없을때 -->
            	  	안녕하세요. ${memberInfo.m_name } 입니다.
            	</c:when>
            	<c:otherwise>
            		${memberInfo.m_introduce }
            	</c:otherwise>
            </c:choose>
            </div>
        </div><!--//modal_bd_content -->
        <div class="box_userInfo" id="userFavorite">
            <div class="title_userInfo">관심 분야</div>
            <div class="content_userInfo">
            	<c:if test="${fn:length(memberInfo.m_interestingText1) ne 0}">
                	${memberInfo.m_interestingText1 }
                    <c:if test="${fn:length(memberInfo.m_interestingText2) ne 0}">
                        , ${memberInfo.m_interestingText2 }
                	</c:if>
            	</c:if>
			</div>
        </div>
        <div class="box_userInfo" id="userSkill">
            <div class="title_userInfo">보유 기술</div>
            <div class="content_userInfo">
				${memberInfo.skills }
			</div>
        </div>
        <div class="box_userInfo gallery" id="userProject">
            <a class="gallery_arrows gallery_left"  href="#"></a>
            <a class="gallery_arrows gallery_right" id="gallery_right" href="#"></a>
            <div class="title_userInfo">작업 목록</div>
            <div class="content_userInfo">
                <ul>
                	<c:choose>
                		<c:when test="${empty myProjects}">
                			<li>등록한 글이 없습니다.</li>
                		</c:when>
                		<c:otherwise>
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
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
        </div><!--//userProject-->
        
        <div class="box_userInfo gallery" id="userLike">
            <a class="gallery_arrows gallery_left"  href="#"></a>
            <a class="gallery_arrows gallery_right" id="gallery_right" href="#"></a>
            <div class="title_userInfo">좋아요</div>
            <div class="content_userInfo">
                <ul>
					<c:choose>
                		<c:when test="${empty likeProjects }">
                			<li>좋아하는 게시물이 없습니다.</li>
                		</c:when>
                		<c:otherwise>
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
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
        </div><!--//userLike-->
    </div>
    
</div><!--//modal_content_userInfo-->
</div>