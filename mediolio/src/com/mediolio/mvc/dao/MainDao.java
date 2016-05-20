package com.mediolio.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.CategoryVO;
import com.mediolio.vo.FriendVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.ProjectVO;

@Repository
public class MainDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	public String FindNickname(int m_id) {
		return st.selectOne("main.select_m_nickname",m_id);
	}
	
	public List<HashtagVO> projectHashtags(){
		return st.selectList("main.projectHashtags");
	}
	
	public List<CategoryVO> catelist(){
		return st.selectList("main.catelists");
	}
	
	public List<ProjectVO> likelist(int m_id){
		System.out.println("likelist");
		return st.selectList("main.selectlike",m_id);
	}

	public List<ProjectVO> getProjectLists() {
		return st.selectList("main.getProjectLists");
	}

	public List<ProjectVO> getCertainCategoryList(String category) {
		return st.selectList("main.getCertainCategoryList", category);
	}

	
}
