package com.mediolio.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.CategoryNameVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.ProjectDetailVO;
import com.mediolio.vo.ReplyVO;

@Repository
public class ProjectDetailDao {
	@Autowired
	private SqlSessionTemplate st;
	
	
	public List<ReplyVO> getReplyList(int p_id) {
		return st.selectList("pd.getReplyList", p_id);
	}

	public ProjectDetailVO projectDetail(Map<String, Integer> map) {
		return st.selectOne("pd.projectDetail", map);
	}

	public List<HashtagVO> projectHash(int p_id) {
		return st.selectList("pd.projectHash", p_id);
	}

	public List<CategoryNameVO> getSubcategoryName(List<String> list) {
		return  st.selectList("pd.getSubcategoryName", list);
	}

	public ReplyVO submitReply(ReplyVO vo, String act_to) {
		//댓글 등록
		st.insert("pd.submitReply", vo);
		
		//push 알림을 위한 member_action 테이블에 등록
		Member_actionVO maVo = new Member_actionVO();
		maVo.setAct_from(vo.getM_id());
		maVo.setAct_to(Integer.parseInt(act_to));
		maVo.setP_id(vo.getP_id());
		
		int insertedR_id = vo.getR_id();
		maVo.setR_id(insertedR_id);//방금 reply테이블에 insert된 r_id 값이 ReplyVO에 자동저장됨
		
		st.insert("pd.actionReplySumbitted", maVo);
		return st.selectOne("pd.selectInsertedReply", insertedR_id);
	}

	public void deleteReply(int r_id) {
		st.delete("pd.deleteReply", r_id);
		st.delete("pd.actionDeleteReply", r_id);
	}
}
