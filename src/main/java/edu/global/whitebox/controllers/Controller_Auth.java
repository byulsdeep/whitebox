package edu.global.whitebox.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.services.Service_BI;
import edu.global.whitebox.services.Service_YEONG;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@Controller
public class Controller_Auth {

	@Autowired
	WhiteBoxAuthentication auth;
	@Autowired
	Service_YEONG service_YEONG;
	@Autowired
	private Gson gson;
	@Autowired
	private Gson gsonPretty;
	@Autowired
	SqlSessionTemplate sqlSession;
	
	private static final Logger logger = LogManager.getLogger(Controller_Auth.class);

	@GetMapping("/")
	public ModelAndView home(@RequestParam(name = "message", required = false) String message, ModelAndView mav,
			Principal principal) {
		
		System.out.println("ようこそ、ホワイトボックスへ");
		mav.setViewName("member/index");
		
		// 로그아웃 메시지 localhost/?message=logout
		if (message != null && !message.isEmpty()) {
			if (message.equals("logout")) {
				mav.addObject("message", "ログアウトしました");
			}
		}
		service_YEONG.backController("getHomeProductList", mav); // 메인 페이지 상품 가져오기
		
		//  비회원. 로그인 안한 상태
		System.out.println("isAnonymous");
		System.out.println(this.auth.isAnonymous());
		if (this.auth.isAnonymous()) {
			return mav;
		}
		
		// 223-05-07 
		// spring security 로그인시 UserDetails 객체가 Authentication 객체에 저장되는 것을 활용 해
		// authentication.getName() 으로 db에서 유저 정보를 다시 긁어오는게 아닌
		// authentication.getPrincipal() 로 spring security 가 저장한 유저 정보를 가져오도록 refactoring함
		// 통합 시키기 위해 WhiteBoxUserDetails와 UserBean 수정. MemberBean, SellerBean 삭제
		
		System.out.println("..test startrs here ");
		UserBean userInfo = (UserBean) mav.getModel().get("userInfo");
		System.out.println(this.gsonPretty.toJson(userInfo));
		
		System.out.println("..and it ends here..");
		this.auth.backController("setUserInfo", mav);
		
		// 이메일 미인증 상태로 로그인 시
		if (this.auth.isUnauthenticated()) {
			mav.addObject("unauthenticated", true);
		}
		return mav;
	}
	@GetMapping("/login")
	public String memberLogin(@RequestParam(name = "message", required = false) String message, final Model model) {
		if (message != null && !message.isEmpty()) {
			if (message.equals("error")) {
				model.addAttribute("message", "IDまたはパスワードが間違いました");
			}
			if (message.equals("logout")) {
				model.addAttribute("message", "ログアウトしました");
			}
		}
		return "member/login";
	}
	@GetMapping("/memberSignUp")
	public String moveMemberSignUp() {
		return "member/signUp";
	}
	@PostMapping("/memberSignUp")
	public ModelAndView memberSignUp(HttpServletRequest request, ModelAndView mav, @ModelAttribute UserBean signUpInfo, @RequestParam("usrImageFile") MultipartFile[] files) {
		mav.addObject("signUpInfo", signUpInfo);
		mav.addObject("files", files);
		mav.addObject("httpServletRequest", request);
		// 모델에 이름을 안정해주고 객체를 추가하면 변수명이 아닌 객체 데이터 타입으로 저장된다
		this.auth.backController("signUp", mav);
		service_YEONG.backController("getHomeProductList", mav); // 메인 페이지 상품 가져오기
		return mav;
	}
	@GetMapping("/emailAuth")
	public ModelAndView memberEmailAuth(@RequestParam(name = "authenticationCode") String authenticationCode,
			ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		mav.addObject("authenticationCode", authenticationCode);
		mav.addObject("httpServletRequest", request);
		mav.addObject("httpServletResponse", response);
		this.auth.backController("authenticateEmail", mav);

		return mav;
	}
	@PostMapping("/resendAuthenticationEmail")
	public ModelAndView sendAuthenticationEmail(ModelAndView mav) {
		UserBean userBean = new UserBean();
		userBean.setUsrId(this.auth.getAuthentication().getName());
		mav.addObject("userBean", userBean);
		this.auth.backController("setUserInfo", mav);
		this.auth.backController("resendAuthenticationEmail", mav);
		mav.addObject("authenicationEmailResent", true);
		mav.setViewName("member/index");
		return mav;
	}
	@GetMapping("/seller/home")
	public String sellerHome() {
		
//moveSellerProductListButton.href = '/seller/productList?proUsrselid=' + userInfo.usrId + '&currentPage=1&itemsPerPage=10';
		return "redirect:/seller/productList?proUsrselid=" + this.auth.getUserInfo().getUsrId() + "&currentPage=1&itemsPerPage=10";
	}
	@GetMapping("/sellerLogin")
	public String sellerLogin(@RequestParam(name = "message", required = false) String message, final Model model) {
		if (message != null && !message.isEmpty()) {
			if (message.equals("error")) {
				model.addAttribute("message", "IDまたはパスワードが間違いました");
			}
			if (message.equals("logout")) {
				model.addAttribute("message", "ログアウトしました");
			}
		}
		return "seller/login";
	}
	@GetMapping("/sellerSignUp")
	public String moveSellerSignUp() {
		return "seller/signUp";
	}
	@PostMapping("/sellerSignUp")
	public ModelAndView sellerSignUp(HttpServletRequest request, ModelAndView mav, @ModelAttribute UserBean signUpInfo, @RequestParam("usrImageFile") MultipartFile[] files) {
		mav.addObject("signUpInfo", signUpInfo);
		mav.addObject("files", files);
		mav.addObject("httpServletRequest", request);
		this.auth.backController("signUp", mav);
		return mav;
	}
	@GetMapping("/403")
	public String accessDenied(final Model model, Principal principal) {
		model.addAttribute("message", principal.getName() + "さん！ このページへのアクセスは許可されていません！ ");
		return "403";
	}
	
	@Autowired
	Service_BI service_BI;
	
	@GetMapping("/best")
	public String getBestproduct(ModelAndView mav) {
		service_BI.backController("getBestproductList", mav); // 메인 페이지 상품 가져오기
		return "member/best";
	}

}

