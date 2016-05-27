package com.mediolio.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mediolio.vo.ContentVO;
import com.mediolio.vo.FriendVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.ProjectDetailVO;
import com.mediolio.vo.ReplyVO;
import com.mediolio.vo.TeamMemberVO;

/* *****
 * ***** 오지은 + 모하람 작성 class
 * *****
 * */

@Repository
public class ProjectDetailDao {
	@Autowired
	private SqlSessionTemplate st;
	
	// 오지은 작성 - 댓글목록 리턴
	public List<ReplyVO> getReplyList(int p_id) {
		return st.selectList("pd.getReplyList", p_id);
	}

	// 오지은 작성 - 프로젝트 관련 정보 리턴- 프로젝트 타이틀, 카테고리, 작업정보,  좋아요수 등
	public ProjectDetailVO projectDetailRelatedProject(int p_id) {
		return st.selectOne("pd.projectDetailRelatedProject", p_id);
	}

	// 오지은 작성 - 프로젝트 작성자 정보 리턴 - 이름, 관심분야, 좋아요 여부 등
	public FriendVO projectDetailRelatedMember(Map<String, Integer> map) {
		return st.selectOne("pd.projectDetailRelatedMember", map);
	}
	
	// 오지은 작성 - 해쉬태그 리턴
	public List<HashtagVO> projectHash(int p_id) {
		return st.selectList("pd.projectHash", p_id);
	}

	//오지은 작성 - 댓글 업로드
	public ReplyVO submitReply(ReplyVO vo, String act_to) {
		//댓글 등록
		vo.setR_text(vo.getR_text().replaceAll("\r\n", "<br>"));
		//먼저 Reply 테이블에 등록
		st.insert("pd.submitReply", vo);
		
		//push 알림을 위한 member_action 테이블에 등록
		Member_actionVO maVo = new Member_actionVO();
		maVo.setAct_from(vo.getM_id());
		maVo.setAct_to(Integer.parseInt(act_to));
				
		int insertedR_id = vo.getR_id();
		maVo.setAct_what(insertedR_id);//방금 reply테이블에 insert된 r_id 값이 ReplyVO에 자동저장됨
		
		//두번째로 Member_Action 테이블에 등록
		st.insert("pd.actionReplySumbitted", maVo);
		
		//현재 등록한 댓글 리턴
		return st.selectOne("pd.selectInsertedReply", insertedR_id);
	}

	// 오지은 작성 - 댓글 삭제
	public void deleteReply(int r_id) {
		st.delete("pd.deleteReply", r_id); //Reply 테이블에서 삭제
		st.delete("pd.actionDeleteReply", r_id); //Member_Action 테이블에서 삭제
	}
	
	// 모하람 작성 - 해당 프로젝트 id에 포함된 콘텐츠 목록(영상, 문서, 이미지, 텍스트) 리턴
	public List<ContentVO> projectContents(int p_id){
		return st.selectList("pd.projectContents", p_id);
	}
	
	// 모하람 작성 - 조횟수 업데이트
	public void increaseHits(int p_id){
		st.update("pd.increaseHits",p_id);
	}

	// 오지은 작성 - 해당 프로젝트에 관련된 팀원 목록 리턴
	public List<TeamMemberVO> getTeamMember(int p_id) {
		return st.selectList("pd.getTeamMember", p_id);
	}

}
