package com.mediolio.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.UsermypageDao;
import com.mediolio.vo.FriendVO;

@Controller
public class UsermypageModel {
	
	@Autowired
	private UsermypageDao udao;
	
	@RequestMapping("/userpage")
	public ModelAndView gotousermypage(@RequestParam("usr_id") String m_id){
		ModelAndView mav = new ModelAndView("usermypage/usermypage");
		
		int usr_id = Integer.parseInt(m_id);
		FriendVO vo = udao.getMemberInfo(usr_id);
		mav.addObject("memberInfo", vo);
		mav.addObject("myProjects", udao.getProjectsUploaded(usr_id));
		mav.addObject("likeProjects", udao.getProjectsLiked(usr_id));
		System.out.println("끝");
		return mav;
	}
}
