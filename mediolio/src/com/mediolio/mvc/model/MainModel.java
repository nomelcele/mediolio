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
import com.mediolio.vo.CategoryVO;
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
			//로그인 한 상태
			System.out.println("id : " +mev.getM_id());
			System.out.println("nickname : "+mev.getM_name());
			
			//관심분야 최신 글
			List<CategoryVO> category = mdao.getInterestingPart(mev.getM_id());
			mav.addObject("interesting", category);
			List<ProjectVO> new1 = mdao.getNewProject_interest(category.get(0).getCate_id());
			List<ProjectVO> new2 = mdao.getNewProject_interest(category.get(1).getCate_id());
			
			mav.addObject("new1_idx", new1.size());
			mav.addObject("new2_idx", new2.size());
			mav.addObject("new1", new1);
			mav.addObject("new2", new2);
		}else{
			//로그인하지 않은 상태 - 게임/웹&앱/영상 분야 최신 글 출력
			List<ProjectVO> new1 = mdao.getNewProject_visitor(1);
			List<ProjectVO> new2 = mdao.getNewProject_visitor(2);
			List<ProjectVO> new3 = mdao.getNewProject_visitor(3);
			
			mav.addObject("new1_idx", new1.size());
			mav.addObject("new2_idx", new2.size());
			mav.addObject("new3_idx", new3.size());
			
			mav.addObject("new1", new1);//게임
			mav.addObject("new2", new2);//웹&앱
			mav.addObject("new3", new3);//영상
		}

		return mav;
	}
	
	@RequestMapping("mainMorePrjs")
	public String mainMorePrjs(HttpSession session, Model model, @RequestParam("cate") String cate){
		
		model.addAttribute("mainProjects", mdao.mainMorePrjs(Integer.parseInt(cate)));		
		return "main.selectcategory";
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
		
		model.addAttribute("likepage",mdao.likelist(mev.getM_id()));
		return "main.selectlikepage";
	}

}
