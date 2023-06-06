package edu.global.whitebox.services;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.OrderDetailBean;
import edu.global.whitebox.beans.ProductBean;

@Service
public class Service_YEONG implements ServiceRules{

	private static final Logger logger = LogManager.getLogger(LineAuthentication.class);

	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Gson gson;

	@Override
	public void backController(String serviceCode, ModelAndView mav) {

		switch (serviceCode) {
		case "getHomeProductList":
			this.getHomeProductList(mav);
			break;
		case "getProductDetail":
			this.getProductDetail(mav);
			break;
		case "getOrderDetail":
			this.getOrderDetail(mav);
			break;
		}
	}

	@Override
	public void backController(String serviceCode, Model model) {
		
	}

	private void getHomeProductList(ModelAndView mav) {
		List<ProductBean> homeProductList = new ArrayList<ProductBean>();
		homeProductList = this.sqlSession.selectList("getHomeProductList");
		
		mav.addObject("homeProductList", this.gson.toJson(homeProductList));
		System.out.println("getHomeProductList :: " + homeProductList);
	}
	
	private void getProductDetail(ModelAndView mav) {
		ProductBean productBean = (ProductBean) mav.getModel().get("productBean");
		System.out.println("pro : " + productBean.toString());
		ProductBean product = this.sqlSession.selectOne("getProductDetail", productBean);
		logger.info("getProductDetail : " + product.toString());
		System.out.println("getProductDetail : " + product.toString());
		mav.addObject("productInfo", this.gson.toJson(product));
	}

	private void getOrderDetail(ModelAndView mav) {
		List<OrderDetailBean> orderDetailList = new ArrayList<OrderDetailBean>();
		OrderBean orderBean = (OrderBean) mav.getModel().get("orderBean");
		orderDetailList = this.sqlSession.selectList("getOrderDetail", orderBean);
		mav.addObject("orderDetailList", this.gson.toJson(orderDetailList));
		mav.addObject("orderData", orderBean);
	}

}
