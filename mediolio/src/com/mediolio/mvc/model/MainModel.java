package com.mediolio.mvc.model;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.HistoryDao;
import com.mediolio.mvc.dao.MainDao;
import com.mediolio.vo.HistoryVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectVO;




@Controller
public class MainModel {
		
	@Autowired
	private MainDao mdao;
	@Autowired
	private HistoryDao htdao;
	
	@RequestMapping(value={"","main"})
	public ModelAndView main(HttpSession session){

		ModelAndView mav = new ModelAndView("main/index");		
		MemberVO mev = (MemberVO) session.getAttribute("mev");
		if(mev!=null){
			System.out.println("id : " +mev.getM_id());
			System.out.println("nickname : "+mev.getM_name());
		}

		return mav;
	}
	
	//박성준 1차 작성
	//오지은 수정
	@RequestMapping("selcatcard")
	public String selcatcard(HttpSession session, Model model, @RequestParam("selcat") String selcat){
		String category="0";
		String p_type;
		List<ProjectVO> prjList;
		
		if(selcat.equals("ct_project")){
			//프로젝트인 경우
			p_type="1";
			prjList = mdao.getProjectLists();
			
		}else{
			//과제인 경우
			p_type="0";
			if(selcat.equals("ct_game")){
				category="1";
			}
			else if(selcat.equals("ct_webApp")){
				category="2";
			}
			else if(selcat.equals("ct_video")){
				category="3";
			}
			else if(selcat.equals("ct_3d")){
				category="4";
			}
			else if(selcat.equals("ct_design")){
				category="5";
			}
			else if(selcat.equals("ct_misc")){
				category="6";
			}
			prjList = mdao.getCertainCategoryList(category);
			
		}
		
		model.addAttribute("p_type", p_type);
		model.addAttribute("mainProjects", prjList);
		model.addAttribute("hashtag", mdao.projectHashtags());
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
		if(!htList.isEmpty()){
			HistoryVO recentHt = htList.get(0);
			model.addAttribute("recentHtId", recentHt.getHt_id());
			model.addAttribute("recentHtTitle", recentHt.getHt_title());
			model.addAttribute("branches",htdao.branchList(recentHt.getHt_id()));
				
		}
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
		model.addAttribute("likepage",mdao.likelist(mev.getM_id()));
		return "main.selectlikepage";
	}

}
