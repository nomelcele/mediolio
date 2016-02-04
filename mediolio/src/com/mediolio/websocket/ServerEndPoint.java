package com.mediolio.websocket;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.JsonObject;
import com.google.gson.stream.JsonWriter;

@ServerEndpoint("/serverEndPoint")
public class ServerEndPoint {
	private static Thread thread;
    private final Logger logger = LogManager.getLogger(getClass());
    private Set<Session> sessionSet = Collections.synchronizedSet(new HashSet<Session>());
   
    private static boolean start_stop;
    
	@OnOpen
	public void handleOpen(Session session){
		sessionSet.add(session);
		//HttpSession httpSession = (HttpSession)session.getUserProperties().get("someSessionPropertyName");
		System.out.println("client is now connected...");
	}
	@OnMessage
	public String handleMessage(String message, Session session) throws IOException{
		String username = (String) session.getUserProperties().get("username");
		if(username == null){
			session.getUserProperties().put("username", message);
			session.getBasicRemote().sendText(buildJsonData("System", "you are now connected as " +message));
		}else{
			Iterator<Session> iterator = sessionSet.iterator();
			while(iterator.hasNext()) iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
		}
		System.out.println("receive from client: " + message);
		String replyMessage = "echo " + message;
		System.out.println("send to client: " + replyMessage);
		return replyMessage;
	}
	@OnClose
	public void handleClose(Session session){
		sessionSet.remove(session);
		System.out.println("client is now disconnected...");
	}
	
	public void handleError(Throwable t){
		t.printStackTrace();
	}
	
	private String buildJsonData(String username, String message){
		//JsonObject jsonObject = Json.createObjectBuilder().add("message", username+" : " +message).builder();
		StringWriter stringWriter = new StringWriter();
		//try(JsonWriter jsonWriter = Json.createWriter(stringWriter)){jsonWriter.write(jsonObject);}
		return "";/*stringWriter.toString();*/
	}
}
