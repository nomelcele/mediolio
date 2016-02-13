package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.ProjectDetailVO;
import com.mediolio.vo.ReplyVO;

@Repository
public class ProjectDetailDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<ReplyVO> getReplyList(int p_id) {
		return st.selectList("pd.getReplyList", p_id);
	}

	public ProjectDetailVO projectDetail(int p_id) {
		return st.selectOne("pd.projectDetail", p_id);
	}

	public List<HashtagVO> projectHash(int p_id) {
		return st.selectList("pd.projectHash", p_id);
	}
}
