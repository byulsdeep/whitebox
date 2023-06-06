package edu.global.whitebox.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.services.Service_HH;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@Controller
public class Controller_HH {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	Service_HH hh;
	@Autowired
	WhiteBoxAuthentication whiteBoxAuthentication;
	
	private static final Logger logger = LogManager.getLogger(Controller_HH.class);
	
	@GetMapping("/seller/proRegist")
	public ModelAndView moveProRegist(ModelAndView mav) {
		this.whiteBoxAuthentication.setUserInfo(mav);
		mav.setViewName("/seller/selProductRegist");
		return mav;
	}
	
	@PostMapping("/seller/proRegist")
	public ModelAndView ProRegist(ModelAndView mav, @ModelAttribute ProductBean productBean, @RequestParam("proImage") MultipartFile[] files) {
		System.out.println("...............productBean");
		System.out.println(productBean.toString());
		
		//판매자 아이디 정보
		UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();
		productBean.setProUsrselid(userInfo.getUsrId());
		mav.addObject("productBean",productBean);
		mav.addObject("files",files);
		
		this.hh.backController("regist", mav);
		mav.setViewName("/seller/selProductRegist");
		return mav;
	}
	
	@GetMapping("/seller/storeInfo")
	public ModelAndView movoSelStoreInfo(ModelAndView mav) {

		this.whiteBoxAuthentication.setUserInfo(mav);
		
		mav.setViewName("/seller/storeInfo");
		
		return mav;
	}
	
	@PostMapping("/seller/storeInfo")
	public ModelAndView selStoreInfo(ModelAndView mav, @ModelAttribute UserBean userBean) {
		mav.addObject("userBean", userBean);
		
		this.whiteBoxAuthentication.setUserInfo(mav);
		System.out.println(userBean);
		this.hh.backController("editStore", mav);

		mav.setViewName("/seller/storeInfo");
		
		return mav;
	}
	
	@PostMapping("/seller/updateSellerProfileImage")
	public ModelAndView updateSellerProfileImage(ModelAndView mav, @RequestParam("usrImageFile") MultipartFile[] file) {
		
		UserBean userBean = this.whiteBoxAuthentication.getUserInfo();
		System.out.println(userBean);
		
		mav.addObject("userBean",userBean);
		mav.addObject("file",file[0]);
		
		this.hh.backController("updateSellerProfileImage", mav);
		this.whiteBoxAuthentication.setUserInfo(mav);

		mav.setViewName("/seller/storeInfo");
		
		
		return mav;
	}
	
}
