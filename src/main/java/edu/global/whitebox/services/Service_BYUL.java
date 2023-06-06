package edu.global.whitebox.services;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.Gson;

import edu.global.whitebox.beans.FriendBean;
import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.OrderDetailBean;
import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.beans.UserBean;
import edu.global.whitebox.beans.ViewHistoryBean;
import edu.global.whitebox.utilities.Encryption;

@Service
public class Service_BYUL implements ServiceRules{

	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private Gson gson;
	@Autowired
	private Gson gsonPretty;
	@Autowired
	private Encryption enc;
	
    private final RestTemplate restTemplate;

    private final String clientId;
    private final String appSecret;
    private final String baseURL;
    
	public Service_BYUL() {
        this.restTemplate = new RestTemplate();
        this.restTemplate.setMessageConverters(Collections.singletonList(new MappingJackson2HttpMessageConverter()));
        this.clientId = "YOUR_CLIENT_ID_HERE";
        this.appSecret = "YOUR_APP_SECRET_HERE";
        this.baseURL = "https://api-m.sandbox.paypal.com";
	}
	
	@Override
	public void backController(String serviceCode, ModelAndView mav) {
		switch (serviceCode) {
		case "selectProductByPage":
			this.selectProductByPage(mav);
			break;
		case "selectProductByPageAndQuery":
			this.selectProductByPageAndQuery(mav);
			break;
		case "moveCart":
			this.moveCart(mav);
			break;
		case "updateRecipient":
			this.updateRecipient(mav);
			break;
		case "updateQty":
			this.updateQty(mav);
			break;
		case "copyCart":
			this.copyCart(mav);
			break;
		case "emptyCart":
			this.emptyCart(mav);
			break;
		case "deleteCart":
			this.deleteCart(mav);
			break;
		case "order":
			this.order(mav);
			break;
		case "paypal":
			this.paypal(mav);
			break;
		case "selectFriendList":
			this.selectFriendList(mav);
			break;
		case "selectFriendWishList":
			this.selectFriendWishList(mav);
			break;
		case "selectFriendRequests":
			this.selectFriendRequests(mav);
			break;
		case "acceptRequest":
			this.acceptRequest(mav);
			break;
		case "declineRequest":
			this.declineRequest(mav);
			break;
		case "sendRequest":
			this.sendRequest(mav);
			break;
		case "selectGiftList":
			this.selectGiftList(mav);
			break;
		}
	}

	@Override
	public void backController(String serviceCode, Model model) {
		switch (serviceCode) {
		case "updateProduct":
			this.updateProduct(model);
			break;
		case "deleteProduct":
			this.deleteProduct(model);
			break;
		case "insertCart":
			this.insertCart(model);
			break;
		case "createOrder":
			this.createOrder(model);
			break;
		case "capturePayment":
			this.capturePayment(model);
			break;	
		case "deleteFriend":
			this.deleteFriend(model);
			break;	
		case "acceptRequestAjax":
			this.acceptRequestAjax(model);
			break;	
		case "declineRequestAjax":
			this.declineRequestAjax(model);
			break;	
		case "confirmRequestAjax":
			this.confirmRequestAjax(model);
			break;	
		case "confirmGiftAjax":
			this.confirmGiftAjax(model);
			break;	
		}
	}
	private void confirmGiftAjax(Model model) {
		OrderDetailBean giftInfo = (OrderDetailBean) model.getAttribute("giftInfo");
		giftInfo.setOdtOrddate(LocalDateTime.parse(giftInfo.getOdtOrddate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
		this.sqlSession.update("updateGStoGA", giftInfo);
	}
	@Transactional
	private void selectGiftList(ModelAndView mav) {
		try {
			String usrId = this.whiteBoxAuthentication.getUserInfo().getUsrId();
			
			List<OrderDetailBean> receivedGiftList = this.sqlSession.selectList("selectReceivedGiftList", usrId);
			
			int index = 0;
			for (OrderDetailBean receivedGift : receivedGiftList) {
				if (receivedGift.getOdtGstcode().equals("GS")) {
					receivedGift.setOdtOrddate(LocalDateTime.parse(receivedGift.getOdtOrddate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
					this.sqlSession.update("updateGStoGA", receivedGift);
					System.out.println("updated " + index++);					
				}
			}
			receivedGiftList = this.sqlSession.selectList("selectReceivedGiftList", usrId);
			
			System.out.println(this.gsonPretty.toJson(receivedGiftList));
			mav.addObject("receivedGiftList", this.gson.toJson(receivedGiftList));
			
			List<OrderDetailBean> sentGiftList = this.sqlSession.selectList("selectSentGiftList", usrId);
			System.out.println(this.gsonPretty.toJson(sentGiftList));
			mav.addObject("sentGiftList", this.gson.toJson(sentGiftList));
			
			List<OrderDetailBean> selfGiftList = this.sqlSession.selectList("selectSelfGiftList", usrId);
			System.out.println(this.gsonPretty.toJson(selfGiftList));
			mav.addObject("selfGiftList", this.gson.toJson(selfGiftList));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private void acceptRequestAjax(Model model) {
		FriendBean requestInfo = (FriendBean) model.getAttribute("requestInfo");
		this.sqlSession.update("acceptRequest", requestInfo);
	}
	private void declineRequestAjax(Model model) {
		FriendBean requestInfo = (FriendBean) model.getAttribute("requestInfo");
		this.sqlSession.delete("declineRequest", requestInfo);
	}
	private void confirmRequestAjax(Model model) {
		FriendBean requestInfo = (FriendBean) model.getAttribute("requestInfo");
		this.sqlSession.update("confirmRequest", requestInfo);
	}
	private void acceptRequest(ModelAndView mav) {
		FriendBean requestInfo = (FriendBean) mav.getModel().get("requestInfo");
		if (this.sqlSession.update("acceptRequest", requestInfo) == 1) {
			mav.addObject("acceptMessage", this.gson.toJson(requestInfo));
		}
	}
	private void declineRequest(ModelAndView mav) {
		FriendBean requestInfo = (FriendBean) mav.getModel().get("requestInfo");
		if (this.sqlSession.delete("declineRequest", requestInfo) == 1) {
			mav.addObject("declineMessage", "拒否しました！");
		}
	}
	private void sendRequest(ModelAndView mav) {
		FriendBean requestInfo = (FriendBean) mav.getModel().get("requestInfo");
		if (this.sqlSession.insert("sendRequest", requestInfo) == 1) {
			mav.addObject("requestMessage", this.gson.toJson(requestInfo));
		}
	}
	private void deleteFriend(Model model) {
		boolean message = false;
		if (this.sqlSession.delete("deleteFriend", model.getAttribute("friendId")) == 1) {
			message = true;
		}
		model.addAttribute("message", message);
	}
	private void selectFriendList(ModelAndView mav) {
		this.setFriendList(mav, false);
	}
	private void selectFriendWishList(ModelAndView mav) {
		
		UserBean friendInfo = this.sqlSession.selectOne("selectLightUserInfo", (String) mav.getModel().get("friendId"));
		
		System.out.println(this.gsonPretty.toJson(friendInfo));
		mav.addObject("friendInfo", this.gson.toJson(friendInfo));
		
		List<ViewHistoryBean> friendWishList = this.sqlSession.selectList("selectWishList", friendInfo.getUsrId());
		
		System.out.println(this.gsonPretty.toJson(friendWishList));
		mav.addObject("friendWishList", this.gson.toJson(friendWishList));
	}
	private void selectFriendRequests(ModelAndView mav) {
		
		UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();
		
		FriendBean queryInfo = (FriendBean) mav.getModel().get("queryInfo");
		queryInfo.setMyId(userInfo.getUsrId());
		
		List<FriendBean> friendRequests = null;
		if (queryInfo.getQuery() != null) {
			friendRequests = this.sqlSession.selectList("selectFriendRequestsAndQueryResult", queryInfo);
		} else {
			friendRequests = this.sqlSession.selectList("selectFriendRequests", userInfo.getUsrId());
		}
		System.out.println(this.gsonPretty.toJson(friendRequests));
		mav.addObject("friendRequests", this.gson.toJson(friendRequests));
	}
    private void createOrder(Model model) { // OrderBean cartInfo
        try {
        	
        	OrderBean cartInfo = (OrderBean) model.getAttribute("cartInfo");
        	
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(generatePayPalAccessToken());

            Map<String, Object> requestPayload = new HashMap<>();
            requestPayload.put("intent", "CAPTURE");

            Map<String, Object> purchaseUnit = new HashMap<>();
            Map<String, Object> amount = new HashMap<>();
            amount.put("currency_code", "JPY");
            
            int value = 0;
            System.out.println("calculating sum: ");
            for (OrderDetailBean orderDetail : cartInfo.getOrderDetail()) {
            	System.out.println("product: " + orderDetail.getProName());
            	System.out.println("qty: " + orderDetail.getOdtQty());
            	System.out.println("price: " + orderDetail.getProPrice());
            	value += orderDetail.getOdtQty() * orderDetail.getProPrice();
            	System.out.println("subTotal: " + orderDetail.getOdtQty() * orderDetail.getProPrice());
            	System.out.println("accumulatedTotal: " + value);
            	System.out.println("--------------------------");
            }
            System.out.println("total: " + value);
            amount.put("value", String.valueOf(value));
            purchaseUnit.put("amount", amount);

            requestPayload.put("purchase_units", Collections.singletonList(purchaseUnit));

            HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestPayload, headers);
            ResponseEntity<Object> responseEntity = restTemplate.exchange(
                    baseURL + "/v2/checkout/orders",
                    HttpMethod.POST,
                    requestEntity,
                    Object.class
            );

            if (responseEntity.getStatusCode() == HttpStatus.CREATED) {
            	
            	model.addAttribute("order", responseEntity.getBody());
            }
        } catch (HttpClientErrorException ex) {
            // Handle exception
        }
    }
    private String generatePayPalAccessToken() {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            headers.setBasicAuth(clientId, appSecret);

            UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(baseURL + "/v1/oauth2/token")
                    .queryParam("grant_type", "client_credentials");

            HttpEntity<String> requestEntity = new HttpEntity<>(headers);
            ResponseEntity<Object> responseEntity = restTemplate.exchange(
                    builder.toUriString(),
                    HttpMethod.POST,
                    requestEntity,
                    Object.class
            );

            if (responseEntity.getStatusCode() == HttpStatus.OK) {
                Map<String, Object> response = (Map<String, Object>) responseEntity.getBody();
                return response.get("access_token").toString();
            }
        } catch (HttpClientErrorException ex) {
            // Handle exception
        }

        return null;
    }
    
    @Transactional
    private void capturePayment(Model model) { // String orderId
        try {
        	
        	String orderID = (String) model.getAttribute("orderID");
        	
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(generatePayPalAccessToken());

            HttpEntity<String> requestEntity = new HttpEntity<>(headers);
            ResponseEntity<Object> responseEntity = restTemplate.exchange(
                    baseURL + "/v2/checkout/orders/" + orderID + "/capture",
                    HttpMethod.POST,
                    requestEntity,
                    Object.class
            );

            if (responseEntity.getStatusCode() == HttpStatus.CREATED) {
            	            	
            	OrderBean cartInfo = this.getCartInfo();
            	cartInfo.setOrdPaycode("PP");
            	this.sqlSession.update("completeOrder", cartInfo);
            	
            	for (OrderDetailBean orderDetail : cartInfo.getOrderDetail()) {
            		this.sqlSession.update("updateStock", orderDetail);
            	}
        
            	model.addAttribute("captureData", responseEntity.getBody());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private OrderBean getCartInfo() {
    	UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();	
		OrderBean cart = this.sqlSession.selectOne("selectCartPage", userInfo.getUsrId());
		if (cart == null) return null;
		
		System.out.println(this.gsonPretty.toJson(cart));
		return cart;
    }
    private void setCartInfo(Object object) {
    	if (object instanceof ModelAndView) {
    		((ModelAndView) object).addObject("cartInfo", this.gson.toJson(this.getCartInfo()));
    	} else if (object instanceof Model) {
    		((Model) object).addAttribute("cartInfo", this.gson.toJson(this.getCartInfo()));
    	}
    }
    private List<FriendBean> getFriendList() {
		UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();	
		
		List<FriendBean> friendList = this.sqlSession.selectList("selectFriendList", userInfo.getUsrId());

    	return friendList;
    }
    
	private void setFriendList(ModelAndView mav, boolean includeSelf) {
		UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();	
		
		List<FriendBean> friendList = this.getFriendList();
		
		if (includeSelf) {
			FriendBean self = new FriendBean();
			
			self.setFriendId(userInfo.getUsrId());
			self.setUsrLastname(userInfo.getUsrLastname());
			self.setUsrFirstname(userInfo.getUsrFirstname());
			self.setUsrImage(userInfo.getUsrImage());
			
			friendList.add(self);
		}
		
		System.out.println(this.gsonPretty.toJson(friendList));
		mav.addObject("friendList", this.gson.toJson(friendList));
	}
	
	private void order(ModelAndView mav) {
		this.setCartInfo(mav);
	}
	private void paypal(ModelAndView mav) {
		this.setCartInfo(mav);
	}
	
	@Transactional
	private void deleteCart(ModelAndView mav) {
		try {
			OrderDetailBean cartToDelete = (OrderDetailBean) mav.getModel().get("cartToDelete");
			
			cartToDelete.setOdtOrddate(LocalDateTime.parse(cartToDelete.getOdtOrddate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
			this.sqlSession.delete("emptyCartItem", cartToDelete);
			
			OrderBean cart = this.sqlSession.selectOne("selectCartPage", cartToDelete.getOdtOrdmemid());
			
			if (cart.getOrderDetail().size() < 1) {
				this.sqlSession.delete("emptyCart", this.whiteBoxAuthentication.getUserInfo().getUsrId());
			} else {
				System.out.println(this.gsonPretty.toJson(cart));
				mav.addObject("cartInfo", this.gson.toJson(cart));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@Transactional
	private void emptyCart(ModelAndView mav) {
		this.sqlSession.delete("emptyCartItems", this.whiteBoxAuthentication.getUserInfo().getUsrId());
		this.sqlSession.delete("emptyCart", this.whiteBoxAuthentication.getUserInfo().getUsrId());
	}
	@Transactional
	private void copyCart(ModelAndView mav) {
		try {
			OrderDetailBean cartToCopy = (OrderDetailBean) mav.getModel().get("cartToCopy");
			System.out.println(cartToCopy);
			cartToCopy.setOdtOrddate(LocalDateTime.parse(cartToCopy.getOdtOrddate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
			
			UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();	
			
			this.sqlSession.update("updateCartDate", userInfo.getUsrId());
			OrderBean cart = this.sqlSession.selectOne("selectCart", userInfo.getUsrId());
			cartToCopy.setOdtMemrecipient(userInfo.getUsrId());
			cartToCopy.setOdtOrddate(cart.getOrdDate());
		    this.sqlSession.insert("insertOrderDetail", cartToCopy);
		    
		    this.setCartInfo(mav);
			
			this.setFriendList(mav, true);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private void updateQty(ModelAndView mav) {
		OrderDetailBean updatedOrderDetail = (OrderDetailBean) mav.getModel().get("updatedOrderDetail");
		System.out.println(updatedOrderDetail);
		  
        OrderBean cartInfo = this.getCartInfo();  
        updatedOrderDetail.setOdtOrddate(cartInfo.getOrdDate());
       
        this.sqlSession.update("updateOrderDetailQty", updatedOrderDetail);
		
        this.setCartInfo(mav);
		
		this.setFriendList(mav, true);
	}
	private void updateRecipient(ModelAndView mav) {
		OrderDetailBean updatedOrderDetail = (OrderDetailBean) mav.getModel().get("updatedOrderDetail");
		System.out.println(updatedOrderDetail);
		
		OrderBean cartInfo = this.getCartInfo();  
        updatedOrderDetail.setOdtOrddate(cartInfo.getOrdDate());
        updatedOrderDetail.setOdtGstcode("GS");
        
        this.sqlSession.update("updateOrderDetailRecipient", updatedOrderDetail);
        
        this.setCartInfo(mav);
		
		this.setFriendList(mav, true);
	}
	private void moveCart(ModelAndView mav) {
		
		this.setCartInfo(mav);
		
		this.setFriendList(mav, true);
	}
	@Transactional
	private void insertCart(Model model) {
		try {
			String message = "시스템 오류";
			model.addAttribute("message", message);
			
			UserBean userInfo = this.whiteBoxAuthentication.getUserInfo();
			OrderBean cart = new OrderBean();
			cart.setOrdUsrmemid(userInfo.getUsrId());
			
			cart = this.sqlSession.selectOne("selectCart", cart);

			if (cart == null) {
				System.out.println("장바구니 없음. 새 장바구니 생성");
				// 기존 장바구니가 없는 경우 새 장바구니 생성
				// INSERT INTO ORD VALUES (DEFAULT, #{ordUsrMemid}, DEFAULT, DEFAULT);
				cart = new OrderBean();
				cart.setOrdUsrmemid(userInfo.getUsrId());
				this.sqlSession.insert("insertOrder", cart);
			} else {			
				// 기존 장바구니가 있는 경우
				System.out.println("장바구니 발견");
				// 장바구니 날짜 업데이트
				this.sqlSession.update("updateCartDate", cart);
			}
			// 갱신된 장바구니 날짜 다시 불러오기
			cart = this.sqlSession.selectOne("selectCart", cart);			
			
			// 프론트에서 받아온 새로운 장바구니에 담을 상품
			OrderDetailBean newItem = (OrderDetailBean) model.getAttribute("newItem");
			
			// INSERT INTO ODT VALUES (#{odtOrddate}, #{odtOrdmemid}, #{odtProusrselid}, #{odtProcode}, #{odtQty}, #{odtMemrecipient}, DEFAULT);
			
			newItem.setOdtOrddate(cart.getOrdDate());
			newItem.setOdtOrdmemid(userInfo.getUsrId());
			newItem.setOdtMemrecipient(userInfo.getUsrId());
			newItem.setOdtGstcode("GC"); // 장바구니의 담기 기본값이 내게 보내기이므로 선물 상태는 수락완료로
			
			// 카트에 기존 같은 상품 있는지 확인

			if (cart.getOrderDetail().isEmpty()) {
			    System.out.println("같은 상품 없음");
			    newItem.setOdtQty(1);
			    this.sqlSession.insert("insertOrderDetail", newItem);
			} else {
			    boolean sameProductFound = false;
			    
			    for (OrderDetailBean item : cart.getOrderDetail()) {
			        if (item.getOdtProusrselid().equals(newItem.getOdtProusrselid()) &&
			            item.getOdtProcode().equals(newItem.getOdtProcode())) {
			            System.out.println("같은 상품 발견");
			            newItem.setOdtQty(item.getOdtQty() + 1);
			            this.sqlSession.update("updateOrderDetailQty", newItem);
			            sameProductFound = true;
			            break;
			        }
			    }
			    
			    if (!sameProductFound) {
			        System.out.println("같은 상품 없음");
			        newItem.setOdtQty(1);
			        this.sqlSession.insert("insertOrderDetail", newItem);
			    }
			}

			System.out.println("insert/update 완료");
			message = "かーとに商品を入れました。";
			model.addAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	@Transactional
	private void updateProduct(Model model) {
		ProductBean productBean = (ProductBean) model.getAttribute("productBean");
		productBean.setProUsrselid(this.whiteBoxAuthentication.getUserInfo().getUsrId());
		
		if (this.sqlSession.update("updateProduct", productBean) == 1) {
			productBean = this.sqlSession.selectOne("selectProduct", productBean);
			System.out.println(productBean.toString());
			model.addAttribute("updatedProduct", productBean);			
		} else {
			model.addAttribute("updatedProduct", "FAIL");
		}
	}	
	@Transactional
	private void deleteProduct(Model model) {
		try {
			ProductBean productBean = (ProductBean) model.getAttribute("productBean");
			productBean.setProUsrselid(this.whiteBoxAuthentication.getUserInfo().getUsrId());
			
			this.sqlSession.update("deleteProduct", productBean);
			this.sqlSession.delete("deleteProductImage", productBean);
			String path = "C:\\whitebox_workspace\\whiteboxx\\src\\main\\webapp\\res\\img\\productImg\\" + 
			productBean.getProUsrselid() + "\\" + productBean.getProCode();
			System.out.println("deleting directory :" + path);
	        System.out.println(FileSystemUtils.deleteRecursively(new File(path)) ? "Directory deleted successfully." : "Failed to delete directory.");
			model.addAttribute("deletedProduct", productBean);			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private void selectProductByPageAndQuery(ModelAndView mav) {
		ProductBean productBean = (ProductBean) mav.getModel().get("productBean");
		int productCount = this.sqlSession.selectOne("selectQueriedProductCount", productBean);
		List<ProductBean> productByPageAndQuery = this.sqlSession.selectList("selectProductByPageAndQuery", productBean);

		productByPageAndQuery.forEach(product -> product.setQuery(productBean.getQuery()));
		
		System.out.println(this.gsonPretty.toJson(productByPageAndQuery));
		mav.addObject("productCount", productCount);
		System.out.println("productCount : " + productCount);
		mav.addObject("productListByPage", this.gson.toJson(productByPageAndQuery));
	}
	
	private void selectProductByPage(ModelAndView mav) {
		ProductBean productBean = (ProductBean) mav.getModel().get("productBean");
		int productCount = this.sqlSession.selectOne("selectProductCount", productBean);
		List<ProductBean> productListByPage = this.sqlSession.selectList("selectProductByPage", productBean);
		
		productListByPage.forEach(product -> product.setQuery(productBean.getQuery()));
		
		System.out.println(this.gsonPretty.toJson(productListByPage));
		mav.addObject("productCount", productCount);
		mav.addObject("productListByPage", this.gson.toJson(productListByPage));
	}
}
