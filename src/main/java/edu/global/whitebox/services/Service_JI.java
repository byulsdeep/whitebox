package edu.global.whitebox.services;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.OrderDetailBean;
import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.utilities.Encryption;

@Service
public class Service_JI implements ServiceRules {
	
	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Gson gsonPretty;
	@Autowired
	private Gson gson;
	@Autowired
	private Encryption enc;
	
	@Override
	public void backController(String serviceCode, ModelAndView mav) {
		switch (serviceCode) {

		case "moveShop":
			this.moveShop(mav);
			break;
		case "moveSelOrderList":
			this.moveSelOrderList(mav);
			break;
		}
	}

	@Override
	public void backController(String serviceCode, Model model) {
		switch (serviceCode) {
		case "":
			break;
		case " ":
			break;
		}
		
	}

//판매자 정보 (판매자로고 이미지, 판매자 상점명, 상점 정보) 
	private void moveShop(ModelAndView mav) {
		UserBean sellerInfo = (UserBean) mav.getModel().get("sellerInfo");
		System.out.println(sellerInfo.toString());

		// 매장 정보
		sellerInfo = this.sqlSession.selectOne("getUserInfo", sellerInfo);
		System.out.println(this.gsonPretty.toJson(sellerInfo));
		mav.addObject("sellerInfo", this.gson.toJson(sellerInfo));
		
		// topThreeProducts 최고 매출 상품 3가지
		List<ProductBean> topThreeProducts =  this.sqlSession.selectList("selectTopThreeProducts", sellerInfo.getUsrId());
		System.out.println(this.gsonPretty.toJson(topThreeProducts));
		mav.addObject("topThreeProducts", this.gson.toJson(topThreeProducts));
		
		// 상품 정보
		List<ProductBean> productList = this.sqlSession.selectList("selectProductList", sellerInfo.getUsrId());
		System.out.println(this.gsonPretty.toJson(productList));
		mav.addObject("productList", this.gson.toJson(productList));
		
	}
	
	private void moveSelOrderList(ModelAndView mav) {

		//주문 정보
		List<OrderBean> orderList = this.sqlSession.selectList("getSellerOrders", this.whiteBoxAuthentication.getUserInfo().getUsrId());
		System.out.println(this.gsonPretty.toJson(orderList));
		mav.addObject("orderList", this.gson.toJson(orderList));
		
	}
	

}
