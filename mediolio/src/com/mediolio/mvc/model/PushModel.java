package com.mediolio.mvc.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.PushDao;

/* *****
 * ***** 오지은 작성
 * *****
 * */

@Controller
public class PushModel {
	
	@Autowired
	private PushDao pdao;
	
	// 새로운 메세지나, 아직 읽지 않은 메세지들 리턴하는 함수
	@RequestMapping("getMsgNotifications")
	public ModelAndView getMsgNotifications(@RequestParam("m_id") String m_id){
		ModelAndView mav = new ModelAndView("jsonView");
		
		mav.addObject("msg", pdao.getMsgNotifications(m_id));
		return mav;
	}
	
	// 새로운 팔로워가 있을 때 팔로워 목록을 리턴하는 함수
	@RequestMapping("getFollowNotifications")
	public ModelAndView getFollowNotifications(@RequestParam("m_id") String m_id){
		ModelAndView mav = new ModelAndView("jsonView");
		
		mav.addObject("msg", pdao.getFollowNotifications(m_id));
		return mav;
	}
	
	// 특정 유저가 올린 글에 새로운 댓글이 달린 경우, 목록을 리턴하는 함수
	@RequestMapping("getReplyNotifications")
	public ModelAndView getReplyNotifications(@RequestParam("m_id") String m_id){
		ModelAndView mav = new ModelAndView("jsonView");

		mav.addObject("msg", pdao.getReplyNotifications(m_id));
		return mav;
	}
}
