package com.mediolio.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.MainDao;



@Controller
public class MainModel {
	
	@Autowired
	private MainDao mdao;
	
	@RequestMapping(value={"","main"})
	public ModelAndView main(HttpSession session){
		ModelAndView mav = new ModelAndView("main/index");
		int id = 0;
		String nickname="";
		try{
			id = (int) session.getAttribute("id");
			nickname = mdao.FindNickname(id);
		}catch(Exception e){
			id=0;
			nickname="";
		}
		
		System.out.println("id : " + id);
		System.out.println("nickname :"+ nickname);
		mav.addObject("m_id", id);
		mav.addObject("m_nickname",nickname);
		return mav;
	}
}
