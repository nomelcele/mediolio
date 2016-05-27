package com.mediolio.mvc.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.ProjectDetailDao;
import com.mediolio.vo.ContentVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ReplyVO;


/* *****
 * ***** 오지은 + 모하람 작성 class
 * *****
 * */

@Controller
public class ProjectDetailModel {
	@Autowired
	private ProjectDetailDao pddao;
	
	// 게시물(프로젝트/과제) 상세 보기 페이지(projectView.jsp)를 여는 함수
	@RequestMapping("projectView")
	public String projectView(Model model, @RequestParam("p_id") String p_id, @RequestParam("m_id") String m_id, HttpSession session){
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("p_id", Integer.parseInt(p_id)); 
		map.put("p_m_id", Integer.parseInt(m_id)); //게시물 작성자 m_id
		
		if(mev!=null){
			map.put("m_id", mev.getM_id()); //로그인 한 사람의 m_id
		}else{
			map.put("m_id", 0);
		}
		
		// 모하람 작성 - 해당 게시물에 포함된 콘텐츠(이미지/문서/텍스트/embed 태그 등)
		List<ContentVO> contents = pddao.projectContents(Integer.parseInt(p_id));
		model.addAttribute("contents", contents);

		// 모하람 작성 - 조회수 증가(자기가 올린 게시물이 아닌 경우)
		if(Integer.parseInt(m_id) != map.get("m_id").intValue()){
			pddao.increaseHits(Integer.parseInt(p_id));
		}
		
		int pid = Integer.parseInt(p_id);
		// 오지은 작성 - 게시물 관련 정보 -  타이틀, 카테고리, 작업정보,  좋아요수 등
		model.addAttribute("detail", pddao.projectDetailRelatedProject(pid));
				
		// 오지은 작성 - 게시물 작성자 정보 - 이름, 관심분야, 좋아요 여부 등
		model.addAttribute("writer", pddao.projectDetailRelatedMember(map));
		
		// 오지은 작성 - 댓글목록
		model.addAttribute("reply", pddao.getReplyList(pid));
		
		// 오지은 작성 - 해쉬태그
		model.addAttribute("tag", pddao.projectHash(pid));
		
		// 오지은 작성 - 팀원 정보
		model.addAttribute("team", pddao.getTeamMember(pid));
		return "project/projectView";
	}

	//오지은 작성 - 댓글 업로드
	@RequestMapping("submitReply")
	public ModelAndView submitReply(ReplyVO vo, @RequestParam("act_to") String act_to, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){			
			vo.setM_id(mev.getM_id());
			mav.addObject("reply", pddao.submitReply(vo, act_to));
		}
		return mav;
	}
	
	//오지은 작성 - 댓글 삭제
	@RequestMapping("deleteReply")
	public ModelAndView deleteReply(@RequestParam("r_id") String r_id){
		ModelAndView mav = new ModelAndView("jsonView");
		pddao.deleteReply(Integer.parseInt(r_id));	
		return mav;
	}
}
