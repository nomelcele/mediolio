package com.mediolio.mvc.model;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UsermypageModel {
	@RequestMapping("/usermypage")
	public ModelAndView gotousermypage(){
		return new ModelAndView("usermypage/usermypage");
	}
}
