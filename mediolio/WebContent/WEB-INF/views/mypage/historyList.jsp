<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                        <textarea placeholder="예)웹앱프로그래밍" class="historyList_addRelated" onkeyup="autoCompleteHtClass(this)"></textarea>
                        <div class="autoCompleteBox classBox autoHtClass"><ul id="autoCompleteArea"></ul></div>
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