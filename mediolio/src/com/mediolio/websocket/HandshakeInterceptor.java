package com.mediolio.websocket;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;



/* *****  오지은 작성
 * ***** 
 * *****  각 회원의 Push 알람을 위한 Websocket 관련 class
 * *****  클라이언트마다 연결을 만들 때 Handshaking 과정에서 거치는 class
 * */

public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{
	@Override
	public boolean beforeHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
                
        ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
        //System.out.println("URI:"+request.getURI());
 
        HttpServletRequest req =  ssreq.getServletRequest();
         
        // 이 곳에서 로그인한 회원의 id를 put, WebsocketEndPoint.java에서 받아서 사용
        String usrId = req.getParameter("id");
        attributes.put("usrId", usrId);
 
        return super.beforeHandshake(request, response, wsHandler, attributes);
	}
}
