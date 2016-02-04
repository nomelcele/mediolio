package com.mediolio.websocket;

import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class SocketHandler extends TextWebSocketHandler{
	private static Thread thread;
    private final Logger logger = LogManager.getLogger(getClass());
    private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
   
    private static boolean start_stop;
    
    public SocketHandler (){
          super();
          this.logger.info("create SocketHandler instance!");
    }

	//WebSocket 연결이 닫혔을 때 호출
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
          super.afterConnectionClosed(session, status);
          sessionSet.remove(session);
          start_stop = false;
          System.out.println("remove session!");
          this.logger.info("remove session!");
          Thread.currentThread().interrupt();
    }
    
	//WebSocket 연결이 열리고 사용이 준비될 때 호출(클라이언트에서 접속을 하여 성공할 경우 발생하는 이벤트)
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
    	  start_stop = true;
          super.afterConnectionEstablished(session);
          sessionSet.add(session);
          System.out.println("add session!");
          this.logger.info("add session!");
          
          thread = new Thread(){
				 int i=0;
                 @Override
                 public void run() {
                        while (start_stop){
                              try {
                            	  System.out.println(i);
                                     sendMessage ("send message index "+ thread.getName() + ": " + i++);
                                     Thread.sleep(1000);
                              } catch (InterruptedException e) {
                                     e.printStackTrace();
                                     break;
                              } 
                        }
                 }
          };
          thread.start();
    }

    // 클라이언트로부터 메시지가 도착했을 때 호출
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
          super.handleMessage(session, message);
          System.out.println("receive message!"+message.toString());
          this.logger.info("receive message:"+message.toString());
    }
    
    //전송 에러 발생할 때 호출
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
          this.logger.error("web socket error!", exception);
    }

    //WebSocketHandler가 부분 메시지를 처리할 때 호출
    @Override
    public boolean supportsPartialMessages() {
          this.logger.info("call method!");
          return super.supportsPartialMessages();
    }

    public void sendMessage (String message){
          for (WebSocketSession session: this.sessionSet){
                 if (session.isOpen()){
                        try{
                              session.sendMessage(new TextMessage(message));
                        }catch (Exception ignored){
                              this.logger.error("fail to send message!", ignored);
                        }
                 }
          }
    }

}
