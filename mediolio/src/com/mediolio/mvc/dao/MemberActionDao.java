package com.mediolio.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.MessageVO;

@Repository
public class MemberActionDao {
	@Autowired
	private SqlSessionTemplate st;

	public void msgSend(MessageVO vo) {
		st.insert("ma.msgSend", vo);		
	}

	public int projectLike(Member_actionVO maVo) {
		st.insert("ma.projectLike", maVo);
		return st.selectOne("ma.getProjectLike", maVo.getAct_target());
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
	
}
