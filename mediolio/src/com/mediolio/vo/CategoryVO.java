package com.mediolio.vo;

/*
 *  DB I/O에 사용 - 데이터를 담는 객체 class
 * */

public class CategoryVO {
	private int cate_id;
	private String cate_name;
	
	public CategoryVO(){}
	
	public CategoryVO(int cate_id, String cate_name) {
		this.cate_id = cate_id;
		this.cate_name = cate_name;
	}
	
	public int getCate_id() {
		return cate_id;
	}
	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}

	
	
}
