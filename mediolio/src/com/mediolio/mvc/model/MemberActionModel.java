package com.mediolio.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.MemberActionDao;
import com.mediolio.vo.Member_actionVO;
import com.mediolio.vo.MessageVO;

/*
 * Member Action : 쪽지 보내기, 좋아요, 팔로우, 푸쉬알림
 */
@Controller
public class MemberActionModel {
	@Autowired
	private MemberActionDao maDao;
	
	//쪽지 보내기
	@RequestMapping("msgSend")
	public ModelAndView msgSend(MessageVO vo, HttpSession session){
		vo.setMsg_from((int)session.getAttribute("id"));
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("메세지내용 : " + vo.getMsg_text() + ", from~to : " + vo.getMsg_from() + ", " + vo.getMsg_to());
		maDao.msgSend(vo);
		return mav;
	}
	
	//프로젝트 좋아요
	@RequestMapping("projectLike")
	public ModelAndView projectLike(@RequestParam("p_id") String p_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		System.out.println("projectID : " + p_id +", m_id : " + (int)session.getAttribute("id"));
		
		Member_actionVO maVo = new Member_actionVO();
		maVo.setM_id((int)session.getAttribute("id"));
		maVo.setAct_target(Integer.parseInt(p_id));
		
		//좋아요 수 추가 & 현재 프로젝트의 좋아요 수 받아오기
		mav.addObject("likeNum", maDao.projectLike(maVo));
		return mav;
	}
	
	//프로젝트 좋아요 취소
	@RequestMapping("projectLikeCancel")
	public ModelAndView projectLikeCancel(@RequestParam("p_id") String p_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
				
		Member_actionVO maVo = new Member_actionVO();
		maVo.setM_id((int)session.getAttribute("id"));
		maVo.setAct_target(Integer.parseInt(p_id));
		
		maDao.projectLikeCancel(maVo);
		return mav;
	}
	
	//팔로우하기
	@RequestMapping("followMember")
	public ModelAndView followMember(@RequestParam("m_id") String m_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("m_id to follow : " + m_id +", my m_id : " + (int)session.getAttribute("id"));
		
		Member_actionVO maVo = new Member_actionVO();
		maVo.setM_id((int)session.getAttribute("id"));
		maVo.setAct_target(Integer.parseInt(m_id));
		maDao.followMember(maVo);
		return mav;
	}
	
	//팔로우 취소
	@RequestMapping("followCancel")
	public ModelAndView followCancel(@RequestParam("m_id") String m_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("m_id to unfollow : " + m_id +", my m_id : " + (int)session.getAttribute("id"));
		
		Member_actionVO maVo = new Member_actionVO();
		maVo.setM_id((int)session.getAttribute("id"));
		maVo.setAct_target(Integer.parseInt(m_id));
		maDao.followCancel(maVo);
		return mav;
	}
	
	//팔로우 여부 체크
	@RequestMapping("followCheck")
	public ModelAndView followCheck(@RequestParam("m_id") String m_id, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		int myId = (int)session.getAttribute("id");
		
		Member_actionVO maVo = new Member_actionVO();
		maVo.setM_id(myId);
		maVo.setAct_target(Integer.parseInt(m_id));
		
		//팔로우된 row가 있는지 체크
		int isFollow = maDao.followCheck(maVo);
		System.out.println("isFollowed : " + isFollow);
		if(isFollow>0){
			//팔로우 됨
			mav.addObject("isFollowed", "y");
		}else{
			mav.addObject("isFollowed", "n");
		}
		return mav;
	}
}
