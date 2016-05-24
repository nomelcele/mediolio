<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
	<div id="contentsWrap">
    <c:forEach var="mainProjects" items="${mainProjects}">
	    <div class="cardWrap">
	    <input type="hidden" class="projectId" value="${mainProjects.p_id}">
	    <input type="hidden" class="memberId" value="${mainProjects.m_id}">
	    	<div class="card_hd"></div>
	    	<div class="card_img">
	            <a href="projectView?m_id=${mainProjects.m_id}&p_id=${mainProjects.p_id}">
	                <div>
	                	<p>
	                		<c:forTokens var="aTag" items="${mainProjects.hashtags }" delims=",">
								<span>#${aTag }</span><br>
							</c:forTokens>
	                    </p>
	                </div>
	                <c:if test="${mainProjects.p_coverImg ne '' && mainProjects.p_coverImg ne null}">
	                	<img src="resources/images/projectCover/${mainProjects.p_coverImg}"/>
	                </c:if>
	                <c:if test="${mainProjects.p_coverImg eq '' || mainProjects.p_coverImg eq null}">
		                <img src="resources/images/default.png"/>
	                </c:if>
	            </a>
	        </div><!--//card_img-->
	    	<div class="card_bd">
	        	<p class="card_title ellipsis"><a href="projectView?m_id=${mainProjects.m_id}&p_id=${mainProjects.p_id}">${mainProjects.p_title}</a></p>
	            <p class="card_dscrpt"><a href="userpage?usr_id=${mainProjects.m_id }">${mainProjects.authorID} ${mainProjects.authorName}</a></p>
	            <p class="card_tag">
					${mainProjects.p_summary }		
	            </p>
	        </div><!--//card_bd-->
	        <div class="card_ct">
	        	<p class="p_like"><span></span>${mainProjects.p_likenum}</p>
	            <p class="p_view"><span></span>${mainProjects.p_viewnum}</p>
	        </div><!--//card_ct-->
	    </div><!--//cardWrap-->

    </c:forEach>
  

</div>