package edu.global.whitebox.beans;

import java.util.List;

import lombok.Data;

@Data
public class ProductBean {
	
	private String proUsrselid; //판매자아이디
	private String proCode; //상품코드
	private String proCatcode; //카테고리
	private String catName;
	private String proName; //상품명
	private int proPrice; //가격
	private int proStock; //재고
	private String proInfo; //상품정보
	private String proIsdeleted;
	private List<ProductImageBean> productImage;
	private String productThumbnail;
	
	// pagination
	private int currentPage = 1; 
	private int itemsPerPage = 10;
	
	// search
	private String query;
	
	private String selShopname;
}

//	
//PRO_USRSELID NVARCHAR2(500),
//PRO_CODE NUMBER(4),
//PRO_CATCODE CHAR(2) NOT NULL,
//PRO_NAME NVARCHAR2(20) NOT NULL,
//PRO_PRICE NUMBER(7) DEFAULT -1,
//PRO_STOCK NUMBER(5) DEFAULT -1,
//PRO_INFO NVARCHAR2(2000) NOT NULL,
//PRO_ISDELETED CHAR(1) CHECK (PRO_ISDELETED IN ('T', 'F')),

//PRIMARY KEY (PRO_USRSELID, PRO_CODE),
//FOREIGN KEY (PRO_USRSELID) REFERENCES SELLER (SEL_USRID),
//FOREIGN KEY (PRO_CATCODE) REFERENCES CATEGORY (CAT_CODE) 