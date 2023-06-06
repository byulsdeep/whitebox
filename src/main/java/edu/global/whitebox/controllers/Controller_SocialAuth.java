package edu.global.whitebox.controllers;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.global.whitebox.services.SocialAuthentication;

@Controller
public class Controller_SocialAuth {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	SocialAuthentication socialAuth;

	private static final Logger logger = LogManager.getLogger(Controller_SocialAuth.class);

	@GetMapping("/oauth/line")
	public ModelAndView lineCallback(ModelAndView mav, @RequestParam("code") String authorizationCode) {
		logger.info(authorizationCode);
		mav.addObject("authorizationCode", authorizationCode);
		this.socialAuth.backController("lineLogin", mav);
        return mav;
	}
	
	@GetMapping("/oauth/google")
	public ModelAndView googleCallback(ModelAndView mav, @RequestParam("code") String authorizationCode) {
		logger.info(authorizationCode);
		mav.addObject("authorizationCode", authorizationCode);
		this.socialAuth.backController("googleLogin", mav);
        return mav;
	}
	
	@GetMapping("/oauth/kakao")
	public ModelAndView kakaoCallback(ModelAndView mav, @RequestParam("code") String authorizationCode) {
		logger.info(authorizationCode);
		mav.addObject("authorizationCode", authorizationCode);
		this.socialAuth.backController("kakaoLogin", mav);
        return mav;
	}
}
