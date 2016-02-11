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
        
        sessionSet.add(session);
    } 
  
    // 클라이언트에서 send를 이용해서 메시지 발송을 한 경우 이벤트 핸들링
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        //String payloadMessage = (String) message.getPayload();
        
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
	                    	
	                    	Thread.sleep(30000);
	                 	} catch (InterruptedException | IOException e) {
	                 		Thread.currentThread().interrupt();
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
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        super.afterConnectionClosed(session, status);

        System.out.println("Closed");
        //thread 멈춤
        String usrId =  (String) session.getAttributes().get("usrId");
        threadMap.get(usrId).interrupt();
        //session 삭제
        sessionSet.remove(session);
    }
}