package com.mediolio.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsermypageDao {
	
	@Autowired
	private SqlSessionTemplate st;

	public Object getMemberInfo(int usr_id) {
		return null;
	}
	
}
