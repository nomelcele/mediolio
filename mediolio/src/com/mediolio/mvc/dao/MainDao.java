package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.BranchVO;
import com.mediolio.vo.CategoryVO;
import com.mediolio.vo.ProjectVO;


/* ***** 박성준 + 
 * ***** 모하람 + 
 * ***** 오지은 작성 class
 * */

@Repository
public class MainDao {
	
	@Autowired
	private SqlSessionTemplate st;
		
	public List<CategoryVO> catelist(){
		return st.selectList("main.catelists");
	}
	
	//박성준 작성 - 로그인한 회원이 "좋아요"를 누른 게시물 리턴
	public List<ProjectVO> likelist(int m_id){
		return st.selectList("main.selectlike",m_id);
	}

	//오지은 작성 - 모든 프로젝트 받아오기 (과제x. 프로젝트 게시물만 출력)
	public List<ProjectVO> getProjectLists() {
		return st.selectList("main.getProjectLists");
	}

	//오지은 작성 - 카테고리 메뉴 클릭 시(과제 목록만 출력)
	public List<ProjectVO> getCertainCategoryList(String category) {
		return st.selectList("main.getCertainCategoryList", category);
	}

	//오지은 작성 - 로그인한 회원의 관심분야 받아오기
	public List<CategoryVO> getInterestingPart(int m_id) {
		return st.selectList("main.getInterestingPart", m_id);
	}
	
	//오지은 작성 - 로그인 한 회원의 관심분야 최신글
	public List<ProjectVO> getNewProject_interest(int category) {
		return st.selectList("main.getNewProject_interest", category);
	}

	//오지은 작성 - 로그인하지 않은 사람의 메인화면 - 각 분야 최신글
	public List<ProjectVO>  getNewProject_visitor(int category) {
		return st.selectList("main.getNewProject_visitor", category);
	}

	//오지은 작성 - 메인에서 최신 글 더 보기 눌렀을 때(과제/프로젝트 모두 포함하여 출력)
	public List<ProjectVO> mainMorePrjs(int category) {
		return st.selectList("main.mainMorePrjs", category);
	}
	
	// 모하람 작성 - 유저가 가장 최근에 업데이트한 히스토리의 브랜치들을 리턴
	public List<BranchVO> recentHistory(int m_id){
		return st.selectList("main.recentHistory", m_id);
	}
	
}
