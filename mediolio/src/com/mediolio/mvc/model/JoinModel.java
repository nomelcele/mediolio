package com.mediolio.mvc.model;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.email.Email;
import com.mediolio.email.EmailSender;
import com.mediolio.mvc.dao.JoinDao;
import com.mediolio.vo.MemberSkillVO;
import com.mediolio.vo.MemberVO;
/*
 * ***** 박성준 작성 class
 * ***** 로그인 및 회원가입, 임시비밀번호 전송
 */



@Controller
public class JoinModel {

	@Autowired
	private JoinDao jdao;
	@Autowired
	private EmailSender emailSender;
	@Autowired
	private Email email;

	@RequestMapping(value="InsertJoinInfo", method = RequestMethod.POST)
	public ModelAndView InsertJoinInfo(MemberVO mevo, HttpSession session){
		// 회원가입
		System.out.println(mevo.getM_id());
		System.out.println(mevo.getM_mail());
		System.out.println(mevo.getM_pw());
		System.out.println(mevo.getM_gender());
		System.out.println(mevo.getM_interesting1());
		System.out.println(mevo.getM_interesting2());
		System.out.println(mevo.getM_joindate());
		ModelAndView mav = new ModelAndView("jsonView");
		int insertedJoininfo = jdao.InsertJoinInfo(mevo);
		mav.addObject("m_id", insertedJoininfo);
		MemberVO selectedPw = jdao.LoginInfo(mevo.getM_mail());
		if(insertedJoininfo!=0){
			session.setAttribute("mev",selectedPw);
		}
		return mav;
	}
	
	@RequestMapping(value="InsertSkillInfo", method = RequestMethod.POST)
	public ModelAndView InsertSkillInfo(MemberSkillVO mkvo, HttpSession session){
		// 관련기술 입력
		System.out.println(mkvo.getM_id());

		ModelAndView mav = new ModelAndView("jsonView");
		int insertedSkillinfo = jdao.InsertSkillInfo(mkvo);
		mav.addObject("m_id", insertedSkillinfo);
		return mav;
	}
	
	@RequestMapping(value = "DoubleInfo")
	public ModelAndView DoubleInfo(String m_mail){
		//중복검사
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
		//회원정보 조회
		ModelAndView mav = new ModelAndView("jsonView");
		MemberVO selectedPw = jdao.LoginInfo(m_mail);
		if(selectedPw!=null){
			mav.addObject("m_pw", selectedPw.getM_pw());
			mav.addObject("m_id", selectedPw.getM_id());
			if(selectedPw.getM_pw().equals(pw)){
				session.setAttribute("mev",selectedPw);
			}
			return mav;
		}
		else{
			mav.addObject("m_id", null);
			mav.addObject("m_pw","0");
			return mav;
		}
	}
	
	@RequestMapping("sendEmailAction")
    public ModelAndView sendEmailAction (String m_mail) throws Exception {
		//임시 비밀번호 변경
        ModelAndView mav = new ModelAndView("jsonView");
        MemberVO selectedPw = new MemberVO();
        selectedPw.setM_mail(m_mail);
        StringBuffer buffer = new StringBuffer();
        Random random = new Random();
        String chars[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9".split(",");    		
        for (int i = 0; i < 6; i++) {
        buffer.append(chars[random.nextInt(chars.length)]);
        }
        selectedPw.setM_pw(buffer.toString());
        jdao.sendEmailAction(selectedPw);
        mav.addObject("m_pw", buffer.toString());
        String id=m_mail;
        String pw=selectedPw.getM_pw();
        System.out.println(pw);
        email.setContent("비밀번호는 "+pw+" 입니다.");
        email.setReceiver(m_mail);
        email.setSubject(id+"님 비밀번호 찾기 메일입니다.");
        emailSender.SendEmail(email);
        return mav;
    }
}
