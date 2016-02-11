package com.mediolio.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MainDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	public String FindNickname(int m_id) {
		return st.selectOne("main.select_m_nickname",m_id);
	}
}
