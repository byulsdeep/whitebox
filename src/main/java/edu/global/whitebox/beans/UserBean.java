package edu.global.whitebox.beans;

import java.util.List;

import lombok.Data;

@Data
public class UserBean {

	private String usrId;
	private String usrPassword;
	private int usrEnabled;
	private String usrLastname;
	private String usrFirstname;
	private String usrPhone;
	private String usrEmail;
	private String usrAddress;
	private String usrImage;
	private String usrDate;
	private List<AuthorityBean> authorities; 
	
	private String memPostal;
	private String memGender;
	private String memBirthday;
	
	private String selShopname;
	private String selInfo;
	
	private String authority;
		// 1. AUT 테이블 insert 용
		// 참고: 
		// WhiteBoxAuthentication mav.addObject("isInserted", this.sqlSession.insert("insertRole", userBean));
		// Mapper_Auth.xml INSERT INTO AUT VALUES (#{usrId}, #{authority})
		// 2. 소셜로그인, 일반 로그인 구분용. 소셜로그인인 경우 이메일 인증을 진행하지 않는다.
	
	private boolean isDecoded;
	// 중복 보호화 방지용
	
	private String memIssocial;
	// 소셜 구분용 
}
