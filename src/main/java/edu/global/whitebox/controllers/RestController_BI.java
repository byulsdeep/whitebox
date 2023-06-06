package edu.global.whitebox.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.services.Service_BI;

@RestController
public class RestController_BI { // RestController는 비동기식이라 페이지 이동이 없어서 Model만 사용

	@Autowired
	private Service_BI service_BI;

	@RequestMapping(value = "/member/myPage/updateUserPassword", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String updateUserPassword(Model model, @ModelAttribute UserBean userBean) {
		// 동기식
		// (@ModelAttribute UserBean userBean) : Java 객체의 필드명과 html input 요소의 name 속성과
		// 매핑하면 된다. ex: UserBean.usrPassword -> <input name='usrPassword'>
		// mav.addObject : 모델(mav)에 Java 객체를 담아 백에서 꺼내 쓸 수 있다. ex: mav에 "userBean"이란
		// 이름으로 userBean을 담음
		// service_BI.backController에 mav를 "updateUserPassword"로 매핑 요청
		// Service_BI.java switch문에서 "updateUserPassword"를 찾아 mav 전달
		// 해당하는 backController 찾아서 userBean 값을 mav에서 갖고 옴(객체생성). || 나머지는 null값, pw는
		// accountSetting.jsp form(updateUserPassword)에서 입력한 값
		System.out.println("updateUserPassword");
		model.addAttribute("userBean", userBean);

		this.service_BI.backController("updateUserPassword", model);

		return (String) model.getAttribute("message"); // accountSetting.jsp의 function pwUpdateSuccess(data)에 값이 들어간다.

		// mav: el 로 접근 ${message}
		// ajax: 콜백함수 data 파라미터로 접근
	}

	@RequestMapping(value = "/member/myPage/updateUserInfo", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String updateUserInfo(Model model, @ModelAttribute UserBean userBean) {
		System.out.println("-----------------------------------------updateUserInfo");
		model.addAttribute("userBean", userBean);
		this.service_BI.backController("updateUserInfo", model);
		return (String) model.getAttribute("message"); // accountSetting.jsp의 function usrInfoUpdateSuccess(data)에 값이 들어간다.
	}
}
