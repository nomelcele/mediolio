package com.mediolio.mvc.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mediolio.mvc.dao.ProjectDao;

@Controller
public class ProjectModel {
	@Autowired
	private ProjectDao pdao;
	
	@RequestMapping(value="addProject")
	public String addProject(){
		return "project/addProject";
	}
	
	@RequestMapping(value="dbTest")
	public String dbTest(Model model){
		pdao.insertTest();
		model.addAttribute("test", pdao.selectTest());
		return "project/addProject";
	}

}
