package edu.global.whitebox.beans;

import lombok.Data;

@Data
public class ProductImageBean {
//	PIG_PROSELID    NOT NULL NVARCHAR2(500) 
//	PIG_PROCODE     NOT NULL NUMBER(4)      
//	PIG_CODE        NOT NULL NUMBER(2)      
//	PIG_NAME                 NVARCHAR2(50)  
//	PIG_PATH                 NVARCHAR2(300) 
//	PIG_ISTHUMBNAIL          CHAR(1)    
	private String pigProusrselid;
	private String pigProcode;
	private String pigCode;
	private String pigName;
	private String pigPath;
	private String pigIsthumbnail;
	
}
