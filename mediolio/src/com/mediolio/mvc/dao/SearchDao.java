package com.mediolio.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.FriendVO;
import com.mediolio.vo.ProjectVO;


/* *****
 * ***** 오지은 작성
 * *****
 * */

@Repository
public class SearchDao {

	@Autowired
	private SqlSessionTemplate st;

	// 해시태그로 검색 시 - 그 해시태그(변수 key)를 가지고 있는 프로젝트 목록들을 리턴
	public List<ProjectVO> searchTag(String key) {
		return st.selectList("search.searchtag", key);
	}

	//과목 검색 - 과목 id(변수 key)를 기반으로, 해당 과목에 관련된 프로젝트 목록 리턴
	public List<ProjectVO> searchSubject(String key) {
		return st.selectList("search.searchSbj", Integer.parseInt(key));
	}
	
	//글 제목으로 검색 시  - 전체 범위에서 또는 특정 카테고리에서 어떤 글 제목을 가진 프로젝트들을 출력
	public List<ProjectVO> searchTitle(Map<String, Object> map) {
		return st.selectList("search.searchTitle", map);
	}

	//홈페이지에 가입한 전체 회원 중에서 어떤 사람을 검색할 때
	public List<FriendVO> searchMemberInTotal(Map<String, Object> map) {
		return st.selectList("search.searchMemberInTotal", map);
	}

	//특정 카테고리에 글을 올린 사람 중에서 어떤 사람을 검색할 때
	public List<FriendVO> searchMemberInCategory(Map<String, Object> map) {
		return st.selectList("search.searchMemberInCategory", map);
	}

	//기술 id(sk_id)에 매칭되는 기술 명을 리턴받는 함수.
	public String getSkillName(String sk_id) {
		return st.selectOne("search.getSkillName", sk_id);
	}

}
