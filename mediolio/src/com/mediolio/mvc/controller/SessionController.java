package com.mediolio.mvc.model;

/*
 * ***** 박성준 작성 class
 * ***** 로그인 세션 확인
 */

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

import com.mediolio.vo.MemberVO;

@Controller
public class SessionModel extends HandlerInterceptorAdapter {
private static final Log log = LogFactory.getLog(SessionModel.class);

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { 
		log.info("session체크");
		HttpSession session  =  request.getSession();
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		System.out.println("로그인 상태");
		if(mev!=null){
			log.info("현재 로그인하려는 m_id = "+mev.getM_id());
		}
		if ( mev == null) {		//session check
			response.sendRedirect("main");
			return false;
		}
		else{
			return true;
		}
	}

	@RequestMapping(value = "logout")
	public ModelAndView logout(HttpSession session) throws Exception{	
		String curTime = new SimpleDateFormat("yyyy/MM/dd/HH:mm").format(new Date());	
		log.info("logout 현재시간 : "+curTime);
		ModelAndView mav = new ModelAndView("redirect:/main");
		session.invalidate();			//session 종료(안에있는 데이터 다삭제)
		System.out.println("로그아웃 성공");
		return mav;		
	}


}


