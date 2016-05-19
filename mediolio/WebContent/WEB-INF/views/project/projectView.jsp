<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="resources/css/projectView.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/projectView.js"></script>
<script type="text/javascript" src="js/memberAction.js"></script>

<div id="contentsWrap">
	<div class="cardWrap clear" id="modal_content">
        <div class="projectViewBox clear" id="projectViewBox_left">
            <div class="modal_hd" id="modal_hd_content">
                <p id="content_categoryWrap">
                    <span>
                    	<c:choose>
                    		<c:when test="${detail.p_type eq '0' }">
                    			과제
                    		</c:when>
                    		<c:otherwise>
                    			프로젝트
                    		</c:otherwise>
                    	</c:choose>
                    </span>
                    <span> > </span>
                    <span>${detail.cate_name }</span>
                </p>
                <h2>${detail.p_title }</h2>
                <h3 id="content_userId"><a href="#">${writer.m_studentID } ${writer.m_name }</a></h3>
                <h3 id="content_date">${detail.p_date }</h3>
                <h3 id="content_hits"><span>${detail.p_viewnum }</span> views</h3>

		        <c:choose>
		        <c:when test="${sessionScope.mev == null }">
		        	<a id="contentHeart">
		        		<img src="resources/images/heartAfter.png" alt="LikeIt"/>
		        	</a>
		        </c:when>
		        <c:when test="${writer.like_or_not > 0 }">
		        	<a id="contentHeart" class="cancelLikeProject">
		        		<img src="resources/images/heartAfter.png" alt="LikeIt"/>
		        	</a>
		        </c:when>
		        <c:otherwise>
		        	<a id="contentHeart" class="likeProject">
		        		<img src="resources/images/heartBefore.png" alt="LikeIt"/>
		        	</a>
		        </c:otherwise>
		        </c:choose>
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
		        <!-- 댓글내용란 -->
		        <div class="replyContentsTotalWrap">
		        <c:forEach var="aReply" items="${reply }">
			        <div class="replyContentWrap">
			            <p>
			                <a href="#">${aReply.m_studentID } ${aReply.m_name }</a>
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
					        	    <textarea placeholder="댓글 내용을 입력하세요." name="r_text" onkeypress="if(event.keyCode==13) submitReply();"></textarea>
					            	<input type="button" value="입력" onclick="submitReply()"/>
					        	</form>
					        </div>
			    	</c:when>
				</c:choose>			
			</div>
        </div><!--projectViewBox_left-->
		
		<div class="projectViewBox clear" id="projectViewBox_right">
		    <div class="writerWrap">
		        <h1><a onclick="userPop(event)" class="btn_userPop" href="#">${writer.m_studentID } ${writer.m_name }</a></h1>
		        <h2>${writer.m_introduce }</h2>
		        <div class="lineWrap clear">
                    <span>관심 분야</span>
                    <h3>${writer.m_interesting1_text }, ${writer.m_interesting2_text }</h3>
                </div>
                <div class="lineWrap clear">
                    <span>보유 기술</span>
                    <h3>JAVA, JAVASCRIPT, Photoshop, Illustrator</h3>
                </div>
                <h4>관련 히스토리</h4>
                <h5><a href="#">JUICY 반응형 웹사이트</a></h5>
		    </div>
		    
		    <div class="projectWrap">
		        <h1>작업 정보</h1>
		        <div class="lineWrap clear">
                    <span>작업 이름</span>
                    <h3>${detail.p_prjname }</h3>
                </div>
                <div class="lineWrap clear">
                    <span>작업 기간</span>
                    <h3>${detail.p_workfrom} ~ ${detail.p_workto}</h3>
                </div>
                <div class="lineWrap clear">
                    <span>관련 과목</span>
                    <h3>${detail.cl_name }</h3>
                </div>
                
                <hr>
                
                <h1>팀원 정보</h1>
                <div class="projectTeamWrap clear">
                    <h2><a onclick="userPop(event)" class="btn_userPop" href="#">12이유라</a></h2>
                    <h3>디자인</h3>
                    <h4>UI기획 및 디자인, 웹표준 마크업, CSSddddddd</h4>
                </div>
                <div class="projectTeamWrap clear">
                    <h2><a onclick="userPop(event)" class="btn_userPop" href="#">12이유라</a></h2>
                    <h3>디자인</h3>
                    <h4>UI기획 및 디자인, 퍼블리싱</h4>
                </div>
                <div class="projectTeamWrap clear">
                    <h2><a onclick="userPop(event)" class="btn_userPop" href="#">12이유라</a></h2>
                    <h3>디자인</h3>
                    <h4>UI기획 및 디자인, 퍼블리싱</h4>
                </div>
		    </div>
		</div><!--//projectViewBox_right-->
		
	</div><!--//modal_content-->
	<ul class="userPopWrap">
	    <li><a href="#">유저페이지</a></li>
	    <li><a href="#">쪽지 보내기</a></li>
	    <li><a href="#">유저 히스토리</a></li>
	</ul><!-- userPopWrap -->
	
	<input type="hidden" id="other_m_id" value="${writer.m_id }"> <!-- !!!!!!!!!!!!  작성자 ID input hidden   !!!!!!!!!! -->
	<input type="hidden" id="this_p_id" value="${detail.p_id }"><!-- !!!!!!!!!!!!  현재 프로젝트 ID input hidden   !!!!!!!!!! -->
</div>