package com.mediolio.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.MemberSkillVO;
import com.mediolio.vo.MemberVO;




@Repository
public class JoinDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	public int InsertJoinInfo(MemberVO mevo){
		// 회원가입 정보삽입
		st.insert("join.InsertJoinInfo", mevo);
		return st.selectOne("join.select_m_id");
	}
	
	public int InsertSkillInfo(MemberSkillVO mkvo){
		// 관련기술 삽입
		st.insert("join.InsertSkillInfo", mkvo);
		return st.selectOne("join.select_m_id");
	}
	
	public String DoubleInfo(String m_mail) {
		return st.selectOne("join.doubleInfo",m_mail);
	}
	
	public MemberVO LoginInfo(String m_mail) {
		return st.selectOne("join.loginIdentify",m_mail);
	}
	
	public void sendEmailAction (MemberVO mevo){
		st.update("join.sendpw",mevo);
	}
}
