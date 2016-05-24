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
import com.mediolio.vo.HashtagVO;
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
	@RequestMapping("searchH")
	public ModelAndView searchH(@RequestParam("key") String key){
		ModelAndView mav = new ModelAndView("search/search");
		mav.addObject("key", key);
		mav.addObject("type", "태그");
		key = key.trim();
		key = key.replaceAll(" ", ""); //해쉬태그 띄어쓰기 없애기
		
		List<Object> resultList = sdao.searchTag(key);
		for(int i=0; i<resultList.size(); i++){
			System.out.println(((ProjectVO) resultList.get(i)).getP_title());
		}

		mav.addObject("list", resultList);
		mav.addObject("total", resultList.size());
		return mav;
	}
	
	//과목으로 검색
	@RequestMapping("searchC")
	public ModelAndView search(@RequestParam("cl_id") String cl_id, @RequestParam("cl_n") String cl_name){
		ModelAndView mav = new ModelAndView("search/search");
		mav.addObject("key", cl_name);
		mav.addObject("type", "과목");
		
		List<Object> resultList = sdao.searchSubject(cl_id);
		mav.addObject("list", resultList);
		mav.addObject("total", resultList.size());
		
		for(int i=0; i<resultList.size(); i++){
			System.out.println(((ProjectVO) resultList.get(i)).getP_title());
		}

		return mav;
	}
	
	//글 제목으로 검색
	@RequestMapping("searchT")
	public ModelAndView searchTitle(@RequestParam("key") String key, @RequestParam("ct") String category){
		ModelAndView mav = new ModelAndView("search/search");
		mav.addObject("key", key);
		mav.addObject("type", "제목");
		System.out.println("searchDetail : " + key + ", " + category);
		
		//검색어 가공 - 띄어쓰기로 구분
		key = key.trim();
		String[] splitKey =  key.split(" ");
		List<String> keys = new ArrayList<>();
		
		for (int i=0; i<splitKey.length; i++){
			System.out.println("검색어 : " + splitKey[i]);
			keys.add("%"+splitKey[i]+"%");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyGroup", keys);
		map.put("cate", category);

		List<Object> resultList = sdao.searchTitle(map);
		mav.addObject("list", resultList);
		mav.addObject("total", resultList.size());

		return mav;
	}
	
	//학우 검색
	@RequestMapping("searchM")
	public ModelAndView searchMember(@RequestParam("key") String key, @RequestParam("ct") String category, @RequestParam("sk") String skill){
		ModelAndView mav = new ModelAndView("search/searchm");
		mav.addObject("key", key);
		mav.addObject("type", "학우");
		System.out.println("searchDetail : " + key  + ", " + category + ", " + skill);
		
		
		//!!!!! 검색어 자르는 기능 보완하기 !!!!
		//검색어 가공 - 띄어쓰기로 구분
		key = key.trim();
		String[] splitKey =  key.split(" ");
		List<String> keys = new ArrayList<>();
		
		for (int i=0; i<splitKey.length; i++){
			System.out.println("검색어 : " + splitKey[i]);
			keys.add("%"+splitKey[i]+"%");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		key = key.trim();
		map.put("keyGroup", keys);
		map.put("sk", skill);
		
		List<Object> resultList;
		
		if(category.equals("0")){//전체에서 검색
			System.out.println("전체검색");
			resultList = sdao.searchMemberInTotal(map);
			mav.addObject("list", resultList);
		}else{//특정 카테고리에 글을 쓴 학우 내에서 검색
			map.put("cate", category);
			resultList = sdao.searchMemberInCategory(map);
			mav.addObject("list", resultList);
		}
		mav.addObject("total", resultList.size());

		return mav;
	}

}
