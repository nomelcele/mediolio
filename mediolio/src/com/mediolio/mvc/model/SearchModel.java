package com.mediolio.mvc.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.HistoryDao;
import com.mediolio.mvc.dao.SearchDao;
import com.mediolio.vo.FriendVO;
import com.mediolio.vo.ProjectVO;

@Controller
public class SearchModel {

	@Autowired
	private SearchDao sdao;
	@Autowired
	private HistoryDao htdao;
	
	@RequestMapping("searchAutoCompleteClass")
	public ModelAndView searchAutoCompleteClass(String cl_name){
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("list",  htdao.autocompleteClass(cl_name));

		return mav;
	}
	
	@RequestMapping("search")
	public ModelAndView search(@RequestParam("key") String key, @RequestParam("section") String section){
		ModelAndView mav = new ModelAndView("jsonView");
		Map<String, String> map = new HashMap<String, String>();
		key = key.trim();
		map.put("key", key);
		map.put("section", section);
		
		System.out.println("search 함수 : " + key);
		
		if(section.equals("member")) {
			List<FriendVO> resultList = sdao.searchUser(key);
			for(int i=0; i<resultList.size(); i++){
				System.out.println(resultList.get(i).getM_nickname());
			}
		}else if(section.equals("tag")){
			key = key.replaceAll(" ", "");
			List<ProjectVO> resultList = sdao.searchTag(key);
			for(int i=0; i<resultList.size(); i++){
				System.out.println(resultList.get(i).getP_title());
			}
		}else if(section.equals("subject")){
			List<ProjectVO> resultList = sdao.searchSubject(key);
			for(int i=0; i<resultList.size(); i++){
				System.out.println(resultList.get(i).getP_title());
			}
		}
		

		return mav;
	}
	
	@RequestMapping("searchDetail")
	public ModelAndView searchTitle(@RequestParam("key") String key, @RequestParam("section") String section, 
			@RequestParam("ct") String category, @RequestParam("sk") String skill){
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("searchDetail : " + key + ", " + section + ", " + category + ", " + skill);
		
		Map<String, String> map = new HashMap<String, String>();
		key = key.trim();
		map.put("key", key);
		map.put("section", section);
		map.put("cate", returnCateVal(category));

		
		List<ProjectVO> resultList = sdao.searchProjects(map);
		
		
		return mav;
	}
	
	private String returnCateVal(String cateStr){
		String cateVal = "0";
		if(cateStr.equals("게임")) cateVal = "1";
		else if(cateStr.equals("웹 & 앱")) cateVal = "2";
		else if(cateStr.equals("디자인")) cateVal = "5";
		else if(cateStr.equals("영상 & 사운드")) cateVal = "3";
		else if(cateStr.equals("3D")) cateVal = "4";
		else if(cateStr.equals("기타")) cateVal = "6";
		
		return cateVal;
	}
}
