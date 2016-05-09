package com.mediolio.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.FriendVO;
import com.mediolio.vo.ProjectVO;

@Repository
public class SearchDao {

	@Autowired
	private SqlSessionTemplate st;

	public List<ProjectVO> searchTag(String key) {
		return st.selectList("search.searchtag", key);
	}

	public List<ProjectVO> searchSubject(String key) {
		return st.selectList("search.searchSbj", Integer.parseInt(key));
	}

	public List<ProjectVO> searchTitle(Map<String, Object> map) {
		return st.selectList("search.searchTitle", map);
	}

	public List<FriendVO> searchMemberInTotal(Map<String, Object> map) {
		return st.selectList("search.searchMemberInTotal", map);
	}

	public List<FriendVO> searchMemberInCategory(Map<String, Object> map) {
		return st.selectList("search.searchMemberInCategory", map);
	}
}
