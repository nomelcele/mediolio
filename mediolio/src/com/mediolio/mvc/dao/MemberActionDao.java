package com.mediolio.mvc.dao;

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

	public void submitReply(ReplyVO vo, String act_to) {
		//댓글 등록
		st.insert("ma.submitReply", vo);
		
		//push 알림을 위한 member_action 테이블에 등록
		Member_actionVO maVo = new Member_actionVO();
		maVo.setAct_from(vo.getM_id());
		maVo.setAct_to(Integer.parseInt(act_to));
		maVo.setP_id(vo.getP_id());
		maVo.setR_id(vo.getR_id());//방금 reply테이블에 insert된 r_id 값이 ReplyVO에 자동저장됨
		
		st.insert("ma.actionReplySumbitted", maVo);
	}
	
}
