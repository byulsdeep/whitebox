package edu.global.whitebox.beans;

import lombok.Data;

@Data
public class ViewHistoryBean extends ProductBean {
//	VHS_USRMEMID    NOT NULL NVARCHAR2(33) 
//	VHS_PROUSRSELID NOT NULL NVARCHAR2(33) 
//	VHS_PROCODE     NOT NULL NUMBER(4)     
//	VHS_DATE                 DATE          
//	VHS_ISVIEWED             CHAR(1)       
//	VHS_ISWATCHED            CHAR(1)       
//	VHS_ISWISHED             CHAR(1)       

	private String vhsUsrmemid;
	private String vhsProusrselid;
	private String vhsProcode;
	private String vhsDate;
	private String vhsIsviewed;
	private String vhsIswatched;
	private String vhsIswished;
}