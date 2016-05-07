package com.mediolio.mvc.model;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mediolio.mvc.dao.HistoryDao;
import com.mediolio.mvc.dao.SearchDao;

@Controller
public class SearchModel {

	@Autowired
	private SearchDao sdao;
	@Autowired
	private HistoryDao htdao;
	
	@RequestMapping("classAutoComplete")
	public ModelAndView classAutoComplete(String cl_name){
		System.out.println(cl_name);
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("jsonList", htdao.autocompleteClass(cl_name));
		return mav;
	}
		
}
