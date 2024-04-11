package com.cafe24.goott351.board.cs.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cs/*")
public class CsController {
	
	@RequestMapping("terms")
	public String openTerms(Locale locale, Model model) throws Exception {
		
		return "cs/homeTerms";
	}
	
	@RequestMapping("info")
	public String openInfo(Locale locale, Model model) throws Exception {
		
		return "cs/homeInfo";
	}
	
	@RequestMapping("personalInfo")
	public String openPersonalInfo(Locale locale, Model model) throws Exception {
		
		return "cs/homePersonalInfo";
	}
	
	@RequestMapping("location")
	public String openLocation(Locale locale, Model model) throws Exception {
		
		return "cs/location";
	}
	
	@RequestMapping("teamInfo")
	public String openTeamInfo(Locale locale, Model model) throws Exception {
		
		return "cs/teamInfo";
	}


}
