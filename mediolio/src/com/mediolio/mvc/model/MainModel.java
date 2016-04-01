package com.mediolio.mvc.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.MainDao;
import com.mediolio.vo.FriendVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectVO;




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
		System.out.println("nickname : "+mev.getM_name());
		}
		
		mav.addObject("mainProjects", mdao.mainProjects());
		mav.addObject("hashtag", mdao.projectHashtags());
		mav.addObject("category",mdao.catelist());
		mav.addObject("selcat", cat);
		/*List<SubcategoryVO> list = mdao.subcatelist();
		System.out.println(list.get(1).getSc_name());*/
		return mav;
	}
	
	@RequestMapping("selcatcard")
	public String selcatcard(HttpSession session, Model model, @RequestParam("selcat") String selcat){
		if(selcat.equals("ct_game")){
			cat="1";
		}
		else if(selcat.equals("ct_webApp")){
			cat="2";
		}
		else if(selcat.equals("ct_video")){
			cat="3";
		}
		else if(selcat.equals("ct_3d")){
			cat="4";
		}
		else if(selcat.equals("ct_design")){
			cat="5";
		}
		else if(selcat.equals("ct_misc")){
			cat="6";
		}
		else{
			cat="100";
		}
		System.out.println(cat);
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
		System.out.println("id : " +mev.getM_id());
		System.out.println("nickname : "+mev.getM_name());
		}
		
		model.addAttribute("mainProjects", mdao.mainProjects());
		model.addAttribute("hashtag", mdao.projectHashtags());
		model.addAttribute("category",mdao.catelist());
		model.addAttribute("selcat", cat);
		return "main.selectcategory";
	}
	
/*	@RequestMapping("selectmypage")
	public String selectmypage(HttpSession session, Model model){
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
		System.out.println("id : " +mev.getM_id());
		System.out.println("nickname : "+mev.getM_name());
		}
		
		model.addAttribute("mainProjects", mdao.mainProjects());
		model.addAttribute("hashtag", mdao.projectHashtags());
		model.addAttribute("category",mdao.catelist());
		return "main.selectmypage";
	}*/
	
	@RequestMapping("gotoMyPage")
	public ModelAndView gotoMyPage(){
		
		return new ModelAndView("mypage/mypage");
	}
	
	@RequestMapping("selectlikepage")
	public String selectlikepage(HttpSession session, Model model){
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
			System.out.println("id : " +mev.getM_id());
			System.out.println("nickname : "+mev.getM_name());
		}
		
		//model.addAttribute("mainProjects", mdao.mainProjects());
		model.addAttribute("hashtag", mdao.projectHashtags());
		model.addAttribute("category",mdao.catelist());
		model.addAttribute("likepage",mdao.likelist(mev.getM_id()));
		return "main.selectlikepage";
	}

	@RequestMapping("search")
	public ModelAndView search(@RequestParam("key") String key, @RequestParam("section") String section){
		ModelAndView mav = new ModelAndView("jsonView");
		Map<String, String> map = new HashMap<String, String>();
		map.put("key", key);
		map.put("section", section);
		
		System.out.println("search 함수 : " + key);
		
		if(key.equals("USER")) {
			List<FriendVO> resultList = mdao.searchUser(key);
			for(int i=0; i<resultList.size(); i++){
				System.out.println(resultList.get(i).getM_nickname());
			}
		}else if(key.equals("TAG")){
			List<ProjectVO> resultList = mdao.searchTag(key);
			for(int i=0; i<resultList.size(); i++){
				System.out.println(resultList.get(i).getP_title());
			}
		}else{
			List<ProjectVO> resultList = mdao.searchProjects(map);
		}
		
		
		return mav;
	}

}
