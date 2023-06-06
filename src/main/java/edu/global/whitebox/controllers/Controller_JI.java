package edu.global.whitebox.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.OrderDetailBean;
import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.services.Service_JI;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@Controller
public class Controller_JI {

	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;	
	@Autowired
	private Service_JI ji;
	
	@GetMapping("/usr_selshop/{usrId}")
	public ModelAndView moveShop(ModelAndView mav, @PathVariable("usrId") String usrId) {
		this.whiteBoxAuthentication.setUserInfo(mav);
		UserBean sellerInfo = new UserBean();
		sellerInfo.setUsrId(usrId);
		
		mav.addObject("sellerInfo", sellerInfo);
		
		this.ji.backController("moveShop", mav);
		mav.setViewName("member/ghh_usr_selshop");
		
		return mav;
	}
	/*seller 주문 리스트 */
		@GetMapping("/seller/selOrderlist")
		public ModelAndView selOrderlist(ModelAndView mav) {
			
			//UserBean sellerInfo = new UserBean();
			
			//OrderBean orderBean = new OrderBean();
			//OrderDetailBean orderDeitalBean = new OrderDetailBean();
			
			
			this.whiteBoxAuthentication.setUserInfo(mav);
			
			this.ji.backController("moveSelOrderList", mav);
			
			mav.setViewName("/seller/selOrderList");
			return mav;
			
	}
	}
