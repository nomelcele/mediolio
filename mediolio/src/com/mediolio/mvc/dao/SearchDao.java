package com.mediolio.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.HashtagVO;

@Repository
public class SearchDao {

	@Autowired
	private SqlSessionTemplate st;

	public List<Object> searchTag(String key) {
		return st.selectList("search.searchtag", key);
	}

	public List<Object> searchSubject(String key) {
		return st.selectList("search.searchSbj", Integer.parseInt(key));
	}

	public List<Object> searchTitle(Map<String, Object> map) {
		return st.selectList("search.searchTitle", map);
	}

	public List<Object> searchMemberInTotal(Map<String, Object> map) {
		return st.selectList("search.searchMemberInTotal", map);
	}

	public List<Object> searchMemberInCategory(Map<String, Object> map) {
		return st.selectList("search.searchMemberInCategory", map);
	}

	public List<HashtagVO> getHashList(List<Object> list) {
		return st.selectList("search.getHashList", list);
	}

}
