package edu.global.whitebox.services;

import java.io.File;
import java.net.URLEncoder;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import edu.global.whitebox.beans.AuthenticationLogBean;
import edu.global.whitebox.beans.AuthorityBean;
import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.security.WhiteBoxUserDetails;
import edu.global.whitebox.utilities.Encryption;

@Service
public class WhiteBoxAuthentication implements ServiceRules {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Encryption enc;
	@Autowired
	private Gson gson;
	@Autowired
	private Gson gsonPretty;
	@Autowired
	private JavaMailSenderImpl javaMailSender;
	@Autowired
	private AuthenticationManager authenticationManager;

	@Override
	public void backController(String serviceCode, ModelAndView mav) {
		switch (serviceCode) {
		case "signUp":
			this.signUp(mav);
			break;
		case "setUserInfo":
			this.setUserInfo(mav);
			break;
		case "authenticateEmail":
			this.authenticateEmail(mav);
			break;
		case "resendAuthenticationEmail":
			this.resendAuthenticationEmail(mav);
			break;
		}
	}
	@Override
	public void backController(String serviceCode, Model model) {
		switch (serviceCode) {
		case "checkUsrIdDuplicate":
			this.checkUsrIdDuplicate(model);
			break;
		case "setUserInfo":
			this.setUserInfo(model);
			break;
		}
	}
	// 아이디 중복 확인
	private void checkUsrIdDuplicate(Model model) {
		boolean isDuplicate = this.sqlSession.selectOne("checkUsrIdDuplicate", model.getAttribute("userBean"));
		model.addAttribute("isDuplicate", isDuplicate ? "true" : "false");
	}
	// 회원가입
	@Transactional
	private void signUp(ModelAndView mav) {
		UserBean signUpInfo = (UserBean) mav.getModel().get("signUpInfo");
		try {
			// 소셜 구분
			System.out.println("..signUp");
			System.out.println("memIssocial : " + signUpInfo.getMemIssocial());
			
			if (signUpInfo.getMemIssocial().equals("T")) {
				signUpInfo.setUsrPassword("Squirrel");
				signUpInfo.setAuthority("ROLE_MEMBER");
			} else {
				signUpInfo.setAuthority("ROLE_UNAUTHENTICATED"); // 이메일 인증 전 권한 'UNAUTHENTICATED' 추가. 이메일 인증 후
			}
			
			System.out.println("password : " + signUpInfo.getUsrPassword());
			// 암호화
			signUpInfo = this.encodeUserInfo(signUpInfo);

			if (signUpInfo.getMemIssocial().equals("F")) {
				// 사진 업로드
				signUpInfo.setUsrImage(this.uploadFile(mav, signUpInfo));
			}
			this.sqlSession.insert("insertUser", signUpInfo);
			// 구매자 / 판매자 구분
			if (signUpInfo.getMemBirthday() != null) {
				mav.setViewName("member/index");
				this.sqlSession.insert("insertMember", signUpInfo);
			} else {
				this.sqlSession.insert("insertSeller", signUpInfo);
				// 판매자는 이메일 인증 하지 말자...............
				mav.setViewName("seller/login");
				signUpInfo.setAuthority("ROLE_SELLER");
			}
			// ROLE INSERT
			this.sqlSession.insert("insertRole", signUpInfo);

			// 복호화
			signUpInfo = this.decodeUserInfo(signUpInfo);
			if (signUpInfo.getMemIssocial().equals("T")) {
				// 소셜인 경우 즉시 로그인
				System.out.println(this.gsonPretty.toJson(signUpInfo));
				this.processLogin(new WhiteBoxUserDetails(signUpInfo));
				this.setUserInfo(mav);
			}
			if (signUpInfo.getMemIssocial().equals("F") && signUpInfo.getMemBirthday() != null) {
				// 인증 이메일 전송
				this.sendAuthenticationEmail(signUpInfo);
			}
			UserBean welcomeInfo = new UserBean();
			welcomeInfo.setUsrLastname(signUpInfo.getUsrLastname());
			welcomeInfo.setUsrFirstname(signUpInfo.getUsrFirstname());
			welcomeInfo.setMemIssocial(signUpInfo.getMemIssocial());
			mav.addObject("welcomeInfo", this.gson.toJson(welcomeInfo));
		} catch (Exception e) {
			mav.addObject("error", 1);
			e.printStackTrace();
		}
	}
	// 파일 업로드
	public String uploadFile(ModelAndView mav, UserBean signUpInfo) {
		HttpServletRequest request = (HttpServletRequest) mav.getModel().get("httpServletRequest");
		MultipartFile file = ((MultipartFile[]) mav.getModel().get("files"))[0];

		if (file.getSize() == 0) {
			return "/res/img/whitebox_logo_p.png";
		}
//		String fullPath = request.getSession().getServletContext().getRealPath("/resources");
//		int index = fullPath.indexOf(".metadata");
//		String workspacePath = fullPath.substring(0, index);
//		String projectPath = "whitebox\\src\\main\\webapp\\resources\\img\\usrImg\\";
		String folder = signUpInfo.getUsrId();
//		String uploadPath = workspacePath + projectPath + folder;
		String uploadPath = "C:\\whitebox_workspace\\whiteboxx\\src\\main\\webapp\\res\\img\\usrImg" + "\\" + folder;
		System.out.println("uploadPath: " + uploadPath);
		String physicalPath = uploadPath + "\\" + file.getOriginalFilename();
		physicalPath = physicalPath.replace("\\", "/");
		System.out.println("physicalPath: " + physicalPath);
		String relativePath = "/res/img/usrImg/" + folder + "/" + file.getOriginalFilename();
		relativePath = relativePath.replace("\\", "/");
		System.out.println(relativePath);
		signUpInfo.setUsrImage(relativePath);

		System.out.println("usrImg: " + signUpInfo.getUsrImage());

		if (!new File(uploadPath).exists())
			new File(uploadPath).mkdirs();
		try {
			file.transferTo(new File(physicalPath));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return signUpInfo.getUsrImage();
	}
	// 소셜용 상남자식 로그인. 이미 인증 과정을 외부에서 거쳤기 때문에, 비밀번호는 우리가 저장하지 않기 때문에, 스프링 시큐리티를 속일 임의의
	// 비밀번호 Squirrel 부여
	public void processLogin(UserDetails userDetails) {
		Authentication authentication = this.authenticationManager
				.authenticate(new UsernamePasswordAuthenticationToken(userDetails, "Squirrel"));
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}
	// 이메일 전송
	@Transactional
	private void sendAuthenticationEmail(UserBean userInfo) {
		// 인증 로그 작성
		AuthenticationLogBean authenticationLogBean = new AuthenticationLogBean();
		authenticationLogBean.setAulUsrid(userInfo.getUsrId());
		authenticationLogBean.setAulAurcode("AS");
		/*
		 * AS 인증코드 발송 AN 인증 완료 (알림 용) AC 완료 확인 (알림 중단)
		 */
		this.sqlSession.insert("insertAuthenticationLog", authenticationLogBean);
		// 날짜 가져오기
		authenticationLogBean.setAulDate(this.sqlSession.selectOne("getAulDate", authenticationLogBean));
		String authenticationCode = null;
		System.out.println(userInfo.toString());

		try {
			// 복호화
			System.out.println(userInfo.toString());
			// 이메일 + 인증시간, 아이디를 키로 인증코드 작성
			authenticationCode = this.enc.aesEncode(
					authenticationLogBean.getAulUsrid() + ":" + authenticationLogBean.getAulDate(), "SquirrelGrip");
			System.out.println("authenticationCode : " + authenticationCode);
			authenticationCode = URLEncoder.encode(authenticationCode, "UTF-8");
			System.out.println("encoded : " + authenticationCode);
			System.out.println("full link : ");
			System.out.println("http://localhost/emailAuth?authenticationCode=" + authenticationCode);
		} catch (Exception e) {
			e.printStackTrace();
		}

		MimeMessage mimeMessage = this.javaMailSender.createMimeMessage();
		MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, "UTF-8");
		try {
			mimeMessageHelper.setFrom("whitebox-japan@outlook.com");
			mimeMessageHelper.setTo(userInfo.getUsrEmail());
			mimeMessageHelper.setSubject("[Whitebox] ホワイトボックスへようこそ - アカウントの認証をお願いします");
			mimeMessageHelper.setText(this.emailHTML(userInfo, authenticationCode), true);
			this.javaMailSender.send(mimeMessage);
		} catch (MessagingException e1) {
			e1.printStackTrace();
		}
	}
	// 이메일 양식 생성
	private String emailHTML(UserBean userInfo, String authenticationCode) {
		StringBuilder sb = new StringBuilder();
		sb.append("<!DOCTYPE html>\r\n" + "<html>\r\n" + "  <head>\r\n" + "    <meta charset='UTF-8'>\r\n"
				+ "    <title>[Whitebox] ホワイトボックスへようこそ - アカウントの認証をお願いします</title>\r\n" + "  </head>\r\n" + "  <body>\r\n"
				+ "    <h1>ホワイトボックスへようこそ - アカウントの認証をお願いします</h1>\r\n"
				+ "    <img style='display: block; margin: auto;' src='http://localhost/res/img/whitebox_logo_p.png' />\r\n"
				+ "    <p>" + userInfo.getUsrLastname() + userInfo.getUsrFirstname() + "様</p>\r\n"
				+ "    <p>ホワイトボックスをご利用いただきありがとうございます。あなたのアカウントの登録が完了しました。ご利用いただく前に、ご提供いただいたメールアドレスの確認が必要です。</p>\r\n"
				+ "    <p>アカウントを有効化し、当社のサービスをご利用いただくには、以下のリンクをクリックしてください。</p>\r\n"
				+ "    <p><a href='http://localhost/emailAuth?authenticationCode=" + authenticationCode + "'>["
				+ authenticationCode + "]</a></p>\r\n"
				+ "    <p>このリンクから、メールアドレスの確認とアカウントの設定が可能です。最良の体験を得るため、デスクトップまたはラップトップコンピューターを使用することをお勧めします。</p>\r\n"
				+ "    <p>ホワイトボックスに登録されていない場合、またはこのメールを認識できない場合は、無視してください。</p>\r\n"
				+ "    <p>ホワイトボックスを選んでいただきありがとうございます。あなたの目標の達成に向けてお手伝いできることを楽しみにしています。</p>\r\n" + "    <p>敬具</p>\r\n"
				+ "    <p>ホワイトボックス</p>\r\n" + "    <p>Whitebox</p>\r\n" + "  </body>\r\n" + "</html>");
		return sb.toString();
	}
	// 이메일 인증
	private void authenticateEmail(ModelAndView mav) {
		mav.setViewName("emailAuth");

		String authenticationCode = (String) mav.getModel().get("authenticationCode");
		System.out.println(authenticationCode);
//		authenticationCode = this.enc.aesEncode(authenticationLogBean.getAulUsrid() + ":" + authenticationLogBean.getAulDate(), "SquirrelGrip");
		String[] split = null;
		try {
			split = this.enc.aesDecode(authenticationCode, "SquirrelGrip").split(":");
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(split[0]);
		System.out.println(split[1]);
//		SELECT COUNT(*) FROM AUL WHERE AUL_AURCODE = 'AS' AND AUL_USRID = 'whitebox' AND AUL_DATE = TO_DATE('20230505042602', 'YYYYMMDDHH24MISS');

		AuthorityBean authorityBean = new AuthorityBean();
		authorityBean.setAutUsrid(split[0]);

		if ((boolean) this.sqlSession.selectOne("isAuthenticated", authorityBean)) {
			System.out.println("member or seller");
			mav.addObject("result", "?");
		} else {
			/*
			 * AS 인증코드 발송 AN 인증 완료 (알림 용) AC 완료 확인 (알림 중단)
			 */
			AuthenticationLogBean authenticationLogBean = new AuthenticationLogBean();
			authenticationLogBean.setAulUsrid(split[0]);
			authenticationLogBean.setAulDate(split[1]);
			if ((boolean) this.sqlSession.selectOne("authenticateEmail", authenticationLogBean)) {
				// 인증 로그 insert, 유효기간 설정, role 업데이트
				authenticationLogBean.setAulAurcode("AN");
				this.sqlSession.insert("insertAuthenticationLog", authenticationLogBean);
				authorityBean.setAutAuthority("ROLE_MEMBER");
				this.sqlSession.update("updateRole", authorityBean);

				// 로그아웃
				HttpServletRequest request = (HttpServletRequest) mav.getModel().get("httpServletRequest");
				HttpServletResponse response = (HttpServletResponse) mav.getModel().get("HttpServletResponse");
				new SecurityContextLogoutHandler().logout(request, response,
						SecurityContextHolder.getContext().getAuthentication());

				mav.addObject("result", true);
			} else {
				System.out.println("what went wrong");
				mav.addObject("result", false);
			}
		}
	}
	// 이메일 재전송
	private void resendAuthenticationEmail(ModelAndView mav) {
		this.sendAuthenticationEmail(this.getUserInfo());
	}
	// 암호화 모듈
	public UserBean encodeUserInfo(UserBean userInfo) {
		try {
			userInfo.setUsrPassword(this.enc.encode(userInfo.getUsrPassword()));
			userInfo.setUsrPhone(this.enc.aesEncode(userInfo.getUsrPhone(), userInfo.getUsrId()));
			userInfo.setUsrEmail(this.enc.aesEncode(userInfo.getUsrEmail(), userInfo.getUsrId()));
			userInfo.setUsrAddress(this.enc.aesEncode(userInfo.getUsrAddress(), userInfo.getUsrId()));
			if (userInfo.getMemBirthday() != null) {
				userInfo.setMemPostal(this.enc.aesEncode(userInfo.getMemPostal(), userInfo.getUsrId()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	// 복호화 모듈
	public UserBean decodeUserInfo(UserBean encodedInfo) {
		System.out.println("..decoding subject : \n" + this.gsonPretty.toJson(encodedInfo));
		System.out.println("..starting decoding process.. hopefully...works out...");

		if (encodedInfo.isDecoded()) {
			System.out.println("..object already decoded..cancelling process..");
			return encodedInfo;
		}
		try {
			encodedInfo.setUsrPhone(this.enc.aesDecode(encodedInfo.getUsrPhone(), encodedInfo.getUsrId()));
			System.out.println("..phone : " + encodedInfo.getUsrPhone());
			encodedInfo.setUsrEmail(this.enc.aesDecode(encodedInfo.getUsrEmail(), encodedInfo.getUsrId()));
			System.out.println("..email : " + encodedInfo.getUsrEmail());
			encodedInfo.setUsrAddress(this.enc.aesDecode(encodedInfo.getUsrAddress(), encodedInfo.getUsrId()));
			System.out.println("..address : " + encodedInfo.getUsrAddress());
			encodedInfo.setUsrDate(encodedInfo.getUsrDate() != null ? encodedInfo.getUsrDate().substring(0, 10) : null);
			System.out.println("..date : " + encodedInfo.getUsrDate());
			if (encodedInfo.getMemBirthday() != null) {
				System.out.println("..is a member");
				encodedInfo.setMemPostal(this.enc.aesDecode(encodedInfo.getMemPostal(), encodedInfo.getUsrId()));
				System.out.println("..postal : " + encodedInfo.getMemPostal());
				System.out.println(encodedInfo.getMemBirthday());
				encodedInfo.setMemBirthday(encodedInfo.getMemBirthday().substring(0, 10));
				System.out.println("..birthday : " + encodedInfo.getMemBirthday());
			} else {
				System.out.println("..is a seller");
			}

			System.out.println("..decoding success");
			encodedInfo.setDecoded(true);

		} catch (Exception e) {
			System.out.println("..decoding failure");

			e.printStackTrace();
		} finally {
			System.out.println("..decoding result : \n" + this.gsonPretty.toJson(encodedInfo));
		}
		return encodedInfo;
	}
	// 세션에서 유저 정보 가져오기
	public UserBean getUserInfo() {
		System.out.println("..getUserInfo()");
		UserBean userInfo = null;
		if (this.getAuthentication().getPrincipal() instanceof WhiteBoxUserDetails) {
			System.out.println("..logged in");
			userInfo = this
					.decodeUserInfo(((WhiteBoxUserDetails) this.getAuthentication().getPrincipal()).getUserInfo());
		}
		return userInfo;
	}
	// 가져온 정보 모델에 추가하기
	public void setUserInfo(Object object) {
		System.out.println("..setUserInfo()");
		UserBean userInfo = this.getUserInfo();
		if (userInfo == null) return;
		if (object instanceof ModelAndView) {
			((ModelAndView) object).addObject("userInfo", this.gson.toJson(userInfo));
			System.out.println("..setNotificationInfo");
			((ModelAndView) object).addObject("notificationInfo", this.gson.toJson(this.sqlSession.selectList("selectNotificationInfo", userInfo.getUsrId())));
			((ModelAndView) object).addObject("giftNotificationInfo", this.gson.toJson(this.sqlSession.selectList("selectReceivedGiftListGS", userInfo.getUsrId())));
		} else if (object instanceof Model) {
			((Model) object).addAttribute("userInfo", userInfo);
			System.out.println("..setNotificationInfo");
			((Model) object).addAttribute("notificationInfo", this.sqlSession.selectList("selectNotificationInfo", userInfo.getUsrId()));
			((Model) object).addAttribute("giftNotificationInfo", this.gson.toJson(this.sqlSession.selectList("selectReceivedGiftListGS", userInfo.getUsrId())));
		}
	}
	public Authentication getAuthentication() {
		return SecurityContextHolder.getContext().getAuthentication();
	}
	// 비회원 여부
	public boolean isAnonymous() {
		return this.getAuthentication().getName().equals("anonymousUser");
	}
	// 회원 여부
	public boolean isMember() {
		return this.getAuthentication().getAuthorities().stream()
				.anyMatch(auth -> auth.getAuthority().equals("ROLE_MEMBER"));
	}
	// 인증 여부
	public boolean isUnauthenticated() {
		return this.getAuthentication().getAuthorities().stream()
				.anyMatch(auth -> auth.getAuthority().equals("ROLE_UNAUTHENTICATED"));
	}
	// 판매자 여부
	public boolean isSeller() {
		return this.getAuthentication().getAuthorities().stream()
				.anyMatch(auth -> auth.getAuthority().equals("ROLE_SELLER"));
	}
}
