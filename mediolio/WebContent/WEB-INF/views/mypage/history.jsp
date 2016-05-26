<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--  <div class="historyWrap clear"> -->
        <h2 class="historyTitle ellipsis"><span>제목</span>${htTitle}</h2>
<!--        <input class="btnStyle2 btn_card" id="btn_editAllCards" type="button" value="편집">-->
        <input class="btnStyle2 btn_card" id="btn_addCard" type="button" value="글쓰기">
        
        
        <div class="timeLineWrap clear">
            <form action="addBranch" method="post" enctype="multipart/form-data">
            <input type="hidden" id="htId" name="ht_id" value="${htId}">
            <div class="timeCardWrap clear">
                <div class="timeCircle"></div>
                <div class="cardWrap timeCard">
                    <div class="timeCard_hd">
                        <input type="text" name="br_title" class="timeCard_writeInput timeCard_writeTitle" placeholder="글제목을 입력하세요.">
                    </div>
                    
                    <div class="timeCard_content">
                        <textarea name="br_text" class="timeCard_writeInput timeCard_writeContent"></textarea>
                        <input type="button" class="btn_timeCard_addImage" value="사진 추가" onclick="addBrImg()">
                        <div class="timeCard_addImageWrap clear">
	                        <div id="imgFileBox1">
	                            <label></label>
	                            <a class="btn_timeCard_delImage" href="javascript:deleteBrImg(this)">X</a>
	                            <div class="fileWrap_timeCard">
	                                <span>파일 추가</span>
	                                <input type="file" name="imgFiles[0]" class="file_timeCard" onchange="showFileName(this)">
	                            </div>
                            </div>
                            
                            <div id="imgFileBox2" style="display:none;">
	                            <label></label>
	                            <a class="btn_timeCard_delImage" href="javascript:deleteBrImg(this)">X</a>
	                            <div class="fileWrap_timeCard">
	                                <span>파일 추가</span>
	                                <input type="file" name="imgFiles[1]" class="file_timeCard" onchange="showFileName(this)">
	                            </div>
                            </div>
                            
                            <div id="imgFileBox3" style="display:none;">
	                            <label></label>
	                            <a class="btn_timeCard_delImage" href="javascript:deleteBrImg(this)">X</a>
	                            <div class="fileWrap_timeCard">
	                                <span>파일 추가</span>
	                                <input type="file" name="imgFiles[2]" class="file_timeCard" onchange="showFileName(this)">
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
            
            <!-- Branches -->
            <c:forEach var="branchList" items="${branchList}">
	            <div class="timeCardWrap clear">
	                <div class="timeCircle"></div>
	                <div class="cardWrap timeCard">
	                    <div class="timeCard_hd">
	                        <h3 class="ellipsis">${branchList.br_title}</h3>
	                        <h4>${branchList.br_date}</h4>
	                        <span class="timeCard_display timeCard_lock">
	                        	<c:if test="${branchList.br_public eq 1}">
		                        	공개
		                        </c:if>
		                        <c:if test="${branchList.br_public eq 0}">
		                        	비공개
		                        </c:if>
	                        </span>
	                    </div>
	                    <div class="timeCard_visualWrap slider">
	                        <ul class="timeCard_imgWrap">
	                        	<c:if test="${branchList.br_img1 != null}">
		                            <li><a href="#">
		                                <img src="upload/history/${branchList.br_img1}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                            <c:if test="${branchList.br_img2 != null}">
		                            <li><a href="#">
		                                <img src="upload/history/${branchList.br_img2}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                            <c:if test="${branchList.br_img3 != null}">
		                            <li><a href="#">
		                                <img src="upload/history/${branchList.br_img3}" class="timeLine_img">
		                            </a></li>
	                            </c:if>
	                        </ul>
	                    </div><!--  timeCard_visualWrap -->
	                    <div class="timeCard_content">
	                    	${branchList.br_text}
	                    </div><!-- timeCard_content -->
	                    <div class="timeCard_btnBox">
	                        <input class="btnStyle_timeCard_left" type="button" value="수정">
	                        <input class="btnStyle_timeCard_right br_delete_btn" type="button" value="삭제" onclick="deleteBranch()">
	                        <input type="hidden" class="branch_id" value="${branchList.br_id}">
	                    </div>
	                </div><!--  timeCard-->
	            </div><!-- timeCardWrap-->
            </c:forEach>
            <!-- Branches -->
        </div>
<!--     </div> -->