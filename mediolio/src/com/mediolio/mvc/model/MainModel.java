package com.mediolio.mvc.model;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.MainDao;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectVO;
import com.mediolio.vo.SubcategoryVO;



@Controller
public class MainModel {
	
	private String cat="0";
	
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
		cat="0";
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
		mav.addObject("selcat", cat);
		/*List<SubcategoryVO> list = mdao.subcatelist();
		System.out.println(list.get(1).getSc_name());*/
		return mav;
	}
	
	@RequestMapping("selcatcard")
	public String selcatcard(HttpSession session, Model model, @RequestParam("selcat") String selcat){
		if(selcat.equals("게임기획")){
			cat="1";
		}
		else if(selcat.equals("게임개발")){
			cat="2";
		}
		else if(selcat.equals("웹기획")){
			cat="9";
		}
		else if(selcat.equals("웹개발")){
			cat="10";
		}
		else if(selcat.equals("시나리오")){
			cat="3";
		}
		else if(selcat.equals("연출")){
			cat="4";
		}
		else if(selcat.equals("촬영")){
			cat="5";
		}
		else if(selcat.equals("OAP")){
			cat="6";
		}
		else if(selcat.equals("모델링")){
			cat="7";
		}
		else if(selcat.equals("애니메이션")){
			cat="8";
		}
		else if(selcat.equals("DESIGN")){
			cat="11";
		}
		else if(selcat.equals("COMPUTER GRAPHICS")){
			cat="12";
		}
		else if(selcat.equals("SOUND")){
			cat="13";
		}
		else{
			cat="100";
		}
		System.out.println(cat);
		ModelAndView mav = new ModelAndView("main/index");		
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
		System.out.println("id : " +mev.getM_id());
		System.out.println("nickname : "+mev.getM_nickname());
		}
		
		model.addAttribute("mainProjects", mdao.mainProjects());
		model.addAttribute("hashtag", mdao.projectHashtags());
		model.addAttribute("subcategory",mdao.subcatelist());
		model.addAttribute("category",mdao.catelist());
		model.addAttribute("selcat", cat);
		return "main.selectcategory";
	}
	
	@RequestMapping("selectmypage")
	public String selectmypage(HttpSession session, Model model){
		ModelAndView mav = new ModelAndView("main/index");		
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
		System.out.println("id : " +mev.getM_id());
		System.out.println("nickname : "+mev.getM_nickname());
		}
		
		model.addAttribute("mainProjects", mdao.mainProjects());
		model.addAttribute("hashtag", mdao.projectHashtags());
		model.addAttribute("subcategory",mdao.subcatelist());
		model.addAttribute("category",mdao.catelist());
		return "main.selectmypage";
	}
	
	@RequestMapping("selectlikepage")
	public String selectlikepage(HttpSession session, Model model){
		ModelAndView mav = new ModelAndView("main/index");		
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
		System.out.println("id : " +mev.getM_id());
		System.out.println("nickname : "+mev.getM_nickname());
		}
		
		//model.addAttribute("mainProjects", mdao.mainProjects());
		model.addAttribute("hashtag", mdao.projectHashtags());
		model.addAttribute("subcategory",mdao.subcatelist());
		model.addAttribute("category",mdao.catelist());
		model.addAttribute("likepage",mdao.likelist(mev.getM_id()));
		return "main.selectlikepage";
	}
}
