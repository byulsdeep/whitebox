package edu.global.whitebox.beans;

import java.util.List;

import lombok.Data;

@Data
public class FilterBean {

	// index
	private String filterGender;
	private String filterStudent;
	private String filterType;
	private String filterMinPrice;
	private String filterMaxPrice;
	
	// orderList
	private String filterUsrmemid;
	private String filterStartDate;
	private String filterEndDate;
}