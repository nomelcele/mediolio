package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.ProjectVO;

@Repository
public class MainDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	public String FindNickname(int m_id) {
		return st.selectOne("main.select_m_nickname",m_id);
	}
	
	public List<ProjectVO> mainProjects(){
		return st.selectList("main.mainProjects");
	}
	
	public List<HashtagVO> projectHashtags(int p_id){
		return st.selectList("main.projectHashtags",p_id);
	}
}
