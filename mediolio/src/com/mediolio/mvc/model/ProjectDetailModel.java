package com.mediolio.mvc.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mediolio.mvc.dao.ProjectDetailDao;

@Controller
public class ProjectDetailModel {
	@Autowired
	private ProjectDetailDao pddao;
	
	@RequestMapping("projectDetail")
	public String projectDetail(Model model, @RequestParam("p_id") String p_id){
		//프로젝트 타이틀, 상위 카테고리 이름, 하위 카테고리 ID, 작성자닉넴, 작성자 소개, 좋아요수, 관심분야ID
		model.addAttribute("detail", pddao.projectDetail(Integer.parseInt(p_id)));
		//해쉬태그
		model.addAttribute("tag", pddao.projectHash(Integer.parseInt(p_id)));
		//댓글목록
		model.addAttribute("reply", pddao.getReplyList(Integer.parseInt(p_id)));
		//하위 카테고리 이름과 관심분야 이름 받아와야함!!!!!
		
		
		return "project/projectDetail";
	}
}
