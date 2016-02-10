package com.mediolio.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.WebSocketSession;

@Repository
public class PushDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public int checkLatestNews(String userId, WebSocketSession session) {
		//새로 받아온 알림목록 갯수
		int pushList = st.selectOne("push.checkLatestNews", Integer.parseInt(userId));
		
		//이미 push되어 있는 메세지 개수 받아오기(세션에 저장되어 있음)
		String pushedNum = String.valueOf(session.getAttributes().get("push-"+userId));
		
		System.out.println("pushedNum : " + pushedNum);
		if(pushedNum.trim().equals("null")){
			System.out.println("첫 로그인 null");
			//처음 로그인 한 경우, session에 저장하고 새로 도착한 알림 수를 리턴
			session.getAttributes().put("push-"+userId, pushList);
			if(pushList>0) return pushList;
			else return -1;
		}else if( Integer.parseInt(pushedNum)<pushList){
			System.out.println("pushListMore");
			//30초 내에 새로 도착한 알림이 있는 경우, session에 새로 저장하고 알림 갯수 리턴
			session.getAttributes().put("push-"+userId, pushList);
			return pushList;
		}else //30초 내에 업데이트된 소식이 없는 경우
			System.out.println("nothing");
			return -1;
	}
}