package com.mediolio.vo;

public class ProjectDetailVO {
	private int p_id, m_id, cate_id, p_viewnum, p_likenum, p_replynum, follow_or_not, like_or_not;
	private String m_studentID, m_name, m_introduce, m_interesting1, m_interesting2, sc_id, cate_name, p_title, p_date;
	
	
	public int getFollow_or_not() {
		return follow_or_not;
	}
	public void setFollow_or_not(int follow_or_not) {
		this.follow_or_not = follow_or_not;
	}
	public int getLike_or_not() {
		return like_or_not;
	}
	public void setLike_or_not(int like_or_not) {
		this.like_or_not = like_or_not;
	}

	public String getM_interesting1() {
		return m_interesting1;
	}
	public void setM_interesting1(String m_interesting1) {
		this.m_interesting1 = m_interesting1;
	}
	public String getM_interesting2() {
		return m_interesting2;
	}
	public void setM_interesting2(String m_interesting2) {
		this.m_interesting2 = m_interesting2;
	}
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public int getCate_id() {
		return cate_id;
	}
	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}
	public int getP_viewnum() {
		return p_viewnum;
	}
	public void setP_viewnum(int p_viewnum) {
		this.p_viewnum = p_viewnum;
	}
	public int getP_likenum() {
		return p_likenum;
	}
	public void setP_likenum(int p_likenum) {
		this.p_likenum = p_likenum;
	}
	public int getP_replynum() {
		return p_replynum;
	}
	public void setP_replynum(int p_replynum) {
		this.p_replynum = p_replynum;
	}
	public String getM_studentID() {
		return m_studentID;
	}
	public void setM_studentID(String m_studentID) {
		this.m_studentID = m_studentID;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_introduce() {
		return m_introduce;
	}
	public void setM_introduce(String m_introduce) {
		this.m_introduce = m_introduce;
	}
	public String getSc_id() {
		return sc_id;
	}
	public void setSc_id(String sc_id) {
		this.sc_id = sc_id;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	
	
}
