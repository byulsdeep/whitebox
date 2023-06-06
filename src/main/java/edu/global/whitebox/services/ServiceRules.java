package edu.global.whitebox.services;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public interface ServiceRules {
	public abstract void backController(String serviceCode, ModelAndView mav);
	public abstract void backController(String serviceCode, Model model);
}
