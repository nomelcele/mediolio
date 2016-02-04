package com.mediolio.mvc.model;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainModel {
	@RequestMapping(value={"","main"})
	public String main(){
		return "main/index";
	}
}
