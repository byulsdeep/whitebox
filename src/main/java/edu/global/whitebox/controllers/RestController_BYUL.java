package edu.global.whitebox.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.global.whitebox.beans.FriendBean;
import edu.global.whitebox.beans.OrderBean;
import edu.global.whitebox.beans.OrderDetailBean;
import edu.global.whitebox.beans.ProductBean;
import edu.global.whitebox.services.Service_BYUL;
import edu.global.whitebox.services.WhiteBoxAuthentication;

@RestController
public class RestController_BYUL {
	
	@Autowired
	private Service_BYUL byul;
	@Autowired
	private WhiteBoxAuthentication whiteBoxAuthentication;
	
	@RequestMapping(value = "/member/myPage/confirmGiftAjax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public void confirmGiftAjax(Model model, @ModelAttribute OrderDetailBean giftInfo) {
		model.addAttribute("giftInfo", giftInfo);
		this.byul.backController("confirmGiftAjax", model);
	}	
	@RequestMapping(value = "/member/myPage/acceptRequestAjax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public List<FriendBean> acceptRequestAjax(Model model, @ModelAttribute FriendBean requestInfo) {
		model.addAttribute("requestInfo", requestInfo);
		this.byul.backController("acceptRequestAjax", model);
		this.whiteBoxAuthentication.backController("setUserInfo", model);
		return (List<FriendBean>) model.getAttribute("notificationInfo");
	}	
	@RequestMapping(value = "/member/myPage/declineRequestAjax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public List<FriendBean> declineRequestAjax(Model model, @ModelAttribute FriendBean requestInfo) {
		model.addAttribute("requestInfo", requestInfo);
		this.byul.backController("declineRequestAjax", model);
		this.whiteBoxAuthentication.backController("setUserInfo", model);

		return (List<FriendBean>) model.getAttribute("notificationInfo");
	}	
	@RequestMapping(value = "/member/myPage/confirmRequestAjax", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public List<FriendBean> confirmRequestAjax(Model model, @ModelAttribute FriendBean requestInfo) {
		model.addAttribute("requestInfo", requestInfo);
		this.byul.backController("confirmRequestAjax", model);
		this.whiteBoxAuthentication.backController("setUserInfo", model);

		return (List<FriendBean>) model.getAttribute("notificationInfo");
	}	
	
	@PostMapping("/member/myPage/deleteFriend")
	public boolean deleteFriend(Model model, @RequestParam("friendId") String friendId) {
		
		System.out.println("friendId: " + friendId);
		
		model.addAttribute("friendId", friendId);
		this.byul.backController("deleteFriend", model);
		
		return (boolean) model.getAttribute("message");
	}

    @PostMapping("/member/createPayPalOrder")
    public ResponseEntity<Object> createPayPalOrder(Model model, @RequestBody OrderBean cartInfo) {
    	
    	System.out.println(cartInfo);
    	model.addAttribute("cartInfo", cartInfo);
    	
    	this.byul.backController("createOrder", model);
    	
    	Object order = model.getAttribute("order");
        
        return ResponseEntity.ok(order);
    }
    @PostMapping("/member/capturePayPalOrder")
    public ResponseEntity<Object> capturePayPalOrder(Model model, @RequestBody Object requestBody) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(objectMapper.writeValueAsString(requestBody));
            String orderID = jsonNode.get("orderID").asText();

            model.addAttribute("orderID", orderID);
            this.byul.backController("capturePayment", model);
            Object captureData = model.getAttribute("captureData");

            return ResponseEntity.ok(captureData);
        } catch (Exception e) {
            // Handle the exception appropriately
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

	@RequestMapping(value = "/insertCart", method = RequestMethod.POST, produces = "application/json; charset=utf8")
																				// text/plain
																				// application/text
																				// application/json
	public String checkUsrIdDuplicate(Model model, @ModelAttribute OrderDetailBean orderDetailBean) {
		System.out.println(orderDetailBean.getOdtProusrselid());
		System.out.println(orderDetailBean.getOdtProcode());
	    // odtProusrselid=seller&odtProcode=3
		model.addAttribute("newItem", orderDetailBean);
		
		this.byul.backController("insertCart", model);
		
		return (String) model.getAttribute("message");
	}
	
	@PostMapping("/seller/updateProduct")
	private ProductBean updateProduct(Model model, @ModelAttribute ProductBean productBean) {
		
		System.out.println(productBean.toString());
		model.addAttribute(productBean);
		this.byul.backController("updateProduct", model);
		
		System.out.println(((ProductBean) model.getAttribute("updatedProduct")).toString());
		
		return (ProductBean) model.getAttribute("updatedProduct");
	}
	@PostMapping("/seller/deleteProduct")
	private ProductBean deleteProduct(Model model, @ModelAttribute ProductBean productBean) {
		
		System.out.println(productBean.toString());
		model.addAttribute(productBean);
		this.byul.backController("deleteProduct", model);
		
		System.out.println(((ProductBean) model.getAttribute("deletedProduct")).toString());
		
		return (ProductBean) model.getAttribute("deletedProduct");
	}
}