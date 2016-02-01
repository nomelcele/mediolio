package com.mediolio.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.JoinDao;
import com.mediolio.vo.MemberVO;


@Controller
public class JoinModel {

	@Autowired
	private JoinDao jdao;
	
	@RequestMapping("/menu=login")
	public ModelAndView gotoLogin(){
		return new ModelAndView("/login/login");
	}
	@RequestMapping("/menu=password")
	public ModelAndView gotoPassword(){
		return new ModelAndView("/login/password");
	}
	@RequestMapping("/menu=join")
	public ModelAndView gotoJoin(){
		return new ModelAndView("/login/join");
	}
	@RequestMapping("/menu=loginsuccess")
	public ModelAndView gotoTestmain(){
		return new ModelAndView("/login/loginsuccess");
	}
/*	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("redirect:menu=nonlogin");
		session.invalidate();
		return mav;
	}*/
	@RequestMapping("/menu=nonlogin")
	public ModelAndView gotoTestnonlogin(){
		return new ModelAndView("/login/nonlogin");
	}
	
	@RequestMapping(value="InsertJoinInfo", method = RequestMethod.POST)
	public ModelAndView InsertJoinInfo(MemberVO mevo, HttpSession session){
		// 회원가입
		//int m_id= acvo.getM_id();
		System.out.println(mevo.getM_id());
		System.out.println(mevo.getM_mail());
		System.out.println(mevo.getM_pw());
		System.out.println(mevo.getM_gender());
		System.out.println(mevo.getM_joindate());
		ModelAndView mav = new ModelAndView("jsonView");
		int insertedJoininfo = jdao.InsertJoinInfo(mevo);
		mav.addObject("m_id", insertedJoininfo);
		if(insertedJoininfo!=0){
			session.setAttribute("id", insertedJoininfo);
			session.setAttribute("pw", mevo.getM_pw());
		}
		return mav;
	}
	
	@RequestMapping(value = "DoubleInfo")
	public ModelAndView DoubleInfo(String m_mail){
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println(m_mail);
		String Isdouble = jdao.DoubleInfo(m_mail);
		if(Isdouble==null){
			Isdouble = "0";
		}
		mav.addObject("m_id", Isdouble);
		return mav;
	}
	
	@RequestMapping(value = "LoginInfo")
	public ModelAndView LoginInfo(String m_mail, String pw, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		MemberVO selectedPw = jdao.LoginInfo(m_mail);
		//System.out.println(selectedPw);
		if(selectedPw!=null){
			mav.addObject("m_pw", selectedPw.getM_pw());
			mav.addObject("m_id", selectedPw.getM_id());
			if(selectedPw.getM_pw().equals(pw)){
				session.setAttribute("id", selectedPw.getM_id());
				session.setAttribute("pw", pw);
			}
			return mav;
		}
		else{
			mav.addObject("m_id", null);
			mav.addObject("m_pw","0");
			return mav;
		}
	}
}
