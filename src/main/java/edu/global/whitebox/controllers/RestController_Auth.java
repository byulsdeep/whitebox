package edu.global.whitebox.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@RestController
public class RestController_Auth {

	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;

	@PostMapping("/checkUsrIdDuplicate")
	public String checkUsrIdDuplicate(Model model, @ModelAttribute UserBean userBean) {
		model.addAttribute(userBean);
		this.whiteBoxAuthentication.backController("checkUsrIdDuplicate", model);
		return (String) model.getAttribute("isDuplicate");
	}
}
