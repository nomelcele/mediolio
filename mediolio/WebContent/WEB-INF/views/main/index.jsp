<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<link href="resources/css/myPage.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/search.css" rel="stylesheet" type="text/css"/>
<link href="resources/css/index2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="resources/css/jquery.bxslider.css"/>

<script src="js/index2.js"></script>
<script src="js/jQuery/jquery.dotdotdot.min.js"></script>
<script src="js/jQuery/jquery.bxslider.min.js"></script>


<!-- 이유라 : 마크업  -->
<!-- 모하람 : 히스토리 부분 데이터 뿌림 -->
<!-- 오지은 : 회원 관심분야 최신 글 데이터 뿌림 -->

<div id="navigator">
    <p>MAIN</p>
</div>
<div id="contentsWrap">
	<div class="contentS clear">
		<div class="cardWrap cardWrap_main">
		    <div id="historyTitle_main">
		        <span>내 히스토리 - </span>
		        <span class="ellipsis">${recentHtTitle}</span>
		        <input type="button" class="btnStyle3" id="btn_moreHistory" value="바로가기">
		    </div>
		    <div class="historyWrap historyWrap_main clear">
		        
		        <div class="timeLineWrap clear">
		        	<c:if test="${htNum eq 0}">
			        	<div class="timeCardWrap clear">
			        		<div class="cardWrap timeCard">
			        			<div>새로운 히스토리가 없습니다.</div>
			        		</div>
			        	</div>
		        	</c:if>
		        	<c:if test="${htNum eq -1}">
		        		<div class="timeCardWrap clear">
		        			<div class="timeCircle"></div>
			        		<div class="cardWrap timeCard">
			        			<div class="mainTxt">로그인 후 나의 히스토리를 확인하세요.</div>
			        		</div>
			        	</div>
		        	</c:if>
		        	
		        	<c:forEach var="br" items="${recentHtBrs}">
            <div class="timeCardWrap clear">
                <div class="timeCircle"></div>
                <div class="cardWrap timeCard">
                    <div class="timeCard_hd">
                        <h3 class="ellipsis">${br.br_title}</h3>
                        <h4>${br.br_date}</h4>
                    </div>
                    <c:if test="${br.br_img1 ne null || br.br_img2 ne null || br.br_img3 ne null}">
	                    <div class="timeCard_visualWrap slider">
	                        <ul class="bxslider">
	                        	<c:if test="${br.br_img1 ne null}">
		                            <li><a href="#">
		                                <img src="upload/history/${br.br_img1}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                            <c:if test="${br.br_img2 ne null}">
		                            <li><a href="#">
		                                <img src="upload/history/${br.br_img2}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                            <c:if test="${br.br_img3 ne null}">
		                            <li><a href="#">
		                                <img src="upload/history/${br.br_img3}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                        </ul>
	                    </div><!--//timeCard_visualWrap -->
                    </c:if>
                    <div class="timeCard_content">
                        ${br.br_text}
                    </div><!--//timeCard_content-->
                    <a href="#" class="timeCard_more">더 보기..</a>
                </div><!--//timeCard-->
            </div><!--//timeCardWrap-->
            </c:forEach>
       
		            
		        </div>
		    </div>
		</div>
	    
	    
		<div class="cardWrap newestWrap">
		<c:choose>
		<c:when test="${sessionScope.mev != null }">
		    <div class="hd_historyEx">나의 관심분야 최신 글</div>
		    	<c:set var="index" value="0"/>
		
				    <div class="newestWrap_bd">
				    	
				        <div class="newestWrap_title">
				            ${interesting[index].cate_name }
				            <input type="button" value="more" class="btnStyle4" onclick="seeMore('${interesting[index].cate_id}')">
				        </div><!--//newestWrap_title-->
				        
				        <c:choose>
				        <c:when test="${new1_idx == 0 }">
					        <div class="newest_contentWrap">
					        	새로운 글이 없습니다.
					        </div>
				        </c:when>
				        <c:otherwise>
					        <c:forEach var="newest" items="${new1}">
					        <div class="newest_contentWrap">
					            <a href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">
								<c:choose>
									<c:when test="${newest.p_coverImg eq '' || newest.p_coverImg eq null}">
										<img src="resources/images/default.png" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:when>
									<c:otherwise>
										<img src="resources/images/projectCover/${newest.p_coverImg}" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:otherwise>
								</c:choose>
					            </a>
					            <div class="newest_textWrap">
					                <p class="newest_title"><a class="ellipsis" href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">${newest.p_title }</a></p>
					                <p class="newest_content"><a href="#">${newest.p_summary } </a></p>
					                <p class="newest_tag ellipsis">
					                	<c:forTokens var="aTag" items="${newest.hashtags }" delims=",">
											#${aTag } 
										</c:forTokens>
					                </p>
					            </div>
					        </div><!--//newest_contentWrap-->	 
					    	</c:forEach>       
				        </c:otherwise>
				        </c:choose>
		
				    </div><!--//newestWrap_bd-->
		
			    
			    <c:set var="index" value="${index+1 }"/>
			    
				    <div class="newestWrap_bd">
		
				        <div class="newestWrap_title">
				            ${interesting[index].cate_name }
				            <input type="button" value="more" class="btnStyle4" onclick="seeMore('${interesting[index].cate_id}')">
				        </div><!--//newestWrap_title-->
				        
				        <c:choose>
					        <c:when test="${new2_idx == 0 }">
						        <div class="newest_contentWrap">
						        	새로운 글이 없습니다.
						        </div>
					        </c:when>
					        <c:otherwise>
						        <c:forEach var="newest" items="${new2}">
							        <div class="newest_contentWrap">
							            <a href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">
										<c:choose>
											<c:when test="${newest.p_coverImg eq '' || newest.p_coverImg eq null}">
												<img src="resources/images/default.png" width="80" height="80" alt="포트폴리오 이미지"/>
											</c:when>
											<c:otherwise>
												<img src="resources/images/projectCover/${newest.p_coverImg}" width="80" height="80" alt="포트폴리오 이미지"/>
											</c:otherwise>
										</c:choose>
							            </a>
							            <div class="newest_textWrap">
							                <p class="newest_title"><a class="ellipsis" href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">${newest.p_title }</a></p>
							                <p class="newest_content"><a href="#">${newest.p_summary }</a></p>
							                <p class="newest_tag ellipsis">
							                	<c:forTokens var="aTag" items="${newest.hashtags }" delims=",">
													#${aTag } 
												</c:forTokens>
							                </p>
							            </div>
							        </div><!--//newest_contentWrap-->	        
					    		</c:forEach>
					        </c:otherwise>
						</c:choose>
				    </div><!--//newestWrap_bd-->
		
		</c:when>
		
		<c:otherwise>
		    <div class="hd_historyEx">최신 글</div>
			
				<div class="newestWrap_bd">
					<div class="newestWrap_title">
				                게임
						<input type="button" value="more" class="btnStyle4"  onclick="seeMore('1')">
					</div><!--//newestWrap_title-->
					
					
				 <c:choose>
					<c:when test="${new1_idx == 0 }">
						<div class="newest_contentWrap">
						 	새로운 글이 없습니다.
						</div>
					</c:when>
					<c:otherwise>	
						<c:forEach var="newest" items="${new1}">     
							<div class="newest_contentWrap">
								<a href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">
								<c:choose>
									<c:when test="${newest.p_coverImg eq '' || newest.p_coverImg eq null}">
										<img src="resources/images/default.png" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:when>
									<c:otherwise>
										<img src="resources/images/projectCover/${newest.p_coverImg}" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:otherwise>
								</c:choose>
								</a>
								<div class="newest_textWrap">
									<p class="newest_title"><a class="ellipsis" href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">${newest.p_title }</a></p>
									<p class="newest_content"><a href="#">${newest.p_summary }</a></p>
									<p class="newest_tag ellipsis">
										<c:forTokens var="aTag" items="${newest.hashtags }" delims=",">
											#${aTag } 
										</c:forTokens>
									</p>
								</div>
							</div><!--//newest_contentWrap-->		        
				    	</c:forEach>
				    </c:otherwise>
				</c:choose>
				</div><!--//newestWrap_bd-->
		
		    
				<div class="newestWrap_bd">
		
					<div class="newestWrap_title">
				                웹&앱
						<input type="button" value="more" class="btnStyle4" onclick="seeMore('2')">
					</div><!--//newestWrap_title-->
					
					<c:choose>
						<c:when test="${new2_idx == 0 }">
							<div class="newest_contentWrap">
							 	새로운 글이 없습니다.
							</div>
						</c:when>
						<c:otherwise>	
							<c:forEach var="newest" items="${new2}">	        
							<div class="newest_contentWrap">
								<a href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">
								<c:choose>
									<c:when test="${newest.p_coverImg eq '' || newest.p_coverImg eq null}">
										<img src="resources/images/default.png" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:when>
									<c:otherwise>
										<img src="resources/images/projectCover/${newest.p_coverImg}" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:otherwise>
								</c:choose>
								</a>
								<div class="newest_textWrap">
									<p class="newest_title"><a class="ellipsis" href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">${newest.p_title }</a></p>
									<p class="newest_content"><a href="#">${newest.p_summary } </a></p>
									<p class="newest_tag ellipsis">
										<c:forTokens var="aTag" items="${newest.hashtags }" delims=",">
											#${aTag } 
										</c:forTokens>
									</p>
								</div>
							</div><!--//newest_contentWrap-->		
							</c:forEach>       
						</c:otherwise>
					</c:choose> 
				</div><!--//newestWrap_bd-->
		
		    
				<div class="newestWrap_bd">
					<div class="newestWrap_title">
				         	영상&사운드
						<input type="button" value="more" class="btnStyle4" onclick="seeMore('3')">
					</div><!--//newestWrap_title-->
					
					<c:choose>
						<c:when test="${new3_idx == 0 }">
							<div class="newest_contentWrap">
							 	새로운 글이 없습니다.
							</div>
						</c:when>
						<c:otherwise>	
						 	<c:forEach var="newest" items="${new3}">       
							<div class="newest_contentWrap">
								<a href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">
								<c:choose>
									<c:when test="${newest.p_coverImg eq '' || newest.p_coverImg eq null}">
										<img src="resources/images/default.png" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:when>
									<c:otherwise>
										<img src="resources/images/projectCover/${newest.p_coverImg}" width="80" height="80" alt="포트폴리오 이미지"/>
									</c:otherwise>
								</c:choose>
								</a>
								<div class="newest_textWrap">
									<p class="newest_title"><a class="ellipsis" href="projectView?m_id=${newest.m_id}&p_id=${newest.p_id}">${newest.p_title }</a></p>
									<p class="newest_content"><a href="#">${newest.p_summary } </a></p>
									<p class="newest_tag ellipsis">
										<c:forTokens var="aTag" items="${newest.hashtags }" delims=",">
											#${aTag } 
										</c:forTokens>
									</p>
								</div>
							</div><!--//newest_contentWrap-->	
							</c:forEach>
						</c:otherwise>
					</c:choose>     
				</div><!--//newestWrap_bd-->
		
		</c:otherwise>
		</c:choose>
		    
		
		</div><!--//newestWrap-->
	</div><!--//contentM -->
</div><!-- contentsWrap -->

