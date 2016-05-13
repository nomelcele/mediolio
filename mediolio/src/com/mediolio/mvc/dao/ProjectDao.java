package com.mediolio.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.ContentVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectVO;
import com.mediolio.vo.TeamMemberVO;

@Repository
public class ProjectDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<HashtagVO> autocompleteTags(String h_value){
		return st.selectList("proj.autocompleteTags",h_value);
	}
	
	public void uploadContent(ContentVO covo){
		st.insert("proj.uploadContent",covo);
	}
	
	public int addProject(ProjectVO pvo){
		st.insert("proj.addProject", pvo);
		return pvo.getP_id();
	}
	
	public void addHashtag(HashtagVO hvo){
		st.insert("proj.addHashtag", hvo);
	}
	
	public List<MemberVO> autocompleteMember(String m_name){
		// 팀원 추가 시 학생 이름 자동 완성
		return st.selectList("proj.autocompleteMember", m_name);
	}
	
	public void addProjectInfo(ProjectVO pvo){
		// 프로젝트 정보 추가
		st.update("proj.addProjectInfo", pvo);
	}
	
	public void addTeamMember(TeamMemberVO tmvo){
		// 팀원 소개 추가
		st.insert("proj.addTeamMember", tmvo);
	}
}
