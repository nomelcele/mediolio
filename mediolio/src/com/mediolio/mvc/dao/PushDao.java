package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.WebSocketSession;

import com.mediolio.vo.PushMsgVO;
import com.mediolio.vo.PushVO;



/* *****
 * ***** 오지은 작성
 * *****
 * */

@Repository
public class PushDao {
	@Autowired
	private SqlSessionTemplate st;
	
	// header의 종 모양에 알림 갯수를 나타내기 위한 함수. 30초마다 websocket에 의해 실행
	public int checkLatestNews(String userId, WebSocketSession session) {
		//알림 목록 갯수
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

	// 새로운 메세지나, 아직 읽지 않은 메세지들 리턴하는 함수
	public List<PushMsgVO> getMsgNotifications(String m_id) {
		return  st.selectList("push.getMsgNotifications", Integer.parseInt(m_id));
	}

	// 새로운 팔로워가 있을 때 팔로워 목록을 리턴하는 함수
	public List<PushVO> getFollowNotifications(String m_id) {
		return st.selectList("push.getFollowNotifications", Integer.parseInt(m_id));
	}
	
	// 특정 유저가 올린 글에 새로운 댓글이 달린 경우, 목록을 리턴하는 함수
	public List<PushVO> getReplyNotifications(String m_id) {
		return st.selectList("push.getReplyNotifications", Integer.parseInt(m_id));
	}

}
