package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.FriendVO;
import com.mediolio.vo.UserProjectsVO;

@Repository
public class UsermypageDao {
	
	@Autowired
	private SqlSessionTemplate st;

	public FriendVO getMemberInfo(int usr_id) {
		return st.selectOne("userpage.getMemberInfo", usr_id);
	}
	public List<UserProjectsVO> getProjectsUploaded(int usr_id){
		return st.selectList("userpage.getProjectsUploaded", usr_id);
	}
	public List<UserProjectsVO> getProjectsLiked(int usr_id) {
		return st.selectList("userpage.getProjectsLiked", usr_id);
	}
	
}
