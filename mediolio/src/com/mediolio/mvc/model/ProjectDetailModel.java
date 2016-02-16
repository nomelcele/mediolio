package com.mediolio.mvc.model;

import java.io.File;
import java.util.Arrays;
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

import com.mediolio.mvc.dao.ProjectDetailDao;
import com.mediolio.viewer.BoxViewClient;
import com.mediolio.viewer.BoxViewException;
import com.mediolio.viewer.Document;
import com.mediolio.viewer.Session;
import com.mediolio.vo.ContentVO;
import com.mediolio.vo.MemberVO;
import com.mediolio.vo.ProjectDetailVO;
import com.mediolio.vo.ReplyVO;

@Controller
public class ProjectDetailModel {
	@Autowired
	private ProjectDetailDao pddao;
	
	private static BoxViewClient boxView;
	
	@RequestMapping("projectDetail")
	public String projectDetail(Model model, @RequestParam("p_id") String p_id, @RequestParam("m_id") String m_id, HttpSession session){
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("p_id", Integer.parseInt(p_id)); map.put("p_m_id", Integer.parseInt(m_id));
		
		if(mev!=null){
			map.put("m_id", mev.getM_id());
		}else{
			map.put("m_id", 0);
		}

		// 조회수 증가(자기가 올린 프로젝트가 아닌 경우)
		if(Integer.parseInt(m_id) != map.get("m_id").intValue()){
			System.out.println("조회수 증가");
			pddao.increaseHits(Integer.parseInt(p_id));
		}
		//프로젝트 타이틀, 좋아요 여부, 상위 카테고리 이름, 하위 카테고리 ID, 작성자닉넴, 작성자 소개, 팔로우 여부, 좋아요수, 관심분야ID 받아옴
		ProjectDetailVO pdvo = pddao.projectDetail(map);
		model.addAttribute("detail", pdvo);
		
		// 프로젝트 콘텐츠
		List<ContentVO> contents = pddao.projectContents(Integer.parseInt(p_id));
		for(ContentVO covo:contents){
			if(covo.getC_type().equals("document")){
				// 문서 파일 뷰어 url 넣기
				File file = new File(session.getServletContext().getRealPath("/")+"upload\\"+covo.getC_value());
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("name", covo.getC_value());
				params.put("nonSvg", true);
				
				try {
					boxView = new BoxViewClient("3e7kxpyozin7r0kbknmiwa2dmpcoyq3w");
					Document doc = boxView.upload(file,params);
					Session viewSession = doc.createSession();
					String viewUrl = viewSession.getViewUrl();
					covo.setC_value(viewUrl);

				} catch (BoxViewException e) {
					e.printStackTrace();
				}
			}
		}
		model.addAttribute("contents", contents);
		
		//해쉬태그
		model.addAttribute("tag", pddao.projectHash(Integer.parseInt(p_id)));
		//댓글목록
		model.addAttribute("reply", pddao.getReplyList(Integer.parseInt(p_id)));
		
		//작성자 관심분야
		List<String> interesting_list = Arrays.asList((pdvo.getM_interestingPart()).split(","));
		model.addAttribute("interesting", pddao.getSubcategoryName(interesting_list));
		
		//해당 프로젝트의 하위 카테고리
		List<String> subCategory_list = Arrays.asList((pdvo.getSc_id()).split("/"));
		model.addAttribute("subcategory", pddao.getSubcategoryName(subCategory_list));
		
				
		return "project.projectDetail";
	}
	
	//댓글 달기
	@RequestMapping("submitReply")
	public ModelAndView submitReply(ReplyVO vo, @RequestParam("act_to") String act_to, HttpSession session){
		ModelAndView mav = new ModelAndView("jsonView");
		
		MemberVO mev = (MemberVO)session.getAttribute("mev");
		if(mev!=null){			
			vo.setM_id(mev.getM_id());

			mav.addObject("reply", pddao.submitReply(vo, act_to));
			System.out.println("댓글 내용 : " + vo.getR_text() + ", projectID : " + vo.getP_id() + ", m_id : " + vo.getM_id());
		}
		return mav;
	}
	
	//댓글 삭제
	@RequestMapping("deleteReply")
	public ModelAndView deleteReply(@RequestParam("r_id") String r_id){
		ModelAndView mav = new ModelAndView("jsonView");
		pddao.deleteReply(Integer.parseInt(r_id));	
		return mav;
	}
}
