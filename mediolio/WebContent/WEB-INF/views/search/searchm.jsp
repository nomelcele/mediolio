<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="resources/css/search.css" rel="stylesheet" type="text/css"/>
<script src="js/projectView.js"></script>

<div id="contentsWrap">
    <div class="cardWrap searchResultWrap">
        <p class="searchResult">
        	<span class="searchType">${type }</span>  검색 > ${category } > "
        	<c:if test="${key ne '' }"><strong class="searchKey">${key }</strong></c:if>
        	<c:if test="${skillName ne '' && skillName ne null }"><strong> ${skillName }</strong></c:if>
        	"  ( 결과 ${total }건 )
        </p>
    </div>
    
     <c:forEach var="prj" items="${list}">
     
	    <div class="cardWrap searchWrap searchTeamWrap">
	        <div class="search_teamWrap clear">
	            <div class="search_teamWrapLeft">
	                <p class="search_person">
	                    <a class="btn_userPop" onclick="userPop(event, this, '${prj.m_id}'); return false;" href="#">${prj.m_studentID } ${prj.m_name }</a>
	                </p>
	                <p class="search_personInfo">
	                    <span>관심분야</span>
	                    <span class="personInfo_cont ellipsis">${prj.m_interestingText1 } ${prj.m_interestingText2 }</span>
	                </p>
	                <p class="search_personInfo clear">
	                    <span>보유기술</span>
	                    <span class="personInfo_cont">${prj.skills }</span>
	                </p>
	            </div>
	            <div class="search_teamWrapRight">
	                <c:set var="projects" value="${prj.projects }"/>
                    <c:set var="projectArr" value="${fn:split(projects, '/') }"/>
					<c:forEach var="id_img_set" items="${projectArr }">
						<c:set var="id_img_arr" value="${fn:split(id_img_set, ',') }"/>
	                    <c:choose>
							<c:when test="${fn:length(id_img_arr) eq 1}">
								<a href="projectView?p_id=${id_img_arr[0] }&m_id=${prj.m_id }"><img src="resources/images/default.png" width="80" height="80"/></a>
	                        </c:when>
		                    <c:otherwise>
								<a href="projectView?p_id=${id_img_arr[0] }&m_id=${prj.m_id }"><img src="resources/images/projectCover/${id_img_arr[1] }" width="80" height="80"/></a>	                        			
		                    </c:otherwise>
						</c:choose>
					</c:forEach>
	            </div>
	        </div><!--//search_teamWrap-->
	    </div><!--//searchTeamWrap-->
    
    </c:forEach>
    
    <ul class="userPopWrap">
	    <li><a href="#" class="userPop_userPage">유저페이지</a></li>
	    <li><a href="#" class="msg">쪽지 보내기</a></li>
	    <li><a href="gotoMyPage">유저 히스토리</a></li>
	</ul>
    
    
</div><!--//contentsWrap-->