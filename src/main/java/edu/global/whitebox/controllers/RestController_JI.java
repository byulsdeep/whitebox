package edu.global.whitebox.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import edu.global.whitebox.beans.OrderDetailBean;
import edu.global.whitebox.services.Service_JI;

@RestController
public class RestController_JI {

	@Autowired
	private Service_JI ji;
	

}
