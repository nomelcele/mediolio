<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 쪽지보내기 모달 -->
    <div class="modal" id="writeNoteWrap">
        <div class="modal_hd"  id="writeNoteWrap_hd">SEND MESSAGE
            <input class="btnStyle3" id="btn_sendNote" type="button" value="SEND"/>
        </div>
        <div class="modal_bd" id="writeNoteWrap_bd">
        	<input type="text" placeholder="받는 사람" id="input_noteTo" value="${m_nickname }"/>
	        <form id="msgForm">
	        	<input type="hidden" name="msg_to" value="${m_id }">
	            <textarea placeholder="내용을 입력하세요." name="msg_text"></textarea>
	        </form>
        </div>
    </div>