package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.MessageVO;
import com.mediolio.vo.ReplyVO;

@Repository
public class MemberActionDao {
	@Autowired
	private SqlSessionTemplate st;

	public void msgSend(MessageVO vo) {
		st.insert("ma.msgSend", vo);		
	}

	public List<MessageVO> getMsgList(int m_id) {
		return st.selectList("ma.getMsgList", m_id);
	}
	
	public int projectLike(Member_actionVO maVo) {
		st.insert("ma.projectLike", maVo);
		return st.selectOne("ma.getProjectLike", maVo.getP_id());
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

	public void projectLikeCancel(Member_actionVO maVo) {
		st.delete("ma.projectLikeCancel", maVo);
	}

	public ReplyVO submitReply(ReplyVO vo, String act_to) {
		//댓글 등록
		st.insert("ma.submitReply", vo);
		
		//push 알림을 위한 member_action 테이블에 등록
		Member_actionVO maVo = new Member_actionVO();
		maVo.setAct_from(vo.getM_id());
		maVo.setAct_to(Integer.parseInt(act_to));
		maVo.setP_id(vo.getP_id());
		
		int insertedR_id = vo.getR_id();
		maVo.setR_id(insertedR_id);//방금 reply테이블에 insert된 r_id 값이 ReplyVO에 자동저장됨
		
		st.insert("ma.actionReplySumbitted", maVo);
		return st.selectOne("ma.selectInsertedReply", insertedR_id);
	}

	public void deleteReply(int r_id) {
		st.delete("ma.deleteReply", r_id);
		st.delete("ma.actionDeleteReply", r_id);
	}

	public List<ReplyVO> getReplyList(int p_id) {
		return st.selectList("ma.getReplyList", p_id);
	}

}
