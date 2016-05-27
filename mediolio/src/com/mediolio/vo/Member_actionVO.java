package com.mediolio.vo;

/*
 *  DB I/O에 사용 - 데이터를 담는 객체 class
 * */

public class Member_actionVO {
	private int act_id, act_to, act_from, act_what;
	private String act_type, act_read, act_date;
	public int getAct_id() {
		return act_id;
	}
	public void setAct_id(int act_id) {
		this.act_id = act_id;
	}
	public int getAct_to() {
		return act_to;
	}
	public void setAct_to(int act_to) {
		this.act_to = act_to;
	}
	public int getAct_from() {
		return act_from;
	}
	public void setAct_from(int act_from) {
		this.act_from = act_from;
	}

	public int getAct_what() {
		return act_what;
	}
	public void setAct_what(int act_what) {
		this.act_what = act_what;
	}
	public String getAct_type() {
		return act_type;
	}
	public void setAct_type(String act_type) {
		this.act_type = act_type;
	}
	public String getAct_read() {
		return act_read;
	}
	public void setAct_read(String act_read) {
		this.act_read = act_read;
	}
	public String getAct_date() {
		return act_date;
	}
	public void setAct_date(String act_date) {
		this.act_date = act_date;
	}
	
}
