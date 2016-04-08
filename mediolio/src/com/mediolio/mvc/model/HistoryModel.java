package com.mediolio.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mediolio.mvc.dao.HistoryDao;
import com.mediolio.vo.HistoryVO;
import com.mediolio.vo.MemberVO;

@Controller
public class HistoryModel {
	@Autowired
	private HistoryDao htdao;
	
	@RequestMapping(value="addHistory")
	public String addHistory(HistoryVO htvo,HttpSession session){
		// 새로운 히스토리 추가
		htvo.setM_id(((MemberVO)session.getAttribute("mev")).getM_id());
		htdao.addHistory(htvo);
		return "redirect:gotoMyPage";
	}
	
	@RequestMapping(value="deleteHistory")
	public String deleteHistory(int ht_id){
		// 히스토리 삭제
		htdao.deleteHistory(ht_id);
		return "redirect:gotoMyPage";
	}
}
