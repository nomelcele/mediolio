package com.mediolio.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.MemberSkillVO;
import com.mediolio.vo.MemberVO;

/*
 * ***** 박성준 작성 class
 * ***** 회원가입 정보, 아이디 중복검사, 로그인 정보, 임시 비밀번호 전송
 */


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
		// 중복검사
		return st.selectOne("join.doubleInfo",m_mail);
	}
	
	public MemberVO LoginInfo(String m_mail) {
		// 회원정보
		return st.selectOne("join.loginIdentify",m_mail);
	}
	
	public void sendEmailAction (MemberVO mevo){
		//임시 비밀번호로 변경
		st.update("join.sendpw",mevo);
	}
}
