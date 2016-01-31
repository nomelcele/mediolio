package com.mediolio.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.MemberVO;

@Repository
public class JoinDao {
	
	private SqlSessionTemplate st;
	
	public int InsertJoinInfo(MemberVO mevo){
		// 회원가입 정보삽입
		st.insert("join.InsertJoinInfo", mevo);
		return st.selectOne("join.select_m_id");
	}
	
	public String DoubleInfo(String m_mail) {
		return st.selectOne("join.doubleInfo",m_mail);
	}
}
