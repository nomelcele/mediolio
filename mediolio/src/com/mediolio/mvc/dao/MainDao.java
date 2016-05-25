package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.BranchVO;
import com.mediolio.vo.CategoryVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.ProjectVO;

@Repository
public class MainDao {
	
	@Autowired
	private SqlSessionTemplate st;
		
	public List<CategoryVO> catelist(){
		return st.selectList("main.catelists");
	}
	
	public List<ProjectVO> likelist(int m_id){
		return st.selectList("main.selectlike",m_id);
	}

	public List<ProjectVO> getProjectLists() {
		return st.selectList("main.getProjectLists");
	}

	public List<ProjectVO> getCertainCategoryList(String category) {
		return st.selectList("main.getCertainCategoryList", category);
	}

	public List<CategoryVO> getInterestingPart(int m_id) {
		return st.selectList("main.getInterestingPart", m_id);
	}
	
	public List<ProjectVO> getNewProject_interest(int category) {
		return st.selectList("main.getNewProject_interest", category);
	}

	public List<ProjectVO>  getNewProject_visitor(int category) {
		return st.selectList("main.getNewProject_visitor", category);
	}

	public List<ProjectVO> mainMorePrjs(int category) {
		return st.selectList("main.mainMorePrjs", category);
	}
	
	public List<BranchVO> recentHistory(int m_id){
		// 나의 최근 히스토리
		return st.selectList("main.recentHistory", m_id);
	}
	
}
