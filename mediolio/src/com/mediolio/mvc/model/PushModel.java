package com.mediolio.mvc.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.PushDao;

@Controller
public class PushModel {
	
	@Autowired
	private PushDao pdao;
	
	@RequestMapping("getMsgNotifications")
	public ModelAndView getMsgNotifications(@RequestParam("m_id") String m_id){
		ModelAndView mav = new ModelAndView("jsonView");
		
		Map<String, List<Object>> map = pdao.getMsgNotifications(m_id);
		mav.addObject("msg", map.get("msg"));
		mav.addObject("act", map.get("act"));
		return mav;
	}
}
