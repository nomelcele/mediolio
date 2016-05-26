package com.mediolio.mvc.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.UsermypageDao;
import com.mediolio.vo.FriendVO;

/* *****
 * ***** 오지은 작성
 * *****
 * */

@Controller
public class UsermypageModel {
	
	@Autowired
	private UsermypageDao udao;
	
	//usermypage로 이동하는 함수. 
	//해당 유저의 정보, 그 유저가 업로드한 프로젝트 정보들, 그 유저가 좋아하는 프로젝트 정보들을 들고 이동
	@RequestMapping("/userpage")
	public ModelAndView gotousermypage(@RequestParam("usr_id") String m_id){
		ModelAndView mav = new ModelAndView("usermypage/usermypage");
		
		int usr_id = Integer.parseInt(m_id);
		FriendVO vo = udao.getMemberInfo(usr_id);
		mav.addObject("memberInfo", vo);
		mav.addObject("myProjects", udao.getProjectsUploaded(usr_id));
		mav.addObject("likeProjects", udao.getProjectsLiked(usr_id));
		return mav;
	}
}
