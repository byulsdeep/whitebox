package edu.global.whitebox.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import edu.global.whitebox.beans.ViewHistoryBean;
import edu.global.whitebox.services.Service_BI;
import edu.global.whitebox.services.Service_BYUL;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@Controller
public class Controller_BI {

	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;
	@Autowired
	private Service_BI service_BI;
	@Autowired
	private Service_BYUL byul;

	/* 마이페이지 */
//	@GetMapping("/member/myPage")
//	public ModelAndView moveMyPage(ModelAndView mav) {
//		this.whiteBoxAuthentication.backController("setUserInfo", mav);
//		mav.setViewName("member/myPage/BI_dashboard");
//		return mav;		
//	}
	@GetMapping("/member/myPage")
	public ModelAndView moveMyPage(ModelAndView mav, ViewHistoryBean vhsb) { // vhsb에 ? 값 들어감
		this.whiteBoxAuthentication.setUserInfo(mav);
		System.out.println(vhsb.getCurrentPage());
		System.out.println(vhsb.getItemsPerPage());
		vhsb.setItemsPerPage(9);

		String usrId = this.whiteBoxAuthentication.getUserInfo().getUsrId();
		vhsb.setVhsUsrmemid(usrId); // usrId를 담아서 Service_BI쪽에서 꺼냄 
		System.out.println("usrId: " + usrId);
		
		mav.addObject("vhsbObject", vhsb); // back에서 mav에 vhsb객체를 담음
		this.service_BI.backController("userWishListByPage", mav);
		this.byul.backController("selectGiftList", mav);

		mav.setViewName("member/myPage/BI_dashboard");
		return mav; // Service의 userWishListByPage와 userWishListCount프론트(jsp)로 리턴
	}
	
	

	@GetMapping("/member/myPage/accountSetting")
	public ModelAndView moveMemberAccountSetting(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		mav.setViewName("member/myPage/accountSetting");
		return mav;
	}

	@RequestMapping(value = "/member/myPage/updateUserImg", method = RequestMethod.POST)
	public ModelAndView updateUserImg(ModelAndView mav, @RequestParam("usrImageFile") MultipartFile[] files) {
		mav.addObject("file", files[0]);
		System.out.println(files[0].getOriginalFilename());
		System.out.println(files[0].getSize());
		this.service_BI.backController("updateUserImg", mav);
		this.whiteBoxAuthentication.setUserInfo(mav);

		mav.setViewName("member/myPage/accountSetting");
		return mav;
	}
	
	
//	/member/myPage/userWishList?currentPage=?&itemsPerPage=9&
	@GetMapping("/member/myPage/userWishList")
	public ModelAndView userWishListByPage(ModelAndView mav, ViewHistoryBean vhsb) { // vhsb에 ? 값 들어감
		this.whiteBoxAuthentication.setUserInfo(mav);
		System.out.println(vhsb.getCurrentPage());
		System.out.println(vhsb.getItemsPerPage());
		vhsb.setItemsPerPage(9);

		String usrId = this.whiteBoxAuthentication.getUserInfo().getUsrId();
		vhsb.setVhsUsrmemid(usrId); // usrId를 담아서 Service_BI쪽에서 꺼냄 
		System.out.println("usrId: " + usrId);
		
		mav.addObject("vhsbObject", vhsb); // back에서 mav에 vhsb객체를 담음
		this.service_BI.backController("userWishListByPage", mav);
		mav.setViewName("member/myPage/userWishList");
		return mav; // Service의 userWishListByPage와 userWishListCount프론트(jsp)로 리턴
	}
	
//	/member/myPage/userWatchList?currentPage=?&itemsPerPage=9&
	@GetMapping("/member/myPage/userWatchList")
	public ModelAndView userWatchListByPage(ModelAndView mav, ViewHistoryBean vhsb) { // vhsb에 ? 값 들어감
		this.whiteBoxAuthentication.setUserInfo(mav);
		System.out.println(vhsb.getCurrentPage());
		System.out.println(vhsb.getItemsPerPage());
		vhsb.setItemsPerPage(9);

		String usrId = this.whiteBoxAuthentication.getUserInfo().getUsrId();
		vhsb.setVhsUsrmemid(usrId); // usrId를 담아서 Service_BI쪽에서 꺼냄 
		System.out.println("usrId: " + usrId);
		
		mav.addObject("vhsbObject", vhsb); // back에서 mav에 vhsb객체를 담음
		this.service_BI.backController("userWatchListByPage", mav);
		mav.setViewName("member/myPage/userWatchList");
		return mav; // Service의 userWatchListByPage와 userWatchList프론트(jsp)로 리턴
	}
	
	@GetMapping("/member/myPage/userViewHistory")
	public ModelAndView userViewHistoryByPage(ModelAndView mav, ViewHistoryBean vhsb) {
		this.whiteBoxAuthentication.setUserInfo(mav);
		System.out.println(vhsb.getCurrentPage());
		System.out.println(vhsb.getItemsPerPage());
		vhsb.setItemsPerPage(9);

		String usrId = this.whiteBoxAuthentication.getUserInfo().getUsrId();
		vhsb.setVhsUsrmemid(usrId); // usrId를 담아서 Service_BI쪽에서 꺼냄 
		System.out.println("usrId: " + usrId);
		
		mav.addObject("vhsbObject", vhsb); // back에서 mav에 vhsb객체를 담음
		this.service_BI.backController("userViewHistoryByPage", mav);
		mav.setViewName("member/myPage/userViewHistory");
		return mav; // Service의 userWatchListByPage와 userWatchList프론트(jsp)로 리턴
	}
}