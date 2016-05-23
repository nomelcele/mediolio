package com.mediolio.mvc.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.FriendVO;
import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.MessageVO;
import com.mediolio.vo.PushMsgVO;

@Repository
public class MemberActionDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public int projectLike(Member_actionVO maVo) {
		st.insert("ma.projectLike", maVo);
		return st.selectOne("ma.getProjectLike", maVo.getAct_what());
	}

	public void projectLikeCancel(Member_actionVO maVo) {
		st.delete("ma.projectLikeCancel", maVo);
	}
	
	public void msgSend(MessageVO vo) {
		st.insert("ma.msgSend", vo);		
	}

	public List<PushMsgVO> getMsgListReceived(int msg_to) {
		return st.selectList("ma.getMsgListReceived", msg_to);
	}
	
	public List<PushMsgVO> getMsgListSent(int msg_from) {
		return st.selectList("ma.getMsgListSent", msg_from);
	}

	public void deleteMsgSent(int msg_id) {
		st.update("ma.deleteMsgSent", msg_id);		
	}
	
	public void deleteMsgReceived(int msg_id){
		st.update("ma.deleteMsgReceived", msg_id);
	}

	public void readMsgReceived(int msg_id) {
		st.update("ma.readMsgReceived", msg_id);
	}
	
	public void followMember(Member_actionVO maVo) {
		st.insert("ma.followMember", maVo);
	}
	
	public void followCancel(Member_actionVO maVo){
		st.delete("ma.followCancel", maVo);
	}

	public int followCheck(Member_actionVO maVo) {
		return st.selectOne("ma.followCheck", maVo);
	}

	public List<FriendVO> getFollowingList(int m_id) {
		return st.selectList("ma.getFollowingList", m_id);
	}

	public List<FriendVO> getFollowerList(int m_id) {
		return st.selectList("ma.getFollowerList", m_id);
	}

	public HashMap<String, Integer> friendCnt(int m_id) {
		return st.selectOne("ma.friendCnt", m_id);
	}

	public Object autoCompleteWhoReceive(String m_name) {
		return st.selectList("ma.autoCompleteWhoReceive", m_name);
	}
}
