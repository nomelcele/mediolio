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

/* *****
 * ***** 모하람 작성
 * *****
 * */
@Repository
public class ProjectDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<HashtagVO> autocompleteTags(String h_value){
		// 태그 등록 시, 사용자가 입력한 글자(h_value)가 포함된 태그들의 목록 리턴
		return st.selectList("proj.autocompleteTags",h_value);
	}
	
	public void uploadContent(ContentVO covo){
		// 게시물의 콘텐츠(이미지, 문서, embed 태그, 텍스트) 정보 등록
		st.insert("proj.uploadContent",covo);
	}
	
	public int addProject(ProjectVO pvo){
		// 새로운 게시물 등록 후 게시물의 id를 리턴
		st.insert("proj.addProject", pvo);
		return pvo.getP_id();
	}
	
	public void addHashtag(HashtagVO hvo){
		// 게시물의 태그들 등록
		st.insert("proj.addHashtag", hvo);
	}
	
	public List<MemberVO> autocompleteMember(String m_name){
		// 프로젝트 정보 등록 페이지에서 팀원 추가 시 사용자가 입력한 글자(m_name)가 포함된 회원들의 이름 목록 리턴
		return st.selectList("proj.autocompleteMember", m_name);
	}
	
	public void addProjectInfo(ProjectVO pvo){
		// 프로젝트 정보 추가
		st.update("proj.addProjectInfo", pvo);
	}
	
	public void addTeamMember(TeamMemberVO tmvo){
		// 프로젝트의 팀원 정보 등록
		st.insert("proj.addTeamMember", tmvo);
	}
	
	public List<ProjectVO> userProject(int m_id){
		// 유저가 등록한 게시물 목록 리턴
		return st.selectList("proj.userProject", m_id);
	}
}
