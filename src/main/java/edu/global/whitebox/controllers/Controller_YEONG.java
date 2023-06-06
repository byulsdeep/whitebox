package edu.global.whitebox.controllers;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.services.LineAuthentication;
import edu.global.whitebox.services.Service_YEONG;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@Controller
public class Controller_YEONG {
	
	private static final Logger logger = LogManager.getLogger(LineAuthentication.class);
	
	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;	
	@Autowired
	private Service_YEONG yeong;

	@GetMapping("/product/{pro_usrselid}/{pro_code}")
	public ModelAndView viewProductDetail(ModelAndView mav, ProductBean productBean, 
			@PathVariable("pro_usrselid") String proUsrselid, @PathVariable("pro_code") String proCode) {
		
		this.whiteBoxAuthentication.setUserInfo(mav);
		
		productBean.setProUsrselid(proUsrselid);
		productBean.setProCode(proCode);
		
		mav.addObject("productBean", productBean);
		yeong.backController("getProductDetail", mav);
		
		mav.setViewName("member/productDetails");
		return mav;
	}

	@GetMapping("/productSearch")
	public ModelAndView viewProductSearch(ModelAndView mav) {

		mav.setViewName("member/productSearch");
		return mav;
	}
	
	@GetMapping("/member/myPage/orderHistory")
	public ModelAndView viewOrderHistory(ModelAndView mav, ProductBean productBean) {
		this.whiteBoxAuthentication.setUserInfo(mav);

		mav.setViewName("member/myPage/orderHistory");
		return mav;
	}
	

	@GetMapping("/member/myPage/order/{ordUsrmemid}/{ordDate}")
	public ModelAndView orderDetail(ModelAndView mav, OrderBean orderBean, 
			@PathVariable("ordUsrmemid") String ordUsrmemid, @PathVariable("ordDate") String ordDate) {
		this.whiteBoxAuthentication.setUserInfo(mav);
		
		orderBean.setOrdUsrmemid(ordUsrmemid);
		orderBean.setOrdDate(ordDate);
		System.out.println(orderBean);
		mav.addObject("orderBean", orderBean);

		this.yeong.backController("getOrderDetail", mav);
		mav.setViewName("member/myPage/orderDetail");
		
		return mav;
	}

}
