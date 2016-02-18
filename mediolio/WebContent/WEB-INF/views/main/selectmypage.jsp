<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
	<div id="contentsWrap">
    <c:forEach var="mainProjects" items="${mainProjects}">
    	<c:if test="${mainProjects.m_id eq sessionScope.mev.m_id}">
	    <div class="cardWrap">
	    <input type="hidden" class="projectId" value="${mainProjects.p_id}">
	    <input type="hidden" class="memberId" value="${mainProjects.m_id}">
	    	<div class="card_hd"></div>
	    	<div class="card_img">
	            <a href="#" onClick="contentModalOpen(this, 'index')">
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
	            <p class="card_dscrpt"><a href="#">${mainProjects.authorID} ${mainProjects.authorName}</a></p>
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
	    </c:if>
    </c:forEach>
  

</div>