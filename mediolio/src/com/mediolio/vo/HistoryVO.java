package com.mediolio.vo;

public class HistoryVO {
	private int ht_id, cl_id, m_id, ht_public;
	private String ht_title, ht_introduce, ht_lastedit, ht_createdate,class_name;
	
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public int getHt_public() {
		return ht_public;
	}
	public void setHt_public(int ht_public) {
		this.ht_public = ht_public;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public int getHt_id() {
		return ht_id;
	}
	public void setHt_id(int ht_id) {
		this.ht_id = ht_id;
	}
	public int getCl_id() {
		return cl_id;
	}
	public void setCl_id(int cl_id) {
		this.cl_id = cl_id;
	}
	public String getHt_title() {
		return ht_title;
	}
	public void setHt_title(String ht_title) {
		this.ht_title = ht_title;
	}
	public String getHt_introduce() {
		return ht_introduce;
	}
	public void setHt_introduce(String ht_introduce) {
		this.ht_introduce = ht_introduce;
	}
	public String getHt_lastedit() {
		return ht_lastedit;
	}
	public void setHt_lastedit(String ht_lastedit) {
		this.ht_lastedit = ht_lastedit;
	}
	public String getHt_createdate() {
		return ht_createdate;
	}
	public void setHt_createdate(String ht_createdate) {
		this.ht_createdate = ht_createdate;
	}
	
	
}
