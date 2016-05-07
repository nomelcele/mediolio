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

import com.mediolio.mvc.dao.HistoryDao;
import com.mediolio.mvc.dao.MainDao;
import com.mediolio.vo.BranchVO;
import com.mediolio.vo.FriendVO;
import com.mediolio.vo.HashtagVO;
import com.mediolio.vo.HistoryVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectVO;




@Controller
public class MainModel {
	
	private String cat="0";
	
	@Autowired
	private MainDao mdao;
	@Autowired
	private HistoryDao htdao;
	
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
	public String gotoMyPage(Model model, HttpSession session){
		// 전체 히스토리 리스트
		List<HistoryVO> htList = htdao.historyList(((MemberVO)session.getAttribute("mev")).getM_id());
		model.addAttribute("htList", htList);
		// 가장 최근에 업데이트 된 히스토리의 브랜치들 불러오기
		HistoryVO recentHt = htList.get(0);
		model.addAttribute("recentHtId", recentHt.getHt_id());
		model.addAttribute("recentHtTitle", recentHt.getHt_title());
		model.addAttribute("branches",htdao.branchList(recentHt.getHt_id()));
		return "mypage/mypage";
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

}
