package edu.global.whitebox.controllers;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import edu.global.whitebox.beans.FilterBean;
import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.ProductBean;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestController_YEONG {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Gson gson;
	
	private static final Logger logger = LogManager.getLogger(Controller_Auth.class);

	@RequestMapping(value = "/recommends", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String recommendProduct(@RequestBody FilterBean filterBean) {
		List<ProductBean> recommendProductList = new ArrayList<ProductBean>();
		System.out.println(filterBean);
		recommendProductList = this.sqlSession.selectList("getHomeRecommendProductList", filterBean);
		
		return this.gson.toJson(recommendProductList);
	}
	
	@RequestMapping(value = "/mypage/orders", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String orderProduct(@RequestBody FilterBean filterBean) {
		List<OrderBean> orderList = new ArrayList<OrderBean>();
		System.out.println(filterBean);
		orderList = this.sqlSession.selectList("getOrderList", filterBean);
		
		return this.gson.toJson(orderList);
	}
}
