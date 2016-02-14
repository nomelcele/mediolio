<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="js/projectDetail.js"></script> 

<div class="modal" id="modal_content">
	<div class="modal_hd" id="modal_hd_content">
        <p id="content_categoryWrap">
            <span class="cate_parent">${detail.cate_name }</span>
            <span> > </span>
            <span class="cate_child">
                <c:forEach var="aItem" items="${subcategory }" varStatus="status">
    				${aItem.sc_name }<c:if test="${not status.last}">, </c:if>
    			</c:forEach>
            </span>
        </p>
        <h2>${detail.p_title }</h2>
        <h3 id="content_userId">
        	<input type="hidden" name="m_id" id="writer_m_id" value="${detail.m_id }"> <!-- !!!!!!!!!!!!  작성자 ID input hidden   !!!!!!!!!! -->
        	<a href="#">${detail.m_studentID } ${detail.m_nickname }</a>
        </h3>
        <h3 id="content_date">${detail.p_date }</h3>
        <h3 id="content_hits"><span>${detail.p_viewnum }</span> views</h3>
        
        <a href="#" id="contentHeart">
        	<c:choose>
        		<c:when test="${detail.like_or_not > 0 }">
        			<img src="resources/images/heartAfter.png" class="likeProject" alt="LikeIt"/>
        		</c:when>
        		<c:otherwise>
        			<img src="resources/images/heartBefore.png" class="dontlikeProject" alt="LikeIt"/>
        		</c:otherwise>
        	</c:choose>
        </a>
        <span id="heartNum">${detail.p_likenum }</span>
    </div> 
    <div class="modal_bd" id="modal_bd_content">
    	<div id="content_imgWrap"></div>
        <div id="content_tagWrap">
            <p>연관 태그</p>
            <c:forEach var="aTag" items="${tag }">
	            <span>#${aTag.h_value }</span>
            </c:forEach>
        </div>
    </div><!--//modal_bd_content -->
    <hr>
    <div class="modal_ft" id="modal_ft_content">
    	<div class="replyContentsTotalWrap">
        <!-- 댓글내용란 -->
        <c:forEach var="aReply" items="${reply }">
	        <div class="replyContentWrap">
	            <p>
	                <a href="#">${aReply.m_studentID } ${aReply.m_nickname }</a>
	                <c:choose>
			     		<c:when test="${sessionScope.mev.m_id == aReply.m_id }">
			     			<!-- 로그인한 사람과 댓글단 사람이 같을 경우 삭제버튼 등장 -->
			     			<a class="btn_deleteReply">X<input type="hidden" value="${aReply.r_id }"></a>
			     		</c:when>
			     	</c:choose>
	                <span>${aReply.r_date }</span>
	            </p>
	            <div class="replyContent">
	             	${aReply.r_text }  
	             </div>
	        </div><!--//replyContentWrap-->
		</c:forEach>
       	</div>
       <!-- 댓글입력란 -->
       <c:choose>
        	<c:when test="${sessionScope.mev != null }">
        	     <div id="writeReplyWrap">
		        	<form id="reply_form">
		        		<input type="hidden" name="p_id" value="${detail.p_id }">
		        	    <textarea placeholder="댓글 내용을 입력하세요." name="r_text"></textarea>
		            	<input type="button" value="입력" onclick="submitReply()"/>
		        	</form>
		        </div>
        	</c:when>
        </c:choose>
    </div>
</div><!--//modal_content-->
    

<div class="modal" id="modal_content_userInfo">
	<div class="modal_hd" id="modal_hd_content_userInfo">
        <a href="#">${detail.m_studentID } ${detail.m_nickname }</a>
    </div> 
    <div id="modal_bd_content_userFavorite">
    	<c:forEach var="aItem" items="${interesting }" varStatus="status">
    		${aItem.cate_name } ${aItem.sc_name }<c:if test="${not status.last}">, </c:if>
    	</c:forEach>
    </div>
    <div class="modal_bd" id="modal_bd_content_userInfo">
    	${detail.m_introduce }	
    </div><!--//modal_bd_content -->
    
    <div class="modal_ft" id="modal_ft_content_userInfo">
        <ul>
            <li>
            <c:choose>
				<c:when test="${detail.follow_or_not == 0}">
			    	<a href="#">FOLLOW</a>
			    </c:when>
			    <c:otherwise>
			    	<a href="#">UNFOLLOW</a>
			    </c:otherwise>
			</c:choose>
            </li>
            <li><a href="#">MESSAGE</a></li>
        </ul>
        
    </div>
</div><!--//modal_content_userInfo-->