package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.FriendVO;
import com.mediolio.vo.UserProjectsVO;

/* *****
 * ***** 오지은 작성
 * *****
 * */

@Repository
public class UsermypageDao {
	
	@Autowired
	private SqlSessionTemplate st;

	// id를 기반으로 해당 유저의 정보(이름, 관심분야, 소개, 보유기술 등)를 받아오는 함수
	public FriendVO getMemberInfo(int usr_id) {
		return st.selectOne("userpage.getMemberInfo", usr_id);
	}
	
	// id를 기반으로 해당 유저가 업로드한 프로젝트들을 받아오는 함수
	public List<UserProjectsVO> getProjectsUploaded(int usr_id){
		return st.selectList("userpage.getProjectsUploaded", usr_id);
	}
	
	// id를 기반으로 해당 유저가 좋아요 누른 프로젝트를 받아오는 함수
	public List<UserProjectsVO> getProjectsLiked(int usr_id) {
		return st.selectList("userpage.getProjectsLiked", usr_id);
	}
	
}
