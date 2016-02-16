package com.mediolio.mvc.model;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.MainDao;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectVO;
import com.mediolio.vo.SubcategoryVO;



@Controller
public class MainModel {
	
	@Autowired
	private MainDao mdao;
	
	@RequestMapping(value={"","main"})
	public ModelAndView main(HttpSession session){
/*		ModelAndView mav = new ModelAndView("main/index");
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
		return mav;*/
		ModelAndView mav = new ModelAndView("main/index");		
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
		System.out.println("id : " +mev.getM_id());
		System.out.println("nickname : "+mev.getM_nickname());
		}
		
		mav.addObject("mainProjects", mdao.mainProjects());
		mav.addObject("hashtag", mdao.projectHashtags());
		mav.addObject("subcategory",mdao.subcatelist());
		mav.addObject("category",mdao.catelist());
		/*List<SubcategoryVO> list = mdao.subcatelist();
		System.out.println(list.get(1).getSc_name());*/
		return mav;
	}
}
