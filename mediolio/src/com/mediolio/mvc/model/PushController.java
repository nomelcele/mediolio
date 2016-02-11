package com.mediolio.mvc.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.PushDao;

@Controller
public class PushController {
	
	@Autowired
	private PushDao pdao;
	
	@RequestMapping("getNotifications")
	public ModelAndView getNotifications(@RequestParam("m_id") String m_id){
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<Object> list = pdao.getNotifications(m_id);
		mav.addObject("list", list);
		return mav;
	}
}
