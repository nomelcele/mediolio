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

@Controller
public class ProjectDetailModel {
	@Autowired
	private ProjectDetailDao pddao;
	
	@RequestMapping("projectView")
	public String projectView(Model model, @RequestParam("p_id") String p_id, @RequestParam("m_id") String m_id, HttpSession session){
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("p_id", Integer.parseInt(p_id)); 
		map.put("p_m_id", Integer.parseInt(m_id)); //프로젝트 작성자 m_id
		
		if(mev!=null){
			map.put("m_id", mev.getM_id()); //로그인 한 사람의 m_id
		}else{
			map.put("m_id", 0);
		}
		
		// 프로젝트 콘텐츠
		List<ContentVO> contents = pddao.projectContents(Integer.parseInt(p_id));
		model.addAttribute("contents", contents);

		
		// 조회수 증가(자기가 올린 프로젝트가 아닌 경우)
		if(Integer.parseInt(m_id) != map.get("m_id").intValue()){
			pddao.increaseHits(Integer.parseInt(p_id));
		}
		
		int pid = Integer.parseInt(p_id);
		//프로젝트 관련 정보 - 프로젝트 타이틀, 카테고리, 작업정보,  좋아요수 등
		model.addAttribute("detail", pddao.projectDetailRelatedProject(p_id));
				
		//프로젝트 작성자 정보 - 이름, 관심분야, 좋아요 여부 등
		model.addAttribute("writer", pddao.projectDetailRelatedMember(map));
		
		//댓글목록
		model.addAttribute("reply", pddao.getReplyList(pid));
		
		//해쉬태그
		model.addAttribute("tag", pddao.projectHash(pid));
		
		//팀원 정보
		model.addAttribute("team", pddao.getTeamMember(pid));
		return "project/projectView";
	}

	//댓글 달기
	@RequestMapping("submitReply")
	public ModelAndView submitReply(ReplyVO vo, @RequestParam("act_to") String act_to, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){			
			vo.setM_id(mev.getM_id());
			mav.addObject("reply", pddao.submitReply(vo, act_to));
			System.out.println("댓글 내용 : " + vo.getR_text() + ", projectID : " + vo.getP_id() + ", m_id : " + vo.getM_id());
		}
		return mav;
	}
	
	//댓글 삭제
	@RequestMapping("deleteReply")
	public ModelAndView deleteReply(@RequestParam("r_id") String r_id){
		ModelAndView mav = new ModelAndView("jsonView");
		pddao.deleteReply(Integer.parseInt(r_id));	
		return mav;
	}
}
