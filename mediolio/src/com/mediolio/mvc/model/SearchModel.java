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
import com.mediolio.vo.FriendVO;
import com.mediolio.vo.ProjectVO;


/* *****
 * ***** 오지은 작성
 * *****
 * */

@Controller
public class SearchModel {

	@Autowired
	private SearchDao sdao;
	@Autowired
	private HistoryDao htdao;
	
	// 과목 검색 시 - 검색창에 글자를 타이핑 할 때(keyevent) 과목 자동완성을 위한 함수.
	// 과목 명 리스트 리턴
	@RequestMapping("searchAutoCompleteClass")
	public ModelAndView searchAutoCompleteClass(String cl_name){
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("list",  htdao.autocompleteClass(cl_name));

		return mav;
	}
	
	//과목 검색 - 자동완성되어 나타난 과목 목록을 선택했을 때 실행되는 함수
	// 과목 id를 기반으로, 해당 과목에 관련된 프로젝트 목록 리턴
	@RequestMapping("searchC")
	public ModelAndView search(@RequestParam("cl_id") String cl_id, @RequestParam("cl_n") String cl_name){
		ModelAndView mav = new ModelAndView("search/search");
		mav.addObject("key", cl_name);
		mav.addObject("type", "과목");
		
		List<ProjectVO> resultList = sdao.searchSubject(cl_id);
		mav.addObject("list", resultList);
		mav.addObject("total", resultList.size());
		
		return mav;
	}
	
	
	// 해시태그로 검색 시 - 그 해시태그를 가지고 있는 프로젝트 목록들을 리턴
	@RequestMapping("searchH")
	public ModelAndView searchH(@RequestParam("key") String key){
		ModelAndView mav = new ModelAndView("search/search");
		mav.addObject("key", key);
		mav.addObject("type", "태그");
		key = key.trim();
		key = key.replaceAll(" ", ""); //검색어에 띄어쓰기가 있다면 띄어쓰기 없애기
		
		List<ProjectVO> resultList = sdao.searchTag(key);

		mav.addObject("list", resultList);
		mav.addObject("total", resultList.size());
		return mav;
	}
	
	
	//글 제목으로 검색 시 - 전체 범위에서 또는 특정 카테고리에서 어떤 글 제목을 가진 프로젝트들을 출력
	@RequestMapping("searchT")
	public ModelAndView searchTitle(@RequestParam("key") String key, @RequestParam("ct") String category){
		ModelAndView mav = new ModelAndView("search/search");
		mav.addObject("key", key);
		mav.addObject("type", "제목");
		mav.addObject("category", getCategoryName(category));
		
		//검색어 가공 - 띄어쓰기로 구분
		// ex) 검색어 "안드로이드 어플리케이션" 
		//       -> "안드로이드" 또는 "어플리케이션"을 제목(p_title) 또는 작업 명(p_prjname)으로 가진 프로젝트 출력
		key = key.trim();
		String[] splitKey =  key.split(" ");
		List<String> keys = new ArrayList<>();
		
		for (int i=0; i<splitKey.length; i++){
			keys.add("%"+splitKey[i]+"%");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyGroup", keys);
		map.put("cate", category);

		List<ProjectVO> resultList = sdao.searchTitle(map);
		mav.addObject("list", resultList);
		mav.addObject("total", resultList.size());

		return mav;
	}
	
	//학우 검색 - "이름" 또는 "기술" 또는 "그 기술을 가진 사람이름" 을 기반으로 검색
	@RequestMapping("searchM")
	public ModelAndView searchMember(@RequestParam("key") String key, @RequestParam("ct") String category, @RequestParam("sk") String skill){
		ModelAndView mav = new ModelAndView("search/searchm");
		mav.addObject("key", key);
		mav.addObject("type", "학우");
		mav.addObject("category", getCategoryName(category));
		
		if(!skill.equals("0")){
			//검색옵션에 기술을 선택했을 때
			mav.addObject("skillName", sdao.getSkillName(skill));
		}
		
		//검색어 가공 - 띄어쓰기로 구분
		key = key.trim();
		String[] splitKey =  key.split(" ");
		List<String> keys = new ArrayList<>();
		
		for (int i=0; i<splitKey.length; i++){
			keys.add("%"+splitKey[i]+"%");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		key = key.trim();
		map.put("keyGroup", keys);
		map.put("sk", skill);
		
		List<FriendVO> resultList;
		
		if(category.equals("0")){
			//전체에서 검색
			resultList = sdao.searchMemberInTotal(map);
		}else{
			//특정 카테고리에 글을 쓴 학우 내에서 검색
			map.put("cate", category);
			resultList = sdao.searchMemberInCategory(map);
		}
		
		mav.addObject("list", resultList);
		mav.addObject("total", resultList.size());

		return mav;
	}

	// 뷰에서 넘어온 카테고리id를 카테고리 이름으로 변환해주는 함수
	// 다시 뷰로 출력할 때 필요한 값
	private String getCategoryName(String intCategory){
		String strCategory = "전체";
		
		if(intCategory.equals("1")) strCategory = "게임";
		else if(intCategory.equals("2")) strCategory = "웹&앱";
		else if(intCategory.equals("3")) strCategory = "디자인";
		else if(intCategory.equals("4")) strCategory = "영상&사운드";
		else if(intCategory.equals("5")) strCategory = "3D";
		else if(intCategory.equals("6")) strCategory = "기타";
		
		return strCategory;
	}
}
