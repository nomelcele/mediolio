<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<link href="resources/css/myPage.css" rel="stylesheet" type="text/css"/>    
<script src="js/myPage.js"></script> 
<div id="contentsWrap_nopd">
    <div class="rmcnWrap">
            <a class="btn_rmcn" id="btn_rmcnUp" href="#"></a>
            <a class="btn_rmcn" id="btn_rmcnDown" href="#"></a>
    </div><!--//rmcnWrap-->
    <h1 class="pageTitle"><span class="pageTitleIcon"></span>내 히스토리<span class="pageTitleNext"><a href="#">내 게시물</a></span></h1>
    
    <hr>
    
    <div class="historyWrap clear">
        <h2 class="historyTitle ellipsis"><span>제목</span>${recentHtTitle}</h2>
<!--        <input class="btnStyle2 btn_card" id="btn_editAllCards" type="button" value="편집">-->
        <input class="btnStyle2 btn_card" id="btn_addCard" type="button" value="글쓰기">
        
        
        <div class="timeLineWrap clear">
            <form action="addBranch" method="post" enctype="multipart/form-data">
            <input type="hidden" id="recentHtId" name="ht_id" value="${recentHtId}">
            <div class="timeCardWrap clear">
                <div class="timeCircle"></div>
                <div class="cardWrap timeCard">
                    <div class="timeCard_hd">
                        <input type="text" name="br_title" class="timeCard_writeInput timeCard_writeTitle" placeholder="글제목을 입력하세요.">
                    </div>
                    
                    <div class="timeCard_content">
                        <textarea name="br_text" class="timeCard_writeInput timeCard_writeContent"></textarea>
                        <input type="button" class="btn_timeCard_addImage" value="사진 추가">
                        <div class="timeCard_addImageWrap clear">
	                        <div id="imgFileBox1">
	                            <label></label>
	                            <a class="btn_timeCard_delImage" href="#">X</a>
	                            <div class="fileWrap_timeCard">
	                                <span>파일 추가</span>
	                                <input type="file" name="imgFiles[0]" class="file_timeCard">
	                            </div>
                            </div>
                            
                            <div id="imgFileBox2" style="display:none;">
	                            <label></label>
	                            <a class="btn_timeCard_delImage" href="#">X</a>
	                            <div class="fileWrap_timeCard">
	                                <span>파일 추가</span>
	                                <input type="file" name="imgFiles[1]" class="file_timeCard">
	                            </div>
                            </div>
                            
                            <div id="imgFileBox3" style="display:none;">
	                            <label></label>
	                            <a class="btn_timeCard_delImage" href="#">X</a>
	                            <div class="fileWrap_timeCard">
	                                <span>파일 추가</span>
	                                <input type="file" name="imgFiles[2]" class="file_timeCard">
	                            </div>
                            </div>
                        </div>
                        
                    </div><!--//timeCard_content-->
                    <div class="timeCard_writeDisplayWrap">
                        <input type="radio" name="br_public" value="1" checked><label>공개</label>
                        <input type="radio" name="br_public" value="0"><label>비공개</label>
                    </div>
                    <div class="timeCard_btnBox">
                        <input class="btnStyle_timeCard_left" type="button" value="취소">
                        <input class="btnStyle_timeCard_right" type="submit" value="완료">
                    </div>
                </div><!--//timeCard-->
            </div><!--//timeCardWrap-->
            </form>
            
            
            
            
            
            
            
            
            
            <c:forEach var="branches" items="${branches}">
	            <div class="timeCardWrap clear">
	                <div class="timeCircle"></div>
	                <div class="cardWrap timeCard">
	                    <div class="timeCard_hd">
	                        <h3 class="ellipsis">${branches.br_title}</h3>
	                        <h4>${branches.br_date}</h4>
	                        <span class="timeCard_display timeCard_lock">
	                        	<c:if test="${branches.br_public eq 1}">
		                        	공개
		                        </c:if>
		                        <c:if test="${branches.br_public eq 0}">
		                        	비공개
		                        </c:if>
	                        </span>
	                    </div>
	                    <div class="timeCard_visualWrap slider">
	                        <ul class="timeCard_imgWrap">
	                        	<c:if test="${branches.br_img1 != null}">
		                            <li><a href="#">
		                                <img src="upload/history/${branches.br_img1}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                            <c:if test="${branches.br_img2 != null}">
		                            <li><a href="#">
		                                <img src="upload/history/${branches.br_img2}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                            <c:if test="${branches.br_img3 != null}">
		                            <li><a href="#">
		                                <img src="upload/history/${branches.br_img3}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                        </ul>
	                    </div><!--//timeCard_visualWrap -->
	                    <div class="timeCard_content">
	                    	${branches.br_text}
	                    </div><!--//timeCard_content-->
	                    <div class="timeCard_btnBox">
	                        <input class="btnStyle_timeCard_left" type="button" value="수정">
	                        <input class="btnStyle_timeCard_right br_delete_btn" type="button" value="삭제">
	                        <input type="hidden" class="branch_id" value="${branches.br_id}">
	                    </div>
	                </div><!--//timeCard-->
	            </div><!--//timeCardWrap-->
            </c:forEach>
            
        </div>
    </div>
    <div class="cardWrap historyExWrap">
        <div class="hd_historyEx">히스토리 목록
            <input type="button" class="btnStyle3" id="btn_addHistory" value="추가">
        </div>
        <div class="bd_historyEx">
        <!-- 히스토리 목록 -->
            <c:forEach var="htList" items="${htList}">
	            <table cellspacing="0" cellpadding="0">
	                <tr>
	                    <td class="historyList_border historyList_name">
	                    	<input type="hidden" class="history_id" value="${htList.ht_id}">
	                        <p class="historyList_arco ellipsis history_title">${htList.ht_title}</p>
	                        <a class="historyList_pop" href="#"></a>
	                        <div class="history_popMenuWrap">
	                            <ul class="history_popMenu">
	                                <li><a href="#">히스토리 수정</a></li>
	                                <li>
	                                	<form action="deleteHistory" id="deleteHt${htList.ht_id}">
	                                		<input type="hidden" name="ht_id" value="${htList.ht_id}">
	                                	</form>
	                                	<a href="javascript:deleteHistory(${htList.ht_id});">히스토리 삭제</a>
	                                </li>
	                                <li><a href="javascript:changeHtPublic(${htList.ht_id},${htList.ht_public});">공개설정 : 
		                                <c:if test="${htList.ht_public eq 1}">
		                                	공개
		                                </c:if>
		                                <c:if test="${htList.ht_public eq 0}">
		                                	비공개
		                                </c:if>
	                                </a></li>
	                            </ul>
	                        </div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="historyList_border historyList_contentWrap">
	                        <p class="history_content">${htList.ht_introduce}</p>
	                        <p><span>관련과목 : </span>${htList.class_name}</p>
	                        
	                    </td>
	                </tr>
	            </table>
            </c:forEach>
         <!-- 히스토리 목록 -->
            <form id="addHistoryForm" action="addHistory" method="post">
            <table cellspacing="0" cellpadding="0" class="historyList_addTable">
                <tr>
                    <td class="historyList_border historyList_addName">
                        <input type="text" name="ht_title" placeholder="히스토리 제목을 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <td class="historyList_border historyList_addContentWrap clear">
                        <textarea name="ht_introduce" placeholder="내용을 입력하세요."></textarea>
                        <span>관련과목 : </span>
                        <textarea placeholder="예)웹앱프로그래밍" class="historyList_addRelated"></textarea>
                        <div class="autoCompleteBox classBox"><ul id="autoCompleteArea"></ul></div>
                        <div class="timeCard_writeDisplayWrap">
                            <input name="ht_public" value="1" type="radio" checked><label>공개</label>
                            <input name="ht_public" value="0" type="radio"><label>비공개</label>
                        </div>
                        <div class="timeCard_btnBox">
                            <input class="btnStyle_timeCard_left" type="button" value="취소">
                            <input id="addHistoryBtn" class="btnStyle_timeCard_right" type="button" value="완료">
                        </div>
                    </td>
                </tr>
            </table>
            </form>
            
            
        </div><!--/bd_historyEx-->
    </div><!--//historyExWrap-->
    
    
    
    
    
    
    
    
</div>