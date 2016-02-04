package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public void insertTest(){
		st.insert("proj.insertTest", 1);
	}
	
	public int selectTest(){
		return st.selectOne("proj.selectTest");
	}
	
}
