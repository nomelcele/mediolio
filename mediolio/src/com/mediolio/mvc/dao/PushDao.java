package com.mediolio.mvc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		if(pushedNum.trim().equals("null")){
			//처음 로그인 한 경우, session에 저장하고 새로 도착한 알림 수를 리턴
			session.getAttributes().put("push-"+userId, pushList);
			return pushList;
		}else if( Integer.parseInt(pushedNum)<pushList){
			//30초 내에 새로 도착한 알림이 있는 경우, session에 새로 저장하고 알림 갯수 리턴
			session.getAttributes().put("push-"+userId, pushList);
			return pushList;
		}else //30초 내에 업데이트된 소식이 없는 경우
			return  -1;
	}

	public Map<String, List<Object>> getMsgNotifications(String m_id) {
		Map<String, List<Object>> map = new HashMap<String, List<Object>>();
		map.put("msg", st.selectList("push.getMsgNotifications", Integer.parseInt(m_id)));
		return map;
	}

	public Map<String, List<Object>> getFollowNotifications(String m_id) {
		Map<String, List<Object>> map = new HashMap<String, List<Object>>();
		map.put("msg", st.selectList("push.getFollowNotifications", Integer.parseInt(m_id)));
		return map;
	}
	
	public Map<String, List<Object>> getReplyNotifications(String m_id) {
		Map<String, List<Object>> map = new HashMap<String, List<Object>>();
		map.put("msg", st.selectList("push.getReplyNotifications", Integer.parseInt(m_id)));
		return map;
	}

}
