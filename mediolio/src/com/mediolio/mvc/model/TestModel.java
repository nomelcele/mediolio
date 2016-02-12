package com.mediolio.mvc.model;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;


@Controller
public class TestModel {

	@RequestMapping("test")
	public ModelAndView gotoTest(){
		return new ModelAndView("test");
	}

}
