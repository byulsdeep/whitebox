package edu.global.whitebox.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.beans.ProductImageBean;
import edu.global.whitebox.beans.UserBean;
import net.coobird.thumbnailator.Thumbnailator;

@Service
public class Service_HH implements ServiceRules {

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Gson gson;
	@Autowired
	private Gson gsonPretty;
//	@Autowired
//	private ProductBean productBean;

	@Override
	public void backController(String serviceCode, ModelAndView mav) {
		switch (serviceCode) {
		case "regist":
			this.regist(mav);
			break;
		case "editStore":
			this.editStore(mav);
			break;
		case "updateSellerProfileImage":
			this.updateSellerProfileImage(mav);
			break;

		}

	}

	@Transactional
	public void uploadFile(ModelAndView mav, ProductBean productBean) {
		try {
			MultipartFile[] files = ((MultipartFile[]) mav.getModel().get("files"));
			System.out.println(files.length);
			System.out.println(files);
			String s = this.sqlSession.selectOne("selectProcode", productBean);
			System.out.println(s);

			productBean.setProCode(this.sqlSession.selectOne("selectProcode", productBean));
			this.sqlSession.insert("insertProduct", productBean);

			System.out.println(productBean.getProCode());

			String uploadPath = "C:\\whitebox_workspace\\whiteboxx\\src\\main\\webapp\\res\\img\\productImg\\"
					+ productBean.getProUsrselid() + "\\" + productBean.getProCode();
			uploadPath = uploadPath.replace("\\", "/");
			String uploadPathDB = "\\res\\img\\productImg\\" + productBean.getProUsrselid() + "\\"
					+ productBean.getProCode() + "\\original\\";
			uploadPathDB = uploadPathDB.replace("\\", "/");

			if (files.length != 0) {

				for (int i = 0; i < files.length; i++) {
					ProductImageBean productImage = new ProductImageBean();
					productImage.setPigProusrselid(productBean.getProUsrselid());
					productImage.setPigProcode(productBean.getProCode());
					productImage.setPigName(files[i].getOriginalFilename());

					productImage.setPigPath(uploadPath + "/original/" + files[i].getOriginalFilename());

					if (productImage.getPigName().equals(productBean.getProductThumbnail())) {
						productImage.setPigIsthumbnail("T");

					} else {
						productImage.setPigIsthumbnail("F");
					}

					if (!new File(uploadPath + "/original/").exists())
						new File(uploadPath + "/original/").mkdirs();
					try {
						files[i].transferTo(new File(productImage.getPigPath()));
					} catch (Exception e) {
						e.printStackTrace();
					}

					if (productImage.getPigIsthumbnail().equals("T")) {
						if (!new File(uploadPath + "/small/").exists()) {
							new File(uploadPath + "/small/").mkdirs();
						}

						FileOutputStream thumbnail = new FileOutputStream(
								new File(uploadPath + "/small/" + files[i].getOriginalFilename()));
						Thumbnailator.createThumbnail(files[i].getInputStream(), thumbnail, 360, 350);

					}

					productImage.setPigPath(uploadPathDB + files[i].getOriginalFilename());
					this.sqlSession.insert("insertProductImage", productImage);

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Transactional
	private void regist(ModelAndView mav) {
		try {
			ProductBean productBean = (ProductBean) mav.getModel().get("productBean");
			System.out.println(productBean);
			productBean.setProIsdeleted("F");
			this.uploadFile(mav, productBean);
			mav.addObject("message", "상품이 등록되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Transactional
	private void editStore(ModelAndView mav) {
		UserBean userBean = (UserBean) mav.getModel().get("userBean");
		System.out.println(userBean);

		if (this.sqlSession.update("updateEditStore", userBean) == 1) {
			this.sqlSession.update("updateEditStore2", userBean);
			String s = this.sqlSession.selectOne("selectUsrDate", userBean);
			System.out.println(s);

			userBean.setUsrDate(s);

			mav.addObject("newInfo", this.gson.toJson(userBean));

		} else {
			mav.addObject("falseInfo", "수정실패");
		}
	}

	@Transactional
	public void updateSellerProfileImage(ModelAndView mav) {
		UserBean userBean = (UserBean) mav.getModel().get("userBean");

		try {
			MultipartFile file = ((MultipartFile) mav.getModel().get("file"));
			System.out.println(file.getSize());
			System.out.println(file);

			String uploadPath = "C:\\whitebox_workspace\\whiteboxx\\src\\main\\webapp\\res\\img\\usrImg\\"
					+ userBean.getUsrId() + "\\";
			uploadPath = uploadPath.replace("\\", "/");
			String uploadPathDB = "\\res\\img\\usrImg\\" + userBean.getUsrId() + "\\";
			uploadPathDB = uploadPathDB.replace("\\", "/");

			if (!new File(uploadPath).exists()) {
				new File(uploadPath).mkdirs();
			}
			try {
				file.transferTo(new File(uploadPath + file.getOriginalFilename()));
			} catch (Exception e) {
				e.printStackTrace();
			}
			userBean.setUsrImage(uploadPathDB + file.getOriginalFilename());
			this.sqlSession.update("updateEditprofile", userBean);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void backController(String serviceCode, Model model) {
		// TODO Auto-generated method stub

	}

}