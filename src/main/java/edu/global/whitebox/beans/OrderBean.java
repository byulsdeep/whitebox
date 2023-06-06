package edu.global.whitebox.beans;

import java.util.List;

import lombok.Data;

//ORD_DATE     NOT NULL DATE          
//ORD_USRMEMID NOT NULL NVARCHAR2(33) 
//ORD_OSTSTATE          CHAR(2)       
//ORD_PAYCODE           CHAR(2)       
//이름               널?       유형            
//---------------- -------- ------------- 
@Data
public class OrderBean {
	
	private String ordDate;
	private String ordUsrmemid;
	private String ordOststate;
	private String ordPaycode;
	private List<OrderDetailBean> orderDetail;
	
	private String proUsrselid;
	private String proCode;
	private String proName;
	private String ordQty;
	private String proPrice;
	private String odtProusrselid;
	private String selShopname;
	
	private List<ProductImageBean> productImage;
}
