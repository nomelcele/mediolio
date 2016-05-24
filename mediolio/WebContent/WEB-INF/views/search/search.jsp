<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="resources/css/search.css" rel="stylesheet" type="text/css"/>

<div id="contentsWrap">
    <div class="rmcnWrap">
            <a class="btn_rmcn" id="btn_rmcnUp" href="#"></a>
            <a class="btn_rmcn" id="btn_rmcnDown" href="#"></a>
    </div><!--//rmcnWrap-->
    
    <div class="cardWrap searchResultWrap">
        <p class="searchResult">"<strong>${key }</strong>"&nbsp;<span>${type }</span> 검색결과 ${total }건</p>
    </div>
    
    <c:forEach var="prj" items="${list}">
	    <div class="cardWrap searchWrap">
	        <a href="projectView?m_id=${prj.m_id}&p_id=${prj.p_id}">
		        <c:if test="${prj.p_coverImg ne '' && prj.p_coverImg ne null}">
		        	<img src="resources/images/projectCover/${prj.p_coverImg}" width="100" height="100" alt="포트폴리오 이미지"/>
		        </c:if>
		        <c:if test="${prj.p_coverImg eq '' || prj.p_coverImg eq null}">
			     	<img src="resources/images/default.png" width="100" height="100" alt="포트폴리오 이미지"/>
		        </c:if>
	        </a>
	        <div class="search_contentWrap">
	            <p class="search_title"><a class="ellipsis" href="projectView?m_id=${prj.m_id}&p_id=${prj.p_id}">${prj.p_title}</a></p>
	            <p class="search_writer"><a class="ellipsis" href="userpage?usr_id=${prj.m_id }">${prj.authorID } ${prj.authorName }</a></p>
	            <p class="search_tag ellipsis">
	                <c:forTokens var="aTag" items="${prj.hashtags }" delims=",">
						#${aTag } 
					</c:forTokens>
	            </p>
	        </div>
	    </div>
    </c:forEach>
<!--     <div class="cardWrap searchWrap">
        <a href="#">
            <img src="http://placehold.it/100x100/f0f0f0" width="100" height="100" alt="포트폴리오 이미지"/>
        </a>
        <div class="search_contentWrap">
            <p class="search_title"><a class="ellipsis" href="#">글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다.</a></p>
            <p class="search_writer"><a class="ellipsis" href="#">12이유라</a></p>
            <p class="search_tag ellipsis">게임프로그래밍, 게임디자인</p>
        </div>
    </div>
    
    <div class="cardWrap searchWrap">
        <a href="#">
            <img src="http://placehold.it/100x100/ccc" width="100" height="100" alt="포트폴리오 이미지"/>
        </a>
        <div class="search_contentWrap">
            <p class="search_title"><a class="ellipsis" href="#">글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. </a></p>
            <p class="search_writer"><a class="ellipsis" href="#">12이유라</a></p>
            <p class="search_tag ellipsis">게임프로그래밍, 게임디자인</p>
        </div>
    </div>
    
    <div class="cardWrap searchWrap">
        <a href="#">
            <img src="http://placehold.it/100x100/ccc" width="100" height="100" alt="포트폴리오 이미지"/>
        </a>
        <div class="search_contentWrap">
            <p class="search_title"><a class="ellipsis" href="#">글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. </a></p>
            <p class="search_writer"><a class="ellipsis" href="#">12이유라</a></p>
            <p class="search_tag ellipsis">게임프로그래밍, 게임디자인</p>
        </div>
    </div>
    
    <div class="cardWrap searchWrap">
        <a href="#">
            <img src="http://placehold.it/100x100/ccc" width="100" height="100" alt="포트폴리오 이미지"/>
        </a>
        <div class="search_contentWrap">
            <p class="search_title"><a class="ellipsis" href="#">글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. </a></p>
            <p class="search_writer"><a class="ellipsis" href="#">12이유라</a></p>
            <p class="search_tag ellipsis">게임프로그래밍, 게임디자인</p>
        </div>
    </div>
    
    <div class="cardWrap searchWrap">
        <a href="#">
            <img src="http://placehold.it/100x100/ccc" width="100" height="100" alt="포트폴리오 이미지"/>
        </a>
        <div class="search_contentWrap">
            <p class="search_title"><a class="ellipsis" href="#">글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. </a></p>
            <p class="search_writer"><a class="ellipsis" href="#">12이유라</a></p>
            <p class="search_tag ellipsis">게임프로그래밍, 게임디자인</p>
        </div>
    </div>
    
    <div class="cardWrap searchWrap">
        <a href="#">
            <img src="http://placehold.it/100x100/ccc" width="100" height="100" alt="포트폴리오 이미지"/>
        </a>
        <div class="search_contentWrap">
            <p class="search_title"><a class="ellipsis" href="#">글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. 글제목입니다. </a></p>
            <p class="search_writer"><a class="ellipsis" href="#">12이유라</a></p>
            <p class="search_tag ellipsis">게임프로그래밍, 게임디자인</p>
        </div>
    </div> -->
    
    
</div><!--//contentsWrap-->