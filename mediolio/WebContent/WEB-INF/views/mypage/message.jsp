<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="js/note.js"></script> 


<!-- 이유라 : 마크업  -->
<!-- 오지은 : 데이터 뿌림 -->

<div id="contentsWrap">
    <div class="rmcnWrap">
            <a class="btn_rmcn" id="btn_rmcnUp" href="#"></a>
            <a class="btn_rmcn" id="btn_rmcnDown" href="#"></a>
    </div><!--//rmcnWrap-->
    
    <div class="cardWrap" id="cardWrap_note">
    	<div class="card_hd" id="card_note_hd">
            <a class="btn_receiveView" href="#">받은 쪽지함</a>
            <a class="btn_sendView" href="#">보낸 쪽지함</a>
            <input type="button" class="btnStyle3" id="btn_writeNote" value="쪽지보내기" onclick="noteModalOpen('','')"/>
        </div>
        
        <!-- 받은쪽지 내용물-->
        <div class="card_note_bd" id="card_receiveNote_bd">
        <c:forEach var="aMsg" items="${list }">
    		<div class="noteWrap receiveNoteWrap">
                <div class="noteWrap_hd">
                	<input type="hidden" class="this_msg_id" value="${aMsg.msg_id }">
                    <a class="noteId" href="userpage?usr_id=${aMsg.msg_from }">${aMsg.msg_from_studentID } ${aMsg.msg_from_nickname }</a>
                    <p class="noteDate">${aMsg.msg_date }</p>
                    <a href="#" class="btn_note replyNote" onclick="noteModalOpen('${aMsg.msg_from }', '${aMsg.msg_from_studentID } ${aMsg.msg_from_nickname }')">답장</a>
                    <a href="#" class="btn_note btn_deleteNote receiveNote">삭제</a>
                    <hr>
                </div>
                <div class="noteWrap_bd">
                	<p>
                    	${aMsg.msg_text }
                    </p>
                    <a href="#" class="noteMore">>> more</a>
                </div><!--//noteWrap_bd-->
            </div><!--//noteWrap -->
    	</c:forEach>
        </div><!--//card_receiveNote_bd --> 

        
        <!-- 보낸쪽지 내용물 -->
        <div class="card_note_bd" id="card_sendNote_bd">
            
<!--                <div class="noteWrap sendNoteWrap">
                <div class="noteWrap_hd">
                    <p class="noteId">12USER</p>
                    <p class="noteDate">2016-02-02 12:00:00</p>
                    <a href="#" class="btn_note btn_deleteNote sendNote">삭제</a>
                    <hr>
                </div>
                <div class="noteWrap_bd">
                   <p>
                    SSSLorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur beatae in quidem, debitis, inventore totam autem enim repellat cum quae commodi ex. Vitae dolor mollitia earum totam obcaecati, perspiciatis provident! Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur beatae in quidem, debitis, inventore totam autem enim repellat cum quae commodi ex. Vitae dolor mollitia earum totam obcaecati, perspiciatis provident!Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur beatae in quidem, debitis, inventore totam autem enim repellat cum quae commodi ex. Vitae dolor mollitia earum totam obcaecati, perspiciatis provident! 
                    </p>
                    <a href="#" class="noteMore">>> more</a>
                </div>//noteWrap_bd
            </div>//noteWrap
 -->
        </div><!--//card_sendNote_bd -->
    </div>
   </div>


   