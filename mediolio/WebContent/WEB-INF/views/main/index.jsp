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
	            <a href="#" onClick="contentModalOpen(this, 'index'); return false;">
	                <div>
	                	<p>
	                	<c:forEach var="hashtag" items="${hashtag}">
	                		<c:if test="${mainProjects.p_id eq hashtag.p_id && hashtag.h_value ne ''}">
	                    <!-- <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p> -->
	                    		#${hashtag.h_value}<br>
	                    	</c:if>
	                    </c:forEach>
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
	        	<p class="card_title ellipsis"><a href="#">${mainProjects.p_title}</a></p>
	            <p class="card_dscrpt"><a href="userpage?usr_id=${mainProjects.m_id }" class="user_id">${mainProjects.authorID} ${mainProjects.authorName}</a></p>
	            <p class="card_tag">
	            	<!-- 게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드, -->
	            	<c:forEach items="${fn:split(mainProjects.sc_id,'/')}" var="sc">
	            		<c:forEach var="subcategory" items="${subcategory}">
	            			<c:if test="${sc eq subcategory.sc_id}">
	            				<c:forEach var="category" items="${category}">
	            					<c:if test="${category.cate_id eq subcategory.sc_parent}">
	            						<%-- ${category.cate_name} ${subcategory.sc_name} --%>
	            						<%-- <c:if test="${subcategory.sc_id eq '11'||subcategory.sc_id eq '12'||subcategory.sc_id eq '13'}">
	            							${subcategory.sc_name}
	            						<c:if test="${subcategory.sc_id eq '11'||subcategory.sc_id eq '12'||subcategory.sc_id eq '13'}"> --%>
	            						<c:choose> 
											<c:when test="${subcategory.sc_id eq '11'||subcategory.sc_id eq '12'||subcategory.sc_id eq '13'}">
												${subcategory.sc_name},
											</c:when>
											<c:otherwise>
												${category.cate_name} ${subcategory.sc_name},
											</c:otherwise>
										</c:choose>
	            					</c:if>
	            				</c:forEach>
	            			</c:if>
	            		</c:forEach>
	            	</c:forEach>
	            </p>
	        </div><!--//card_bd-->
	        <div class="card_ct">
	        	<p class="p_like"><span></span>${mainProjects.p_likenum}</p>
	            <p class="p_view"><span></span>${mainProjects.p_viewnum}</p>
	        </div><!--//card_ct-->
	    </div><!--//cardWrap-->
    </c:forEach>
  
<!--     <div class="cardWrap"> -->
<!--     	<div class="card_hd"></div> -->
<!--     	<div class="card_img"> -->
<!--             <a href="#" onClick="contentModalOpen()"> -->
<!--                 <div> -->
<!--                     <p>태그내용<br>태그내용태그내용태그내용태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br>태그내용<br></p> -->
<!--                 </div> -->
<!--                 <img src="resources/images/default.png"/> -->
<!--             </a> -->
<!--         </div>//card_img -->
<!--     	<div class="card_bd"> -->
<!--         	<p class="card_title ellipsis"><a href="#">글제목입니다.글제목입니다.글제목입니다.</a></p> -->
<!--             <p class="card_dscrpt"><a href="#">12이유라</a></p> -->
<!--             <p class="card_tag">게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,게임프로그래밍,게임사운드,</p> -->
<!--         </div>//card_bd -->
<!--         <div class="card_ct"> -->
<!--         	<p class="p_like"><span></span>12</p> -->
<!--             <p class="p_view"><span></span>12</p> -->
<!--         </div>//card_ct -->
<!--     </div>//cardWrap -->
    
</div>
<!-- <div class="modal" id="modal_content">
	<div class="modal_hd" id="modal_hd_content">
        <p id="content_categoryWrap">
            <span class="cate_parent">GAME</span>
            <span> > </span>
            <span class="cate_child">게임프로그래밍</span>
        </p>
        <h2>글제목입니다.글제목입니다.</h2>
        <h3 id="content_userId"><a href="#">12LEEYURA</a></h3>
        <h3 id="content_date">2016.02.10</h3>
        <h3 id="content_hits"><span>0</span> views</h3>
        
        <a href="#" id="contentHeart">
            <img src="resources/images/heartBefore.png" alt="LikeIt"/>
        </a>
        <span id="heartNum">10</span>
    </div> 
    <div class="modal_bd" id="modal_bd_content">
    	<div id="content_imgWrap"></div>
        <div id="content_tagWrap">
            <p>연관 태그</p>
            <span>#겜프</span>
            <span>#게임디자인</span>
            
        </div>
    </div>//modal_bd_content
    <hr>
    <div class="modal_ft" id="modal_ft_content">
        
        <div class="replyContentWrap">
            <p>
                <a href="#">12LEEYURA</a>
                <a href="#" id="btn_deleteReply">X</a>
                <span>2016-02-12 12:00:00</span>
            </p>
            <div class="replyContent">
                안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 안녕하세요. 댓글입니다. 
            </div>
        </div>//replyContentWrap
        
        <div class="replyContentWrap">
            <p>
                <a href="#">12USER</a>
                <span>2016-02-12 12:00:00</span>
            </p>
            <div class="replyContent">
                안녕하세요. 댓글입니다.  
            </div>
        </div>//replyContentWrap
       
        <div id="writeReplyWrap">
            <textarea placeholder="댓글 내용을 입력하세요."></textarea>
            <input type="button" value="입력"/>
        </div>
        
        
    </div>
</div>//modal_content
    
    
    
    
<div class="modal" id="modal_content_userInfo">
	<div class="modal_hd" id="modal_hd_content_userInfo">
        <a href="#">12LEEYURA</a>
    </div> 
    <div id="modal_bd_content_userFavorite">게임프로그래밍</div>
    <div class="modal_bd" id="modal_bd_content_userInfo">
    	안녕하세요. 자기소개입니다. 안녕하세요. 자기소개입니다. 안녕하세요. 자기소개입니다. 안녕하세요. 자기소개입니다. 안녕하세요. 자기소개입니다. 안녕하세요. 자기소개입니다. 안녕하세요. 자기소개입니다. 안녕하세요. 자기소개입니다. 
    </div>//modal_bd_content
    
    <div class="modal_ft" id="modal_ft_content_userInfo">
        <ul>
            <li><a href="#">FOLLOW</a></li>
            <li><a href="#">MESSAGE</a></li>
        </ul>
        
    </div>
</div>//modal_content_userInfo -->
