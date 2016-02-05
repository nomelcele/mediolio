package com.mediolio.websocket;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/websocket/serverEndPoint", configurator = ServerConfigurator.class)
public class ServerEndPoint {
	private static Thread thread;
    private Set<Session> sessionSet = Collections.synchronizedSet(new HashSet<Session>());
   
    private static boolean start_stop;
    
	@OnOpen
	public void handleOpen(EndpointConfig endpointConfig, Session session){
		//configurator에서 세팅했던 username을 가져와서 session에 넣는다
		session.getUserProperties().put("userPush", endpointConfig.getUserProperties().get("userPush"));
		sessionSet.add(session);
		System.out.println("client is now connected...");
	}
	
	@OnMessage
	public void handleMessage(String message, Session session) throws IOException{
		//handleOpen에서 넣었던 username 가져와서 사용
		String username = (String) session.getUserProperties().get("userPush");
		System.out.println("연결 : " + username + ", " + message);
		
		start_stop = true;
		if(username != null){
			System.out.println("null이 아님!");
			thread = new Thread(){
				int i=0;
	            @Override
	            public void run() {
	            	while (true){
	                	try {
	                    	System.out.println(i);
	                    	buildJsonData("thread"+username, i++);
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
	}
	@OnClose
	public void handleClose(Session session){
		start_stop = false;
		sessionSet.remove(session);
        Thread.currentThread().interrupt();
		System.out.println("client is now disconnected...");
	}
	
	@OnError
	public void handleError(Throwable t){
		t.printStackTrace();
	}
	
	private void buildJsonData(String username, int i){
		sessionSet.stream().forEach(x -> {
			JsonObject jsonObject = Json.createObjectBuilder().add("message", username+": " +i).build();
			StringWriter stringWriter = new StringWriter();
			
			try(JsonWriter jsonWriter = Json.createWriter(stringWriter)){
				jsonWriter.write(jsonObject);
				x.getBasicRemote().sendText(stringWriter.toString());
			}
			catch(Exception e){e.printStackTrace();}
		});
		
	}
}
