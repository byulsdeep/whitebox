package edu.global.whitebox.beans;

import lombok.Data;

@Data
public class PageInfoBean {
	private int currentPage;	// 現在ページ番号
	private int itemsPerPage;	// ページごとの項目数
	
	public PageInfoBean() {
		this.currentPage = 1;
		this.itemsPerPage = 10;
		// デフォルト値、frontからの資料がある場合は
		// Springの@ModelAttributeが
		// @Dataで自動生成されたSetter関数で値を更新する
	}
}