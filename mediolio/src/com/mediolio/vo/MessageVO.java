package com.mediolio.vo;

public class MessageVO {
	private int msg_id, msg_from, msg_to;
	private String msg_text, msg_date, msg_to_status, msg_from_status;
	
	public String getMsg_to_status() {
		return msg_to_status;
	}
	public void setMsg_to_status(String msg_to_status) {
		this.msg_to_status = msg_to_status;
	}
	public String getMsg_from_status() {
		return msg_from_status;
	}
	public void setMsg_from_status(String msg_from_status) {
		this.msg_from_status = msg_from_status;
	}
	public int getMsg_id() {
		return msg_id;
	}
	public void setMsg_id(int msg_id) {
		this.msg_id = msg_id;
	}
	public int getMsg_from() {
		return msg_from;
	}
	public void setMsg_from(int msg_from) {
		this.msg_from = msg_from;
	}
	public int getMsg_to() {
		return msg_to;
	}
	public void setMsg_to(int msg_to) {
		this.msg_to = msg_to;
	}
	public String getMsg_text() {
		return msg_text;
	}
	public void setMsg_text(String msg_text) {
		this.msg_text = msg_text;
	}
	public String getMsg_date() {
		return msg_date;
	}
	public void setMsg_date(String msg_date) {
		this.msg_date = msg_date;
	}
	
	

}
