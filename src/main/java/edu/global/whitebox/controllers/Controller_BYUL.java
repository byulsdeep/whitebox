package edu.global.whitebox.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.global.whitebox.beans.FriendBean;
import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.OrderDetailBean;
import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.services.Service_BYUL;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@Controller
public class Controller_BYUL {
	
	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;	
	@Autowired
	private Service_BYUL byul;
	
	/* 주문 */ 
	@GetMapping("/member/order")
	public ModelAndView order(ModelAndView mav, OrderBean cart) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("order", mav);
		mav.setViewName("member/kej_order");
		return mav;
	}
	@GetMapping("/member/orderSuccess")
	public ModelAndView orderSuccess(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		mav.setViewName("member/orderSuccess");
		return mav;
	}
	/* 결제 */
	@GetMapping("/member/payment/paypal")
	public ModelAndView paypal(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("paypal", mav);
		mav.setViewName("member/payment/paypal");
		return mav;
	}
	@GetMapping("/member/payment/kakao")
	public ModelAndView kakao(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		mav.setViewName("member/payment/kakao");
		return mav;
	}
// 장바구니 페이지
	@GetMapping("/member/cart")
	public ModelAndView moveCart(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("moveCart", mav);
		mav.setViewName("member/kej_cart");
		return mav;
	}
	@PostMapping("/member/updateQty")
	public ModelAndView updateQty(ModelAndView mav, @ModelAttribute OrderDetailBean updatedOrderDetail) {
		mav.addObject("updatedOrderDetail", updatedOrderDetail);
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("updateQty", mav);
		mav.setViewName("member/kej_cart");
		return mav;
	}
	@PostMapping("/member/updateRecipient")
	public ModelAndView updateRecipient(ModelAndView mav, @ModelAttribute OrderDetailBean updatedOrderDetail) {
		mav.addObject("updatedOrderDetail", updatedOrderDetail);
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("updateRecipient", mav);
		mav.setViewName("member/kej_cart");
		return mav;
	}
	@PostMapping("/member/copyCart")
	public ModelAndView copyCart(ModelAndView mav, @ModelAttribute OrderDetailBean cartToCopy) {
		mav.addObject("cartToCopy", cartToCopy);
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("copyCart", mav);
		mav.setViewName("member/kej_cart");
		return mav;
	}
	@GetMapping("/member/emptyCart")
	public ModelAndView emptyCart(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("emptyCart", mav);
		mav.setViewName("member/kej_cart");
		return mav;
	}
	@PostMapping("/member/deleteCart")
	public ModelAndView deleteCart(ModelAndView mav, OrderDetailBean cartToDelete) {
		mav.addObject("cartToDelete", cartToDelete);
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("deleteCart", mav);
		mav.setViewName("member/kej_cart");
		return mav;
	}

		
	/* 마이샵 */
	@GetMapping("/seller/productList")
	public ModelAndView selectProductByPage(ModelAndView mav, ProductBean productBean) {
		mav.addObject("productBean", productBean);
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		if (productBean.getQuery() != null) {
			// http://localhost/seller/productList?proUsrselid=seller&currentPage=1&itemsPerPage=10&query=keyword
			this.byul.backController("selectProductByPageAndQuery", mav);
		} else {
			// http://localhost/seller/productList?proUsrselid=seller&currentPage=1&itemsPerPage=10
			this.byul.backController("selectProductByPage", mav);			
		}
		mav.setViewName("seller/productList");
		return mav;
	}

	
	/* 마이페이지 */
	@GetMapping("/member/myPage/acceptRequest")
	public ModelAndView acceptRequest(ModelAndView mav, @ModelAttribute FriendBean requestInfo, @ModelAttribute FriendBean queryInfo) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		mav.addObject("requestInfo", requestInfo);
		mav.addObject("queryInfo", queryInfo);
		this.byul.backController("acceptRequest", mav);
		this.byul.backController("selectFriendRequests", mav);
		mav.setViewName("member/myPage/friendRequests");
		return mav;
	}	
	@GetMapping("/member/myPage/declineRequest")
	public ModelAndView declineRequest(ModelAndView mav, @ModelAttribute FriendBean requestInfo, @ModelAttribute FriendBean queryInfo) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		mav.addObject("requestInfo", requestInfo);
		mav.addObject("queryInfo", queryInfo);
		this.byul.backController("declineRequest", mav);
		this.byul.backController("selectFriendRequests", mav);
		mav.setViewName("member/myPage/friendRequests");
		return mav;
	}	
	@GetMapping("/member/myPage/sendRequest")
	public ModelAndView sendRequest(ModelAndView mav, @ModelAttribute FriendBean requestInfo, @ModelAttribute FriendBean queryInfo) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		
		System.out.println("..sendRequest");
		System.out.println(requestInfo);
		mav.addObject("requestInfo", requestInfo);
		this.byul.backController("sendRequest", mav);
		mav.addObject("queryInfo", queryInfo);
		this.byul.backController("selectFriendRequests", mav);
		mav.setViewName("member/myPage/friendRequests");
		return mav;
	}	
//	@GetMapping("/member/myPage")
//	public String moveMyPage() {
//		return "member/myPage/dashboard";
//	}
//	@GetMapping("/member/myPage/accountSetting")
//	public ModelAndView moveMemberAccountSetting(ModelAndView mav) {
//		this.whiteBoxAuthentication.setUserInfo(mav);
//		mav.setViewName("member/myPage/accountSetting");
//		return mav;
//	}
	@GetMapping("/member/myPage/friendList")
	public ModelAndView moveFriendList(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("selectFriendList", mav);
		mav.setViewName("member/myPage/friendList");
		return mav;
	}
	@GetMapping("/member/myPage/friendWishList")
	public ModelAndView friendWishList(ModelAndView mav, @RequestParam(name = "friendId") String friendId) {
		System.out.println("friendId: " + friendId);
		mav.addObject("friendId", friendId);
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("selectFriendWishList", mav);
		mav.setViewName("member/myPage/friendWishList");
		return mav;
	}
	@GetMapping("/member/myPage/friendRequests")
	public ModelAndView moveFriendRequests(ModelAndView mav, @ModelAttribute FriendBean queryInfo) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		mav.addObject("queryInfo", queryInfo);
		this.byul.backController("selectFriendRequests", mav);
		mav.setViewName("member/myPage/friendRequests");
		return mav;
	}
	@GetMapping("/member/myPage/giftHistory")
	public ModelAndView moveGiftHistory(ModelAndView mav) {
		this.whiteBoxAuthentication.backController("setUserInfo", mav);
		this.byul.backController("selectGiftList", mav);
		mav.setViewName("member/myPage/giftHistory");
		return mav;
	}
}
