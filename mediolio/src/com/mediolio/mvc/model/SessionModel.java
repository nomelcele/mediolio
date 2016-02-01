package com.mediolio.mvc.model;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Controller
public class SessionModel extends HandlerInterceptorAdapter {
private static final Log log = LogFactory.getLog(SessionModel.class);

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { 
		log.info("session체크");
		HttpSession session  =  request.getSession();
		//int m_id = (int)session.getAttribute("id");
		System.out.println("로그인 상태");
		//log.info("현재 로그인하려는 m_id = "+m_id);
		log.info("현재 로그인하려는 m_id = "+session.getAttribute("id"));
		if ( session.getAttribute("id") == null) {		//session check
			response.sendRedirect("menu=login");
			return false;
		}
		else{
			return true;
		}
	}
/*	@RequestMapping(value = "/logout")
	public String logout(HttpSession session){	
		String curTime = new SimpleDateFormat("yyyy/MM/dd/HH:mm").format(new Date());	
		log.info("logout 현재시간 : "+curTime);
		session.invalidate();			//session 종료(안에있는 데이터 다삭제)
		System.out.println("로그아웃 성공");
		return "redirect:menu=nonlogin";
	}*/
	@RequestMapping(value = "logout")
	public ModelAndView logout(HttpSession session) throws Exception{	
		String curTime = new SimpleDateFormat("yyyy/MM/dd/HH:mm").format(new Date());	
		log.info("logout 현재시간 : "+curTime);
		ModelAndView mav = new ModelAndView("redirect:/menu=nonlogin");
		session.invalidate();			//session 종료(안에있는 데이터 다삭제)
		System.out.println("로그아웃 성공");
		return mav;		
	}


}


