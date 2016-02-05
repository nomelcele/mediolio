package com.mediolio.websocket;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.*;
public class ServerConfigurator extends ServerEndpointConfig.Configurator{
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response){
		HttpSession session = (HttpSession) request.getHttpSession();
		String loginid= Integer.toString((int)session.getAttribute("id"));
		sec.getUserProperties().put("userPush", loginid);
	}

}
