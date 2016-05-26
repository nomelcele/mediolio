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

/*
 * ***** 오지은 작성
 * ***** 
 */

@Repository
public class MemberActionDao {
	@Autowired
	private SqlSessionTemplate st;
	
	//프로젝트 "좋아요" 눌렀을 때
	public int projectLike(Member_actionVO maVo) {
		st.insert("ma.projectLike", maVo); //좋아요 누른 정보 insert
		return st.selectOne("ma.getProjectLike", maVo.getAct_what()); //해당 프로젝트에 대한 총 좋아요 수 리턴
	}

	//프로젝트 "좋아요" 취소
	public void projectLikeCancel(Member_actionVO maVo) {
		st.delete("ma.projectLikeCancel", maVo);
	}
	
	// 메세지 보냄
	public void msgSend(MessageVO vo) {
		st.insert("ma.msgSend", vo);		
	}

	//받은 메세지 목록
	public List<PushMsgVO> getMsgListReceived(int msg_to) {
		return st.selectList("ma.getMsgListReceived", msg_to);
	}
	
	//보낸 메세지 목록
	public List<PushMsgVO> getMsgListSent(int msg_from) {
		return st.selectList("ma.getMsgListSent", msg_from);
	}

	//내가 보낸 메세지를 보낸메세지 목록에서 삭제했을 때
	public void deleteMsgSent(int msg_id) {
		st.update("ma.deleteMsgSent", msg_id);		
	}
	
	//내가 받은 메세지를 받은메세지 목록에서 삭제했을 때
	public void deleteMsgReceived(int msg_id){
		st.update("ma.deleteMsgReceived", msg_id);
	}

	//내가 받은 메세지를 읽었을 때
	public void readMsgReceived(int msg_id) {
		st.update("ma.readMsgReceived", msg_id);
	}
	
	//다른 회원을 팔로우할 때
	public void followMember(Member_actionVO maVo) {
		st.insert("ma.followMember", maVo);
	}
	
	//팔로우 취소
	public void followCancel(Member_actionVO maVo){
		st.delete("ma.followCancel", maVo);
	}

	//나와 다른 회원이 팔로우된 상태인지 확인
	public int followCheck(Member_actionVO maVo) {
		return st.selectOne("ma.followCheck", maVo);
	}

	//어떤 회원의 팔로잉 리스트 리턴
	public List<FriendVO> getFollowingList(int m_id) {
		return st.selectList("ma.getFollowingList", m_id);
	}

	//어떤 회원의 팔로워 리스트 리턴
	public List<FriendVO> getFollowerList(int m_id) {
		return st.selectList("ma.getFollowerList", m_id);
	}

	//팔로잉/팔로워 수 리턴
	public HashMap<String, Integer> friendCnt(int m_id) {
		return st.selectOne("ma.friendCnt", m_id);
	}

	//메세지 받을 대상을 수동입력할 때 자동완성
	public Object autoCompleteWhoReceive(String m_name) {
		return st.selectList("ma.autoCompleteWhoReceive", m_name);
	}
}
