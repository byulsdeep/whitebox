package edu.global.whitebox.services;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonElement;

import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.security.WhiteBoxUserDetails;
import edu.global.whitebox.utilities.Encryption;

@Service
public class SocialAuthentication implements ServiceRules {

	private static final Logger logger = LogManager.getLogger(LineAuthentication.class);

	@Autowired
	private WhiteBoxAuthentication whiteBoxAuth;
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Gson gson;
	@Autowired
	private LineAuthentication lineAuth;
	@Autowired
	private GoogleAuthentication googleAuth;
	@Autowired
	private KakaoAuthentication kakaoAuth;
	@Autowired
	private Service_YEONG service_YEONG;

	@Override
	public void backController(String serviceCode, ModelAndView mav) {

		SocialLogin socialAuth = null;

		switch (serviceCode) {
		case "lineLogin":
			socialAuth = lineAuth;
			break;
		case "googleLogin":
			socialAuth = googleAuth;
			break;
		case "kakaoLogin":
			socialAuth = kakaoAuth;
			break;
		}
		this.Login(mav, socialAuth.execute(mav));

	}

	@Override
	public void backController(String serviceCode, Model model) {

	}

	public void Login(ModelAndView mav, JsonElement element) {
		UserBean userBean = null;

		try {
			boolean isId = this.sqlSession.selectOne("getMemberId",
					element.getAsJsonObject().get("id").getAsString());
			
			if (isId) { // 가입된 회원
				whiteBoxAuth.processLogin(new WhiteBoxUserDetails(whiteBoxAuth.decodeUserInfo(this.sqlSession.selectOne("getUserInfo", element.getAsJsonObject().get("id").getAsString()))));
				whiteBoxAuth.backController("setUserInfo", mav);
				service_YEONG.backController("getHomeProductList", mav); // 메인 페이지 상품 가져오기
				mav.setViewName("member/index");
			} else {
				userBean = new UserBean();
				System.out.println(element.getAsJsonObject().get("id").getAsString());
				System.out.println(element.getAsJsonObject().get("email").getAsString());
				System.out.println(element.getAsJsonObject().get("picture").getAsString());

				userBean.setUsrId(element.getAsJsonObject().get("id").getAsString());
				userBean.setUsrEmail(element.getAsJsonObject().get("email").getAsString());
				if (element.getAsJsonObject().get("picture").getAsString() != null) {
					userBean.setUsrImage(element.getAsJsonObject().get("picture").getAsString());
				} else {
					userBean.setUsrImage("https://picsum.photos/120");
				}

				mav.addObject("memberInfo", this.gson.toJson(userBean));
				mav.setViewName("member/signUp");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
