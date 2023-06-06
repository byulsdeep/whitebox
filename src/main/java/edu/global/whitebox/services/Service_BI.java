package edu.global.whitebox.services;

import java.io.File;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.beans.ViewHistoryBean;
import edu.global.whitebox.utilities.Encryption;

@Service
public class Service_BI implements ServiceRules {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Encryption enc;
	@Autowired
	private Gson gson;
	@Autowired
	private Gson gsonPretty;
	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;

	@Override
	public void backController(String serviceCode, ModelAndView mav) {
		// 동기용
		switch (serviceCode) {
		case "updateUserImg":
			this.updateUserImg(mav);
			break;
		case "userWishListByPage":
			this.userWishListByPage(mav);
			break;
		case "userWatchListByPage":
			this.userWatchListByPage(mav);
			break;
		case "userViewHistoryByPage":
			this.userViewHistoryByPage(mav);
			break;
		}
	}	
	
	@Override
	public void backController(String serviceCode, Model model) {
		// rest 용
		switch (serviceCode) {
		case "updateUserPassword":
			this.updateUserPassword(model);
			break;
		case "updateUserInfo":
			this.updateUserInfo(model);
			break;
		}
	}
	
	private void userViewHistoryByPage(ModelAndView mav) {

		ViewHistoryBean vhsb = (ViewHistoryBean) mav.getModel().get("vhsbObject");

		// (String) mav.getModel().get("usrId") Controller.java에서 mav.addObject("usrId", usrId)에 저장된 usrId를 꺼냄

		// DB 담음
		List<ViewHistoryBean> userViewHistoryByPage = this.sqlSession.selectList("userViewHistoryByPage", vhsb);
		// Mapper_BI.xml userWishListByPage가 요구하는 #{파라미터}를 입력
		int userViewHistoryCount = this.sqlSession.selectOne("userViewHistoryCount", vhsb);
		// Mapper_BI.xml userWishListByPage가 요구하는 #{파라미터}를 입력

		System.out.println(this.gsonPretty.toJson(userViewHistoryByPage));
		System.out.println(userViewHistoryCount);

		// mav에 담음
		mav.addObject("userViewHistoryByPage", this.gson.toJson(userViewHistoryByPage));
		mav.addObject("userViewHistoryCount", userViewHistoryCount);
	}
	
	private void userWatchListByPage(ModelAndView mav) {

		ViewHistoryBean vhsb = (ViewHistoryBean) mav.getModel().get("vhsbObject");

		// (String) mav.getModel().get("usrId") Controller.java에서 mav.addObject("usrId", usrId)에 저장된 usrId를 꺼냄

		// DB 담음
		List<ViewHistoryBean> userWatchListByPage = this.sqlSession.selectList("userWatchListByPage", vhsb);
		// Mapper_BI.xml userWishListByPage가 요구하는 #{파라미터}를 입력
		int userWatchListCount = this.sqlSession.selectOne("userWatchListCount", vhsb);
		// Mapper_BI.xml userWishListByPage가 요구하는 #{파라미터}를 입력

		System.out.println(this.gsonPretty.toJson(userWatchListByPage));
		System.out.println(userWatchListCount);

		// mav에 담음
		mav.addObject("userWatchListByPage", this.gson.toJson(userWatchListByPage));
		mav.addObject("userWatchListCount", userWatchListCount);
	}

	private void userWishListByPage(ModelAndView mav) {

		ViewHistoryBean vhsb = (ViewHistoryBean) mav.getModel().get("vhsbObject");

		// (String) mav.getModel().get("usrId") Controller.java에서 mav.addObject("usrId",
		// usrId)에 저장된 usrId를 꺼냄

		// DB 담음
		List<ViewHistoryBean> userWishListByPage = this.sqlSession.selectList("userWishListByPage", vhsb);
		// Mapper_BI.xml userWishListByPage가 요구하는 #{파라미터}를 입력
		int userWishListCount = this.sqlSession.selectOne("userWishListCount", vhsb);
		// Mapper_BI.xml userWishListByPage가 요구하는 #{파라미터}를 입력

		System.out.println(this.gsonPretty.toJson(userWishListByPage));
		System.out.println(userWishListCount);

		// mav에 담음
		mav.addObject("userWishListByPage", this.gson.toJson(userWishListByPage));
		mav.addObject("userWishListCount", userWishListCount);
	}

	@Transactional // revoke
	private void updateUserImg(ModelAndView mav) {
		try {
			MultipartFile file = (MultipartFile) mav.getModel().get("file");
			System.out.println(".....updateUserImg");
			System.out.println(file.getOriginalFilename());
			System.out.println(file.getSize());
			// 2. 기존 사진 삭제
			UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();

			String path = "C:\\whitebox_workspace\\whiteboxx\\src\\main\\webapp\\res\\img\\usrImg\\"
					+ userInfo.getUsrId();

			System.out.println("path: " + path);
			boolean isSuccess = FileSystemUtils.deleteRecursively(new File(path));
			System.out.println("delete success: " + isSuccess);
			// 3. 새로운 사진 저장
			if (!new File(path).exists())
				new File(path).mkdirs();
			try {
				file.transferTo(new File(path + "\\" + file.getOriginalFilename()));
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 1. db 업데이트
			String dbPath = "/res/img/usrImg/" + userInfo.getUsrId() + "/" + file.getOriginalFilename();

			userInfo.setUsrImage(dbPath);

			String message = "修正に失敗しました！あほやろ！";

			if (this.sqlSession.update("updateUserImg", userInfo) == 1) {
				message = "修正に成功しました！この天才！";
			}
			mav.addObject("newPath", dbPath);
			mav.addObject("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Transactional
	private void updateUserInfo(Model model) {
		try {
			UserBean userBean = (UserBean) model.getAttribute("userBean");

			System.out.println("updateUserInfoLastname : " + userBean.getUsrLastname());
			System.out.println("updateUserInfoFirstname : " + userBean.getUsrFirstname());
			System.out.println("updateUserInfoPhone : " + userBean.getUsrPhone());
			System.out.println("updateUserInfoEmail : " + userBean.getUsrEmail());
			System.out.println("updateUserInfoAddress : " + userBean.getUsrAddress());
			System.out.println("updateUserInfoPostal : " + userBean.getMemPostal());
			System.out.println("updateUserInfoGender : " + userBean.getMemGender());
			System.out.println("updateUserInfoBirthday : " + userBean.getMemBirthday());

			String encodedUsrPhone = this.enc.aesEncode(userBean.getUsrPhone(), userBean.getUsrId());
			String encodedUsrEmail = this.enc.aesEncode(userBean.getUsrEmail(), userBean.getUsrId());
			String encodedUsrAddress = this.enc.aesEncode(userBean.getUsrAddress(), userBean.getUsrId());
			String encodedMemPostal = this.enc.aesEncode(userBean.getMemPostal(), userBean.getUsrId());

			System.out.println("encodedUsrPhone: " + encodedUsrPhone);
			System.out.println("encodedUsrEmail: " + encodedUsrEmail);
			System.out.println("encodedUsrAddress: " + encodedUsrAddress);
			System.out.println("encodedMemPostal: " + encodedMemPostal);

			userBean.setUsrPhone(encodedUsrPhone);
			userBean.setUsrEmail(encodedUsrEmail);
			userBean.setUsrAddress(encodedUsrAddress);
			userBean.setMemPostal(encodedMemPostal);

			String message = "修正に失敗しました！あほやろ！";
			this.sqlSession.update("updateUsr", userBean);

			if (this.sqlSession.update("updateMem", userBean) == 1) {
				message = "修正に成功しました！この天才！";
			}

			model.addAttribute("message", message);
			// RestController.java에 return (String) model.getAttribute("message") 함.
			// userInfo.setUsrPassword(this.enc.encode(userInfo.getUsrPassword()));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void updateUserPassword(Model model) {
		UserBean userBean = (UserBean) model.getAttribute("userBean");

		System.out.println("updateUserPassword : " + userBean.getUsrPassword());

		String encodedPassword = this.enc.encode(userBean.getUsrPassword());
		System.out.println("encodedPassword: " + encodedPassword);
		userBean.setUsrPassword(encodedPassword);
		userBean.setUsrId(this.whiteBoxAuthentication.getUserInfo().getUsrId());

		String message = "修正に失敗しました！あほやろ！";

		if (this.sqlSession.update("updateUserPassword", userBean) == 1) {
			message = "修正に成功しました！この天才！";
		}

		model.addAttribute("message", message);
		// RestController.java에 return (String) model.getAttribute("message") 함.
//		userInfo.setUsrPassword(this.enc.encode(userInfo.getUsrPassword()));
	}

}
