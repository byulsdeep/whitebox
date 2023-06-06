package edu.global.whitebox.beans;

import lombok.Data;

//ODT_ORDDATE      NOT NULL DATE          
//ODT_ORDMEMID     NOT NULL NVARCHAR2(33) 
//ODT_PROUSRSELID  NOT NULL NVARCHAR2(33) 
//ODT_PROCODE      NOT NULL NUMBER(4)     
//ODT_QTY                   NUMBER(2)     
//ODT_MEMRECIPIENT          NVARCHAR2(33) 
//ODT_GSTCODE               CHAR(2)      
@Data
public class OrderDetailBean extends ProductBean {

	private String odtOrddate;
	private String odtOrdmemid;
	private String odtProusrselid;
	private String odtProcode;
	private int odtQty;
	private String odtMemrecipient;
	
	private String oldOdtMemrecipient; // 구분용
	
	private String odtGstcode;
	
	// JOIN 위해 상품 객체 상속
//	private String proName; 
//	private int proPrice; 
//	private int proStock; 
//	private String proInfo;
//	private char proIsdeleted;
//	private List<ProductImageBean> productImage;
	
	// JOIN 위해 셀러 정보 추가
	private String selInfo;
	
	// JOIN 사용자 프로필 사진
	private String usrImage;
	private String usrLastname;
	private String usrFirstname;
	
	// JOIN 선물 상태
	private String gstName;
}
