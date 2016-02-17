package com.mediolio.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UsermypageModel {
	@RequestMapping("/userpage")
	public ModelAndView gotousermypage(@RequestParam("m_id") String m_id){
		ModelAndView mav = new ModelAndView("usermypage/usermypage");
		
		
		return mav;
	}
}
