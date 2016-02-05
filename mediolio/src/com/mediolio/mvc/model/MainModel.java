package com.mediolio.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MainModel {
	@RequestMapping(value={"","main"})
	public ModelAndView main(HttpSession session){
		ModelAndView mav = new ModelAndView("main/index");
		int id = 0;
		try{
			id = (int) session.getAttribute("id");
		}catch(Exception e){
			id=0;
		}
		System.out.println("id : " + id);
		mav.addObject("m_id", id);
		return mav;
	}
}
