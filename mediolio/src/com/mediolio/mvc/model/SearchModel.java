package com.mediolio.mvc.model;

import java.util.ArrayList;
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
	
	//태그 검색, 과목으로 검색
	@RequestMapping("search")
	public ModelAndView search(@RequestParam("key") String key, @RequestParam("section") String section){
		ModelAndView mav = new ModelAndView("jsonView");
		Map<String, String> map = new HashMap<String, String>();
		key = key.trim();
		map.put("key", key);
		map.put("section", section);
		
		System.out.println("search 함수 : " + key);
		
		if(section.equals("tag")){
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
	
	//글 제목으로 검색
	@RequestMapping("searchTitle")
	public ModelAndView searchTitle(@RequestParam("key") String key, @RequestParam("section") String section, 
			@RequestParam("ct") String category){
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("searchDetail : " + key + ", " + section + ", " + category);
		
		//검색어 가공 - 띄어쓰기로 구분
		key = key.trim();
		String[] splitKey =  key.split(" ");
		List<String> keys = new ArrayList<>();
		
		for (int i=0; i<splitKey.length; i++){
			System.out.println("검색어 : " + splitKey[i]);
			keys.add("%"+splitKey[i]+"%");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("key", keys);
		map.put("cate", returnCateVal(category));

		mav.addObject("list", sdao.searchTitle(map));
		return mav;
	}
	
	//학우 검색
	@RequestMapping("searchMember")
	public ModelAndView searchMember(@RequestParam("key") String key, @RequestParam("section") String section, 
			@RequestParam("ct") String category, @RequestParam("sk") String skill){
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("searchDetail : " + key + ", " + section + ", " + category + ", " + skill);
		
		
		//!!!!! 검색어 자르는 기능 추가하기 !!!!
		
		Map<String, String> map = new HashMap<String, String>();
		key = key.trim();
		map.put("key", key);
		map.put("sk", skill);
		
		category =  returnCateVal(category);
		if(category.equals("0")){//전체에서 검색
			mav.addObject("list", sdao.searchMemberInTotal(map));
		}else{//특정 카테고리에 글을 쓴 학우 내에서 검색
			map.put("cate", category);
			mav.addObject("list", sdao.searchMemberInCategory(map));
		}

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
