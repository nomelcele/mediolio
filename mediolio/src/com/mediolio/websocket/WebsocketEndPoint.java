package com.mediolio.websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.mediolio.mvc.dao.PushDao;

/* *****  오지은 작성
 * ***** 
 * *****  각 회원의 Push 알람을 위한 Websocket class
 * *****  각 회원마다 스레드를 생성하여, 30초마다 각 회원에게 새로운 알림을 푸시하는 역할
 * */

public class WebsocketEndPoint extends TextWebSocketHandler {

    // 접속하는 사용자에 대한 세션을 보관하기 위해 정의
	private Thread thread;
    private Set<WebSocketSession> sessionSet = Collections.synchronizedSet(new HashSet<WebSocketSession>());
    private Map<String, Thread> threadMap = Collections.synchronizedMap(new HashMap<String, Thread>());

    @Autowired
    private PushDao pdao;
    
    // 클라이언트에서 접속을 하여 성공할 경우 발생하는 이벤트
    @Override
    public void afterConnectionEstablished(WebSocketSession session)
            throws Exception {
        super.afterConnectionEstablished(session);
        System.out.println("Session Connected");
        
        sessionSet.add(session); //sessionSet에 각 회원의 세션 저장
    } 
  
    // 클라이언트에서 send를 이용해서 메시지 발송을 한 경우 이벤트 핸들링
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        //String payloadMessage = (String) message.getPayload();
        
    	// 클라이언트에서 메세지를 보낸 회원 식별(usrId)
        Map<String, Object> map = session.getAttributes();
        String usrId = (String)map.get("usrId");
        
		if(usrId != null){
			thread = new Thread(){
	            @Override
	            public void run() {
	            	while (!Thread.currentThread().isInterrupted()){
	                	try {
	                		int msg = pdao.checkLatestNews(usrId, session);
	                		
	                		//새 push가 0개 이상인 경우에만 client에 알림
	                		if(msg>0) session.sendMessage(new TextMessage(msg+""));
	                    	
	                    	Thread.sleep(30000); //30초 sleep
	                 	} catch (InterruptedException | IOException e) {
	                 		Thread.currentThread().interrupt();
	                 		sessionSet.remove(session);
	                    	System.out.println("thread interrupted");
	                    	break;
	                 	} 
	            	}
	        	}
			};
			//thread 저장
			threadMap.put(usrId, thread);
		    thread.start();
		}
        
    }
  
    // 클라이언트에서 연결을 종료할 경우 발생하는 이벤트
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        try {
			super.afterConnectionClosed(session, status);
			
        } catch (Exception e) {
			e.printStackTrace();
			
		}finally{
	        //System.out.println("Closed");
	        
			// 연결을 종료한 회원의 thread 멈춤
	        String usrId =  (String) session.getAttributes().get("usrId");
	        threadMap.get(usrId).interrupt();
	        
	        //그 회원의 session 삭제
	        sessionSet.remove(session);
		}

    }
}